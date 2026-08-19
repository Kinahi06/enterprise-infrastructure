# Changelog

## 2026-08-18 to 2026-08-19 — Tailscale Overlay Network and Bootstrap Automation

### Added

- Tailscale nodes `macbook-admin`, `linux01-server` and `nova-ws01`
- Stable MagicDNS access independent of changing UTM or upstream subnets
- Exact UFW rules on `tailscale0` for Mac SSH/SMB and Windows SMB
- Ubuntu, macOS and Windows Tailscale bootstrap scripts
- Idempotent Ubuntu UFW client-authorization helper
- Check-only modes, installer checksum validation and local deployment logs
- Interactive setup questions, validation and final `[y/N]` confirmation

### Completed

- Verified SSH from macOS to Ubuntu over Tailscale
- Verified authenticated SMB read/write from macOS and Windows
- Diagnosed Windows elevated-session SMB authentication instead of enabling guest access
- Removed obsolete local-subnet UFW rules without interrupting remote access
- Rebooted Ubuntu and verified Tailscale, SSH, Samba and LVM persistence
- Identified Windows traffic using a DERP relay while application tests still passed
- Passed the macOS bootstrap's local check-only validation; offline-peer detection also failed safely
- Verified Linux and macOS wizard cancellation without changing either system
- Passed Ubuntu bootstrap and exact UFW client-rule checks without changes
- Passed Windows PowerShell parsing and bootstrap check-only validation
- Verified Windows wizard cancellation before applying the confirmed configuration
- Applied the Windows wizard successfully and revalidated MagicDNS, Tailscale ping and TCP 445

### Security

- Incoming services are limited by interface, exact Tailscale source and port
- Browser authentication is the automation default
- Optional auth keys are read from protected files and never embedded in source
- One-time browser-authentication URLs are displayed only on screen and excluded from logs
- Published scripts contain no passwords, private keys, tokens or recovery secrets

### Pending

- Test every bootstrap against a fresh VM snapshot
- Investigate a direct Windows-to-Ubuntu Tailscale path
- Design and test file-server backup and restore

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
- Enabled UFW with default-deny incoming policy
- Restricted SSH and SMB to `192.168.64.0/24`
- Verified new SSH and SMB connections after firewall activation
- Confirmed TCP 139 is blocked while TCP 22 and 445 remain reachable
- Disabled Samba printer loading, spoolss and guest usershares
- Disabled the explicit `printers` and `print$` resources
- Rebooted and verified SSH, UFW, Samba, the LVM mount and stored data

### Pending

- Test access from Windows
- Design and test backup and restore

### Security

- Guest access to `company` is disabled
- Access is restricted to members of `fileshare`
- UFW permits only TCP 22 and TCP 445 from the laboratory subnet
- Legacy TCP 139 is blocked by the firewall
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
