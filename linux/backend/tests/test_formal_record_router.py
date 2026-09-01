from __future__ import annotations

import json
from dataclasses import dataclass
from datetime import datetime, timezone

import pytest
from sqlalchemy.orm import Session

from app.ai.types import AITextResult
from app.database.models import Case, CaseQuestion, InterrogationSession
from app.database.session import init_database, make_engine
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo
from app.services.formal_record_router import FormalRecordRouter, RouteClass


@dataclass
class FakeSupervisor:
    text: str | None = None
    error: Exception | None = None
    model_id: str = "qwen3-4b-test"

    def __post_init__(self):
        self.calls: list[dict] = []

    def generate(self, prompt: str, *, session_id: str, options: dict | None = None):
        self.calls.append({"prompt": prompt, "session_id": session_id, "options": options or {}})
        if self.error is not None:
            raise self.error
        return AITextResult(text=self.text or "{}", model_id=self.model_id, session_id=session_id)


def make_context(tmp_path, *, with_question_fragment: bool = True):
    engine = make_engine(f"sqlite:///{tmp_path / 'formal-router.db'}")
    init_database(engine)
    db = Session(engine, expire_on_commit=False)
    case = Case(id="CASE-ROUTER", officer_name="测试警官")
    session = InterrogationSession(id="SESSION-ROUTER", case_id=case.id, status="RUNNING", stage="QUESTIONING")
    db.add_all([case, session])
    fixed = CaseQuestion(
        id="Q-FIXED",
        case_id=case.id,
        source="CASE",
        standard_question_id=None,
        text="你因何事来公安机关？",
        regex_patterns_json="[]",
        aliases_json="[]",
        section_type="OPENING",
        template_key="SUSPECT_INQUIRY_V1",
        template_item_key="opening-reason",
        locked=True,
        formal_answer_text="此前回答",
        sort_order=10,
        active=True,
    )
    dynamic = CaseQuestion(
        id="Q-LIVE",
        case_id=case.id,
        source="LIVE",
        standard_question_id=None,
        text="你与王某是什么关系？",
        regex_patterns_json="[]",
        aliases_json="[]",
        section_type="BODY",
        locked=False,
        formal_answer_text="认识三年",
        sort_order=20,
        active=True,
    )
    db.add_all([fixed, dynamic])
    db.flush()
    capture = asr_repo.create_capture_session(
        db,
        case_id=case.id,
        interrogation_session_id=session.id,
        sample_rate=16000,
    )
    capture.started_at = datetime(2026, 9, 1, 8, 0, tzinfo=timezone.utc)
    db.flush()
    unit = qa_repo.create_open(db, case_id=case.id, session_id=session.id, started_at=capture.started_at)
    position = 1
    if with_question_fragment:
        question = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case.id,
            ordinal=1,
            started_at_ms=0,
            ended_at_ms=800,
            raw_text="今天为什么过来的？",
            speaker="INTERROGATOR",
            speaker_source="MANUAL",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="test-asr",
        )
        qa_repo.append_fragment(db, unit, fragment_id=question.id, role="QUESTION", position=position)
        position += 1
    answer = asr_repo.create_fragment(
        db,
        capture_session_id=capture.id,
        case_id=case.id,
        ordinal=2,
        started_at_ms=1000,
        ended_at_ms=2000,
        raw_text="派出所通知我过来配合调查。",
        speaker="SUSPECT",
        speaker_source="MANUAL",
        voiceprint_verified=True,
        low_confidence=False,
        model_id="test-asr",
    )
    qa_repo.append_fragment(db, unit, fragment_id=answer.id, role="ANSWER", position=position)
    qa_repo.close(
        db,
        unit,
        raw_question_text="今天为什么过来的？" if with_question_fragment else "",
        raw_answer_text="派出所通知我过来配合调查。",
        ended_at=datetime(2026, 9, 1, 8, 0, 2, tzinfo=timezone.utc),
    )
    db.commit()
    return engine, db, case, unit, fixed, dynamic


def route_payload(classification: str, *, target: str | None, question=None, answer="整理后的回答", confidence=0.94, candidates=None):
    return json.dumps(
        {
            "classification": classification,
            "target_question_id": target,
            "formal_question": question,
            "formal_answer": answer,
            "confidence": confidence,
            "candidate_question_ids": candidates or [],
            "reason_code": "SEMANTIC_MATCH",
        },
        ensure_ascii=False,
    )


def test_direct_json_match_fixed_and_prompt_contract(tmp_path):
    engine, db, _case, unit, fixed, _dynamic = make_context(tmp_path)
    try:
        supervisor = FakeSupervisor(text=route_payload("MATCH_FIXED", target=fixed.id))
        decision = FormalRecordRouter(db, ai_supervisor=supervisor).route(unit.id)
        assert decision.classification is RouteClass.MATCH_FIXED
        assert decision.target_question_id == fixed.id
        assert decision.formal_answer == "整理后的回答"
        assert decision.model_id == "qwen3-4b-test"
        call = supervisor.calls[0]
        assert call["session_id"] == f"formal-route:{unit.id}"
        assert call["options"] == {
            "temperature": 0.1,
            "top_p": 0.8,
            "max_tokens": 192,
            "enable_thinking": False,
        }
        prompt = call["prompt"]
        assert "今天为什么过来的？" in prompt
        assert "派出所通知我过来配合调查。" in prompt
        assert "Q-FIXED" in prompt and "Q-LIVE" in prompt
        assert "此前回答" in prompt and "认识三年" in prompt
        for label in ("MATCH_FIXED", "MATCH_EXISTING", "CREATE_LIVE_FROM_SPEECH", "NEEDS_REVIEW", "IGNORE"):
            assert label in prompt
        assert "JSON" in prompt
    finally:
        db.close()
        engine.dispose()


