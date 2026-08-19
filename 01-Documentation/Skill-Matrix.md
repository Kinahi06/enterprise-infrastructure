# Evidence-Based Skill Matrix

Last updated: 2026-08-19

The status describes laboratory evidence, not a certification or claim of
production mastery.

| Status | Meaning |
|---|---|
| Demonstrated | Implemented and verified in the current lab |
| Practised | Used in a guided exercise; more independent repetition needed |
| Planned | Not yet implemented |

## Demonstrated

| Area | Evidence |
|---|---|
| Ubuntu deployment | Ubuntu Server 24.04 ARM64 installed in UTM and baselined |
| Linux inspection | OS, network, memory, storage, LVM, sockets and failed units checked |
| Package maintenance | APT plan reviewed, upgrades applied and reboot need verified |
| systemd | Service state, socket activation, startup and logs interpreted |
| SSH | Host fingerprint checked; dedicated ED25519 key and client alias tested |
| LVM and ext4 | 10 GiB logical volume created, formatted and persistently mounted |
| Linux permissions | Service group, setgid inheritance and restrictive modes verified |
| Samba | Authenticated share deployed and validated with `testparm` |
| UFW | Default-deny policy activated with exact interface/source/port rules |
| Tailscale | Three-platform tailnet, MagicDNS and peer/service tests completed |
| Cross-platform SMB | macOS and Windows read/write tests passed |
| Bash automation | Idempotent bootstrap and UFW authorization with check-only modes |
| PowerShell automation | Interactive wizard, cancellation and confirmed execution tested |
| Git/GitHub | Feature branch, intentional commit, PR review gate and merge completed |
| Troubleshooting | Incidents resolved from logs, command output and application tests |

## Practised

| Area | Current evidence gap |
|---|---|
| Windows services and Registry | Inspection completed; service creation/recovery still pending |
| Windows Event Viewer | Basic use only; structured incident lab still pending |
| PowerShell objects | Commands used; pipelines and reusable object processing need practice |
| IPv4, NAT and virtual networking | Several topologies diagnosed; routing/VLAN depth pending |
| Tailscale path analysis | DERP identified; direct-path troubleshooting pending |
| Security hardening | UFW and Samba completed; controlled SSH hardening pending |
| Backup and recovery | Reboot persistence proved; data/configuration restore not yet tested |

## Planned

- Active Directory, Group Policy, DNS and DHCP server roles
- Ansible configuration management
- Containers and Linux application deployment
- Centralized monitoring and logging
- Tested backup, restore and disaster-recovery workflow
- VLAN and routing laboratories

## Current Development Priority

1. Fresh-VM automation acceptance testing.
2. Samba backup and restore.
3. Effective SSH configuration review and hardening.
4. Monitoring for storage, service health and authentication failures.

Supporting detail:
[Engineering Journal](./Engineering-Journal.md) ·
[Automation Guide](../02-Automation/README.md) ·
[Infrastructure Plan](./Infrastructure-Plan.md)
