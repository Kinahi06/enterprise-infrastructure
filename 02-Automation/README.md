# Tailscale Bootstrap Automation

This directory turns the manual overlay-network laboratory into a repeatable,
auditable deployment workflow for Ubuntu, macOS and Windows.

The scripts are intentionally conservative:

- interactive browser authentication is the default;
- credentials are never embedded in source code or command examples;
- installers come from the official Tailscale package service;
- Windows and macOS installers are checked against the published SHA256 value;
- rerunning a script reuses the current installation and connection;
- `--check-only` / `-CheckOnly` validates without changing configuration;
- the UFW helper adds exact rules and never deletes rules or enables UFW.
- first-login URLs are shown only on screen and excluded from deployment logs.

## Architecture

There are two separate stages because a new machine cannot download private
configuration from a tailnet server before it has joined that tailnet.

```text
public GitHub repository
        |
        | download and inspect the platform bootstrap
        v
new client ---- browser authentication ----> Tailscale tailnet
        |
        | exact client address and required service
        v
Ubuntu server UFW authorization on tailscale0
```

GitHub is the stage-one distribution point. Private shares can distribute
additional configuration only after the client has joined the tailnet.

## Files

| File | Run on | Purpose |
|------|--------|---------|
| `bootstrap-tailscale-linux.sh` | Ubuntu client or server | Install Tailscale, join the tailnet and verify state |
| `bootstrap-tailscale-macos.sh` | macOS client | Install the standalone package, join and test a service |
| `bootstrap-tailscale-windows.ps1` | Windows client | Install the official package, join and test a service |
| `authorize-tailscale-client.sh` | Ubuntu service server | Add exact SSH and/or SMB UFW rules on `tailscale0` |

## Interactive Wizard Mode

This is the normal learning and one-machine deployment mode. Start a script
without its required naming parameters and answer the questions.

Ubuntu:

```bash
sudo ./bootstrap-tailscale-linux.sh
```

macOS:

```bash
./bootstrap-tailscale-macos.sh
```

Windows, from PowerShell as Administrator:

```powershell
.\bootstrap-tailscale-windows.ps1
```

UFW authorization, on the Ubuntu service server:

```bash
sudo ./authorize-tailscale-client.sh
```

Depending on the platform and task, the wizard asks for:

- the new Tailscale/MagicDNS device name;
- an optional peer and TCP port for the acceptance test;
- whether Windows should run Tailscale without a signed-in desktop user;
- the client address and whether it needs SSH, SMB or both;
- final confirmation before a change.

The device name changes only the Tailscale/MagicDNS identity. It does not rename
the Windows computer itself.

The wizard never asks for or stores a password, passphrase or raw auth key.
Administrator passwords are handled by the operating system, normal Tailscale
login happens in the official browser, and SMB credentials remain a separate
authenticated service step. An optional auth-key *file path* can be supplied as
an explicit automation parameter; the key value is never typed into the wizard.

Pressing Enter at the final `[y/N]` confirmation safely cancels the operation.

## Parameter Mode

Parameters are retained for repeatability, remote execution and future
configuration-management tools. In this mode missing required values cause an
error instead of being guessed.

## Safe Operating Procedure

For every new machine:

1. Create a VM snapshot or confirm another recovery path.
2. Download the appropriate script from the public repository.
3. Read the script before running it.
4. Run it with browser authentication.
5. Record the assigned device name and Tailscale IPv4 address.
6. On the service server, authorize only the ports that device needs.
7. Open a second connection and perform an application-level test.
8. Run the bootstrap again in check-only mode.
9. Record the result in the engineering journal.

This is automation with verification, not `curl | sudo bash`.

## Download From Any Network

After these files are published on GitHub, a Linux or macOS machine with normal
internet access can download one script without cloning the entire repository:

```bash
curl -fL -o bootstrap-tailscale-linux.sh \
  https://raw.githubusercontent.com/Kinahi06/enterprise-infrastructure/main/02-Automation/bootstrap-tailscale-linux.sh
less bootstrap-tailscale-linux.sh
chmod 700 bootstrap-tailscale-linux.sh
```

Windows PowerShell equivalent:

```powershell
$Uri = 'https://raw.githubusercontent.com/Kinahi06/enterprise-infrastructure/main/02-Automation/bootstrap-tailscale-windows.ps1'
Invoke-WebRequest -Uri $Uri -OutFile '.\bootstrap-tailscale-windows.ps1'
Get-Content '.\bootstrap-tailscale-windows.ps1'
```

Reading the downloaded file is a deliberate approval step. Executing a changing
internet response directly through a pipe would make the deployment shorter but
less auditable.

## Ubuntu Bootstrap

Local repository example:

```bash
sudo bash ./bootstrap-tailscale-linux.sh \
  --hostname linux02-server \
  --verify-peer macbook-admin
```

Validation-only run:

```bash
sudo bash ./bootstrap-tailscale-linux.sh \
  --hostname linux02-server \
  --verify-peer macbook-admin \
  --check-only
```

The first version supports Ubuntu and uses the detected Ubuntu codename to add
Tailscale's official stable APT repository. Logs are appended to:

```text
/var/log/enterprise-lab/tailscale-bootstrap.log
```

## macOS Bootstrap

