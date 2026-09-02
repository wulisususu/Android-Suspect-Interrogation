from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def replace_once(path: str, old: str, new: str) -> None:
    target = ROOT / path
    text = target.read_text(encoding="utf-8")
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"{path}: expected exactly one anchor, found {count}: {old[:120]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


# Runtime selection API: process-local, idle-only and authority-gated.
(ROOT / "linux/backend/app/api/speaker_runtime.py").write_text(
    '''from __future__ import annotations

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
''',
    encoding="utf-8",
)

# Source-aware capture can atomically rebuild idle future-session services.
replace_once(
    "linux/backend/app/services/source_aware_asr_capture_service.py",
    '''        self.fragment_sink = fragment_sink
        self.capture_finished_sink = capture_finished_sink
        self.speaker_model_key = str(speaker_model_key or "xvector").strip().lower()
''',
    '''        self.fragment_sink = fragment_sink
        self.capture_finished_sink = capture_finished_sink
        self.calibration_resolver_factory = calibration_resolver_factory
        self.backend_calibration_resolver_factory = backend_calibration_resolver_factory
        self.speaker_model_key = str(speaker_model_key or "xvector").strip().lower()
''',
)
replace_once(
    "linux/backend/app/services/source_aware_asr_capture_service.py",
    '''        inputs = {
            "ALSA": device_manager,
            "BROWSER": browser_audio_input,
        }
        for source, audio_input in inputs.items():
            if audio_input is None:
                continue
            resolver = calibration_resolver_factory(source) if calibration_resolver_factory is not None else None
            secondary_resolver = None
            if backend_calibration_resolver_factory is not None:
                primary_backend = (
                    self.speaker_authoritative_backend
                    if self.speaker_model_key == "compare"
                    else self.speaker_model_key
                )
                if primary_backend is not None:
                    resolver = backend_calibration_resolver_factory(source, primary_backend)
                if self.speaker_model_key == "compare" and primary_backend is not None:
                    secondary_backend = (
                        "eres2net_large" if primary_backend == "xvector" else "xvector"
                    )
                    secondary_resolver = backend_calibration_resolver_factory(source, secondary_backend)
            self._services[source] = AsrCaptureService(
                session_factory=session_factory,
                device_manager=audio_input,
                ai_supervisor=ai_supervisor,
                publish_event=publish_event,
                sample_rate=sample_rate,
                read_timeout=read_timeout,
                calibration_resolver=resolver,
                secondary_calibration_resolver=secondary_resolver,
                fragment_sink=fragment_sink,
                capture_finished_sink=capture_finished_sink,
                speaker_model_key=self.speaker_model_key,
                speaker_authoritative_backend=self.speaker_authoritative_backend,
            )

        if not self._services:
''',
    '''        self._inputs = {
            "ALSA": device_manager,
            "BROWSER": browser_audio_input,
        }
        for source, audio_input in self._inputs.items():
            if audio_input is None:
                continue
            self._services[source] = self._build_service(
                source,
                audio_input,
                self.speaker_model_key,
                self.speaker_authoritative_backend,
            )

        if not self._services:
''',
)
replace_once(
    "linux/backend/app/services/source_aware_asr_capture_service.py",
    '''    def _source(self, source: str | None = None) -> str:
''',
    '''    def _build_service(
        self,
        source: str,
        audio_input: Any,
        mode: str,
        authoritative_backend: str | None,
    ) -> AsrCaptureService:
        resolver = (
            self.calibration_resolver_factory(source)
            if self.calibration_resolver_factory is not None
            else None
        )
        secondary_resolver = None
        primary_backend = authoritative_backend if mode == "compare" else mode
        if self.backend_calibration_resolver_factory is not None:
            resolver = self.backend_calibration_resolver_factory(source, primary_backend)
            if mode == "compare":
                secondary_backend = "eres2net_large" if primary_backend == "xvector" else "xvector"
                secondary_resolver = self.backend_calibration_resolver_factory(source, secondary_backend)
        return AsrCaptureService(
            session_factory=self.session_factory,
            device_manager=audio_input,
            ai_supervisor=self.ai_supervisor,
            publish_event=self.publish_event,
            sample_rate=self.sample_rate,
            read_timeout=self.read_timeout,
            calibration_resolver=resolver,
            secondary_calibration_resolver=secondary_resolver,
            fragment_sink=self.fragment_sink,
            capture_finished_sink=self.capture_finished_sink,
            speaker_model_key=mode,
            speaker_authoritative_backend=authoritative_backend,
        )

    def configure_speaker_backend(
        self,
        mode: str,
        authoritative_backend: str | None = None,
    ) -> dict[str, str]:
        normalized_mode = str(mode or "xvector").strip().lower()
        normalized_authority = (
            None
            if authoritative_backend is None
            else str(authoritative_backend).strip().lower()
        )
        concrete = {"xvector", "eres2net_large"}
        if normalized_mode not in {*concrete, "compare"}:
            raise DomainError("SPEAKER_BACKEND_SELECTION_INVALID", "声纹运行模式无效", 422)
        if normalized_mode == "compare":
            if normalized_authority not in concrete:
                raise DomainError(
                    "SPEAKER_BACKEND_SELECTION_INVALID",
                    "Compare 模式必须指定业务 authoritative backend",
                    422,
                )
        else:
            if normalized_authority not in {None, normalized_mode}:
                raise DomainError(
                    "SPEAKER_BACKEND_SELECTION_INVALID",
                    "单后端模式的 authoritative backend 必须与所选后端一致",
                    422,
                )
            normalized_authority = None

        with self._lock:
            for active_case in list(self._capture_sources):
                self._prune_capture_if_stopped(active_case)
            if self._capture_sources or self._preparation_source is not None:
                raise DomainError(
                    "SPEAKER_BACKEND_SELECTION_BUSY",
                    "当前存在活动语音会话，不能切换声纹 embedding space",
                    409,
                )
            replacement: dict[str, AsrCaptureService] = {}
            for source, audio_input in self._inputs.items():
                if audio_input is None:
                    continue
                replacement[source] = self._build_service(
                    source,
                    audio_input,
                    normalized_mode,
                    normalized_authority,
                )
            old_services = self._services
            self._services = replacement
            self._default_service = self._services.get("ALSA") or next(iter(self._services.values()))
            self.speaker_model_key = normalized_mode
            self.speaker_authoritative_backend = normalized_authority

        for service in old_services.values():
            try:
                service.shutdown()
            except Exception:
                pass
        return {
            "mode": normalized_mode,
            "authoritativeBackend": (
                normalized_authority if normalized_mode == "compare" else normalized_mode
            ),
        }

    def _source(self, source: str | None = None) -> str:
''',
)

