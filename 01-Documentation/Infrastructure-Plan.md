# Infrastructure Plan

Last updated: 2026-08-18

## 1. Project Overview

The project models a small enterprise infrastructure and provides repeatable laboratories for Windows, Linux, networking, security, troubleshooting and automation.

The design will be implemented in stages. A service will not be installed until its users, dependencies, data, availability requirements and recovery method are understood.

## 2. Proposed Departments

- Management
- Administration
- Accounting
- Human Resources
- Sales
- Operations
- Call Center
- DevOps and IT
- General Staff

This department list is preliminary and will be revised when the fictional company requirements are defined.

## 3. Current Laboratory Inventory

| Asset | Platform | Address | Resources | Current role | Status |
|-------|----------|---------|-----------|--------------|--------|
| `nova-ws01` | Windows 11 Pro, UTM ARM64 | Tailscale `100.73.143.51` | Document later | Windows SMB client and administration workstation | Operational |
| `linux01-server` | Ubuntu Server 24.04.4 LTS ARM64 | Tailscale `100.125.27.99` | ~4 GiB RAM, 64 GiB virtual disk | Authenticated Samba file server | Operational |
| `macbook-admin` | macOS host | Tailscale `100.118.247.65` | Physical host | Administrative workstation and SMB client | Operational |

### `linux01` Storage

- Virtual disk: 64 GiB
- EFI partition: 1 GiB
- `/boot`: 2 GiB
- LVM physical volume: approximately 60.9 GiB
- Root logical volume: approximately 30.5 GiB
- Service-data logical volume `files`: 10 GiB
- Service-data filesystem: ext4, label `files`
- Persistent service-data mount: `/srv/samba`
- Remaining unallocated volume-group capacity: approximately 20.47 GiB

The `files` logical volume is mounted by filesystem UUID through `/etc/fstab`. Persistence was tested by unmounting it and restoring it with `mount -a`. Remaining LVM capacity is retained for future growth or another workload.

### `linux01` Access

- Local recovery access through the UTM console
- OpenSSH socket listening on TCP port 22
- Verified server ED25519 host key
- Password authentication currently retained for recovery and training
- Dedicated lab client public key installed for user `linux01`
- Public-key-only authentication successfully tested from macOS
- macOS client alias `linux01-lab` configured and tested
- Samba account created for existing Linux user `linux01`

## 4. Current Network

The original UTM NAT subnet was useful while all systems shared one local
network, but addresses and subnets changed when the VM network mode or upstream
network changed. Tailscale now provides a stable encrypted management overlay
independent of home, workplace or mobile-host addressing.

Current tailnet endpoints:

- `macbook-admin`: `100.118.247.65`
- `linux01-server`: `100.125.27.99`
- `nova-ws01`: `100.73.143.51`

MagicDNS names are preferred in normal commands. Tailscale IPv4 addresses are
recorded because the current UFW design uses exact source-address rules.

Legacy observed virtual-network endpoints:

- macOS/virtual-network side: `192.168.64.1`
- `linux01`: `192.168.64.3`
- SSH destination port: TCP 22
- SMB destination port: TCP 445

Direct SMB access from macOS to `smb://192.168.64.3/company` was verified during
the local-network phase. It is no longer the normal administration path.

UFW is active with default-deny incoming and allow outgoing policies. The final
incoming policy contains exactly three rules:

- TCP 22 on `tailscale0` from `100.118.247.65` for Mac SSH administration
- TCP 445 on `tailscale0` from `100.118.247.65` for Mac SMB access
- TCP 445 on `tailscale0` from `100.73.143.51` for Windows SMB access

TCP 139 remains blocked. Windows currently reaches the server through a DERP
relay rather than a direct peer-to-peer path. Functionality and encryption are
verified; direct-path optimization remains a separate performance task.

## 5. Planned Infrastructure Roles

Potential future roles:

- Identity and directory services
- DNS and DHCP
- File and print services
- Linux web or application service
- Monitoring and centralized logging
- Configuration management and automation
- Backup and recovery

The first role assigned to `linux01` is an authenticated standalone Samba file server. It is not an Active Directory domain controller.

## 6. Shared Resources

- `company` authenticated file share at `/srv/samba/company`
- Administrative tools and scripts
- Centralized logs
- Monitoring dashboards
- Configuration repository
- Backup storage

## 7. Engineering Rules

1. Inspect and document the baseline before changing a system.
2. Define the expected result and verification method before a change.
3. Make the smallest appropriate change.
4. Keep local console or other recovery access while changing remote access.
5. Never commit passwords, passphrases, tokens or private keys.
6. Test backups and recovery instead of assuming they work.
7. Record incidents, evidence, resolution and verification.

## 8. Automation Design

Stage-one bootstrap scripts are stored in the public GitHub repository because
a new machine cannot access a private tailnet share before enrollment. After
joining, a server-side helper grants only the required service on `tailscale0`.

Implemented components:

- Ubuntu Tailscale bootstrap in Bash
- macOS Tailscale bootstrap in Bash
- Windows Tailscale bootstrap in PowerShell
- Idempotent Ubuntu UFW authorization helper
- Check-only validation modes and deployment logs

Authentication is interactive by default. Optional auth-key files must be kept
outside Git, protected by filesystem permissions and removed after enrollment.

## 9. Next Milestones

1. Test the bootstrap scripts against fresh VM snapshots.
2. Define and test backup and restore for service data and configuration.
3. Investigate DERP relay use and direct-path requirements in UTM.
4. Review effective SSH server settings and plan controlled hardening.
5. Add monitoring for storage capacity, Samba state and authentication failures.
