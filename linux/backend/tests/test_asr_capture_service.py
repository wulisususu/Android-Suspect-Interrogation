from __future__ import annotations

import struct
import threading
import time
from pathlib import Path

from app.ai.speech.types import SpeechEvent, SpeechEventType
from app.database.models import ASRCaptureSession, ASRFragment
from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo
from app.repositories import voiceprints as voiceprint_repo
from app.services import asr_capture_service as capture_module
from app.services.asr_capture_service import AsrCaptureService


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

    def open_speech_session(self, session_id: str, *, sample_rate: int = 16000):
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


def _seed_database(tmp_path: Path):
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
        voiceprint_repo.assign_session_roles(
            db,
            session_id=session.id,
            suspect_voiceprint_id=suspect.id,
            interrogator_officer_id=None,
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
        assert fragment.speaker_source == "X_VECTOR"
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
    assert payload["speakerSource"] == "X_VECTOR"
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
    assert started["speakerThreshold"] == 0.70
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
    with factory() as db:
        assert db.query(ASRFragment).count() == 1
        fragment = db.query(ASRFragment).one()
        assert fragment.raw_text == "我是嫌疑人"
    engine.dispose()


def test_question_preparation_dictation_works_without_session_or_voiceprint_and_does_not_persist_dialogue(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'question-preparation.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        case = case_repo.create(
            db,
            {"id": "CASE-PREP", "suspectName": "张某", "officerName": "李警官"},
        )
        db.commit()
        case_id = case.id

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

    started = service.start_preparation(case_id)
    assert started["active"] is True
    assert started["caseId"] == case_id
    assert started["mode"] == "QUESTION_PREP"
    assert started["interrogationSessionId"] is None

    _wait_until(lambda: len(speech.pushed) == 2)
    stopped = service.stop_preparation(case_id)

    assert stopped["active"] is False
    assert stopped["mode"] == "QUESTION_PREP"
    assert stopped["text"] == "我是嫌疑人"
    assert speech.pushed == chunks
    assert device.started == 1
    assert device.stopped == 1
    assert speech.finalized == [speech.opened[0][0]]
    assert speech.closed == speech.finalized
    assert events.events == []

    with factory() as db:
        assert db.query(ASRCaptureSession).count() == 0
        assert db.query(ASRFragment).count() == 0
        assert session_repo.active_for_case(db, case_id) is None
        assert voiceprint_repo.get_suspect(db, case_id) is None
    engine.dispose()
