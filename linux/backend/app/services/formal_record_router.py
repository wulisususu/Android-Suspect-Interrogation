from __future__ import annotations

import json
import logging
import re
from dataclasses import dataclass, replace
from enum import Enum
from typing import Any

from sqlalchemy.orm import Session

from app.ai.prompt.formal_record_routing import build_formal_record_routing_prompt
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo
from app.repositories import template_questions as question_repo
from app.services.question_matching import is_operational_utterance, is_question_utterance


logger = logging.getLogger(__name__)


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
    # The model's formal_answer is advisory (raw transcript answers are
    # canonical), so a missing advisory answer must not suppress the
    # classification flip that locked/live target metadata demands.
    if target is None or not decision.target_question_id:
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


_AMBIGUOUS_REFERENCE_RE = re.compile(r"(?:那个|这个|刚才(?:那个|这个)?)(?:时间|时候|问题|情况|事|事情)")
_TIME_QUESTION_RE = re.compile(r"(?:什么时候|何时|几点|时间|哪天)")
_QUESTION_NOISE_RE = re.compile(r"[\s，。？！,.?!；;：:、\"'“”‘’()（）]+")


def _unique_targets(target_ids: tuple[str, ...] | list[str]) -> tuple[str, ...]:
    result: list[str] = []
    for value in target_ids:
        clean = str(value or "").strip()
        if clean and clean not in result:
            result.append(clean)
    return tuple(result)


def precheck_routing_decision(
    *,
    raw_question: str | None,
    recent_target_ids: tuple[str, ...] | list[str],
) -> FormalRecordRouteDecision | None:
    """Resolve deterministic E/D cases before an expensive model call.

    Only narrow, high-confidence patterns are handled here. Ordinary
    non-question evidence is intentionally not discarded.
    """

    question = str(raw_question or "").strip()
    if is_operational_utterance(question):
        return FormalRecordRouteDecision(
            classification=RouteClass.IGNORE,
            target_question_id=None,
            formal_question=None,
            formal_answer=None,
            confidence=1.0,
            candidate_question_ids=(),
            reason_code="OPERATIONAL_CHATTER_PRECHECK",
            model_id=None,
        )

    candidates = _unique_targets(recent_target_ids)
    if _AMBIGUOUS_REFERENCE_RE.search(question) and len(candidates) > 1:
        return FormalRecordRouteDecision(
            classification=RouteClass.NEEDS_REVIEW,
            target_question_id=None,
            formal_question=None,
            formal_answer=None,
            confidence=None,
            candidate_question_ids=candidates,
            reason_code="AMBIGUOUS_REFERENCE_PRECHECK",
            model_id=None,
        )
    return None


