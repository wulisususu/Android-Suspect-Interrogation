from sqlalchemy.orm import Session

from app.database.models import Case, InterrogationSession
from app.database.session import init_database, make_engine
from app.repositories import asr_fragments as asr_repo
from app.repositories import question_rounds as rounds_repo
from app.services.interrogation_projection_service import InterrogationProjectionService


def test_deferred_question_can_still_be_ignored(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'deferred-ignore.db'}")
    init_database(engine)
    with Session(engine, expire_on_commit=False) as db:
        case = Case(id="CASE-DEFERRED-IGNORE", officer_name="测试警官")
        session = InterrogationSession(
            id="SESSION-DEFERRED-IGNORE",
            case_id=case.id,
            status="RUNNING",
            stage="QUESTIONING",
        )
        db.add_all([case, session])
        db.flush()
        capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=session.id,
            sample_rate=16000,
        )
        fragment = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case.id,
            ordinal=1,
            started_at_ms=1000,
            ended_at_ms=1600,
            raw_text="你为什么又回去了？",
            speaker="INTERROGATOR",
            speaker_source="MANUAL",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="test-asr",
        )
        pending = rounds_repo.create_pending(
            db,
            case_id=case.id,
            session_id=session.id,
            officer_fragment_id=fragment.id,
            question_text=fragment.edited_text,
            match_status="UNMATCHED",
        )
        pending.status = "DEFERRED"
        db.commit()

        result = InterrogationProjectionService(db).ignore_pending(pending.id)
        db.commit()

        assert result["status"] == "IGNORED"
        db.refresh(pending)
        assert pending.status == "IGNORED"

    engine.dispose()
