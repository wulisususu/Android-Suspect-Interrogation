from __future__ import annotations

import struct
import threading
import time
from pathlib import Path

from app.ai.speech.calibration import MODEL_BASELINE_THRESHOLD
from app.ai.speech.types import SpeechEvent, SpeechEventType
from app.database.models import ASRCaptureSession, ASRFragment
from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo
from app.repositories import voiceprints as voiceprint_repo
from app.services import asr_capture_service as capture_module
from app.services.asr_capture_service import AsrCaptureService
from app.services.speaker_mode import (
    DEGRADED_REASON_MARGIN_CALIBRATION_MISSING,
    SUSPECT_PLUS_INTERROGATOR,
)
from app.services.speaker_policy import SpeakerRole, decide_speaker


def _embedding(*values: float) -> bytes:
    return struct.pack(f"<{len(values)}f", *values)


class FakeDeviceManager:
    def __init__(self, chunks: list[bytes]):
        self._chunks = list(chunks)
        self.started = 0
        self.stopped = 0
        self.reads = 0
        self.exhausted = threading.Event()

    def start_record(self) -> None:
        self.started += 1

    def read_audio_frames(self, timeout: float = 0.01) -> bytes:
        self.reads += 1
        if self._chunks:
            chunk = self._chunks.pop(0)
            if not self._chunks:
                self.exhausted.set()
            return chunk
        self.exhausted.set()
        time.sleep(min(timeout, 0.005))
        return b""

    def stop_record(self) -> None:
        self.stopped += 1


class FakeSpeechSupervisor:
    def __init__(self, *, fail_on_push: bool = False):
        self.speaker_accept_threshold = 0.70
        self.speaker_margin = 0.10
        self.fail_on_push = fail_on_push
        self.opened: list[tuple[str, int]] = []
        self.pushed: list[bytes] = []
        self.finalized: list[str] = []
        self.closed: list[str] = []

    def open_speech_session(self, session_id: str, *, sample_rate: int = 16000, speaker_backend: str | None = None):
        self.opened.append((session_id, sample_rate))
        return {"session_id": session_id, "sample_rate": sample_rate}

    def push_speech_pcm(self, session_id: str, pcm: bytes):
        self.pushed.append(bytes(pcm))
        if self.fail_on_push:
            raise RuntimeError("simulated speech worker failure")
        if len(self.pushed) == 1:
            return [
                SpeechEvent(
                    type=SpeechEventType.VAD_START,
                    session_id=session_id,
                    start_ms=0,
                    model_id="test-vad",
                )
            ]
        if len(self.pushed) == 2:
            return [
                SpeechEvent(
                    type=SpeechEventType.VAD_END,
                    session_id=session_id,
                    start_ms=0,
                    end_ms=1200,
                    model_id="test-vad",
                ),
                SpeechEvent(
                    type=SpeechEventType.ASR_FINAL,
                    session_id=session_id,
                    start_ms=0,
                    end_ms=1200,
                    text="我是嫌疑人",
                    confidence=0.94,
                    model_id="test-paraformer",
                    details={"model_version": "asr-v1"},
                ),
                SpeechEvent(
                    type=SpeechEventType.SPEAKER_RESULT,
                    session_id=session_id,
                    start_ms=0,
                    end_ms=1200,
                    embedding=[1.0, 0.0, 0.0, 0.0],
                    model_id="test-xvector",
                    details={
                        "backend_key": "xvector",
                        "model_version": "speaker-v1",
                        "model_fingerprint": "sha256:test-xvector",
                    },
                ),
            ]
        return []

    def finalize_speech_session(self, session_id: str):
        self.finalized.append(session_id)
        return []

    def close_speech_session(self, session_id: str) -> None:
        self.closed.append(session_id)


class EventCollector:
    def __init__(self):
        self.events: list[tuple[str, str, dict]] = []
        self.ready = threading.Event()

    def __call__(self, session_id: str, event: str, payload: dict) -> None:
        self.events.append((session_id, event, payload))
        self.ready.set()


