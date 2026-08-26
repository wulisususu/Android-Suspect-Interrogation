from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.database.models import Case, InterrogationSession, Message
from app.database.session import init_database, make_engine
from app.domain.enums import InterrogationStage, SessionStatus
from app.repositories import messages as message_repo


def make_db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'repo.sqlite3'}")
    init_database(engine)
    return engine, Session(engine)


def test_message_revision_preserves_identity_and_mark_does_not_duplicate(tmp_path):
    engine, db = make_db(tmp_path)
    try:
        db.add(Case(id="CASE-1", officer_name="警官"))
        db.add(InterrogationSession(
            id="SESSION-1", case_id="CASE-1", status=SessionStatus.RUNNING.value,
            stage=InterrogationStage.IDENTITY.value,
        ))
        db.commit()

        created = message_repo.create(db, case_id="CASE-1", session_id="SESSION-1", speaker="民警", text="你叫什么？")
        db.commit()
        original_id = created.id

        revised, revision = message_repo.revise(
            db, case_id="CASE-1", message_id=original_id, new_text="请说明你的姓名。", reason="联调修订", actor_id="officer-1"
        )
        message_repo.mark(db, case_id="CASE-1", message_id=original_id, mark="conflict")
        db.commit()

        assert revised.id == original_id
        assert revised.text == "请说明你的姓名。"
        assert revision.message_id == original_id
        assert revision.old_text == "你叫什么？"
        assert revision.new_text == "请说明你的姓名。"
        assert revision.version == 2
        assert db.scalar(select(func.count()).select_from(Message)) == 1
        assert db.get(Message, original_id).mark == "conflict"
    finally:
        db.close()
        engine.dispose()
