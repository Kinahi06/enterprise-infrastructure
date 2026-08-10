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
