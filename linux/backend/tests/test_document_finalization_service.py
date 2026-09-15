from pathlib import Path

import pytest

from app.database.models import Case, DocumentSnapshot, InterrogationSession, QAUnit
from app.database.session import init_database, make_engine, make_session_factory
from app.domain.enums import SessionStatus, WorkflowState
from app.domain.errors import DomainError
from app.services.document_finalization_service import DocumentFinalizationService


class FakeCaptureService:
    def __init__(self, events: list[str]):
        self.active = True
        self.events = events

    def status(self, _case_id: str) -> dict:
        return {"active": self.active}

    def stop(self, _case_id: str) -> dict:
        self.events.append("capture-stop")
        self.active = False
        return {"active": False}


class FakeRoutingCoordinator:
    def __init__(self, events: list[str]):
        self.events = events

    def drain_capture(self, case_id: str, session_id: str, *, timeout: float) -> None:
        self.events.append(f"routing-drain:{case_id}:{session_id}")


def seed(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'finalize.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        case = Case(id="CASE-FINALIZE", workflow_state=WorkflowState.QUESTIONING.value)
        session = InterrogationSession(
            id="SESSION-FINALIZE",
            case_id=case.id,
            status=SessionStatus.RUNNING.value,
            stage="IDENTITY",
        )
        db.add_all([case, session])
        db.commit()
    return engine, factory, case.id, session.id


def test_finalize_stops_capture_drains_routing_then_finishes_and_freezes(tmp_path: Path):
    engine, factory, case_id, session_id = seed(tmp_path)
    events: list[str] = []
    with factory() as db:
        state = DocumentFinalizationService(
            db,
            capture_service=FakeCaptureService(events),
            routing_coordinator=FakeRoutingCoordinator(events),
        ).finalize(case_id, actor_id="officer-1")

        assert state["status"] == "FROZEN"
        assert events == ["capture-stop", f"routing-drain:{case_id}:{session_id}"]
        assert db.get(Case, case_id).workflow_state == WorkflowState.FROZEN.value
        assert db.get(InterrogationSession, session_id).status == SessionStatus.COMPLETED.value
        assert db.query(DocumentSnapshot).filter_by(case_id=case_id).count() == 1
    engine.dispose()


def test_finalize_refuses_to_freeze_unresolved_routing_work(tmp_path: Path):
    engine, factory, case_id, session_id = seed(tmp_path)
    events: list[str] = []
    with factory() as db:
        db.add(QAUnit(
            id="QA-REVIEW",
            case_id=case_id,
            session_id=session_id,
            status="NEEDS_REVIEW",
            raw_question_text="你从哪里拿的刀？",
            raw_answer_text="从厨房。",
        ))
        db.commit()

        with pytest.raises(DomainError) as exc:
            DocumentFinalizationService(
                db,
                capture_service=FakeCaptureService(events),
                routing_coordinator=FakeRoutingCoordinator(events),
            ).finalize(case_id)
        assert exc.value.code == "FORMAL_RECORD_REVIEW_REQUIRED"
        assert db.get(Case, case_id).workflow_state == WorkflowState.QUESTIONING.value
        assert db.get(InterrogationSession, session_id).status == SessionStatus.RUNNING.value
        assert db.query(DocumentSnapshot).filter_by(case_id=case_id).count() == 0
    engine.dispose()
