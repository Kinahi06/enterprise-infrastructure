# Infrastructure Engineering Lab

Personal homelab and learning portfolio: Linux and Windows administration,
networking, service troubleshooting and introductory automation on Apple Silicon.

**Last updated: 2026-09-29 · Latest completed exercise: INC-011**

## Start here

- [Skills by topic / Навыки по темам](01-Documentation/Skills-Overview.md)
- [Full learning map / Все занятия и модули](01-Documentation/Learning-Map.md)
- [Learning progress](01-Documentation/Progress.md)
- [Engineering journal and incident write-ups](01-Documentation/Engeniering%20Journal.md)
- [Skill matrix and assessment limits](01-Documentation/Skill%20Matrix.md)
- [Linux troubleshooting cheat sheet](01-Documentation/Linux-Troubleshooting-Cheatsheet.md)
- [Cross-platform Tailscale automation](02-Automation/README.md)

## Laboratory progress — full session index

Session numbers below refer to exercises, not entire curriculum modules.
Earlier Windows, Ubuntu, storage and Tailscale lessons are listed separately in
the [full learning map](01-Documentation/Learning-Map.md).

| Area | Result |
|---|---|
| Lab 01: Broken Web Stack | Prepared exercise; learner completion is not confirmed |
| INC-002: Service permissions | Completed: service-account access to application code, process/socket/HTTP verification |
| INC-003: Runtime configuration | Completed with guidance: invalid environment value located and corrected |
| INC-004: Remote API | Completed with guidance: local-only bind diagnosed; remote client access verified |
| INC-005: Service dependency | Completed with guidance: ordering versus required dependency, effective unit graph verified |
| INC-006: Inode exhaustion | Completed: free bytes distinguished from free inodes, scoped stale-file cleanup and service recovery |
| INC-007: Linux diagnostic gate | Completed: permissions and port conflict; final 11 checks passing |
| INC-008: Name resolution | Completed with guidance: local hosts mapping corrected to match the listener; all PASS learner-reported |
| INC-009: TCP failures | Recovered refused/timeout scenarios with guidance; oral defence remains pending |
| INC-010: HTTP 502 | Corrected a reverse-proxy upstream mismatch; practical work and oral defence completed with guidance |
| INC-011: HTTP contract | Independently identified routing to an old backend version; corrected the route, reported all checker checks passing, completed defence with a payload-validation clarification |
| INC-012: TLS | Lab and learning material prepared; learner completion is not yet confirmed |

See the [engineering journal](01-Documentation/Engeniering%20Journal.md) for
incident details and the [progress log](01-Documentation/Progress.md) for evidence
limits. The full course roadmap, including future modules, is in the
[learning map](01-Documentation/Learning-Map.md); planned topics are not completed skills.

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
