# Skills and Learning Experience — Topic Overview

**English** | [Русский](Skills-Overview.ru.md)

[All lessons, lab sessions and future curriculum modules](Learning-Map.md).

Updated **1 October 2026**. One bullet per topic, based on published repository
documentation, course reports and exercises completed during tutoring sessions.

## Scope of experience

Personal infrastructure homelab and training, not commercial production
experience. Some work was tutor/AI-assisted; independent diagnostic steps are
identified separately. Planned technologies are not counted as acquired skills.
No professional tenure or earned certifications are claimed here.

## Linux and system administration

- **Ubuntu Server:** I deployed Ubuntu Server 24.04 LTS ARM64 in UTM and performed initial OS, resource, network and service checks.
- **Packages and maintenance:** I used APT, distinguished package metadata refresh from package upgrades, and verified the system after reboot.
- **systemd:** I inspected status and unit files, started/stopped/restarted services, distinguished active/inactive/failed from enabled/disabled, and explored socket activation.
- **Process diagnostics:** I correlated MainPID, processes, occupied ports and systemd services to resolve listener conflicts.
- **Logs:** I investigated failures using journalctl and current-process messages rather than assuming an active process was healthy.
- **Runtime configuration:** I located EnvironmentFile and application settings, corrected addresses/ports without changing application code, and distinguished restart from daemon-reload.
- **systemd dependencies:** I practised After=, Requires= and drop-ins, checking startup order and effective configuration with explanations from the tutor.
- **Permissions:** I used users/groups, chown/chmod and file/directory read, write and traversal permissions; tested access as the service account.
- **Least privilege:** I separated writable application data from code, using group permissions and setgid inheritance in the file-service lab.
- **Filesystems:** I distinguished free bytes from free inodes, diagnosed ENOSPC caused by inode exhaustion, and previewed scoped file selections before deletion.
- **Storage and LVM:** I created a dedicated logical volume, ext4 filesystem and persistent fstab mount in the lab, with post-reboot verification.

## Networking, remote access and HTTP

- **IPv4 and virtual networks:** I checked IP addresses, local subnets, loopback, bind addresses and reachability between virtual machines and macOS.
- **Name resolution:** I used getent, local hosts entries and MagicDNS to diagnose a name resolving to the wrong service address.
- **TCP and sockets:** I used port filters in ss, interpreted LISTEN/address/port/PID, and diagnosed missing listeners and port conflicts.
- **Connection refusal versus timeout:** I distinguished immediate connection failure from timeout; identified filtering despite an active listener with guidance.
- **OpenSSH:** I established macOS-to-Linux access using ED25519 keys, host fingerprint checks, authorized_keys, file permissions and a client SSH alias.
- **Tailscale:** I deployed and verified Ubuntu/macOS/Windows overlay connectivity, MagicDNS, SSH and SMB over the tailnet.
- **Network path and latency:** I explored direct connections versus DERP relay and their relationship to SSH latency; independent VPN optimization expertise is not claimed.
- **UFW:** I configured lab restrictions by interface, exact client address and service while preserving an SSH recovery path.
- **nftables:** I gained introductory experience reading tables, chains, conditions and drop counters; removed only an isolated lab filter after a tool walkthrough.
- **HTTP diagnostics:** I used curl, status codes and response bodies to distinguish a running process, TCP reachability and a successful client scenario.
- **Reverse proxies:** I traced client → proxy → API, compared UPSTREAM with the actual listener, and resolved HTTP 502 with a targeted component restart.
- **API version routing:** I independently identified requests reaching an old v1 backend instead of v2 from three service logs and corrected the upstream.
- **API contract validation:** I practised checking the expected JSON version and data through the original client endpoint; body validation beyond status/port remains a guided reinforcement topic.

- **TLS/HTTPS:** I completed a guided certificate-name repair, inspected validity/SAN, used the correct certificate/key pair and showed verified HTTPS without -k; checker PASS reported by me.
- **Docker basics:** I launched nginx:1.30.5-alpine as s18-web, checked loopback publication, HTTP/logs and stop/start of the same ID; final stop is unconfirmed.
- **User separation:** I created dev/view/ops and lab, tested /srv/team dev:lab 2750, allowed dev and denied view; ops privileges and individual SSH access remain pending.

## Windows, virtualization and file services

- **UTM / Apple Silicon:** I deployed Windows 11 Pro ARM64 and Ubuntu Server ARM64, configured virtual resources and installed VirtIO Guest Tools.
- **Windows fundamentals:** I explored winver, msinfo32, Device Manager, Disk Management, Task Manager and Resource Monitor.
- **Windows Services and Registry:** I performed basic service inspection/management and explored system directories and the Registry; full Windows Server administration competence is not claimed.
- **Windows resource diagnostics:** I observed CPU, RAM, disk and network activity through Resource Monitor exercises.
- **Samba / SMB:** I deployed an authenticated Linux file server with group-based access and verified read/write access from macOS and Windows.
- **File-service security:** disabled unnecessary printer/guest features, restricted network access and rechecked the service after reboot.

