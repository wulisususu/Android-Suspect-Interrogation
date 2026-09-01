from __future__ import annotations

import pytest
from sqlalchemy.orm import Session

from app.database.models import Case
from app.database.session import init_database, make_engine
from app.domain.errors import DomainError
from app.services.template_workspace_service import TemplateWorkspaceService


@pytest.fixture
def db(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'formal-record-editor.db'}")
    init_database(engine)
    with Session(engine, expire_on_commit=False) as session:
        yield session
        session.rollback()
    engine.dispose()


@pytest.fixture
def case(db):
    row = Case(id="CASE-FORMAL-EDITOR", suspect_name="张某", officer_name="测试民警")
    db.add(row)
    db.commit()
    return row


def test_formal_record_template_is_seeded_idempotently_around_body_questions(db, case):
    svc = TemplateWorkspaceService(db)
    body = svc.add_case_question(case.id, text="你什么时候到现场？", source="CASE")

    first = svc.ensure_formal_record(case.id, template_key="SUSPECT_INQUIRY_V1")
    second = svc.ensure_formal_record(case.id, template_key="SUSPECT_INQUIRY_V1")

    assert first["templateKey"] == "SUSPECT_INQUIRY_V1"
    assert second["templateKey"] == "SUSPECT_INQUIRY_V1"
    questions = second["questions"]
    assert [q["sectionType"] for q in questions] == sorted(
        [q["sectionType"] for q in questions],
        key={"OPENING": 0, "BODY": 1, "CLOSING": 2}.__getitem__,
    )
    assert [q["id"] for q in questions if q["sectionType"] == "BODY"] == [body["id"]]
    assert len([q for q in questions if q["sectionType"] == "OPENING"]) >= 3
    assert len([q for q in questions if q["sectionType"] == "CLOSING"]) == 3
    assert len({q["templateItemKey"] for q in questions if q["sectionType"] != "BODY"}) == len(
        [q for q in questions if q["sectionType"] != "BODY"]
    )


def test_ensure_does_not_seed_or_reorder_a_frozen_legacy_record(db, case):
    svc = TemplateWorkspaceService(db)
    body = svc.add_case_question(case.id, text="历史问题？", source="CASE")
    original_sort_order = body["sortOrder"]
    case.workflow_state = "FROZEN"
    case.document_status = "FROZEN"
    db.commit()

    workspace = svc.ensure_formal_record(case.id, template_key="SUSPECT_INQUIRY_V1")

    assert workspace["templateKey"] is None
    assert [q["id"] for q in workspace["questions"]] == [body["id"]]
    assert workspace["questions"][0]["sortOrder"] == original_sort_order
    assert workspace["questions"][0]["sectionType"] == "BODY"


def test_frozen_formal_record_rejects_all_question_mutations_server_side(db, case):
    svc = TemplateWorkspaceService(db)
    body = svc.add_case_question(case.id, text="冻结前问题？", source="CASE")
    svc.ensure_formal_record(case.id, template_key="SUSPECT_INQUIRY_V1")
    case.workflow_state = "FROZEN"
    case.document_status = "FROZEN"
    db.commit()

    operations = [
        lambda: svc.add_case_question(case.id, text="冻结后新增？", source="CASE"),
        lambda: svc.update_case_question(case.id, body["id"], text="冻结后修改？"),
        lambda: svc.reorder(case.id, [body["id"]]),
        lambda: svc.deactivate_case_question(case.id, body["id"]),
        lambda: svc.save_to_library(case.id, body["id"], "通用"),
    ]

    for operation in operations:
        with pytest.raises(DomainError) as error:
            operation()
        assert error.value.code == "FORMAL_RECORD_FROZEN"


def test_fixed_template_question_text_cannot_be_edited_or_soft_removed(db, case):
    svc = TemplateWorkspaceService(db)
    workspace = svc.ensure_formal_record(case.id, template_key="SUSPECT_INQUIRY_V1")
    fixed = next(q for q in workspace["questions"] if q["sectionType"] == "OPENING")

    with pytest.raises(DomainError) as edit_error:
        svc.update_case_question(case.id, fixed["id"], text="被篡改的固定问题")
    assert edit_error.value.code == "FIXED_QUESTION_LOCKED"

    with pytest.raises(DomainError) as remove_error:
        svc.deactivate_case_question(case.id, fixed["id"])
    assert remove_error.value.code == "FIXED_QUESTION_LOCKED"


def test_body_questions_are_editable_removable_and_reorder_only_within_body(db, case):
    svc = TemplateWorkspaceService(db)
    first = svc.add_case_question(case.id, text="问题一？", source="CASE")
    second = svc.add_case_question(case.id, text="问题二？", source="LIVE")
    svc.ensure_formal_record(case.id, template_key="SUSPECT_INQUIRY_V1")

    updated = svc.update_case_question(case.id, first["id"], text="修改后的问题一？")
    assert updated["text"] == "修改后的问题一？"
    assert updated["sectionType"] == "BODY"

    reordered = svc.reorder(case.id, [second["id"], first["id"]])
    body = [q for q in reordered if q["sectionType"] == "BODY"]
    assert [q["id"] for q in body] == [second["id"], first["id"]]
    assert reordered[0]["sectionType"] == "OPENING"
    assert reordered[-1]["sectionType"] == "CLOSING"

    removed = svc.deactivate_case_question(case.id, second["id"])
    assert removed["active"] is False
    assert [q["id"] for q in svc.workspace(case.id)["questions"] if q["sectionType"] == "BODY"] == [first["id"]]


def test_live_question_insert_after_body_never_crosses_into_fixed_closing_section(db, case):
    svc = TemplateWorkspaceService(db)
    first = svc.add_case_question(case.id, text="第一条动态问题？", source="CASE")
    svc.ensure_formal_record(case.id, template_key="SUSPECT_INQUIRY_V1")

    second = svc.add_case_question(
        case.id,
        text="从实时对话拖入的问题？",
        source="LIVE",
        after_question_id=first["id"],
    )

    workspace = svc.workspace(case.id)
    body = [q for q in workspace["questions"] if q["sectionType"] == "BODY"]
    assert [q["id"] for q in body] == [first["id"], second["id"]]
    assert workspace["questions"][-1]["sectionType"] == "CLOSING"
