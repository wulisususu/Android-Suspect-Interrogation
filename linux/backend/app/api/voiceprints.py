from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Depends, Query, Request
from pydantic import BaseModel, Field
from sqlalchemy.orm import Session

from app.ai.errors import AIError, ResourceBusyError
from app.api.deps import get_db
from app.api.responses import envelope
from app.domain.errors import DomainError
from app.services.voiceprint_service import VoiceprintService


router = APIRouter(tags=["voiceprints"])


class ActorBody(BaseModel):
    actor_id: str | None = None


class OfficerEnrollmentStartBody(ActorBody):
    officer_name: str = Field(min_length=1, max_length=128)


class VoiceRoleAssignmentBody(ActorBody):
    interrogator_officer_id: str | None = Field(default=None, max_length=128)
    recorder_officer_id: str | None = Field(default=None, max_length=128)


def _speech_client(request: Request):
    client = getattr(request.app.state, "speech_client", None)
    if client is None:
        raise DomainError("SPEECH_RUNTIME_UNAVAILABLE", "离线语音运行时未配置", 503)
    return client


def _capture_service(request: Request):
    capture = getattr(request.app.state, "voiceprint_capture", None)
    if capture is None:
        raise DomainError("AUDIO_DEVICE_NOT_CONFIGURED", "声纹录音设备未配置", 503)
    return capture


def _service(request: Request, db: Session) -> VoiceprintService:
    return VoiceprintService(db, speech_client=_speech_client(request))


def _context(request: Request) -> dict[str, Any]:
    context = getattr(request.app.state, "voiceprint_enrollment_context", None)
    if context is None:
        context = {}
        request.app.state.voiceprint_enrollment_context = context
    return context


def _set_context(request: Request, *, kind: str, subject_id: str, **extra: Any) -> None:
    context = _context(request)
    context.clear()
    context.update({"kind": kind, "subject_id": subject_id, **extra})


def _clear_context(request: Request, *, kind: str, subject_id: str) -> dict[str, Any]:
    context = dict(_context(request))
    if context.get("kind") != kind or context.get("subject_id") != subject_id:
        raise DomainError("CAPTURE_SUBJECT_MISMATCH", "当前声纹录音上下文不匹配", 409)
    _context(request).clear()
    return context


def _raise_ai_error(exc: AIError) -> None:
    status = 409 if isinstance(exc, ResourceBusyError) else 503
    raise DomainError(exc.code, exc.message, status, data=exc.details) from exc


@router.get("/cases/{case_id}/voiceprints/readiness")
def readiness(case_id: str, request: Request, db: Session = Depends(get_db)):
    return envelope(_service(request, db).readiness(case_id))


@router.get("/voiceprints/enrollment/status")
def enrollment_status(request: Request):
    return envelope(_capture_service(request).status())


@router.post("/cases/{case_id}/voiceprints/suspect/enrollment/start")
def start_suspect_enrollment(
    case_id: str,
    request: Request,
    body: ActorBody | None = None,
    db: Session = Depends(get_db),
):
    # Validate the case before occupying the process-global recorder.
    _service(request, db).readiness(case_id)
    result = _capture_service(request).start("suspect", case_id)
    _set_context(request, kind="suspect", subject_id=case_id)
    return envelope(result, "嫌疑人声纹录音已开始")


@router.post("/cases/{case_id}/voiceprints/suspect/enrollment/stop")
def stop_suspect_enrollment(
    case_id: str,
    request: Request,
    body: ActorBody | None = None,
    db: Session = Depends(get_db),
):
    context = dict(_context(request))
    if context.get("kind") != "suspect" or context.get("subject_id") != case_id:
        raise DomainError("CAPTURE_SUBJECT_MISMATCH", "当前嫌疑人声纹录音上下文不匹配", 409)
    pcm = _capture_service(request).stop("suspect", case_id)
    _clear_context(request, kind="suspect", subject_id=case_id)
    try:
        result = _service(request, db).enroll_suspect(
            case_id,
            pcm,
            actor_id=body.actor_id if body else None,
        )
    except AIError as exc:
        _raise_ai_error(exc)
    return envelope(result, "嫌疑人声纹已注册")


@router.get("/officer-voiceprints")
def list_officer_voiceprints(
    request: Request,
    active_only: bool = Query(True),
    db: Session = Depends(get_db),
):
    return envelope(_service(request, db).list_officers(active_only=active_only))


@router.post("/officer-voiceprints/{officer_id}/enrollment/start")
def start_officer_enrollment(
    officer_id: str,
    body: OfficerEnrollmentStartBody,
    request: Request,
    db: Session = Depends(get_db),
):
    # Build the service here so a missing speech runtime is reported before
    # occupying the shared recorder.
    _service(request, db)
    result = _capture_service(request).start("officer", officer_id)
    _set_context(
        request,
        kind="officer",
        subject_id=officer_id,
        officer_name=body.officer_name.strip(),
    )
    return envelope(result, "民警声纹录音已开始")


@router.post("/officer-voiceprints/{officer_id}/enrollment/stop")
def stop_officer_enrollment(
    officer_id: str,
    request: Request,
    body: ActorBody | None = None,
    db: Session = Depends(get_db),
):
    context = dict(_context(request))
    if context.get("kind") != "officer" or context.get("subject_id") != officer_id:
        raise DomainError("CAPTURE_SUBJECT_MISMATCH", "当前民警声纹录音上下文不匹配", 409)
    officer_name = str(context.get("officer_name") or "").strip()
    if not officer_name:
        raise DomainError("OFFICER_IDENTITY_REQUIRED", "民警姓名不能为空", 400)
    pcm = _capture_service(request).stop("officer", officer_id)
    _clear_context(request, kind="officer", subject_id=officer_id)
    service = _service(request, db)
    try:
        existing = next(
            (item for item in service.list_officers(active_only=False) if item["officerId"] == officer_id),
            None,
        )
        if existing is None:
            result = service.enroll_officer(
                officer_id,
                officer_name,
                pcm,
                actor_id=body.actor_id if body else None,
            )
        else:
            result = service.update_officer(
                officer_id,
                pcm,
                actor_id=body.actor_id if body else None,
            )
    except AIError as exc:
        _raise_ai_error(exc)
    return envelope(result, "民警声纹已保存")


@router.delete("/officer-voiceprints/{officer_id}")
def revoke_officer_voiceprint(
    officer_id: str,
    request: Request,
    actor_id: str | None = Query(default=None),
    db: Session = Depends(get_db),
):
    return envelope(
        _service(request, db).revoke_officer(officer_id, actor_id=actor_id),
        "民警声纹已撤销",
    )


@router.put("/cases/{case_id}/voiceprints/assignments")
def assign_voice_roles(
    case_id: str,
    body: VoiceRoleAssignmentBody,
    request: Request,
    db: Session = Depends(get_db),
):
    return envelope(
        _service(request, db).bind_roles(
            case_id,
            body.interrogator_officer_id,
            body.recorder_officer_id,
            actor_id=body.actor_id,
        ),
        "审讯声纹角色已绑定",
    )
