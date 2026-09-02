from __future__ import annotations

import threading
from typing import Any, Callable

from app.domain.errors import DomainError
from app.request_audio_context import current_request_audio_source, normalize_audio_source
from app.services.asr_capture_service import AsrCaptureService


CalibrationResolverFactory = Callable[[str], Callable[[Any], Any] | None]
BackendCalibrationResolverFactory = Callable[[str, str], Callable[[Any], Any] | None]


class SourceAwareAsrCaptureService:
    """Route each ASR capture to ALSA or the LAN browser input.

    ``AsrCaptureService`` intentionally owns one concrete input for the complete
    lifetime of a capture thread. This coordinator keeps that invariant while
    selecting the concrete service per HTTP start request. Formal interrogation
    and question-preparation dictation therefore share one source policy without
    mutating a process-global device pointer while a worker thread is running.
    """

    def __init__(
        self,
        *,
        session_factory,
        device_manager: Any | None,
        browser_audio_input: Any | None,
        ai_supervisor: Any,
        publish_event,
        sample_rate: int = 16_000,
        read_timeout: float = 0.2,
        calibration_resolver_factory: CalibrationResolverFactory | None = None,
        backend_calibration_resolver_factory: BackendCalibrationResolverFactory | None = None,
        fragment_sink: Callable[[str, str], None] | None = None,
        capture_finished_sink: Callable[[str, str], None] | None = None,
        speaker_model_key: str = "xvector",
        speaker_authoritative_backend: str | None = None,
    ) -> None:
        self.session_factory = session_factory
        self.device_manager = device_manager
        self.browser_audio_input = browser_audio_input
        self.ai_supervisor = ai_supervisor
        self.publish_event = publish_event
        self.sample_rate = int(sample_rate)
        self.read_timeout = float(read_timeout)
        self.fragment_sink = fragment_sink
        self.capture_finished_sink = capture_finished_sink
        self.speaker_model_key = str(speaker_model_key or "xvector").strip().lower()
        self.speaker_authoritative_backend = (
            None
            if speaker_authoritative_backend is None
            else str(speaker_authoritative_backend).strip().lower()
        )
        self._lock = threading.RLock()
        self._capture_sources: dict[str, str] = {}
        self._preparation_source: tuple[str, str] | None = None
        self._services: dict[str, AsrCaptureService] = {}

        inputs = {
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
            raise ValueError("at least one ASR audio input must be configured")
        self._default_service = self._services.get("ALSA") or next(iter(self._services.values()))

    def _source(self, source: str | None = None) -> str:
        selected = normalize_audio_source(source) or current_request_audio_source("ALSA")
        if selected not in self._services:
            if selected == "BROWSER":
                raise DomainError(
                    "BROWSER_AUDIO_UNAVAILABLE",
                    "浏览器音频输入未配置，不能启动局域网浏览器录音",
                    503,
                )
            raise DomainError("AUDIO_DEVICE_NOT_CONFIGURED", "Linux ALSA 录音设备未配置", 503)
        return selected

    def _prune_capture_if_stopped(self, case_id: str) -> None:
        with self._lock:
            source = self._capture_sources.get(case_id)
        if source is None:
            return
        try:
            active = bool(self._services[source].status(case_id).get("active"))
        except Exception:
            return
        if not active:
            with self._lock:
                if self._capture_sources.get(case_id) == source:
                    self._capture_sources.pop(case_id, None)

    def start(self, case_id: str, source: str | None = None) -> dict[str, Any]:
        selected = self._source(source)
        with self._lock:
            for active_case in list(self._capture_sources):
                self._prune_capture_if_stopped(active_case)
            if self._capture_sources:
                raise DomainError("ASR_AUDIO_RESOURCE_BUSY", "正式审讯录音正在占用麦克风", 409)
            if self._preparation_source is not None:
                raise DomainError("ASR_AUDIO_RESOURCE_BUSY", "准备阶段语音输入正在占用麦克风", 409)
            result = self._services[selected].start(case_id)
            self._capture_sources[str(case_id)] = selected
        payload = dict(result)
        payload["source"] = selected
        return payload

    def stop(self, case_id: str) -> dict[str, Any]:
        case_id = str(case_id).strip()
        with self._lock:
            source = self._capture_sources.get(case_id)
        if source is None:
            return self.status(case_id)
        try:
            result = self._services[source].stop(case_id)
        finally:
            with self._lock:
                if self._capture_sources.get(case_id) == source:
                    self._capture_sources.pop(case_id, None)
        payload = dict(result)
        payload["source"] = source
        return payload

    def status(self, case_id: str) -> dict[str, Any]:
        case_id = str(case_id).strip()
        with self._lock:
            source = self._capture_sources.get(case_id)
        if source is None:
            return self._default_service.status(case_id)
        result = dict(self._services[source].status(case_id))
        result["source"] = source
        if not result.get("active"):
            with self._lock:
                if self._capture_sources.get(case_id) == source:
                    self._capture_sources.pop(case_id, None)
        return result

    def start_preparation(self, case_id: str, source: str | None = None) -> dict[str, Any]:
        selected = self._source(source)
        with self._lock:
            for active_case in list(self._capture_sources):
                self._prune_capture_if_stopped(active_case)
            if self._capture_sources:
                raise DomainError("ASR_AUDIO_RESOURCE_BUSY", "正式审讯录音正在占用麦克风", 409)
            if self._preparation_source is not None:
                raise DomainError("ASR_PREPARATION_ALREADY_ACTIVE", "已有准备阶段语音输入正在进行", 409)
            result = self._services[selected].start_preparation(case_id)
            self._preparation_source = (str(case_id), selected)
        payload = dict(result)
        payload["source"] = selected
        return payload

    def stop_preparation(self, case_id: str) -> dict[str, Any]:
        case_id = str(case_id).strip()
        with self._lock:
            current = self._preparation_source
        if current is None or current[0] != case_id:
            result = self._default_service.stop_preparation(case_id)
            return dict(result)
        source = current[1]
        try:
            result = self._services[source].stop_preparation(case_id)
        finally:
            with self._lock:
                if self._preparation_source == current:
                    self._preparation_source = None
        payload = dict(result)
        payload["source"] = source
        return payload

    def shutdown(self) -> None:
        for service in self._services.values():
            try:
                service.shutdown()
            except Exception:
                pass
        with self._lock:
            self._capture_sources.clear()
            self._preparation_source = None
