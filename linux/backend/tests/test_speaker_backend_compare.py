from __future__ import annotations

import pytest

from app.services.speaker_backend_compare import (
    SpeakerBackendCompareCoordinator,
    SpeakerBackendDiagnostic,
)


def _diagnostic(
    backend_key: str,
    *,
    role: str = "SUSPECT",
    score: float | None = 0.91,
    latency_ms: float | None = 12.5,
    error_code: str | None = None,
) -> SpeakerBackendDiagnostic:
    return SpeakerBackendDiagnostic(
        backend_key=backend_key,
        role=role,
        speaker_source="SPEAKER_EMBEDDING" if error_code is None else "UNASSIGNED",
        voiceprint_verified=error_code is None,
        score=score,
        second_best_score=0.42 if score is not None else None,
        threshold=0.78,
        margin=0.06,
        calibration_id=f"CAL-{backend_key}",
        calibration_status="VALID",
        model_id=f"model-{backend_key}",
        model_version="v1",
        model_fingerprint=("a" if backend_key == "xvector" else "b") * 64,
        latency_ms=latency_ms,
        error_code=error_code,
    )


def test_compare_requires_explicit_supported_authoritative_backend():
    with pytest.raises(ValueError, match="authoritative"):
        SpeakerBackendCompareCoordinator(None)
    with pytest.raises(ValueError, match="authoritative"):
        SpeakerBackendCompareCoordinator("compare")

    assert SpeakerBackendCompareCoordinator("xvector").authoritative_backend == "xvector"
    assert SpeakerBackendCompareCoordinator("eres2net_large").authoritative_backend == "eres2net_large"


def test_compare_evidence_preserves_both_results_and_marks_only_one_authoritative():
    coordinator = SpeakerBackendCompareCoordinator("xvector")
    payload = coordinator.build_evidence(
        xvector=_diagnostic("xvector", role="SUSPECT", score=0.93, latency_ms=9.0),
        eres2net_large=_diagnostic("eres2net_large", role="INTERROGATOR", score=0.88, latency_ms=21.0),
    )

    assert payload["mode"] == "compare"
    assert payload["authoritativeBackend"] == "xvector"
    assert payload["authoritativeAvailable"] is True
    assert [item["backendKey"] for item in payload["results"]] == ["xvector", "eres2net_large"]

    authoritative, secondary = payload["results"]
    assert authoritative["authoritative"] is True
    assert authoritative["diagnosticOnly"] is False
    assert authoritative["role"] == "SUSPECT"
    assert authoritative["score"] == 0.93
    assert authoritative["calibrationId"] == "CAL-xvector"

    assert secondary["authoritative"] is False
    assert secondary["diagnosticOnly"] is True
    assert secondary["role"] == "INTERROGATOR"
    assert secondary["score"] == 0.88
    assert secondary["latencyMs"] == 21.0

    # Compare evidence may contain scores and model identity, never biometric vectors.
    assert all("embedding" not in item for item in payload["results"])


def test_secondary_failure_is_diagnostic_and_never_corrupts_authoritative_result():
    coordinator = SpeakerBackendCompareCoordinator("xvector")
    payload = coordinator.build_evidence(
        xvector=_diagnostic("xvector", role="SUSPECT", score=0.94),
        eres2net_large=_diagnostic(
            "eres2net_large",
            role="UNKNOWN",
            score=None,
            latency_ms=None,
            error_code="BACKEND_UNAVAILABLE",
        ),
    )

    authoritative, secondary = payload["results"]
    assert payload["authoritativeAvailable"] is True
    assert authoritative["role"] == "SUSPECT"
    assert authoritative["authoritative"] is True
    assert secondary["diagnosticOnly"] is True
    assert secondary["errorCode"] == "BACKEND_UNAVAILABLE"


def test_authoritative_failure_never_promotes_successful_secondary_to_business_authority():
    coordinator = SpeakerBackendCompareCoordinator("xvector")
    payload = coordinator.build_evidence(
        xvector=_diagnostic(
            "xvector",
            role="UNKNOWN",
            score=None,
            latency_ms=None,
            error_code="BACKEND_UNAVAILABLE",
        ),
        eres2net_large=_diagnostic("eres2net_large", role="SUSPECT", score=0.96),
    )

    authoritative, secondary = payload["results"]
    assert payload["authoritativeAvailable"] is False
    assert authoritative["authoritative"] is True
    assert authoritative["role"] == "UNKNOWN"
    assert authoritative["errorCode"] == "BACKEND_UNAVAILABLE"
    assert secondary["authoritative"] is False
    assert secondary["diagnosticOnly"] is True
    assert secondary["role"] == "SUSPECT"
