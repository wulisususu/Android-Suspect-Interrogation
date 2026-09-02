from __future__ import annotations

from datetime import datetime, timedelta, timezone

import pytest
from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.database.models import Case, CaseQuestion, InterrogationSession, QuestionRound
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo
from app.repositories import template_questions as question_repo
from app.services.formal_record_router import FormalRecordRouteDecision, RouteClass
from app.services.formal_record_routing_service import FormalRecordRoutingService
from app.services.template_workspace_service import TemplateWorkspaceService


def decision(kind: RouteClass, *, target=None, question=None, answer=None, confidence=0.9, reason="TEST"):
    return FormalRecordRouteDecision(
        classification=kind,
        target_question_id=target,
        formal_question=question,
        formal_answer=answer,
        confidence=confidence,
        candidate_question_ids=(),
        reason_code=reason,
        model_id="qwen3-4b-test",
    )


def as_utc(value: datetime) -> datetime:
    """Normalize SQLite's timezone-naive datetime round-trip for instant comparison."""
    if value.tzinfo is None:
        return value.replace(tzinfo=timezone.utc)
    return value.astimezone(timezone.utc)


def make_context(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'routing-service.db'}")
    init_database(engine)
    db = Session(engine, expire_on_commit=False)
    case = Case(id="CASE-ROUTE-SVC", officer_name="测试警官")
    session = InterrogationSession(id="SESSION-ROUTE-SVC", case_id=case.id, status="RUNNING", stage="QUESTIONING")
    db.add_all([case, session])
    db.flush()
    opening = CaseQuestion(
        id="Q-OPEN",
        case_id=case.id,
        source="CASE",
        text="你因何事来公安机关？",
        regex_patterns_json="[]",
        aliases_json="[]",
        section_type="OPENING",
        template_key="SUSPECT_INQUIRY_V1",
        template_item_key="opening-reason",
        locked=True,
        sort_order=10,
        active=True,
    )
    body1 = CaseQuestion(
        id="Q-BODY-1",
        case_id=case.id,
        source="CASE",
        text="你几点到现场？",
        regex_patterns_json="[]",
        aliases_json="[]",
        section_type="BODY",
        locked=False,
        sort_order=20,
        active=True,
    )
    body2 = CaseQuestion(
        id="Q-BODY-2",
        case_id=case.id,
        source="LIVE",
        text="你与王某是什么关系？",
        regex_patterns_json="[]",
        aliases_json="[]",
        section_type="BODY",
        locked=False,
        sort_order=30,
        active=True,
    )
    closing = CaseQuestion(
        id="Q-CLOSE",
        case_id=case.id,
        source="CASE",
        text="你还有什么要补充的？",
        regex_patterns_json="[]",
        aliases_json="[]",
        section_type="CLOSING",
        template_key="SUSPECT_INQUIRY_V1",
        template_item_key="closing-supplement",
        locked=True,
        sort_order=40,
        active=True,
    )
    db.add_all([opening, body1, body2, closing])
    db.flush()
    capture = asr_repo.create_capture_session(
        db,
        case_id=case.id,
        interrogation_session_id=session.id,
        sample_rate=16000,
    )
    capture.started_at = datetime(2026, 9, 1, 8, 0, tzinfo=timezone.utc)
    db.commit()
    return engine, db, case, session, capture, opening, body1, body2, closing


