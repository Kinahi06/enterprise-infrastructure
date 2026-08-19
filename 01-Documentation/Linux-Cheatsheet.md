# Linux Administration Cheat Sheet

Quick reference for the Infrastructure Engineering Lab.

Use commands to answer a specific question. Do not run the entire list blindly.

---

# Command Safety

| Mark | Meaning |
|------|---------|
| READ | Reads system state |
| CHANGE | Changes packages or configuration |
| DISRUPTIVE | Can interrupt a service or the server |

Before a change, identify the expected result and decide how the result will be verified.

## Read an Error Before Retrying

First determine which part failed:

- `command not found` — the command name may be wrong or the program is unavailable
- `invalid option` — an option such as `-h` or `-o` may be mistyped
- `No such file or directory` — the command ran, but the supplied path was not found
- `Permission denied` — the current user does not have permission for the requested operation

Useful editing keys:

| Key | Action |
|-----|--------|
| `Up Arrow` | Recall the previous command |
| `Left/Right Arrow` | Move to the character that needs correction |
| `Tab` | Complete an unambiguous command or path; press twice to show matches |

Correct the smallest error and run the command again. Do not add `sudo` unless the error is actually about permission.

## Silent Success and Exit Status

Many Unix commands print nothing when they succeed. Verify the resulting state instead of waiting for a success message.

```bash
echo $?
```

Run immediately after the command being checked:

- `0` — success
- Any other value — an error or different result occurred

Examples of state verification:

```bash
ls -ld ~/.ssh
ls -l ~/.ssh/authorized_keys
```

`mkdir -p` is intentionally quiet when the directory already exists.

## Shell Versus Text Editor

- A shell prompt such as `linux01@linux01:~$` executes commands.
- `nano` edits file contents; command text entered inside `nano` is saved as text and is not executed.

Basic `nano` keys:

| Key | Action |
|-----|--------|
| `Ctrl+O` | Write the file |
| `Enter` | Confirm the filename |
| `Ctrl+X` | Exit |
| `N` | Decline saving when asked |

---

# Post-Installation Checklist

These checks create a baseline before the server receives an application role.

## 1. Identify the System

```bash
hostnamectl
```

Safety: READ

Shows the hostname, operating system, architecture, kernel and virtualization platform.

Check:

- Correct hostname
- Expected Ubuntu version
- Expected architecture
- Expected virtualization platform

## 2. Check Network Interfaces

```bash
ip -br address
```

Safety: READ

Shows a short list of interfaces and assigned IP addresses.

Check:

- Main interface is `UP`
- IPv4 address belongs to the expected subnet
- Loopback contains `127.0.0.1`

## 3. Check Uptime and Load

```bash
uptime
```

Safety: READ

Shows time since boot, logged-in users and load averages for 1, 5 and 15 minutes.

## 4. Check the Running Kernel

```bash
uname -r
```

Safety: READ

Shows the kernel currently loaded into memory. Useful after updates and reboots.

## 5. Check Memory

```bash
free -h
```

Safety: READ

Shows RAM and swap usage in human-readable units.

Check the `available` column. Linux uses otherwise unused RAM for cache, so a low `free` value is not automatically a problem.

## 6. Check Filesystem Usage

```bash
df -h
```

Safety: READ

Shows used and available space on mounted filesystems.

Check:

- Root filesystem `/`
- `/boot` and `/boot/efi`
- Filesystems approaching full capacity

