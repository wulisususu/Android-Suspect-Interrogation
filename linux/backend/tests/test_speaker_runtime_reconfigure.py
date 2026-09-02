from __future__ import annotations

import pytest

from app.domain.errors import DomainError
from app.services.source_aware_asr_capture_service import SourceAwareAsrCaptureService


class _AudioInput:
    pass


def _service() -> SourceAwareAsrCaptureService:
    return SourceAwareAsrCaptureService(
        session_factory=lambda: None,
        device_manager=_AudioInput(),
        browser_audio_input=None,
        ai_supervisor=object(),
        publish_event=lambda *_args: None,
        speaker_model_key="xvector",
    )


def test_speaker_backend_reconfiguration_rebuilds_only_idle_future_sessions():
    service = _service()
    try:
        result = service.configure_speaker_backend("compare", "xvector")
        assert result == {"mode": "compare", "authoritativeBackend": "xvector"}
        assert service.speaker_model_key == "compare"
        assert service.speaker_authoritative_backend == "xvector"
        assert service._services["ALSA"].speaker_model_key == "compare"
        assert service._services["ALSA"].authoritative_speaker_backend == "xvector"
    finally:
        service.shutdown()


def test_speaker_backend_reconfiguration_is_rejected_while_capture_is_active():
    service = _service()
    service._capture_sources["CASE-ACTIVE"] = "ALSA"
    try:
        with pytest.raises(DomainError) as exc:
            service.configure_speaker_backend("eres2net_large", None)
        assert exc.value.code == "SPEAKER_BACKEND_SELECTION_BUSY"
        assert service.speaker_model_key == "xvector"
        assert service._services["ALSA"].speaker_model_key == "xvector"
    finally:
        service._capture_sources.clear()
        service.shutdown()
