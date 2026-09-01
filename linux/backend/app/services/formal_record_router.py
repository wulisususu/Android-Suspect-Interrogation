from __future__ import annotations

import json
import re
from dataclasses import dataclass
from enum import Enum
from typing import Any

from sqlalchemy.orm import Session

from app.ai.prompt.formal_record_routing import build_formal_record_routing_prompt
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo
from app.repositories import template_questions as question_repo


class RouteClass(str, Enum):
    MATCH_FIXED = "MATCH_FIXED"
    MATCH_EXISTING = "MATCH_EXISTING"
    CREATE_LIVE_FROM_SPEECH = "CREATE_LIVE_FROM_SPEECH"
    NEEDS_REVIEW = "NEEDS_REVIEW"
    IGNORE = "IGNORE"


@dataclass(frozen=True)
class FormalRecordRouteDecision:
    classification: RouteClass
    target_question_id: str | None
    formal_question: str | None
    formal_answer: str | None
    confidence: float | None
    candidate_question_ids: tuple[str, ...]
    reason_code: str
    model_id: str | None


_EXPECTED_KEYS = {
    "classification",
    "target_question_id",
    "formal_question",
    "formal_answer",
    "confidence",
    "candidate_question_ids",
    "reason_code",
}
_FENCED_JSON = re.compile(r"\A```(?:json)?\s*(\{.*\})\s*```\Z", re.DOTALL | re.IGNORECASE)


def _clean_optional_text(value: Any) -> str | None:
    if value is None:
        return None
    if not isinstance(value, str):
        raise ValueError("text field must be string or null")
    clean = value.strip()
    return clean or None


def _parse_payload(raw: str) -> dict[str, Any]:
    text = str(raw or "").strip()
    if not text:
        raise ValueError("empty model output")
    if text.startswith("```"):
        match = _FENCED_JSON.fullmatch(text)
        if match is None:
            raise ValueError("invalid fenced JSON output")
        text = match.group(1)
    elif not (text.startswith("{") and text.endswith("}")):
        raise ValueError("model output must be JSON only")
    payload = json.loads(text)
    if not isinstance(payload, dict) or set(payload) != _EXPECTED_KEYS:
        raise ValueError("model output shape mismatch")
    return payload


