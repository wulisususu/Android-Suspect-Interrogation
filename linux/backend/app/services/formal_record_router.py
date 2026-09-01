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


def canonicalize_existing_target_decision(
    decision: FormalRecordRouteDecision,
    target: Any | None,
) -> FormalRecordRouteDecision:
    """Make persisted target metadata authoritative for existing-question routes."""

    if decision.classification not in {RouteClass.MATCH_FIXED, RouteClass.MATCH_EXISTING}:
        return decision
    if target is None or not decision.target_question_id or not decision.formal_answer:
        return decision

    if bool(getattr(target, "locked", False)) and getattr(target, "template_key", None):
        classification = RouteClass.MATCH_FIXED
    elif not bool(getattr(target, "locked", False)) and getattr(target, "source", None) in {"CASE", "LIVE"}:
        classification = RouteClass.MATCH_EXISTING
    else:
        return decision

    return FormalRecordRouteDecision(
        classification=classification,
        target_question_id=decision.target_question_id,
        formal_question=None,
        formal_answer=decision.formal_answer,
        confidence=decision.confidence,
        candidate_question_ids=decision.candidate_question_ids,
        reason_code=decision.reason_code,
        model_id=decision.model_id,
    )


_CN_DIGITS = {
    "零": 0,
    "〇": 0,
    "一": 1,
    "二": 2,
    "两": 2,
    "三": 3,
    "四": 4,
    "五": 5,
    "六": 6,
    "七": 7,
    "八": 8,
    "九": 9,
}
_CN_NUMBER = r"[零〇一二两三四五六七八九十百]+"
_NUM_TOKEN = rf"(?:\d+(?:\.\d+)?|{_CN_NUMBER})"
_TIME_RE = re.compile(
    rf"(?P<daypart>凌晨|清晨|早上|上午|中午|下午|傍晚|晚上|夜里|夜间)?\s*"
    rf"(?P<hour>{_NUM_TOKEN})\s*(?:点|时)"
    rf"(?:(?P<minute>{_NUM_TOKEN})\s*分?)?"
)
_COLON_TIME_RE = re.compile(r"(?<!\d)(?P<hour>\d{1,2})\s*[:：]\s*(?P<minute>\d{1,2})(?!\d)")
_QUANTITY_RE = re.compile(
    rf"(?P<number>{_NUM_TOKEN})\s*(?:个)?(?P<unit>人|次|辆|件|元|岁|米|公里|天|年|月|日)"
)


def _parse_number(token: str) -> float | None:
    clean = str(token or "").strip()
    if not clean:
        return None
    try:
        return float(clean)
    except ValueError:
        pass

    if "百" in clean:
        left, right = clean.split("百", 1)
        hundreds = _CN_DIGITS.get(left[-1], 1) if left else 1
        tail = _parse_number(right) if right else 0
        return float(hundreds * 100 + (tail or 0))
    if "十" in clean:
        left, right = clean.split("十", 1)
        tens = _CN_DIGITS.get(left[-1], 1) if left else 1
        ones = _CN_DIGITS.get(right[0], 0) if right else 0
        return float(tens * 10 + ones)
    if all(char in _CN_DIGITS for char in clean):
        value = 0
        for char in clean:
            value = value * 10 + _CN_DIGITS[char]
        return float(value)
    return None


def _normalize_hour(hour: int, daypart: str | None) -> int:
    if daypart in {"下午", "傍晚", "晚上", "夜里", "夜间"} and 1 <= hour < 12:
        return hour + 12
    if daypart == "中午" and 1 <= hour <= 5:
        return hour + 12
    return hour


def _time_facts(text: str) -> set[tuple[int, int | None]]:
    value = str(text or "")
    facts: set[tuple[int, int | None]] = set()
    for match in _COLON_TIME_RE.finditer(value):
        hour = int(match.group("hour"))
        minute = int(match.group("minute"))
        if 0 <= hour <= 23 and 0 <= minute <= 59:
            facts.add((hour, minute))
    for match in _TIME_RE.finditer(value):
        raw_hour = _parse_number(match.group("hour"))
        if raw_hour is None or not raw_hour.is_integer():
            continue
        hour = _normalize_hour(int(raw_hour), match.group("daypart"))
        raw_minute = match.group("minute")
        minute: int | None = None
        if raw_minute:
            parsed_minute = _parse_number(raw_minute)
            if parsed_minute is None or not parsed_minute.is_integer():
                continue
            minute = int(parsed_minute)
        if 0 <= hour <= 23 and (minute is None or 0 <= minute <= 59):
            facts.add((hour, minute))
    return facts


def _quantity_facts(text: str) -> set[tuple[float, str]]:
    facts: set[tuple[float, str]] = set()
    for match in _QUANTITY_RE.finditer(str(text or "")):
        number = _parse_number(match.group("number"))
        if number is not None:
            facts.add((number, match.group("unit")))
    return facts


def _explicit_facts_preserved(raw_answer: str, formal_answer: str) -> bool:
    raw_times = _time_facts(raw_answer)
    formal_times = _time_facts(formal_answer)
    if not raw_times.issubset(formal_times):
        return False

    raw_quantities = _quantity_facts(raw_answer)
    formal_quantities = _quantity_facts(formal_answer)
    return raw_quantities.issubset(formal_quantities)


def preserve_existing_answer_facts(
    decision: FormalRecordRouteDecision,
    *,
    raw_answer: str | None,
) -> FormalRecordRouteDecision:
    """Fail safe to raw testimony if Qwen drops explicit time/quantity facts.

    The fallback is deliberately limited to existing-question auto routes. It
    never invents or normalizes a missing fact; it simply preserves the current
    raw answer verbatim when model prose loses explicit structured facts.
    """

    if decision.classification not in {RouteClass.MATCH_FIXED, RouteClass.MATCH_EXISTING}:
        return decision
    raw = str(raw_answer or "").strip()
    formal = str(decision.formal_answer or "").strip()
    if not raw or not formal or _explicit_facts_preserved(raw, formal):
        return decision
    return FormalRecordRouteDecision(
        classification=decision.classification,
        target_question_id=decision.target_question_id,
        formal_question=decision.formal_question,
        formal_answer=raw,
        confidence=decision.confidence,
        candidate_question_ids=decision.candidate_question_ids,
        reason_code="FACT_LOSS_RAW_FALLBACK",
        model_id=decision.model_id,
    )


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
            target = self._case_question(unit.case_id, decision.target_question_id)
            decision = canonicalize_existing_target_decision(decision, target)
            decision = preserve_existing_answer_facts(decision, raw_answer=unit.raw_answer_text)
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
