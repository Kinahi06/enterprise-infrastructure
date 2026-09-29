# Infrastructure Engineering Lab — Documentation

Personal learning laboratory for infrastructure deployment, troubleshooting and documentation.

Last updated: 2026-09-29

## Current Progress

- Linux service-diagnostics sprint completed, including permissions, systemd dependencies, inode exhaustion and port conflicts.
- Session 09: TCP recovery completed with guidance; oral defence remains pending.
- Session 10: reverse-proxy HTTP 502 incident and oral defence completed with guidance.
- Session 11: old-backend routing identified independently; repair credited, with acceptance-test and payload-validation support.
- Session 12: HTTPS/TLS lab prepared; learner completion is not confirmed.

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
- Current focus: HTTPS verification, followed by Docker.

## Documentation

- [Repository overview](../README.md)
- [Skills by topic / Навыки по темам](./Skills-Overview.md)
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
