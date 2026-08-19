#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_NAME="$(basename "$0")"
CLIENT_IP=""
CLIENT_NAME=""
CHECK_ONLY=false
SERVICES=()
LOG_DIR="/var/log/enterprise-lab"
LOG_FILE="$LOG_DIR/tailscale-ufw.log"

usage() {
  cat <<EOF
Usage:
  sudo bash $SCRIPT_NAME
  sudo bash $SCRIPT_NAME --client-ip 100.x.y.z --client-name NAME \\
    --service ssh|smb [--service ssh|smb] [--check-only]

Adds least-privilege UFW rules on tailscale0. The script does not enable UFW,
does not remove existing rules and is safe to run repeatedly.
Run it without arguments to start the interactive authorization wizard.
EOF
}

log() {
  printf '[%s] %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$*"
}

die() {
  log "ERROR: $*" >&2
  exit 1
}

valid_client_name() {
  [[ "$1" =~ ^[A-Za-z0-9]([A-Za-z0-9._-]{0,62}[A-Za-z0-9])?$ ]]
}

valid_tailscale_ipv4() {
  local second_octet third_octet fourth_octet

  if [[ "$1" =~ ^100\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$ ]]; then
    second_octet=$((10#${BASH_REMATCH[1]}))
    third_octet=$((10#${BASH_REMATCH[2]}))
    fourth_octet=$((10#${BASH_REMATCH[3]}))
    ((second_octet >= 64 && second_octet <= 127 && \
      third_octet <= 255 && fourth_octet <= 255))
  else
    return 1
  fi
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
  [[ -t 0 ]] || die "client IP, name and service are required when input is not interactive"

  printf '\nTailscale UFW authorization wizard\n'
  printf 'This wizard adds exact rules and never enables UFW or deletes rules.\n\n'

  while [[ -z "$CLIENT_NAME" ]] || ! valid_client_name "$CLIENT_NAME"; do
    read -r -p "Client name (example: nova-ws02): " CLIENT_NAME
    valid_client_name "$CLIENT_NAME" || \
      printf 'Use letters, digits, dots, underscores or internal hyphens.\n'
  done

  while [[ -z "$CLIENT_IP" ]] || ! valid_tailscale_ipv4 "$CLIENT_IP"; do
    read -r -p "Client Tailscale IPv4 (100.x.y.z): " CLIENT_IP
    valid_tailscale_ipv4 "$CLIENT_IP" || \
      printf 'Enter an address inside Tailscale range 100.64.0.0/10.\n'
  done

  if ((${#SERVICES[@]} == 0)); then
    while ((${#SERVICES[@]} == 0)); do
      prompt_yes_no "Allow SSH administration (TCP 22)?" no && SERVICES+=("ssh")
      prompt_yes_no "Allow SMB file access (TCP 445)?" no && SERVICES+=("smb")
      ((${#SERVICES[@]} > 0)) || printf 'Select at least one service.\n'
    done
  fi

  printf '\nPlanned authorization:\n'
  printf '  Client:   %s (%s)\n' "$CLIENT_NAME" "$CLIENT_IP"
  printf '  Services:'
  printf ' %s' "${SERVICES[@]}"
  printf '\n  Mode:     %s\n\n' "$(if [[ "$CHECK_ONLY" == true ]]; then printf 'check only'; else printf 'add missing rules'; fi)"

  prompt_yes_no "Continue?" no || {
    log "Cancelled by user; no changes made"
    exit 0
  }
}

while (($#)); do
  case "$1" in
    --client-ip)
      (($# >= 2)) || die "--client-ip requires a value"
      CLIENT_IP="$2"
      shift 2
      ;;
    --client-name)
      (($# >= 2)) || die "--client-name requires a value"
      CLIENT_NAME="$2"
      shift 2
      ;;
    --service)
      (($# >= 2)) || die "--service requires a value"
      SERVICES+=("$2")
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

[[ $EUID -eq 0 ]] || die "run this script with sudo"

if [[ -z "$CLIENT_IP" || -z "$CLIENT_NAME" ]] || ((${#SERVICES[@]} == 0)); then
  run_wizard
fi

valid_client_name "$CLIENT_NAME" || \
  die "client name contains unsupported characters"

valid_tailscale_ipv4 "$CLIENT_IP" || \
  die "client IP must be a Tailscale IPv4 address in 100.64.0.0/10"

for service in "${SERVICES[@]}"; do
  [[ "$service" == "ssh" || "$service" == "smb" ]] || \
    die "unsupported service '$service'; use ssh or smb"
done

command -v ufw >/dev/null 2>&1 || die "UFW is not installed"
ip link show tailscale0 >/dev/null 2>&1 || die "tailscale0 is unavailable"
ufw_status="$(ufw status | head -n 1)"
[[ "$ufw_status" == "Status: active" ]] || \
  die "UFW is inactive; this script intentionally refuses to enable it"

install -d -m 0750 "$LOG_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

rule_exists() {
  local port="$1"
  ufw show added | grep -Fq \
    "ufw allow in on tailscale0 from $CLIENT_IP to any port $port proto tcp"
}

apply_service() {
  local service="$1"
  local port label comment

  case "$service" in
    ssh)
      port=22
      label="SSH"
      ;;
    smb)
      port=445
      label="SMB"
      ;;
  esac

  comment="$label $CLIENT_NAME via Tailscale"

  if rule_exists "$port"; then
    log "$label rule already exists for $CLIENT_IP; skipped"
  elif [[ "$CHECK_ONLY" == true ]]; then
    log "MISSING: $label from $CLIENT_IP on tailscale0"
    return 2
  else
    log "Adding $label access for $CLIENT_NAME ($CLIENT_IP)"
    ufw allow in on tailscale0 from "$CLIENT_IP" to any port "$port" \
      proto tcp comment "$comment"
  fi
}

log "Authorizing $CLIENT_NAME ($CLIENT_IP)"
result=0
for service in "${SERVICES[@]}"; do
  apply_service "$service" || result=$?
done

ufw status numbered

if ((result != 0)); then
  die "one or more requested rules are missing"
fi

if [[ "$CHECK_ONLY" == true ]]; then
  log "All requested rules are present; no changes made"
else
  log "Authorization completed successfully"
fi
