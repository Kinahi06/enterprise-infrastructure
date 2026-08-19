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

---

# Lesson 4 — Ubuntu Server Baseline and SSH

Date:
2026-08-10

Environment:
Ubuntu Server 24.04.4 LTS ARM64 running in UTM on Apple Virtualization

---

## Objectives

- Inspect a new Ubuntu Server before assigning it a role
- Understand the VM's CPU architecture, network, memory and disk layout
- Review and install system updates safely
- Verify the server after a reboot
- Understand systemd service and socket states
- Prepare and verify the first SSH connection

---

## Baseline Discovered

- Hostname: `linux01`
- Operating system: Ubuntu Server 24.04.4 LTS
- Architecture: ARM64
- Virtualization platform: Apple Virtualization in UTM
- IPv4 address: `192.168.64.3/24`
- RAM: approximately 3.8 GiB
- Swap: approximately 3.8 GiB
- Virtual disk: 64 GiB
- Root logical volume: approximately 30.5 GiB
- Free space in the LVM volume group: approximately 30.47 GiB
- Running kernel after maintenance: `6.8.0-137-generic`
- Failed systemd units after maintenance: 0
- ED25519 host-key fingerprint: `SHA256:Ur/zU2dPPTwqhV2XNXfbre0sfzBo17iWMzLuxIOT4kY`
- Lab client-key fingerprint: `SHA256:5eqebJS9oZJ9gGGDIoKdGAtH31D5yhBPcaC5o+diegs`

The unused LVM space is not an error. It is capacity that can later be assigned to the root filesystem or to a separate logical volume after the server role and storage requirements are known.

---

## What I Learned

### System inspection

- `hostnamectl` identifies the OS, kernel, architecture, hostname and virtualization platform.
- `ip -br address` provides a compact view of network interfaces and addresses.
- `uptime` shows time since boot, logged-in users and load averages.
- `free -h` shows RAM and swap usage; the `available` value is more useful than `free` when judging memory pressure.
- `df -h` reports usage of mounted filesystems.
- `lsblk` shows the relationship between disks, partitions, LVM and mount points.
- `pvs`, `vgs` and `lvs` show the three LVM layers: physical volume, volume group and logical volume.
- `systemctl --failed` provides a quick system health check, but zero failed units does not prove that every application works.

### Package maintenance

- `sudo apt update` refreshes package metadata and does not install upgrades.
- `apt list --upgradable` shows which packages have newer versions available.
- `sudo apt upgrade` calculates a plan before applying it, allowing upgraded, installed, removed and held packages to be reviewed.
- Updates were appropriate for this new lab because no application compatibility requirements had been defined and the VM could be recovered if necessary.
- `/var/log/apt/history.log` records package operations, including commands, packages, dates and whether an unattended upgrade performed the work.
- A reboot should be based on evidence, not habit. After maintenance, the active kernel, uptime and failed units were checked.

### Terminal and command-line work

- Linux command options begin with `-` or `--`; one wrong character can change or invalidate the command.
- `-h` commonly requests human-readable sizes, while `-o` in `lsblk` selects output columns.
- Long output can be opened in `less`; `Space` moves forward, `b` moves back and `q` exits.
- The Up Arrow recalls command history so a typo can be corrected without retyping the entire command.
- `Tab` completion helps avoid mistakes in commands and file paths.
- `No such file or directory` means the program ran but the specified path was not found. The path itself should be checked character by character.

### systemd and SSH

- `systemctl status` shows whether a unit is loaded, active and enabled, along with recent logs.
- `loaded` means systemd knows the unit definition.
- `active` describes the unit's current runtime state.
- `enabled` describes whether the unit is configured to participate automatically in startup or activation.
- A service can be inactive while its socket is active. With socket activation, systemd listens on the network and starts the service when a connection arrives.
- `ssh.service` was inactive, but `ssh.socket` was enabled and active (listening).
- The SSH socket listened on TCP port 22 for both IPv4 (`0.0.0.0:22`) and IPv6 (`[::]:22`).
- After the first client connected, socket activation changed `ssh.service` to `active (running)`.
- An SSH host-key fingerprint must be compared during the first connection instead of accepting it blindly.
- `w` distinguishes active login sessions, their source, login time, idle time, CPU use and current command.
- Multiple sessions can belong to the same account; `2 users` in the `w` header means two sessions in this case, not two different usernames.
- A server host key proves the server's identity, while a client key proves the user's identity.
- The private client key remains on the administrator's device; only the `.pub` key is installed on servers.
- `~/.ssh/authorized_keys` lists the public keys allowed to authenticate as that Linux account.
- SSH requires restrictive permissions: `700` for `~/.ssh` and `600` for `authorized_keys`.