def test_single_fenced_json_block_is_accepted(tmp_path):
    engine, db, _case, unit, _fixed, dynamic = make_context(tmp_path)
    try:
        raw = route_payload("MATCH_EXISTING", target=dynamic.id)
        supervisor = FakeSupervisor(text=f"```json\n{raw}\n```")
        decision = FormalRecordRouter(db, ai_supervisor=supervisor).route(unit.id)
        assert decision.classification is RouteClass.MATCH_EXISTING
        assert decision.target_question_id == dynamic.id
    finally:
        db.close()
        engine.dispose()


@pytest.mark.parametrize(
    "model_text",
    [
        'Result: {"classification":"IGNORE","target_question_id":null,"formal_question":null,"formal_answer":null,"confidence":0.8,"candidate_question_ids":[],"reason_code":"NO_VALUE"}',
        route_payload("UNKNOWN_CLASS", target=None),
        route_payload("MATCH_FIXED", target="Q-FIXED", confidence=1.2),
    ],
)
def test_malformed_or_invalid_model_output_degrades_to_review(tmp_path, model_text):
    engine, db, _case, unit, _fixed, _dynamic = make_context(tmp_path)
    try:
        decision = FormalRecordRouter(db, ai_supervisor=FakeSupervisor(text=model_text)).route(unit.id)
        assert decision.classification is RouteClass.NEEDS_REVIEW
        assert decision.target_question_id is None
        assert decision.reason_code == "INVALID_MODEL_OUTPUT"
    finally:
        db.close()
        engine.dispose()


def test_model_fixed_label_targeting_live_is_canonicalized(tmp_path):
    engine, db, _case, unit, _fixed, dynamic = make_context(tmp_path)
    try:
        decision = FormalRecordRouter(
            db,
            ai_supervisor=FakeSupervisor(
                text=route_payload(
                    "MATCH_FIXED",
                    target=dynamic.id,
                    question=dynamic.text,
                )
            ),
        ).route(unit.id)
        assert decision.classification is RouteClass.MATCH_EXISTING
        assert decision.target_question_id == dynamic.id
        assert decision.formal_question is None
    finally:
        db.close()
        engine.dispose()


def test_model_existing_label_targeting_fixed_is_canonicalized(tmp_path):
    engine, db, _case, unit, fixed, _dynamic = make_context(tmp_path)
    try:
        decision = FormalRecordRouter(
            db,
            ai_supervisor=FakeSupervisor(
                text=route_payload(
                    "MATCH_EXISTING",
                    target=fixed.id,
                    question=fixed.text,
                )
            ),
        ).route(unit.id)
        assert decision.classification is RouteClass.MATCH_FIXED
        assert decision.target_question_id == fixed.id
        assert decision.formal_question is None
    finally:
        db.close()
        engine.dispose()


def test_c_requires_real_question_fragment(tmp_path):
    engine, db, _case, unit, _fixed, _dynamic = make_context(tmp_path, with_question_fragment=False)
    try:
        decision = FormalRecordRouter(
            db,
            ai_supervisor=FakeSupervisor(
                text=route_payload(
                    "CREATE_LIVE_FROM_SPEECH",
                    target=None,
                    question="你离开现场后是否返回？",
                )
            ),
        ).route(unit.id)
        assert decision.classification is RouteClass.NEEDS_REVIEW
        assert decision.reason_code == "INVALID_MODEL_OUTPUT"
    finally:
        db.close()
        engine.dispose()


def test_c_requires_non_empty_formal_question(tmp_path):
    engine, db, _case, unit, _fixed, _dynamic = make_context(tmp_path)
    try:
        decision = FormalRecordRouter(
            db,
            ai_supervisor=FakeSupervisor(
                text=route_payload("CREATE_LIVE_FROM_SPEECH", target=None, question="   ")
            ),
        ).route(unit.id)
        assert decision.classification is RouteClass.NEEDS_REVIEW
        assert decision.reason_code == "INVALID_MODEL_OUTPUT"
    finally:
        db.close()
        engine.dispose()


def test_model_exception_degrades_to_review_without_reasoning_text(tmp_path):
    engine, db, _case, unit, _fixed, _dynamic = make_context(tmp_path)
    try:
        decision = FormalRecordRouter(
            db,
            ai_supervisor=FakeSupervisor(error=RuntimeError("llm unavailable")),
        ).route(unit.id)
        assert decision.classification is RouteClass.NEEDS_REVIEW
        assert decision.reason_code == "INVALID_MODEL_OUTPUT"
        assert decision.model_id is None
        assert not hasattr(decision, "reasoning")
    finally:
        db.close()
        engine.dispose()
