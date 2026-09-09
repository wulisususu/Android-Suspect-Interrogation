"""Typed snapshots/results and MOSS wire error codes for the worker client."""
from __future__ import annotations

from dataclasses import dataclass
from typing import Any

from ..errors import AIError


class MossWorkerError(AIError):
    """Base class for MOSS worker-reported failures; subclasses pin wire codes."""

    code = "MOSS_ERROR"


class MossModelError(MossWorkerError):
    code = "MOSS_MODEL"


class MossRknnError(MossWorkerError):
    code = "MOSS_RKNN"


class MossRkllmError(MossWorkerError):
    code = "MOSS_RKLLM"


class MossContextError(MossWorkerError):
    code = "MOSS_CONTEXT"


class MossOomError(MossWorkerError):
    code = "MOSS_OOM"


class MossInvalidGenerationError(MossWorkerError):
    code = "MOSS_INVALID_GENERATION"


class MossAudioCorruptError(MossWorkerError):
    code = "MOSS_AUDIO_CORRUPT"


class MossAudioUnsupportedError(MossWorkerError):
    code = "MOSS_AUDIO_FORMAT"


class MossAudioChangedError(MossWorkerError):
    code = "MOSS_AUDIO_CHANGED"


class MossCancelledError(MossWorkerError):
    code = "MOSS_CANCELLED"


class MossRevisionChangedError(MossWorkerError):
    code = "MOSS_REVISION_CHANGED"


class MossJobNotFoundError(MossWorkerError):
    code = "MOSS_JOB_NOT_FOUND"


class MossGenerationLimitError(MossWorkerError):
    code = "GENERATION_LIMIT_REACHED"


@dataclass(frozen=True)
class MossWindowStatus:
    """Per-window status preserving failed interval, attempt tier and termination."""

    window_id: str
    start_ms: int
    end_ms: int
    window_minutes: int
    state: str
    parse_status: str | None
    error: str | None
    token_count: int | None
    normal_termination: bool | None
    # Task 16 (additive): worker publishes the per-window published segment
    # count; None when an older worker build omits it.
    segment_count: int | None = None
    # Task 16 (additive): DONE windows additionally carry their published
    # segments in the worker's get_result serialization; () when an older
    # worker build (or a non-DONE window) omits the key.
    segments: tuple["MossTranscriptSegment", ...] = ()

    @classmethod
    def from_dict(cls, payload: dict[str, Any]) -> "MossWindowStatus":
        # Missing key (older worker build / non-DONE window) or explicit null
        # tolerates to an empty tuple; anything else non-list is a contract
        # violation.
        segments = payload.get("segments")
        if segments is None:
            segments = ()
        elif not isinstance(segments, list):
            raise ValueError("segments must be a JSON array")
        return cls(
            window_id=str(payload["window_id"]),
            start_ms=int(payload["start_ms"]),
            end_ms=int(payload["end_ms"]),
            window_minutes=int(payload["window_minutes"]),
            state=str(payload["state"]),
            parse_status=_optional_str(payload.get("parse_status")),
            error=_optional_str(payload.get("error")),
            token_count=_optional_int(payload.get("token_count")),
            normal_termination=_optional_bool(payload.get("normal_termination")),
            segment_count=_optional_int(payload.get("segment_count")),
            segments=tuple(MossTranscriptSegment.from_dict(item) for item in segments),
        )


@dataclass(frozen=True)
class MossJobSnapshot:
    job_id: str
    state: str
    audio_sha256: str
    model_manifest_sha256: str
    progress: float
    error: str | None
    windows: tuple[MossWindowStatus, ...] = ()

    @classmethod
    def from_dict(cls, payload: dict[str, Any]) -> "MossJobSnapshot":
        windows = payload.get("windows") or []
        if not isinstance(windows, list):
            raise ValueError("windows must be a JSON array")
        return cls(
            job_id=str(payload["job_id"]),
            state=str(payload["state"]),
            audio_sha256=str(payload["audio_sha256"]),
            model_manifest_sha256=str(payload["model_manifest_sha256"]),
            progress=float(payload["progress"]),
            error=_optional_str(payload.get("error")),
            windows=tuple(MossWindowStatus.from_dict(item) for item in windows),
        )


@dataclass(frozen=True)
class MossTranscriptSegment:
    segment_id: str
    window_id: str
    start_ms: int
    end_ms: int
    local_speaker: str
    global_speaker: str | None
    text: str
    speaker_mapping_confidence: float | None
    parse_status: str
    merge_status: str
    alternate: "MossTranscriptSegment | None"
    model_manifest_sha256: str

    @classmethod
    def from_dict(cls, payload: dict[str, Any]) -> "MossTranscriptSegment":
        alternate = payload.get("alternate")
        return cls(
            segment_id=str(payload["segment_id"]),
            window_id=str(payload["window_id"]),
            start_ms=int(payload["start_ms"]),
            end_ms=int(payload["end_ms"]),
            local_speaker=str(payload["local_speaker"]),
            global_speaker=_optional_str(payload.get("global_speaker")),
            text=str(payload["text"]),
            speaker_mapping_confidence=_optional_float(payload.get("speaker_mapping_confidence")),
            parse_status=str(payload["parse_status"]),
            merge_status=str(payload["merge_status"]),
            alternate=cls.from_dict(alternate) if alternate is not None else None,
            model_manifest_sha256=str(payload["model_manifest_sha256"]),
        )


@dataclass(frozen=True)
class MossJobResult:
    job_id: str
    audio_sha256: str
    model_manifest_sha256: str
    segments: tuple[MossTranscriptSegment, ...]

    @classmethod
    def from_dict(cls, payload: dict[str, Any]) -> "MossJobResult":
        segments = payload["segments"]
        if not isinstance(segments, list):
            raise ValueError("segments must be a JSON array")
        return cls(
            job_id=str(payload["job_id"]),
            audio_sha256=str(payload["audio_sha256"]),
            model_manifest_sha256=str(payload["model_manifest_sha256"]),
            segments=tuple(MossTranscriptSegment.from_dict(item) for item in segments),
        )


def _optional_int(value: Any) -> int | None:
    return None if value is None else int(value)


def _optional_float(value: Any) -> float | None:
    return None if value is None else float(value)


def _optional_str(value: Any) -> str | None:
    return None if value is None else str(value)


def _optional_bool(value: Any) -> bool | None:
    return None if value is None else bool(value)
