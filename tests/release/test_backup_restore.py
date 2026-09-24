import hashlib
import json
import os
import sqlite3
import subprocess
import tarfile
import wave
from pathlib import Path

from shell_scripts import native_script_path, script_command, script_environment


ROOT = Path(__file__).resolve().parents[2]


def _run(script: str, env: dict[str, str], *args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        script_command(ROOT / script, *args),
        cwd=ROOT,
        env=script_environment({**os.environ, **env}),
        check=True,
        text=True,
        capture_output=True,
    )


def test_backup_uses_consistent_sqlite_snapshot_and_restore_verifies_integrity(tmp_path):
    data_dir = tmp_path / "data"
    backup_dir = tmp_path / "backups"
    data_dir.mkdir()
    backup_dir.mkdir()
    db = data_dir / "interrogation.db"

    writer = sqlite3.connect(db)
    writer.execute("PRAGMA journal_mode=WAL")
    writer.execute("CREATE TABLE cases(id INTEGER PRIMARY KEY, value TEXT NOT NULL)")
    writer.execute("INSERT INTO cases(value) VALUES ('snapshot-row')")
    writer.commit()

    env = {
        "SUSPECT_DATA_DIR": os.fspath(data_dir),
        "SUSPECT_DB_PATH": os.fspath(db),
        "SUSPECT_BACKUP_DIR": os.fspath(backup_dir),
        "SUSPECT_BACKUP_RETENTION": "3",
    }
    backup = _run("scripts/backup.sh", env)
    archive = native_script_path(backup.stdout.strip().splitlines()[-1])
    assert archive.exists()

    writer.execute("INSERT INTO cases(value) VALUES ('after-backup')")
    writer.commit()
    writer.close()

    _run("scripts/restore.sh", env, os.fspath(archive), "--yes")

    restored = sqlite3.connect(db)
    rows = restored.execute("SELECT value FROM cases ORDER BY id").fetchall()
    integrity = restored.execute("PRAGMA integrity_check").fetchone()[0]
    restored.close()

    assert rows == [("snapshot-row",)]
    assert integrity == "ok"


