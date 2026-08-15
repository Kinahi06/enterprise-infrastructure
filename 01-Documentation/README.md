# Infrastructure Engineering Lab

Personal laboratory for learning infrastructure engineering through deployment, inspection, troubleshooting and documentation.

Last updated: 2026-08-15

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
| Lessons completed | 4 |
| Current lesson | 5 — file-server hardening in progress |
| Incidents documented | 7 |
| Scripts written | 0 |
| Commands practised | 70+ |
| Time invested | ~16+ hours |

## Current Systems

| System | Platform | Status | Current purpose |
|--------|----------|--------|-----------------|
| Windows 11 Pro ARM64 VM | UTM | Running | Windows administration laboratory |
| `linux01` | Ubuntu Server 24.04.4 LTS ARM64 | Running | Authenticated Samba file server laboratory |

## Current Module

Linux file-server deployment over verified SSH administration.

Completed in the current module:

- Reusable macOS SSH alias `linux01-lab`
- Dedicated 10 GiB LVM logical volume for service data
- Persistent ext4 mount at `/srv/samba`
- Group-based Linux permissions with setgid inheritance
- Samba 4.19 standalone file server
- Authenticated `company` share
- Successful macOS SMB read/write test

Next:

- Review and enable subnet-restricted UFW rules without losing SSH
- Remove unused printer-sharing configuration
- Verify SSH, storage and Samba after a controlled reboot
- Test the share from the Windows laboratory

## Documentation

- [Engineering Journal](./Engeniering%20Journal.md)
- [Progress Timeline](./Progress.md)
- [Skill Matrix](./Skill%20Matrix.md)
- [Infrastructure Plan](./Infrastructure-Plan.md)
- [Linux Administration Cheat Sheet](./Linux-Cheatsheet.md)
- [Windows Administration Cheat Sheet](./Windows-Cheatsheet.md)
- [Changelog](./CHAGELOG.MD)

## Security Rule

The repository may contain public-key fingerprints and public keys when needed for documentation. Passwords, passphrases, private keys, tokens and recovery secrets must never be committed.
