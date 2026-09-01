from __future__ import annotations

import time
from collections import deque
from datetime import datetime, timezone

import pytest
from sqlalchemy import select

from app.database.models import ASRFragment, Case, CaseQuestion, InterrogationSession, QAUnit
from app.database.session import init_database, make_engine, make_session_factory
from app.domain.errors import DomainError
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo
from app.services.formal_record_router import FormalRecordRouteDecision, RouteClass
from app.services.formal_record_routing_service import FormalRecordRoutingService
from app.services.qa_routing_coordinator import QARoutingCoordinator
from app.services.qa_unit_builder import QAUnitBuilder
from app.services.template_workspace_service import TemplateWorkspaceService


def decision(kind: RouteClass, *, target=None, question=None, answer=None, confidence=0.95, candidates=(), reason="E2E"):
    return FormalRecordRouteDecision(
        classification=kind,
        target_question_id=target,
        formal_question=question,
        formal_answer=answer,
        confidence=confidence,
        candidate_question_ids=tuple(candidates),
        reason_code=reason,
        model_id="fake-qwen3-4b",
    )


class SequenceRouter:
    def __init__(self, decisions):
        self.decisions = deque(decisions)
        self.calls: list[str] = []

    def route(self, qa_unit_id: str):
        self.calls.append(qa_unit_id)
        if not self.decisions:
            raise AssertionError("fake router exhausted")
        return self.decisions.popleft()


def wait_until(predicate, timeout=3.0):
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if predicate():
            return
        time.sleep(0.02)
    raise AssertionError("condition did not become true")


