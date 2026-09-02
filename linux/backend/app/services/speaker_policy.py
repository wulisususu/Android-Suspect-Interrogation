from __future__ import annotations

import math
from dataclasses import dataclass
from enum import Enum
from typing import Collection, Iterable, Mapping, Any


class _StrEnumCompat(str, Enum):
    """String enum compatible with the RK3588 Python 3.10 runtime."""

    def __str__(self) -> str:
        return str(self.value)


_MIN_USABLE_DURATION_MS = 1000
_REFERENCE_ROLES = frozenset({"SUSPECT", "INTERROGATOR", "RECORDER"})


class SpeakerRole(_StrEnumCompat):
    SUSPECT = "SUSPECT"
    INTERROGATOR = "INTERROGATOR"
    RECORDER = "RECORDER"
    OFFICER_FALLBACK = "OFFICER_FALLBACK"
    UNKNOWN = "UNKNOWN"


class SpeakerSource(_StrEnumCompat):
    # Historical persisted value. Keep readable forever; new model-backed
    # decisions use SPEAKER_EMBEDDING so provenance is backend-neutral.
    X_VECTOR = "X_VECTOR"
    SPEAKER_EMBEDDING = "SPEAKER_EMBEDDING"
    SUSPECT_EXCLUSION = "SUSPECT_EXCLUSION"
    MANUAL = "MANUAL"
    UNASSIGNED = "UNASSIGNED"


@dataclass(frozen=True)
class SpeakerDecision:
    role: SpeakerRole
    source: SpeakerSource
    voiceprint_verified: bool
    score: float | None
    second_best_score: float | None
    threshold: float
    margin: float
    speaker_id: str | None = None
    speaker_name: str | None = None
    low_confidence: bool = False


@dataclass(frozen=True)
class _Candidate:
    role: SpeakerRole
    score: float
    speaker_id: str | None
    speaker_name: str | None


def decide_speaker(
    *,
    candidates: Iterable[Mapping[str, Any]],
    enabled_roles: Collection[SpeakerRole | str],
    threshold: float,
    margin: float,
    usable_duration_ms: int,
    overlap: bool,
) -> SpeakerDecision:
    """Return a conservative, deterministic speaker-attribution decision.

    The policy consumes already-computed similarity scores. It deliberately
    knows nothing about model loading, persistence, or session state. A caller
    must provide calibrated ``threshold`` and ``margin`` values.
    """

    threshold = _validate_threshold(threshold)
    margin = _validate_margin(margin)
    duration = int(usable_duration_ms)
    if duration < 0:
        raise ValueError("usable_duration_ms must be non-negative")

    enabled = {_as_role(role) for role in enabled_roles}
    if SpeakerRole.SUSPECT not in enabled:
        raise ValueError("SUSPECT must be enabled for speaker attribution")
    if any(role.value not in _REFERENCE_ROLES for role in enabled):
        raise ValueError("enabled_roles may contain only enrolled reference roles")

    parsed = _parse_candidates(candidates)
    active = [item for item in parsed if item.role in enabled]

    if bool(overlap) or duration < _MIN_USABLE_DURATION_MS:
        return _unknown(threshold, margin)

    # Suspect-only mode is intentionally asymmetric: the registered suspect is
    # verified by the selected speaker-embedding backend; speech that fails the
    # suspect threshold is treated as generic police speech, explicitly marked
    # as exclusion rather than a biometrically verified officer identity.
    if enabled == {SpeakerRole.SUSPECT}:
        suspect = _find(active, SpeakerRole.SUSPECT)
        if suspect is None:
            return _unknown(threshold, margin)
        if suspect.score >= threshold:
            return _verified(suspect, None, threshold, margin)
        return _fallback(suspect.score, threshold, margin)

    ranked = sorted(active, key=lambda item: item.score, reverse=True)
    if not ranked:
        return _unknown(threshold, margin)

    best = ranked[0]
    second = ranked[1] if len(ranked) > 1 else None
    second_score = second.score if second is not None else None
    passes_threshold = best.score >= threshold
    passes_margin = second is None or (best.score - second_score) >= margin

    if passes_threshold and passes_margin:
        return _verified(best, second_score, threshold, margin)

    # Full mode has references for both officer roles, so a failed or ambiguous
    # biometric match remains UNKNOWN. There is no exclusion fallback because
    # doing so would discard useful uncertainty among fully enrolled speakers.
    full_mode = {
        SpeakerRole.SUSPECT,
        SpeakerRole.INTERROGATOR,
        SpeakerRole.RECORDER,
    }.issubset(enabled)
    if full_mode:
        return _unknown(
            threshold,
            margin,
            score=best.score,
            second_best_score=second_score,
        )

    # Partial mode has exactly one registered officer role. If the suspect is
    # clearly below the calibrated threshold by at least the calibrated margin,
    # the utterance may be classified only as generic police speech. It is never
    # attributed to the registered officer unless that officer independently
    # passes both threshold and margin.
    suspect = _find(active, SpeakerRole.SUSPECT)
    if suspect is not None and suspect.score < (threshold - margin):
        return _fallback(suspect.score, threshold, margin, second_score)

    return _unknown(
        threshold,
        margin,
        score=best.score,
        second_best_score=second_score,
    )