---

## Errors Investigated

### Incorrect option separator

Examples encountered:

- `free =h` instead of `free -h`
- `lsblk -0` instead of `lsblk -o`

Lesson:

Read an error message before retrying. Determine whether the problem is the command name, an option or an argument.

### Mistyped systemd command

`systemctl` was initially mistyped. After correcting the command, the unit status could be inspected normally.

Lesson:

Command names are exact. Use shell history and edit the incorrect character instead of starting over.

### Mistyped SSH host-key path

Entered path component:

```text
shh_host_ed25519_key.pub
```

Correct path component:

```text
ssh_host_ed25519_key.pub
```

Result:

`ssh-keygen` started successfully, but returned `No such file or directory` because the requested path did not exist.

Lesson:

Separate command-execution errors from file-path errors. Use history and tab completion to reduce typing mistakes.

### SSH password rejected for the wrong account

Problem:

SSH reached the password prompt but repeatedly returned `Permission denied`.

Evidence:

- The server answered on TCP port 22, so networking and the SSH listener were working.
- The host-key fingerprint matched, so the intended server had been reached.
- `whoami` on the server returned `linux01`.
- `sudo -k` followed by `sudo -v` accepted the local password.
- The SSH command incorrectly requested the account `linuxx01` with an extra `x`.
- The SSH journal recorded `Invalid user`, `user unknown` and `Failed password for invalid user` for the incorrect account.

Resolution:

Connected using the correct account:

```bash
ssh linux01@192.168.64.3
```

Lesson:

SSH authenticates the password for the username written before `@`. A correct password for one account will be rejected when a different account is requested. Verify identity and credentials before rebooting a healthy server.

Verification:

After the corrected login, `systemctl status ssh` showed:

- `Active: active (running)`
- `TriggeredBy: ssh.socket`
- `Accepted password for linux01`
- `session opened for user linux01`

These messages confirmed both socket activation and successful authentication.

### Invalid content in `authorized_keys`

Problem:

The shell command used to copy the public key was entered as text inside `nano`. The first save also failed because the server's `~/.ssh` directory did not yet exist. A later file contained one line, but `ssh-keygen` reported that it was not a public key.

Investigation:

- `ls -ld ~/.ssh` verified the directory and its `700` permissions.
- `ls -la ~/.ssh` showed that `authorized_keys` initially had a size of 0 bytes.
- `wc -l` confirmed the number of lines but did not validate their contents.
- `ssh-keygen -lf ~/.ssh/authorized_keys` detected malformed key data.

Resolution:

The correct public key was transmitted from macOS through the existing SSH connection and written to `authorized_keys`. The file was then set to mode `600`.

Verification:

- `wc -l` reported one key line.
- `ssh-keygen -lf` displayed the expected ED25519 fingerprint and comment.
- A new connection restricted to public-key authentication succeeded without requesting the Ubuntu account password.

Lesson:

An editor records text but does not execute shell commands. File existence and line count do not prove that the file contains valid data; use a format-aware validation tool when one is available.

---

## Commands Practised

```bash
hostnamectl
ip -br address
uptime
uname -r
free -h
df -h
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
sudo pvs
sudo vgs
sudo lvs
systemctl --failed
apt list --upgradable
sudo apt upgrade
less /var/log/apt/history.log
systemctl status
systemctl status ssh
systemctl status ssh.socket
ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
ssh linux01@192.168.64.3
whoami
hostname
echo $SSH_CONNECTION
w
mkdir -p ~/.ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
ls -ld ~/.ssh
ls -la ~/.ssh
echo $?
nano ~/.ssh/authorized_keys
wc -l ~/.ssh/authorized_keys
ssh-keygen -lf ~/.ssh/authorized_keys
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_enterprise_lab -C "kinahi06@enterprise-lab"
pbcopy < ~/.ssh/id_ed25519_enterprise_lab.pub
cat ~/.ssh/id_ed25519_enterprise_lab.pub | ssh linux01@192.168.64.3 'cat > ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
ssh -o IdentitiesOnly=yes -o PreferredAuthentications=publickey -i ~/.ssh/id_ed25519_enterprise_lab linux01@192.168.64.3
exit
```

