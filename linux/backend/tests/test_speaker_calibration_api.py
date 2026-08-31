from __future__ import annotations

import struct
from uuid import uuid4

from fastapi.testclient import TestClient

from app.database.models import AuditLog
from app.database.voiceprint_models import OfficerVoiceProfile, OfficerVoiceSample
from app.main import create_app
from app.services.speaker_calibration_service import CurrentMicrophoneIdentity, CurrentSpeakerModelIdentity


MODEL_FP = "a" * 64
MIC_FP = "b" * 64


class FakeGateway:
    def status(self): return {"state": "test"}


class FakeSupervisor:
    def shutdown(self): pass


def _embedding(axis: int, offset: float) -> bytes:
    values = [0.01, 0.01, 0.01]
    values[axis] = 1.0
    values[(axis + 1) % 3] += offset
    return struct.pack("<3f", *values)


def _seed(app):
    with app.state.session_factory() as db:
        for index, officer in enumerate(("P1", "P2", "P3")):
            profile = OfficerVoiceProfile(
                id=str(uuid4()), officer_id=officer, officer_name=officer,
                aggregate_embedding=_embedding(index, 0), embedding_dim=3,
                model_id="xvector", model_version="v1", aggregate_version=1,
                sample_count=3, active=True, revoked_at=None,
            )
            db.add(profile); db.flush()
            for sample_index in range(3):
                db.add(OfficerVoiceSample(
                    id=str(uuid4()), profile_id=profile.id, embedding=_embedding(index, (sample_index - 1) * 0.03),
                    embedding_dim=3, model_id="xvector", model_version="v1", model_fingerprint=MODEL_FP,
                    quality="GOOD", usable_duration_ms=22_000, segment_count=3, audio_source="ALSA",
                    device_id="hw:1,0", device_name="USB Mic", microphone_fingerprint=MIC_FP,
                    microphone_fingerprint_certainty="STRONG", active=True,
                ))
        db.commit()


def test_calibration_api_recomputes_from_global_library_and_returns_history(tmp_path):
    app = create_app(
        database_url=f"sqlite:///{tmp_path/'api.db'}",
        hardware_gateway=FakeGateway(),
        hardware_manager=None,
        ai_supervisor=FakeSupervisor(),
    )
    app.state.speaker_calibration_model_provider = lambda: CurrentSpeakerModelIdentity("xvector", "v1", MODEL_FP)
    app.state.speaker_calibration_microphone_provider = lambda: CurrentMicrophoneIdentity(
        "ALSA", "hw:1,0", "USB Mic", MIC_FP, "STRONG"
    )
    _seed(app)

    with TestClient(app) as client:
        initial = client.get('/api/v1/speaker-calibration/status')
        assert initial.status_code == 200
        assert initial.json()['data']['status'] == 'NOT_CALIBRATED'

        computed = client.post('/api/v1/speaker-calibration/recompute', json={'actor_id': 'admin'})
        assert computed.status_code == 200
        payload = computed.json()['data']
        assert payload['status'] == 'VALID'
        assert payload['calibration']['metricScope'] == 'LOCAL_FINITE_CORPUS_ESTIMATE'
        assert payload['calibration']['speakerModelFingerprint'] == MODEL_FP
        assert payload['calibration']['microphoneFingerprint'] == MIC_FP

        history = client.get('/api/v1/speaker-calibration/history').json()['data']
        assert len(history) == 1
        assert history[0]['calibrationId'] == payload['calibration']['calibrationId']

    with app.state.session_factory() as db:
        audit = db.query(AuditLog).filter(AuditLog.action == 'SPEAKER_DEVICE_CALIBRATION_RECOMPUTE').one()
        assert audit.case_id is None
