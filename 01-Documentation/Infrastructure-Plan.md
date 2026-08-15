# Infrastructure Plan

Last updated: 2026-08-15

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
| Windows 11 Pro VM | UTM, ARM64 | Dynamic | Document later | Windows administration workstation | Deployed |
| `linux01` | Ubuntu Server 24.04.4 LTS ARM64 | `192.168.64.3/24` | ~4 GiB RAM, 64 GiB virtual disk | Authenticated Samba file server | Operational, hardening pending |

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

Observed virtual-network endpoints:

- macOS/virtual-network side: `192.168.64.1`
- `linux01`: `192.168.64.3`
- SSH destination port: TCP 22
- SMB destination port: TCP 445

Direct SMB access from macOS to `smb://192.168.64.3/company` is verified. The exact UTM network mode, address-allocation method and persistence requirements still need to be documented before relying on fixed addresses.

UFW was inactive during deployment. A least-privilege policy is planned to allow TCP 22 and TCP 445 only from `192.168.64.0/24`; it was not enabled before the session ended.

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

## 6. Shared Resources — Planned

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

## 8. Next Milestones

1. Review and enable subnet-restricted UFW rules while keeping UTM console recovery.
2. Verify new SSH and SMB connections after firewall activation.
3. Remove unused Samba printer shares and validate the resulting configuration.
4. Perform a controlled reboot and verify `/srv/samba`, `smbd` and client access.
5. Test the `company` share from Windows.
6. Document the effective UTM network mode and IP-allocation strategy.
7. Define backup and restore tests for the file-server data.
