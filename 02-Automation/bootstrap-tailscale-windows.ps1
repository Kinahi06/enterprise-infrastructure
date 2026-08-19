#requires -Version 5.1

<#
.SYNOPSIS
Installs, configures or validates Tailscale on Windows.

.DESCRIPTION
Run without parameters for an interactive setup wizard, or provide parameters
for repeatable automation. Passwords and raw authentication keys are never
requested by this script.

.EXAMPLE
.\bootstrap-tailscale-windows.ps1

.EXAMPLE
.\bootstrap-tailscale-windows.ps1 -Hostname nova-ws02 -VerifyPeer linux01-server -VerifyPort 445 -Unattended

.EXAMPLE
.\bootstrap-tailscale-windows.ps1 -VerifyPeer linux01-server -VerifyPort 445 -CheckOnly
#>

[CmdletBinding()]
param(
    [string]$Hostname,

    [string]$VerifyPeer,

    [ValidateRange(0, 65535)]
    [int]$VerifyPort = 0,

    [string]$AuthKeyFile,

    [switch]$Unattended,

    [switch]$CheckOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$InstallerUrl = 'https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe'
$LogDirectory = Join-Path $env:ProgramData 'EnterpriseLab\Logs'
$LogFile = Join-Path $LogDirectory 'tailscale-bootstrap.log'
$TranscriptStarted = $false

function Test-Administrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-ValidDnsLabel {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return $false
    }

    return ($Value.Length -le 63 -and
        $Value -match '^[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?$')
}

function Test-ValidPeer {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return $false
    }

    $candidate = $Value.Trim().TrimEnd('.')
    [System.Net.IPAddress]$parsedAddress = $null
    if ([System.Net.IPAddress]::TryParse($candidate, [ref]$parsedAddress)) {
        return $true
    }

    if ($candidate.Length -gt 253) {
        return $false
    }

    foreach ($label in $candidate.Split('.')) {
        if (-not (Test-ValidDnsLabel -Value $label.ToLowerInvariant())) {
            return $false
        }
    }

    return $true
}

function Read-YesNo {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Prompt,

        [bool]$Default = $false
    )

    $suffix = if ($Default) { '[Y/n]' } else { '[y/N]' }
    while ($true) {
        $answer = (Read-Host "$Prompt $suffix").Trim().ToLowerInvariant()
        if ([string]::IsNullOrWhiteSpace($answer)) {
            return $Default
        }

        switch ($answer) {
            'y' { return $true }
            'yes' { return $true }
            'n' { return $false }
            'no' { return $false }
            default { Write-Warning 'Enter y or n.' }
        }
    }
}

function Read-ValidHostname {
    while ($true) {
        $value = (Read-Host 'Tailscale device name (example: nova-ws02)').Trim().ToLowerInvariant()
        if (Test-ValidDnsLabel -Value $value) {
            return $value
        }
        Write-Warning 'Use 1-63 lowercase letters, digits or internal hyphens.'
    }
}

function Read-OptionalPeer {
    while ($true) {
        $value = (Read-Host 'Peer to verify (MagicDNS name/IP, blank to skip)').Trim()
        if ([string]::IsNullOrWhiteSpace($value)) {
            return $null
        }
        if (Test-ValidPeer -Value $value) {
            return $value.TrimEnd('.')
        }
        Write-Warning 'Enter a valid IP address or DNS/MagicDNS name.'
    }
}

function Read-OptionalPort {
    while ($true) {
        $value = (Read-Host 'TCP port to verify (1-65535, blank to skip)').Trim()
        if ([string]::IsNullOrWhiteSpace($value)) {
            return 0
        }

        [int]$parsed = 0
        if ([int]::TryParse($value, [ref]$parsed) -and
            $parsed -ge 1 -and $parsed -le 65535) {
            return $parsed
        }
        Write-Warning 'Enter a whole number from 1 to 65535, or leave blank.'
    }
}

function Resolve-ProtectedAuthKeyFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Auth-key file was not found: $Path"
    }

    $resolvedPath = (Resolve-Path -LiteralPath $Path).Path
    $broadReadSids = @(
        'S-1-1-0',       # Everyone
        'S-1-5-11',      # Authenticated Users
        'S-1-5-32-545'   # BUILTIN\Users
    )

    $acl = Get-Acl -LiteralPath $resolvedPath
    foreach ($rule in $acl.Access) {
        if ($rule.AccessControlType -ne
            [System.Security.AccessControl.AccessControlType]::Allow) {
            continue
        }

        try {
            $sid = $rule.IdentityReference.Translate(
                [System.Security.Principal.SecurityIdentifier]
            ).Value
        }
        catch {
            continue
        }

        if ($sid -in $broadReadSids) {
            throw 'Auth-key file ACL grants access to a broad Windows group. Restrict it to the current administrator and SYSTEM.'
        }
    }

    return $resolvedPath
}

