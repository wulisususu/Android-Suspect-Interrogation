from __future__ import annotations

from dataclasses import dataclass
from typing import Any


_SUPPORTED_BACKENDS = ("xvector", "eres2net_large")


@dataclass(frozen=True)
class SpeakerBackendDiagnostic:
    """Non-biometric comparison evidence for one speaker backend decision.

    Embeddings deliberately do not belong to this structure. They are transient
    worker-to-policy inputs and must never be copied into persistent comparison
    evidence, ordinary logs, or audit payloads.
    """

    backend_key: str
    role: str
    speaker_source: str
    voiceprint_verified: bool
    score: float | None
    second_best_score: float | None
    threshold: float | None
    margin: float | None
    calibration_id: str | None
    calibration_status: str | None
    model_id: str | None
    model_version: str | None
    model_fingerprint: str | None
    latency_ms: float | None
    error_code: str | None = None

    def __post_init__(self) -> None:
        key = str(self.backend_key or "").strip().lower()
        if key not in _SUPPORTED_BACKENDS:
            raise ValueError(f"unsupported speaker backend diagnostic: {self.backend_key!r}")
        object.__setattr__(self, "backend_key", key)

    @property
    def available(self) -> bool:
        return self.error_code is None

    def to_evidence_dict(self, *, authoritative: bool) -> dict[str, Any]:
        return {
            "backendKey": self.backend_key,
            "authoritative": bool(authoritative),
            "diagnosticOnly": not bool(authoritative),
            "available": self.available,
            "role": str(self.role),
            "speakerSource": str(self.speaker_source),
            "voiceprintVerified": bool(self.voiceprint_verified),
            "score": self.score,
            "secondBestScore": self.second_best_score,
            "threshold": self.threshold,
            "margin": self.margin,
            "calibrationId": self.calibration_id,
            "calibrationStatus": self.calibration_status,
            "modelId": self.model_id,
            "modelVersion": self.model_version,
            "modelFingerprint": self.model_fingerprint,
            "latencyMs": self.latency_ms,
            "errorCode": self.error_code,
        }


class SpeakerBackendCompareCoordinator:
    """Build backend-neutral compare evidence without choosing a winner.

    Business authority is fixed by configuration before capture begins. A
    successful secondary result can never replace an unavailable authoritative
    backend. This coordinator only shapes diagnostic evidence; role mutation is
    owned by the existing authoritative ASR capture path.
    """

    def __init__(self, authoritative_backend: str | None) -> None:
        key = str(authoritative_backend or "").strip().lower()
        if key not in _SUPPORTED_BACKENDS:
            raise ValueError("authoritative speaker backend must be xvector or eres2net_large")
        self.authoritative_backend = key

    @property
    def secondary_backend(self) -> str:
        return "eres2net_large" if self.authoritative_backend == "xvector" else "xvector"

    def build_evidence(
        self,
        *,
        xvector: SpeakerBackendDiagnostic,
        eres2net_large: SpeakerBackendDiagnostic,
    ) -> dict[str, Any]:
        by_key = {
            "xvector": xvector,
            "eres2net_large": eres2net_large,
        }
        for expected, item in by_key.items():
            if item.backend_key != expected:
                raise ValueError(
                    f"compare diagnostic backend mismatch: expected {expected}, got {item.backend_key}"
                )
        authoritative = by_key[self.authoritative_backend]
        return {
            "mode": "compare",
            "authoritativeBackend": self.authoritative_backend,
            "authoritativeAvailable": authoritative.available,
            "results": [
                by_key[key].to_evidence_dict(authoritative=(key == self.authoritative_backend))
                for key in _SUPPORTED_BACKENDS
            ],
        }