## Terminal and working tools

- **Shell / Bash / zsh:** I used commands, arguments, paths, pipes, grep/find/head/wc and sudo in daily exercises; complex scripts still require support.
- **Vim:** I practised opening, editing, saving and exiting; editor modes and safe selection of the intended configuration file are still being reinforced.
- **tmux:** I used persistent sessions and panes, switching and resizing; configuration was prepared with assistance.
- **Terminal tooling:** I used zsh-autosuggestions, syntax highlighting, completions, fzf and btop; setup and troubleshooting were assisted.

## Automation, Git and documentation

- **Assisted Bash/PowerShell project work:** the repository contains four Tailscale/UFW bootstrap and authorization scripts; independent implementation from scratch has not been demonstrated.
- **Safe automation execution:** I explored check-only modes, repeat runs without duplicating correct settings, logging and interactive confirmation of changes.
- **Automation validation:** the journal records Ubuntu/macOS/Windows checks and Windows wizard execution; full bootstrap on fresh VMs remains unvalidated.
- **Git/GitHub:** I maintained a learning portfolio and gained exposure to branches, commits and publishing; recent commit/push operations were performed by the AI assistant, and advanced merge/rebase/recovery skills are not confirmed.
- **Secret handling:** I separated public and private keys and excluded passwords/tokens from repository content and logs in lab workflows.
- **Engineering documentation:** I recorded incident symptoms, hypotheses, causes, changes and acceptance checks, with a progress journal and Linux cheat sheet; documentation was AI-assisted.
- **Diagnostic method:** I moved from symptoms to service, log, process, socket and configuration evidence, then applied a minimal change and repeated the client check.

## Planned or not yet demonstrated

- **CI/CD:** initial theory exposure only; completed pipeline practice is not confirmed.
- **Advanced containers:** I have not demonstrated Dockerfile, Compose, volumes or registry work.
- **Ansible, Terraform, Kubernetes, cloud and GitOps:** future learning topics, not demonstrated practical competencies.
- **Active Directory, GPO, DNS/DHCP servers and IIS:** included in earlier plans; completed labs are not confirmed.
- **Production, HA, SRE, monitoring platforms and backup recovery:** no claim of production operations, on-call responsibility, high availability or successful backup/restore projects without further evidence.
- **Certifications:** certifications listed in the repository are future goals, not earned credentials.
- **Other hypervisors and numeric ratings:** VirtualBox/Hyper-V/VMware self-ratings and Skill Matrix scores are not independent practical evidence or professional assessments.

## Concrete project outcomes

- **Infrastructure homelab:** Windows and Ubuntu on UTM, with macOS administration, SSH, LVM-backed Samba and cross-platform access checks.
- **Overlay connectivity:** Tailscale/MagicDNS and restricted SSH/SMB access, verified after reboot.
- **Linux diagnostic sprint:** completed incidents involving permissions, runtime configuration, dependencies, bind addresses, inodes and port conflicts; the final Linux gate recorded 11 PASS results in the course materials.
- **INC-009:** recovered two endpoints with different TCP failures; guided practical work completed, with oral assessment still pending.
- **INC-010:** corrected an upstream/API port mismatch; practical work and oral assessment completed with explanations, all PASS results reported by me.
- **INC-011:** identified the old-version cause independently and showed the new upstream in a screenshot; PASS results reported by me, with acceptance commands and response-body clarification supplied by the tutor.
- **Automation artifacts:** four Bash/PowerShell scripts, validation modes and documentation represent assisted project work, not proof of independent authorship of all code.

## Publication and sources

- **Repository and default branch:** [Kinahi06/enterprise-infrastructure — main](https://github.com/Kinahi06/enterprise-infrastructure/tree/main).
- **Progress:** [Progress.md](Progress.md) records outcomes through guided TASK-013 and the in-progress access exercise.
- **Skill matrix:** [Skill Matrix.md](Skill%20Matrix.md) contains learning self-assessments, not professional certification.
- **Engineering journal:** [Engeniering Journal.md](Engeniering%20Journal.md) records observations, repairs, checks and evidence limits.
- **Automation:** [02-Automation](../02-Automation/README.md) contains assisted Bash/PowerShell project artifacts, without claiming independent authorship of all code.
- **Currency:** updated 1 October 2026; historical hour and command counts are not used as current metrics.