def _write_audio_case(data_dir: Path, db: Path) -> tuple[Path, bytes]:
    case_id = "CASE-001"
    capture_id = "CAPTURE-001"
    relative_path = f"audio/{case_id}/{capture_id}/segment-000001.wav"
    audio_path = data_dir / relative_path
    audio_path.parent.mkdir(parents=True)
    pcm = b"\x12\x00\x34\x00" * 800
    with wave.open(os.fspath(audio_path), "wb") as output:
        output.setnchannels(1)
        output.setsampwidth(2)
        output.setframerate(16_000)
        output.writeframes(pcm)

    connection = sqlite3.connect(db)
    connection.executescript(
        """
        CREATE TABLE asr_capture_sessions (
            id TEXT PRIMARY KEY,
            case_id TEXT NOT NULL,
            audio_sample_count INTEGER NOT NULL
        );
        CREATE TABLE asr_audio_segments (
            id TEXT PRIMARY KEY,
            capture_session_id TEXT NOT NULL,
            sequence INTEGER NOT NULL,
            relative_path TEXT NOT NULL,
            start_sample INTEGER NOT NULL,
            committed_samples INTEGER NOT NULL,
            finalized_samples INTEGER NOT NULL,
            sha256 TEXT NOT NULL,
            status TEXT NOT NULL
        );
        """
    )
    connection.execute(
        "INSERT INTO asr_capture_sessions VALUES (?, ?, ?)",
        (capture_id, case_id, len(pcm) // 2),
    )
    connection.execute(
        "INSERT INTO asr_audio_segments VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
        (
            "segment-row-1", capture_id, 1, relative_path, 0, len(pcm) // 2,
            len(pcm) // 2, hashlib.sha256(pcm).hexdigest(), "FINALIZED",
        ),
    )
    connection.commit()
    connection.close()
    return audio_path, pcm


def test_backup_excludes_audio_bytes_and_restore_preserves_manifest_verified_audio(tmp_path):
    data_dir = tmp_path / "data"
    backup_dir = tmp_path / "backups"
    data_dir.mkdir()
    backup_dir.mkdir()
    db = data_dir / "interrogation.db"
    writer = sqlite3.connect(db)
    writer.execute("CREATE TABLE cases(id INTEGER PRIMARY KEY, value TEXT NOT NULL)")
    writer.execute("INSERT INTO cases(value) VALUES ('snapshot-row')")
    writer.commit()
    writer.close()
    audio_path, pcm = _write_audio_case(data_dir, db)
    mutable_file = data_dir / "operator-notes.json"
    mutable_file.write_text('{"retained": true}', encoding="utf-8")
    env = {
        "SUSPECT_DATA_DIR": os.fspath(data_dir),
        "SUSPECT_DB_PATH": os.fspath(db),
        "SUSPECT_BACKUP_DIR": os.fspath(backup_dir),
        "SUSPECT_BACKUP_RETENTION": "3",
    }

    result = _run("scripts/backup.sh", env)
    archive = native_script_path(result.stdout.strip().splitlines()[-1])
    with tarfile.open(archive, "r:gz") as saved:
        names = set(saved.getnames())
        assert "data/audio/CASE-001/CAPTURE-001/segment-000001.wav" not in names
        assert "data/operator-notes.json" in names
        manifest = json.load(saved.extractfile("audio_manifest.json"))
    assert manifest == {
        "segments": [{
            "relativePath": "audio/CASE-001/CAPTURE-001/segment-000001.wav",
            "caseId": "CASE-001",
            "captureId": "CAPTURE-001",
            "captureCommittedSamples": len(pcm) // 2,
            "segmentCommittedSamples": len(pcm) // 2,
            "sha256": hashlib.sha256(pcm).hexdigest(),
        }],
    }

    mutable_file.write_text('{"retained": false}', encoding="utf-8")
    audio_hash = hashlib.sha256(audio_path.read_bytes()).hexdigest()
    _run("scripts/restore.sh", env, os.fspath(archive), "--yes")

    restored = sqlite3.connect(db)
    assert restored.execute("SELECT value FROM cases").fetchall() == [("snapshot-row",)]
    restored.close()
    assert mutable_file.read_text(encoding="utf-8") == '{"retained": true}'
    assert hashlib.sha256(audio_path.read_bytes()).hexdigest() == audio_hash
    previous = next(tmp_path.glob("data.pre-restore-*"))
    assert not (previous / "audio").exists()


def test_restore_reports_missing_or_mismatched_manifest_audio_as_incomplete(tmp_path):
    for damaged in ("missing", "mismatched"):
        data_dir = tmp_path / damaged / "data"
        backup_dir = tmp_path / damaged / "backups"
        data_dir.mkdir(parents=True)
        backup_dir.mkdir()
        db = data_dir / "interrogation.db"
        writer = sqlite3.connect(db)
        writer.execute("CREATE TABLE cases(id INTEGER PRIMARY KEY, value TEXT NOT NULL)")
        writer.execute("INSERT INTO cases(value) VALUES ('snapshot-row')")
        writer.commit()
        writer.close()
        audio_path, _ = _write_audio_case(data_dir, db)
        env = {
            "SUSPECT_DATA_DIR": os.fspath(data_dir),
            "SUSPECT_DB_PATH": os.fspath(db),
            "SUSPECT_BACKUP_DIR": os.fspath(backup_dir),
        }
        archive = native_script_path(_run("scripts/backup.sh", env).stdout.strip().splitlines()[-1])
        if damaged == "missing":
            audio_path.unlink()
        else:
            with wave.open(os.fspath(audio_path), "rb") as source:
                params = source.getparams()
                pcm = bytearray(source.readframes(source.getnframes()))
            pcm[0] ^= 0xFF
            with wave.open(os.fspath(audio_path), "wb") as target:
                target.setparams(params)
                target.writeframes(pcm)

        result = subprocess.run(
            script_command(ROOT / "scripts" / "restore.sh", str(archive), "--yes"),
            cwd=ROOT,
            env=script_environment({**os.environ, **env}),
            check=False,
            text=True,
            capture_output=True,
        )
        assert result.returncode != 0
        assert "audio evidence incomplete" in (result.stdout + result.stderr)
        assert sqlite3.connect(db).execute("SELECT value FROM cases").fetchall() == [("snapshot-row",)]
