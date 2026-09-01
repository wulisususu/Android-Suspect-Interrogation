from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from typing import Protocol, runtime_checkable


class SpeakerBackendKey(str, Enum):
    XVECTOR = "xvector"
    ERES2NET_LARGE = "eres2net_large"


class SpeakerRuntimeMode(str, Enum):
    XVECTOR = "xvector"
    ERES2NET_LARGE = "eres2net_large"
    COMPARE = "compare"


@dataclass(frozen=True, slots=True)
class SpeakerEmbeddingResult:
    embedding: list[float]
    backend_key: SpeakerBackendKey
    model_id: str
    model_version: str | None
    model_fingerprint: str | None
    latency_ms: float | None = None


@runtime_checkable
class SpeakerEmbeddingBackend(Protocol):
    key: SpeakerBackendKey

    def extract_embedding(self, pcm: bytes, sample_rate: int) -> SpeakerEmbeddingResult:
        ...
