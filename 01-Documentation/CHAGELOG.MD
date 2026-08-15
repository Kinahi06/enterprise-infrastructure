# Changelog

## 2026-08-14 to 2026-08-15 — First Linux Server Role: Samba File Server

### Added

- Reusable macOS SSH client alias `linux01-lab`
- 10 GiB LVM logical volume named `files`
- ext4 filesystem labelled `files`
- Persistent mount at `/srv/samba` through `/etc/fstab`
- Unix group `fileshare` and setgid-controlled `company` directory
- Samba 4.19 standalone file-server role
- Authenticated SMB share named `company`
- Dedicated Samba credentials for the existing Linux account `linux01`

### Completed

- Applied the available `linux-firmware` upgrade and respected Ubuntu phased updates
- Verified that no reboot or service restart was required after maintenance
- Created, formatted, mounted and remounted the service-data logical volume
- Proved that `mount -a` restores the mount from `/etc/fstab`
- Verified Linux group inheritance and write access without `sudo`
- Validated `smb.conf` with `testparm`
- Verified `smbd` on TCP ports 139 and 445
- Connected from macOS and performed a two-way SMB file test

### Pending

- Stage, review and enable UFW rules for SSH and SMB from `192.168.64.0/24`
- Remove unused Samba printer shares
- Perform controlled reboot and post-reboot acceptance tests
- Test access from Windows

### Security

- Guest access to `company` is disabled
- Access is restricted to members of `fileshare`
- No passwords, key passphrases, private keys or recovery secrets were documented

## 2026-08-10 — Ubuntu Baseline and Verified SSH Administration

### Added

- Linux and Windows administration cheat sheets
- Ubuntu Server baseline covering OS, kernel, network, memory, storage and LVM
- SSH host-key fingerprint verification procedure
- Live systemd socket-activation investigation
- ED25519 client key dedicated to the laboratory
- SSH public-key authentication and `authorized_keys` validation
- Active-session and authentication-log investigation notes

### Completed

- Applied available Ubuntu package upgrades
- Rebooted and verified kernel, uptime and failed units
- Confirmed `ssh.socket` listening on TCP port 22
- Established the first verified SSH connection from macOS
- Confirmed public-key-only login without password fallback
- Documented restrictive permissions for `.ssh` and `authorized_keys`

### Incidents Investigated

- Distinguished command-name, option and file-path typing errors
- Diagnosed rejected SSH authentication as an incorrect username
- Used SSH logs to confirm `Invalid user`, successful authentication and session creation
- Repaired missing and malformed `authorized_keys` content
- Distinguished shell command execution from text entered in `nano`

### Documentation

- Updated the engineering journal, progress timeline, skill matrix and infrastructure plan
- Added current-system inventory and next-session objectives
- Confirmed that no passwords, passphrases or private keys are stored in the repository

## 2026-08-08 — Ubuntu Server Deployment

### Added

- Ubuntu Server 24.04 LTS ARM64 virtual machine
- OpenSSH Server
- Linux infrastructure laboratory environment

### Completed

- Deployed the first Ubuntu Server
- Verified IPv4 connectivity
- Verified DNS name resolution
- Reviewed available system package updates

## 2026-08-03 — Windows Administration Foundation

### Added

- Windows 11 Pro ARM64 laboratory
- VirtIO Guest Tools and drivers
- Windows Services and Service Control Manager study
- Registry-based service configuration analysis
- Resource Monitor experiments

### Completed

- Investigated Windows directory structure and WinSxS
- Diagnosed missing VirtIO network drivers
- Practised elevated PowerShell and Windows diagnostic tools
- Investigated `LanmanServer` and unnecessary Xbox services
