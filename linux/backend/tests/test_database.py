from pathlib import Path
import threading
import time

import pytest
from sqlalchemy import inspect, text
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import Session

from app.database.models import ASRCaptureSession, ASRFragment, Case
from app.database.session import begin_sqlite_immediate, init_database, make_engine


REQUIRED_TABLES = {
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


def test_schema_has_required_tables_and_foreign_keys(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'db.sqlite3'}")
    init_database(engine)
    assert REQUIRED_TABLES.issubset(set(inspect(engine).get_table_names()))
    with engine.connect() as conn:
        assert conn.execute(text("PRAGMA foreign_keys")).scalar_one() == 1
        assert conn.execute(text("PRAGMA busy_timeout")).scalar_one() == 5000


def test_schema_has_durable_live_speech_tables(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'durable-live-speech.sqlite3'}")
    init_database(engine)
    tables = set(inspect(engine).get_table_names())
    assert {
        "asr_audio_segments",
        "asr_audio_frames",
        "live_speech_jobs",
        "asr_fragment_lineage",
    } <= tables


def test_fresh_schema_only_allows_unconfirmed_fragments_to_be_superseded(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'superseded-fragments.sqlite3'}")
    init_database(engine)
    with Session(engine) as db:
        case = Case(id="CASE-SUPERSEDED")
        capture = ASRCaptureSession(
            id="CAPTURE-SUPERSEDED", case_id=case.id, status="COMPLETE", sample_rate=16000,
        )
        confirmed = ASRFragment(
            id="FRAGMENT-CONFIRMED", capture_session_id=capture.id, case_id=case.id,
            ordinal=1, started_at_ms=0, ended_at_ms=1000, raw_text="confirmed", edited_text="confirmed",
            speaker="UNKNOWN", speaker_source="ASR", state="CONFIRMED", model_id="model-v1",
            confirmed_message_id=None,
        )
        pending = ASRFragment(
            id="FRAGMENT-PENDING", capture_session_id=capture.id, case_id=case.id,
            ordinal=2, started_at_ms=1000, ended_at_ms=2000, raw_text="pending", edited_text="pending",
            speaker="UNKNOWN", speaker_source="ASR", state="PENDING", model_id="model-v1",
            confirmed_message_id=None,
        )
        db.add(case)
        db.flush()
        db.add(capture)
        db.flush()
        db.add_all([confirmed, pending])
        db.commit()

    with pytest.raises(IntegrityError, match="confirmed fragments cannot be superseded"):
        with engine.begin() as connection:
            connection.execute(text(
                "UPDATE asr_fragments SET state='SUPERSEDED' WHERE id='FRAGMENT-CONFIRMED'"
            ))
    with engine.begin() as connection:
        connection.execute(text(
            "UPDATE asr_fragments SET state='SUPERSEDED' WHERE id='FRAGMENT-PENDING'"
        ))
    with engine.connect() as connection:
        rows = connection.execute(text(
            "SELECT id, state FROM asr_fragments WHERE id IN ('FRAGMENT-CONFIRMED', 'FRAGMENT-PENDING')"
        )).all()
        states = dict(rows)
    assert states == {"FRAGMENT-CONFIRMED": "CONFIRMED", "FRAGMENT-PENDING": "SUPERSEDED"}


def test_sqlite_immediate_write_lock_waits_for_the_current_writer(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'lock.sqlite3'}")
    init_database(engine)
    first = Session(engine)
    second = Session(engine)
    begin_sqlite_immediate(first)
    acquired: list[bool] = []

    def wait_for_writer_lock():
        begin_sqlite_immediate(second)
        acquired.append(True)
        second.commit()

    thread = threading.Thread(target=wait_for_writer_lock)
    thread.start()
    time.sleep(0.05)
    assert acquired == []
    first.commit()
    thread.join(timeout=1)
    assert acquired == [True]
    first.close()
    second.close()


def test_sqlite_data_survives_engine_restart(tmp_path: Path):
    db_path = tmp_path / "persist.sqlite3"
    url = f"sqlite:///{db_path}"
    engine = make_engine(url)
    init_database(engine)
    with Session(engine) as db:
        db.add(Case(id="CASE-PERSIST", officer_name="测试警官"))
        db.commit()
    engine.dispose()

    engine2 = make_engine(url)
    init_database(engine2)
    with Session(engine2) as db:
        item = db.get(Case, "CASE-PERSIST")
        assert item is not None
        assert item.officer_name == "测试警官"
