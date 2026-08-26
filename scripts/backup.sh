#!/usr/bin/env bash
set -euo pipefail
DATA_DIR="${SUSPECT_DATA_DIR:-/var/lib/suspect-interrogation}"
DB_PATH="${SUSPECT_DB_PATH:-${DATA_DIR}/interrogation.db}"
BACKUP_DIR="${SUSPECT_BACKUP_DIR:-${DATA_DIR}/backups}"
RETENTION="${SUSPECT_BACKUP_RETENTION:-7}"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
ARCHIVE="$BACKUP_DIR/suspect-interrogation-$STAMP.tar.gz"
mkdir -p "$BACKUP_DIR"
[[ -d "$DATA_DIR" ]] || { echo "data directory missing: $DATA_DIR" >&2; exit 1; }
[[ -f "$DB_PATH" ]] || { echo "database missing: $DB_PATH" >&2; exit 1; }
[[ "$RETENTION" =~ ^[1-9][0-9]*$ ]] || { echo "invalid SUSPECT_BACKUP_RETENTION: $RETENTION" >&2; exit 2; }

# Avoid archiving symlinks from the mutable PII tree. A symlink could point
# outside DATA_DIR and turn a trusted restore into an arbitrary-file write.
unsafe_link="$(find "$DATA_DIR" -type l ! -path "$BACKUP_DIR" ! -path "$BACKUP_DIR/*" -print -quit 2>/dev/null || true)"
[[ -z "$unsafe_link" ]] || { echo "refusing backup with symlink in data tree: $unsafe_link" >&2; exit 1; }

if [[ -e "$ARCHIVE" ]]; then
  ARCHIVE="$BACKUP_DIR/suspect-interrogation-$STAMP-$RANDOM.tar.gz"
fi
TMP_ARCHIVE="$BACKUP_DIR/.$(basename "$ARCHIVE").tmp.$$"
STAGE="$(mktemp -d "$BACKUP_DIR/.stage-$STAMP-XXXXXX")"
trap 'rm -rf "$STAGE"; rm -f "$TMP_ARCHIVE"' EXIT
mkdir -p "$STAGE/data"
DB_BASE="$(basename "$DB_PATH")"

python3 - "$DB_PATH" "$STAGE/data/$DB_BASE" <<'PY'
import sqlite3, sys
src, dst = sys.argv[1:]
source = sqlite3.connect(src, timeout=5)
target = sqlite3.connect(dst)
try:
    source.backup(target)
    target.commit()
    result = target.execute("PRAGMA integrity_check").fetchone()[0]
    if result != "ok":
        raise SystemExit(f"backup integrity_check failed: {result}")
finally:
    target.close()
    source.close()
PY

BACKUP_BASENAME="$(basename "$BACKUP_DIR")"
tar -C "$DATA_DIR" \
  --exclude="./$DB_BASE" \
  --exclude="./$DB_BASE-wal" \
  --exclude="./$DB_BASE-shm" \
  --exclude="./$BACKUP_BASENAME" \
  -cf - . | tar -C "$STAGE/data" -xf -

(
  cd "$STAGE/data"
  while IFS= read -r -d '' file; do sha256sum "$file"; done < <(find . -type f -print0 | sort -z)
) > "$STAGE/manifest.sha256"
printf 'created_utc=%s\ndb=%s\n' "$STAMP" "$DB_BASE" > "$STAGE/metadata.env"

# Build on the same filesystem and rename only after the archive is complete.
# Consumers therefore see either the previous backup set or a complete new file.
tar -C "$STAGE" -czf "$TMP_ARCHIVE" data manifest.sha256 metadata.env
mv -f "$TMP_ARCHIVE" "$ARCHIVE"

mapfile -t archives < <(find "$BACKUP_DIR" -maxdepth 1 -type f -name 'suspect-interrogation-*.tar.gz' -printf '%T@ %p\n' | sort -nr | cut -d' ' -f2-)
for ((i=RETENTION; i<${#archives[@]}; i++)); do rm -f -- "${archives[$i]}"; done
printf '%s\n' "$ARCHIVE"