---

## Maintenance Verification

After the upgrade and reboot:

- The server had recently booted.
- Kernel `6.8.0-137-generic` was running.
- Load was near zero.
- No failed systemd units were reported.
- `ssh.socket` was active and listening on port 22.
- The ED25519 public host key was found and its fingerprint was displayed successfully.
- The fingerprint presented to macOS matched the fingerprint read locally on the server.
- The server key was added to the macOS `known_hosts` file.
- The first SSH login from macOS succeeded as user `linux01`.
- `$SSH_CONNECTION` identified client `192.168.64.1`, server `192.168.64.3` and destination port `22`.
- `ssh.service` was observed running after activation by the client connection.
- `w` showed one remote session from `192.168.64.1` and one local `tty1` console session, both owned by `linux01`.
- A lab-specific ED25519 client key was created on macOS.
- The public key was installed in `/home/linux01/.ssh/authorized_keys`.
- Public-key-only SSH authentication succeeded using the intended private key.

The first verified remote administration session from macOS to `linux01` is working.

---

## Lesson 4 Closeout

Status at the end of 2026-08-10:

- Ubuntu package maintenance is complete and no immediate updates are pending.
- Kernel `6.8.0-137-generic` is active.
- No failed systemd units were observed after maintenance.
- SSH host identity was verified before trust was accepted.
- Password authentication and public-key authentication both succeeded for `linux01`.
- Public-key-only testing proved that success was not caused by password fallback.
- The UTM console remains available as a recovery path.
- Password authentication has not been disabled.
- No passwords, passphrases or private keys were written to project documentation.

Next lesson:

1. Inspect or create the macOS SSH client configuration.
2. Add a short alias for the lab server without overwriting existing settings.
3. Test the alias and review effective SSH client behavior.
4. Inspect firewall and server SSH settings before considering hardening.
5. Define a workload for `linux01` before installing additional software.

---

# Lesson 5 — LVM-Backed Samba File Server

Date:
2026-08-14 to 2026-08-15

Environment:
Ubuntu Server 24.04.4 LTS ARM64 in UTM, administered from macOS over SSH

Status:
Completed and verified after controlled reboot

---

## Objectives

- Convert `linux01` from an unassigned training node into a useful server
- Create dedicated storage without consuming the root filesystem
- Make the storage mount persistent
- Model access through a Unix group instead of broad permissions
- Publish an authenticated SMB share
- Prove read and write access from a real macOS client
- Preserve SSH and UTM-console recovery paths before firewall changes

---

## Maintenance and SSH Client Preparation

- Created `~/.ssh/config` on macOS with alias `linux01-lab`.
- Configured the alias to use host `192.168.64.3`, user `linux01`, the dedicated laboratory key and `IdentitiesOnly yes`.
- Verified the effective client configuration with `ssh -G`.
- Successfully connected using `ssh linux01-lab`.
- Reviewed pending upgrades before applying them.
- Observed Ubuntu phased updates: five Kerberos packages were deferred while `linux-firmware` was eligible.
- Applied the available upgrade.
- Confirmed that the running kernel was current, no services required restart, no failed units were present and no reboot-request file existed.

---

## Baseline Before the File-Server Role

- UFW state: inactive
- Existing externally listening service: SSH on TCP 22
- LVM volume group: `ubuntu-vg`, approximately 60.95 GiB
- Existing root logical volume: approximately 30.47 GiB
- Initial free volume-group capacity: approximately 30.47 GiB
- No Samba ports were present before installation

The workload was defined before allocating storage: an authenticated internal file share for macOS and later Windows clients.

---

## Dedicated LVM Storage

Created a 10 GiB logical volume:

```bash
sudo lvcreate -L 10G -n files ubuntu-vg
```

Formatted it as ext4 and assigned a readable filesystem label:

