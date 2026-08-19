# Engineering Journal

Concise record of completed laboratories, decisions, incidents and acceptance
evidence. Command syntax is maintained separately in the Linux and Windows
runbooks to avoid duplicating hundreds of lines here.

## Lesson 1 — Windows Infrastructure Foundation

**Date:** 2026-08-03<br>
**Environment:** Windows 11 Pro ARM64 in UTM

### Work Completed

- Deployed the VM and installed VirtIO Guest Tools.
- Identified Windows directory and component-store responsibilities.
- Inspected services, processes and system information.
- Generated CPU, memory, disk and network workloads in Resource Monitor.

### Acceptance Evidence

- Windows detected the virtual network device after the VirtIO driver install.
- Resource Monitor attributed activity to the intended test processes.
- Elevated PowerShell completed operations that failed in a non-elevated shell.

### Key Incidents

| Symptom | Cause | Resolution and lesson |
|---|---|---|
| Setup could not see the NIC | VirtIO driver missing | Used the hypervisor tools ISO before searching externally |
| DISM error 740 | Shell was not elevated | Started PowerShell as Administrator; account membership is not process elevation |
| Incorrect performance figures | Wrong process/activity view selected | Repeated the test and verified the measurement source |

## Lesson 2 — Windows Services and Registry

### Work Completed

- Inspected Service Control Manager state and startup configuration.
- Connected service definitions with their Registry locations.
- Compared `Get-Service` output with deeper service configuration.
- Investigated shared `svchost.exe` hosting.

### Key Learning

A service name can appear in several Windows interfaces, but the evidence comes
from its actual configuration, dependencies, executable or service DLL and
runtime state. Services should not be disabled merely because their names look
unnecessary.

## Lesson 3 — Ubuntu Server Deployment

**Date:** 2026-08-08<br>
**Environment:** Ubuntu Server 24.04 LTS ARM64 in UTM

### Work Completed

- Deployed a minimal 64 GiB thin-provisioned VM.
- Installed OpenSSH Server.
- Verified IPv4 connectivity, DNS resolution and available updates.
- Deferred optional roles until a workload was defined.

### Key Incidents

| Symptom | Cause | Resolution and lesson |
|---|---|---|
| `ping` rejected an argument | Incorrect syntax | Read the error and corrected the command before blaming the network |
| DNS test failed | `google,com` typo | Separated input error from resolver failure |

## Lesson 4 — Linux Baseline and Verified SSH

**Date:** 2026-08-10<br>
**Environment:** Ubuntu Server 24.04.4 LTS, UTM Apple Virtualization

### Baseline

| Item | Observed state |
|---|---|
| Host / architecture | `linux01`, ARM64 |
| Memory / swap | ~3.8 GiB / ~3.8 GiB |
| Virtual disk | 64 GiB |
| Root LV / free VG | ~30.5 GiB / ~30.47 GiB |
| Kernel after maintenance | `6.8.0-137-generic` |
| Failed systemd units | 0 |

### Work Completed

- Inspected OS, network, uptime, memory, filesystems, disks and all LVM layers.
- Reviewed the APT plan, applied upgrades and checked history/reboot evidence.
- Investigated `ssh.socket` listening while `ssh.service` was initially idle.
- Compared the server ED25519 fingerprint before accepting first connection.
- Created a dedicated macOS ED25519 client key and installed only its public key.
- Verified public-key-only login and inspected live sessions and SSH logs.

### Key Incidents

| Symptom | Evidence and cause | Resolution |
|---|---|---|
| Password repeatedly rejected | Port and host key were correct; logs reported `Invalid user` | Corrected `linuxx01` to `linux01`; reboot was unnecessary |
| `authorized_keys` was invalid | A shell command had been typed into `nano`; line count alone looked valid | Created `~/.ssh`, installed the actual public key, set `700/600` permissions and validated with `ssh-keygen` |
| Several commands failed | Wrong option, command spelling or path component | Classified the error before retrying and used history/tab completion |

### Acceptance Evidence

- Correct kernel running and no failed units after maintenance.
- `ssh.socket` listening on TCP 22 and activating `ssh.service` on demand.
- Host fingerprint matched on server and client.
- Dedicated client key succeeded with password fallback disabled.

## Lesson 5 — LVM-Backed Samba File Server

**Date:** 2026-08-14 to 2026-08-15<br>
**Status:** Passed controlled reboot acceptance test

### Design

The workload is an authenticated internal file share. Service data is isolated
from the root filesystem and access is controlled through a Unix group.