## 7. Check Disk Layout

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
```

Safety: READ

Shows disks, partitions, LVM volumes, filesystems and mount points.

## 8. Check LVM

```bash
sudo pvs
sudo vgs
sudo lvs
```

Safety: READ

- `pvs` — physical volumes
- `vgs` — volume groups and unused capacity under `VFree`
- `lvs` — logical volumes

## 9. Check Failed Units

```bash
systemctl --failed
```

Safety: READ

Shows systemd units in the failed state.

Healthy baseline:

```text
0 loaded units listed.
```

## 10. Check Time Synchronization

```bash
timedatectl
```

Safety: READ

Shows local time, UTC time, timezone and clock synchronization state.

## 11. Check Updates

```bash
sudo apt update
apt list --upgradable
```

Safety:

- `apt update` — CHANGE; refreshes package metadata
- `apt list --upgradable` — READ; lists available package upgrades

`apt update` does not install upgrades.

## 12. Document the Baseline

Record:

- Hostname and server role
- OS, architecture and kernel
- IP address
- RAM allocation
- Disk and LVM layout
- Failed units
- Pending updates

---

# Package Management

## Install Available Upgrades

```bash
sudo apt upgrade
```

Safety: CHANGE

Before confirming, review:

- Upgraded packages
- Newly installed packages
- Removed packages
- Packages kept back
- Download size and disk usage

Avoid `-y` until the proposed changes have been reviewed.

## Read APT History

```bash
less /var/log/apt/history.log
```

Safety: READ

Important fields:

- `Start-Date`
- `Commandline`
- `Requested-By`
- `Install`, `Upgrade` or `Remove`
- `End-Date`

`Commandline: /usr/bin/unattended-upgrade` indicates an automatic update.

## Check Whether a Reboot Is Requested

```bash
cat /var/run/reboot-required
```

Safety: READ

- Message displayed — reboot requested
- `No such file or directory` — no reboot request recorded

## Simulate Removing Unused Dependencies

```bash
sudo apt autoremove --dry-run
```

Safety: READ

Shows what would be removed without changing the system. Review every package before performing the real removal.

---

# Services

## Check One Service

```bash
systemctl status SERVICE_NAME
```

Safety: READ

Check:

- `Loaded`
- `Active`
- `enabled` or `disabled`
- Process ID
- Recent log messages

The three common status concepts are different:

- `loaded` — systemd found and loaded the unit definition
- `active` — the unit is currently running, listening or otherwise active
- `enabled` — the unit is configured for automatic startup or activation

`systemctl status` normally opens long output in a pager. Press `q` to return to the prompt.

## Check Automatic Startup

```bash
systemctl is-enabled SERVICE_NAME
```

Safety: READ

Shows whether a service is configured to start automatically.

## Change Service State

```bash
sudo systemctl start SERVICE_NAME
sudo systemctl stop SERVICE_NAME
sudo systemctl restart SERVICE_NAME
```

Safety: DISRUPTIVE

Confirm the service name, dependencies and user impact first.

---

# Logs

## Read a Large File

```bash
less FILE_PATH
```

| Key | Action |
|-----|--------|
| `Space` | Next screen |
| `b` | Previous screen |
| `g` | Beginning |
| `G` | End |
| `/text` | Search |
| `n` | Next match |
| `q` | Quit |

## Read Logs for One Service

```bash
journalctl -u SERVICE_NAME
```

Safety: READ

Shows journal entries associated with a systemd service.

## Read Logs from the Current Boot

```bash
journalctl -b
```

Safety: READ

Limits the journal to the current boot session.

---

# Networking

## Test IP Connectivity

```bash
ping -c 4 8.8.8.8
```

Safety: READ

Tests network connectivity without depending on DNS.

## Test DNS and Connectivity

```bash
ping -c 4 example.com
```

Safety: READ

If the IP test works but the hostname test fails, investigate DNS.

## Show Listening Ports

```bash
sudo ss -tulpn
```

Safety: READ

Shows listening TCP and UDP sockets and their associated processes.

---

# SSH

## Check the SSH Service

```bash
systemctl status ssh
```

Safety: READ

## Check SSH Socket Activation

```bash
systemctl status ssh.socket
```

Safety: READ

On Ubuntu, SSH may use socket activation. In that case:

- `ssh.socket` can be `active (listening)`
- `ssh.service` can be `inactive (dead)` until a client connects
- `TriggeredBy: ssh.socket` on the service links the two units

This is not a failure when the socket is listening on TCP port 22.

## Display the Server Host-Key Fingerprint

```bash
ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
```

Safety: READ

- `ssh-keygen` — works with SSH keys
- `-l` — displays a fingerprint
- `-f` — selects the key file
- `.pub` — identifies the public key, which is safe to use for this check

Record this fingerprint on the server and compare it with the fingerprint shown by the SSH client during the first connection.

## Connect to a Server

```bash
ssh USERNAME@SERVER_IP
```

Safety: READ

On the first connection, confirm that the destination is correct before accepting its host-key fingerprint.

If the fingerprints differ, do not accept the connection until the cause is understood.

After accepting a verified key, the SSH client records it in `~/.ssh/known_hosts`. Future connections compare the server against that saved key and warn if it changes.

## Verify the Remote Session

```bash
whoami
hostname
echo $SSH_CONNECTION
```

Safety: READ

- `whoami` — account used on the remote system
- `hostname` — remote system receiving the commands
- `$SSH_CONNECTION` — client address and port followed by server address and port

## Show Active Login Sessions

```bash
w
```

Safety: READ

Header fields include uptime, number of active sessions and load averages.

| Column | Meaning |
|--------|---------|
| `USER` | Account that owns the session |
| `TTY` | Terminal assigned to the session; `tty1` commonly indicates a local console |
| `FROM` | Client address; `-` commonly indicates a local session |
| `LOGIN@` | Login time |
| `IDLE` | Time since activity in that session |
| `JCPU` | CPU time used by processes attached to the terminal |
| `PCPU` | CPU time used by the current process |
| `WHAT` | Current command or session process |

The session count is not necessarily a count of unique usernames. One account can have a local console and several simultaneous SSH sessions.

## Diagnose a Rejected SSH Password

Do not assume the server needs a reboot. Check the evidence in order:

1. If a password prompt appears, the network connection and SSH listener are already working.
2. Confirm that `USERNAME` in `ssh USERNAME@SERVER_IP` exactly matches the intended server account.
3. On the server console, run `whoami` to identify the current account.
4. Check keyboard layout and Caps Lock without exposing the password.
5. To validate the local password without changing configuration, use:

```bash
sudo -k
sudo -v
```

`sudo -k` forgets cached authentication. `sudo -v` asks for the account password and refreshes the credential without running an administrative change.

A password can be correct but still be rejected when SSH is asked to authenticate a different username.

## Read SSH Authentication Evidence

```bash
systemctl status ssh
```

The recent log lines can distinguish different stages:

- `Invalid user` or `user unknown` — the requested account does not exist
- `Failed password` — authentication was rejected
- `Accepted password` — authentication succeeded
- `session opened` — the remote login session was created

With socket activation, a successful incoming connection can change `ssh.service` from `inactive (dead)` to `active (running)`. `TriggeredBy: ssh.socket` confirms what activated it.

## Client Keys and Server Host Keys

- A server host key allows the client to verify the identity of the server.
- A client key allows the server to verify the identity of a user.
- The private client key stays on the client device and must never be copied into a repository, chat or server.
- The public `.pub` file is intended to be installed on servers.

## Create a Dedicated Client Key

Run on the client device:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_enterprise_lab -C "kinahi06@enterprise-lab"
```

