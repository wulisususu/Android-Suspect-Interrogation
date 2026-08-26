#!/usr/bin/env bash
set -euo pipefail
[[ $# -ge 1 ]] || { echo "usage: restore.sh <archive> [--yes]" >&2; exit 2; }
ARCHIVE="$1"; CONFIRM="${2:-}"
DATA_DIR="${SUSPECT_DATA_DIR:-/var/lib/suspect-interrogation}"
DB_PATH="${SUSPECT_DB_PATH:-${DATA_DIR}/interrogation.db}"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
[[ -f "$ARCHIVE" ]] || { echo "archive not found: $ARCHIVE" >&2; exit 1; }
if [[ "$CONFIRM" != "--yes" ]]; then read -r -p "Restore $ARCHIVE into $DATA_DIR? type YES: " answer; [[ "$answer" == "YES" ]] || exit 1; fi
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
tar -xzf "$ARCHIVE" -C "$TMP"
[[ -f "$TMP/manifest.sha256" && -d "$TMP/data" ]] || { echo "invalid backup archive" >&2; exit 1; }
(cd "$TMP/data" && sha256sum -c ../manifest.sha256)
DB_BASE="$(basename "$DB_PATH")"
[[ -f "$TMP/data/$DB_BASE" ]] || { echo "database missing from backup" >&2; exit 1; }
python3 - "$TMP/data/$DB_BASE" <<'PY'
import sqlite3, sys
c=sqlite3.connect(sys.argv[1]); r=c.execute("PRAGMA integrity_check").fetchone()[0]; c.close()
if r != "ok": raise SystemExit(f"restore integrity_check failed: {r}")
PY
mkdir -p "$DATA_DIR"
PREVIOUS="${DATA_DIR}.pre-restore-${STAMP}"
cp -a "$DATA_DIR" "$PREVIOUS" 2>/dev/null || true
BACKUP_BASENAME="$(basename "${SUSPECT_BACKUP_DIR:-${DATA_DIR}/backups}")"
find "$DATA_DIR" -mindepth 1 -maxdepth 1 ! -name "$BACKUP_BASENAME" -exec rm -rf -- {} +
cp -a "$TMP/data/." "$DATA_DIR/"
python3 - "$DB_PATH" <<'PY'
import sqlite3, sys
c=sqlite3.connect(sys.argv[1]); r=c.execute("PRAGMA integrity_check").fetchone()[0]; c.close()
if r != "ok": raise SystemExit(f"post-restore integrity_check failed: {r}")
PY
printf '%s\n' "$DATA_DIR"
