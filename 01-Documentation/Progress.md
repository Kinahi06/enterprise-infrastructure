# Progress Timeline

Last updated: 2026-08-10

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
- [ ] Create a reusable macOS SSH client profile
- [ ] Review Ubuntu firewall state and SSH hardening
- [ ] Assign the first application or infrastructure role to `linux01`
- [ ] Learn PowerShell objects
- [ ] Investigate Windows Event Viewer

## Future Modules

### September

- [ ] Active Directory
- [ ] DNS server
- [ ] DHCP server
- [ ] File server

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

## Current Focus

Remote Linux administration over SSH.

## Next Session

1. Inspect or create `~/.ssh/config` on macOS.
2. Add a readable host alias for `linux01`.
3. Test the alias while retaining console recovery access.
4. Review firewall and effective SSH settings without changing them blindly.
5. Define the first workload for `linux01` before installing additional software.