def _seed_database(tmp_path: Path, *, bind_interrogator: bool = False):
    engine = make_engine(f"sqlite:///{tmp_path / 'capture.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        case = case_repo.create(db, {"id": "CASE-1", "suspectName": "张某", "officerName": "李警官"})
        session = session_repo.create(db, case.id)
        suspect = voiceprint_repo.enroll_suspect(
            db,
            case_id=case.id,
            embedding=_embedding(1.0, 0.0, 0.0, 0.0),
            embedding_dim=4,
            model_id="test-xvector",
            model_version="ref-v1",
            enrollment_quality="TEST",
            usable_duration_ms=20_000,
        )
        officer_id = None
        if bind_interrogator:
            voiceprint_repo.enroll_officer(
                db,
                officer_id="P-001",
                officer_name="主审张警官",
                embedding=_embedding(0.0, 1.0, 0.0, 0.0),
                embedding_dim=4,
                model_id="test-xvector",
                model_version="ref-v1",
                enrollment_quality="TEST",
                usable_duration_ms=20_000,
            )
            officer_id = "P-001"
        voiceprint_repo.assign_session_roles(
            db,
            session_id=session.id,
            suspect_voiceprint_id=suspect.id,
            interrogator_officer_id=officer_id,
            recorder_officer_id=None,
        )
        db.commit()
        case_id = case.id
        session_id = session.id
    return engine, factory, case_id, session_id


def _wait_until(predicate, timeout: float = 1.0) -> None:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if predicate():
            return
        time.sleep(0.01)
    raise AssertionError("condition did not become true")


def test_capture_pushes_each_pcm_chunk_once_persists_verified_fragment_and_broadcasts(tmp_path: Path):
    engine, factory, case_id, session_id = _seed_database(tmp_path)
    chunks = [b"\x01\x00" * 1600, b"\x02\x00" * 1600]
    device = FakeDeviceManager(chunks)
    speech = FakeSpeechSupervisor()
    events = EventCollector()
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=device,
        ai_supervisor=speech,
        publish_event=events,
        sample_rate=16_000,
        read_timeout=0.01,
    )

    started = service.start(case_id)
    assert started["active"] is True
    assert started["caseId"] == case_id
    assert started["interrogationSessionId"] == session_id

    _wait_until(lambda: len(speech.pushed) == 2)
    _wait_until(lambda: bool(events.events))
    stopped = service.stop(case_id)

    assert speech.pushed == chunks
    assert device.started == 1
    assert device.stopped == 1
    assert len(speech.opened) == 1
    assert speech.finalized == [speech.opened[0][0]]
    assert speech.closed == [speech.opened[0][0]]
    assert stopped["active"] is False

    with factory() as db:
        captures = list(db.query(ASRCaptureSession).all())
        fragments = list(db.query(ASRFragment).all())
        assert len(captures) == 1
        assert captures[0].status == "STOPPED"
        assert captures[0].ended_at is not None
        assert len(fragments) == 1
        fragment = fragments[0]
        assert fragment.raw_text == "我是嫌疑人"
        assert fragment.edited_text == "我是嫌疑人"
        assert fragment.state == "PENDING"
        assert fragment.speaker == "SUSPECT"
        assert fragment.speaker_source == "SPEAKER_EMBEDDING"
        assert fragment.voiceprint_verified is True
        assert fragment.low_confidence is False
        assert fragment.speaker_score == 1.0
        assert fragment.speaker_threshold == 0.70
        assert fragment.speaker_margin == 0.10
        assert fragment.asr_confidence == 0.94
        assert fragment.model_id == "test-paraformer"
        assert fragment.model_version == "asr-v1"

    assert len(events.events) == 1
    event_session, event_name, payload = events.events[0]
    assert event_session == session_id
    assert event_name == "ASR_FRAGMENT"
    assert payload["rawText"] == "我是嫌疑人"
    assert payload["speaker"] == "SUSPECT"
    assert payload["speakerSource"] == "SPEAKER_EMBEDDING"
    assert payload["thresholdSource"] == "DEVICE_CALIBRATED"
    assert payload["voiceprintVerified"] is True
    engine.dispose()


