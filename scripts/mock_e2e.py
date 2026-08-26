#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import os
import sqlite3
import subprocess
from pathlib import Path

EVENTS = [
    "boot",
    "case_created",
    "identity_read",
    "session_start",
    "recording_mock",
    "asr_mock",
    "message_added",
    "ai_mock",
    "message_edit",
    "revision_created",
    "message_marked",
    "session_pause",
    "session_resume",
    "session_finish",
    "freeze",
    "signature_mock",
    "report_created",
    "service_restart",
    "data_verified",
    "backup_created",
    "restore_verified",
]


def event(conn: sqlite3.Connection, name: str, payload: dict | None = None) -> None:
    conn.execute(
        "INSERT INTO audit_events(name, payload) VALUES (?, ?)",
        (name, json.dumps(payload or {}, ensure_ascii=False, sort_keys=True)),
    )
    conn.commit()


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--state-dir", required=True)
    parser.add_argument("--backup-dir", required=True)
    args = parser.parse_args()

    root = Path(__file__).resolve().parents[1]
    state = Path(args.state_dir)
    backup_dir = Path(args.backup_dir)
    state.mkdir(parents=True, exist_ok=True)
    backup_dir.mkdir(parents=True, exist_ok=True)
    db = state / "interrogation.db"

    conn = sqlite3.connect(db)
    conn.execute("PRAGMA journal_mode=WAL")
    conn.execute("CREATE TABLE IF NOT EXISTS cases(id TEXT PRIMARY KEY, transcript TEXT, frozen_hash TEXT, signature TEXT)")
    conn.execute("CREATE TABLE IF NOT EXISTS audit_events(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, payload TEXT NOT NULL)")

    event(conn, "boot")
    conn.execute("INSERT INTO cases(id, transcript) VALUES (?, ?)", ("E2E-CASE-001", "initial statement"))
    conn.commit()
    event(conn, "case_created")
    event(conn, "identity_read", {"mock": True})
    event(conn, "session_start")
    event(conn, "recording_mock")
    event(conn, "asr_mock", {"text": "mock transcript"})
    event(conn, "message_added")
    event(conn, "ai_mock", {"offline": True})

    conn.execute("UPDATE cases SET transcript=? WHERE id=?", ("edited mock transcript", "E2E-CASE-001"))
    conn.commit()
    event(conn, "message_edit")
    event(conn, "revision_created", {"version": 2})
    event(conn, "message_marked")
    event(conn, "session_pause")
    event(conn, "session_resume")
    event(conn, "session_finish")

    canonical = json.dumps(
        {"case_id": "E2E-CASE-001", "transcript": "edited mock transcript", "version": 2},
        ensure_ascii=False,
        sort_keys=True,
        separators=(",", ":"),
    ).encode("utf-8")
    freeze_hash = hashlib.sha256(canonical).hexdigest()
    conn.execute("UPDATE cases SET frozen_hash=? WHERE id=?", (freeze_hash, "E2E-CASE-001"))
    conn.commit()
    event(conn, "freeze", {"sha256": freeze_hash})

    signature = f"mock-sha256:{freeze_hash}"
    conn.execute("UPDATE cases SET signature=? WHERE id=?", (signature, "E2E-CASE-001"))
    conn.commit()
    event(conn, "signature_mock", {"binding": signature})

    report = state / "report-E2E-CASE-001.json"
    report.write_text(
        json.dumps({"case_id": "E2E-CASE-001", "sha256": freeze_hash}, sort_keys=True),
        encoding="utf-8",
    )
    event(conn, "report_created")
    conn.close()

    restarted = sqlite3.connect(db)
    event(restarted, "service_restart")
    row = restarted.execute(
        "SELECT transcript, frozen_hash, signature FROM cases WHERE id=?",
        ("E2E-CASE-001",),
    ).fetchone()
    assert row == ("edited mock transcript", freeze_hash, signature)
    event(restarted, "data_verified")
    restarted.close()

    env = {
        **os.environ,
        "SUSPECT_DATA_DIR": os.fspath(state),
        "SUSPECT_DB_PATH": os.fspath(db),
        "SUSPECT_BACKUP_DIR": os.fspath(backup_dir),
        "SUSPECT_BACKUP_RETENTION": "3",
    }
    backup = subprocess.run(
        [os.fspath(root / "scripts" / "backup.sh")],
        env=env,
        check=True,
        text=True,
        capture_output=True,
    )
    archive = backup.stdout.strip().splitlines()[-1]

    destructive = sqlite3.connect(db)
    destructive.execute("DELETE FROM cases")
    destructive.commit()
    destructive.close()

    subprocess.run(
        [os.fspath(root / "scripts" / "restore.sh"), archive, "--yes"],
        env=env,
        check=True,
        text=True,
        capture_output=True,
    )

    restored = sqlite3.connect(db)
    restored_case = restored.execute("SELECT id, frozen_hash, signature FROM cases").fetchone()
    integrity = restored.execute("PRAGMA integrity_check").fetchone()[0]
    restored.close()
    assert restored_case == ("E2E-CASE-001", freeze_hash, signature)

    result = {
        "events": EVENTS,
        "case_id": "E2E-CASE-001",
        "freeze_sha256": freeze_hash,
        "signature_binding": signature,
        "restored_integrity": integrity,
        "model_downloads": 0,
    }
    print(json.dumps(result, ensure_ascii=False, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
