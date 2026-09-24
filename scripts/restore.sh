#!/usr/bin/env bash
set -euo pipefail
[[ $# -ge 1 ]] || { echo "usage: restore.sh <archive> [--yes]" >&2; exit 2; }
ARCHIVE="$1"; CONFIRM="${2:-}"
DATA_DIR="${SUSPECT_DATA_DIR:-/var/lib/suspect-interrogation}"
DB_PATH="${SUSPECT_DB_PATH:-${DATA_DIR}/interrogation.db}"
PYTHON="${PYTHON:-python3}"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
[[ -f "$ARCHIVE" ]] || { echo "archive not found: $ARCHIVE" >&2; exit 1; }
if [[ "$CONFIRM" != "--yes" ]]; then
  read -r -p "Restore $ARCHIVE into $DATA_DIR? type YES: " answer
  [[ "$answer" == "YES" ]] || { echo "restore cancelled" >&2; exit 1; }
fi

# Validate member names and types before tar extracts anything. Backup archives
# may contain regular files/directories only and may not escape their root.
"$PYTHON" - "$ARCHIVE" <<'PY'
from pathlib import PurePosixPath
import sys, tarfile
archive = sys.argv[1]
with tarfile.open(archive, "r:gz") as tf:
    for member in tf.getmembers():
        path = PurePosixPath(member.name)
        if path.is_absolute() or ".." in path.parts:
            raise SystemExit(f"unsafe archive path: {member.name}")
        if member.issym() or member.islnk() or member.isdev():
            raise SystemExit(f"unsafe archive member type: {member.name}")
        if path.parts and path.parts[0] not in {"data", "manifest.sha256", "metadata.env", "audio_manifest.json"}:
            raise SystemExit(f"unexpected archive root: {member.name}")
PY

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
tar -xzf "$ARCHIVE" -C "$TMP"
[[ -f "$TMP/manifest.sha256" && -d "$TMP/data" ]] || { echo "invalid backup archive" >&2; exit 1; }
(cd "$TMP/data" && sha256sum -c ../manifest.sha256)
DB_BASE="$(basename "$DB_PATH")"
[[ -f "$TMP/data/$DB_BASE" ]] || { echo "database missing from backup" >&2; exit 1; }
"$PYTHON" - "$TMP/data/$DB_BASE" <<'PY'
import sqlite3, sys
c=sqlite3.connect(sys.argv[1]); r=c.execute("PRAGMA integrity_check").fetchone()[0]; c.close()
if r != "ok": raise SystemExit(f"restore integrity_check failed: {r}")
PY

if [[ -f "$TMP/audio_manifest.json" ]]; then
  if ! "$PYTHON" - "$TMP/audio_manifest.json" "$TMP/data/$DB_BASE" "$DATA_DIR" <<'PY'
import hashlib, json, re, sqlite3, sys, wave
from pathlib import Path, PurePosixPath

manifest_path, db_path, data_root = map(Path, sys.argv[1:])
try:
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    if not isinstance(manifest, dict) or set(manifest) != {"segments"} or not isinstance(manifest["segments"], list):
        raise ValueError("invalid manifest shape")

    connection = sqlite3.connect(db_path)
    tables = {row[0] for row in connection.execute("SELECT name FROM sqlite_master WHERE type='table'")}
    required = {"asr_capture_sessions", "asr_audio_segments"}
    expected = {}
    if required & tables and not required <= tables:
        raise ValueError("incomplete audio archive schema in restored database")
    if required <= tables:
        for relative_path, case_id, capture_id, capture_samples, committed_samples in connection.execute(
            """SELECT s.relative_path, c.case_id, c.id, c.audio_sample_count, s.committed_samples
               FROM asr_audio_segments s JOIN asr_capture_sessions c ON c.id = s.capture_session_id
               WHERE s.committed_samples > 0"""
        ):
            expected[relative_path] = (case_id, capture_id, int(capture_samples), int(committed_samples))
    connection.close()

    if data_root.is_symlink():
        raise ValueError("audio data directory is a symlink")
    seen = set()
    actual = {}
    for item in manifest["segments"]:
        if not isinstance(item, dict) or set(item) != {
            "relativePath", "caseId", "captureId", "captureCommittedSamples", "segmentCommittedSamples", "sha256"
        }:
            raise ValueError("invalid manifest entry")
        relative_path = item["relativePath"]
        if not isinstance(relative_path, str) or "\\" in relative_path:
            raise ValueError("invalid audio path")
        path = PurePosixPath(relative_path)
        if (str(path) != relative_path or path.is_absolute() or path.parts[:1] != ("audio",)
                or len(path.parts) != 4 or path.parts[1] != item["caseId"]
                or path.parts[2] != item["captureId"]
                or not re.fullmatch(r"segment-[0-9]+\.wav", path.name)):
            raise ValueError("invalid audio path")
        if relative_path in seen:
            raise ValueError("duplicate audio path")
        seen.add(relative_path)
        counts = (item["caseId"], item["captureId"], item["captureCommittedSamples"], item["segmentCommittedSamples"])
        if not all(isinstance(value, int) and not isinstance(value, bool) and value >= 0 for value in counts[2:]):
            raise ValueError("invalid committed sample count")
        if counts[3] <= 0 or not re.fullmatch(r"[0-9a-f]{64}", str(item["sha256"])):
            raise ValueError("invalid audio digest or committed sample count")
        actual[relative_path] = counts

        audio_path = data_root.joinpath(*path.parts)
        current = data_root
        for part in path.parts:
            current = current / part
            if current.is_symlink():
                raise ValueError("audio evidence path contains a symlink")
        if not audio_path.is_file():
            raise FileNotFoundError(relative_path)
        with wave.open(str(audio_path), "rb") as source:
            if source.getnchannels() != 1 or source.getsampwidth() != 2 or source.getframerate() != 16000:
                raise ValueError("audio evidence format mismatch")
            pcm = source.readframes(counts[3])
            if len(pcm) != counts[3] * 2:
                raise ValueError("audio evidence is shorter than its committed checkpoint")
        if hashlib.sha256(pcm).hexdigest() != item["sha256"]:
            raise ValueError("audio evidence hash mismatch")

    if actual != expected:
        raise ValueError("audio manifest does not match restored database checkpoints")
except Exception as error:
    print(f"audio evidence incomplete: {error}", file=sys.stderr)
    raise SystemExit(3)
PY
  then
    exit 3
  fi
else
  echo "warning: legacy backup has no audio evidence manifest; preserving the existing audio archive" >&2
fi

mkdir -p "$DATA_DIR"
PREVIOUS="${DATA_DIR}.pre-restore-${STAMP}"
mkdir -p "$PREVIOUS"
find "$DATA_DIR" -mindepth 1 -maxdepth 1 ! -name audio -exec cp -a -- {} "$PREVIOUS/" \; 2>/dev/null || true
BACKUP_BASENAME="$(basename "${SUSPECT_BACKUP_DIR:-${DATA_DIR}/backups}")"
find "$DATA_DIR" -mindepth 1 -maxdepth 1 ! -name "$BACKUP_BASENAME" ! -name audio -exec rm -rf -- {} +
find "$TMP/data" -mindepth 1 -maxdepth 1 ! -name audio -exec cp -a -- {} "$DATA_DIR/" \;

"$PYTHON" - "$DB_PATH" <<'PY'
import sqlite3, sys
c=sqlite3.connect(sys.argv[1]); r=c.execute("PRAGMA integrity_check").fetchone()[0]; c.close()
if r != "ok": raise SystemExit(f"post-restore integrity_check failed: {r}")
PY
printf '%s\n' "$DATA_DIR"