def test_capture_without_margin_runs_suspect_only_and_preserves_uncalibrated_margin(tmp_path: Path):
    engine, factory, case_id, session_id = _seed_database(tmp_path)
    chunks = [b"\x01\x00" * 1600, b"\x02\x00" * 1600]
    device = FakeDeviceManager(chunks)
    speech = FakeSpeechSupervisor()
    speech.speaker_margin = None
    speech.speaker_threshold_source = "MODEL_BASELINE"
    events = EventCollector()
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=device,
        ai_supervisor=speech,
        publish_event=events,
        sample_rate=16_000,
        read_timeout=0.01,
    )

    started = service.start(case_id)
    assert started["active"] is True
    assert started["thresholdSource"] == "MODEL_BASELINE"
    assert started["speakerMarginConfigured"] is False

    _wait_until(lambda: len(speech.pushed) == 2)
    _wait_until(lambda: bool(events.events))
    service.stop(case_id)

    with factory() as db:
        fragment = db.query(ASRFragment).one()
        assert fragment.speaker == "SUSPECT"
        assert fragment.voiceprint_verified is True
        assert fragment.speaker_threshold == 0.70
        assert fragment.speaker_margin is None

    assert len(events.events) == 1
    event_session, event_name, payload = events.events[0]
    assert event_session == session_id
    assert event_name == "ASR_FRAGMENT"
    assert payload["speaker"] == "SUSPECT"
    assert payload["speakerMargin"] is None
    assert payload["thresholdSource"] == "MODEL_BASELINE"
    engine.dispose()


def _capture_service(factory, speech: FakeSpeechSupervisor, events: EventCollector) -> AsrCaptureService:
    return AsrCaptureService(
        session_factory=factory,
        device_manager=FakeDeviceManager([]),
        ai_supervisor=speech,
        publish_event=events,
        sample_rate=16_000,
        read_timeout=0.01,
    )


