#!/usr/bin/env bash
set -euo pipefail
DATA_DIR="${SUSPECT_DATA_DIR:-/var/lib/suspect-interrogation}"
DB_PATH="${SUSPECT_DB_PATH:-${DATA_DIR}/interrogation.db}"
BACKUP_DIR="${SUSPECT_BACKUP_DIR:-${DATA_DIR}/backups}"
RETENTION="${SUSPECT_BACKUP_RETENTION:-7}"
PYTHON="${PYTHON:-python3}"
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

"$PYTHON" - "$DB_PATH" "$STAGE/data/$DB_BASE" <<'PY'
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
  --exclude="./audio" \
  --exclude="./audio/*" \
  --exclude="./$BACKUP_BASENAME" \
  -cf - . | tar -C "$STAGE/data" -xf -

"$PYTHON" - "$STAGE/data/$DB_BASE" "$DATA_DIR" "$STAGE/audio_manifest.json" <<'PY'
import hashlib, json, re, sqlite3, sys, wave
from pathlib import Path, PurePosixPath

db_path, data_root, output_path = map(Path, sys.argv[1:])
connection = sqlite3.connect(db_path)
connection.row_factory = sqlite3.Row
tables = {row[0] for row in connection.execute("SELECT name FROM sqlite_master WHERE type='table'")}
required = {"asr_capture_sessions", "asr_audio_segments"}
segments = []
if required & tables and not required <= tables:
    raise SystemExit("incomplete audio archive schema in database snapshot")
if required <= tables:
    rows = connection.execute(
        """SELECT s.relative_path, c.case_id, c.id AS capture_id,
                  c.audio_sample_count AS capture_samples, s.committed_samples
           FROM asr_audio_segments s
           JOIN asr_capture_sessions c ON c.id = s.capture_session_id
           WHERE s.committed_samples > 0
           ORDER BY s.relative_path"""
    ).fetchall()
    for row in rows:
        relative_path = row["relative_path"]
        path = PurePosixPath(relative_path)
        if (not isinstance(relative_path, str) or "\\" in relative_path
                or path.is_absolute() or path.parts[:1] != ("audio",)
                or len(path.parts) != 4 or path.parts[1] != row["case_id"]
                or path.parts[2] != row["capture_id"]
                or not re.fullmatch(r"segment-[0-9]+\.wav", path.name)):
            raise SystemExit(f"invalid archived audio path in database: {relative_path!r}")
        audio_path = data_root.joinpath(*path.parts)
        if audio_path.is_symlink() or not audio_path.is_file():
            raise SystemExit(f"committed audio segment is missing: {relative_path}")
        try:
            with wave.open(str(audio_path), "rb") as source:
                if source.getnchannels() != 1 or source.getsampwidth() != 2 or source.getframerate() != 16000:
                    raise SystemExit(f"committed audio segment format is invalid: {relative_path}")
                pcm = source.readframes(int(row["committed_samples"]))
                if len(pcm) != int(row["committed_samples"]) * 2:
                    raise SystemExit(f"committed audio segment is shorter than its checkpoint: {relative_path}")
        except (wave.Error, OSError) as error:
            raise SystemExit(f"cannot read committed audio segment {relative_path}: {error}")
        segments.append({
            "relativePath": relative_path,
            "caseId": row["case_id"],
            "captureId": row["capture_id"],
            "captureCommittedSamples": int(row["capture_samples"]),
            "segmentCommittedSamples": int(row["committed_samples"]),
            "sha256": hashlib.sha256(pcm).hexdigest(),
        })
connection.close()
output_path.write_text(json.dumps({"segments": segments}, ensure_ascii=False, sort_keys=True, indent=2) + "\n", encoding="utf-8")
PY

(
  cd "$STAGE/data"
  while IFS= read -r -d '' file; do sha256sum "$file"; done < <(find . -type f -print0 | sort -z)
) > "$STAGE/manifest.sha256"
printf 'created_utc=%s\ndb=%s\n' "$STAMP" "$DB_BASE" > "$STAGE/metadata.env"

# Build on the same filesystem and rename only after the archive is complete.
# Consumers therefore see either the previous backup set or a complete new file.
tar -C "$STAGE" -czf "$TMP_ARCHIVE" data manifest.sha256 metadata.env audio_manifest.json
mv -f "$TMP_ARCHIVE" "$ARCHIVE"

mapfile -t archives < <(find "$BACKUP_DIR" -maxdepth 1 -type f -name 'suspect-interrogation-*.tar.gz' -printf '%T@ %p\n' | sort -nr | cut -d' ' -f2-)
for ((i=RETENTION; i<${#archives[@]}; i++)); do rm -f -- "${archives[$i]}"; done
printf '%s\n' "$ARCHIVE"
