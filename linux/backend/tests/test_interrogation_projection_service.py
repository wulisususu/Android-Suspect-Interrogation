from __future__ import annotations

import json
from datetime import datetime, timezone

import pytest
from sqlalchemy.orm import Session

from app.database.models import Case, InterrogationSession, QuestionRound
from app.database.session import init_database, make_engine
from app.repositories import asr_fragments as asr_repo
from app.repositories import question_rounds as rounds_repo
from app.services.interrogation_projection_service import InterrogationProjectionService
from app.services.template_workspace_service import TemplateWorkspaceService


@pytest.fixture
def db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'projection.db'}")
    init_database(engine)
    with Session(engine, expire_on_commit=False) as session:
        yield session
        session.rollback()
    engine.dispose()


@pytest.fixture
def projection_context(db):
    case = Case(id="CASE-PROJECTION", officer_name="测试警官")
    session = InterrogationSession(
        id="SESSION-PROJECTION",
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
            voiceprint_verified=speaker != "UNKNOWN",
            low_confidence=speaker == "UNKNOWN",
            model_id="test-asr",
        )
        db.commit()
        return row

    return case, session, fragment


def add_question(db, case_id: str, text: str, pattern: str):
    return TemplateWorkspaceService(db).add_case_question(
        case_id,
        text=text,
        source="CASE",
        regex_patterns=[pattern],
    )


def add_round(
    db,
    *,
    case_id: str,
    session_id: str,
    question_id: str,
    round_no: int = 1,
    answer_text: str = "",
    answer_fragment_ids: list[str] | None = None,
    status: str = "ACTIVE",
    officer_fragment_id: str | None = None,
):
    row = QuestionRound(
        id=f"ROUND-{question_id}-{round_no}",
        case_id=case_id,
        session_id=session_id,
        case_question_id=question_id,
        round_no=round_no,
        actual_question_text="实际问话",
        officer_fragment_id=officer_fragment_id,
        answer_text=answer_text,
        answer_fragment_ids_json=json.dumps(answer_fragment_ids or []),
        status=status,
        started_at=datetime.now(timezone.utc),
    )
    db.add(row)
    db.commit()
    return row


def test_suspect_fragment_appends_to_active_round_once(db, projection_context):
    case, session, fragment = projection_context
    question = add_question(db, case.id, "你何时到现场？", r"什么时候.*现场")
    round_row = add_round(db, case_id=case.id, session_id=session.id, question_id=question["id"])
    suspect = fragment("SUSPECT", "我八点到的。")
    service = InterrogationProjectionService(db)

    first = service.process_fragment(case.id, suspect.id)
    db.commit()
    second = service.process_fragment(case.id, suspect.id)
    db.commit()
    db.refresh(round_row)

    assert round_row.answer_text == "我八点到的。"
    assert json.loads(round_row.answer_fragment_ids_json) == [suspect.id]
    assert first == second


def test_operational_police_instruction_does_not_close_active_round(db, projection_context):
    case, session, fragment = projection_context
    question = add_question(db, case.id, "你何时到现场？", r"什么时候.*现场")
    existing = add_round(db, case_id=case.id, session_id=session.id, question_id=question["id"])
    instruction = fragment("OFFICER_FALLBACK", "继续说。")

    result = InterrogationProjectionService(db).process_fragment(case.id, instruction.id)
    db.commit()

    assert result["status"] == "RAW_ONLY"
    assert rounds_repo.active_round(db, case.id, session.id).id == existing.id


def test_unknown_speaker_never_enters_formal_record(db, projection_context):
    case, session, fragment = projection_context
    question = add_question(db, case.id, "你何时到现场？", r"什么时候.*现场")
    existing = add_round(db, case_id=case.id, session_id=session.id, question_id=question["id"])
    unknown = fragment("UNKNOWN", "你什么时候到现场的？")

    result = InterrogationProjectionService(db).process_fragment(case.id, unknown.id)
    db.commit()
    db.refresh(existing)

    assert result["status"] == "RAW_ONLY"
    assert existing.status == "ACTIVE"
    assert rounds_repo.active_pending(db, case.id, session.id) is None


