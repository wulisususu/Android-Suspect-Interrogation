from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import Any


class SpeechEventType(str, Enum):
    VAD_START = "VAD_START"
    VAD_END = "VAD_END"
    ASR_PARTIAL = "ASR_PARTIAL"
    ASR_FINAL = "ASR_FINAL"
    SPEAKER_RESULT = "SPEAKER_RESULT"
    SPEAKER_COMPARE_RESULT = "SPEAKER_COMPARE_RESULT"
    ERROR = "ERROR"


@dataclass(frozen=True)
class SpeechEvent:
    type: SpeechEventType
    session_id: str
    start_ms: int | None = None
    end_ms: int | None = None
    text: str | None = None
    confidence: float | None = None
    embedding: list[float] | None = None
    model_id: str | None = None
    details: dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_dict(cls, payload: dict[str, Any]) -> "SpeechEvent":
        embedding = payload.get("embedding")
        return cls(
            type=SpeechEventType(str(payload["type"])),
            session_id=str(payload["session_id"]),
            start_ms=_optional_int(payload.get("start_ms")),
            end_ms=_optional_int(payload.get("end_ms")),
            text=_optional_str(payload.get("text")),
            confidence=_optional_float(payload.get("confidence")),
            embedding=[float(value) for value in embedding] if embedding is not None else None,
            model_id=_optional_str(payload.get("model_id")),
            details=dict(payload.get("details") or {}),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "type": self.type.value,
            "session_id": self.session_id,
            "start_ms": self.start_ms,
            "end_ms": self.end_ms,
            "text": self.text,
            "confidence": self.confidence,
            "embedding": self.embedding,
            "model_id": self.model_id,
            "details": dict(self.details),
        }


def _optional_int(value: Any) -> int | None:
    return None if value is None else int(value)


def _optional_float(value: Any) -> float | None:
    return None if value is None else float(value)


def _optional_str(value: Any) -> str | None:
    return None if value is None else str(value)
