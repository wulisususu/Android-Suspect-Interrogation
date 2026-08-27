from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Depends, Query, Request
from pydantic import BaseModel, Field
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.api.deps import get_db
from app.database.models import ASRFragment
from app.domain.errors import DomainError
from app.repositories import asr_fragments as asr_repo
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.services.message_service import MessageService
from app.services.speaker_policy import SpeakerRole, SpeakerSource


router = APIRouter(tags=["asr"])


class FragmentUpdateRequest(BaseModel):
    edited_text: str = ""
    speaker: str
    actor_id: str | None = None


class FragmentBatchRequest(BaseModel):
    fragment_ids: list[str] = Field(default_factory=list)
    actor_id: str | None = None


def _supervisor(request: Request):
    return request.app.state.ai_supervisor


def _capture_service(request: Request):
    service = getattr(request.app.state, "asr_capture_service", None)
    if service is None:
        raise DomainError("ASR_CAPTURE_UNAVAILABLE", "连续语音采集服务未配置", 503)
    return service


def _fragment_for_case(db: Session, case_id: str, fragment_id: str) -> ASRFragment:
    case_repo.get(db, case_id)
    fragment = asr_repo.get_fragment(db, fragment_id)
    if fragment.case_id != case_id:
        raise DomainError("ASR_FRAGMENT_NOT_FOUND", "ASR 临时片段不存在", 404)
    return fragment


def _fragment_payload(fragment: ASRFragment) -> dict[str, Any]:
    return {
        "fragmentId": fragment.id,
        "captureSessionId": fragment.capture_session_id,
        "caseId": fragment.case_id,
        "ordinal": fragment.ordinal,
        "startedAtMs": fragment.started_at_ms,
        "endedAtMs": fragment.ended_at_ms,
        "rawText": fragment.raw_text,
        "editedText": fragment.edited_text,
        "asrConfidence": fragment.asr_confidence,
        "speaker": fragment.speaker,
        "speakerId": fragment.speaker_id,
        "speakerName": fragment.speaker_name,
        "speakerScore": fragment.speaker_score,
        "secondBestScore": fragment.second_best_score,
        "speakerThreshold": fragment.speaker_threshold,
        "speakerMargin": fragment.speaker_margin,
        "speakerSource": fragment.speaker_source,
        "voiceprintVerified": fragment.voiceprint_verified,
        "lowConfidence": fragment.low_confidence,
        "state": fragment.state,
        "modelId": fragment.model_id,
        "modelVersion": fragment.model_version,
        "confirmedMessageId": fragment.confirmed_message_id,
        "createdAt": fragment.created_at.isoformat() if fragment.created_at is not None else None,
        "updatedAt": fragment.updated_at.isoformat() if fragment.updated_at is not None else None,
    }


def _asr_status(request: Request) -> dict[str, Any]:
    supervisor = _supervisor(request)
    health = supervisor.health()
    capabilities = supervisor.capabilities()
    speech = health.get("speech") or {}
    threshold = getattr(supervisor, "speaker_accept_threshold", None)
    margin = getattr(supervisor, "speaker_margin", None)
    calibrated = threshold is not None and margin is not None
    ready = speech.get("state") == "READY" and capabilities.get("asr", {}).get("state") not in {"ERROR", "NOT_CONFIGURED"}
    return {
        "state": "AVAILABLE" if ready else "ERROR",
        "speech": speech,
        "capabilities": {
            "asr": capabilities.get("asr"),
            "vad": capabilities.get("vad"),
            "speaker": capabilities.get("speaker"),
        },
        "calibration": {
            "configured": calibrated,
            "threshold": threshold,
            "margin": margin,
        },
    }


