"""Business API: MOSS transcription wired into interrogation cases (Task 16).

All endpoints answer the repository envelope and degrade to ``503
MOSS_DISABLED`` when ``MOSS_ENABLED=0`` (or when no coordinator is wired).
Worker-side failures map through the existing AI error taxonomy; business
rejections (unknown case, missing audio, hash mismatch, active job) use the
shared ``DomainError`` contract.
"""
from __future__ import annotations

from fastapi import APIRouter, Request
from pydantic import BaseModel, Field

from app.ai.errors import AIError
from app.api.responses import envelope
from app.domain.errors import DomainError

router = APIRouter(tags=["moss-transcription"])


class MossSubmitRequest(BaseModel):
    audioPath: str
    audioSha256: str | None = None


class MossResubmitRequest(BaseModel):
    audioPath: str


class MossMappingItem(BaseModel):
    globalSpeaker: str
    role: str


class MossMappingRequest(BaseModel):
    mappings: list[MossMappingItem] = Field(default_factory=list)


def _coordinator(request: Request):
    coordinator = getattr(request.app.state, "moss_coordinator", None)
    if coordinator is None:
        raise DomainError("MOSS_DISABLED", "MOSS 长音频转写未启用 (MOSS_ENABLED=0)", 503)
    return coordinator


def _domain_error(exc: AIError) -> DomainError:
    """Map worker-side AI errors onto HTTP semantics (mirrors ai_runtime)."""
    status = {
        "MODEL_NOT_INSTALLED": 503,
        "BACKEND_UNAVAILABLE": 503,
        "WORKER_CRASHED": 503,
        "WORKER_TIMEOUT": 504,
        "RESOURCE_BUSY": 409,
        "WORKER_CANCELLED": 409,
        "MOSS_JOB_NOT_FOUND": 404,
        "MOSS_AUDIO_CHANGED": 409,
        "MOSS_AUDIO_CORRUPT": 400,
        "MOSS_AUDIO_EMPTY": 400,
        "MOSS_AUDIO_FORMAT": 400,
        "MOSS_CANCELLED": 409,
        "MOSS_RESULT_NOT_READY": 409,
    }.get(exc.code, 502)
    return DomainError(exc.code, exc.message, status, exc.details)


@router.post("/cases/{case_id}/moss-transcription")
def submit_moss_transcription(case_id: str, body: MossSubmitRequest, request: Request):
    try:
        data = _coordinator(request).submit(case_id, body.audioPath, body.audioSha256)
    except AIError as exc:
        raise _domain_error(exc) from exc
    return envelope(data, "MOSS 转写任务已提交")


@router.get("/cases/{case_id}/moss-transcription")
def moss_transcription_status(case_id: str, request: Request):
    return envelope(_coordinator(request).status(case_id))


@router.get("/cases/{case_id}/moss-transcription/transcript")
def moss_transcription_transcript(case_id: str, request: Request):
    return envelope(_coordinator(request).transcript(case_id))


@router.post("/cases/{case_id}/moss-transcription/resubmit")
def resubmit_moss_transcription(case_id: str, body: MossResubmitRequest, request: Request):
    try:
        data = _coordinator(request).resubmit(case_id, body.audioPath)
    except AIError as exc:
        raise _domain_error(exc) from exc
    return envelope(data, "MOSS 转写任务已重新提交")


@router.get("/cases/{case_id}/moss-speaker-mapping")
def get_moss_speaker_mapping(case_id: str, request: Request):
    return envelope(_coordinator(request).get_mapping(case_id))


@router.put("/cases/{case_id}/moss-speaker-mapping")
def put_moss_speaker_mapping(case_id: str, body: MossMappingRequest, request: Request):
    return envelope(
        _coordinator(request).put_mapping(case_id, [item.model_dump() for item in body.mappings]),
        "说话人映射已保存",
    )
