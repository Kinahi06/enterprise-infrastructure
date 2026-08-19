# Documentation Index

This directory separates concise portfolio evidence from detailed operational
references. The project overview is available in the
[repository README](../README.md).

Last updated: 2026-08-19

## Five-Minute Reading Path

1. [Infrastructure Plan](./Infrastructure-Plan.md) — current architecture,
   security controls and roadmap.
2. [Progress](./Progress.md) — completed milestones and next work.
3. [Skill Matrix](./Skill-Matrix.md) — skills linked to practical evidence.
4. [Automation](../02-Automation/README.md) — repeatable Tailscale deployment
   and acceptance criteria.

## Detailed Evidence

- [Engineering Journal](./Engineering-Journal.md) — six laboratory summaries,
  incidents, resolutions and verification.
- [Changelog](./CHANGELOG.md) — compact chronological record of delivered
  changes.

## Operational References

- [Linux Administration Runbook](./Linux-Cheatsheet.md)
- [Windows Administration Runbook](./Windows-Cheatsheet.md)

The runbooks are intentionally comprehensive and are not part of the short
portfolio reading path.

## Current Lab

| System | Platform | Role | State |
|---|---|---|---|
| `macbook-admin` | macOS | Administration and SMB client | Operational |
| `nova-ws01` | Windows 11 Pro ARM64 | Windows administration and SMB client | Operational |
| `linux01-server` | Ubuntu Server 24.04 LTS ARM64 | SSH and authenticated Samba server | Operational |

The systems communicate through Tailscale MagicDNS. Ubuntu uses a default-deny
UFW policy with three exact inbound rules: Mac SSH, Mac SMB and Windows SMB.

## Documentation Standard

Every completed change should record:

1. purpose and expected result;
2. relevant implementation decision;
3. verification evidence;
4. incident cause and resolution, when applicable;
5. security or rollback considerations.

Passwords, passphrases, private keys, auth tokens and recovery secrets are
excluded from the repository.
