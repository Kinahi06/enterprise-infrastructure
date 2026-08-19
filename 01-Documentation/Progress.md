# Progress and Roadmap

Last updated: 2026-08-19

## Delivered Milestones

| Date | Milestone | Verification |
|---|---|---|
| 2026-08-03 | Windows 11 ARM64 lab and VirtIO drivers | Hardware, services and Resource Monitor inspected |
| 2026-08-08 | Ubuntu Server 24.04 deployment | IPv4, DNS, SSH package and update state verified |
| 2026-08-10 | Linux baseline and SSH administration | Host key checked; password and public-key login tested |
| 2026-08-14 | Dedicated LVM service storage | ext4 volume restored by `mount -a` and survived reboot |
| 2026-08-15 | Authenticated Samba file server | macOS read/write test and least-privilege permissions passed |
| 2026-08-18 | Cross-platform Tailscale overlay | macOS SSH plus macOS/Windows SMB passed through MagicDNS |
| 2026-08-19 | Bootstrap automation | Bash/PowerShell check-only, cancellation and confirmed-run tests passed |

## Current Capability

- Administer Ubuntu through verified SSH and systemd tooling.
- Inspect packages, logs, sockets, filesystems and LVM before changing state.
- Build persistent LVM-backed service storage.
- Configure Samba authentication, Unix group permissions and setgid inheritance.
- Apply UFW default-deny policy without losing the recovery path.
- Diagnose service, firewall, authentication and network-path failures separately.
- Operate Tailscale across macOS, Windows and Linux.
- Write idempotent Bash and PowerShell bootstrap tools with validation modes.
- Use Git branches, pull requests and runtime evidence to publish changes.

## Acceptance Evidence

- Tailscale, SSH, Samba, UFW and `/srv/samba` recover after Ubuntu reboot.
- Mac can authenticate with a dedicated ED25519 key and reach SMB TCP 445.
- Windows can authenticate to `company`, create data and reach TCP 445.
- Exact UFW authorization reruns do not add duplicate rules.
- Automation never requests or logs passwords, passphrases or raw auth keys.
- Windows wizard cancellation exits without changes; confirmed execution passes.

## In Progress

- [ ] Run every bootstrap against a clean VM snapshot.
- [ ] Define Samba backup scope and recovery objectives.
- [ ] Perform and document a restore test.
- [ ] Review effective SSH server configuration before hardening.
- [ ] Investigate direct Tailscale paths versus DERP relay use.

## Later Modules

| Area | Planned laboratories |
|---|---|
| Microsoft infrastructure | Active Directory, DNS, DHCP, Group Policy, PowerShell objects |
| Linux services | Web/application service, containers and service hardening |
| Automation | Ansible, reusable configuration and CI validation |
| Operations | Monitoring, centralized logging, backup and disaster recovery |
| Networking | VLANs, routing and deeper DNS/DHCP troubleshooting |

Detailed lesson evidence is in the
[Engineering Journal](./Engineering-Journal.md); practical command references
are in the Linux and Windows runbooks.