```bash
sudo mkfs.ext4 -L files /dev/ubuntu-vg/files
lsblk -f
```

Verified results:

- Logical volume: `/dev/ubuntu-vg/files`
- Size reported by LVM: 10.00 GiB
- Filesystem: ext4
- Label: `files`
- Mount point: initially empty
- Remaining free capacity in `ubuntu-vg`: approximately 20.47 GiB

The separate volume prevents file-share data from silently consuming all free space on the root filesystem and gives the workload an independent capacity boundary.

---

## Persistent Mount

Created the service-data mount point:

```bash
sudo mkdir -p /srv/samba
```

Backed up `/etc/fstab`, then added an entry using the filesystem UUID rather than a device name:

```text
UUID=132114e7-fce2-43c5-8c87-3f88a07a0274 /srv/samba ext4 defaults 0 2
```

Applied the systemd configuration refresh and validated the mount:

```bash
sudo systemctl daemon-reload
sudo mount -a
findmnt /srv/samba
df -h /srv/samba
```

Persistence was tested without rebooting:

1. Unmounted `/srv/samba`.
2. Confirmed that `findmnt` returned no mount.
3. Ran `mount -a`.
4. Confirmed that the `files` logical volume returned at `/srv/samba`.

The mounted filesystem reported approximately 9.8 GiB total and 9.3 GiB available.

---

## Unix Group and Filesystem Permissions

Created a role group and added the laboratory user:

```bash
sudo groupadd fileshare
sudo usermod -aG fileshare linux01
```

Created the shared directory and assigned restrictive group permissions:

```bash
sudo mkdir -p /srv/samba/company
sudo chown root:fileshare /srv/samba/company
sudo chmod 2770 /srv/samba/company
```

Interpretation of `2770`:

- Owner: read, write and enter
- Group: read, write and enter
- Others: no access
- Leading `2`: setgid inheritance for new directory contents

The original SSH session did not immediately contain the new supplementary group because process credentials are established at login. After reconnecting, `id` showed `fileshare`, and user `linux01` created a file without `sudo`. The new file inherited group `fileshare`.

---

## Samba Deployment

Installed Samba 4.19 and verified:

- `smbd.service` was enabled and active
- TCP 445 and TCP 139 were listening on IPv4 and IPv6
- The server role reported by `testparm` was `ROLE_STANDALONE`

Backed up the original configuration and added the authenticated share:

```ini
[company]
    comment = Enterprise Lab company files
    path = /srv/samba/company
    browseable = yes
    read only = no
    guest ok = no
    valid users = @fileshare
    force group = fileshare
    create mask = 0660
    force create mode = 0660
    directory mask = 2770
    force directory mode = 2770
```

`testparm -s` returned `Loaded services file OK` and displayed the effective `company` share.

Added existing Linux user `linux01` to Samba's account database with `smbpasswd`, reloaded the configuration and confirmed that `smbd` remained active. The Samba password itself was not recorded.

---

## macOS Client Acceptance Test

The macOS client listed available resources with:

```bash
smbutil view //linux01@192.168.64.3
```

The response included:

- `company` — the intended disk share
- `print$` — an unused default printer-driver share to remove later
- `IPC$` — Samba's normal inter-process control share

Connected in Finder using:

```text
smb://192.168.64.3/company
```

The file created locally on Ubuntu appeared in Finder. macOS then created:

```text
/Volumes/company/mac-test/hello-from-mac.txt
```

The server immediately showed the same objects under:

```text
/srv/samba/company/mac-test/hello-from-mac.txt
```

The content matched on both systems. The Samba-created directory inherited `fileshare` and setgid permissions; the Samba-created file received mode `0660` as configured.

This proved the complete path:

```text
macOS client -> TCP 445 -> smbd -> smb.conf -> Linux identity and group -> ext4 LVM storage
```

---

## Errors Investigated

### Invalid `ss` option

`ss -tulkpn` included unsupported option `-k`. Reading the command's help revealed the valid flags, and `ss -tulpn` produced the intended listening-socket report.

### Command and path spelling

Examples included `fgs` instead of `vgs`, `findtmnt` instead of `findmnt`, `geyent` instead of `getent`, and `sbm.conf` instead of `smb.conf`.