class FormalRecordRouter:
    def __init__(self, db: Session, *, ai_supervisor: Any):
        self.db = db
        self.ai_supervisor = ai_supervisor

    def route(self, qa_unit_id: str) -> FormalRecordRouteDecision:
        unit = qa_repo.get(self.db, qa_unit_id)
        prompt = build_formal_record_routing_prompt(context=self._context(unit))
        result = None
        try:
            result = self.ai_supervisor.generate(
                prompt,
                session_id=f"formal-route:{unit.id}",
                options={
                    "temperature": 0.1,
                    "top_p": 0.8,
                    "max_tokens": 512,
                    "enable_thinking": False,
                },
            )
            decision = self._decision_from_payload(_parse_payload(result.text), model_id=result.model_id)
            if not self._policy_valid(unit, decision):
                return self._invalid(result.model_id)
            return decision
        except Exception:
            return self._invalid(getattr(result, "model_id", None))

    def _decision_from_payload(self, payload: dict[str, Any], *, model_id: str | None) -> FormalRecordRouteDecision:
        classification = RouteClass(payload["classification"])
        target = payload["target_question_id"]
        if target is not None and not isinstance(target, str):
            raise ValueError("target_question_id must be string or null")
        target = target.strip() if isinstance(target, str) else None
        if target == "":
            target = None

        confidence_raw = payload["confidence"]
        if confidence_raw is None:
            confidence = None
        elif isinstance(confidence_raw, bool) or not isinstance(confidence_raw, (int, float)):
            raise ValueError("confidence must be numeric or null")
        else:
            confidence = float(confidence_raw)
            if not 0.0 <= confidence <= 1.0:
                raise ValueError("confidence out of range")

        candidate_raw = payload["candidate_question_ids"]
        if not isinstance(candidate_raw, list) or not all(isinstance(item, str) for item in candidate_raw):
            raise ValueError("candidate_question_ids must be string array")
        candidates: list[str] = []
        for item in candidate_raw:
            clean = item.strip()
            if clean and clean not in candidates:
                candidates.append(clean)

        reason_code = payload["reason_code"]
        if not isinstance(reason_code, str) or not reason_code.strip():
            raise ValueError("reason_code required")

        return FormalRecordRouteDecision(
            classification=classification,
            target_question_id=target,
            formal_question=_clean_optional_text(payload["formal_question"]),
            formal_answer=_clean_optional_text(payload["formal_answer"]),
            confidence=confidence,
            candidate_question_ids=tuple(candidates),
            reason_code=reason_code.strip(),
            model_id=model_id,
        )

    def _policy_valid(self, unit, decision: FormalRecordRouteDecision) -> bool:
        if decision.classification is RouteClass.MATCH_FIXED:
            target = self._case_question(unit.case_id, decision.target_question_id)
            return bool(
                target is not None
                and target.locked
                and target.template_key
                and decision.formal_question is None
                and decision.formal_answer
            )

        if decision.classification is RouteClass.MATCH_EXISTING:
            target = self._case_question(unit.case_id, decision.target_question_id)
            return bool(
                target is not None
                and not target.locked
                and target.source in {"CASE", "LIVE"}
                and decision.formal_question is None
                and decision.formal_answer
            )

        if decision.classification is RouteClass.CREATE_LIVE_FROM_SPEECH:
            return bool(
                decision.target_question_id is None
                and decision.formal_question
                and decision.formal_answer
                and str(unit.raw_question_text or "").strip()
                and self._has_question_fragment(unit)
            )

        if decision.classification is RouteClass.IGNORE:
            return bool(
                decision.target_question_id is None
                and decision.formal_question is None
                and decision.formal_answer is None
            )

        if decision.classification is RouteClass.NEEDS_REVIEW:
            if decision.target_question_id is not None and self._case_question(unit.case_id, decision.target_question_id) is None:
                return False
            return all(self._case_question(unit.case_id, item) is not None for item in decision.candidate_question_ids)

        return False

    def _case_question(self, case_id: str, question_id: str | None):
        if not question_id:
            return None
        try:
            return question_repo.get_case(self.db, case_id, question_id)
        except Exception:
            return None

    def _has_question_fragment(self, unit) -> bool:
        return any(link.role == "QUESTION" for link in unit.fragments)

    def _context(self, unit) -> dict[str, Any]:
        fragments: list[dict[str, Any]] = []
        for link in sorted(unit.fragments, key=lambda item: item.position):
            fragment = asr_repo.get_fragment(self.db, link.fragment_id)
            fragments.append({
                "id": fragment.id,
                "role": link.role,
                "speaker": fragment.speaker,
                "startMs": fragment.started_at_ms,
                "endMs": fragment.ended_at_ms,
                "text": str(fragment.edited_text or fragment.raw_text or "").strip(),
            })

        previous = [row for row in qa_repo.list_recent_closed(self.db, unit.case_id, limit=3) if row.id != unit.id][:2]
        previous_context = [
            {
                "id": row.id,
                "question": row.raw_question_text,
                "answer": row.raw_answer_text,
                "classification": row.classification,
                "targetQuestionId": row.target_question_id,
            }
            for row in reversed(previous)
        ]
        recent_target_id = next((row.target_question_id for row in previous if row.target_question_id), None)
        questions = [
            {
                "id": row.id,
                "text": row.text,
                "source": "FIXED" if row.locked else row.source,
                "section": row.section_type,
                "locked": bool(row.locked),
                "formalAnswerText": row.formal_answer_text,
            }
            for row in question_repo.list_case(self.db, unit.case_id)
        ]
        return {
            "qaUnit": {
                "id": unit.id,
                "rawQuestion": unit.raw_question_text,
                "rawAnswer": unit.raw_answer_text,
                "startedAt": unit.started_at.isoformat() if unit.started_at else None,
                "endedAt": unit.ended_at.isoformat() if unit.ended_at else None,
                "fragments": fragments,
            },
            "previousQaUnits": previous_context,
            "formalQuestions": questions,
            "recentTargetQuestionId": recent_target_id,
        }

    @staticmethod
    def _invalid(model_id: str | None) -> FormalRecordRouteDecision:
        return FormalRecordRouteDecision(
            classification=RouteClass.NEEDS_REVIEW,
            target_question_id=None,
            formal_question=None,
            formal_answer=None,
            confidence=None,
            candidate_question_ids=(),
            reason_code="INVALID_MODEL_OUTPUT",
            model_id=model_id,
        )
