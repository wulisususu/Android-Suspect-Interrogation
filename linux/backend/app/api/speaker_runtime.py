from __future__ import annotations

from typing import Any, Literal

from fastapi import APIRouter, Request
from pydantic import BaseModel, model_validator

from app.api.responses import envelope
from app.domain.errors import DomainError


router = APIRouter(prefix="/speaker-runtime", tags=["speaker-runtime"])
SpeakerBackendKey = Literal["xvector", "eres2net_large"]
SpeakerRuntimeMode = Literal["xvector", "eres2net_large", "compare"]
_CONCRETE_BACKENDS = ("xvector", "eres2net_large")


class SpeakerRuntimeSelectionBody(BaseModel):
    mode: SpeakerRuntimeMode
    authoritative_backend: SpeakerBackendKey | None = None

    @model_validator(mode="after")
    def validate_selection(self) -> "SpeakerRuntimeSelectionBody":
        if self.mode == "compare" and self.authoritative_backend is None:
            raise ValueError("authoritative_backend is required for compare mode")
        if self.mode != "compare" and self.authoritative_backend not in {None, self.mode}:
            raise ValueError("authoritative_backend must match the selected single backend")
        return self


def _health(request: Request) -> dict[str, Any]:
    client = getattr(request.app.state, "speech_client", None)
    if client is None:
        return {}
    try:
        payload = client.health()
    except Exception as exc:
        return {"runtime_error": type(exc).__name__}
    return payload if isinstance(payload, dict) else {}


def _backend_health(health: dict[str, Any], backend: str) -> dict[str, Any]:
    backends = health.get("speaker_backends")
    raw = backends.get(backend) if isinstance(backends, dict) else None
    if not isinstance(raw, dict):
        raw = health if backend == "xvector" else {}
    error = raw.get("error")
    error_code = None
    error_type = None
    if isinstance(error, dict):
        error_code = error.get("code")
        error_type = error.get("error_type") or error.get("type")
    elif error:
        error_code = "BACKEND_UNAVAILABLE"
        error_type = type(error).__name__
    ready = bool(raw.get("ready"))
    installed = error_code not in {"MODEL_NOT_CONFIGURED", "MODEL_NOT_INSTALLED"}
    if not raw:
        installed = False
    return {
        "ready": ready,
        "installed": installed,
        "modelId": raw.get("model_id") or raw.get("speaker_model_id"),
        "modelVersion": raw.get("model_version") or raw.get("speaker_model_version"),
        "modelFingerprint": raw.get("model_fingerprint") or raw.get("speaker_model_fingerprint"),
        "errorCode": error_code,
        "errorType": error_type,
    }


def _status_payload(request: Request) -> dict[str, Any]:
    settings = request.app.state.runtime_settings
    mode = str(getattr(settings, "speaker_backend", "xvector") or "xvector").strip().lower()
    authority = (
        str(getattr(settings, "speaker_authoritative_backend", None) or "").strip().lower()
        if mode == "compare"
        else mode
    )
    if not authority:
        authority = "xvector"
    health = _health(request)
    normalized = {backend: _backend_health(health, backend) for backend in _CONCRETE_BACKENDS}
    secondary = "eres2net_large" if authority == "xvector" else "xvector"
    degraded = bool(mode == "compare" and not normalized[secondary]["ready"])
    return {
        "selection": {"mode": mode, "authoritativeBackend": authority},
        "backends": normalized,
        "degraded": degraded,
        "comparisonMetrics": {
            "correctRoleRate": None,
            "errorRate": None,
            "unknownRate": None,
            "latencyMs": {"xvector": None, "eres2net_large": None},
            "status": "CONTROLLED_GROUND_TRUTH_REQUIRED",
        },
    }


@router.get("")
def speaker_runtime_status(request: Request):
    return envelope(_status_payload(request))


@router.put("/selection")
def update_speaker_runtime_selection(request: Request, body: SpeakerRuntimeSelectionBody):
    authority = body.authoritative_backend if body.mode == "compare" else body.mode
    status = _status_payload(request)
    backend_state = status["backends"].get(authority, {})
    if not backend_state.get("ready"):
        raise DomainError(
            "SPEAKER_BACKEND_NOT_READY",
            f"{authority} 声纹后端未就绪，不能作为业务 authoritative backend",
            409,
            data={"backend": authority, "errorCode": backend_state.get("errorCode")},
        )

    capture = getattr(request.app.state, "asr_capture_service", None)
    if capture is None or not hasattr(capture, "configure_speaker_backend"):
        raise DomainError("SPEAKER_RUNTIME_UNAVAILABLE", "声纹采集运行时未就绪", 503)
    capture.configure_speaker_backend(
        body.mode,
        body.authoritative_backend if body.mode == "compare" else None,
    )

    settings = request.app.state.runtime_settings
    settings.speaker_backend = body.mode
    settings.speaker_authoritative_backend = (
        body.authoritative_backend if body.mode == "compare" else None
    )
    return envelope(_status_payload(request), "声纹运行模式已更新；仅影响后续新会话")