def test_unmatched_question_buffers_following_suspect_answer(db, projection_context):
    case, session, fragment = projection_context
    officer = fragment("INTERROGATOR", "你为什么又回去了？")
    service = InterrogationProjectionService(db)

    result = service.process_fragment(case.id, officer.id)
    db.commit()
    assert result["status"] == "UNMATCHED"

    suspect = fragment("SUSPECT", "我去拿钥匙。")
    service.process_fragment(case.id, suspect.id)
    db.commit()
    pending = rounds_repo.active_pending(db, case.id, session.id)

    assert pending is not None
    assert pending.buffered_answer_text == "我去拿钥匙。"
    assert json.loads(pending.buffered_fragment_ids_json) == [suspect.id]


def test_ambiguous_question_never_auto_links(db, projection_context):
    case, session, fragment = projection_context
    first = add_question(db, case.id, "你第一次何时到现场？", r"什么时候.*现场")
    second = add_question(db, case.id, "你第二次何时到现场？", r"什么时候.*现场")
    officer = fragment("INTERROGATOR", "你什么时候到现场的？")

    result = InterrogationProjectionService(db).process_fragment(case.id, officer.id)
    db.commit()

    assert result["status"] == "AMBIGUOUS"
    assert result["candidateQuestionIds"] == [first["id"], second["id"]]
    assert rounds_repo.active_round(db, case.id, session.id) is None


def test_repeated_matched_question_waits_for_new_round_choice(db, projection_context):
    case, session, fragment = projection_context
    question = add_question(db, case.id, "你何时到现场？", r"什么时候.*现场")
    add_round(
        db,
        case_id=case.id,
        session_id=session.id,
        question_id=question["id"],
        answer_text="第一次是下午三点。",
        status="CLOSED",
    )
    officer = fragment("INTERROGATOR", "你第二次什么时候到现场的？")
    service = InterrogationProjectionService(db)

    result = service.process_fragment(case.id, officer.id)
    db.commit()
    suspect = fragment("SUSPECT", "第二次是晚上九点。")
    service.process_fragment(case.id, suspect.id)
    db.commit()

    pending = rounds_repo.active_pending(db, case.id, session.id)
    assert result["status"] == "MATCHED_EXISTING"
    assert pending is not None
    assert pending.buffered_answer_text == "第二次是晚上九点。"

    linked = service.link_pending(pending.id, question["id"], round_mode="NEW_ROUND")
    db.commit()
    assert linked["roundNo"] == 2
    assert linked["answerText"] == "第二次是晚上九点。"
    assert linked["actualQuestionText"] == "你第二次什么时候到现场的？"


def test_append_existing_keeps_one_round_and_appends_buffer(db, projection_context):
    case, session, fragment = projection_context
    question = add_question(db, case.id, "你何时到现场？", r"什么时候.*现场")
    existing = add_round(
        db,
        case_id=case.id,
        session_id=session.id,
        question_id=question["id"],
        answer_text="下午三点。",
        status="CLOSED",
    )
    officer = fragment("RECORDER", "那你什么时候到现场的？")
    service = InterrogationProjectionService(db)
    service.process_fragment(case.id, officer.id)
    db.commit()
    suspect = fragment("SUSPECT", "我补充一下，是三点半。")
    service.process_fragment(case.id, suspect.id)
    db.commit()
    pending = rounds_repo.active_pending(db, case.id, session.id)

    linked = service.link_pending(pending.id, question["id"], round_mode="APPEND_EXISTING")
    db.commit()
    db.refresh(existing)

    assert linked["id"] == existing.id
    assert existing.answer_text == "下午三点。 我补充一下，是三点半。"
    assert len(rounds_repo.list_for_question(db, case.id, question["id"])) == 1