def _official_message_speaker(role: str) -> str:
    """Map fine-grained ASR attribution to the existing official transcript vocabulary.

    The official Message model deliberately supports only 民警/嫌疑人. Keep the
    richer INTERROGATOR/RECORDER/OFFICER_FALLBACK value on ASRFragment for
    provenance; UNKNOWN must be resolved manually before formal confirmation.
    """
    try:
        normalized = SpeakerRole(str(role))
    except ValueError as exc:
        raise DomainError("INVALID_SPEAKER_ROLE", "ASR 片段包含无效的说话人角色", 409) from exc

    if normalized is SpeakerRole.SUSPECT:
        return "嫌疑人"
    if normalized in {
        SpeakerRole.INTERROGATOR,
        SpeakerRole.RECORDER,
        SpeakerRole.OFFICER_FALLBACK,
    }:
        return "民警"
    raise DomainError(
        "ASR_SPEAKER_CONFIRMATION_REQUIRED",
        "说话人尚未确认，请先人工指定嫌疑人或民警角色后再写入正式笔录",
        409,
    )


@router.get("/asr/status")
def asr_status(request: Request):
    return _asr_status(request)


@router.post("/asr/start")
def asr_start(request: Request):
    status = _asr_status(request)
    if status["state"] != "AVAILABLE":
        raise DomainError("ASR_NOT_READY", "离线语音运行时尚未就绪", 503, status)
    return status


@router.post("/asr/stop")
def asr_stop(request: Request):
    _capture_service(request).shutdown()
    status = _asr_status(request)
    status["capturesStopped"] = True
    return status


@router.get("/cases/{case_id}/asr/capture")
def capture_status(case_id: str, request: Request):
    return _capture_service(request).status(case_id)


@router.post("/cases/{case_id}/asr/capture/start")
def capture_start(case_id: str, request: Request):
    return _capture_service(request).start(case_id)


@router.post("/cases/{case_id}/asr/capture/stop")
def capture_stop(case_id: str, request: Request):
    return _capture_service(request).stop(case_id)


@router.get("/cases/{case_id}/asr/fragments")
def list_fragments(
    case_id: str,
    include_confirmed: bool = Query(False),
    db: Session = Depends(get_db),
):
    case_repo.get(db, case_id)
    stmt = select(ASRFragment).where(
        ASRFragment.case_id == case_id,
        ASRFragment.state != "DISCARDED",
    )
    if not include_confirmed:
        stmt = stmt.where(ASRFragment.state != "CONFIRMED")
    stmt = stmt.order_by(ASRFragment.created_at.asc(), ASRFragment.ordinal.asc())
    return [_fragment_payload(row) for row in db.scalars(stmt)]


@router.put("/cases/{case_id}/asr/fragments/{fragment_id}")
def update_fragment(
    case_id: str,
    fragment_id: str,
    body: FragmentUpdateRequest,
    db: Session = Depends(get_db),
):
    fragment = _fragment_for_case(db, case_id, fragment_id)
    if fragment.state == "DISCARDED":
        raise DomainError("ASR_FRAGMENT_DISCARDED", "已丢弃的 ASR 片段不能修改", 409)
    try:
        role = SpeakerRole(str(body.speaker))
    except ValueError as exc:
        raise DomainError("INVALID_SPEAKER_ROLE", "无效的说话人角色", 400) from exc

    before = {
        "edited_text": fragment.edited_text,
        "speaker": fragment.speaker,
        "speaker_source": fragment.speaker_source,
    }
    row = asr_repo.update_fragment(
        db,
        fragment_id=fragment_id,
        edited_text=body.edited_text,
        speaker=role.value,
        speaker_id=None,
        speaker_name=None,
        speaker_source=SpeakerSource.MANUAL.value,
        voiceprint_verified=False,
        low_confidence=role is SpeakerRole.UNKNOWN,
    )
    audit_repo.add(
        db,
        case_id=case_id,
        actor_id=body.actor_id,
        action="ASR_FRAGMENT_UPDATE",
        target_type="ASR_FRAGMENT",
        target_id=row.id,
        before=before,
        after={
            "edited_text": row.edited_text,
            "speaker": row.speaker,
            "speaker_source": row.speaker_source,
        },
        detail={"raw_text_unchanged": True},
    )
    db.commit()
    return _fragment_payload(row)