def make_unit(db, case, session, capture, *, ordinal_base: int, start_ms: int, question: str | None, answer: str):
    unit = qa_repo.create_open(
        db,
        case_id=case.id,
        session_id=session.id,
        started_at=capture.started_at + timedelta(milliseconds=start_ms),
    )
    position = 1
    if question is not None:
        q = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case.id,
            ordinal=ordinal_base,
            started_at_ms=start_ms,
            ended_at_ms=start_ms + 500,
            raw_text=question,
            speaker="INTERROGATOR",
            speaker_source="MANUAL",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="test-asr",
        )
        qa_repo.append_fragment(db, unit, fragment_id=q.id, role="QUESTION", position=position)
        position += 1
    a = asr_repo.create_fragment(
        db,
        capture_session_id=capture.id,
        case_id=case.id,
        ordinal=ordinal_base + 1,
        started_at_ms=start_ms + 700,
        ended_at_ms=start_ms + 1400,
        raw_text=answer,
        speaker="SUSPECT",
        speaker_source="MANUAL",
        voiceprint_verified=True,
        low_confidence=False,
        model_id="test-asr",
    )
    qa_repo.append_fragment(db, unit, fragment_id=a.id, role="ANSWER", position=position)
    qa_repo.close(
        db,
        unit,
        raw_question_text=question or "",
        raw_answer_text=answer,
        ended_at=capture.started_at + timedelta(milliseconds=start_ms + 1400),
    )
    db.commit()
    return unit


def test_a_preserves_fixed_question_and_updates_canonical_answer(tmp_path):
    engine, db, case, session, capture, opening, *_ = make_context(tmp_path)
    try:
        unit = make_unit(db, case, session, capture, ordinal_base=1, start_ms=0, question="今天为什么过来的？", answer="派出所通知我来的。")
        result = FormalRecordRoutingService(db).apply_auto(
            unit.id,
            decision(RouteClass.MATCH_FIXED, target=opening.id, answer="接到派出所通知后前来配合调查。"),
        )
        assert opening.text == "你因何事来公安机关？"
        assert opening.formal_answer_text == "接到派出所通知后前来配合调查。"
        assert result["status"] == "APPLIED"
        rounds = db.scalars(select(QuestionRound).where(QuestionRound.case_question_id == opening.id)).all()
        assert len(rounds) == 1
        assert rounds[0].actual_question_text == "今天为什么过来的？"
        assert rounds[0].answer_text == "派出所通知我来的。"
    finally:
        db.close(); engine.dispose()


def test_b_followup_creates_rounds_but_one_canonical_answer_and_keeps_first_asked(tmp_path):
    engine, db, case, session, capture, _opening, body1, *_ = make_context(tmp_path)
    try:
        service = FormalRecordRoutingService(db)
        first = make_unit(db, case, session, capture, ordinal_base=1, start_ms=1000, question="你几点到的？", answer="八点多。")
        service.apply_auto(first.id, decision(RouteClass.MATCH_EXISTING, target=body1.id, answer="大概八点多到达。"))
        first_asked = body1.first_asked_at
        second = make_unit(db, case, session, capture, ordinal_base=3, start_ms=5000, question="具体一点呢？", answer="八点十五左右。")
        service.apply_auto(second.id, decision(RouteClass.MATCH_EXISTING, target=body1.id, answer="大概八点十五分左右到达。"))
        assert body1.formal_answer_text == "大概八点十五分左右到达。"
        assert as_utc(body1.first_asked_at) == as_utc(first_asked)
        rounds = db.scalars(select(QuestionRound).where(QuestionRound.case_question_id == body1.id).order_by(QuestionRound.round_no)).all()
        assert [row.round_no for row in rounds] == [1, 2]
        assert as_utc(rounds[1].started_at) == as_utc(second.started_at)
    finally:
        db.close(); engine.dispose()


def test_c_creates_live_question_from_real_speech_and_canonical_answer(tmp_path):
    engine, db, case, session, capture, *_ = make_context(tmp_path)
    try:
        unit = make_unit(db, case, session, capture, ordinal_base=1, start_ms=2000, question="你后来有没有又回去？", answer="回去拿了手机。")
        result = FormalRecordRoutingService(db).apply_auto(
            unit.id,
            decision(
                RouteClass.CREATE_LIVE_FROM_SPEECH,
                question="你离开现场后是否再次返回？",
                answer="返回过一次，因为手机遗留在现场。",
            ),
        )
        created = question_repo.get_case(db, case.id, result["targetQuestionId"])
        assert created.source == "LIVE"
        assert created.text == "你离开现场后是否再次返回？"
        assert created.formal_answer_text == "返回过一次，因为手机遗留在现场。"
        assert as_utc(created.first_asked_at) == as_utc(unit.started_at)
    finally:
        db.close(); engine.dispose()


