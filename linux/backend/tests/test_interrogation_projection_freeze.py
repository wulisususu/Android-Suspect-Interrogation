from __future__ import annotations

import json

import pytest
from sqlalchemy.orm import Session

from app.database.models import Case, InterrogationSession, QuestionRound
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.repositories import asr_fragments as asr_repo
from app.repositories import question_rounds as rounds_repo
from app.services.interrogation_projection_service import InterrogationProjectionService
from app.services.template_workspace_service import TemplateWorkspaceService


def test_frozen_formal_record_rejects_asr_projection_without_mutating_round(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'projection-freeze.db'}")
    init_database(engine)
    try:
        with Session(engine, expire_on_commit=False) as db:
            case = Case(id="CASE-PROJECTION-FROZEN", officer_name="测试警官")
            session = InterrogationSession(
                id="SESSION-PROJECTION-FROZEN",
                case_id=case.id,
                status="RUNNING",
                stage="QUESTIONING",
            )
            db.add_all([case, session])
            db.flush()

            question = TemplateWorkspaceService(db).add_case_question(
                case.id,
                text="你什么时候到现场？",
                source="CASE",
                regex_patterns=[r"什么时候.*现场"],
            )
            round_row = QuestionRound(
                id="ROUND-PROJECTION-FROZEN",
                case_id=case.id,
                session_id=session.id,
                case_question_id=question["id"],
                round_no=1,
                actual_question_text="你什么时候到现场？",
                answer_text="冻结前回答。",
                answer_fragment_ids_json="[]",
                status="ACTIVE",
            )
            db.add(round_row)

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
                raw_text="冻结以后不应写入正式笔录。",
                speaker="SUSPECT",
                speaker_source="MANUAL",
                voiceprint_verified=True,
                low_confidence=False,
                model_id="test-asr",
            )

            case.workflow_state = "FROZEN"
            case.document_status = "FROZEN"
            db.commit()

            with pytest.raises(DomainError) as error:
                InterrogationProjectionService(db).process_fragment(case.id, fragment.id)

            assert error.value.code == "FORMAL_RECORD_FROZEN"
            db.refresh(round_row)
            assert round_row.answer_text == "冻结前回答。"
            assert json.loads(round_row.answer_fragment_ids_json) == []
            assert asr_repo.get_processed(db, fragment.id) is None
            assert rounds_repo.active_round(db, case.id, session.id).id == round_row.id
    finally:
        engine.dispose()
