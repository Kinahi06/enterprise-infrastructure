#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_NAME="$(basename "$0")"
HOSTNAME_VALUE=""
VERIFY_PEER=""
VERIFY_PORT=0
AUTH_KEY_FILE=""
CHECK_ONLY=false
INSTALLER_URL="https://pkgs.tailscale.com/stable/Tailscale-latest-macos.pkg"
LOG_DIR="$HOME/Library/Logs/EnterpriseLab"
LOG_FILE="$LOG_DIR/tailscale-bootstrap.log"
TAILSCALE_CLI=""

usage() {
  cat <<EOF
Usage:
  bash $SCRIPT_NAME
  bash $SCRIPT_NAME --hostname NAME [options]

Options:
  --hostname NAME       MagicDNS machine name (required in parameter mode).
  --verify-peer NAME    Tailnet peer to test after configuration.
  --verify-port PORT    TCP port to test on --verify-peer.
  --auth-key-file FILE  Read a Tailscale auth key from a protected file.
  --check-only          Validate without installing or changing configuration.
  -h, --help            Show this help.

macOS requires interactive approval for its Tailscale system extension and VPN
configuration. This script automates everything else and pauses for that consent.
Run it without --hostname to start the interactive setup wizard.
EOF
}

log() {
  printf '[%s] %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$*"
}

die() {
  log "ERROR: $*" >&2
  exit 1
}

valid_hostname() {
  [[ "$1" =~ ^[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?$ ]]
}

valid_port() {
  [[ "$1" =~ ^[0-9]+$ ]] && ((10#$1 >= 0 && 10#$1 <= 65535))
}

prompt_yes_no() {
  local prompt="$1"
  local default_answer="${2:-no}"
  local reply suffix

  if [[ "$default_answer" == "yes" ]]; then
    suffix="[Y/n]"
  else
    suffix="[y/N]"
  fi

  while true; do
    read -r -p "$prompt $suffix " reply
    reply="${reply:-$default_answer}"
    case "$reply" in
      y|Y|yes|YES|Yes) return 0 ;;
      n|N|no|NO|No) return 1 ;;
      *) printf 'Please answer yes or no.\n' ;;
    esac
  done
}

run_wizard() {
  [[ -t 0 ]] || die "--hostname is required when input is not interactive"

  printf '\nTailscale macOS setup wizard\n'
  printf 'Passwords and authentication tokens are not collected by this script.\n\n'

  while [[ -z "$HOSTNAME_VALUE" ]] || ! valid_hostname "$HOSTNAME_VALUE"; do
    read -r -p "Device name (example: macbook-admin): " HOSTNAME_VALUE
    valid_hostname "$HOSTNAME_VALUE" || \
      printf 'Use lowercase letters, digits and internal hyphens only.\n'
  done

  if [[ -z "$VERIFY_PEER" ]]; then
    read -r -p "Tailnet peer to verify after setup (optional): " VERIFY_PEER
  fi

  if [[ -n "$VERIFY_PEER" ]] && ! valid_port "$VERIFY_PORT"; then
    printf 'The supplied verify port is invalid; enter it again.\n'
    VERIFY_PORT=0
  fi

  if [[ -n "$VERIFY_PEER" && "$VERIFY_PORT" == "0" ]]; then
    while true; do
      read -r -p "TCP port to verify on that peer (optional, 0 to skip): " VERIFY_PORT
      VERIFY_PORT="${VERIFY_PORT:-0}"
      if valid_port "$VERIFY_PORT"; then
        break
      fi
      printf 'Enter a number from 0 to 65535.\n'
    done
  fi

  if [[ "$CHECK_ONLY" == false && -z "$AUTH_KEY_FILE" ]] && \
    prompt_yes_no "Use a protected auth-key file instead of browser login?" no; then
    while [[ -z "$AUTH_KEY_FILE" ]]; do
      read -r -p "Path to auth-key file: " AUTH_KEY_FILE
      [[ -n "$AUTH_KEY_FILE" ]] || printf 'The path cannot be empty.\n'
    done
  fi

  printf '\nPlanned configuration:\n'
  printf '  Device name: %s\n' "$HOSTNAME_VALUE"
  printf '  Mode:        %s\n' "$(if [[ "$CHECK_ONLY" == true ]]; then printf 'check only'; else printf 'install/configure'; fi)"
  printf '  Verify peer: %s\n' "${VERIFY_PEER:-not requested}"
  printf '  Verify port: %s\n' "$(if [[ "$VERIFY_PORT" -gt 0 ]]; then printf '%s' "$VERIFY_PORT"; else printf 'not requested'; fi)"
  if [[ "$CHECK_ONLY" == false ]]; then
    printf '  Login:       %s\n' "$(if [[ -n "$AUTH_KEY_FILE" ]]; then printf 'protected auth-key file'; else printf 'interactive browser'; fi)"
  fi
  printf '\n'

  prompt_yes_no "Continue?" no || {
    log "Cancelled by user; no changes made"
    exit 0
  }
}

