from __future__ import annotations

import re
from dataclasses import dataclass
from enum import Enum
from typing import Iterable


class QuestionMatchStatus(str, Enum):
    NOT_QUESTION = "NOT_QUESTION"
    UNMATCHED = "UNMATCHED"
    MATCHED = "MATCHED"
    AMBIGUOUS = "AMBIGUOUS"


@dataclass(frozen=True)
class QuestionCandidate:
    id: str
    text: str
    patterns: tuple[str, ...] = ()


@dataclass(frozen=True)
class QuestionMatchResult:
    status: QuestionMatchStatus
    source_text: str
    normalized_text: str
    matched_question_ids: tuple[str, ...] = ()


_OPERATIONAL_UTTERANCES = (
    re.compile(r"^(请)?继续(说|讲|陈述)(下去|一下|吧)?[。！!]*$"),
    re.compile(r"^(请)?(把)?声音(再)?大(一)?点[。！!]*$"),
    re.compile(r"^(请)?说(清楚|慢一点|大声一点)[。！!]*$"),
    re.compile(r"^(嗯|好|好的|行|知道了|明白了|继续)[。！!]*$"),
)

_DECLARATIVE_PREFIXES = (
    "我不知道",
    "我不清楚",
    "我记不清",
    "我没注意",
)

_QUESTION_CUES = (
    "吗", "么", "呢", "谁", "什么", "何时", "什么时候", "几点", "哪", "哪里", "哪儿",
    "为何", "为什么", "怎么", "怎样", "如何", "是否", "是不是", "有没有", "能否", "可否",
    "多少", "几次", "几个", "几人", "多久", "多长", "多远", "哪天", "哪次",
)


def normalize_question_text(text: str) -> str:
    value = (text or "").strip()
    value = re.sub(r"\s+", "", value)
    value = value.replace("？", "?")
    return value


def is_operational_utterance(text: str) -> bool:
    normalized = normalize_question_text(text)
    return bool(normalized and any(pattern.fullmatch(normalized) for pattern in _OPERATIONAL_UTTERANCES))


def is_question_utterance(text: str) -> bool:
    normalized = normalize_question_text(text)
    if not normalized:
        return False
    if is_operational_utterance(normalized):
        return False
    if any(normalized.startswith(prefix) and not normalized.endswith("?") for prefix in _DECLARATIVE_PREFIXES):
        return False
    if "?" in normalized:
        return True
    return any(cue in normalized for cue in _QUESTION_CUES)


def _matches_candidate(normalized_text: str, candidate: QuestionCandidate) -> bool:
    for pattern in candidate.patterns:
        try:
            if re.search(pattern, normalized_text):
                return True
        except re.error:
            continue

    candidate_text = normalize_question_text(candidate.text).rstrip("?")
    source_text = normalized_text.rstrip("?")
    return bool(candidate_text and source_text == candidate_text)


def match_question(text: str, candidates: Iterable[QuestionCandidate]) -> QuestionMatchResult:
    source_text = text
    normalized = normalize_question_text(text)
    if not is_question_utterance(text):
        return QuestionMatchResult(
            status=QuestionMatchStatus.NOT_QUESTION,
            source_text=source_text,
            normalized_text=normalized,
        )

    matches = tuple(candidate.id for candidate in candidates if _matches_candidate(normalized, candidate))
    if not matches:
        status = QuestionMatchStatus.UNMATCHED
    elif len(matches) == 1:
        status = QuestionMatchStatus.MATCHED
    else:
        status = QuestionMatchStatus.AMBIGUOUS

    return QuestionMatchResult(
        status=status,
        source_text=source_text,
        normalized_text=normalized,
        matched_question_ids=matches,
    )
