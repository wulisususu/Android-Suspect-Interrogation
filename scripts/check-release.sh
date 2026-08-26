#!/usr/bin/env bash
set -euo pipefail
DATA_DIR="${SUSPECT_DATA_DIR:-/var/lib/suspect-interrogation}"
ETC_DIR="${SUSPECT_ETC_DIR:-/etc/suspect-interrogation}"
LOG_DIR="${SUSPECT_LOG_DIR:-/var/log/suspect-interrogation}"
MIN_FREE_MB="${SUSPECT_MIN_FREE_MB:-256}"
STAGED=""; if [[ "${1:-}" == "--staged" ]]; then STAGED="${2:-}"; fi
for required in "$DATA_DIR" "$ETC_DIR" "$LOG_DIR"; do parent="$required"; [[ -e "$parent" ]] || parent="$(dirname "$required")"; [[ -e "$parent" ]] || { echo "missing required parent: $parent" >&2; exit 1; }; done
free_mb="$(df -Pm "$DATA_DIR" 2>/dev/null | awk 'NR==2 {print $4}')"
if [[ -n "$free_mb" && "$free_mb" -lt "$MIN_FREE_MB" ]]; then echo "low disk: ${free_mb}MB < ${MIN_FREE_MB}MB" >&2; exit 1; fi
if [[ -n "$STAGED" ]]; then
  [[ -f "$STAGED/linux/backend/app/main.py" ]] || exit 1
  [[ -f "$STAGED/webapp/package.json" ]] || exit 1
  bash -n "$STAGED/deploy/control.sh" "$STAGED/scripts/backup.sh" "$STAGED/scripts/restore.sh"
fi
echo "release preflight: ok"
