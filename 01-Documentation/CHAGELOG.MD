# Changelog

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
