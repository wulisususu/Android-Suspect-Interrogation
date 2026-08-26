from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime, timezone
from enum import Enum
from typing import Any


class EngineState(str, Enum):
    NOT_INSTALLED = "NOT_INSTALLED"
    LOADING = "LOADING"
    READY = "READY"
    BUSY = "BUSY"
    ERROR = "ERROR"
    STOPPED = "STOPPED"


def utc_now_iso() -> str:
    return datetime.now(timezone.utc).isoformat()


@dataclass(frozen=True)
class AITextResult:
    text: str
    model_id: str
    session_id: str
    source: str = "ai"
    created_at: str = field(default_factory=utc_now_iso)


@dataclass(frozen=True)
class AIStreamChunk:
    text: str
    model_id: str
    session_id: str
    final: bool = False
    source: str = "ai"
    created_at: str = field(default_factory=utc_now_iso)


@dataclass(frozen=True)
class ASRResult:
    text: str
    confidence: float
    model_id: str
    session_id: str
    final: bool = True
    source: str = "ai"
    created_at: str = field(default_factory=utc_now_iso)


@dataclass(frozen=True)
class OCRResult:
    text: str
    confidence: float
    fields: dict[str, Any]
    model_id: str
    session_id: str
    source: str = "ai"
    created_at: str = field(default_factory=utc_now_iso)
