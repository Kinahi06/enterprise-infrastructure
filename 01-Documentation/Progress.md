# Progress Timeline

Last updated: 2026-09-27

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

## September 2026 — Linux Service Diagnostics Sprint

- [x] Diagnose systemd service failures from status and journal evidence
- [x] Separate process, socket and HTTP health signals
- [x] Trace runtime configuration through `EnvironmentFile`
- [x] Repair least-privilege file and directory access for a service account
- [x] Diagnose an invalid environment value without editing application code
- [x] Distinguish `After=` ordering from a required systemd dependency
- [x] Use a drop-in with `Requires=` and verify the effective unit graph
- [x] Diagnose local-only bind versus remote client reachability
- [x] Diagnose inode exhaustion separately from free disk space
- [x] Resolve a port conflict by mapping listener PID to its systemd unit
- [x] Complete the final Linux diagnostic gate with 11 checks passing
- [x] Produce an evidence-first Linux troubleshooting cheat sheet

## September 2026 — Networking Diagnostics

### Session 09 — Connection refused versus timeout (guided)

- [x] Reproduce two different TCP connection failures with bounded `curl` requests
- [x] Identify an inactive service with no listener and restore it with `start`
- [x] Compare the other service's MainPID, listening address and runtime configuration
- [x] Read a scoped nftables rule and explain destination address, port, counter and `drop`
- [x] Remove only the isolated training filter and recover HTTP without restarting the service
- [x] Report all final checker checks passing during the exercise
- [x] Recheck both services, listening endpoints, HTTP contracts and current-process logs on 2026-09-27
- [ ] Complete the oral defence independently

The 2026-09-27 read-only recheck confirmed active services and correct HTTP 200
responses. It did not rerun the root-only checker because sudo authentication
was required; socket PID ownership and absence of the training table were not
independently reverified in that repeat check. The earlier full PASS result is
learner-reported. This guided exercise does not raise the independence rating.

### Session 10 — Reverse proxy and HTTP 502 (prepared)

- [x] Prepare a separate two-service lab, ticket and short theory notes
- [x] Validate the prepared application behaviour with five automated tests
- [x] Deliver the installer to the training VM
- [ ] Confirm lab installation and reproduce the client-visible symptom
- [ ] Diagnose and repair the incident
- [ ] Pass the final checker and oral defence

Preparation and automated testing were performed by the tutor. Session 10 is
not recorded as a completed learner exercise.

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
- systemd lifecycle, MainPID and journal correlation
- Process, socket and HTTP health as separate evidence layers
- Service-account permissions and directory traversal/write semantics
- Runtime environment diagnosis without modifying application code
- systemd ordering and required dependency relationships
- Listener PID to systemd unit attribution
- Disk-block versus inode-exhaustion diagnosis
- Safe, preview-first stale-file selection
- Multi-cause incident diagnosis with full post-fix verification
- Guided comparison of TCP connection refusal and timeout
- Scoped packet-filter interpretation without disabling the host firewall
- Distinguishing listener availability from end-to-end HTTP reachability

## Current Focus

Continue networking with the two-hop client -> reverse proxy -> API model,
while retaining Linux through short mixed incidents. Session 09 recovery is
verified with the evidence limits above; Session 10 is prepared, not completed.

## Next Session

1. Install Session 10 and reproduce the original client HTTP request.
2. Distinguish the client-to-proxy connection from the proxy-to-API connection.
3. Verify any repair through the original client URL, not only the direct backend URL.
4. Revisit the pending Session 09 oral defence during a short Linux/network refresh.
5. Keep unrelated infrastructure automation changes in a separate review and commit.