Protect the private key with a passphrase appropriate to the environment. Never record the passphrase in project documentation.

## Prepare the Server Account

Run after logging into the server account:

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

- `authorized_keys` contains one permitted public key per line.
- `700` gives the directory owner full access and everyone else no access.
- `600` allows only the owner to read and write the file.

## Validate an Authorized Key

```bash
wc -l ~/.ssh/authorized_keys
ssh-keygen -lf ~/.ssh/authorized_keys
```

`wc -l` counts lines but does not validate the key. `ssh-keygen -lf` parses the key and displays its fingerprint, algorithm and comment.

## Test Only the Intended Client Key

Run on the client device:

```bash
ssh -o IdentitiesOnly=yes -o PreferredAuthentications=publickey -i ~/.ssh/id_ed25519_enterprise_lab linux01@192.168.64.3
```

- `-i` selects the private identity file.
- `IdentitiesOnly=yes` prevents other agent keys from being tried.
- `PreferredAuthentications=publickey` prevents a successful password fallback from hiding a key-authentication problem.

A prompt for the key passphrase is local key protection. It is different from a prompt for the Linux account password.

---

# LVM Service Storage

## Inspect Capacity Before Allocating

```bash
sudo vgs
sudo lvs
```

Safety: READ

- `VFree` is capacity not yet assigned to a logical volume.
- Define the workload, required size, mount point and recovery method before allocation.

## Create a Logical Volume

```bash
sudo lvcreate -L 10G -n files ubuntu-vg
```

Safety: CHANGE

- `-L 10G` selects the size.
- `-n files` names the logical volume.
- `ubuntu-vg` is the target volume group.

Verify with `sudo lvs` and `sudo vgs`.

## Create a Filesystem

```bash
sudo mkfs.ext4 -L files /dev/ubuntu-vg/files
```

Safety: DESTRUCTIVE IF THE TARGET IS WRONG

`mkfs` creates a new filesystem and destroys existing filesystem content on the selected target. Confirm the exact new logical volume with `lvs` and `lsblk` first.

```bash
lsblk -f
```

