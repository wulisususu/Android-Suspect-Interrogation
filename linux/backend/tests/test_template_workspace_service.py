from __future__ import annotations

import pytest
from sqlalchemy.orm import Session

from app.database.models import Case, PendingQuestion
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.repositories.question_rounds import active_pending, active_round
from app.services.serializers import pending_question_dict
from app.services.template_workspace_service import TemplateWorkspaceService


@pytest.fixture
def db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'workspace-service.db'}")
    init_database(engine)
    with Session(engine, expire_on_commit=False) as session:
        yield session
        session.rollback()
    engine.dispose()


@pytest.fixture
def case(db):
    row = Case(id="CASE-TEMPLATE-1", officer_name="测试警官")
    db.add(row)
    db.commit()
    return row


def test_editing_case_question_preserves_previous_text_as_alias(db, case):
    svc = TemplateWorkspaceService(db)
    question = svc.add_case_question(case.id, text="你何时到现场？", source="CASE")

    updated = svc.update_case_question(case.id, question["id"], text="你什么时候到现场？")

    assert "你何时到现场？" in updated["aliases"]
    assert updated["text"] == "你什么时候到现场？"


def test_live_case_question_does_not_enter_global_library_without_explicit_save(db, case):
    svc = TemplateWorkspaceService(db)
    question = svc.add_case_question(case.id, text="你为什么第二次返回？", source="LIVE")

    assert svc.list_library() == []

    saved = svc.save_to_library(case.id, question["id"], "现场经过")
    assert saved["text"] == "你为什么第二次返回？"
    assert saved["category"] == "现场经过"
    assert [row["id"] for row in svc.list_library("现场经过")] == [saved["id"]]


def test_case_question_can_be_inserted_after_current_question(db, case):
    svc = TemplateWorkspaceService(db)
    first = svc.add_case_question(case.id, text="第一个问题？", source="CASE")
    third = svc.add_case_question(case.id, text="第三个问题？", source="CASE")

    second = svc.add_case_question(
        case.id,
        text="第二个问题？",
        source="LIVE",
        after_question_id=first["id"],
    )

    workspace = svc.workspace(case.id)
    assert [item["id"] for item in workspace["questions"]] == [first["id"], second["id"], third["id"]]
    assert [item["sortOrder"] for item in workspace["questions"]] == [10, 20, 30]


def test_reorder_uses_complete_unique_question_set_and_survives_swaps(db, case):
    svc = TemplateWorkspaceService(db)
    first = svc.add_case_question(case.id, text="一？", source="CASE")
    second = svc.add_case_question(case.id, text="二？", source="CASE")
    third = svc.add_case_question(case.id, text="三？", source="CASE")

    reordered = svc.reorder(case.id, [third["id"], first["id"], second["id"]])

    assert [item["id"] for item in reordered] == [third["id"], first["id"], second["id"]]
    assert [item["sortOrder"] for item in reordered] == [10, 20, 30]

    with pytest.raises(DomainError):
        svc.reorder(case.id, [first["id"], second["id"]])
    with pytest.raises(DomainError):
        svc.reorder(case.id, [first["id"], first["id"], third["id"]])


def test_update_can_replace_regex_patterns_without_losing_aliases(db, case):
    svc = TemplateWorkspaceService(db)
    question = svc.add_case_question(
        case.id,
        text="你何时到现场？",
        source="CASE",
        regex_patterns=[r"什么时候.*现场"],
    )
    svc.update_case_question(case.id, question["id"], text="你几点到现场？")

    updated = svc.update_case_question(
        case.id,
        question["id"],
        regex_patterns=[r"几点.*现场", r"何时.*现场"],
    )

    assert updated["regexPatterns"] == [r"几点.*现场", r"何时.*现场"]
    assert updated["aliases"] == ["你何时到现场？"]


def test_transition_repository_queries_default_to_none(db, case):
    assert active_round(db, case.id, "SESSION-MISSING") is None
    assert active_pending(db, case.id, "SESSION-MISSING") is None


def test_pending_serializer_exposes_buffer_fields_without_business_marks():
    row = PendingQuestion(
        id="P-1",
        case_id="CASE-1",
        session_id="S-1",
        officer_fragment_id="F-1",
        question_text="你为什么又回去了？",
        match_status="UNMATCHED",
        candidate_question_ids_json="[]",
        buffered_answer_text="因为我去拿东西。",
        buffered_fragment_ids_json='["F-2"]',
        status="PENDING",
    )

    data = pending_question_dict(row)

    assert data["questionText"] == "你为什么又回去了？"
    assert data["bufferedAnswerText"] == "因为我去拿东西。"
    assert data["bufferedFragmentIds"] == ["F-2"]
    assert "mark" not in data