Lesson:

Classify the message before reacting. `command not found` points to a command-name problem; `No such file or directory` points to a path problem.

### File versus directory in a backup path

`/etc/fstab/backup-files` failed because `/etc/fstab` is a file, not a directory. The corrected sibling filename was `/etc/fstab.backup-files`.

### Wrong operating-system path

`/Volumes/company` exists on macOS after Finder mounts the SMB share. It does not exist inside the Ubuntu SSH session, where the corresponding path is `/srv/samba/company`.

### Silent success

Several successful administrative commands produced no output, including `groupadd`, `usermod`, `chmod`, `chown`, `mount -a` and Samba's configuration reload. Follow-up inspection commands supplied the evidence instead of treating silence as uncertainty.

---

## Commands Practised

```bash
ssh -G linux01-lab
ssh linux01-lab
apt list --upgradable
sudo apt upgrade --dry-run
sudo apt upgrade
systemctl --failed
sudo ss -tulpn
sudo vgs
sudo lvs
sudo lvcreate -L 10G -n files ubuntu-vg
sudo mkfs.ext4 -L files /dev/ubuntu-vg/files
lsblk -f
sudo mkdir -p /srv/samba
sudo cp -a /etc/fstab /etc/fstab.backup-files
sudo nano /etc/fstab
sudo systemctl daemon-reload
sudo mount -a
sudo umount /srv/samba
findmnt /srv/samba
df -h /srv/samba
sudo groupadd fileshare
sudo usermod -aG fileshare linux01
sudo chown root:fileshare /srv/samba/company
sudo chmod 2770 /srv/samba/company
getent group fileshare
id
ls -ld /srv/samba/company
sudo apt install samba
smbd --version
systemctl status smbd --no-pager
sudo testparm -s
sudo smbpasswd -a linux01
sudo pdbedit -L
sudo smbcontrol smbd reload-config
smbutil view //linux01@192.168.64.3
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 192.168.64.0/24 to any port 22 proto tcp comment 'SSH lab'
sudo ufw allow from 192.168.64.0/24 to any port 445 proto tcp comment 'SMB lab'
sudo ufw show added
sudo ufw enable
sudo ufw status verbose
```

---

## Firewall and Samba Hardening

UFW was configured in a recovery-safe order:

1. Kept the existing SSH session and UTM console available.
2. Set the default incoming policy to deny.
3. Allowed outgoing traffic.
4. Added TCP 22 and TCP 445 rules restricted to `192.168.64.0/24`.
5. Inspected the staged policy before enabling it.
6. Enabled UFW.
7. Tested a new SSH connection and a new SMB connection.

macOS port tests confirmed:

- TCP 22 reachable
- TCP 445 reachable
- TCP 139 blocked by timeout

Samba printing and unnecessary guest-usershare capability were disabled:

~~~ini
[global]
    load printers = no
    disable spoolss = yes
    usershare allow guests = no

[printers]
    available = no

[print$]
    available = no
~~~

`testparm -s` accepted the configuration. After reload, macOS continued to access `company`, while the unused printer resource was no longer available.

---

## Controlled Reboot Acceptance Test

Before reboot, `smbd`, UFW and `ssh.socket` were confirmed enabled. The server was then rebooted deliberately to test persistence rather than to fix a fault.

After reboot:

- SSH access through `linux01-lab` returned.
- The server retained address `192.168.64.3`.
- No failed systemd units were reported.
- The ext4 `files` logical volume mounted automatically at `/srv/samba`.
- Samba returned to the active state.
- UFW returned with the intended subnet-restricted rules.
- The macOS client listed and opened `company`.
- Files created before reboot remained readable.

This completed the acceptance criteria for the first laboratory server role.

---

## Security State at Completion

- Guest access to `company` is disabled.
- Only members of `fileshare` are accepted by the share.
- Files created through Samba are restricted to owner and group.
- The UTM console remains available as a recovery path.
- UFW is active with default-deny incoming policy.
- TCP 22 and TCP 445 are allowed only from `192.168.64.0/24`.
- TCP 139 is blocked.
- Samba printing, spoolss and guest usershares are disabled.
- Persistence was verified through a controlled reboot.
- No passwords, passphrases, private keys or recovery secrets were recorded.

