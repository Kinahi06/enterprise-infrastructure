# Progress Timeline

Last updated: 2026-08-19

## August 2026

- [x] Build first Windows infrastructure laboratory
- [x] Install VirtIO drivers and diagnose virtual hardware
- [x] Learn Windows Resource Monitor and folder structure
- [x] Investigate Windows Services and Registry configuration
- [x] Deploy Ubuntu Server 24.04 LTS ARM64
- [x] Verify Linux IPv4 connectivity and DNS resolution
- [x] Complete initial Linux server provisioning baseline
- [x] Apply updates and verify the server after reboot
- [x] Inspect disks, filesystems and LVM
- [x] Verify OpenSSH socket activation
- [x] Establish verified SSH access from macOS
- [x] Configure and test ED25519 public-key authentication
- [x] Create a reusable macOS SSH client profile
- [x] Assign the first infrastructure role to `linux01`
- [x] Create a dedicated LVM volume and persistent service-data mount
- [x] Configure group-controlled Linux file permissions
- [x] Deploy an authenticated Samba share
- [x] Verify SMB read/write access from macOS
- [x] Review Ubuntu firewall state
- [x] Enable subnet-restricted UFW rules with a tested SSH recovery path
- [x] Remove unused Samba printer-sharing configuration
- [x] Verify Samba and storage after reboot
- [x] Test authenticated SMB read/write access from Windows
- [x] Deploy Tailscale on Ubuntu, macOS and Windows
- [x] Replace changing local-subnet access with stable MagicDNS names
- [x] Verify SSH and SMB across different virtual network segments
- [x] Restrict UFW to exact Tailscale clients and required services
- [x] Remove obsolete local-subnet firewall rules without losing access
- [x] Verify Tailscale, SSH, Samba and storage after a controlled reboot
- [x] Document DERP relay behaviour separately from service availability
- [x] Create first idempotent Bash and PowerShell bootstrap scripts
- [x] Pass macOS, Ubuntu and Windows bootstrap check-only validation
- [x] Verify existing Mac and Windows UFW authorization through check-only mode
- [x] Add interactive wizard and final confirmation to all bootstrap workflows
- [x] Verify Windows wizard cancellation without changing the system
- [x] Apply the Windows wizard successfully and re-test TCP 445
- [x] Exclude one-time browser-authentication URLs from automation logs
- [ ] Review effective SSH server hardening
- [ ] Test bootstrap automation on fresh VM snapshots
- [ ] Learn PowerShell objects
- [ ] Investigate Windows Event Viewer

## Future Modules

### September

- [ ] Active Directory
- [ ] DNS server
- [ ] DHCP server
- [x] File server

### October

- [ ] Group Policy
- [ ] PowerShell automation
- [ ] IIS

### November

- [ ] Docker
- [ ] Linux service deployment

### December

- [ ] Ansible
- [ ] Monitoring
- [ ] Backup and recovery testing

## Completed Skills and Laboratories

- Windows Service Control Manager and service analysis
- Windows Registry navigation and service configuration
- Ubuntu deployment in UTM on Apple Silicon
- Linux post-installation baseline inspection
- APT package metadata, upgrade history and maintenance verification
- Linux memory, filesystem, disk and LVM interpretation
- systemd units, service state and socket activation
- Terminal history, pager navigation and command-error classification
- SSH host identity and ED25519 fingerprint comparison
- Password-authentication failure diagnosis using `whoami`, `sudo` and SSH logs
- Remote-session inspection using `$SSH_CONNECTION` and `w`
- Dedicated client-key creation and private/public key separation
- SSH `authorized_keys` ownership, permissions and content validation
- Public-key-only SSH login verification
- Persistent LVM-backed service storage
- `/etc/fstab` backup, validation and remount testing
- Unix group ownership and setgid directory inheritance
- Samba installation, configuration validation and account creation
- Authenticated SMB share discovery and macOS read/write verification
- Least-privilege UFW activation with remote-access recovery planning
- Samba printer and guest-usershare hardening
- Controlled reboot and post-reboot acceptance testing
- Tailscale installation, MagicDNS naming and cross-platform peer inspection
- Overlay networking independent of changing home, work and mobile subnets
- Exact UFW rules bound to `tailscale0`, source address and service port
- Windows SMB authentication and guest-access error diagnosis
- Cross-platform SMB read/write validation over Tailscale
- DERP relay identification without confusing it with a failed connection
- Idempotent bootstrap design with check-only modes and secret-file handling

## Current Focus

Publish the verified Tailscale automation and begin backup/restore design.

## Next Session

1. Publish the runtime-verified automation and documentation.
2. Test a first-time installation against a fresh VM snapshot.
3. Define what file-server data and configuration must be backed up.
4. Create a backup and perform a restore test.
