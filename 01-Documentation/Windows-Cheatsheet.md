# Windows Administration Runbook

Long-form operational reference for the Infrastructure Engineering Lab.
Portfolio readers can return to the [documentation index](./README.md); this
file is intended for command lookup during hands-on work.

Use commands to answer a specific question. Do not run the entire list blindly.

---

# Command Safety

| Mark | Meaning |
|------|---------|
| READ | Reads system state |
| CHANGE | Changes software or configuration |
| DISRUPTIVE | Can interrupt a service, user or computer |

Before a change, identify the expected result and decide how the result will be verified.

---

# Post-Installation Checklist

These checks create a baseline before the computer or server receives its role.

## 1. Identify the Windows Version

```text
winver
```

Safety: READ

Shows Windows edition, version and OS build.

## 2. Collect System Information

```powershell
Get-ComputerInfo
```

Safety: READ

Shows operating-system, firmware and hardware information.

Graphical alternative:

```text
msinfo32
```

## 3. Check Hardware and Drivers

```text
devmgmt.msc
```

Safety: READ

Opens Device Manager.

Check:

- Yellow warning symbols
- Unknown devices
- Expected network and storage adapters

## 4. Check Storage

```text
diskmgmt.msc
```

Safety: READ

Opens Disk Management and shows disks, partitions, filesystems and drive letters.

PowerShell alternatives:

```powershell
Get-Disk
Get-Partition
Get-Volume
```

## 5. Check Network Configuration

```powershell
Get-NetIPConfiguration
```

Safety: READ

Shows adapters, IP addresses, gateways and DNS servers.

Classic alternative:

```text
ipconfig /all
```

## 6. Test Connectivity and DNS

```text
ping 8.8.8.8
ping example.com
nslookup example.com
```

Safety: READ

Interpretation:

- IP works but hostname fails — investigate DNS
- Both fail — investigate interface, IP, gateway, routing or firewall
- Name resolves but an application fails — investigate the application and destination port

## 7. Check Services

```powershell
Get-Service
```

Safety: READ

Shows service names, display names and current states.

Show only running services:

```powershell
Get-Service | Where-Object Status -eq Running
```

## 8. Check Event Logs

```text
eventvwr.msc
```

Safety: READ

Begin with:

- Windows Logs → System
- Windows Logs → Application
- Windows Logs → Security when authorized

Do not treat every warning as an incident. Correlate events with the failure time and affected component.

## 9. Check Firewall State

```powershell
Get-NetFirewallProfile
```

Safety: READ

Shows Domain, Private and Public firewall profiles.

Do not disable Windows Firewall as a generic troubleshooting step.

## 10. Check Microsoft Defender

```powershell
Get-MpComputerStatus
```

Safety: READ

Shows antivirus, real-time protection and signature status.

## 11. Check Windows Update

```text
Settings → Windows Update
```

Inspect the related service:

```powershell
Get-Service wuauserv
```

Safety: READ

The Windows Update service can use triggered startup. A stopped state does not automatically mean that updates are broken.

## 12. Document the Baseline

Record:

- Computer name and assigned role
- Windows edition and build
- Architecture and firmware type
- CPU and RAM allocation
- Disk layout
- IP address, gateway and DNS servers
- Driver problems
- Firewall and Defender state
- Pending updates

---

# Processes and Performance

## List Processes

```powershell
Get-Process
```

Safety: READ

Shows active processes and resource information.

## Task Manager

```text
taskmgr
```

Safety: READ

Provides a quick overview of processes, performance and startup applications.

## Resource Monitor

```text
resmon
```

Safety: READ

Provides detailed CPU, memory, disk and network activity.

Always confirm that the measurements belong to the intended process.

---

# Services

## Open the Services Console

```text
services.msc
```

Safety: READ

## Check One Service

```powershell
Get-Service SERVICE_NAME
```

Safety: READ

## Read Detailed Service Configuration

```powershell
Get-CimInstance Win32_Service -Filter "Name='SERVICE_NAME'"
```

Safety: READ

Shows executable path, startup mode, service account, process ID and current state.

Before changing a service:

- Identify its purpose
- Check dependencies
- Check its service account
- Check recovery configuration
- Understand user and application impact

---

# Networking

## Display the ARP Cache

```text
arp -a
```

Safety: READ

Shows recently resolved IPv4-to-MAC address mappings.

