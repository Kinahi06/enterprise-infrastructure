# Infrastructure Plan

Last updated: 2026-08-19

## Scope

This project models a small enterprise environment for practical Windows,
Linux, networking, security, troubleshooting and automation exercises. New
services are added only after defining their users, data, dependencies,
verification and recovery path.

## Current Inventory

| Asset | Platform | Role | Tailnet identity | State |
|---|---|---|---|---|
| `macbook-admin` | macOS host | Administration and SMB client | `100.118.247.65` | Operational |
| `nova-ws01` | Windows 11 Pro ARM64 in UTM | Windows administration and SMB client | `100.73.143.51` | Operational |
| `linux01-server` | Ubuntu Server 24.04.4 LTS ARM64 in UTM | SSH and Samba server | `100.125.27.99` | Operational |

MagicDNS names are used in normal commands. Exact Tailscale IPv4 addresses are
recorded because the current firewall policy identifies individual clients.

## Service Architecture

`linux01-server` provides an authenticated standalone Samba share named
`company`; it is not a domain controller.

| Layer | Configuration |
|---|---|
| Remote access | OpenSSH socket on TCP 22; ED25519 client-key login tested |
| Overlay | Tailscale on Ubuntu, macOS and Windows with MagicDNS |
| Firewall | UFW default-deny incoming; exact rules on `tailscale0` |
| Identity | Linux/Samba user `linux01`; Unix group `fileshare` |
| File service | Samba 4.19, guest access disabled, printing disabled |
| Data | `/srv/samba/company` on a dedicated ext4 LVM volume |

### Storage Layout

| Component | Size or value |
|---|---|
| Virtual disk | 64 GiB |
| EFI / boot | 1 GiB / 2 GiB |
| Root logical volume | ~30.5 GiB |
| `files` logical volume | 10 GiB, ext4, label `files` |
| Persistent mount | `/srv/samba` through filesystem UUID in `/etc/fstab` |
| Unallocated VG capacity | ~20.47 GiB |

The separate service volume prevents share data from silently consuming the
root filesystem and leaves capacity for controlled growth.

## Access Policy

The completed Ubuntu inbound policy contains only:

| Client | Interface | Port | Purpose |
|---|---|---:|---|
| `macbook-admin` | `tailscale0` | TCP 22 | SSH administration |
| `macbook-admin` | `tailscale0` | TCP 445 | SMB access |
| `nova-ws01` | `tailscale0` | TCP 445 | SMB access |

TCP 139 and all other unsolicited inbound traffic remain blocked. Local UTM
addresses are recovery or diagnostic paths, not stable management identities.

Some tests use a Tailscale DERP relay. Application access and encryption are
verified; direct-path optimization is tracked as a performance task rather
than an availability failure.

## Automation

Four idempotent tools implement the manual overlay procedure:

- Ubuntu, macOS and Windows bootstrap scripts;
- an Ubuntu helper for exact UFW client authorization.

Interactive mode uses browser authentication and a final default-No approval
gate. Parameter and check-only modes support repeatable validation and future
configuration management. See the [automation guide](../02-Automation/README.md).

## Engineering Rules

1. Record the baseline and expected result before a change.
2. Make the smallest change that satisfies the requirement.
3. Keep console or second-session recovery access during remote-access work.
4. Validate the application, not only the process or open port.
5. Test persistence after reboot and test restore procedures explicitly.
6. Never commit passwords, private keys, auth tokens or recovery secrets.
7. Record incident evidence, cause, resolution and verification.

## Roadmap

1. Test first-time bootstrap on clean VM snapshots.
2. Back up and restore Samba data, configuration and required account state.
3. Add service, storage and authentication monitoring.
4. Review effective SSH settings and harden them with a recovery plan.
5. Add identity, DNS/DHCP and configuration-management laboratories.
