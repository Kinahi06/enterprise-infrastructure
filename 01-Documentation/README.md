# Infrastructure Engineering Lab

Personal laboratory for learning infrastructure engineering through deployment, inspection, troubleshooting and documentation.

Last updated: 2026-08-18

## Goals

- Learn Windows and Linux administration
- Understand networking and virtualization
- Build reproducible infrastructure
- Diagnose systems using evidence instead of assumptions
- Develop PowerShell, Bash, Git and automation skills
- Maintain portfolio-quality engineering documentation

## Current Progress

| Metric | Value |
|--------|------:|
| Lessons completed | 6 |
| Incidents documented | 11 |
| Scripts written | 4 |
| Commands practised | 90+ |
| Time invested | ~20+ hours |

## Current Systems

| System | Platform | Status | Current purpose |
|--------|----------|--------|-----------------|
| `nova-ws01` | Windows 11 Pro ARM64, UTM | Running | Windows client and administration laboratory |
| `linux01-server` | Ubuntu Server 24.04.4 LTS ARM64 | Running | Authenticated Samba file server |
| `macbook-admin` | macOS | Running | Administrative workstation |

## Current Module

Cross-platform remote administration and file services over a Tailscale overlay network.

Completed in the current module:

- Reusable macOS SSH alias `linux01-lab`
- Dedicated 10 GiB LVM logical volume for service data
- Persistent ext4 mount at `/srv/samba`
- Group-based Linux permissions with setgid inheritance
- Samba 4.19 standalone file server
- Authenticated `company` share
- Successful macOS SMB read/write test
- Tailscale installed on Ubuntu, macOS and Windows
- MagicDNS names `linux01-server`, `macbook-admin` and `nova-ws01`
- SSH administration over the encrypted tailnet
- Authenticated SMB read/write tests from macOS and Windows
- UFW default-deny policy with exact client, interface and service rules
- Unused Samba printing services disabled
- Successful post-reboot verification of Tailscale, SSH, Samba and LVM storage
- Idempotent Bash and PowerShell bootstrap automation

Next:

- Test automation against fresh VM snapshots
- Design and perform a backup-and-restore exercise
- Investigate direct versus DERP-relayed Tailscale paths

## Documentation

- [Engineering Journal](./Engeniering%20Journal.md)
- [Progress Timeline](./Progress.md)
- [Skill Matrix](./Skill%20Matrix.md)
- [Infrastructure Plan](./Infrastructure-Plan.md)
- [Linux Administration Cheat Sheet](./Linux-Cheatsheet.md)
- [Windows Administration Cheat Sheet](./Windows-Cheatsheet.md)
- [Changelog](./CHAGELOG.MD)
- [Tailscale Automation](../02-Automation/README.md)

## Security Rule

The repository may contain public-key fingerprints and public keys when needed for documentation. Passwords, passphrases, private keys, tokens and recovery secrets must never be committed.
