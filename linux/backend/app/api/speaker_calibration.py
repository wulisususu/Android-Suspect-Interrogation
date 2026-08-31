from __future__ import annotations

from fastapi import APIRouter, Depends, Query, Request
from pydantic import BaseModel
from sqlalchemy.orm import Session

from app.ai.speech.fingerprint import fingerprint_microphone
from app.api.deps import get_db
from app.api.responses import envelope
from app.domain.errors import DomainError
from app.services.speaker_calibration_service import (
    CurrentMicrophoneIdentity,
    CurrentSpeakerModelIdentity,
    SpeakerCalibrationService,
)
from hardware.base import DeviceInfo


router = APIRouter(prefix="/speaker-calibration", tags=["speaker-calibration"])


class RecomputeBody(BaseModel):
    actor_id: str | None = None


def _model_provider(request: Request):
    injected = getattr(request.app.state, "speaker_calibration_model_provider", None)
    if callable(injected):
        return injected

    def provide() -> CurrentSpeakerModelIdentity:
        client = getattr(request.app.state, "speech_client", None)
        if client is None:
            raise DomainError("SPEAKER_MODEL_UNAVAILABLE", "XVector运行时未配置", 503)
        health = client.health()
        fingerprint = health.get("speaker_model_fingerprint") if isinstance(health, dict) else None
        if not fingerprint:
            raise DomainError("SPEAKER_MODEL_FINGERPRINT_UNAVAILABLE", "当前XVector模型指纹不可用", 503)
        return CurrentSpeakerModelIdentity(
            str(health.get("speaker_model_id") or "xvector"),
            None if health.get("speaker_model_version") is None else str(health.get("speaker_model_version")),
            str(fingerprint),
        )

    return provide


def _microphone_provider(request: Request):
    injected = getattr(request.app.state, "speaker_calibration_microphone_provider", None)
    if callable(injected):
        return injected

    def provide() -> CurrentMicrophoneIdentity:
        manager = getattr(request.app.state, "hardware_manager", None)
        audio = getattr(manager, "audio", None) if manager is not None else None
        info_fn = getattr(audio, "device_info", None)
        info = info_fn() if callable(info_fn) else None
        if not isinstance(info, DeviceInfo):
            device = str(getattr(audio, "device", None) or "default")
            info = DeviceInfo("audio", f"alsa:{device}", f"ALSA {device}", source="real", path=device, metadata={})
        identity = fingerprint_microphone(info)
        return CurrentMicrophoneIdentity(
            "ALSA",
            identity.device_id,
            identity.device_name,
            identity.fingerprint,
            identity.certainty,
        )

    return provide


def _service(request: Request, db: Session) -> SpeakerCalibrationService:
    return SpeakerCalibrationService(
        db,
        model_provider=_model_provider(request),
        microphone_provider=_microphone_provider(request),
    )


@router.get("/status")
def calibration_status(request: Request, db: Session = Depends(get_db)):
    return envelope(_service(request, db).status())


@router.get("/history")
def calibration_history(
    request: Request,
    limit: int = Query(50, ge=1, le=200),
    db: Session = Depends(get_db),
):
    return envelope(_service(request, db).history(limit=limit))


@router.post("/recompute")
def recompute_calibration(
    request: Request,
    body: RecomputeBody | None = None,
    db: Session = Depends(get_db),
):
    return envelope(
        _service(request, db).recompute(actor_id=body.actor_id if body else None),
        "设备声纹校准已重新计算",
    )