Verify the expected filesystem type, label and UUID before mounting.

---

# Persistent Mounts

## Create the Service Mount Point

```bash
sudo mkdir -p /srv/samba
```

`/srv` is intended for site-specific data provided by services. `/mnt` is more commonly used for temporary manual mounts.

## Back Up and Edit `fstab`

```bash
sudo cp -a /etc/fstab /etc/fstab.backup-files
sudo nano /etc/fstab
```

Example:

```text
UUID=FILESYSTEM_UUID /srv/samba ext4 defaults 0 2
```

Fields:

1. Stable filesystem identifier
2. Mount point
3. Filesystem type
4. Mount options
5. Legacy `dump` setting
6. Filesystem-check order; root is normally `1`, data filesystems normally `2`

## Validate Before Reboot

```bash
sudo systemctl daemon-reload
sudo mount -a
findmnt /srv/samba
df -h /srv/samba
```

Safety: CHANGE, THEN READ

Do not reboot after an `fstab` error. Correct it while console or SSH recovery access is still available.

A controlled persistence test for an empty, unused new filesystem:

```bash
sudo umount /srv/samba
findmnt /srv/samba
sudo mount -a
findmnt /srv/samba
```

No output from the first `findmnt` is expected after a successful unmount.

---

# Group-Controlled Service Data

## Create a Service Group

```bash
sudo groupadd fileshare
sudo usermod -aG fileshare USERNAME
```

Safety: CHANGE

`-aG` appends a supplementary group. Omitting `-a` can replace the user's existing supplementary groups.

Reconnect after changing group membership. Existing processes retain the groups assigned when their session started.

## Create a Setgid Shared Directory

```bash
sudo mkdir -p /srv/samba/company
sudo chown root:fileshare /srv/samba/company
sudo chmod 2770 /srv/samba/company
```

- Owner and group receive full directory access.
- Others receive no access.
- Leading `2` sets setgid so new contents inherit the directory group.

Verify:

```bash
getent group fileshare
id USERNAME
ls -ld /srv/samba/company
```

Expected directory mode:

```text
drwxrws---
```

---

# Samba File Server

## Concepts

- SMB is the network file-sharing protocol.
- Samba is the Linux/Unix implementation.
- A share name such as `[company]` maps network clients to a real Linux path.
- Effective access requires both Samba authorization and Linux filesystem permission.

## Install and Inspect

```bash
sudo apt install samba
smbd --version
systemctl status smbd --no-pager
sudo ss -tlpn
```

Modern direct SMB uses TCP 445. TCP 139 and UDP 137–138 are associated with legacy NetBIOS functions.

## Back Up and Validate Configuration

```bash
sudo cp -a /etc/samba/smb.conf /etc/samba/smb.conf.backup-original
sudo nano /etc/samba/smb.conf
sudo testparm -s
```

Do not reload an invalid configuration. Look for:

```text
Loaded services file OK.
```

Authenticated group-controlled share:

```ini
[company]
    path = /srv/samba/company
    browseable = yes
    read only = no
    guest ok = no
    valid users = @fileshare
    force group = fileshare
    create mask = 0660
    force create mode = 0660
    directory mask = 2770
    force directory mode = 2770
```

`@fileshare` means the Unix group named `fileshare`.

## Create a Samba Account

```bash
sudo smbpasswd -a USERNAME
sudo pdbedit -L
```

The Linux account must already exist. Samba credentials are stored separately. Never place the password directly in a command, repository or chat.

## Reload and Verify

```bash
sudo smbcontrol smbd reload-config
systemctl is-active smbd
```

No output from the reload normally indicates success. `is-active` should return `active`.

## macOS Client Test

```bash
smbutil view //USERNAME@SERVER_IP
```

Finder connection:

```text
smb://SERVER_IP/company
```

After mounting, macOS normally exposes the share at:

```text
/Volumes/company
```

Remember that `/Volumes/company` is a macOS path. The corresponding Ubuntu path in this lab is `/srv/samba/company`.

---

# Tailscale Overlay Administration

## Inspect the Node

```bash
tailscale version
systemctl is-enabled tailscaled
systemctl is-active tailscaled
tailscale status
tailscale ip -4
```

Safety: READ

- `tailscale status` shows this node and visible peers.
- `tailscale ip -4` prints the node's stable tailnet IPv4 address.
- A Tailscale address normally belongs to `100.64.0.0/10`.

## Test a Peer