---

## Next Session

1. Test the SMB share from Windows.
2. Compare the Windows and macOS client workflows.
3. Define backup scope for `/srv/samba`, `smb.conf` and related account data.
4. Perform a backup-and-restore exercise.
5. Review effective SSH server settings and plan controlled hardening.

---

# Lesson 6 — Cross-Platform Tailscale Administration

Date:
2026-08-18

Duration:
~4 Hours

---

## Objectives

- Make SSH and SMB independent of changing home, work, mobile and UTM subnets
- Connect Ubuntu, macOS and Windows through an encrypted overlay
- Preserve the server's default-deny firewall policy
- Grant each client only the services it needs
- Verify persistence after reboot
- Turn the manual procedure into safe, repeatable automation

---

## Final Topology

| Node | Platform | MagicDNS name | Tailscale IPv4 | Required access |
|------|----------|---------------|----------------|-----------------|
| Administrator | macOS | `macbook-admin` | `100.118.247.65` | SSH and SMB to Ubuntu |
| File server | Ubuntu | `linux01-server` | `100.125.27.99` | Provides SSH and SMB |
| Workstation | Windows | `nova-ws01` | `100.73.143.51` | SMB to Ubuntu |

The local UTM addresses can still exist, but they are no longer used as the
stable management identity.

---

## Why the Original Network Failed

The original Samba and SSH policy allowed clients from specific local subnets.
When UTM networking changed between shared, bridged and different upstream
networks, the Ubuntu and Windows addresses moved into new subnets. Old SSH
aliases and UFW rules therefore referred to paths that no longer existed.

The important lesson was that a service can be healthy while the network path
to it is wrong. A timeout did not prove that Samba or SSH had failed.

Tailscale added a separate `tailscale0` interface and stable MagicDNS identity
to every node. This decoupled administration from the physical network.

---

## Deployment and Verification

On each platform, the node was authenticated to the same tailnet. The following
evidence was collected:

```text
tailscale status
tailscale ip -4
tailscale ping PEER_NAME
```

On Ubuntu, `tailscaled`, `ssh.socket` and `smbd` were active. macOS established
SSH to `linux01-server`, and `$SSH_CONNECTION` showed Tailscale source and
destination addresses rather than the old UTM subnet.

Windows reached TCP 445 through MagicDNS:

```powershell
Test-NetConnection -ComputerName linux01-server -Port 445 -InformationLevel Detailed
```

Both client operating systems opened the authenticated `company` share and
created files that appeared immediately under `/srv/samba/company` on Ubuntu.

---

## Least-Privilege UFW Policy

The old local-subnet and bridged-address rules were removed only after a second
Tailscale SSH session proved the replacement path. Rules were deleted from the
highest UFW number to the lowest because rule numbers shift after deletion.

The completed policy allows:

- Mac TCP 22 on `tailscale0`
- Mac TCP 445 on `tailscale0`
- Windows TCP 445 on `tailscale0`

Every other unsolicited incoming connection remains denied. Windows was not
granted SSH because its current client role does not require it.

---

## Incidents Investigated

### Incident #0008 — Local IP Addresses Changed

Symptom:

SSH and SMB timed out after changing UTM networking.

Cause:

Clients and the server no longer shared the subnets recorded in aliases and UFW
rules.

Resolution:

Introduced Tailscale as a stable overlay and moved normal administration to
MagicDNS names.

Lesson:

Separate service health, host firewall policy and network reachability during
diagnosis.

### Incident #0009 — Windows SMB Write Reported Guest-Policy Blocking

Symptom:

File Explorer could open the authenticated share, but an elevated PowerShell
session failed to write and reported that unauthenticated guest access was
blocked.

Cause:

The elevated session did not share the Explorer session's SMB credentials.

Resolution:

Created an authenticated SMB connection for that logon context using `net use`
with an interactive password prompt. Guest access remained disabled.

Lesson:

Windows SMB connections and credentials belong to a logon context. Do not
weaken a security policy to hide an authentication problem.

### Incident #0010 — Tailscale Used DERP Relay

Symptom:

Windows `tailscale ping` reported `via DERP(par)` instead of a direct path.

Assessment:

