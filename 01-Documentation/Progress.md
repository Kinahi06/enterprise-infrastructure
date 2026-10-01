# Progress Timeline

Last updated: 2026-10-01

[Full learning map: every lesson, session and curriculum module](Learning-Map.md).
Session numbers and curriculum module numbers are separate sequences.

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

### Session 08 — Local name resolution (completed with guidance)

- [x] Compare the destination returned by `getent` with the actual TCP listener
- [x] Locate the lab name mapping in `/etc/hosts`
- [x] Correct `api.s8.test` from `127.0.0.2` to the listener address `127.0.0.1`
- [x] Report all final checker checks passing on 2026-09-23

The exercise used guidance for resolver commands and locating the hosts file.
I initially proposed restarting the service; the explanation clarified
that a client-side name mapping change does not require restarting a healthy API.
Completion was recorded in the local course but omitted from this published log;
this entry restores it. The final full PASS is reported by me, not newly rerun.

### Session 09 — Connection refused versus timeout (guided)

- [x] Reproduce two different TCP connection failures with bounded `curl` requests
- [x] Identify an inactive service with no listener and restore it with `start`
- [x] Compare the other service's MainPID, listening address and runtime configuration
- [x] Read a scoped nftables rule and explain destination address, port, counter and `drop`
- [x] Remove only the isolated training filter and recover HTTP without restarting the service
- [x] Report all final checker checks passing during the exercise
- [x] Tutor rechecked both services, listening endpoints, HTTP contracts and current-process logs on 2026-09-27
- [ ] Complete the oral defence independently

The 2026-09-27 read-only recheck confirmed active services and correct HTTP 200
responses. It did not rerun the root-only checker because sudo authentication
was required; socket PID ownership and absence of the training table were not
independently reverified in that repeat check. The earlier full PASS result is
reported by me. This guided exercise does not raise the independence rating.

### Session 10 — Reverse proxy and HTTP 502 (completed with guidance)

- [x] Tutor prepared a separate two-service lab, ticket and standalone learning material
- [x] Tutor validated the prepared application behaviour with five automated tests
- [x] Tutor delivered the installer to the training VM
- [x] Confirm lab installation and reproduce the client-visible HTTP 502
- [x] Compare the configured upstream destination with the API's actual listener
- [x] Correct the upstream port and restart only the proxy
- [x] Report successful client-path verification and all final checker checks passing
- [x] Complete the oral defence, including a corrected end-to-end verification misconception

Completed on 2026-09-28. I identified the upstream/listener mismatch
and chose the minimal repair after requesting command syntax and help locating
the backend service. Setup, initial HTTP 502 and proxy configuration were shown
in screenshots; final recovery and all checker PASS results were reported by me,
not independently rerun by the tutor. During the defence, direct API HTTP 200
was initially mistaken for proof of the whole path and a handshake. This was
clarified, and I answered the follow-up correctly. Credit is recorded
without increasing numeric independence ratings.

### Session 11 — Successful HTTP, wrong backend version (completed)

- [x] Independently compare the proxy, current API and old API service logs
- [x] Identify routing to v1 instead of the required v2 despite HTTP 200
- [x] Correct the upstream and restart only the proxy
- [x] Confirm the new upstream in the current process startup log
- [x] Report all final checker checks passing after client-route test commands were supplied
- [x] Complete the short defence with clarification of response-body validation

Completed on 2026-09-29. Screenshots show the initial service relationships and
the restarted proxy using the current API. Final PASS results are reported by me,
not independently rerun. The cause and repair were identified independently in a
scenario related to Session 10; acceptance-test commands were provided on request.
During defence, checking the listener was distinguished from checking the actual
JSON version and data. Numeric skill ratings are unchanged.

## 30 September 2026 — TLS and Docker
I completed INC-012 with guidance. I first suspected an expired certificate,
but old.crt was valid for 29 September–29 October and named old.s12.test.
With supplied openssl commands I checked api.crt, then used the suggested
api.crt/api.key pair. My screenshot shows verified HTTPS to api.s12.test:8443,
the supplied CA, no -k, HTTP 200 and {"status":"ok","service":"s12-api"}.
I reported all checker PASS results; the tutor did not independently rerun it.
I needed clarification that -k disables authentication checks, not encryption.

I then completed TASK-013 with guidance. Docker Client/Server 29.1.3 was accessible
with sudo; without sudo the socket access was denied. I chose a specific tag,
nginx:1.30.5-alpine, instead of stable-alpine. I used the name s18-web rather than
the planned s13-web; this is Session 13, not Session 18.
My screenshots show ID 0e4c538a2d84, 127.0.0.1:8133 → 80, HTTP 200 and
Welcome to nginx!, and a matching GET 200 in container logs.
After stop I showed Exited (0) and curl (7); after start I showed the same ID and HTTP 200.
The last shown state is Up. A final stop was suggested, not confirmed.
I did not demonstrate deletion, Compose, Dockerfile, volumes, registry or Docker-group changes.
There is no check-s13; acceptance used these observations and a short defence.
I needed an image/container explanation, then correctly explained the port mapping
and independence of different container instances. Numeric skill ratings remain unchanged.

## 1 October 2026 — Users and access (in progress)
I created lab (gid 1003), dev (uid 1004), view (uid 1005) and ops (uid 1006).
I added dev to lab, assigned /srv/team to dev:lab and set mode 2750.
I created probe as dev. As view I got expected permission denials from ls and touch.
view is deliberately outside lab: an ordinary employee without project access.
The directory mode is shown; a separate ownership/mode listing of probe is not.
ops currently has ops/users membership in my screenshot; no sudoers configuration is confirmed.
I want a scoped set of non-critical services, but the exact allowlist/actions are not agreed.
Separate SSH logins for these users are not yet configured in the recorded work.

Backups and monitoring are learning requests, not deployments. I have no separate
backup disk, Raspberry Pi or spare laptop for this work. Scope, retention, RPO/RTO
and tooling have not been selected. Earlier draft suggestions are not requirements.
I execute server changes myself; my tutor prepares theory, tickets and references.

## Future Modules

The dated lists below preserve an older Windows/homelab plan, not current
deadlines. The active course sequence and module statuses are in the
[full learning map](Learning-Map.md#curriculum-modules--full-roadmap).

### September

- [ ] Active Directory
- [ ] DNS server
- [ ] DHCP server
- [x] File server

### October

- [ ] Group Policy
- [ ] PowerShell automation
- [ ] IIS

### November (historical schedule; Docker basics completed earlier on 30 September)

- [x] Docker basics (guided TASK-013, 30 September; not the full containers module)
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
- Comparing reverse-proxy upstream configuration with the backend listener
- Repairing an upstream-port mismatch with a proxy-only restart
- Distinguishing env-file reload by restart from systemd unit daemon-reload
- Identifying an old backend version even when the proxy returns HTTP 200
- Practising expected JSON-version and data checks through the client endpoint

## Current Focus

I am practising users, groups and restricted operator access. [Current ticket and study notes](Study-Notes/README.md).
Session 09 oral defence remains open. Backups and monitoring will be separate learning tasks.
I keep unverified work unchecked and do not raise independence scores after guided exercises.
