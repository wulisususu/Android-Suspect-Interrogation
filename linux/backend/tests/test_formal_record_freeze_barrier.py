from __future__ import annotations

import pytest
from sqlalchemy.orm import Session

from app.database.models import Case
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.repositories import facts as fact_repo
from app.repositories import messages as message_repo
from app.services.case_service import CaseService
from app.services.message_service import MessageService


@pytest.fixture
def db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'freeze-barrier.db'}")
    init_database(engine)
    with Session(engine, expire_on_commit=False) as session:
        yield session
        session.rollback()
    engine.dispose()


@pytest.mark.parametrize("workflow_state", ["FROZEN", "SIGNED", "REPORT_GENERATED"])
def test_immutable_workflow_states_reject_case_and_message_mutations(db, workflow_state):
    case = Case(
        id=f"CASE-FREEZE-BARRIER-{workflow_state}",
        suspect_name="冻结前嫌疑人",
        officer_name="测试民警",
        workflow_state="SUMMARY",
    )
    db.add(case)
    db.flush()
    fact_repo.seed_defaults(db, case.id)
    message = message_repo.create(
        db,
        case_id=case.id,
        session_id=None,
        speaker="嫌疑人",
        text="冻结前正式回答。",
    )
    case.workflow_state = workflow_state
    db.commit()

    case_service = CaseService(db)
    message_service = MessageService(db)
    mutations = [
        lambda: case_service.update(case.id, {"suspectName": "冻结后嫌疑人"}),
        lambda: case_service.update_fact(case.id, "time", {"value": "冻结后时间"}),
        lambda: case_service.add_timeline(case.id, {"time": "20:00", "title": "冻结后事件"}),
        lambda: message_service.revise(case.id, message.id, text="冻结后正式回答。"),
        lambda: message_service.mark(case.id, message.id, "highlight"),
    ]

    for mutate in mutations:
        with pytest.raises(DomainError) as error:
            mutate()
        assert error.value.code == "FORMAL_RECORD_FROZEN"

    db.refresh(case)
    db.refresh(message)
    assert case.suspect_name == "冻结前嫌疑人"
    assert message.text == "冻结前正式回答。"
    assert message.mark == ""
    assert case_service.list_facts(case.id)[0]["value"] != "冻结后时间"
    assert case_service.list_timeline(case.id) == []
