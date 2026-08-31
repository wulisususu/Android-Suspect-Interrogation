#!/usr/bin/env bash
set -euo pipefail
READY_URL="${SUSPECT_KIOSK_READY_URL:-https://127.0.0.1:18080/health/ready}"
APP_URL="${SUSPECT_KIOSK_URL:-https://127.0.0.1:18080/}"
ATTEMPTS="${SUSPECT_KIOSK_READY_ATTEMPTS:-30}"
SLEEP_SECONDS="${SUSPECT_KIOSK_READY_SLEEP_SECONDS:-2}"
MAINTENANCE_URL="${SUSPECT_KIOSK_MAINTENANCE_URL:-file:///opt/suspect-interrogation/current/deploy/maintenance.html}"
BROWSER="${SUSPECT_KIOSK_BROWSER:-}"
ready=0
for ((attempt=1; attempt<=ATTEMPTS; attempt++)); do
  if payload="$(curl -fsS --max-time 2 "$READY_URL" 2>/dev/null)" && grep -Eq '"status"[[:space:]]*:[[:space:]]*"ready"' <<<"$payload"; then ready=1; break; fi
  sleep "$SLEEP_SECONDS"
done
target="$APP_URL"; if [[ "$ready" -ne 1 ]]; then echo "backend not ready; opening maintenance page" >&2; target="$MAINTENANCE_URL"; fi
if [[ -z "$BROWSER" ]]; then for candidate in chromium-browser chromium google-chrome; do if command -v "$candidate" >/dev/null 2>&1; then BROWSER="$candidate"; break; fi; done; fi
[[ -n "$BROWSER" ]] || { echo "no kiosk browser found" >&2; exit 1; }
exec "$BROWSER" --kiosk --no-first-run --disable-session-crashed-bubble "$target"
