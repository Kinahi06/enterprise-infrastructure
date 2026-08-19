# Skill Matrix

Last updated: 2026-08-18

Levels are self-assessments used to select the next laboratory exercise, not certifications of mastery.

## Infrastructure

| Skill | Level | Target |
|-------|------:|-------:|
| Windows Administration | 3/10 | 9/10 |
| Linux Administration | 4/10 | 9/10 |
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
| systemd status and journal interpretation | 3/10 | 8/10 |
| Evidence-based incident diagnosis | 3/10 | 9/10 |

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

- Cross-platform bootstrap testing
- Idempotency and validation-only execution
- Secure secret handling in automation

## Next Focus

- Tailscale direct-path troubleshooting
- File-server backup and restore
- Effective SSH server hardening
