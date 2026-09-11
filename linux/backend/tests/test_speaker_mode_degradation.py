"""Task 17B-1 acceptance: the effective speaker mode is one provable rule.

Two sides must agree for every device configuration:

* ``VoiceprintService.readiness()["effectiveRecognitionMode"]`` -- what the operator
  is told will happen.
* ``AsrCaptureService`` -- the roles the runtime actually lets through when it
  attributes a fragment.

The regression this guards: a deployment without a calibrated margin silently ran
suspect-only while the UI still advertised "suspect + interrogating officer".
"""

import struct
from pathlib import Path

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from app.database.models import Case
from app.database.session import init_database, make_engine
from app.hardware_gateway.mock import MockHardwareGateway
from app.main import create_app
from app.repositories import sessions as session_repo
from app.services.asr_capture_service import AsrCaptureService
from app.services.speaker_mode import (
    DEGRADED_REASON_MARGIN_CALIBRATION_MISSING,
    DEGRADED_REASON_THRESHOLD_NOT_CONFIGURED,
    SUSPECT_ONLY,
    SUSPECT_PLUS_INTERROGATOR,
    SpeakerModeConfig,
)
from app.services.speaker_policy import SpeakerRole
from app.services.voiceprint_service import VoiceprintService


SAMPLE_RATE = 16000
GOOD_SEGMENTS = [[0, 8000], [9000, 17000], [18000, 26000]]
GOOD_EMBEDDINGS = [
    [1.0, 0.0, 0.0],
    [0.99, 0.1, 0.0],
    [0.98, -0.1, 0.0],
]


def pcm16(duration_ms: int = 30000, sample: int = 1200) -> bytes:
    samples = duration_ms * SAMPLE_RATE // 1000
    return struct.pack(f"<{samples}h", *([sample] * samples))