def seed(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'qwen-e2e.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        case = Case(id="CASE-QWEN-E2E", officer_name="测试警官")
        session = InterrogationSession(
            id="SESSION-QWEN-E2E",
            case_id=case.id,
            status="RUNNING",
            stage="QUESTIONING",
        )
        fixed = CaseQuestion(
            id="Q-FIXED-REASON",
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
        dynamic = CaseQuestion(
            id="Q-DYNAMIC-TIME",
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
        db.add_all([case, session, fixed, dynamic])
        db.flush()
        capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=session.id,
            sample_rate=16_000,
        )
        capture.started_at = datetime(2026, 9, 1, 9, 0, tzinfo=timezone.utc)

        spoken = [
            ("INTERROGATOR", "今天为什么过来的？"),
            ("SUSPECT", "昨天跟别人发生了纠纷，派出所叫我来的。"),
            ("INTERROGATOR", "就是说是派出所通知你来的，对吗？"),
            ("SUSPECT", "对，今天通知我过来配合调查。"),
            ("INTERROGATOR", "你具体几点到现场的？"),
            ("SUSPECT", "大概八点十五。"),
            ("INTERROGATOR", "你离开现场以后有没有又回来？"),
            ("SUSPECT", "回来过一次，我手机落里面了。"),
            ("INTERROGATOR", "你们以前到底算朋友还是同事？"),
            ("SUSPECT", "这个不好说，以前一起干过活。"),
            ("INTERROGATOR", "声音大一点。"),
            ("SUSPECT", "好。"),
        ]
        fragment_ids = []
        for ordinal, (speaker, text) in enumerate(spoken, 1):
            fragment = asr_repo.create_fragment(
                db,
                capture_session_id=capture.id,
                case_id=case.id,
                ordinal=ordinal,
                started_at_ms=ordinal * 1_000,
                ended_at_ms=ordinal * 1_000 + 600,
                raw_text=text,
                speaker=speaker,
                speaker_source="MANUAL",
                voiceprint_verified=True,
                low_confidence=False,
                model_id="e2e-asr",
                model_version="fixture",
            )
            db.flush()
            fragment_ids.append(fragment.id)
        db.commit()
        return engine, factory, case.id, session.id, capture.id, fixed.id, dynamic.id, fragment_ids, [text for _, text in spoken]


def test_qwen_routing_e2e_preserves_raw_evidence_and_builds_formal_record(tmp_path):
    engine, factory, case_id, session_id, _capture_id, fixed_id, dynamic_id, fragment_ids, raw_texts = seed(tmp_path)
    fake_router = SequenceRouter([
        decision(RouteClass.MATCH_FIXED, target=fixed_id, answer="因昨晚与他人发生纠纷，接到派出所通知后前来。"),
        decision(RouteClass.MATCH_FIXED, target=fixed_id, answer="因昨晚与他人发生纠纷，今日接到派出所通知后前来配合调查。"),
        decision(RouteClass.MATCH_EXISTING, target=dynamic_id, answer="约20时15分到达现场。"),
        decision(
            RouteClass.CREATE_LIVE_FROM_SPEECH,
            question="你离开现场后是否再次返回？",
            answer="返回过一次，因为手机遗留在现场。",
        ),
        decision(RouteClass.NEEDS_REVIEW, candidates=(fixed_id, dynamic_id), confidence=0.58, reason="AMBIGUOUS"),
        decision(RouteClass.IGNORE, confidence=0.99, reason="OPERATIONAL_CHATTER"),
    ])
    commit_visible_events: list[tuple[str, str]] = []

    def publish(session: str, event: str, payload: dict):
        if event == "FORMAL_RECORD_UPDATED":
            with factory() as db:
                unit = qa_repo.get(db, payload["qaUnitId"])
                assert unit.status == "APPLIED"
                assert unit.target_question_id == payload["targetQuestionId"]
                assert CaseQuestion.__table__.c.formal_answer_text is not None
            commit_visible_events.append((session, event))

    coordinator = QARoutingCoordinator(
        session_factory=factory,
        ai_supervisor=object(),
        publish_event=publish,
        idle_close_seconds=60.0,
        poll_interval=0.01,
        router_factory=lambda _db, _ai: fake_router,
    )
    coordinator.start()
    try:
        for fragment_id in fragment_ids:
            coordinator.enqueue_fragment(case_id, fragment_id)
        coordinator.flush_capture(case_id, session_id)

        def routed():
            with factory() as db:
                rows = qa_repo.list_for_case(db, case_id)
                return len(rows) == 6 and all(row.status != "OPEN" for row in rows)

        wait_until(routed)
    finally:
        coordinator.shutdown()

    with factory() as db:
        fragments = list(db.scalars(select(ASRFragment).where(ASRFragment.case_id == case_id).order_by(ASRFragment.ordinal)))
        assert [row.raw_text for row in fragments] == raw_texts
        assert [row.edited_text for row in fragments] == raw_texts

        units = qa_repo.list_for_case(db, case_id)
        assert len(units) == 6
        assert [row.classification for row in units] == [
            "MATCH_FIXED",
            "MATCH_FIXED",
            "MATCH_EXISTING",
            "CREATE_LIVE_FROM_SPEECH",
            "NEEDS_REVIEW",
            "IGNORE",
        ]
        assert units[4].status == "NEEDS_REVIEW"
        assert units[5].status == "IGNORED"

        fixed = db.get(CaseQuestion, fixed_id)
        dynamic = db.get(CaseQuestion, dynamic_id)
        assert fixed is not None and fixed.text == "你因何事来公安机关？"
        assert fixed.formal_answer_text == "因昨晚与他人发生纠纷，今日接到派出所通知后前来配合调查。"
        assert dynamic is not None and dynamic.formal_answer_text == "约20时15分到达现场。"

        live = db.scalar(select(CaseQuestion).where(CaseQuestion.case_id == case_id, CaseQuestion.source == "LIVE"))
        assert live is not None
        assert live.text == "你离开现场后是否再次返回？"
        assert live.formal_answer_text == "返回过一次，因为手机遗留在现场。"
        assert live.first_asked_at is not None
        assert dynamic.first_asked_at is not None
        assert dynamic.first_asked_at < live.first_asked_at

        workspace = TemplateWorkspaceService(db).workspace(case_id)
        review = [row for row in workspace["qaUnits"] if row["status"] == "NEEDS_REVIEW"]
        assert len(review) == 1
        assert review[0]["reasonCode"] == "AMBIGUOUS"
        assert len([row for row in workspace["questions"] if row["source"] == "LIVE"]) == 1

        case = db.get(Case, case_id)
        assert case is not None
        case.workflow_state = "FROZEN"
        db.commit()

        capture = asr_repo.get_capture_session(db, fragments[0].capture_session_id)
        q = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case_id,
            ordinal=99,
            started_at_ms=99_000,
            ended_at_ms=99_500,
            raw_text="你再说一次几点到的？",
            speaker="INTERROGATOR",
            speaker_source="MANUAL",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="e2e-asr",
        )
        a = asr_repo.create_fragment(
            db,
            capture_session_id=capture.id,
            case_id=case_id,
            ordinal=100,
            started_at_ms=100_000,
            ended_at_ms=100_500,
            raw_text="还是八点十五。",
            speaker="SUSPECT",
            speaker_source="MANUAL",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="e2e-asr",
        )
        db.flush()
        builder = QAUnitBuilder(db, idle_close_seconds=60)
        builder.consume_fragment(case_id, q.id)
        builder.consume_fragment(case_id, a.id)
        closed = builder.flush_session(case_id, session_id)
        db.commit()
        assert len(closed) == 1
        with pytest.raises(DomainError, match="冻结"):
            FormalRecordRoutingService(db).apply_auto(
                closed[0],
                decision(RouteClass.MATCH_EXISTING, target=dynamic_id, answer="约20时15分到达现场。"),
            )

    assert len(fake_router.calls) == 6
    assert len(commit_visible_events) == 4
    assert all(session == session_id for session, _ in commit_visible_events)
    engine.dispose()
