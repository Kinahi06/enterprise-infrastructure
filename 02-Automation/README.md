# Tailscale Bootstrap Automation

Repeatable Tailscale deployment and validation for Ubuntu, macOS and Windows,
plus exact UFW authorization on the Ubuntu service server.

## Safety Properties

- Browser authentication is the default; secrets are not embedded in source.
- Optional auth keys are read from protected files, not command-line values.
- macOS and Windows installers are checked against published SHA256 hashes.
- Existing installation and connection state is reused.
- Check-only mode validates without changing configuration.
- UFW rules are exact and duplicate-safe; the helper never enables UFW or
  deletes existing rules.
- One-time browser-login URLs are shown on screen but excluded from logs.
- Every interactive change has a final default-No confirmation.

## Components

| File | Platform | Purpose |
|---|---|---|
| `bootstrap-tailscale-linux.sh` | Ubuntu | Install/join, name the node and verify peers |
| `bootstrap-tailscale-macos.sh` | macOS | Install/join and run an optional TCP acceptance test |
| `bootstrap-tailscale-windows.ps1` | Windows | Install/join, configure unattended mode and verify a service |
| `authorize-tailscale-client.sh` | Ubuntu server | Add exact SSH/SMB UFW rules on `tailscale0` |

```text
GitHub download -> platform bootstrap -> browser login -> tailnet
                                                       -> exact UFW access
                                                       -> application test
```

A public repository is required for first-stage download because a new client
cannot access a private tailnet share before enrollment.

## Recommended Workflow

1. Create a VM snapshot or confirm console recovery access.
2. Download and read the platform script.
3. Run the interactive wizard and authenticate in the official browser.
4. Record the MagicDNS name and `tailscale ip -4` result.
5. Authorize only the services the client requires.
6. Test a new SSH or authenticated SMB session.
7. Rerun the bootstrap and UFW helper in check-only mode.
8. Record the result in the engineering journal.

The scripts change only the Tailscale/MagicDNS device name. They do not rename
the Windows computer or Unix hostname.

## Interactive Mode

Ubuntu:

```bash
sudo ./bootstrap-tailscale-linux.sh
```

macOS:

```bash
./bootstrap-tailscale-macos.sh
```

Windows PowerShell as Administrator:

```powershell
.\bootstrap-tailscale-windows.ps1
```

Ubuntu UFW authorization:

```bash
sudo ./authorize-tailscale-client.sh
```

The wizard collects only non-secret choices: device name, optional test peer
and port, Windows unattended mode, or requested SSH/SMB service. Operating
system elevation and Tailscale/SMB authentication remain separate.

## Parameter and Check-Only Examples

Ubuntu:

```bash
sudo bash ./bootstrap-tailscale-linux.sh \
  --hostname linux02-server \
  --verify-peer macbook-admin

sudo bash ./bootstrap-tailscale-linux.sh \
  --hostname linux02-server \
  --verify-peer macbook-admin \
  --check-only
```

macOS:

```bash
bash ./bootstrap-tailscale-macos.sh \
  --hostname macbook-admin \
  --verify-peer linux01-server \
  --verify-port 445 \
  --check-only
```

Windows:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\bootstrap-tailscale-windows.ps1 `
    -Hostname nova-ws02 `
    -VerifyPeer linux01-server `
    -VerifyPort 445 `
    -CheckOnly
```

Remove `-CheckOnly` and add `-Unattended` for a confirmed Windows deployment
that should remain connected without an interactive desktop login.

## Authorize a Client

Obtain the client's tailnet address on that client:

```bash
tailscale ip -4
```

Preview and then apply SMB-only access on the Ubuntu server:

```bash
sudo bash ./authorize-tailscale-client.sh \
  --client-ip 100.x.y.z \
  --client-name nova-ws02 \
  --service smb \
  --check-only

sudo bash ./authorize-tailscale-client.sh \
  --client-ip 100.x.y.z \
  --client-name nova-ws02 \
  --service smb
```

For an administrator workstation, repeat `--service` with both `ssh` and
`smb`. The helper accepts only Tailscale IPv4 space (`100.64.0.0/10`) and
requires UFW to be active.

## Download Without Cloning

Linux example:

```bash
curl -fL -o bootstrap-tailscale-linux.sh \
  https://raw.githubusercontent.com/Kinahi06/enterprise-infrastructure/main/02-Automation/bootstrap-tailscale-linux.sh
less bootstrap-tailscale-linux.sh
chmod 700 bootstrap-tailscale-linux.sh
```

Windows example:

```powershell
$Uri = 'https://raw.githubusercontent.com/Kinahi06/enterprise-infrastructure/main/02-Automation/bootstrap-tailscale-windows.ps1'
Invoke-WebRequest -Uri $Uri -OutFile '.\bootstrap-tailscale-windows.ps1'
Get-Content '.\bootstrap-tailscale-windows.ps1'
```

Reviewing the file is an approval step; the project deliberately avoids
executing an internet response directly through a privileged pipe.

## Optional Auth-Key File

Browser login is preferable for visible learning. Later unattended builds may
use a short-lived, scoped and preferably one-time auth key stored outside Git:

```bash
install -m 600 /dev/null ./tailscale-auth.key
nano ./tailscale-auth.key
sudo ./bootstrap-tailscale-linux.sh \
  --hostname linux02-server \
  --auth-key-file ./tailscale-auth.key
```

Remove the file after enrollment and revoke unused keys. Never place a key on
the command line, where history and process inspection can expose it.

## Acceptance Criteria

A deployment is complete when all applicable checks pass:

- intended node and peers appear in `tailscale status`;
- `tailscale ip -4` returns an address;
- peer test and required TCP port (`22` or `445`) succeed;
- real SSH or authenticated SMB read/write succeeds;
- UFW contains only intended client/service rules;
- check-only rerun succeeds without duplicates;
- no password, token or private key exists in Git history.

DERP relay output is not automatically a failure. It preserves encrypted
connectivity but usually adds latency; troubleshoot direct paths separately.

### Recorded Result — 2026-08-19

| Platform | Result on current enrolled node |
|---|---|
| Ubuntu | Bootstrap and exact UFW checks passed without changes |
| macOS | Check-only reached `linux01-server` TCP 445 |
| Windows | Parser, check-only, safe cancellation and confirmed wizard run passed |

The confirmed Windows run returned `TcpTestSucceeded : True`. Fresh-VM testing
is still required to validate first-time installation and browser enrollment.

## Logs and Rollback

| Platform | Log location |
|---|---|
| Ubuntu | `/var/log/enterprise-lab/tailscale-bootstrap.log` |
| macOS | `~/Library/Logs/EnterpriseLab` |
| Windows | `%ProgramData%\EnterpriseLab\Logs` when elevated |

Temporarily disconnect with `tailscale down` (`sudo` on Linux). Remove a node
from the admin console only after dependency review. The UFW helper never
deletes rules; inspect `sudo ufw status numbered` and remove only the exact
selected rule while console or second-session recovery remains available.

## References

- [Linux install](https://tailscale.com/docs/install/linux)
- [Windows install](https://tailscale.com/docs/install/windows)
- [macOS install](https://tailscale.com/docs/install/mac)
- [CLI reference](https://tailscale.com/docs/reference/tailscale-cli)
- [Secure auth keys](https://tailscale.com/docs/features/access-control/auth-keys/how-to/secure-auth-keys)
- [DERP troubleshooting](https://tailscale.com/docs/reference/troubleshooting/network-configuration/derp-routing)
