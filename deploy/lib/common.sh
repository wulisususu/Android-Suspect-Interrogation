#!/usr/bin/env bash
set -euo pipefail

SUSPECT_SERVICE_USER="${SUSPECT_SERVICE_USER:-suspect-interrogation}"
SUSPECT_SERVICE_GROUP="${SUSPECT_SERVICE_GROUP:-suspect-interrogation}"
SUSPECT_OPT_DIR="${SUSPECT_OPT_DIR:-/opt/suspect-interrogation}"
SUSPECT_ETC_DIR="${SUSPECT_ETC_DIR:-/etc/suspect-interrogation}"
SUSPECT_DATA_DIR="${SUSPECT_DATA_DIR:-/var/lib/suspect-interrogation}"
SUSPECT_LOG_DIR="${SUSPECT_LOG_DIR:-/var/log/suspect-interrogation}"
SUSPECT_SYSTEMD_DIR="${SUSPECT_SYSTEMD_DIR:-/etc/systemd/system}"
SUSPECT_BACKUP_DIR="${SUSPECT_BACKUP_DIR:-${SUSPECT_DATA_DIR}/backups}"
SUSPECT_CURRENT_LINK="${SUSPECT_CURRENT_LINK:-${SUSPECT_OPT_DIR}/current}"
SUSPECT_RELEASES_DIR="${SUSPECT_RELEASES_DIR:-${SUSPECT_OPT_DIR}/releases}"
SUSPECT_DRY_RUN="${SUSPECT_DRY_RUN:-0}"

log() { printf '[release] %s\n' "$*" >&2; }
die() { log "ERROR: $*"; exit 1; }

require_root() {
  if [[ "$SUSPECT_DRY_RUN" != "1" && "${EUID:-$(id -u)}" -ne 0 ]]; then
    die "this command requires root (or SUSPECT_DRY_RUN=1 for test mode)"
  fi
}

ensure_dir() {
  local path="$1" mode="${2:-0750}"
  mkdir -p "$path"
  chmod "$mode" "$path" 2>/dev/null || true
}

systemctl_safe() {
  if [[ "$SUSPECT_DRY_RUN" == "1" ]]; then
    log "dry-run systemctl $*"
    return 0
  fi
  command -v systemctl >/dev/null 2>&1 || return 0
  systemctl "$@"
}

current_release() {
  if [[ -L "$SUSPECT_CURRENT_LINK" ]]; then
    readlink -f "$SUSPECT_CURRENT_LINK"
  fi
}

atomic_switch() {
  local target="$1" next_link="${SUSPECT_CURRENT_LINK}.next"
  [[ -d "$target" ]] || die "release target does not exist: $target"
  mkdir -p "$(dirname "$SUSPECT_CURRENT_LINK")"
  rm -f "$next_link"
  ln -s "$target" "$next_link"
  mv -Tf "$next_link" "$SUSPECT_CURRENT_LINK"
}