```bash
tailscale ping --c 3 --until-direct=false PEER_NAME
```

Safety: READ

This verifies the tailnet path. Output containing `via DERP(...)` means the
encrypted connection is using a relay. It is still a working path, but usually
has higher latency than a direct connection.

Test the actual service separately:

```bash
ssh USER@PEER_NAME
nc -vz PEER_NAME 445
```

`tailscale ping` proves overlay connectivity. It does not prove that SSH, Samba,
the host firewall or application authentication is correctly configured.

## Join or Rename a Node

Interactive browser enrollment:

```bash
sudo tailscale up --hostname=NODE_NAME
```

Rename an already connected node:

```bash
sudo tailscale set --hostname=NODE_NAME
```

Safety: CHANGE

Never place an auth key directly in shell history. Use a protected file with
mode `600` and Tailscale's `--auth-key=file:PATH` form when unattended
enrollment is genuinely required.

## Exact UFW Rules on the Overlay

```bash
sudo ufw allow in on tailscale0 from CLIENT_TAILSCALE_IP \
  to any port 22 proto tcp comment 'SSH CLIENT_NAME via Tailscale'

sudo ufw allow in on tailscale0 from CLIENT_TAILSCALE_IP \
  to any port 445 proto tcp comment 'SMB CLIENT_NAME via Tailscale'
```

Safety: CHANGE

These rules combine three restrictions:

- ingress interface: `tailscale0`
- source: one known tailnet client
- destination service: TCP 22 or TCP 445

Inspect before deleting anything:

```bash
sudo ufw status numbered
sudo ufw show added
```

Delete numbered rules from highest to lowest so earlier numbers do not shift.
Keep a second SSH connection or the VM console available while changing remote
access.

---

# UFW for Remote File Servers

## Safe Deployment Order

1. Keep the current SSH session open.
2. Keep console recovery available.
3. Add the SSH allow rule before enabling UFW.
4. Add only the service ports that are required.
5. Inspect staged rules.
6. Enable UFW.
7. Test a second SSH session before closing the first.

Example policy for this laboratory:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 192.168.64.0/24 to any port 22 proto tcp comment 'SSH lab'
sudo ufw allow from 192.168.64.0/24 to any port 445 proto tcp comment 'SMB lab'
sudo ufw show added
```

Safety: CHANGE, NOT YET ENABLED

Review the addresses and ports before running `sudo ufw enable`. Direct SMB access by IP does not require opening legacy NetBIOS ports.

## Enable and Verify

~~~bash
sudo ufw enable
sudo ufw status verbose
~~~

Safety: CHANGE

Keep the original SSH session open. From a second client terminal, verify a new SSH connection and a new SMB connection before closing the original session.

On macOS:

~~~bash
nc -G 2 -vz SERVER_IP 22
nc -G 2 -vz SERVER_IP 445
nc -G 2 -vz SERVER_IP 139
~~~

For this lab, ports 22 and 445 should succeed while port 139 should time out.

---

# Samba File-Server Hardening

Disable unused printing and guest usershares:

~~~ini
[global]
    load printers = no
    disable spoolss = yes
    usershare allow guests = no

[printers]
    available = no

[print$]
    available = no
~~~

Validate before reloading:

~~~bash
sudo testparm -s
sudo smbcontrol smbd reload-config
systemctl is-active smbd
~~~

Confirm from the client that the intended file share remains available and the unused printer share is absent.

---

# Controlled Reboot Acceptance Test

Before reboot:

~~~bash
systemctl is-enabled smbd
systemctl is-enabled ufw
systemctl is-enabled ssh.socket
~~~

After reboot:

~~~bash
uptime
ip -br address
systemctl --failed
findmnt /srv/samba
df -h /srv/samba
systemctl is-active smbd
sudo ufw status verbose
~~~

Then create new SSH and SMB client connections and read a file created before the reboot. Persistence is proven only when the services, mount and data all return.

---

# Troubleshooting Order

1. Define exactly what is failing.
2. Determine the affected users and systems.
3. Record the current state before changing anything.
4. Read the relevant service status and logs.
5. Form one testable hypothesis.
6. Test one thing at a time.
7. Apply the smallest appropriate fix.
8. Repeat the original test.
9. Document the cause, resolution and verification.

---

# Post-Maintenance Verification

```bash
uptime
uname -r
systemctl --failed
```

Maintenance is complete only when the intended change is applied and the server remains healthy.