def _parse_candidates(candidates: Iterable[Mapping[str, Any]]) -> list[_Candidate]:
    parsed: list[_Candidate] = []
    seen: set[SpeakerRole] = set()
    for raw in candidates:
        if not isinstance(raw, Mapping):
            raise ValueError("candidate must be a mapping")
        role = _as_role(raw.get("role"))
        if role.value not in _REFERENCE_ROLES:
            raise ValueError("candidate role must be an enrolled reference role")
        if role in seen:
            raise ValueError(f"duplicate candidate role: {role.value}")
        seen.add(role)

        try:
            score = float(raw.get("score"))
        except (TypeError, ValueError) as exc:
            raise ValueError("candidate score must be numeric") from exc
        if not math.isfinite(score) or score < -1.0 or score > 1.0:
            raise ValueError("candidate score must be a finite cosine similarity in [-1, 1]")

        speaker_id = raw.get("speaker_id")
        speaker_name = raw.get("speaker_name")
        parsed.append(
            _Candidate(
                role=role,
                score=score,
                speaker_id=None if speaker_id is None else str(speaker_id),
                speaker_name=None if speaker_name is None else str(speaker_name),
            )
        )
    return parsed


def _as_role(value: SpeakerRole | str | Any) -> SpeakerRole:
    if isinstance(value, SpeakerRole):
        return value
    try:
        return SpeakerRole(str(value))
    except (TypeError, ValueError) as exc:
        raise ValueError(f"invalid speaker role: {value!r}") from exc


def _validate_threshold(value: float) -> float:
    try:
        result = float(value)
    except (TypeError, ValueError) as exc:
        raise ValueError("threshold must be numeric") from exc
    if not math.isfinite(result) or result < -1.0 or result > 1.0:
        raise ValueError("threshold must be finite and within [-1, 1]")
    return result


def _validate_margin(value: float) -> float:
    try:
        result = float(value)
    except (TypeError, ValueError) as exc:
        raise ValueError("margin must be numeric") from exc
    if not math.isfinite(result) or result < 0.0 or result > 2.0:
        raise ValueError("margin must be finite and within [0, 2]")
    return result


def _find(candidates: Iterable[_Candidate], role: SpeakerRole) -> _Candidate | None:
    return next((item for item in candidates if item.role is role), None)


def _verified(
    candidate: _Candidate,
    second_best_score: float | None,
    threshold: float,
    margin: float,
) -> SpeakerDecision:
    return SpeakerDecision(
        role=candidate.role,
        source=SpeakerSource.SPEAKER_EMBEDDING,
        voiceprint_verified=True,
        score=candidate.score,
        second_best_score=second_best_score,
        threshold=threshold,
        margin=margin,
        speaker_id=candidate.speaker_id,
        speaker_name=candidate.speaker_name,
        low_confidence=False,
    )


def _fallback(
    suspect_score: float,
    threshold: float,
    margin: float,
    second_best_score: float | None = None,
) -> SpeakerDecision:
    return SpeakerDecision(
        role=SpeakerRole.OFFICER_FALLBACK,
        source=SpeakerSource.SUSPECT_EXCLUSION,
        voiceprint_verified=False,
        score=suspect_score,
        second_best_score=second_best_score,
        threshold=threshold,
        margin=margin,
        speaker_id=None,
        speaker_name=None,
        low_confidence=False,
    )


def _unknown(
    threshold: float,
    margin: float,
    *,
    score: float | None = None,
    second_best_score: float | None = None,
) -> SpeakerDecision:
    return SpeakerDecision(
        role=SpeakerRole.UNKNOWN,
        source=SpeakerSource.UNASSIGNED,
        voiceprint_verified=False,
        score=score,
        second_best_score=second_best_score,
        threshold=threshold,
        margin=margin,
        speaker_id=None,
        speaker_name=None,
        low_confidence=True,
    )