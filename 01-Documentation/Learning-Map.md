# Learning Map

**English** | [Русский](Learning-Map.ru.md)

Updated: 29 September 2026. This page separates **curriculum modules**, **lab
sessions** and **earlier homelab lessons**, which use different numbering.
Completing Session 11 does not mean completing Module 11. Passing a lab also
does not imply independent mastery of the entire subject.

## Foundation lessons — August 2026

| Lesson | Practical work | Record |
|---|---|---|
| Lesson 1 — Windows infrastructure | Windows 11 ARM on UTM, VirtIO, Resource Monitor, services, Registry and system layout | [Journal](Engeniering%20Journal.md#lesson-1--windows-infrastructure-lab) |
| Lesson 2 — Review | Reflection on the first lesson and questions for further study; not a separate practical assessment | [Journal](Engeniering%20Journal.md#lesson-2) |
| Lesson 3 — Ubuntu deployment | Ubuntu Server ARM64 installation, basic networking and DNS verification | [Journal](Engeniering%20Journal.md#lesson-3--ubuntu-server-deployment) |
| Lesson 4 — Baseline and SSH | OS health, APT, systemd/socket activation, SSH and ED25519, access verification from macOS | [Journal](Engeniering%20Journal.md#lesson-4--ubuntu-server-baseline-and-ssh) |
| Lesson 5 — LVM and Samba | Dedicated volume, ext4/fstab, group permissions and setgid, SMB, UFW and post-reboot verification | [Journal](Engeniering%20Journal.md#lesson-5--lvm-backed-samba-file-server) |
| Lesson 6 — Tailscale and automation | Ubuntu/macOS/Windows connectivity, MagicDNS, client-scoped UFW rules, SMB, DERP and assisted Bash/PowerShell automation | [Journal](Engeniering%20Journal.md#lesson-6--cross-platform-tailscale-administration) |

## Lab sessions — September 2026

| Session | Topic and outcome | Status |
|---|---|---|
| 01 — Broken Web Stack | Prepared Docker Compose environment | Learner completion not confirmed; not counted as completed |
| 02 — Service permissions | Service-account access to application code; process/socket/HTTP verification | Completed |
| 03 — Runtime environment | Located an invalid PORT value using the journal and EnvironmentFile | Completed with guidance |
| 04 — Remote API | Local versus remote reachability, bind address and verification from macOS | Completed with guidance |
| 05 — Dependencies | After versus Requires, drop-ins, effective dependencies and end-to-end health | Completed with dependency-model explanations |
| 06 — Filesystem resources | Inode exhaustion despite free bytes; scoped stale-cache cleanup and worker recovery | Completed; seven PASS results shown |
| 07 — Linux gate | Two successive faults: permissions and an occupied port; PID-to-unit attribution and revalidation | Completed; 11 PASS results recorded |
| 08 — Name resolution | Hosts entry did not match the listener; getent, ss and the original client URL | Completed with guidance; all PASS results learner-reported |
| 09 — TCP errors | Inactive service/no listener versus packet DROP; recovered both endpoints | Guided practical work completed; oral assessment pending |
| 10 — HTTP 502 | Incorrect upstream port; minimal correction and proxy-only restart | Practical work and oral assessment completed with guidance; PASS learner-reported |
| 11 — HTTP contract | HTTP 200 from an old version; routed the proxy to the required backend and checked the response version | Cause identified independently; completed with acceptance-test clarification, PASS learner-reported |
| 12 — TLS | CA trust, certificate hostname and HTTPS verification without bypassing security checks | Prepared; learner completion not confirmed |

Details: [journal](Engeniering%20Journal.md), [progress](Progress.md) and
[skills by topic](Skills-Overview.md). Lab preparation and tutor-run tests do
not count as learner practice. The Session 09 recheck confirmed the endpoints
but did not rerun the complete root-only checker.

## Curriculum modules — full roadmap

| No. | Module | Current status |
|---|---|---|
| 0 | Entry assessment and the overall DevOps system model | Partial theory assessment; not completed |
| 1 | Linux internals: processes, memory, I/O, filesystems, systemd | Practical refresh and Linux gate completed; not a claim of mastery of all internals |
| 2 | Networking: L2–L7, DNS, TCP, routing/NAT, HTTP, proxies, TLS | In progress: Sessions 08–11, with Session 12 prepared next; module not yet completed |
| 3 | Containers: namespaces, cgroups, images, storage and networking | After networking; entry assessment identified learning needs, practical assessment not passed |
| 4 | CI/CD: pipelines, artifacts, promotion and rollback | Planned; initial theory assessment only |
| 5 | Ansible and Terraform: idempotence, drift, state and locking | Planned; practical assessment not passed |
| 6 | Cloud: IAM, VPC, load balancing, storage, resilience and cost | Planned; not assessed |
| 7 | Kubernetes architecture: API, reconciliation, scheduler and kubelet | Planned; not assessed |
| 8 | Kubernetes operations: networking, storage, probes, rollout and RBAC | Planned; not assessed |
| 9 | Databases and queues: PostgreSQL, restore, Redis and queue semantics | Planned; not assessed |
| 10 | Observability and reliability: metrics/logs/traces, SLI/SLO and alerts | Planned; not assessed |
| 11 | Security: identity, least privilege, secrets, TLS and supply chain | Selected fundamentals used in the homelab; full module not completed |
| 12 | GitOps and a final end-to-end incident | Planned; not assessed |

This is a learning roadmap, not a list of qualifications. The older calendar-based
Windows/AD/GPO plan remains an optional direction rather than the current course
sequence. Professional profiles should describe demonstrated homelab work, not
present planned topics as mastered technologies or commercial experience.
