from __future__ import annotations

import json
import threading
import time
from pathlib import Path

from sqlalchemy.orm import Session

from app.database.models import Case, CaseQuestion, InterrogationSession
from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo
from app.services.qa_routing_coordinator import QARoutingCoordinator


class GenerateResult:
    def __init__(self, text: str, model_id: str = "qwen3-4b-test"):
        self.text = text
        self.model_id = model_id


class FakeSupervisor:
    def __init__(self, *, delay: float = 0.0, fail: bool = False):
        self.delay = delay
        self.fail = fail
        self.calls = 0
        self.entered = threading.Event()

    def generate(self, _prompt, *, session_id: str, options: dict):
        self.calls += 1
        self.entered.set()
        if self.delay:
            time.sleep(self.delay)
        if self.fail:
            raise TimeoutError("simulated qwen timeout")
        return GenerateResult(json.dumps({
            "classification": "MATCH_EXISTING",
            "target_question_id": "Q-BODY",
            "formal_question": None,
            "formal_answer": "八点左右到达现场。",
            "confidence": 0.93,
            "candidate_question_ids": [],
            "reason_code": "SEMANTIC_MATCH",
        }, ensure_ascii=False))


class EventCollector:
    def __init__(self, factory):
        self.factory = factory
        self.events: list[tuple[str, str, dict, str | None]] = []
        self.ready = threading.Event()

    def __call__(self, session_id: str, event: str, payload: dict):
        qa_status = None
        qa_id = payload.get("id") or payload.get("qaUnitId")
        if qa_id:
            with self.factory() as db:
                row = db.get(__import__("app.database.models", fromlist=["QAUnit"]).QAUnit, qa_id)
                qa_status = None if row is None else row.status
        self.events.append((session_id, event, dict(payload), qa_status))
        self.ready.set()


def wait_until(predicate, timeout: float = 2.0):
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if predicate():
            return
        time.sleep(0.01)
    raise AssertionError("condition did not become true")