# Calibration endpoints explicitly select the backend/model identity.
(ROOT / "linux/backend/app/api/speaker_calibration.py").write_text(
    '''from __future__ import annotations

from typing import Literal

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
SpeakerBackendKey = Literal["xvector", "eres2net_large"]


class RecomputeBody(BaseModel):
    actor_id: str | None = None


def _model_provider(request: Request, backend: SpeakerBackendKey | None = None):
    injected = getattr(request.app.state, "speaker_calibration_model_provider", None)
    if callable(injected):
        if backend is None:
            return injected

        def injected_provider() -> CurrentSpeakerModelIdentity:
            try:
                identity = injected(backend)
            except TypeError:
                identity = injected()
            actual = str(getattr(identity, "backend_key", "xvector") or "xvector").strip().lower()
            if actual != backend:
                raise DomainError(
                    "SPEAKER_MODEL_BACKEND_MISMATCH",
                    "校准模型提供器返回了错误的声纹后端",
                    503,
                    data={"requestedBackend": backend, "actualBackend": actual},
                )
            return identity

        return injected_provider

    selected = str(backend or "xvector").strip().lower()

    def provide() -> CurrentSpeakerModelIdentity:
        client = getattr(request.app.state, "speech_client", None)
        if client is None:
            raise DomainError("SPEAKER_MODEL_UNAVAILABLE", "声纹运行时未配置", 503)
        health = client.health()
        backends = health.get("speaker_backends") if isinstance(health, dict) else None
        backend_health = backends.get(selected) if isinstance(backends, dict) else None
        if not isinstance(backend_health, dict) and selected == "xvector":
            backend_health = health if isinstance(health, dict) else {}
        backend_health = backend_health or {}
        fingerprint = backend_health.get("model_fingerprint") or backend_health.get("speaker_model_fingerprint")
        if not fingerprint:
            raise DomainError(
                "SPEAKER_MODEL_FINGERPRINT_UNAVAILABLE",
                f"当前 {selected} 模型指纹不可用",
                503,
            )
        return CurrentSpeakerModelIdentity(
            str(backend_health.get("model_id") or backend_health.get("speaker_model_id") or selected),
            None
            if backend_health.get("model_version", backend_health.get("speaker_model_version")) is None
            else str(backend_health.get("model_version", backend_health.get("speaker_model_version"))),
            str(fingerprint),
            backend_key=selected,
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


def _service(
    request: Request,
    db: Session,
    backend: SpeakerBackendKey | None = None,
) -> SpeakerCalibrationService:
    return SpeakerCalibrationService(
        db,
        model_provider=_model_provider(request, backend),
        microphone_provider=_microphone_provider(request),
    )


@router.get("/status")
def calibration_status(
    request: Request,
    backend: SpeakerBackendKey | None = Query(None),
    db: Session = Depends(get_db),
):
    return envelope(_service(request, db, backend).status())


@router.get("/history")
def calibration_history(
    request: Request,
    limit: int = Query(50, ge=1, le=200),
    backend: SpeakerBackendKey | None = Query(None),
    db: Session = Depends(get_db),
):
    return envelope(_service(request, db, backend).history(limit=limit))


@router.post("/recompute")
def recompute_calibration(
    request: Request,
    body: RecomputeBody | None = None,
    backend: SpeakerBackendKey | None = Query(None),
    db: Session = Depends(get_db),
):
    return envelope(
        _service(request, db, backend).recompute(actor_id=body.actor_id if body else None),
        "设备声纹校准已重新计算",
    )
''',
    encoding="utf-8",
)