class FakeSpeechClient:
    def __init__(self):
        self.embedding_calls = 0

    def speech_segments(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        return [list(item) for item in GOOD_SEGMENTS]

    def extract_embedding(self, pcm: bytes, sample_rate: int = SAMPLE_RATE):
        vector = GOOD_EMBEDDINGS[self.embedding_calls % len(GOOD_EMBEDDINGS)]
        self.embedding_calls += 1
        return {
            "embedding": vector,
            "backend_key": "eres2net_large",
            "model_id": "eres2net_large",
            "model_version": "17b1-test",
        }


class FakeCaptureService:
    """Mirrors the parts of AsrCaptureService the readiness route consults."""

    def __init__(self):
        self.active: tuple[str, str] | None = None

    def start(self, kind: str, subject_id: str, source: str = "ALSA"):
        self.active = (kind, subject_id)
        return {
            "active": True,
            "kind": kind,
            "subjectId": subject_id,
            "captureId": "CAP-FAKE-1",
            "source": source,
            "sampleRate": SAMPLE_RATE,
            "capturedBytes": 0,
            "maxBytes": SAMPLE_RATE * 2 * 30,
            "complete": False,
        }

    def stop(self, kind: str, subject_id: str):
        self.active = None
        return pcm16()

    def status(self, case_id: str | None = None):
        return {"active": False, "caseId": case_id}


class FakeSupervisor:
    def __init__(self, *, margin: float | None, threshold: float | None = 0.372):
        self.speaker_margin = margin
        self.speaker_accept_threshold = threshold
        self.speaker_threshold_source = (
            "DEVICE_CALIBRATED" if threshold is not None else "MODEL_BASELINE"
        )

    def shutdown(self) -> None:
        pass


def _calibrated(margin: float | None, threshold: float | None = 0.372) -> SpeakerModeConfig:
    return SpeakerModeConfig(
        margin=margin,
        threshold=threshold,
        threshold_source="DEVICE_CALIBRATED" if threshold is not None else "MODEL_BASELINE",
    )


def _bound_case(tmp_path: Path, name: str):
    """Case with an enrolled suspect + interrogator officer bound to an active session."""
    engine = make_engine(f"sqlite:///{tmp_path / name}")
    init_database(engine)
    db = Session(engine)
    db.add(Case(id="CASE-1", officer_name="测试警官"))
    db.commit()
    service = VoiceprintService(db, speech_client=FakeSpeechClient())
    service.enroll_suspect("CASE-1", pcm16(), actor_id="op")
    service.speech_client = FakeSpeechClient()
    service.enroll_officer("P-001", "主审张警官", pcm16(), actor_id="admin")
    session_repo.create(db, "CASE-1")
    db.commit()
    service.bind_roles("CASE-1", "P-001", None, actor_id="op")
    return engine, db


def _runtime_decision_role(
    *, margin: float | None, candidates: list[dict], enabled: set[SpeakerRole]
):
    """The decision the capture runtime really makes for this operating point."""
    service = AsrCaptureService(
        session_factory=None,
        device_manager=None,
        ai_supervisor=None,
        publish_event=lambda *_args: None,
    )
    return service._decide_with_operating_point(
        candidates=candidates,
        enabled_roles=enabled,
        threshold=0.372,
        margin=margin,
        usable_duration_ms=1200,
        overlap=False,
    ).role


# --- contract: UI declaration vs runtime decision -------------------------------


@pytest.mark.parametrize("margin", [0.08, None])
def test_readiness_effective_mode_matches_the_runtime_decision_roles(tmp_path: Path, margin):
    engine, db = _bound_case(tmp_path, f"contract-{margin}.sqlite3")
    try:
        service = VoiceprintService(db, speech_client=FakeSpeechClient())
        effective = service.readiness("CASE-1", speaker_mode=_calibrated(margin))[
            "effectiveRecognitionMode"
        ]

        # The runtime is fed the same margin/threshold pair. A clear interrogator win
        # must be honoured exactly when readiness claims the officer role is live.
        enabled = {SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR}
        candidates = [
            {"role": SpeakerRole.SUSPECT, "score": 0.60, "speaker_id": "s", "speaker_name": "张某"},
            {
                "role": SpeakerRole.INTERROGATOR,
                "score": 0.95,
                "speaker_id": "P-001",
                "speaker_name": "主审张警官",
            },
        ]
        role = _runtime_decision_role(margin=margin, candidates=candidates, enabled=enabled)

        if margin is not None:
            assert effective == SUSPECT_PLUS_INTERROGATOR
            assert role is SpeakerRole.INTERROGATOR
        else:
            assert effective == SUSPECT_ONLY
            assert role is SpeakerRole.SUSPECT
    finally:
        db.close()
        engine.dispose()


def test_readiness_and_runtime_both_degrade_when_margin_is_missing(tmp_path: Path):
    engine, db = _bound_case(tmp_path, "readiness-degradation.sqlite3")
    try:
        service = VoiceprintService(db, speech_client=FakeSpeechClient())

        uncalibrated = service.readiness("CASE-1", speaker_mode=_calibrated(margin=None))
        assert uncalibrated["declaredRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
        assert uncalibrated["effectiveRecognitionMode"] == SUSPECT_ONLY
        assert uncalibrated["recognitionModeDegraded"] is True
        assert uncalibrated["recognitionModeDegradedReason"] == DEGRADED_REASON_MARGIN_CALIBRATION_MISSING

        missing_threshold = service.readiness("CASE-1", speaker_mode=_calibrated(0.08, threshold=None))
        assert missing_threshold["effectiveRecognitionMode"] == SUSPECT_ONLY
        assert missing_threshold["recognitionModeDegraded"] is True
        assert missing_threshold["recognitionModeDegradedReason"] == DEGRADED_REASON_THRESHOLD_NOT_CONFIGURED

        calibrated = service.readiness("CASE-1", speaker_mode=_calibrated(0.08))
        assert calibrated["effectiveRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
        assert calibrated["recognitionModeDegraded"] is False
        assert calibrated["recognitionModeDegradedReason"] is None

        # The declaration the operator sees is never rewritten by the degradation.
        assert uncalibrated["recognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    finally:
        db.close()
        engine.dispose()


# --- readiness incremental fields -----------------------------------------------


def test_readiness_exposes_suspect_enrollment_metrics(tmp_path: Path):
    engine, db = _bound_case(tmp_path, "metrics.sqlite3")
    try:
        readiness = VoiceprintService(db, speech_client=FakeSpeechClient()).readiness("CASE-1")
        assert readiness["enrollmentQuality"] == "GOOD"
        assert readiness["usableDurationMs"] == 24000
        assert readiness["modelKey"] == "eres2net_large"
        assert readiness["modelId"] == "eres2net_large"
        assert readiness["modelVersion"] == "17b1-test"
    finally:
        db.close()
        engine.dispose()


def test_readiness_without_a_suspect_row_reports_none_metrics_instead_of_failing(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'no-suspect.sqlite3'}")
    init_database(engine)
    db = Session(engine)
    try:
        db.add(Case(id="CASE-1", officer_name="测试警官"))
        db.commit()
        readiness = VoiceprintService(db, speech_client=FakeSpeechClient()).readiness(
            "CASE-1",
            speaker_mode=SpeakerModeConfig(margin=None, threshold=None, threshold_source=None),
        )
        assert readiness["suspectReady"] is False
        assert readiness["enrollmentQuality"] is None
        assert readiness["usableDurationMs"] is None
        assert readiness["modelKey"] is None
        assert readiness["modelId"] is None
        assert readiness["modelVersion"] is None
        assert readiness["speakerMargin"] is None
        assert readiness["speakerThreshold"] is None
        assert readiness["thresholdSource"] is None
        assert readiness["marginConfigured"] is False
        assert readiness["thresholdConfigured"] is False
        assert readiness["effectiveRecognitionMode"] == SUSPECT_ONLY
        assert readiness["recognitionModeDegraded"] is False
        assert readiness["recognitionModeDegradedReason"] is None
    finally:
        db.close()
        engine.dispose()


def test_readiness_without_runtime_config_still_reports_the_declared_mode(tmp_path: Path):
    """No injection (e.g. the enrollment-start guard) must not invent a degradation."""
    engine, db = _bound_case(tmp_path, "no-config.sqlite3")
    try:
        readiness = VoiceprintService(db, speech_client=FakeSpeechClient()).readiness("CASE-1")
        assert readiness["speakerMargin"] is None
        assert readiness["effectiveRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
        assert readiness["recognitionModeDegraded"] is False
        assert readiness["recognitionModeDegradedReason"] is None
    finally:
        db.close()
        engine.dispose()


# --- API injection: runtime speaker config reaches the service layer ------------


def _app(tmp_path: Path, monkeypatch, supervisor):
    """App whose lifespan builds the given supervisor (the real one owns the margins)."""
    monkeypatch.setattr("app.main._build_supervisor", lambda: supervisor)
    app = create_app(
        database_url=f"sqlite:///{tmp_path / 'degradation-api.sqlite3'}",
        hardware_gateway=MockHardwareGateway(simulated=False),
    )
    app.state.speech_client = FakeSpeechClient()
    app.state.voiceprint_capture = FakeCaptureService()
    return app


def _payload(response):
    body = response.json()
    assert body["ok"] is True, body
    return body["data"]


def _bind_interrogator(client: TestClient) -> str:
    created = _payload(client.post("/api/v1/cases", json={"operator_id": "op", "suspectName": "测试对象"}))
    case_id = created["id"]
    _payload(client.post("/api/v1/identity/confirm", json={
        "case_id": case_id,
        "actor_id": "op",
        "name": "测试对象",
        "id_number": "320101199001010099",
        "source": "MANUAL",
    }))
    _payload(client.post(
        f"/api/v1/cases/{case_id}/voiceprints/suspect/enrollment/start",
        json={"actor_id": "op"},
    ))
    _payload(client.post(
        f"/api/v1/cases/{case_id}/voiceprints/suspect/enrollment/stop",
        json={"actor_id": "op"},
    ))
    _payload(client.post(
        "/api/v1/officer-voiceprints/P-001/enrollment/start",
        json={"officer_name": "主审张警官", "actor_id": "admin"},
    ))
    _payload(client.post(
        "/api/v1/officer-voiceprints/P-001/enrollment/stop",
        json={"actor_id": "admin"},
    ))
    _payload(client.post(f"/api/v1/cases/{case_id}/session/start", json={"actor_id": "op"}))
    _payload(client.put(f"/api/v1/cases/{case_id}/voiceprints/assignments", json={
        "interrogator_officer_id": "P-001",
        "recorder_officer_id": None,
        "actor_id": "op",
    }))
    return case_id


def test_readiness_endpoint_reports_degradation_when_the_device_has_no_margin(tmp_path: Path, monkeypatch):
    app = _app(tmp_path, monkeypatch, FakeSupervisor(margin=None))
    with TestClient(app) as client:
        case_id = _bind_interrogator(client)
        data = _payload(client.get(f"/api/v1/cases/{case_id}/voiceprints/readiness"))

    # The UI declaration still reflects the officer binding ...
    assert data["recognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert data["declaredRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert data["interrogatorReady"] is True
    # ... while the effective mode is the one the runtime will really enforce.
    assert data["effectiveRecognitionMode"] == SUSPECT_ONLY
    assert data["recognitionModeDegraded"] is True
    assert data["recognitionModeDegradedReason"] == DEGRADED_REASON_MARGIN_CALIBRATION_MISSING
    assert data["marginConfigured"] is False
    assert data["thresholdConfigured"] is True
    assert data["speakerThreshold"] == 0.372
    assert data["speakerMargin"] is None
    assert data["thresholdSource"] == "DEVICE_CALIBRATED"
    # Enrollment metrics reach the condensed card from the same payload.
    assert data["enrollmentQuality"] == "GOOD"
    assert data["usableDurationMs"] == 24000
    assert data["modelKey"] == "eres2net_large"


def test_readiness_endpoint_reports_the_calibrated_mode_without_degradation(tmp_path: Path, monkeypatch):
    app = _app(tmp_path, monkeypatch, FakeSupervisor(margin=0.08))
    with TestClient(app) as client:
        case_id = _bind_interrogator(client)
        data = _payload(client.get(f"/api/v1/cases/{case_id}/voiceprints/readiness"))

    assert data["declaredRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert data["effectiveRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert data["recognitionModeDegraded"] is False
    assert data["recognitionModeDegradedReason"] is None
    assert data["marginConfigured"] is True
    assert data["speakerMargin"] == 0.08