def test_capture_status_declares_the_effective_mode_reported_by_the_shared_rule(tmp_path: Path):
    """Task 17B-1: the runtime must publish the mode it actually enforces."""
    engine, factory, case_id, _ = _seed_database(tmp_path, bind_interrogator=True)
    speech = FakeSpeechSupervisor()
    chunks = [b"\x01\x00" * 1600, b"\x02\x00" * 1600]

    configured = AsrCaptureService(
        session_factory=factory,
        device_manager=FakeDeviceManager(list(chunks)),
        ai_supervisor=speech,
        publish_event=EventCollector(),
        sample_rate=16_000,
        read_timeout=0.01,
    )
    started = configured.start(case_id)
    assert started["declaredRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert started["effectiveRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert started["recognitionModeDegraded"] is False
    assert started["recognitionModeDegradedReason"] is None
    configured.stop(case_id)

    speech.speaker_margin = None
    uncalibrated = AsrCaptureService(
        session_factory=factory,
        device_manager=FakeDeviceManager(list(chunks)),
        ai_supervisor=speech,
        publish_event=EventCollector(),
        sample_rate=16_000,
        read_timeout=0.01,
    )
    degraded = uncalibrated.start(case_id)
    assert degraded["declaredRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert degraded["effectiveRecognitionMode"] == "SUSPECT_ONLY"
    assert degraded["recognitionModeDegraded"] is True
    assert degraded["recognitionModeDegradedReason"] == DEGRADED_REASON_MARGIN_CALIBRATION_MISSING
    uncalibrated.stop(case_id)
    engine.dispose()


def test_without_a_margin_the_runtime_drops_unbound_officer_candidates(tmp_path: Path):
    """The narrowing must reuse the shared predicate (single source of truth)."""
    engine, factory, _case_id, _session_id = _seed_database(tmp_path)
    speech = FakeSpeechSupervisor()
    speech.speaker_margin = None
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=None,
        ai_supervisor=speech,
        publish_event=lambda *_args: None,
    )
    candidates = [
        {"role": SpeakerRole.SUSPECT, "score": 0.95, "speaker_id": "s", "speaker_name": "张某"},
        {"role": SpeakerRole.INTERROGATOR, "score": 0.99, "speaker_id": "P-001", "speaker_name": "张警官"},
    ]

    degraded = service._decide_with_operating_point(
        candidates=candidates,
        enabled_roles={SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR},
        threshold=0.372,
        margin=None,
        usable_duration_ms=1200,
        overlap=False,
    )
    # The higher-scoring interrogator candidate must not win without a calibrated margin.
    assert degraded.role is SpeakerRole.SUSPECT
    assert degraded.voiceprint_verified is True

    calibrated = service._decide_with_operating_point(
        candidates=candidates,
        enabled_roles={SpeakerRole.SUSPECT, SpeakerRole.INTERROGATOR},
        threshold=0.372,
        margin=0.02,
        usable_duration_ms=1200,
        overlap=False,
    )
    assert calibrated.role is SpeakerRole.INTERROGATOR
    assert calibrated.speaker_id == "P-001"
    engine.dispose()


def test_degraded_fragment_audit_records_the_shared_mode_rule(tmp_path: Path):
    """Task 17B-1: a narrowed operating point must leave an auditable reason."""
    import json

    from app.database.models import AuditLog

    engine, factory, case_id, _ = _seed_database(tmp_path)
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=FakeDeviceManager([]),
        ai_supervisor=FakeSpeechSupervisor(),
        publish_event=lambda *_args: None,
    )
    decision = decide_speaker(
        candidates=[{"role": SpeakerRole.SUSPECT, "score": 0.10, "speaker_id": "s"}],
        enabled_roles={SpeakerRole.SUSPECT},
        threshold=0.372,
        margin=0.0,
        usable_duration_ms=1200,
        overlap=False,
    )
    with factory() as db:
        service._audit_speaker_decision(
            db,
            case_id=case_id,
            fragment_id="FRAG-1",
            decision=decision,
            threshold_source="MODEL_BASELINE",
            margin=None,
            usable_duration_ms=1200,
            decision_roles={SpeakerRole.SUSPECT},
            declared_mode=SUSPECT_PLUS_INTERROGATOR,
            asr_event=SpeechEvent(
                type=SpeechEventType.ASR_FINAL,
                session_id="SPEECH-1",
                start_ms=0,
                end_ms=1200,
                text="嗯",
            ),
        )
        db.commit()
        audit = db.query(AuditLog).filter(AuditLog.action == "ASR_SPEAKER_LOW_CONFIDENCE").one()
        detail = json.loads(audit.detail_json)

    assert detail["declaredRecognitionMode"] == SUSPECT_PLUS_INTERROGATOR
    assert detail["effectiveRecognitionMode"] == "SUSPECT_ONLY"
    assert detail["recognitionModeDegraded"] is True
    assert detail["recognitionModeDegradedReason"] == DEGRADED_REASON_MARGIN_CALIBRATION_MISSING
    engine.dispose()