## Test a TCP Port

```powershell
Test-NetConnection SERVER_NAME -Port PORT_NUMBER
```

Safety: READ

Tests DNS resolution, routing and TCP connectivity to a specific service port.

This provides better application-level evidence than `ping` alone.

---

# SMB File Shares

## Test the SMB Port

```powershell
Test-NetConnection 192.168.64.3 -Port 445
```

Safety: READ

`TcpTestSucceeded : True` proves that the Windows client can reach the server's SMB listener. It does not prove that credentials or share permissions are correct.

## Open a Share in Explorer

Enter in the Explorer address bar:

```text
\\192.168.64.3\company
```

Authenticate with the Samba username and password when prompted.

## Map a Temporary Drive

```cmd
net use Z: \\192.168.64.3\company /user:linux01 *
```

Safety: CHANGE

The final `*` requests the password interactively so it does not appear in command history.

Inspect mapped drives:

```cmd
net use
```

Disconnect:

```cmd
net use Z: /delete
```

If an elevated PowerShell session has no SMB credentials, Windows may report
that organizational policy blocks unauthenticated guest access. Do not weaken
guest policy. Create an authenticated connection instead:

```cmd
net use \\SERVER_NAME\company /user:linux01 * /persistent:no
```

The final `*` asks for the password interactively. Confirm the connection with
`net use`, repeat the original file operation, and disconnect when finished.

---

# Tailscale Overlay Administration

## Inspect the Node and Peers

```powershell
tailscale version
tailscale status
tailscale ip -4
```

Safety: READ

The node name is used by MagicDNS. The `100.x.y.z` address is its tailnet IPv4
address and is independent of the current Wi-Fi, Ethernet or UTM subnet.

## Test Overlay and Service Connectivity

```powershell
tailscale ping linux01-server
Test-NetConnection -ComputerName linux01-server -Port 445 -InformationLevel Detailed
```

Safety: READ

Interpret separately:

- `tailscale ping` verifies the overlay path;
- `TcpTestSucceeded : True` verifies that TCP 445 is reachable;
- opening and writing to the share verifies SMB authentication and permissions.

`via DERP(...)` is a working encrypted relay path, not a failed test. A direct
path is normally faster and can be investigated later as a NAT-traversal issue.

## Run Tailscale Without an Interactive Login Session

From elevated PowerShell:

```powershell
tailscale up --unattended=true
```

Safety: CHANGE

This is useful for a server or laboratory VM that must remain reachable after
the desktop user signs out. It does not mean guest SMB access should be enabled.

## Test SMB Through MagicDNS

```powershell
Test-NetConnection linux01-server -Port 445
net use \\linux01-server\company /user:linux01 * /persistent:no
Set-Content '\\linux01-server\company\windows-test.txt' 'Created from Windows over SMB'
Get-Content '\\linux01-server\company\windows-test.txt'
```

Safety: READ for the port/content checks; CHANGE for `net use` and
`Set-Content`.

---

# Event Logs

## Read Recent System Events

```powershell
Get-WinEvent -LogName System -MaxEvents 20
```

Safety: READ

Shows the 20 most recent events in the System log.

## Read Recent Application Events

```powershell
Get-WinEvent -LogName Application -MaxEvents 20
```

Safety: READ

Use timestamps, event source and event ID to correlate events with the reported failure.

---

# System Files and Recovery

## Check the Windows Component Store

```text
DISM /Online /Cleanup-Image /CheckHealth
```

Safety: READ

Checks whether Windows has already detected component-store corruption.

Run Command Prompt or PowerShell as Administrator. An administrator account does not automatically mean that the current process is elevated.

---

# Troubleshooting Order

1. Define exactly what is failing.
2. Determine the affected users and systems.
3. Record the current state before changing anything.
4. Check hardware, network, service state and relevant logs.
5. Form one testable hypothesis.
6. Test one thing at a time.
7. Apply the smallest appropriate fix.
8. Repeat the original test.
9. Document the cause, resolution and verification.

---

# Post-Maintenance Verification

Check:

- The computer restarted when required
- Expected services are running
- No new critical System or Application events appeared
- Network and application access work
- The intended update or configuration change is present

Useful commands:

```powershell
Get-ComputerInfo
Get-Service
Get-WinEvent -LogName System -MaxEvents 20
```

Maintenance is complete only when the intended change is applied and the system remains healthy.