# Voiceprint readiness/binding: compare uses authority for business gate and exposes both reference spaces.
replace_once(
    "linux/backend/app/services/voiceprint_service.py",
    '''    def __init__(
        self,
        db: Session,
        *,
        speech_client: Any,
        speaker_model_key: str = _XVECTOR,
    ):
        self.db = db
        self.speech_client = speech_client
        self.speaker_model_key = str(speaker_model_key or _XVECTOR).strip().lower()
        if self.speaker_model_key not in _ENROLLMENT_BACKENDS:
            raise ValueError("speaker_model_key must be xvector or eres2net_large")
''',
    '''    def __init__(
        self,
        db: Session,
        *,
        speech_client: Any,
        speaker_model_key: str = _XVECTOR,
        speaker_authoritative_backend: str | None = None,
    ):
        self.db = db
        self.speech_client = speech_client
        self.speaker_model_key = str(speaker_model_key or _XVECTOR).strip().lower()
        configured_authority = (
            None
            if speaker_authoritative_backend is None
            else str(speaker_authoritative_backend).strip().lower()
        )
        if self.speaker_model_key not in {*_ENROLLMENT_BACKENDS, "compare"}:
            raise ValueError("speaker_model_key must be xvector, eres2net_large or compare")
        if self.speaker_model_key == "compare":
            if configured_authority not in _ENROLLMENT_BACKENDS:
                raise ValueError("speaker_authoritative_backend is required for compare mode")
            self.authoritative_speaker_backend = configured_authority
        else:
            if configured_authority not in {None, self.speaker_model_key}:
                raise ValueError("speaker_authoritative_backend must match the single backend")
            self.authoritative_speaker_backend = self.speaker_model_key
''',
)
replace_once(
    "linux/backend/app/services/voiceprint_service.py",
    '''    def readiness(self, case_id: str) -> dict:
        case_repo.get(self.db, case_id)
        suspect = voiceprint_repo.get_suspect(
            self.db, case_id, model_key=self.speaker_model_key
        )
        interrogator_ready = False
        recorder_ready = False

        session = session_repo.active_for_case(self.db, case_id)
        if session is not None:
            assignment = self.db.scalar(
                select(SessionVoiceAssignment).where(SessionVoiceAssignment.session_id == session.id)
            )
            if assignment is not None:
                interrogator_ready = self._officer_active(
                    assignment.interrogator_officer_id, self.speaker_model_key
                )
                recorder_ready = self._officer_active(
                    assignment.recorder_officer_id, self.speaker_model_key
                )

        result = {
            "suspectReady": suspect is not None,
            "interrogatorReady": interrogator_ready,
            "recorderReady": recorder_ready,
            "recognitionMode": self._recognition_mode(interrogator_ready, recorder_ready),
            "canStart": suspect is not None,
        }
        if self.speaker_model_key != _XVECTOR:
            result["selectedSpeakerBackend"] = self.speaker_model_key
        return result
''',
    '''    def readiness(self, case_id: str) -> dict:
        case_repo.get(self.db, case_id)
        session = session_repo.active_for_case(self.db, case_id)
        assignment = None
        if session is not None:
            assignment = self.db.scalar(
                select(SessionVoiceAssignment).where(SessionVoiceAssignment.session_id == session.id)
            )

        backend_states: dict[str, dict[str, Any]] = {}
        for backend in _ENROLLMENT_BACKENDS:
            suspect = voiceprint_repo.get_suspect(self.db, case_id, model_key=backend)
            interrogator_ready = False
            recorder_ready = False
            if assignment is not None:
                interrogator_ready = self._officer_active(
                    assignment.interrogator_officer_id, backend
                )
                recorder_ready = self._officer_active(
                    assignment.recorder_officer_id, backend
                )
            backend_states[backend] = {
                "suspectReady": suspect is not None,
                "interrogatorReady": interrogator_ready,
                "recorderReady": recorder_ready,
                "recognitionMode": self._recognition_mode(interrogator_ready, recorder_ready),
                "canStart": suspect is not None,
            }

        authoritative = backend_states[self.authoritative_speaker_backend]
        result = dict(authoritative)
        if self.speaker_model_key == "compare":
            result.update(
                {
                    "selectedSpeakerBackend": "compare",
                    "authoritativeSpeakerBackend": self.authoritative_speaker_backend,
                    "backends": backend_states,
                }
            )
        elif self.speaker_model_key != _XVECTOR:
            result["selectedSpeakerBackend"] = self.speaker_model_key
        return result
''',
)
replace_once(
    "linux/backend/app/services/voiceprint_service.py",
    '''        suspect = voiceprint_repo.get_suspect(
            self.db, case_id, model_key=self.speaker_model_key
        )
        if suspect is None:
            raise DomainError(
                "SUSPECT_VOICEPRINT_BACKEND_REQUIRED",
                f"请先完成 {self.speaker_model_key} 嫌疑人声纹注册",
                409,
                data={"speaker_backend": self.speaker_model_key},
            )
''',
    '''        binding_backend = self.authoritative_speaker_backend
        suspect = voiceprint_repo.get_suspect(
            self.db, case_id, model_key=binding_backend
        )
        if suspect is None:
            raise DomainError(
                "SUSPECT_VOICEPRINT_BACKEND_REQUIRED",
                f"请先完成 {binding_backend} 嫌疑人声纹注册",
                409,
                data={"speaker_backend": binding_backend},
            )
''',
)
replace_once(
    "linux/backend/app/services/voiceprint_service.py",
    '''            model_key=self.speaker_model_key,
        )
''',
    '''            model_key=binding_backend,
        )
''',
)
replace_once(
    "linux/backend/app/services/voiceprint_service.py",
    '''            "selectedSpeakerBackend": self.speaker_model_key,
            "suspectReady": True,
''',
    '''            "selectedSpeakerBackend": self.speaker_model_key,
            "authoritativeSpeakerBackend": binding_backend,
            "suspectReady": True,
''',
)