def _confirm_one(
    db: Session,
    *,
    case_id: str,
    fragment_id: str,
    actor_id: str | None,
) -> tuple[ASRFragment, bool]:
    fragment = _fragment_for_case(db, case_id, fragment_id)
    if fragment.state == "DISCARDED":
        raise DomainError("ASR_FRAGMENT_DISCARDED", "已丢弃的 ASR 片段不能确认", 409)
    if fragment.state == "CONFIRMED":
        return fragment, False

    official_speaker = _official_message_speaker(fragment.speaker)
    message = MessageService(db).create(
        case_id,
        text=fragment.edited_text,
        speaker=official_speaker,
        actor_id=actor_id,
        commit=False,
    )
    row = asr_repo.confirm_fragment(db, fragment_id=fragment.id, message_id=message["id"])
    audit_repo.add(
        db,
        case_id=case_id,
        actor_id=actor_id,
        action="ASR_FRAGMENT_CONFIRM",
        target_type="ASR_FRAGMENT",
        target_id=row.id,
        after={
            "message_id": message["id"],
            "speaker": row.speaker,
            "official_speaker": official_speaker,
            "text": row.edited_text,
        },
        detail={"raw_text": row.raw_text},
    )
    db.commit()
    return row, True


@router.post("/cases/{case_id}/asr/fragments/{fragment_id}/confirm")
def confirm_fragment(
    case_id: str,
    fragment_id: str,
    db: Session = Depends(get_db),
):
    row, _ = _confirm_one(db, case_id=case_id, fragment_id=fragment_id, actor_id=None)
    return _fragment_payload(row)


def _confirm_batch(
    db: Session,
    *,
    case_id: str,
    fragment_ids: list[str],
    actor_id: str | None,
) -> dict[str, Any]:
    case_repo.get(db, case_id)
    unique_ids = list(dict.fromkeys(str(item).strip() for item in fragment_ids if str(item).strip()))
    confirmed = 0
    rows: list[ASRFragment] = []
    for fragment_id in unique_ids:
        row, created = _confirm_one(db, case_id=case_id, fragment_id=fragment_id, actor_id=actor_id)
        rows.append(row)
        confirmed += int(created)
    return {
        "confirmedCount": confirmed,
        "fragments": [_fragment_payload(row) for row in rows],
    }


@router.post("/cases/{case_id}/asr/fragments/confirm")
def confirm_fragments(
    case_id: str,
    body: FragmentBatchRequest,
    db: Session = Depends(get_db),
):
    return _confirm_batch(
        db,
        case_id=case_id,
        fragment_ids=body.fragment_ids,
        actor_id=body.actor_id,
    )


@router.post("/cases/{case_id}/asr/fragments/apply")
def apply_fragments(
    case_id: str,
    body: FragmentBatchRequest,
    db: Session = Depends(get_db),
):
    fragment_ids = list(body.fragment_ids)
    if not fragment_ids:
        fragment_ids = list(
            db.scalars(
                select(ASRFragment.id)
                .where(
                    ASRFragment.case_id == case_id,
                    ASRFragment.state.in_(["PENDING", "EDITED"]),
                )
                .order_by(ASRFragment.created_at.asc(), ASRFragment.ordinal.asc())
            )
        )
    return _confirm_batch(
        db,
        case_id=case_id,
        fragment_ids=fragment_ids,
        actor_id=body.actor_id,
    )


@router.post("/cases/{case_id}/asr/fragments/{fragment_id}/discard")
def discard_fragment(
    case_id: str,
    fragment_id: str,
    db: Session = Depends(get_db),
):
    fragment = _fragment_for_case(db, case_id, fragment_id)
    if fragment.state == "CONFIRMED":
        raise DomainError("ASR_FRAGMENT_ALREADY_CONFIRMED", "已确认的 ASR 片段不能丢弃", 409)
    if fragment.state != "DISCARDED":
        before = {"state": fragment.state}
        fragment.state = "DISCARDED"
        audit_repo.add(
            db,
            case_id=case_id,
            actor_id=None,
            action="ASR_FRAGMENT_DISCARD",
            target_type="ASR_FRAGMENT",
            target_id=fragment.id,
            before=before,
            after={"state": "DISCARDED"},
        )
        db.commit()
    return _fragment_payload(fragment)
