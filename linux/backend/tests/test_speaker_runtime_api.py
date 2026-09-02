from __future__ import annotations

import struct

from fastapi.testclient import TestClient

from app.main import create_app
from app.repositories import cases as case_repo
from app.repositories import voiceprints as voiceprint_repo
from app.runtime_settings import RuntimeSettings
from app.services.speaker_calibration_service import CurrentMicrophoneIdentity, CurrentSpeakerModelIdentity
from app.services.voiceprint_service import VoiceprintService


XV_FP = "a" * 64
ER_FP = "b" * 64
MIC_FP = "c" * 64


class FakeGateway:
    def status(self):
        return {"state": "test"}


class FakeSupervisor:
    def shutdown(self):
        pass


class FakeSpeechClient:
    def health(self):
        return {
            "speaker_backends": {
                "xvector": {
                    "ready": True,
                    "model_id": "xvector-model",
                    "model_version": "xv-v1",
                    "model_fingerprint": XV_FP,
                    "error": None,
                },
                "eres2net_large": {
                    "ready": False,
                    "model_id": "eres-model",
                    "model_version": "eres-v1",
                    "model_fingerprint": ER_FP,
                    "error": {"code": "BACKEND_UNAVAILABLE", "error_type": "TestUnavailable"},
                },
            }
        }


class ReadySpeechClient(FakeSpeechClient):
    def health(self):
        payload = super().health()
        payload["speaker_backends"]["eres2net_large"]["ready"] = True
        payload["speaker_backends"]["eres2net_large"]["error"] = None
        return payload


def _embedding(x: float, y: float) -> bytes:
    return struct.pack("<2f", x, y)


def _app(tmp_path, *, speech_client=None):
    settings = RuntimeSettings(speaker_backend="xvector")
    app = create_app(
        database_url=f"sqlite:///{tmp_path / 'task10.db'}",
        hardware_gateway=FakeGateway(),
        hardware_manager=None,
        ai_supervisor=FakeSupervisor(),
        runtime_settings=settings,
    )
    app.state.speech_client = speech_client or FakeSpeechClient()
    app.state.speaker_calibration_model_provider = lambda backend=None: CurrentSpeakerModelIdentity(
        "eres-model" if backend == "eres2net_large" else "xvector-model",
        "eres-v1" if backend == "eres2net_large" else "xv-v1",
        ER_FP if backend == "eres2net_large" else XV_FP,
        backend_key=backend or "xvector",
    )
    app.state.speaker_calibration_microphone_provider = lambda: CurrentMicrophoneIdentity(
        "ALSA", "hw:1,0", "USB Mic", MIC_FP, "STRONG"
    )
    return app


def test_runtime_status_exposes_both_backends_and_unavailable_eres_state(tmp_path):
    app = _app(tmp_path)
    with TestClient(app) as client:
        response = client.get("/api/v1/speaker-runtime")
        assert response.status_code == 200
        payload = response.json()["data"]
        assert payload["selection"] == {
            "mode": "xvector",
            "authoritativeBackend": "xvector",
        }
        assert payload["backends"]["xvector"]["ready"] is True
        assert payload["backends"]["xvector"]["modelFingerprint"] == XV_FP
        assert payload["backends"]["eres2net_large"]["ready"] is False
        assert payload["backends"]["eres2net_large"]["errorCode"] == "BACKEND_UNAVAILABLE"


def test_compare_requires_authority_and_unavailable_backend_cannot_be_authoritative(tmp_path):
    app = _app(tmp_path)
    with TestClient(app) as client:
        missing = client.put("/api/v1/speaker-runtime/selection", json={"mode": "compare"})
        assert missing.status_code == 422

        unavailable_single = client.put(
            "/api/v1/speaker-runtime/selection",
            json={"mode": "eres2net_large"},
        )
        assert unavailable_single.status_code == 409
        assert unavailable_single.json()["code"] == "SPEAKER_BACKEND_NOT_READY"

        unavailable_authority = client.put(
            "/api/v1/speaker-runtime/selection",
            json={"mode": "compare", "authoritative_backend": "eres2net_large"},
        )
        assert unavailable_authority.status_code == 409
        assert unavailable_authority.json()["code"] == "SPEAKER_BACKEND_NOT_READY"

        compare = client.put(
            "/api/v1/speaker-runtime/selection",
            json={"mode": "compare", "authoritative_backend": "xvector"},
        )
        assert compare.status_code == 200
        payload = compare.json()["data"]
        assert payload["selection"]["mode"] == "compare"
        assert payload["selection"]["authoritativeBackend"] == "xvector"
        assert payload["degraded"] is True
        assert app.state.runtime_settings.speaker_backend == "compare"
        assert app.state.runtime_settings.speaker_authoritative_backend == "xvector"


def test_calibration_status_can_be_queried_independently_by_backend(tmp_path):
    app = _app(tmp_path, speech_client=ReadySpeechClient())
    with TestClient(app) as client:
        xvector = client.get("/api/v1/speaker-calibration/status?backend=xvector")
        eres = client.get("/api/v1/speaker-calibration/status?backend=eres2net_large")
        assert xvector.status_code == 200
        assert eres.status_code == 200
        assert xvector.json()["data"]["currentModel"]["backendKey"] == "xvector"
        assert xvector.json()["data"]["currentModel"]["fingerprint"] == XV_FP
        assert eres.json()["data"]["currentModel"]["backendKey"] == "eres2net_large"
        assert eres.json()["data"]["currentModel"]["fingerprint"] == ER_FP


def test_compare_readiness_keeps_top_level_business_gate_on_authority_and_reports_both_refs(tmp_path):
    app = _app(tmp_path, speech_client=ReadySpeechClient())
    with app.state.session_factory() as db:
        case = case_repo.create(db, {"id": "CASE-T10", "suspectName": "测试", "officerName": "民警"})
        voiceprint_repo.enroll_suspect(
            db,
            case_id=case.id,
            model_key="xvector",
            embedding=_embedding(1.0, 0.0),
            embedding_dim=2,
            model_id="xvector-model",
            model_version="xv-v1",
            enrollment_quality="TEST",
            usable_duration_ms=20_000,
        )
        db.commit()

        service = VoiceprintService(
            db,
            speech_client=ReadySpeechClient(),
            speaker_model_key="compare",
            speaker_authoritative_backend="xvector",
        )
        readiness = service.readiness(case.id)
        assert readiness["selectedSpeakerBackend"] == "compare"
        assert readiness["authoritativeSpeakerBackend"] == "xvector"
        assert readiness["suspectReady"] is True
        assert readiness["canStart"] is True
        assert readiness["backends"]["xvector"]["suspectReady"] is True
        assert readiness["backends"]["eres2net_large"]["suspectReady"] is False