TCP 445 and real SMB reads and writes succeeded. The overlay was healthy, but
NAT traversal had not produced a direct peer-to-peer route.

Lesson:

DERP is a functional encrypted relay. Treat it as a performance observation,
not an application outage.

### Incident #0011 — Old Firewall Rules Accumulated

Symptom:

UFW contained rules for several temporary local addresses and subnets.

Cause:

New exceptions had been added during troubleshooting without retiring the old
ones.

Resolution:

Kept recovery access, verified replacement Tailscale sessions, then deleted old
rules in descending order. The final policy contains three exact rules.

Lesson:

Firewall maintenance includes removing obsolete access, not only adding new
exceptions.

---

## Controlled Reboot Acceptance Test

After the Ubuntu reboot:

- `tailscaled`, `ssh.socket` and `smbd` returned active;
- `/srv/samba` mounted from the LVM logical volume;
- SSH reconnected through Tailscale;
- `$SSH_CONNECTION` still showed tailnet addresses;
- the existing SMB data remained available.

This proved service, network and storage persistence together.

---

## Automation Design

Four scripts were prepared:

- Ubuntu Tailscale bootstrap
- macOS Tailscale bootstrap
- Windows Tailscale bootstrap
- Ubuntu UFW client authorization

The scripts are designed to be idempotent: a second run should inspect and
reuse correct state rather than install or duplicate it. Each bootstrap has a
check-only mode and records a local log.

An interactive wizard now collects non-secret deployment choices such as the
MagicDNS name, acceptance-test peer, service port and requested UFW services.
It prints a summary and defaults the final confirmation to `No`. Parameter mode
remains available for future Ansible, CI or remote-execution workflows.

Passwords remain outside the scripts. The operating system handles
administrator authentication, Tailscale uses its official browser, and Samba
credentials are managed separately. One-time Tailscale browser-authentication
URLs are shown only on the terminal and deliberately excluded from log files.

A public GitHub repository is used for stage-one download because a new client
cannot reach a private tailnet file server before enrollment. Browser login is
the default. Optional auth keys are read from protected files, never committed
or written directly into command history.

## Automation Acceptance Test — 2026-08-19

The same automation was then exercised on all three operating systems instead
of being accepted from static review alone.

- macOS check-only mode identified `macbook-admin`, reached
  `linux01-server` and passed the TCP 445 application-path test;
- Ubuntu check-only mode confirmed `tailscaled` as enabled and active, listed
  all three tailnet nodes and reached `macbook-admin` without changing state;
- the UFW helper found the existing Mac SSH/SMB and Windows SMB rules and did
  not create duplicates;
- Windows PowerShell parsed the script without errors, reached
  `linux01-server`, and reported `TcpTestSucceeded : True` for port 445;
- the Windows wizard was first cancelled at its final `[y/N]` gate and reported
  that no changes were made;
- a second Windows wizard run was approved, preserved the Windows computer
  name, applied the Tailscale identity `nova-ws01`, enabled unattended operation
  and completed its acceptance checks successfully.

The tests also demonstrated an important naming boundary: `linux01-lab` is a
client-side alias stored in the Mac's SSH configuration, while
`linux01-server` is the shared MagicDNS identity that Windows and other
tailnet devices can resolve.

Some peer tests used `DERP(par)` or `DERP(fra)`. This was recorded as a
performance observation rather than a service failure because traffic remained
encrypted and the end-to-end SSH/SMB checks succeeded.

---

## Commands Practised

```text
tailscale version
tailscale status
tailscale ip -4
tailscale ping linux01-server
systemctl is-enabled tailscaled
systemctl is-active tailscaled
sudo ufw status numbered
sudo ufw allow in on tailscale0 from CLIENT_IP to any port 22 proto tcp
sudo ufw allow in on tailscale0 from CLIENT_IP to any port 445 proto tcp
Test-NetConnection -ComputerName linux01-server -Port 445
net use \\linux01-server\company /user:linux01 * /persistent:no
```

---

## Next Session

1. Review the automation line by line.
2. Run every check-only mode against the current systems.
3. Test a real bootstrap using a fresh VM snapshot.
4. Commit and publish the verified automation.
5. Begin file-server backup and restore design.