| Component | Implemented state |
|---|---|
| Logical volume | `files`, 10 GiB in `ubuntu-vg` |
| Filesystem | ext4, label `files` |
| Persistent mount | `/srv/samba` by UUID in `/etc/fstab` |
| Share directory | `/srv/samba/company`, owner `root:fileshare`, mode `2770` |
| Samba share | `company`, authenticated, writable, `valid users = @fileshare` |
| File modes | files `0660`, directories `2770`, forced group `fileshare` |

### Work Completed

- Allocated, formatted and mounted the dedicated logical volume.
- Backed up and edited `fstab`, then proved restoration with `mount -a`.
- Configured group membership and setgid inheritance.
- Installed Samba 4.19 and validated effective configuration with `testparm`.
- Added an existing Linux account to Samba without recording its password.
- Verified macOS share discovery and two-way read/write.
- Activated UFW in a recovery-safe order.
- Disabled Samba printing, spoolss and guest usershares.

### Key Incidents

| Symptom | Cause | Lesson |
|---|---|---|
| `ss`, `vgs`, `findmnt`, `getent` or `smb.conf` failed | Option or spelling mistakes | `command not found` and missing-path errors point to different layers |
| Backup path failed | Treated `/etc/fstab` as a directory | Verify object type; use a sibling backup file |
| `/Volumes/company` missing over SSH | macOS mount path used inside Ubuntu | Map each client path to the server-side storage path |
| Administrative commands printed nothing | Successful Unix commands are often silent | Follow each change with an explicit inspection command |

### Acceptance Evidence

- `mount -a` restored the volume before reboot.
- Mac-created files appeared under `/srv/samba/company` with intended modes.
- After reboot, SSH, UFW, Samba, the LVM mount and stored data returned.
- TCP 22 and 445 remained reachable while legacy TCP 139 was blocked.

## Lesson 6 — Cross-Platform Tailscale Administration

**Date:** 2026-08-18 to 2026-08-19<br>
**Nodes:** `macbook-admin`, `linux01-server`, `nova-ws01`

### Problem and Design

UTM and upstream-network changes moved devices between local subnets, making
old SSH aliases and firewall rules obsolete. Tailscale supplies stable
MagicDNS identities and an encrypted `tailscale0` management path.

The final Ubuntu firewall grants exactly:

- Mac SSH on TCP 22;
- Mac SMB on TCP 445;
- Windows SMB on TCP 445.

Every rule is bound to `tailscale0` and an exact client address. Windows has no
SSH permission because its current client role does not require it.

### Work Completed

- Joined Ubuntu, macOS and Windows to one tailnet.
- Verified Tailscale identity, address, peer state and application ports.
- Moved normal SSH/SMB workflows from changing local IPs to MagicDNS.
- Removed obsolete UFW rules only after proving a second recovery connection.
- Tested authenticated SMB read/write from both desktop platforms.
- Rebooted Ubuntu and revalidated network, services and storage together.
- Implemented four idempotent Bash/PowerShell tools with wizard, parameter and
  check-only modes.

### Key Incidents

| Symptom | Cause | Resolution and lesson |
|---|---|---|
| SSH/SMB timed out after network changes | Clients and server moved subnets | Separate service health, firewall and route; adopted stable overlay identity |
| Elevated Windows shell reported blocked guest access | It lacked Explorer's authenticated SMB session | Authenticated that logon context; never weakened guest policy |
| `tailscale ping` used DERP | Direct NAT traversal was unavailable | Service remained encrypted and usable; tracked as performance work |
| UFW accumulated temporary rules | Troubleshooting added exceptions without cleanup | Proved replacement access and deleted obsolete rules in descending order |

### Automation Acceptance — 2026-08-19

- macOS check-only reached Ubuntu TCP 445.
- Ubuntu bootstrap confirmed `tailscaled` active/enabled and reached the Mac.
- UFW helper recognized all existing exact rules without duplicates.
- Windows parser/check-only tests passed and TCP 445 returned success.
- Windows wizard cancelled safely at the default-No gate.
- Confirmed Windows run preserved the computer name, applied `nova-ws01`,
  enabled unattended operation and completed successfully.

Some peer tests used `DERP(par)` or `DERP(fra)`. End-to-end SSH/SMB tests passed,
so relay use is recorded as a latency observation rather than an outage.

## Operational Habits Established

1. Baseline before changing state.
2. Read the exact error before retrying.
3. Keep a console or second session during remote-access changes.
4. Validate syntax, runtime state, network port and real application behavior.
5. Treat a reboot as a persistence test, not a default troubleshooting step.
6. Keep secrets out of source, command history and deployment logs.
7. Publish tested changes through a feature branch and pull request.

## Next Laboratory

Define the Samba backup scope and recovery objectives, create a backup, then
restore it into a controlled test location and verify ownership, permissions,
configuration and application access.
