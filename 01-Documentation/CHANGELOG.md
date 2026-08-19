# Changelog

This file records delivered outcomes. Investigation detail belongs in the
[Engineering Journal](./Engineering-Journal.md).

## 2026-08-19 — Automation Published and Accepted

- Added idempotent Ubuntu, macOS and Windows Tailscale bootstrap scripts.
- Added exact, duplicate-safe Ubuntu UFW client authorization.
- Added interactive wizards, parameter mode and check-only validation.
- Kept passwords, raw auth keys and one-time browser URLs out of logs/source.
- Passed current-node tests on all three platforms, including Windows safe
  cancellation and a confirmed run with TCP 445 verification.
- Published and merged the verified automation through pull request #1.

Pending: first-time installation tests on clean VM snapshots.

## 2026-08-18 — Stable Cross-Platform Overlay

- Joined `macbook-admin`, `linux01-server` and `nova-ws01` to one tailnet.
- Replaced changing UTM/upstream addresses with MagicDNS identities.
- Verified macOS SSH and authenticated macOS/Windows SMB over Tailscale.
- Replaced temporary subnet rules with three exact `tailscale0` UFW rules.
- Verified Tailscale, SSH, Samba, UFW and LVM persistence after reboot.
- Recorded DERP relay use as a performance observation, not a service outage.

## 2026-08-14 to 2026-08-15 — Samba File-Server Role

- Created a 10 GiB LVM logical volume and ext4 filesystem for service data.
- Mounted it persistently at `/srv/samba` using filesystem UUID.
- Created the `fileshare` group and setgid-controlled `company` directory.
- Deployed an authenticated Samba 4.19 standalone share.
- Disabled guest access, printing, spoolss and guest usershares.
- Enabled UFW with a recovery-safe default-deny rollout.
- Passed macOS SMB read/write and controlled reboot acceptance tests.

## 2026-08-10 — Linux Baseline and Verified SSH

- Recorded Ubuntu OS, kernel, network, memory, disk and LVM baseline.
- Applied package maintenance and verified the active kernel and failed units.
- Investigated systemd SSH socket activation.
- Compared the server ED25519 host fingerprint before trusting it.
- Installed a dedicated client public key and proved public-key-only login.
- Diagnosed an invalid username and malformed `authorized_keys` from logs and
  format-aware checks.

## 2026-08-08 — Ubuntu Server Deployment

- Deployed Ubuntu Server 24.04 LTS ARM64 in UTM.
- Installed OpenSSH Server.
- Verified IPv4 connectivity, DNS resolution and available updates.

## 2026-08-03 — Windows Administration Foundation

- Deployed Windows 11 Pro ARM64 and installed VirtIO drivers.
- Explored services, Registry configuration and Windows directory roles.
- Ran CPU, memory, disk and network experiments in Resource Monitor.
- Distinguished administrative membership from an elevated process.
