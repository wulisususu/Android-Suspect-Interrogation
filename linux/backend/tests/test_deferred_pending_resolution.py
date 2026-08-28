from __future__ import annotations

from sqlalchemy.orm import Session

from app.database.models import Case, InterrogationSession
from app.database.session import init_database, make_engine
from app.repositories import asr_fragments as asr_repo
from app.repositories import question_rounds as rounds_repo
from app.services.interrogation_projection_service import InterrogationProjectionService
from app.services.template_workspace_service import TemplateWorkspaceService


def test_deferred_question_can_be_added_without_stealing_newer_active_round(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'deferred-resolution.db'}")
    init_database(engine)
    with Session(engine, expire_on_commit=False) as db:
        case = Case(id="CASE-DEFERRED", officer_name="测试警官")
        session = InterrogationSession(
            id="SESSION-DEFERRED",
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
        db.commit()

        matched = TemplateWorkspaceService(db).add_case_question(
            case.id,
            text="你叫什么名字？",
            source="CASE",
            regex_patterns=[r"叫什么名字"],
        )
        db.commit()

        ordinal = 0

        def fragment(speaker: str, text: str):
            nonlocal ordinal
            ordinal += 1
            row = asr_repo.create_fragment(
                db,
                capture_session_id=capture.id,
                case_id=case.id,
                ordinal=ordinal,
                started_at_ms=ordinal * 1000,
                ended_at_ms=ordinal * 1000 + 600,
                raw_text=text,
                speaker=speaker,
                speaker_source="MANUAL",
                voiceprint_verified=True,
                low_confidence=False,
                model_id="test-asr",
            )
            db.commit()
            return row

        service = InterrogationProjectionService(db)
        first_officer = fragment("INTERROGATOR", "你为什么又回去了？")
        service.process_fragment(case.id, first_officer.id)
        db.commit()
        deferred = rounds_repo.active_pending(db, case.id, session.id)
        assert deferred is not None

        first_answer = fragment("SUSPECT", "我去拿钥匙。")
        service.process_fragment(case.id, first_answer.id)
        db.commit()

        second_officer = fragment("INTERROGATOR", "你叫什么名字？")
        service.process_fragment(case.id, second_officer.id)
        db.commit()
        db.refresh(deferred)
        assert deferred.status == "DEFERRED"

        current = rounds_repo.active_round(db, case.id, session.id)
        assert current is not None
        assert current.case_question_id == matched["id"]

        added = service.add_pending_as_question(deferred.id)
        db.commit()

        active_after = rounds_repo.active_round(db, case.id, session.id)
        assert added["status"] == "CLOSED"
        assert added["answerText"] == "我去拿钥匙。"
        assert active_after is not None
        assert active_after.id == current.id

    engine.dispose()


def test_deferred_question_can_link_new_round_without_closing_newer_active_round(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'deferred-link.db'}")
    init_database(engine)
    with Session(engine, expire_on_commit=False) as db:
        case = Case(id="CASE-DEFERRED-LINK", officer_name="测试警官")
        session = InterrogationSession(
            id="SESSION-DEFERRED-LINK",
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
        db.commit()

        current_question = TemplateWorkspaceService(db).add_case_question(
            case.id,
            text="你叫什么名字？",
            source="CASE",
            regex_patterns=[r"叫什么名字"],
        )
        target_question = TemplateWorkspaceService(db).add_case_question(
            case.id,
            text="你何时到现场？",
            source="CASE",
            regex_patterns=[r"什么时候.*现场"],
        )
        db.commit()

        ordinal = 0

        def fragment(speaker: str, text: str):
            nonlocal ordinal
            ordinal += 1
            row = asr_repo.create_fragment(
                db,
                capture_session_id=capture.id,
                case_id=case.id,
                ordinal=ordinal,
                started_at_ms=ordinal * 1000,
                ended_at_ms=ordinal * 1000 + 600,
                raw_text=text,
                speaker=speaker,
                speaker_source="MANUAL",
                voiceprint_verified=True,
                low_confidence=False,
                model_id="test-asr",
            )
            db.commit()
            return row

        service = InterrogationProjectionService(db)
        first_officer = fragment("INTERROGATOR", "你为什么又回去了？")
        service.process_fragment(case.id, first_officer.id)
        db.commit()
        deferred = rounds_repo.active_pending(db, case.id, session.id)
        assert deferred is not None

        first_answer = fragment("SUSPECT", "我去拿钥匙。")
        service.process_fragment(case.id, first_answer.id)
        db.commit()

        second_officer = fragment("INTERROGATOR", "你叫什么名字？")
        service.process_fragment(case.id, second_officer.id)
        db.commit()
        db.refresh(deferred)
        assert deferred.status == "DEFERRED"

        current = rounds_repo.active_round(db, case.id, session.id)
        assert current is not None
        assert current.case_question_id == current_question["id"]

        linked = service.link_pending(deferred.id, target_question["id"], round_mode="NEW_ROUND")
        db.commit()

        active_after = rounds_repo.active_round(db, case.id, session.id)
        assert linked["status"] == "CLOSED"
        assert linked["caseQuestionId"] == target_question["id"]
        assert linked["answerText"] == "我去拿钥匙。"
        assert active_after is not None
        assert active_after.id == current.id

    engine.dispose()
