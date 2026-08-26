from pathlib import Path

from sqlalchemy import inspect, text
from sqlalchemy.orm import Session

from app.database.models import Case
from app.database.session import init_database, make_engine


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