def test_c_without_officer_fragment_degrades_to_review_without_formal_mutation(tmp_path):
    engine, db, case, session, capture, *_ = make_context(tmp_path)
    try:
        before_questions = db.scalar(select(func.count()).select_from(CaseQuestion))
        unit = make_unit(db, case, session, capture, ordinal_base=1, start_ms=0, question=None, answer="我当时在家。")
        result = FormalRecordRoutingService(db).apply_auto(
            unit.id,
            decision(RouteClass.CREATE_LIVE_FROM_SPEECH, question="你当时在哪里？", answer="当时在家。"),
        )
        assert result["status"] == "NEEDS_REVIEW"
        assert db.scalar(select(func.count()).select_from(CaseQuestion)) == before_questions
        assert db.scalar(select(func.count()).select_from(QuestionRound)) == 0
    finally:
        db.close(); engine.dispose()


def test_d_and_e_do_not_mutate_formal_record(tmp_path):
    engine, db, case, session, capture, *_ = make_context(tmp_path)
    try:
        service = FormalRecordRoutingService(db)
        d_unit = make_unit(db, case, session, capture, ordinal_base=1, start_ms=0, question="这个怎么说？", answer="我不确定。")
        before_q = db.scalar(select(func.count()).select_from(CaseQuestion))
        assert service.apply_auto(d_unit.id, decision(RouteClass.NEEDS_REVIEW, reason="AMBIGUOUS"))["status"] == "NEEDS_REVIEW"
        assert db.scalar(select(func.count()).select_from(CaseQuestion)) == before_q
        assert db.scalar(select(func.count()).select_from(QuestionRound)) == 0
        e_unit = make_unit(db, case, session, capture, ordinal_base=3, start_ms=5000, question="声音大一点", answer="好。")
        assert service.apply_auto(e_unit.id, decision(RouteClass.IGNORE, reason="OPERATIONAL"))["status"] == "IGNORED"
        assert db.scalar(select(func.count()).select_from(QuestionRound)) == 0
    finally:
        db.close(); engine.dispose()


def test_auto_formal_mutation_is_blocked_after_freeze(tmp_path):
    engine, db, case, session, capture, _opening, body1, *_ = make_context(tmp_path)
    try:
        unit = make_unit(db, case, session, capture, ordinal_base=1, start_ms=0, question="几点到的？", answer="八点。")
        case.workflow_state = "FROZEN"
        db.commit()
        with pytest.raises(DomainError, match="冻结"):
            FormalRecordRoutingService(db).apply_auto(
                unit.id,
                decision(RouteClass.MATCH_EXISTING, target=body1.id, answer="八点到达。"),
            )
    finally:
        db.close(); engine.dispose()


def test_body_order_uses_first_actual_ask_while_fixed_boundaries_remain(tmp_path):
    engine, db, case, session, capture, opening, body1, body2, closing = make_context(tmp_path)
    try:
        service = FormalRecordRoutingService(db)
        early = make_unit(db, case, session, capture, ordinal_base=1, start_ms=1000, question="你和王某熟吗？", answer="认识。")
        service.apply_auto(early.id, decision(RouteClass.MATCH_EXISTING, target=body2.id, answer="与王某认识。"))
        late = make_unit(db, case, session, capture, ordinal_base=3, start_ms=8000, question="几点到现场？", answer="八点。")
        service.apply_auto(late.id, decision(RouteClass.MATCH_EXISTING, target=body1.id, answer="八点到达。"))
        rows = TemplateWorkspaceService(db).workspace(case.id)["questions"]
        assert [row["id"] for row in rows] == [opening.id, body2.id, body1.id, closing.id]
    finally:
        db.close(); engine.dispose()