while (($#)); do
  case "$1" in
    --hostname)
      (($# >= 2)) || die "--hostname requires a value"
      HOSTNAME_VALUE="$2"
      shift 2
      ;;
    --verify-peer)
      (($# >= 2)) || die "--verify-peer requires a value"
      VERIFY_PEER="$2"
      shift 2
      ;;
    --verify-port)
      (($# >= 2)) || die "--verify-port requires a value"
      VERIFY_PORT="$2"
      shift 2
      ;;
    --auth-key-file)
      (($# >= 2)) || die "--auth-key-file requires a value"
      AUTH_KEY_FILE="$2"
      shift 2
      ;;
    --check-only)
      CHECK_ONLY=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1"
      ;;
  esac
done

[[ "$(uname -s)" == "Darwin" ]] || die "this script supports macOS only"

if [[ -z "$HOSTNAME_VALUE" ]]; then
  run_wizard
fi

valid_hostname "$HOSTNAME_VALUE" || \
  die "hostname must contain lowercase letters, digits or internal hyphens"
valid_port "$VERIFY_PORT" || die "verify port must be a number from 0 to 65535"

mkdir -p "$LOG_DIR"
exec 3>&1 4>&2
exec > >(tee -a "$LOG_FILE") 2>&1

find_tailscale_cli() {
  if command -v tailscale >/dev/null 2>&1; then
    TAILSCALE_CLI="$(command -v tailscale)"
  elif [[ -x /Applications/Tailscale.app/Contents/MacOS/Tailscale ]]; then
    TAILSCALE_CLI="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
  else
    TAILSCALE_CLI=""
  fi
}

ts() {
  TAILSCALE_BE_CLI=1 "$TAILSCALE_CLI" "$@"
}

tailscale_connected() {
  [[ -n "$TAILSCALE_CLI" ]] && ts ip -4 >/dev/null 2>&1
}

validate_state() {
  [[ -n "$TAILSCALE_CLI" ]] || die "Tailscale is not installed"
  ts version
  log "Tailscale IPv4: $(ts ip -4)"
  ts status

  if [[ -n "$VERIFY_PEER" ]]; then
    ts ping --c 3 --until-direct=false "$VERIFY_PEER"
  fi

  if [[ -n "$VERIFY_PEER" && "$VERIFY_PORT" -gt 0 ]]; then
    nc -G 2 -vz "$VERIFY_PEER" "$VERIFY_PORT"
  fi
}

log "Starting $SCRIPT_NAME for $HOSTNAME_VALUE"
find_tailscale_cli

if [[ "$CHECK_ONLY" == true ]]; then
  validate_state
  log "Check completed without changes"
  exit 0
fi

if [[ -z "$TAILSCALE_CLI" ]]; then
  temp_dir="$(mktemp -d)"
  trap 'rm -rf "$temp_dir"' EXIT
  package_path="$temp_dir/Tailscale-latest-macos.pkg"
  checksum_path="$package_path.sha256"

  log "Downloading the official standalone macOS package and checksum"
  curl -fsSL "$INSTALLER_URL" -o "$package_path"
  curl -fsSL "$INSTALLER_URL.sha256" -o "$checksum_path"

  expected_hash="$(awk '{print $1; exit}' "$checksum_path")"
  actual_hash="$(shasum -a 256 "$package_path" | awk '{print $1}')"
  [[ "$actual_hash" == "$expected_hash" ]] || die "installer checksum mismatch"

  log "Checksum verified; macOS will request an administrator password"
  sudo installer -pkg "$package_path" -target /
  open -a Tailscale

  cat <<'EOF'
Approve the Tailscale system extension and VPN configuration in System Settings,
then finish the application onboarding. Press Enter here when that is complete.
EOF
  read -r

  find_tailscale_cli
  [[ -n "$TAILSCALE_CLI" ]] || die "Tailscale CLI was not found after installation"
fi

if tailscale_connected; then
  log "Node is already authenticated; updating only its MagicDNS hostname"
  ts set --hostname="$HOSTNAME_VALUE"
else
  up_args=("--hostname=$HOSTNAME_VALUE")
  if [[ -n "$AUTH_KEY_FILE" ]]; then
    [[ -f "$AUTH_KEY_FILE" && -r "$AUTH_KEY_FILE" ]] || \
      die "auth-key file is not readable: $AUTH_KEY_FILE"

    auth_mode="$(stat -f '%Lp' "$AUTH_KEY_FILE")"
    auth_mode_decimal=$((8#$auth_mode))
    (( (auth_mode_decimal & 077) == 0 )) || \
      die "auth-key file permissions are too broad; use chmod 600"

    up_args+=("--auth-key=file:$AUTH_KEY_FILE")
    log "Authenticating with the supplied auth-key file"
  else
    log "Complete the browser authentication requested by Tailscale"
  fi
  if [[ -z "$AUTH_KEY_FILE" ]]; then
    log "Browser authentication output is shown only on screen and is not logged"
    ts up "${up_args[@]}" >&3 2>&4
  else
    ts up "${up_args[@]}"
  fi
fi

validate_state
log "Bootstrap completed successfully"
