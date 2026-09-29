# Infrastructure Engineering Lab

Personal homelab and learning portfolio: Linux and Windows administration,
networking, service troubleshooting and introductory automation on Apple Silicon.

**Last updated: 2026-09-29 · Latest completed exercise: INC-011**

## Start here

- [Skills by topic / Навыки по темам](01-Documentation/Skills-Overview.md)
- [Learning progress](01-Documentation/Progress.md)
- [Engineering journal and incident write-ups](01-Documentation/Engeniering%20Journal.md)
- [Skill matrix and assessment limits](01-Documentation/Skill%20Matrix.md)
- [Linux troubleshooting cheat sheet](01-Documentation/Linux-Troubleshooting-Cheatsheet.md)
- [Cross-platform Tailscale automation](02-Automation/README.md)

## Latest progress

| Area | Result |
|---|---|
| Linux service diagnostics | Completed incidents involving permissions, runtime configuration, dependencies, inode exhaustion and port conflicts |
| INC-009: TCP failures | Recovered refused/timeout scenarios with guidance; oral defence remains pending |
| INC-010: HTTP 502 | Corrected a reverse-proxy upstream mismatch; practical work and oral defence completed with guidance |
| INC-011: HTTP contract | Independently identified routing to an old backend version; corrected the route, reported all checker checks passing, completed defence with a payload-validation clarification |
| INC-012: TLS | Lab and learning material prepared; learner completion is not yet confirmed |

## Lab environment and project work

- UTM virtual machines: Ubuntu Server ARM64 and Windows 11 Pro ARM64, administered from macOS.
- OpenSSH key-based access, LVM-backed Samba storage and cross-platform SMB acceptance tests.
- Tailscale/MagicDNS connectivity and client-scoped UFW rules.
- Bash and PowerShell bootstrap scripts with check-only modes and conservative confirmation steps.
- Evidence-based incident notes: symptom, hypothesis, observation, minimal change and client-path verification.

## Scope and evidence

This is a personal learning project, not a record of commercial production work.
Exercises include guided learning and independent diagnostic steps; documentation
and automation were developed with assistance. Each report distinguishes observed
evidence from learner-reported results. Prepared labs and tutor-run tests are not
counted as completed learner exercises.

Next: HTTPS/TLS fundamentals, then Docker. Secrets and private keys are not part
of this repository. [Documentation index](01-Documentation/README.md).
