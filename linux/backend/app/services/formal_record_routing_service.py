from __future__ import annotations

from sqlalchemy.orm import Session

from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import qa_units as qa_repo
from app.repositories import question_rounds as round_repo
from app.repositories import template_questions as question_repo
from app.services.formal_record_policy import assert_formal_record_mutable
from app.services.formal_record_router import FormalRecordRouteDecision, RouteClass
from app.services.serializers import qa_unit_dict, question_round_dict
from app.services.template_workspace_service import TemplateWorkspaceService


_MANUAL_ACTIONS = {"CREATE_LIVE", "LINK_QA", "LINK_ANSWER", "IGNORE"}


class FormalRecordRoutingService:
    def __init__(self, db: Session):
        self.db = db

    def apply_auto(self, qa_unit_id: str, decision: FormalRecordRouteDecision) -> dict:
        unit = qa_repo.get(self.db, qa_unit_id)
        if decision.classification is RouteClass.NEEDS_REVIEW:
            return self._review(unit, decision)
        if decision.classification is RouteClass.IGNORE:
            return self._ignore(unit, decision, manual=False)

        if decision.classification is RouteClass.MATCH_FIXED:
            question = self._valid_target(unit.case_id, decision.target_question_id, fixed=True)
            if question is None or not decision.formal_answer:
                return self._review(unit, decision, reason_code="INVALID_AUTO_DECISION")
            assert_formal_record_mutable(self.db, unit.case_id)
            return self._apply_existing(unit, question, decision, audit_action="QA_ROUTE_AUTO_APPLIED")

        if decision.classification is RouteClass.MATCH_EXISTING:
            question = self._valid_target(unit.case_id, decision.target_question_id, fixed=False)
            if question is None or not decision.formal_answer:
                return self._review(unit, decision, reason_code="INVALID_AUTO_DECISION")
            assert_formal_record_mutable(self.db, unit.case_id)
            return self._apply_existing(unit, question, decision, audit_action="QA_ROUTE_AUTO_APPLIED")

        if decision.classification is RouteClass.CREATE_LIVE_FROM_SPEECH:
            if not self._can_create_live(unit, decision):
                return self._review(unit, decision, reason_code="INVALID_AUTO_DECISION")
            assert_formal_record_mutable(self.db, unit.case_id)
            created = TemplateWorkspaceService(self.db).add_case_question(
                unit.case_id,
                text=decision.formal_question or "",
                source="LIVE",
            )
            question = question_repo.get_case(self.db, unit.case_id, created["id"])
            return self._apply_existing(unit, question, decision, audit_action="QA_ROUTE_AUTO_APPLIED")

        return self._review(unit, decision, reason_code="INVALID_AUTO_DECISION")

    def resolve_manual(
        self,
        qa_unit_id: str,
        *,
        action: str,
        case_question_id: str | None = None,
        formal_question: str | None = None,
        formal_answer: str | None = None,
    ) -> dict:
        unit = qa_repo.get(self.db, qa_unit_id)
        normalized = str(action or "").strip().upper()
        if normalized not in _MANUAL_ACTIONS:
            raise DomainError("INVALID_QA_RESOLUTION_ACTION", "问答单元处理动作无效", 400)
        if normalized == "IGNORE":
            manual_decision = FormalRecordRouteDecision(
                classification=RouteClass.IGNORE,
                target_question_id=None,
                formal_question=None,
                formal_answer=None,
                confidence=unit.confidence,
                candidate_question_ids=(),
                reason_code="MANUAL_IGNORE",
                model_id=unit.model_id,
            )
            return self._ignore(unit, manual_decision, manual=True)

        assert_formal_record_mutable(self.db, unit.case_id)
        clean_answer = str(formal_answer if formal_answer is not None else unit.raw_answer_text or "").strip()
        if not clean_answer:
            raise DomainError("FORMAL_ANSWER_REQUIRED", "正式答案不能为空", 400)

        if normalized == "CREATE_LIVE":
            clean_question = str(formal_question if formal_question is not None else unit.raw_question_text or "").strip()
            if not clean_question or not self._question_fragment_ids(unit):
                raise DomainError("FORMAL_QUESTION_REQUIRED", "创建现场问题必须来自真实民警提问", 400)
            created = TemplateWorkspaceService(self.db).add_case_question(
                unit.case_id, text=clean_question, source="LIVE"
            )
            question = question_repo.get_case(self.db, unit.case_id, created["id"])
        else:
            if not case_question_id:
                raise DomainError("CASE_QUESTION_REQUIRED", "必须选择目标正式问题", 400)
            question = question_repo.get_case(self.db, unit.case_id, case_question_id)

        manual_decision = FormalRecordRouteDecision(
            classification=RouteClass.CREATE_LIVE_FROM_SPEECH if normalized == "CREATE_LIVE" else RouteClass.MATCH_EXISTING,
            target_question_id=question.id,
            formal_question=question.text if normalized == "CREATE_LIVE" else None,
            formal_answer=clean_answer,
            confidence=unit.confidence,
            candidate_question_ids=(),
            reason_code=f"MANUAL_{normalized}",
            model_id=unit.model_id,
        )
        return self._apply_existing(unit, question, manual_decision, audit_action="QA_ROUTE_MANUAL_APPLIED")

    def _apply_existing(self, unit, question, decision: FormalRecordRouteDecision, *, audit_action: str) -> dict:
        question_ids = self._question_fragment_ids(unit)
        answer_ids = self._answer_fragment_ids(unit)
        round_row = round_repo.create_round(
            self.db,
            case_id=unit.case_id,
            session_id=unit.session_id,
            case_question_id=question.id,
            actual_question_text=str(unit.raw_question_text or question.text).strip(),
            officer_fragment_id=question_ids[0] if question_ids else None,
            answer_text=str(unit.raw_answer_text or "").strip(),
            answer_fragment_ids=answer_ids,
            status="CLOSED",
            started_at=unit.started_at,
            ended_at=unit.ended_at,
        )
        question_repo.set_canonical_answer(
            self.db,
            question,
            answer_text=decision.formal_answer or "",
            first_asked_at=unit.started_at,
        )
        TemplateWorkspaceService(self.db).apply_actual_body_order(unit.case_id)
        qa_repo.save_decision(
            self.db,
            unit,
            classification=decision.classification.value,
            target_question_id=question.id,
            formal_question_text=decision.formal_question,
            formal_answer_text=decision.formal_answer,
            confidence=decision.confidence,
            model_id=decision.model_id,
            reason_code=decision.reason_code,
            status="APPLIED",
            candidate_question_ids=list(decision.candidate_question_ids),
        )
        self._audit(unit, decision, action=audit_action, target_question_id=question.id)
        return {
            "status": "APPLIED",
            "targetQuestionId": question.id,
            "round": question_round_dict(round_row),
            "qaUnit": qa_unit_dict(unit),
        }

    def _review(self, unit, decision: FormalRecordRouteDecision, *, reason_code: str | None = None) -> dict:
        code = reason_code or decision.reason_code
        qa_repo.save_decision(
            self.db,
            unit,
            classification=RouteClass.NEEDS_REVIEW.value,
            target_question_id=None,
            formal_question_text=decision.formal_question,
            formal_answer_text=decision.formal_answer,
            confidence=decision.confidence,
            model_id=decision.model_id,
            reason_code=code,
            status="NEEDS_REVIEW",
            candidate_question_ids=list(decision.candidate_question_ids),
        )
        review_decision = FormalRecordRouteDecision(
            classification=RouteClass.NEEDS_REVIEW,
            target_question_id=None,
            formal_question=decision.formal_question,
            formal_answer=decision.formal_answer,
            confidence=decision.confidence,
            candidate_question_ids=decision.candidate_question_ids,
            reason_code=code,
            model_id=decision.model_id,
        )
        self._audit(unit, review_decision, action="QA_ROUTE_REVIEW_REQUIRED", target_question_id=None)
        return {"status": "NEEDS_REVIEW", "qaUnit": qa_unit_dict(unit)}

    def _ignore(self, unit, decision: FormalRecordRouteDecision, *, manual: bool) -> dict:
        qa_repo.save_decision(
            self.db,
            unit,
            classification=RouteClass.IGNORE.value,
            target_question_id=None,
            formal_question_text=None,
            formal_answer_text=None,
            confidence=decision.confidence,
            model_id=decision.model_id,
            reason_code=decision.reason_code,
            status="IGNORED",
            candidate_question_ids=[],
        )
        self._audit(
            unit,
            decision,
            action="QA_ROUTE_MANUAL_APPLIED" if manual else "QA_ROUTE_IGNORED",
            target_question_id=None,
        )
        return {"status": "IGNORED", "qaUnit": qa_unit_dict(unit)}

    def _valid_target(self, case_id: str, question_id: str | None, *, fixed: bool):
        if not question_id:
            return None
        try:
            row = question_repo.get_case(self.db, case_id, question_id)
        except DomainError:
            return None
        if fixed:
            return row if row.locked and row.template_key else None
        return row if not row.locked and row.source in {"CASE", "LIVE"} else None

    def _can_create_live(self, unit, decision: FormalRecordRouteDecision) -> bool:
        return bool(
            decision.formal_question
            and decision.formal_answer
            and str(unit.raw_question_text or "").strip()
            and self._question_fragment_ids(unit)
        )

    @staticmethod
    def _question_fragment_ids(unit) -> list[str]:
        return [link.fragment_id for link in sorted(unit.fragments, key=lambda item: item.position) if link.role == "QUESTION"]

    @staticmethod
    def _answer_fragment_ids(unit) -> list[str]:
        return [link.fragment_id for link in sorted(unit.fragments, key=lambda item: item.position) if link.role == "ANSWER"]

    def _audit(self, unit, decision: FormalRecordRouteDecision, *, action: str, target_question_id: str | None) -> None:
        audit_repo.add(
            self.db,
            case_id=unit.case_id,
            action=action,
            target_type="QA_UNIT",
            target_id=unit.id,
            detail={
                "qa_unit_id": unit.id,
                "classification": decision.classification.value,
                "target_question_id": target_question_id,
                "confidence": decision.confidence,
                "model_id": decision.model_id,
                "reason_code": decision.reason_code,
                "question_fragment_ids": self._question_fragment_ids(unit),
                "answer_fragment_ids": self._answer_fragment_ids(unit),
            },
        )