# API factory passes compare authority into VoiceprintService.
replace_once(
    "linux/backend/app/api/voiceprints.py",
    '''    speaker_model_key = getattr(settings, "speaker_backend", "xvector")
    return VoiceprintService(
        db,
        speech_client=_speech_client(request),
        speaker_model_key=speaker_model_key,
    )
''',
    '''    speaker_model_key = getattr(settings, "speaker_backend", "xvector")
    speaker_authoritative_backend = getattr(settings, "speaker_authoritative_backend", None)
    return VoiceprintService(
        db,
        speech_client=_speech_client(request),
        speaker_model_key=speaker_model_key,
        speaker_authoritative_backend=speaker_authoritative_backend,
    )
''',
)

# Register runtime router.
replace_once(
    "linux/backend/app/main.py",
    '''from app.api.speaker_calibration import router as speaker_calibration_router
''',
    '''from app.api.speaker_calibration import router as speaker_calibration_router
from app.api.speaker_runtime import router as speaker_runtime_router
''',
)
replace_once(
    "linux/backend/app/main.py",
    '''    app.include_router(speaker_calibration_router, prefix="/api/v1")
    app.include_router(client_context_router, prefix="/api/v1")
''',
    '''    app.include_router(speaker_calibration_router, prefix="/api/v1")
    app.include_router(speaker_runtime_router, prefix="/api/v1")
    app.include_router(client_context_router, prefix="/api/v1")
''',
)

print("Task 10 backend GREEN apply completed")
