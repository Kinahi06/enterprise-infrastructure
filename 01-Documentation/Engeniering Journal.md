# Engineering Journal

---

# Lesson 1 — Windows Infrastructure Lab

Date:
2026-08-03

Duration:
~6 Hours

---

## Objectives

- Deploy Windows 11 Pro ARM64 virtual machine
- Configure UTM virtual hardware
- Install VirtIO Guest Tools
- Explore Windows system architecture
- Learn basic Windows diagnostic tools
- Perform the first Resource Monitor laboratory

---

## What I Learned

- A server is a role, not a physical machine.
- There is no universal "best" virtual machine configuration.
- VM resources should always match the workload.
- Thin Provisioning allocates storage dynamically rather than reserving the full virtual disk size.
- Windows diagnostics should always begin with system inspection before making changes.
- Resource Monitor provides much deeper information than Task Manager for troubleshooting.

---

## Windows Tools Explored

- winver
- msinfo32
- Device Manager
- Disk Management
- Resource Monitor
- PowerShell
- Services

---

## Windows Folder Investigation

Studied the purpose of the following directories:

- C:\Windows
- C:\Program Files
- C:\Program Files (x86)
- C:\Users
- C:\ProgramData
- C:\Windows\System32
- C:\Windows\SysWOW64
- C:\Windows\WinSxS

Main conclusions:

- Windows itself is stored inside the Windows directory.
- User profiles are isolated inside the Users directory.
- Program Files contains installed applications.
- System32 contains the core operating system components.
- SysWOW64 stores compatibility components for 32-bit applications.
- WinSxS is the Windows Component Store used for servicing, recovery and feature installation.

---

## Resource Monitor Lab

### Baseline

CPU:
3–10%

Memory:
73%

Disk I/O:
0–200 KB/sec

Network I/O:
0–250 KB/sec

Hard Faults/sec:
0

---

### CPU Test

Process:
PowerShell

Purpose:
Generate artificial CPU load and observe process utilization.

Observation:
Initially measured the wrong process (ShellExperienceHost), then corrected the methodology.

---

### Memory Test

Working Set:
303,736 KB

Private:
21,156 KB

Commit:
325,396 KB

Hard Faults/sec:
0

Observation:
Windows handled the allocated memory without page faults.

---

### Disk Test

Process:
PowerShell

Write:
1,350,756,213 B/sec

Read:
956 B/sec

Response Time:
2 ms

Observation:
The generated workload successfully produced measurable disk activity.

---

### Network Test

Process:
Microsoft Edge

Remote Host:
youtube.com

Receive:
1,387,593 B/sec

Latency:
N/A

---

## Incidents

### Incident #0001

Problem:

Windows Setup could not detect the virtual network adapter.

Hypothesis:

Missing VirtIO network driver.

Investigation:

Checked the UTM Guest Tools ISO before searching online.

Resolution:

Installed the VirtIO network driver from Guest Tools.

Lesson Learned:

Always inspect the hypervisor tools before searching for external drivers.

---

### Incident #0002

Problem:

DISM returned Error 740.

Cause:

PowerShell was not running with elevated privileges.

Resolution:

Started PowerShell using "Run as Administrator".

Lesson Learned:

Administrator account does not automatically mean an elevated process.

---

### Incident #0003

Problem:

Incorrect Resource Monitor measurements.

Cause:

Observed the wrong process and confused Process Activity with Disk Activity.

Resolution:

Repeated the laboratory using the correct workload and process selection.

Lesson Learned:

Always verify that measurements are taken from the intended process and activity source.

---

## Engineering Notes

During this lesson I realized that diagnostics are based on evidence rather than assumptions.

Resource Monitor should be used to identify the actual source of CPU, memory, disk or network activity instead of relying on overall system graphs.

Another important lesson was understanding that Windows components should not be removed simply because they appear unnecessary. Every service or package must first be identified, investigated and documented before any modification is performed.

---

## Questions for Future Lessons