def test_add_pending_as_live_question_moves_complete_buffer(db, projection_context):
    case, session, fragment = projection_context
    current = add_question(db, case.id, "你叫什么名字？", r"叫什么名字")
    add_round(db, case_id=case.id, session_id=session.id, question_id=current["id"], status="CLOSED")
    officer = fragment("INTERROGATOR", "你为什么把钥匙带走了？")
    service = InterrogationProjectionService(db)
    service.process_fragment(case.id, officer.id)
    db.commit()
    suspect = fragment("SUSPECT", "因为我以为那是我的钥匙。")
    service.process_fragment(case.id, suspect.id)
    db.commit()
    pending = rounds_repo.active_pending(db, case.id, session.id)

    created = service.add_pending_as_question(pending.id, after_question_id=current["id"])
    db.commit()

    workspace = TemplateWorkspaceService(db).workspace(case.id)
    live = next(item for item in workspace["questions"] if item["id"] == created["caseQuestionId"])
    assert live["source"] == "LIVE"
    assert live["text"] == "你为什么把钥匙带走了？"
    assert created["answerText"] == "因为我以为那是我的钥匙。"


def test_ignore_pending_preserves_raw_asr_fragment(db, projection_context):
    case, _session, fragment = projection_context
    officer = fragment("INTERROGATOR", "你为什么又回去了？")
    service = InterrogationProjectionService(db)
    service.process_fragment(case.id, officer.id)
    db.commit()
    pending = next(row for row in [rounds_repo.active_pending(db, case.id, "SESSION-PROJECTION")] if row)
    before = (officer.raw_text, officer.edited_text, officer.speaker)

    result = service.ignore_pending(pending.id)
    db.commit()
    db.refresh(officer)

    assert result["status"] == "IGNORED"
    assert (officer.raw_text, officer.edited_text, officer.speaker) == before


def test_reassociate_round_moves_whole_round_without_editing_raw_fragments(db, projection_context):
    case, session, fragment = projection_context
    source = add_question(db, case.id, "你何时到现场？", r"什么时候.*现场")
    destination = add_question(db, case.id, "你为什么返回现场？", r"为什么.*现场")
    officer = fragment("INTERROGATOR", "你第二次为什么返回现场？")
    suspect = fragment("SUSPECT", "我回去拿东西。")
    existing = add_round(
        db,
        case_id=case.id,
        session_id=session.id,
        question_id=source["id"],
        answer_text=suspect.edited_text,
        answer_fragment_ids=[suspect.id],
        status="CLOSED",
        officer_fragment_id=officer.id,
    )
    before_officer = (officer.raw_text, officer.edited_text, officer.speaker)
    before_suspect = (suspect.raw_text, suspect.edited_text, suspect.speaker)

    moved = InterrogationProjectionService(db).reassociate_round(
        existing.id,
        case_question_id=destination["id"],
    )
    db.commit()
    db.refresh(officer)
    db.refresh(suspect)

    assert moved["caseQuestionId"] == destination["id"]
    assert moved["roundNo"] == 1
    assert moved["answerText"] == "我回去拿东西。"
    assert (officer.raw_text, officer.edited_text, officer.speaker) == before_officer
    assert (suspect.raw_text, suspect.edited_text, suspect.speaker) == before_suspect


def test_new_police_question_supersedes_unresolved_pending_answer_context(db, projection_context):
    case, session, fragment = projection_context
    matched_question = add_question(db, case.id, "你叫什么名字？", r"叫什么名字")
    service = InterrogationProjectionService(db)

    first_officer = fragment("INTERROGATOR", "你为什么又回去了？")
    first_result = service.process_fragment(case.id, first_officer.id)
    db.commit()
    old_pending = rounds_repo.active_pending(db, case.id, session.id)
    assert first_result["status"] == "UNMATCHED"
    assert old_pending is not None

    second_officer = fragment("INTERROGATOR", "你叫什么名字？")
    second_result = service.process_fragment(case.id, second_officer.id)
    db.commit()
    assert second_result["status"] == "MATCHED"

    suspect = fragment("SUSPECT", "我叫张三。")
    service.process_fragment(case.id, suspect.id)
    db.commit()
    db.refresh(old_pending)
    active = rounds_repo.active_round(db, case.id, session.id)

    assert old_pending.status == "DEFERRED"
    assert old_pending.buffered_answer_text == ""
    assert active is not None
    assert active.case_question_id == matched_question["id"]
    assert active.answer_text == "我叫张三。"
