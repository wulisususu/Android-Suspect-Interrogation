from __future__ import annotations

from sqlalchemy.orm import Session

from app.repositories import question_rounds as round_repo
from app.repositories import template_questions as question_repo
from app.services.formal_record_policy import assert_formal_record_mutable
from app.services.serializers import question_round_dict


class FormalRecordAnswerService:
    """Create or edit a formal answer without fabricating ASR evidence."""

    def __init__(self, db: Session):
        self.db = db

    def upsert(self, case_id: str, question_id: str, *, answer_text: str) -> dict:
        assert_formal_record_mutable(self.db, case_id)
        question = question_repo.get_case(self.db, case_id, question_id)
        round_row = round_repo.latest_for_question(self.db, case_id, question_id)
        if round_row is None:
            round_row = round_repo.create_round(
                self.db,
                case_id=case_id,
                session_id=None,
                case_question_id=question_id,
                actual_question_text=question.text,
                officer_fragment_id=None,
                answer_text=answer_text,
                answer_fragment_ids=[],
                status="CLOSED",
            )
        else:
            round_row.answer_text = str(answer_text or "").strip()
            self.db.flush()
        return question_round_dict(round_row)