- NAT vs Bridge networking
- Windows Service Control Manager
- AppX Packages
- Provisioned Packages
- Windows Component Store
- PowerShell automation
- Service optimization
- Windows startup sequence

---

## Commands Learned

winver

msinfo32

resmon

services.msc

diskmgmt.msc

Get-ComputerInfo

Get-Process

Get-Service

DISM

Get-AppxPackage

Get-AppxProvisionedPackage

---

## References

Microsoft Learn
https://learn.microsoft.com/

PowerShell Documentation
https://learn.microsoft.com/powershell/

Microsoft Sysinternals
https://learn.microsoft.com/sysinternals/

UTM Documentation
https://docs.getutm.app/

VirtIO Drivers
https://github.com/virtio-win

---

## Next Lesson

Windows Services

Goals:

- Understand the Windows Service Control Manager
- Investigate service dependencies
- Learn startup types
- Explore AppX and Provisioned Packages
- Create the first PowerShell automation script
- Begin optimizing the laboratory environment

# Lesson 2

## What I Learned

- Service Control Manager (SCM) manages the lifecycle of Windows services.
- Windows service configuration is stored in the Registry.
- Many Windows services run inside `svchost.exe` instead of a dedicated executable.
- PowerShell retrieves service information from the system configuration rather than storing it itself.

## What Surprised Me

- The same service name can appear in multiple Windows subsystems.
- Finding the correct Registry location requires understanding the Windows architecture rather than relying on search results.
- A service configuration contains significantly more information than `Get-Service` displays.

## Questions Raised

- How does SCM determine which service DLL to load?
- Why are multiple services grouped into the same `svchost.exe` process?
- What exactly happens internally when `Set-Service` changes the startup type?

# Lesson 3 — Ubuntu Server Deployment

Date:
2026-08-08

Duration:
~2 Hours

---

## Objectives

- Deploy Ubuntu Server 24.04 LTS ARM64 virtual machine
- Configure virtual machine resources in UTM
- Install OpenSSH Server
- Verify network connectivity
- Verify DNS resolution
- Check available system updates

---

## What I Learned

- Ubuntu Server can be deployed efficiently on ARM64 hardware using UTM.
- Thin Provisioning allows a virtual disk to grow dynamically without allocating its full configured capacity immediately.
- OpenSSH Server provides remote command-line access to a Linux server.
- Server validation should be performed before making unnecessary configuration changes.
- `apt update` refreshes package metadata but does not install updates.
- `apt list --upgradable` shows packages that have newer versions available.

---

## Linux Tools Explored

- ping
- apt
- OpenSSH

---

## Network Verification

IPv4:
192.168.64.3

Connectivity:
Successful

DNS Resolution:
Successful

Tests performed:

- Ping to 8.8.8.8
- Ping to google.com

---

## Incidents

### Incident #0004

Problem:

Incorrect `ping` command syntax caused an invalid argument error.

Cause:

Command syntax was entered incorrectly.

Resolution:

Corrected the command and repeated the connectivity test.

Lesson Learned:

Always verify command syntax before assuming that the system or network is failing.

---

### Incident #0005

Problem:

DNS lookup failed during a connectivity test.

Cause:

The domain was entered as `google,com` instead of `google.com`.

Resolution:

Corrected the domain name and repeated the test successfully.

Lesson Learned:

Differentiate user input errors from actual DNS or network failures.

---

## Engineering Notes

The Ubuntu Server was deployed successfully as the first Linux system in the infrastructure laboratory.

A 64 GB dynamically allocated virtual disk was selected to allow future expansion without consuming the full disk capacity immediately.

The server was intentionally kept minimal during installation. Optional server applications were not installed because no specific server role has been assigned yet.

Available system updates were reviewed before applying any changes.

---

## Commands Learned

ping

apt update

apt list --upgradable

---

## Next Lesson

Linux Server Provisioning

Goals:

- Apply system updates
- Verify disk and memory usage
- Verify SSH access
- Inspect running services
- Begin basic Linux system administration