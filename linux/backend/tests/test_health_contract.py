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
    assert set(payload["capabilities"]) >= {"hardware", "ai"}
    assert payload["checks"]["storage"]["required"] is True
    assert payload["checks"]["database"]["required"] is True
    assert payload["capabilities"]["hardware"]["required"] is False
    assert payload["capabilities"]["ai"]["required"] is False