function Get-TailscaleExecutable {
    $command = Get-Command 'tailscale.exe' -ErrorAction SilentlyContinue
    if ($command) {
        return $command.Source
    }

    $defaultPath = Join-Path $env:ProgramFiles 'Tailscale\tailscale.exe'
    if (Test-Path -LiteralPath $defaultPath) {
        return $defaultPath
    }

    return $null
}

function Invoke-Tailscale {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$ArgumentList
    )

    & $script:TailscalePath @ArgumentList
    if ($LASTEXITCODE -ne 0) {
        throw "tailscale $($ArgumentList -join ' ') failed with exit code $LASTEXITCODE"
    }
}

function Test-TailscaleConnected {
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'
    try {
        $address = & $script:TailscalePath ip -4 2>$null
        return ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace(($address -join '')))
    }
    finally {
        $ErrorActionPreference = $previousPreference
    }
}

function Test-CurrentState {
    Invoke-Tailscale -ArgumentList @('version')
    Write-Host "Tailscale IPv4: $((& $script:TailscalePath ip -4) -join ', ')"
    if ($LASTEXITCODE -ne 0) {
        throw 'The node is not authenticated to a tailnet.'
    }

    Invoke-Tailscale -ArgumentList @('status')

    if ($VerifyPeer) {
        Invoke-Tailscale -ArgumentList @('ping', '--c', '3', '--until-direct=false', $VerifyPeer)
    }

    if ($VerifyPeer -and $VerifyPort -gt 0) {
        $test = Test-NetConnection -ComputerName $VerifyPeer -Port $VerifyPort `
            -InformationLevel Detailed
        $test
        if (-not $test.TcpTestSucceeded) {
            throw "TCP $VerifyPort on $VerifyPeer is unreachable."
        }
    }
}

if (-not $CheckOnly -and -not (Test-Administrator)) {
    throw 'Run PowerShell as Administrator.'
}

$UnattendedChoiceMade = $PSBoundParameters.ContainsKey('Unattended')
$InteractiveMode = -not $CheckOnly -and [string]::IsNullOrWhiteSpace($Hostname)

if ($AuthKeyFile) {
    $AuthKeyFile = Resolve-ProtectedAuthKeyFile -Path $AuthKeyFile
}

if ($InteractiveMode) {
    if ([Console]::IsInputRedirected) {
        throw 'Hostname is required when input is not interactive.'
    }

    Write-Host ''
    Write-Host 'Enterprise Lab - Tailscale Windows setup wizard'
    Write-Host 'Passwords and authentication tokens are never requested or stored by this script.'
    Write-Host 'Tailscale authentication happens in the official browser window.'
    Write-Host ''

    $Hostname = Read-ValidHostname
    if ($VerifyPeer -and -not (Test-ValidPeer -Value $VerifyPeer)) {
        Write-Warning 'The supplied VerifyPeer is invalid; enter it again.'
        $VerifyPeer = $null
    }
    if (-not $VerifyPeer) {
        $VerifyPeer = Read-OptionalPeer
    }
    if ($VerifyPeer -and $VerifyPort -eq 0) {
        $VerifyPort = Read-OptionalPort
    }
    if (-not $Unattended) {
        $Unattended = Read-YesNo `
            -Prompt 'Keep Tailscale running when no Windows user is signed in?' `
            -Default $true
    }
    $UnattendedChoiceMade = $true

    Write-Host ''
    Write-Host 'Planned configuration:'
    Write-Host "  Device name: $Hostname"
    Write-Host "  Verify peer: $(if ($VerifyPeer) { $VerifyPeer } else { 'not requested' })"
    Write-Host "  Verify port: $(if ($VerifyPort -gt 0) { $VerifyPort } else { 'not requested' })"
    Write-Host "  Unattended:  $(if ($Unattended) { 'enabled' } else { 'disabled' })"
    Write-Host "  Login:       $(if ($AuthKeyFile) { 'protected auth-key file' } else { 'interactive browser' })"
    Write-Host ''

    if (-not (Read-YesNo -Prompt 'Continue?' -Default $false)) {
        Write-Host 'Cancelled by user; no changes made.'
        exit 0
    }
}
elseif (-not $CheckOnly) {
    $Hostname = $Hostname.Trim().ToLowerInvariant()
    if (-not (Test-ValidDnsLabel -Value $Hostname)) {
        throw 'Hostname must be a valid 1-63 character DNS label.'
    }
}

if ($VerifyPeer -and -not (Test-ValidPeer -Value $VerifyPeer)) {
    throw 'VerifyPeer must be a valid IP address or DNS/MagicDNS name.'
}

if ($VerifyPort -gt 0 -and -not $VerifyPeer) {
    throw 'VerifyPort requires VerifyPeer.'
}

try {
    if (Test-Administrator) {
        New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null
        Start-Transcript -Path $LogFile -Append | Out-Null
        $TranscriptStarted = $true
    }

    if ($CheckOnly) {
        Write-Host 'Starting Tailscale state check.'
    }
    else {
        Write-Host "Starting Tailscale bootstrap for $Hostname"
    }
    $script:TailscalePath = Get-TailscaleExecutable

    if (-not $script:TailscalePath -and $CheckOnly) {
        throw 'Tailscale is not installed.'
    }

    if (-not $script:TailscalePath) {
        $installerPath = Join-Path $env:TEMP 'tailscale-setup-latest.exe'
        $checksumPath = "$installerPath.sha256"

        Write-Host 'Downloading the official Tailscale installer and checksum.'
        Invoke-WebRequest -Uri $InstallerUrl -OutFile $installerPath -UseBasicParsing
        Invoke-WebRequest -Uri "$InstallerUrl.sha256" -OutFile $checksumPath -UseBasicParsing

        $expectedHash = ((Get-Content -LiteralPath $checksumPath -Raw).Trim() -split '\s+')[0]
        $actualHash = (Get-FileHash -LiteralPath $installerPath -Algorithm SHA256).Hash
        if ($actualHash -ine $expectedHash) {
            throw 'Installer SHA256 does not match the checksum published by Tailscale.'
        }

        Write-Host 'Checksum verified. Complete the official installer window.'
        $process = Start-Process -FilePath $installerPath -Wait -PassThru
        if ($process.ExitCode -ne 0) {
            throw "Tailscale installer exited with code $($process.ExitCode)."
        }

        $script:TailscalePath = Get-TailscaleExecutable
        if (-not $script:TailscalePath) {
            throw 'Tailscale was installed but tailscale.exe was not found.'
        }
    }

    if ($CheckOnly) {
        Test-CurrentState
        Write-Host 'Check completed without changes.'
        return
    }

    if (Test-TailscaleConnected) {
        Write-Host 'Node is already authenticated; updating its MagicDNS hostname.'
        Invoke-Tailscale -ArgumentList @('set', "--hostname=$Hostname")

        if ($UnattendedChoiceMade) {
            $unattendedValue = ([bool]$Unattended).ToString().ToLowerInvariant()
            Invoke-Tailscale -ArgumentList @('up', "--hostname=$Hostname", "--unattended=$unattendedValue")
        }
    }
    else {
        $upArguments = @("--hostname=$Hostname")
        if ($UnattendedChoiceMade) {
            $unattendedValue = ([bool]$Unattended).ToString().ToLowerInvariant()
            $upArguments += "--unattended=$unattendedValue"
        }

        if ($AuthKeyFile) {
            $upArguments += "--auth-key=file:$AuthKeyFile"
            Write-Host 'Authenticating with the supplied auth-key file.'
        }
        else {
            Write-Host 'Complete the browser authentication requested by Tailscale.'
        }

        $suspendTranscript = -not $AuthKeyFile -and $TranscriptStarted
        if ($suspendTranscript) {
            Write-Host 'Browser authentication output will be shown only on screen and not written to the log.'
            Stop-Transcript | Out-Null
            $TranscriptStarted = $false
        }

        try {
            Invoke-Tailscale -ArgumentList (@('up') + $upArguments)
        }
        finally {
            if ($suspendTranscript) {
                try {
                    Start-Transcript -Path $LogFile -Append | Out-Null
                    $TranscriptStarted = $true
                }
                catch {
                    Write-Warning "Could not resume the deployment transcript: $($_.Exception.Message)"
                }
            }
        }
    }

    Test-CurrentState
    Write-Host 'Bootstrap completed successfully.'
}
finally {
    if ($TranscriptStarted) {
        Stop-Transcript | Out-Null
    }
}
