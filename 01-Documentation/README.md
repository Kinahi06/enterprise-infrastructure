# Infrastructure Engineering Lab

Personal laboratory for learning infrastructure engineering through deployment, inspection, troubleshooting and documentation.

Last updated: 2026-08-10

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
| Incidents documented | 7 |
| Scripts written | 0 |
| Commands practised | 40+ |
| Time invested | ~12 hours |

## Current Systems

| System | Platform | Status | Current purpose |
|--------|----------|--------|-----------------|
| Windows 11 Pro ARM64 VM | UTM | Running | Windows administration laboratory |
| `linux01` | Ubuntu Server 24.04.4 LTS ARM64 | Running | Linux administration and SSH laboratory |

## Current Module

Remote Linux administration over SSH.

Completed in the current module:

- Ubuntu baseline and resource inspection
- APT upgrade and post-maintenance verification
- Disk, filesystem and LVM analysis
- systemd service and socket activation analysis
- Verified SSH host identity
- Password and ED25519 public-key authentication
- SSH authentication-log troubleshooting

Next:

- Create a macOS SSH client profile for `linux01`
- Decide the first server role before installing role-specific software
- Review firewall state and SSH hardening with a recovery plan

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