def repair_existing_target_intent_mismatch(
    decision: FormalRecordRouteDecision,
    target: Any | None,
    *,
    raw_question: str | None,
    raw_answer: str | None,
) -> FormalRecordRouteDecision:
    """Reject a strong existing-target intent conflict as a real LIVE question.

    The first protected mismatch is deliberately narrow: an existing target is
    explicitly a time question, while the real officer utterance is a valid
    substantive question that does not ask for time. In that situation the
    backend must not attach the answer to the time field. It creates C from the
    actually spoken Q+A, never from an invented model question.
    """

    if decision.classification not in {RouteClass.MATCH_FIXED, RouteClass.MATCH_EXISTING}:
        return decision
    if target is None:
        return decision

    question = str(raw_question or "").strip()
    answer = str(raw_answer or "").strip()
    target_text = str(getattr(target, "text", "") or "").strip()
    if not question or not answer or not is_question_utterance(question):
        return decision

    target_asks_time = bool(_TIME_QUESTION_RE.search(target_text))
    spoken_asks_time = bool(_TIME_QUESTION_RE.search(question))
    if not target_asks_time or spoken_asks_time:
        return decision

    return FormalRecordRouteDecision(
        classification=RouteClass.CREATE_LIVE_FROM_SPEECH,
        target_question_id=None,
        formal_question=question,
        formal_answer=answer,
        confidence=decision.confidence,
        candidate_question_ids=(),
        reason_code="TARGET_INTENT_MISMATCH_CREATE_LIVE",
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
    """Fail safe to raw testimony if Qwen drops explicit time/quantity facts."""

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
    # Qwen/MiniCPM chat templates may emit a thinking block even with reasoning
    # disabled; it eats into the token budget and hides the JSON payload.
    text = re.sub(r"<think>.*?</think>", "", text, flags=re.DOTALL).strip()
    if not text:
        raise ValueError("model output was only a thinking block")
    if text.startswith("```"):
        match = _FENCED_JSON.fullmatch(text)
        if match is not None:
            text = match.group(1)
    # Small local models wrap the JSON in prose or emit harmless extra fields
    # (e.g. reason_code). Extract the first balanced object and require the
    # contract keys to be present; unknown extra keys are ignored.
    start = text.find("{")
    if start < 0:
        raise ValueError("model output contains no JSON object")
    depth = 0
    end = -1
    in_string = False
    escaped = False
    for index in range(start, len(text)):
        ch = text[index]
        if in_string:
            if escaped:
                escaped = False
            elif ch == "\\":
                escaped = True
            elif ch == '"':
                in_string = False
        elif ch == '"':
            in_string = True
        elif ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                end = index + 1
                break
    if end < 0:
        raise ValueError("model output contains an unbalanced JSON object")
    payload = json.loads(text[start:end])
    if not isinstance(payload, dict) or not _EXPECTED_KEYS.issubset(payload):
        raise ValueError("model output shape mismatch")
    return payload


class FormalRecordRouter:
    def __init__(self, db: Session, *, ai_supervisor: Any):
        self.db = db
        self.ai_supervisor = ai_supervisor

    def route(self, qa_unit_id: str) -> FormalRecordRouteDecision:
        unit = qa_repo.get(self.db, qa_unit_id)
        recent = [row for row in qa_repo.list_recent_closed(self.db, unit.case_id, limit=3) if row.id != unit.id]
        prechecked = precheck_routing_decision(
            raw_question=unit.raw_question_text,
            recent_target_ids=tuple(row.target_question_id for row in recent if row.target_question_id),
        )
        if prechecked is not None:
            return prechecked

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
            if decision.classification in {RouteClass.MATCH_FIXED, RouteClass.MATCH_EXISTING}:
                # For matches the formal question text comes from the matched
                # target question, never from the model. Small models like to
                # echo the question into formal_question, which would trip
                # policy validation even though the field is unused.
                decision = replace(decision, formal_question=None)
            target = self._case_question(unit.case_id, decision.target_question_id)
            if decision.classification in {RouteClass.MATCH_FIXED, RouteClass.MATCH_EXISTING}:
                # An exact spoken-text match beats the model's target pick:
                # questions asked verbatim (bot or template-driven) always
                # resolve deterministically, while small models confuse ids.
                exact = self._resolve_target_by_text(unit.case_id, unit.raw_question_text)
                if exact is not None and (target is None or target.id != exact.id):
                    decision = replace(decision, target_question_id=exact.id)
                    target = exact
            decision = canonicalize_existing_target_decision(decision, target)
            decision = repair_existing_target_intent_mismatch(
                decision,
                target,
                raw_question=unit.raw_question_text,
                raw_answer=unit.raw_answer_text,
            )
            decision = preserve_existing_answer_facts(decision, raw_answer=unit.raw_answer_text)
            if not self._policy_valid(unit, decision):
                logger.warning(
                    "formal routing policy rejected qa unit %s: cls=%s target=%s formal_q=%r confidence=%s",
                    qa_unit_id,
                    decision.classification.value,
                    decision.target_question_id,
                    decision.formal_question,
                    decision.confidence,
                )
                return self._invalid(result.model_id)
            return decision
        except Exception:
            raw = getattr(result, "text", "")
            logger.warning(
                "formal routing model output unparsable for qa unit %s (%s chars): %.400s",
                qa_unit_id,
                len(raw or ""),
                raw or "<none>",
            )
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
            # Since raw-transcript answers became canonical (the model's
            # formal_answer is advisory only), an empty model answer must not
            # block an otherwise correct fixed-question match.
            return bool(
                target is not None
                and target.locked
                and target.template_key
                and decision.formal_question is None
            )

        if decision.classification is RouteClass.MATCH_EXISTING:
            target = self._case_question(unit.case_id, decision.target_question_id)
            return bool(
                target is not None
                and not target.locked
                and target.source in {"CASE", "LIVE"}
                and decision.formal_question is None
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

    def _resolve_target_by_text(self, case_id: str, question_text: str | None):
        """Deterministically resolve a target when the model echoed a wrong id.

        Small local models sometimes return the QA unit's own id as the target.
        When the spoken question text exactly (normalized) matches one case
        question's text or alias, that unique question becomes the target so
        fixed template questions still archive automatically.
        """
        normalized = _QUESTION_NOISE_RE.sub("", str(question_text or ""))
        if not normalized:
            return None
        matches = []
        for question in question_repo.list_case(self.db, case_id):
            candidates = [_QUESTION_NOISE_RE.sub("", str(getattr(question, "text", "") or ""))]
            try:
                for alias in json.loads(getattr(question, "aliases_json", "") or "[]"):
                    candidates.append(_QUESTION_NOISE_RE.sub("", str(alias or "")))
            except (TypeError, ValueError):
                pass
            if any(candidate and candidate == normalized for candidate in candidates):
                matches.append(question)
        return matches[0] if len(matches) == 1 else None

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
