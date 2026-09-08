import os

from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_missing_model_is_not_installed_capability_not_api_failure(monkeypatch, tmp_path):
    missing_model = tmp_path / "models" / "missing.rkllm"
    monkeypatch.setenv("SUSPECT_MODEL_PATH", os.fspath(missing_model))

    response = client.get("/health/ready")
    assert response.status_code == 200

    payload = response.json()
    assert payload["status"] in {"ready", "degraded"}
    assert payload["capabilities"]["ai"]["state"] == "NOT_INSTALLED"
    assert payload["capabilities"]["ai"]["required"] is False


def test_enabled_moss_with_unreachable_worker_stays_optional_and_independent(monkeypatch, tmp_path):
    monkeypatch.setenv("MODEL_ROOT", os.fspath(tmp_path / "models"))
    monkeypatch.setenv("MOSS_ENABLED", "0")

    disabled = client.get("/health/ready").json()
    assert disabled["capabilities"]["moss"]["state"] == "DISABLED"

    monkeypatch.setenv("MOSS_ENABLED", "1")
    monkeypatch.setenv("SUSPECT_MOSS_SOCKET", os.fspath(tmp_path / "absent" / "moss.sock"))
    enabled = client.get("/health/ready").json()

    moss = enabled["capabilities"]["moss"]
    assert moss["required"] is False
    assert moss["state"] == "UNAVAILABLE"
    assert moss["lastError"]
    # An optional capability must not flip readiness nor disturb realtime ASR.
    assert enabled["status"] == disabled["status"]
    assert enabled["capabilities"]["asr"] == disabled["capabilities"]["asr"]
