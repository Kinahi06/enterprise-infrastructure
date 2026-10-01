# Infrastructure Engineering Lab — Documentation

Personal learning laboratory for infrastructure deployment, troubleshooting and documentation.

Last updated: 2026-10-01

## Current Progress

- Linux service-diagnostics sprint completed, including permissions, systemd dependencies, inode exhaustion and port conflicts.
- Session 08: local name-to-IP mapping corrected with guidance; all checker PASS learner-reported.
- Session 09: TCP recovery completed with guidance; oral defence remains pending.
- Session 10: reverse-proxy HTTP 502 incident and oral defence completed with guidance.
- Session 11: old-backend routing identified independently; repair credited, with acceptance-test and payload-validation support.
- Session 12: I completed TLS with guidance; verified HTTPS screenshot, checker PASS reported by me.
- Session 13: I completed the first Docker deployment and stop/start exercise with guidance.
- Current: I am practising user/group separation; ops permissions remain undecided.

The progress timeline records evidence limits. Prepared materials, assisted work
and independent diagnosis are distinguished rather than counted as equivalent.

## Lab Platforms

| Platform | Role in the laboratory |
|---|---|
| Windows 11 Pro ARM64 / UTM | Windows administration and SMB client practice |
| Ubuntu Server 24.04 LTS ARM64 / UTM | Linux services, Samba, storage and network incidents |
| macOS | Administrative workstation and SSH/SMB client |

This describes the lab design, not a live availability check.

## Project Areas

- ED25519 SSH access and reusable client configuration.
- LVM-backed ext4 storage, persistent mounts and group-controlled Samba access.
- Tailscale/MagicDNS networking and client-scoped UFW policies.
- Cross-platform Bash/PowerShell bootstrap automation with check-only modes.
- Process, socket, HTTP and configuration evidence in incident diagnosis.
- Current focus: users/groups and scoped service access; backup and monitoring study is planned, not implemented.

## Documentation

- [Study notes and current ticket](./Study-Notes/README.md)
- [Engineering Work Templates](../03-Templates/README.md)

- [Repository overview](../README.md)
- Full learning map: [English](./Learning-Map.md) · [Русский](./Learning-Map.ru.md)
- Skills by topic: [English](./Skills-Overview.md) · [Русский](./Skills-Overview.ru.md)
- [Progress Timeline](./Progress.md)
- [Engineering Journal](./Engeniering%20Journal.md)
- [Skill Matrix](./Skill%20Matrix.md)
- [Infrastructure Plan](./Infrastructure-Plan.md)
- [Linux Troubleshooting Cheat Sheet](./Linux-Troubleshooting-Cheatsheet.md)
- [Linux Troubleshooting PDF](./Linux-Troubleshooting-Cheatsheet.pdf)
- [Linux Administration Cheat Sheet](./Linux-Cheatsheet.md)
- [Windows Administration Cheat Sheet](./Windows-Cheatsheet.md)
- [Historical Changelog](./CHAGELOG.MD)
- [Tailscale Automation](../02-Automation/README.md)

## Scope and Security

This is educational homelab experience, not commercial production experience.
Documentation and automation include assisted work. Passwords, private keys,
tokens and recovery secrets must never be committed.