def test_capture_failure_still_finalizes_worker_stops_alsa_and_marks_db_stopped(tmp_path: Path):
    engine, factory, case_id, _ = _seed_database(tmp_path)
    device = FakeDeviceManager([b"\x01\x00" * 1600])
    speech = FakeSpeechSupervisor(fail_on_push=True)
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=device,
        ai_supervisor=speech,
        publish_event=lambda *_args: None,
        sample_rate=16_000,
        read_timeout=0.01,
    )

    service.start(case_id)
    _wait_until(lambda: service.status(case_id)["active"] is False)

    assert device.started == 1
    assert device.stopped == 1
    assert len(speech.finalized) == 1
    assert speech.closed == speech.finalized
    status = service.status(case_id)
    assert status["lastError"] == "simulated speech worker failure"

    with factory() as db:
        capture = db.query(ASRCaptureSession).one()
        assert capture.status == "STOPPED"
        assert capture.ended_at is not None
        assert db.query(ASRFragment).count() == 0
    engine.dispose()


def test_capture_starts_with_model_baseline_when_device_calibration_is_missing(tmp_path: Path):
    engine, factory, case_id, _ = _seed_database(tmp_path)
    device = FakeDeviceManager([])
    speech = FakeSpeechSupervisor()
    speech.speaker_accept_threshold = None
    speech.speaker_margin = None
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=device,
        ai_supervisor=speech,
        publish_event=lambda *_args: None,
        read_timeout=0.01,
    )

    started = service.start(case_id)
    assert started["active"] is True
    assert started["speakerThreshold"] == MODEL_BASELINE_THRESHOLD
    assert started["thresholdSource"] == "MODEL_BASELINE"
    assert started["speakerMarginConfigured"] is False
    assert device.started == 1

    service.stop(case_id)
    assert device.stopped == 1
    engine.dispose()


def test_projection_failure_keeps_raw_fragment_and_capture_loop_healthy(tmp_path: Path, monkeypatch):
    engine, factory, case_id, _ = _seed_database(tmp_path)
    device = FakeDeviceManager([b"\x01\x00" * 1600, b"\x02\x00" * 1600])
    speech = FakeSpeechSupervisor()
    events = EventCollector()

    class ExplodingProjection:
        calls = 0

        def __init__(self, _db):
            pass

        def process_fragment(self, _case_id: str, _fragment_id: str):
            type(self).calls += 1
            raise RuntimeError("simulated formal projection failure")

    monkeypatch.setattr(capture_module, "InterrogationProjectionService", ExplodingProjection, raising=False)
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=device,
        ai_supervisor=speech,
        publish_event=events,
        sample_rate=16_000,
        read_timeout=0.01,
    )

    service.start(case_id)
    _wait_until(lambda: len(speech.pushed) == 2)
    _wait_until(lambda: bool(events.events))
    stopped = service.stop(case_id)

    assert ExplodingProjection.calls == 1
    assert stopped["lastError"] is None


def test_fragment_sink_bypasses_legacy_projection_and_capture_finished_sink_flushes(tmp_path: Path, monkeypatch):
    engine, factory, case_id, session_id = _seed_database(tmp_path)
    device = FakeDeviceManager([b"\x01\x00" * 1600, b"\x02\x00" * 1600])
    speech = FakeSpeechSupervisor()
    events = EventCollector()
    fragments: list[tuple[str, str]] = []
    finished: list[tuple[str, str]] = []

    class ForbiddenProjection:
        calls = 0

        def __init__(self, _db):
            pass

        def process_fragment(self, _case_id: str, _fragment_id: str):
            type(self).calls += 1
            raise AssertionError("legacy projection must not run in qwen sink mode")

    monkeypatch.setattr(capture_module, "InterrogationProjectionService", ForbiddenProjection, raising=False)
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=device,
        ai_supervisor=speech,
        publish_event=events,
        fragment_sink=lambda case, fragment: fragments.append((case, fragment)),
        capture_finished_sink=lambda case, session: finished.append((case, session)),
        sample_rate=16_000,
        read_timeout=0.01,
    )

    service.start(case_id)
    _wait_until(lambda: bool(fragments))
    service.stop(case_id)

    assert ForbiddenProjection.calls == 0
    assert len(fragments) == 1
    assert fragments[0][0] == case_id
    assert finished == [(case_id, session_id)]
    engine.dispose()
