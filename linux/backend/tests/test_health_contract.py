from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_liveness_is_process_only():
    response = client.get("/health/live")
    assert response.status_code == 200
    assert response.json() == {"status": "alive"}


def test_readiness_reports_required_checks_and_capabilities():
    response = client.get("/health/ready")
    assert response.status_code == 200

    payload = response.json()
    assert payload["status"] in {"ready", "degraded"}
    assert set(payload["checks"]) >= {"storage", "database"}
    assert set(payload["capabilities"]) >= {
        "hardware",
        "ai",
        "asr",
        "vad",
        "speaker",
        "voiceprintCalibration",
        "audioCapture",
    }
    assert payload["checks"]["storage"]["required"] is True
    assert payload["checks"]["database"]["required"] is True
    assert payload["capabilities"]["hardware"]["required"] is False
    assert payload["capabilities"]["ai"]["required"] is False
    for name in ("asr", "vad", "speaker", "voiceprintCalibration", "audioCapture"):
        assert payload["capabilities"][name]["required"] is False


def test_voiceprint_calibration_health_is_fail_closed_until_both_values_exist(monkeypatch):
    monkeypatch.delenv("SUSPECT_SPEAKER_ACCEPT_THRESHOLD", raising=False)
    monkeypatch.delenv("SUSPECT_SPEAKER_MARGIN", raising=False)
    missing = client.get("/health/ready").json()["capabilities"]["voiceprintCalibration"]
    assert missing["state"] == "NOT_CONFIGURED"

    monkeypatch.setenv("SUSPECT_SPEAKER_ACCEPT_THRESHOLD", "0.73")
    monkeypatch.setenv("SUSPECT_SPEAKER_MARGIN", "0.08")
    calibrated = client.get("/health/ready").json()["capabilities"]["voiceprintCalibration"]
    assert calibrated["state"] == "READY"


def test_runtime_capabilities_endpoint_exposes_frontend_contract():
    response = client.get("/api/v1/capabilities")
    assert response.status_code == 200
    payload = response.json()
    assert set(payload) == {
        "identity", "camera", "microphone", "fingerprint", "signature",
        "recording", "asr", "ocr", "llm", "report",
    }
    assert payload["microphone"]["state"] in {"AVAILABLE", "NOT_CONFIGURED", "ERROR"}
    assert payload["asr"]["state"] in {"AVAILABLE", "NOT_CONFIGURED", "ERROR", "MODEL_NOT_INSTALLED"}


def test_speech_capability_prefers_ready_worker_over_stopped_registry_worker():
    from app.health import _speech_capability

    class Supervisor:
        def capabilities(self):
            return {
                "asr": {
                    "state": "STOPPED",
                    "detail": "registry worker is idle",
                    "speech_worker": True,
                    "speech_state": "AVAILABLE",
                }
            }

    result = _speech_capability("asr", supervisor=Supervisor(), calibration={"state": "NOT_CONFIGURED"})
    assert result["state"] == "AVAILABLE"
    assert result["speech_state"] == "AVAILABLE"
