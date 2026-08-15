# Progress Timeline

Last updated: 2026-08-15

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
- [ ] Review Ubuntu firewall state and SSH hardening
- [ ] Enable subnet-restricted UFW rules with a tested SSH recovery path
- [ ] Remove unused Samba printer-sharing configuration
- [ ] Verify Samba and storage after reboot
- [ ] Test the SMB share from Windows
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

## Current Focus

Building and securing the first Linux file-server role.

## Next Session

1. Review the staged UFW policy before enabling it.
2. Permit SSH and SMB only from `192.168.64.0/24`.
3. Verify a second SSH connection and SMB access after UFW is enabled.
4. Remove unused printer-sharing configuration and validate Samba again.
5. Reboot and verify the LVM mount, services, ports and client access.
