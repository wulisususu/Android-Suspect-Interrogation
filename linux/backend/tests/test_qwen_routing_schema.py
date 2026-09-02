from __future__ import annotations

from sqlalchemy import UniqueConstraint

from app.database.models import CaseQuestion, QAUnit, QAUnitFragment


def test_qwen_routing_models_and_canonical_question_fields_exist():
    assert QAUnit.__tablename__ == "qa_units"
    assert QAUnitFragment.__tablename__ == "qa_unit_fragments"
    assert hasattr(CaseQuestion, "formal_answer_text")
    assert hasattr(CaseQuestion, "first_asked_at")


def test_one_asr_fragment_can_belong_to_only_one_qa_unit():
    table = QAUnitFragment.__table__
    unique_columns = {
        tuple(constraint.columns.keys())
        for constraint in table.constraints
        if isinstance(constraint, UniqueConstraint)
    }
    assert ("fragment_id",) in unique_columns
