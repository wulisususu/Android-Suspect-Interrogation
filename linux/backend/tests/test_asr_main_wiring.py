from __future__ import annotations

from fastapi.testclient import TestClient

from app.main import create_app
from app.runtime_settings import RuntimeSettings
from app.services.source_aware_asr_capture_service import SourceAwareAsrCaptureService


class FakeManager:
    device_monitor = None

    def __init__(self):
        self.opened = 0
        self.monitor_started = 0
        self.monitor_stopped = 0
        self.closed = 0

    def open_all(self, strict: bool = False):
        assert strict is False
        self.opened += 1

    def start_monitor(self):
        self.monitor_started += 1

    def stop_monitor(self):
        self.monitor_stopped += 1

    def close_all(self):
        self.closed += 1

    def start_record(self):
        raise AssertionError("wiring test must not start ALSA")

    def read_audio_frames(self, timeout: float = 0.5):
        raise AssertionError("wiring test must not read ALSA")

    def stop_record(self):
        raise AssertionError("wiring test must not stop inactive ALSA")


class FakeSupervisor:
    speaker_accept_threshold = 0.70
    speaker_margin = 0.10

    def __init__(self):
        self.shutdown_calls = 0

    def health(self):
        return {"speech": {"state": "READY", "backend": "test"}}

    def capabilities(self):
        return {
            "asr": {"state": "AVAILABLE", "speech_worker": True},
            "vad": {"state": "AVAILABLE"},
            "speaker": {"state": "AVAILABLE"},
        }

    def shutdown(self):
        self.shutdown_calls += 1


class FakeHardwareGateway:
    def status(self):
        return {"audio": {"state": "AVAILABLE"}}


def test_create_app_wires_source_aware_asr_and_browser_input_lifecycle(tmp_path):
    manager = FakeManager()
    supervisor = FakeSupervisor()
    app = create_app(
        database_url=f"sqlite:///{tmp_path / 'main-wiring.db'}",
        hardware_gateway=FakeHardwareGateway(),
        hardware_manager=manager,
        ai_supervisor=supervisor,
    )

    paths = set(app.openapi()["paths"])
    assert "/api/v1/asr/status" in paths
    assert "/api/v1/cases/{case_id}/asr/capture/start" in paths

    # Browser input must exist even when the process-level runtime default is
    # ALSA; the concrete source is selected only when a capture starts.
    assert app.state.browser_audio_input is not None

    with TestClient(app) as client:
        service = app.state.asr_capture_service
        assert isinstance(service, SourceAwareAsrCaptureService)
        assert service.device_manager is manager
        assert service.browser_audio_input is app.state.browser_audio_input
        assert service.ai_supervisor is supervisor
        assert service.session_factory is app.state.session_factory
        assert app.state.qa_routing_coordinator is None

        response = client.get("/api/v1/asr/status")
        assert response.status_code == 200
        assert response.json()["state"] == "AVAILABLE"

    assert manager.opened == 1
    assert manager.monitor_started == 1
    assert manager.monitor_stopped == 1
    assert manager.closed == 1
    assert supervisor.shutdown_calls == 1


def test_qwen_mode_starts_coordinator_and_injects_sinks_into_all_audio_sources(tmp_path):
    manager = FakeManager()
    supervisor = FakeSupervisor()
    settings = RuntimeSettings(formal_routing_mode="qwen", qa_idle_close_seconds=0.05)
    app = create_app(
        database_url=f"sqlite:///{tmp_path / 'main-qwen-wiring.db'}",
        hardware_gateway=FakeHardwareGateway(),
        hardware_manager=manager,
        ai_supervisor=supervisor,
        runtime_settings=settings,
    )

    with TestClient(app):
        coordinator = app.state.qa_routing_coordinator
        assert coordinator is not None
        assert coordinator.running is True
        service = app.state.asr_capture_service
        assert isinstance(service, SourceAwareAsrCaptureService)
        assert set(service._services) == {"ALSA", "BROWSER"}
        for child in service._services.values():
            assert child.fragment_sink is not None
            assert child.capture_finished_sink is not None

    assert coordinator.running is False
