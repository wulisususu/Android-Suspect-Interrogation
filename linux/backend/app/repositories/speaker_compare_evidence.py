from __future__ import annotations

import json
from uuid import uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.recognition_models import SpeakerBackendComparisonEvidence


_BACKEND_ORDER = {"xvector": 0, "eres2net_large": 1}


def create_evidence(
    db: Session,
    *,
    fragment_id: str,
    capture_session_id: str,
    case_id: str,
    backend_key: str,
    authoritative: bool,
    available: bool,
    role: str,
    speaker_source: str,
    voiceprint_verified: bool,
    score: float | None,
    second_best_score: float | None,
    threshold: float | None,
    margin: float | None,
    calibration_id: str | None,
    calibration_status: str | None,
    model_id: str | None,
    model_version: str | None,
    model_fingerprint: str | None,
    latency_ms: float | None,
    error_code: str | None,
    candidate_scores: list[dict] | tuple[dict, ...],
) -> SpeakerBackendComparisonEvidence:
    key = str(backend_key or "").strip().lower()
    if key not in _BACKEND_ORDER:
        raise ValueError(f"unsupported speaker comparison backend: {backend_key!r}")
    normalized_candidates: list[dict[str, object]] = []
    for item in candidate_scores:
        if not isinstance(item, dict):
            raise ValueError("candidate_scores entries must be mappings")
        normalized_candidates.append(
            {
                "role": str(item.get("role") or "UNKNOWN"),
                "score": None if item.get("score") is None else float(item["score"]),
            }
        )
    row = SpeakerBackendComparisonEvidence(
        id=str(uuid4()),
        fragment_id=str(fragment_id),
        capture_session_id=str(capture_session_id),
        case_id=str(case_id),
        backend_key=key,
        authoritative=bool(authoritative),
        available=bool(available),
        role=str(role),
        speaker_source=str(speaker_source),
        voiceprint_verified=bool(voiceprint_verified),
        score=None if score is None else float(score),
        second_best_score=None if second_best_score is None else float(second_best_score),
        threshold=None if threshold is None else float(threshold),
        margin=None if margin is None else float(margin),
        calibration_id=None if calibration_id is None else str(calibration_id),
        calibration_status=None if calibration_status is None else str(calibration_status),
        model_id=None if model_id is None else str(model_id),
        model_version=None if model_version is None else str(model_version),
        model_fingerprint=None if model_fingerprint is None else str(model_fingerprint),
        latency_ms=None if latency_ms is None else float(latency_ms),
        error_code=None if error_code is None else str(error_code),
        candidate_scores_json=json.dumps(normalized_candidates, ensure_ascii=False, separators=(",", ":")),
    )
    db.add(row)
    db.flush()
    return row


def list_for_fragment(db: Session, fragment_id: str) -> list[SpeakerBackendComparisonEvidence]:
    rows = list(
        db.scalars(
            select(SpeakerBackendComparisonEvidence).where(
                SpeakerBackendComparisonEvidence.fragment_id == str(fragment_id)
            )
        )
    )
    rows.sort(key=lambda item: _BACKEND_ORDER.get(item.backend_key, 99))
    return rows
