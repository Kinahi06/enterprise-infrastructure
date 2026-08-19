#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_NAME="$(basename "$0")"
HOSTNAME_VALUE=""
VERIFY_PEER=""
AUTH_KEY_FILE=""
CHECK_ONLY=false
LOG_DIR="/var/log/enterprise-lab"
LOG_FILE="$LOG_DIR/tailscale-bootstrap.log"

usage() {
  cat <<EOF
Usage:
  sudo bash $SCRIPT_NAME
  sudo bash $SCRIPT_NAME --hostname NAME [options]

Options:
  --hostname NAME       MagicDNS machine name (required in parameter mode).
  --verify-peer NAME    Tailnet peer to ping after configuration.
  --auth-key-file FILE  Read a Tailscale auth key from a protected file.
  --check-only          Validate the current installation without changing it.
  -h, --help            Show this help.

The script supports Ubuntu and never stores an auth key in the repository.
Without --auth-key-file, Tailscale displays an interactive browser login URL.
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

  printf '\nTailscale Ubuntu setup wizard\n'
  printf 'Passwords and authentication tokens are not collected by this script.\n\n'

  while [[ -z "$HOSTNAME_VALUE" ]] || ! valid_hostname "$HOSTNAME_VALUE"; do
    read -r -p "Device name (example: linux02-server): " HOSTNAME_VALUE
    valid_hostname "$HOSTNAME_VALUE" || \
      printf 'Use lowercase letters, digits and internal hyphens only.\n'
  done

  if [[ -z "$VERIFY_PEER" ]]; then
    read -r -p "Tailnet peer to verify after setup (optional): " VERIFY_PEER
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

if [[ "$CHECK_ONLY" == false && $EUID -ne 0 ]]; then
  die "run this script with sudo"
fi

if [[ -z "$HOSTNAME_VALUE" ]]; then
  run_wizard
fi

valid_hostname "$HOSTNAME_VALUE" || \
  die "hostname must contain lowercase letters, digits or internal hyphens"

if [[ $EUID -eq 0 ]]; then
  install -d -m 0750 "$LOG_DIR"
  exec 3>&1 4>&2
  exec > >(tee -a "$LOG_FILE") 2>&1
fi

tailscale_connected() {
  command -v tailscale >/dev/null 2>&1 && tailscale ip -4 >/dev/null 2>&1
}

validate_state() {
  command -v tailscale >/dev/null 2>&1 || die "Tailscale is not installed"
  systemctl is-enabled tailscaled
  systemctl is-active tailscaled
  log "Tailscale IPv4: $(tailscale ip -4)"
  tailscale status

  if [[ -n "$VERIFY_PEER" ]]; then
    log "Testing tailnet path to $VERIFY_PEER"
    tailscale ping --c 3 --until-direct=false "$VERIFY_PEER"
  fi
}

log "Starting $SCRIPT_NAME for $HOSTNAME_VALUE"

if [[ "$CHECK_ONLY" == true ]]; then
  validate_state
  log "Check completed without changes"
  exit 0
fi

[[ -r /etc/os-release ]] || die "/etc/os-release is unavailable"
# shellcheck disable=SC1091
source /etc/os-release
[[ "${ID:-}" == "ubuntu" ]] || die "this first version supports Ubuntu only"
[[ -n "${VERSION_CODENAME:-}" ]] || die "Ubuntu codename was not detected"

if ! command -v tailscale >/dev/null 2>&1; then
  log "Installing prerequisites"
  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl

  keyring_url="https://pkgs.tailscale.com/stable/ubuntu/${VERSION_CODENAME}.noarmor.gpg"
  repository_url="https://pkgs.tailscale.com/stable/ubuntu/${VERSION_CODENAME}.tailscale-keyring.list"
  temp_dir="$(mktemp -d)"
  trap 'rm -rf "$temp_dir"' EXIT

  log "Downloading the official Tailscale signing key and repository definition"
  curl -fsSL "$keyring_url" -o "$temp_dir/tailscale-archive-keyring.gpg"
  curl -fsSL "$repository_url" -o "$temp_dir/tailscale.list"

  install -d -m 0755 /usr/share/keyrings /etc/apt/sources.list.d
  install -m 0644 "$temp_dir/tailscale-archive-keyring.gpg" \
    /usr/share/keyrings/tailscale-archive-keyring.gpg
  install -m 0644 "$temp_dir/tailscale.list" \
    /etc/apt/sources.list.d/tailscale.list

  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y tailscale
else
  log "Tailscale is already installed; package installation skipped"
fi

systemctl enable --now tailscaled

if tailscale_connected; then
  log "Node is already authenticated; updating only its MagicDNS hostname"
  tailscale set --hostname="$HOSTNAME_VALUE"
else
  up_args=("--hostname=$HOSTNAME_VALUE")

  if [[ -n "$AUTH_KEY_FILE" ]]; then
    [[ -f "$AUTH_KEY_FILE" && -r "$AUTH_KEY_FILE" ]] || \
      die "auth-key file is not readable: $AUTH_KEY_FILE"

    auth_mode="$(stat -c '%a' "$AUTH_KEY_FILE")"
    auth_mode_decimal=$((8#$auth_mode))
    (( (auth_mode_decimal & 077) == 0 )) || \
      die "auth-key file permissions are too broad; use chmod 600"

    up_args+=("--auth-key=file:$AUTH_KEY_FILE")
    log "Authenticating with the protected auth-key file"
  else
    log "No auth-key file supplied; complete the browser authentication shown below"
  fi

  if [[ -z "$AUTH_KEY_FILE" ]]; then
    log "Browser authentication output is shown only on screen and is not logged"
    tailscale up "${up_args[@]}" >&3 2>&4
  else
    tailscale up "${up_args[@]}"
  fi
fi

validate_state
log "Bootstrap completed successfully"
