import os
import sqlite3
import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def _run(script: str, env: dict[str, str], *args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [str(ROOT / script), *args],
        cwd=ROOT,
        env={**os.environ, **env},
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
    archive = Path(backup.stdout.strip().splitlines()[-1])
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