```bash
bash ./bootstrap-tailscale-macos.sh \
  --hostname macbook-admin \
  --verify-peer linux01-server \
  --verify-port 445
```

macOS must ask the signed-in user to approve the system extension and VPN
configuration. A normal script should not bypass that security boundary.

Validation-only run:

```bash
bash ./bootstrap-tailscale-macos.sh \
  --hostname macbook-admin \
  --verify-peer linux01-server \
  --verify-port 445 \
  --check-only
```

Logs are appended under `~/Library/Logs/EnterpriseLab`.

## Windows Bootstrap

Open PowerShell as Administrator, inspect the script, then run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\bootstrap-tailscale-windows.ps1 `
    -Hostname nova-ws02 `
    -VerifyPeer linux01-server `
    -VerifyPort 445 `
    -Unattended
```

`-Unattended` makes Tailscale keep running when no user is signed in. Browser
authentication is still used unless `-AuthKeyFile` is explicitly supplied.

Validation-only run:

```powershell
.\bootstrap-tailscale-windows.ps1 `
    -Hostname nova-ws02 `
    -VerifyPeer linux01-server `
    -VerifyPort 445 `
    -CheckOnly
```

Logs are appended to `%ProgramData%\EnterpriseLab\Logs` when the process is
elevated.

## Authorize a Client on the Ubuntu Server

First obtain the client's address on that client:

```bash
tailscale ip -4
```

Preview whether the desired rule already exists:

```bash
sudo bash ./authorize-tailscale-client.sh \
  --client-ip 100.x.y.z \
  --client-name nova-ws02 \
  --service smb \
  --check-only
```

Apply an SMB-only rule:

```bash
sudo bash ./authorize-tailscale-client.sh \
  --client-ip 100.x.y.z \
  --client-name nova-ws02 \
  --service smb
```

Apply SSH and SMB for an administrator workstation:

```bash
sudo bash ./authorize-tailscale-client.sh \
  --client-ip 100.x.y.z \
  --client-name admin-workstation \
  --service ssh \
  --service smb
```

The helper accepts only IPv4 addresses inside Tailscale's `100.64.0.0/10`
range, requires active UFW and restricts rules to interface `tailscale0`.

## Optional Auth-Key Files

Browser login is preferable while learning because every authentication event
is visible. For later unattended provisioning, create a short-lived, scoped and
preferably one-time Tailscale auth key. Store it outside the repository.

Linux or macOS example:

```bash
install -m 600 /dev/null ./tailscale-auth.key
nano ./tailscale-auth.key
sudo bash ./bootstrap-tailscale-linux.sh \
  --hostname linux02-server \
  --auth-key-file ./tailscale-auth.key
```

Delete the local key file after enrollment and revoke an unused key from the
Tailscale admin console. Never place a key directly on a command line because
shell history and process inspection can expose it.

## Acceptance Criteria

A deployment is complete only when all applicable checks pass:

- `tailscale status` shows the intended node and peers;
- `tailscale ip -4` returns an address;
- `tailscale ping` reaches the selected peer;
- the required TCP port passes (`22` or `445`);
- the application itself works (SSH login or authenticated SMB read/write);
- UFW contains only the intended client/service rules;
- a check-only rerun reports success;
- no token, password or private key is present in Git history.

DERP relay output is not automatically a failure. Traffic remains encrypted,
but a direct path normally provides lower latency. Record relay use as a
network-performance observation and troubleshoot NAT traversal separately.

### Recorded Lab Result — 2026-08-19

The acceptance workflow passed on the current laboratory nodes:

| Platform | Node | Result |
|---|---|---|
| macOS | `macbook-admin` | Check-only mode passed and reached Ubuntu TCP 445 |
| Ubuntu | `linux01-server` | Bootstrap check-only and exact UFW-rule checks passed |
| Windows | `nova-ws01` | Parser, check-only, safe cancellation and confirmed wizard run passed |

The Windows run returned `TcpTestSucceeded : True` for
`linux01-server:445` and finished with `Bootstrap completed successfully.`
These results validate an already-enrolled environment. A separate fresh-VM
test is still required to validate first-time installation and browser
enrollment from an unconfigured machine.

## Rollback

The bootstrap scripts do not remove Tailscale. To disable a node temporarily:

```bash
sudo tailscale down
```

On Windows, use `tailscale down` from elevated PowerShell. Remove a machine from
the Tailscale admin console only after confirming that no one depends on it.

UFW rules are deliberately not deleted by the helper. Inspect numbered rules,
keep a console or second SSH session available, and delete only the exact rule
chosen by the administrator:

```bash
sudo ufw status numbered
sudo ufw delete NUMBER
```

## Primary References

- [Install Tailscale on Linux](https://tailscale.com/docs/install/linux)
- [Install Tailscale on Windows](https://tailscale.com/docs/install/windows)
- [Install Tailscale on macOS](https://tailscale.com/docs/install/mac)
- [Tailscale CLI reference](https://tailscale.com/docs/reference/tailscale-cli)
- [Secure auth keys](https://tailscale.com/docs/features/access-control/auth-keys/how-to/secure-auth-keys)
- [DERP routing troubleshooting](https://tailscale.com/docs/reference/troubleshooting/network-configuration/derp-routing)
