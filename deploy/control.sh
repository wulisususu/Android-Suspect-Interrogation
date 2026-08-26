#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/release.sh"

usage() {
  cat <<'EOF'
Usage: deploy/control.sh <command> [args]
Commands:
  install
  deploy [source]
  upgrade [source]
  health
  rollback [release]
  status
  backup
  restore <archive> [--yes]
EOF
}

install_runtime() {
  require_root
  if [[ "$SUSPECT_DRY_RUN" != "1" ]]; then
    getent group "$SUSPECT_SERVICE_GROUP" >/dev/null || groupadd --system "$SUSPECT_SERVICE_GROUP"
    id "$SUSPECT_SERVICE_USER" >/dev/null 2>&1 || useradd --system --gid "$SUSPECT_SERVICE_GROUP" --home-dir "$SUSPECT_DATA_DIR" --shell /usr/sbin/nologin "$SUSPECT_SERVICE_USER"
  fi
  ensure_dir "$SUSPECT_OPT_DIR" 0755
  ensure_dir "$SUSPECT_RELEASES_DIR" 0755
  ensure_dir "$SUSPECT_ETC_DIR" 0750
  ensure_dir "$SUSPECT_DATA_DIR" 0750
  ensure_dir "$SUSPECT_BACKUP_DIR" 0750
  ensure_dir "$SUSPECT_LOG_DIR" 0750
  if [[ "$SUSPECT_DRY_RUN" != "1" ]]; then
    chown -R "$SUSPECT_SERVICE_USER:$SUSPECT_SERVICE_GROUP" "$SUSPECT_DATA_DIR" "$SUSPECT_LOG_DIR"
    chown root:"$SUSPECT_SERVICE_GROUP" "$SUSPECT_ETC_DIR"
    if [[ ! -f "$SUSPECT_ETC_DIR/runtime.env" ]]; then
      install -o root -g "$SUSPECT_SERVICE_GROUP" -m 0640 "$SCRIPT_DIR/suspect-interrogation.env.example" "$SUSPECT_ETC_DIR/runtime.env"
    fi
    install -m 0644 "$REPO_ROOT/systemd/interrogation-api.service" "$SUSPECT_SYSTEMD_DIR/interrogation-api.service"
    install -m 0644 "$REPO_ROOT/systemd/ai-worker.service" "$SUSPECT_SYSTEMD_DIR/ai-worker.service"
    install -m 0644 "$REPO_ROOT/systemd/kiosk.service" "$SUSPECT_SYSTEMD_DIR/kiosk.service"
  fi
  systemctl_safe daemon-reload
  systemctl_safe enable interrogation-api.service kiosk.service
  log "installation layout prepared"
}

health_check() {
  local base="${SUSPECT_HEALTH_BASE_URL:-http://127.0.0.1:8000}"
  curl --fail --silent --show-error --max-time 3 "$base/health/live" >/dev/null
  local ready
  ready="$(curl --fail --silent --show-error --max-time 3 "$base/health/ready")"
  grep -Eq '"status"[[:space:]]*:[[:space:]]*"ready"' <<<"$ready"
  printf '%s\n' "$ready"
}

restart_runtime() {
  systemctl_safe restart interrogation-api.service
  systemctl_safe try-restart ai-worker.service || true
  systemctl_safe restart kiosk.service || true
}

deploy_release() {
  local source="${1:-$REPO_ROOT}" name destination previous
  source="$(cd "$source" && pwd)"
  name="$(release_name_for_source "$source")"
  destination="$SUSPECT_RELEASES_DIR/$name"
  previous="$(current_release || true)"
  ensure_dir "$SUSPECT_RELEASES_DIR" 0755
  stage_source_tree "$source" "$destination"
  install_python_dependencies "$destination"
  build_webapp "$destination"
  "$destination/scripts/check-release.sh" --staged "$destination"
  atomic_switch "$destination"
  if [[ "$SUSPECT_DRY_RUN" != "1" ]]; then
    restart_runtime
    if ! health_check >/dev/null; then
      log "new release failed health check"
      if [[ -n "$previous" && -d "$previous" ]]; then atomic_switch "$previous"; restart_runtime; log "rolled back to $previous"; fi
      return 1
    fi
  fi
  prune_releases
  printf '%s\n' "$destination"
}

rollback_release() {
  local requested="${1:-}" target
  if [[ -n "$requested" ]]; then
    if [[ "$requested" = /* ]]; then target="$requested"; else target="$SUSPECT_RELEASES_DIR/$requested"; fi
  else
    local current
    current="$(current_release || true)"
    target="$(find "$SUSPECT_RELEASES_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' | sort -nr | cut -d' ' -f2- | grep -Fvx "$current" | head -n1 || true)"
  fi
  [[ -n "$target" && -d "$target" ]] || die "rollback target not found"
  atomic_switch "$target"
  if [[ "$SUSPECT_DRY_RUN" != "1" ]]; then restart_runtime; health_check >/dev/null; fi
  printf '%s\n' "$target"
}

status_runtime() {
  printf 'current=%s\n' "$(current_release || printf 'none')"
  if command -v systemctl >/dev/null 2>&1 && [[ "$SUSPECT_DRY_RUN" != "1" ]]; then systemctl --no-pager --full status interrogation-api.service ai-worker.service kiosk.service || true; fi
}

case "${1:---help}" in
  --help|-h|help) usage ;;
  install) shift; install_runtime "$@" ;;
  deploy|upgrade) shift; deploy_release "$@" ;;
  health) shift; health_check "$@" ;;
  rollback) shift; rollback_release "$@" ;;
  status) shift; status_runtime "$@" ;;
  backup) shift; exec "$REPO_ROOT/scripts/backup.sh" "$@" ;;
  restore) shift; [[ $# -ge 1 ]] || die "restore requires archive"; exec "$REPO_ROOT/scripts/restore.sh" "$@" ;;
  *) usage >&2; exit 2 ;;
esac
