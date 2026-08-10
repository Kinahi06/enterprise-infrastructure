# Infrastructure Plan

Last updated: 2026-08-10

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
| `linux01` | Ubuntu Server 24.04.4 LTS ARM64 | `192.168.64.3/24` | ~4 GiB RAM, 64 GiB virtual disk | Unassigned Linux administration node | Deployed |

### `linux01` Storage

- Virtual disk: 64 GiB
- EFI partition: 1 GiB
- `/boot`: 2 GiB
- LVM physical volume: approximately 60.9 GiB
- Root logical volume: approximately 30.5 GiB
- Unallocated volume-group capacity: approximately 30.47 GiB

The free LVM capacity is intentionally retained until a workload defines whether it should extend `/` or become a separate logical volume.

### `linux01` Access

- Local recovery access through the UTM console
- OpenSSH socket listening on TCP port 22
- Verified server ED25519 host key
- Password authentication currently retained for recovery and training
- Dedicated lab client public key installed for user `linux01`
- Public-key-only authentication successfully tested from macOS

## 4. Current Network

Observed virtual-network endpoints:

- macOS/virtual-network side: `192.168.64.1`
- `linux01`: `192.168.64.3`
- SSH destination port: TCP 22

The exact UTM network mode, address-allocation method and persistence requirements still need to be documented before relying on fixed addresses.

## 5. Planned Infrastructure Roles

Potential future roles:

- Identity and directory services
- DNS and DHCP
- File and print services
- Linux web or application service
- Monitoring and centralized logging
- Configuration management and automation
- Backup and recovery

No role is assigned to `linux01` yet. The first workload will be selected before role-specific packages or storage changes are made.

## 6. Shared Resources — Planned

- Department file shares
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

1. Create a macOS SSH client alias for `linux01`.
2. Document the effective UTM network mode and IP-allocation strategy.
3. Inspect Ubuntu firewall and effective SSH settings.
4. Select the first server workload and document its requirements.
5. Decide how LVM capacity will support that workload.
6. Create a recovery and snapshot procedure before disruptive configuration changes.
