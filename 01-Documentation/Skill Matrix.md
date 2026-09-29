# Skill Matrix

Last updated: 2026-09-28

Levels are self-assessments used to select the next laboratory exercise, not certifications of mastery.

## Infrastructure

| Skill | Level | Target |
|-------|------:|-------:|
| Windows Administration | 3/10 | 9/10 |
| Linux Administration | 5/10 | 9/10 |
| Samba File Services | 3/10 | 8/10 |
| Active Directory | 0/10 | 9/10 |
| Group Policy | 0/10 | 8/10 |
| Windows Services | 2/10 | 9/10 |
| Registry | 1/10 | 8/10 |
| Event Viewer | 1/10 | 8/10 |
| OpenSSH Administration | 4/10 | 8/10 |

## Networking

| Skill | Level | Target |
|-------|------:|-------:|
| IPv4 | 4/10 | 9/10 |
| IPv6 | 1/10 | 7/10 |
| DNS | 3/10 | 9/10 |
| DHCP | 1/10 | 8/10 |
| NAT and virtual networking | 4/10 | 8/10 |
| VLAN | 0/10 | 8/10 |
| VPN and overlay networking | 3/10 | 8/10 |

### Recent networking evidence — 2026-09-28

| Topic | Evidence / status |
|-------|-------------------|
| Connection refusal versus timeout | Practised in Session 09 with guidance |
| Process, listener and HTTP separation | Both endpoints rechecked successfully on 2026-09-27 |
| nftables tables, chains and matching rules | Introductory guided interpretation; not independent firewall administration |
| Minimal network repair | Removed only the training filter; HTTP recovered without a service restart |
| Reverse proxy and upstream diagnosis | Session 10 completed with guidance: learner identified the destination/listener mismatch and chose a proxy-only restart |
| Client-path acceptance | Recovery and all checker PASS results learner-reported; no tutor rerun of the final checker |
| HTTP response versus end-to-end health | Defence completed after correcting the assumption that direct API HTTP 200 proves the whole path or a TCP handshake |
| Env-file versus unit changes | Correct distinction in defence; restart rereads process environment, daemon-reload concerns unit definitions |

Existing numeric ratings are unchanged. Session 09 recovery is recorded, but
the oral defence is pending and the full repeated root-only check was not run.
Session 10 is credited, but requested diagnostic prompts and the corrected
defence answer mean it is not treated as an independent mastery assessment.

## Automation and Source Control

| Skill | Level | Target |
|-------|------:|-------:|
| PowerShell | 3/10 | 10/10 |
| Bash and shell usage | 4/10 | 8/10 |
| Git | 2/10 | 9/10 |
| GitHub | 2/10 | 9/10 |
| Ansible | 0/10 | 8/10 |

## Virtualization

| Skill | Level | Target |
|-------|------:|-------:|
| UTM | 6/10 | 9/10 |
| VirtualBox | 6/10 | 9/10 |
| Hyper-V | 0/10 | 8/10 |
| VMware | 0/10 | 8/10 |

## Monitoring and Troubleshooting

| Skill | Level | Target |
|-------|------:|-------:|
| Resource Monitor | 4/10 | 9/10 |
| Task Manager | 6/10 | 8/10 |
| Performance Monitor | 1/10 | 8/10 |
| Event Viewer | 1/10 | 9/10 |
| systemd status and journal interpretation | 5/10 | 8/10 |
| Evidence-based incident diagnosis | 5/10 | 9/10 |

## Linux and SSH Checklist

| Skill | Status |
|-------|--------|
| Deploy Ubuntu Server ARM64 | ✅ |
| Inspect OS, network, memory and storage | ✅ |
| Review and apply APT upgrades | ✅ |
| Interpret disks, filesystems and LVM | ✅ |
| Inspect systemd units and failed services | ✅ |
| Explain SSH socket activation | ✅ |
| Verify a server host-key fingerprint | ✅ |
| Diagnose an invalid SSH username | ✅ |
| Read SSH authentication evidence | ✅ |
| Configure `authorized_keys` permissions | ✅ |
| Verify public-key-only login | ✅ |
| Configure a client alias in `~/.ssh/config` | ✅ |
| Create and format an LVM logical volume | ✅ |
| Configure a persistent UUID mount in `/etc/fstab` | ✅ |
| Configure group ownership and setgid inheritance | ✅ |
| Install and validate a Samba file server | ✅ |
| Create an authenticated SMB share | ✅ |
| Verify SMB access from macOS | ✅ |
| Inspect firewall state | ✅ |
| Enable subnet-restricted firewall rules | ✅ |
| Validate services after a controlled reboot | ✅ |
| Deploy and inspect a Tailscale node | ✅ |
| Use MagicDNS names across changing subnets | ✅ |
| Bind exact UFW rules to `tailscale0` | ✅ |
| Distinguish direct and DERP-relayed paths | ✅ |
| Validate SSH and SMB over an overlay network | ✅ |
| Correlate systemd MainPID, process and listening socket | ✅ |
| Distinguish process, socket and HTTP health | ✅ |
| Read service runtime configuration from `EnvironmentFile` | ✅ |
| Test permissions as the configured service account | ✅ |
| Diagnose directory traversal and write permissions | ✅ |
| Distinguish `After=` from `Requires=` | ✅ |
| Create and verify a systemd drop-in | ✅ |
| Diagnose block and inode exhaustion separately | ✅ |
| Preview a bounded `find` selection before cleanup | ✅ |
| Map a conflicting listener PID to its systemd unit | ✅ |
| Harden SSH with a tested recovery path | ⏳ |

## Windows Services Checklist

| Skill | Status |
|-------|--------|
| View services | ✅ |
| Analyze services | ✅ |
| Disable services | ✅ |
| Read service configuration | ✅ |
| Navigate the Windows Registry | 🟡 |
| Create a Windows Service | ❌ |
| Configure service recovery | ❌ |
| Troubleshoot Windows services | 🟡 |

## Scripting Projects

| Project | Status |
|---------|--------|
| Remove-Xbox.ps1 | Planned |
| Setup-Lab.ps1 | Planned |
| Disable-Telemetry.ps1 | Planned |
| Install-Tools.ps1 | Planned |
| Bootstrap-Tailscale-Linux.sh | Implemented, fresh-VM test pending |
| Bootstrap-Tailscale-macOS.sh | Local check-only passed, fresh install pending |
| Bootstrap-Tailscale-Windows.ps1 | Implemented, fresh-VM test pending |
| Authorize-Tailscale-Client.sh | Implemented, check-only test pending |
| Interactive cross-platform setup wizard | Implemented, Windows runtime test pending |

## Certifications — Future

- [ ] AZ-104
- [ ] AZ-800
- [ ] AZ-801
- [ ] RHCSA
- [ ] CCNA

## Current Focus

- Consolidate completed Session 10 client -> reverse proxy -> API diagnosis
- Separating TCP connection failures from actual HTTP error responses
- Linux incident retention through mixed refresh laboratories
- Evidence-first validation after every state change

## Next Focus

- Explain the two separate TCP connections in a proxied HTTP request
- Localise an upstream failure using journal, socket and configuration evidence
- Verify recovery through the original client endpoint
- Docker fundamentals only after the networking foundation
