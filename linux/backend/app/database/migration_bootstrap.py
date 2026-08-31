from __future__ import annotations

import sqlite3
import sys
from pathlib import Path


REV_0001 = "0001_linux_core_schema"
REV_0002 = "0002_voiceprint_speech_pipeline"
REV_0003 = "0003_template_interrogation_workspace"

CORE_TABLES = {
    "cases",
    "persons",
    "interrogation_sessions",
    "messages",
    "message_revisions",
    "facts",
    "timeline_events",
    "audit_logs",
    "device_events",
    "document_snapshots",
    "signature_records",
}
VOICEPRINT_TABLES = {
    "suspect_voiceprints",
    "officer_voiceprints",
    "session_voice_assignments",
    "asr_capture_sessions",
    "asr_fragments",
}
TEMPLATE_TABLES = {
    "standard_questions",
    "case_questions",
    "question_rounds",
    "pending_questions",
    "processed_speech_fragments",
}
NEWER_TABLES = {
    "officer_voice_profiles",
    "officer_voice_samples",
    "session_officer_voice_snapshots",
    "speaker_device_calibrations",
    "session_speaker_calibration_snapshots",
    "asr_recognition_evidence",
    "asr_recognition_revisions",
}

_RANK = {REV_0001: 1, REV_0002: 2, REV_0003: 3}


def _table_names(connection: sqlite3.Connection) -> set[str]:
    rows = connection.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall()
    return {str(row[0]) for row in rows}


def _current_revision(connection: sqlite3.Connection, tables: set[str]) -> str | None:
    if "alembic_version" not in tables:
        return None
    row = connection.execute("SELECT version_num FROM alembic_version LIMIT 1").fetchone()
    return None if row is None else str(row[0])


def _assert_group_not_partial(tables: set[str], group: set[str], label: str) -> None:
    present = tables & group
    if present and not group <= tables:
        missing = ", ".join(sorted(group - tables))
        raise RuntimeError(f"partial legacy migration schema at {label}; missing: {missing}")


def detect_legacy_baseline(db_path: str | Path) -> str | None:
    """Return a safe Alembic stamp target for a pre-Alembic SQLite database.

    Only the historical 0001-0003 schema is eligible for automatic adoption.
    Newer migrations include data transformation/backfill work and therefore
    must never be inferred merely from table existence.
    """

    path = Path(db_path)
    if not path.exists():
        return None

    connection = sqlite3.connect(str(path))
    try:
        tables = _table_names(connection)
        current = _current_revision(connection, tables)

        if current is not None and current not in _RANK:
            return None

        if tables & NEWER_TABLES:
            if current is None or current in _RANK:
                unexpected = ", ".join(sorted(tables & NEWER_TABLES))
                raise RuntimeError(
                    "newer migration tables exist without a trusted newer Alembic revision: " + unexpected
                )
            return None

        _assert_group_not_partial(tables, VOICEPRINT_TABLES, REV_0002)
        _assert_group_not_partial(tables, TEMPLATE_TABLES, REV_0003)

        target: str | None = None
        if CORE_TABLES <= tables:
            target = REV_0001
        if CORE_TABLES <= tables and VOICEPRINT_TABLES <= tables:
            target = REV_0002
        if CORE_TABLES <= tables and VOICEPRINT_TABLES <= tables and TEMPLATE_TABLES <= tables:
            target = REV_0003

        if target is None:
            return None
        if current is not None and _RANK[current] >= _RANK[target]:
            return None
        return target
    finally:
        connection.close()


def main(argv: list[str] | None = None) -> int:
    args = list(sys.argv[1:] if argv is None else argv)
    if len(args) != 1:
        print("usage: python -m app.database.migration_bootstrap <sqlite-db-path>", file=sys.stderr)
        return 2
    revision = detect_legacy_baseline(args[0])
    if revision:
        print(revision)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