def seed(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'qa-routing-coordinator.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        case = Case(id="CASE-COORD", officer_name="测试警官")
        session = InterrogationSession(id="SESSION-COORD", case_id=case.id, status="RUNNING", stage="QUESTIONING")
        question = CaseQuestion(
            id="Q-BODY",
            case_id=case.id,
            source="CASE",
            text="你几点到现场？",
            regex_patterns_json="[]",
            aliases_json="[]",
            section_type="BODY",
            locked=False,
            sort_order=10,
            active=True,
        )
        db.add_all([case, session, question])
        db.flush()
        capture = asr_repo.create_capture_session(
            db,
            case_id=case.id,
            interrogation_session_id=session.id,
            sample_rate=16000,
        )
        db.commit()
        return engine, factory, case.id, session.id, capture.id


def add_exchange(factory, *, case_id: str, capture_id: str, ordinal_base: int = 1):
    with factory() as db:
        q = asr_repo.create_fragment(
            db,
            capture_session_id=capture_id,
            case_id=case_id,
            ordinal=ordinal_base,
            started_at_ms=0,
            ended_at_ms=400,
            raw_text="你几点到的？",
            speaker="INTERROGATOR",
            speaker_source="MANUAL",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="test-asr",
        )
        a = asr_repo.create_fragment(
            db,
            capture_session_id=capture_id,
            case_id=case_id,
            ordinal=ordinal_base + 1,
            started_at_ms=500,
            ended_at_ms=1000,
            raw_text="八点左右。",
            speaker="SUSPECT",
            speaker_source="MANUAL",
            voiceprint_verified=True,
            low_confidence=False,
            model_id="test-asr",
        )
        db.commit()
        return q.id, a.id


def test_enqueue_is_non_blocking_while_qwen_routes_in_worker(tmp_path):
    engine, factory, case_id, session_id, capture_id = seed(tmp_path)
    supervisor = FakeSupervisor(delay=0.35)
    events = EventCollector(factory)
    coordinator = QARoutingCoordinator(
        session_factory=factory,
        ai_supervisor=supervisor,
        publish_event=events,
        idle_close_seconds=60.0,
        poll_interval=0.01,
    )
    q_id, a_id = add_exchange(factory, case_id=case_id, capture_id=capture_id)
    coordinator.start()
    try:
        started = time.monotonic()
        coordinator.enqueue_fragment(case_id, q_id)
        coordinator.enqueue_fragment(case_id, a_id)
        coordinator.flush_capture(case_id, session_id)
        elapsed = time.monotonic() - started
        assert elapsed < 0.10
        assert supervisor.entered.wait(1.0)
        wait_until(lambda: any(event == "FORMAL_RECORD_UPDATED" for _, event, _, _ in events.events), timeout=2.0)
        with factory() as db:
            unit = qa_repo.list_for_case(db, case_id)[0]
            assert unit.status == "APPLIED"
            assert unit.target_question_id == "Q-BODY"
    finally:
        coordinator.shutdown()
        engine.dispose()


def test_model_timeout_becomes_needs_review_instead_of_killing_worker(tmp_path):
    engine, factory, case_id, session_id, capture_id = seed(tmp_path)
    supervisor = FakeSupervisor(fail=True)
    events = EventCollector(factory)
    coordinator = QARoutingCoordinator(
        session_factory=factory,
        ai_supervisor=supervisor,
        publish_event=events,
        idle_close_seconds=60.0,
        poll_interval=0.01,
    )
    q_id, a_id = add_exchange(factory, case_id=case_id, capture_id=capture_id)
    coordinator.start()
    try:
        coordinator.enqueue_fragment(case_id, q_id)
        coordinator.enqueue_fragment(case_id, a_id)
        coordinator.flush_capture(case_id, session_id)
        wait_until(lambda: bool(qa_repo_status(factory, case_id, "NEEDS_REVIEW")))
        with factory() as db:
            unit = qa_repo.list_for_case(db, case_id)[0]
            assert unit.classification == "NEEDS_REVIEW"
            assert unit.reason_code == "INVALID_MODEL_OUTPUT"
    finally:
        coordinator.shutdown()
        engine.dispose()


def test_startup_recovery_processes_persisted_unassigned_fragments(tmp_path):
    engine, factory, case_id, _session_id, capture_id = seed(tmp_path)
    FakeSupervisorInstance = FakeSupervisor()
    events = EventCollector(factory)
    add_exchange(factory, case_id=case_id, capture_id=capture_id)
    coordinator = QARoutingCoordinator(
        session_factory=factory,
        ai_supervisor=FakeSupervisorInstance,
        publish_event=events,
        idle_close_seconds=0.01,
        poll_interval=0.01,
    )
    coordinator.start()
    try:
        wait_until(lambda: bool(qa_repo_status(factory, case_id, "APPLIED")))
        assert FakeSupervisorInstance.calls == 1
    finally:
        coordinator.shutdown()
        engine.dispose()


def test_capture_flush_closes_last_unit_without_waiting_for_idle_timeout(tmp_path):
    engine, factory, case_id, session_id, capture_id = seed(tmp_path)
    supervisor = FakeSupervisor()
    events = EventCollector(factory)
    coordinator = QARoutingCoordinator(
        session_factory=factory,
        ai_supervisor=supervisor,
        publish_event=events,
        idle_close_seconds=999.0,
        poll_interval=0.01,
    )
    q_id, a_id = add_exchange(factory, case_id=case_id, capture_id=capture_id)
    coordinator.start()
    try:
        coordinator.enqueue_fragment(case_id, q_id)
        coordinator.enqueue_fragment(case_id, a_id)
        wait_until(lambda: bool(qa_repo_status(factory, case_id, "OPEN")))
        coordinator.flush_capture(case_id, session_id)
        wait_until(lambda: bool(qa_repo_status(factory, case_id, "APPLIED")))
    finally:
        coordinator.shutdown()
        engine.dispose()


def test_events_are_published_after_committed_routing_state(tmp_path):
    engine, factory, case_id, session_id, capture_id = seed(tmp_path)
    supervisor = FakeSupervisor()
    events = EventCollector(factory)
    coordinator = QARoutingCoordinator(
        session_factory=factory,
        ai_supervisor=supervisor,
        publish_event=events,
        idle_close_seconds=60.0,
        poll_interval=0.01,
    )
    q_id, a_id = add_exchange(factory, case_id=case_id, capture_id=capture_id)
    coordinator.start()
    try:
        coordinator.enqueue_fragment(case_id, q_id)
        coordinator.enqueue_fragment(case_id, a_id)
        coordinator.flush_capture(case_id, session_id)
        wait_until(lambda: any(event == "QA_UNIT_UPDATED" for _, event, _, _ in events.events))
        qa_event = next(item for item in events.events if item[1] == "QA_UNIT_UPDATED")
        assert qa_event[3] == "APPLIED"
    finally:
        coordinator.shutdown()
        engine.dispose()


def test_attributable_fragment_publishes_open_qa_unit_before_routing(tmp_path):
    engine, factory, case_id, session_id, capture_id = seed(tmp_path)
    events = EventCollector(factory)
    coordinator = QARoutingCoordinator(
        session_factory=factory,
        ai_supervisor=FakeSupervisor(),
        publish_event=events,
        idle_close_seconds=60.0,
        poll_interval=0.01,
    )
    q_id, _a_id = add_exchange(factory, case_id=case_id, capture_id=capture_id)
    try:
        coordinator._consume_fragment(case_id, q_id)
        assert len(events.events) == 1
        published_session_id, event, payload, persisted_status = events.events[0]
        assert published_session_id == session_id
        assert event == "QA_UNIT_UPDATED"
        assert persisted_status == "OPEN"
        assert payload["status"] == "OPEN"
        assert payload["rawQuestionText"] == "你几点到的？"
        assert payload["rawAnswerText"] == ""
    finally:
        engine.dispose()


def qa_repo_status(factory, case_id: str, status: str):
    with factory() as db:
        return [row for row in qa_repo.list_for_case(db, case_id) if row.status == status]
