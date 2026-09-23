from __future__ import annotations

import threading
import time
from pathlib import Path

from app.database.models import ASRCaptureSession
from app.ai.speech.types import SpeechEvent, SpeechEventType
from app.database.session import init_database, make_engine, make_session_factory
from app.repositories import asr_fragments as asr_repo
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo
from app.services.durable_audio_archive import DurableAudioArchive
from app.services.live_speech_coordinator import LiveSpeechCoordinator
from app.services.source_aware_asr_capture_service import SourceAwareAsrCaptureService


class FakeDevice:
    def __init__(self, frames: list[bytes]):
        self.frames = list(frames)
        self.read_count = 0
        self.drained = threading.Event()

    def start_record(self) -> None:
        pass

    def read_audio_frames(self, timeout: float = 0.01) -> bytes:
        self.read_count += 1
        if self.frames:
            frame = self.frames.pop(0)
            if not self.frames:
                self.drained.set()
            return frame
        self.drained.set()
        time.sleep(min(timeout, 0.005))
        return b""

    def stop_record(self) -> None:
        pass


class BlockingSpeechWorker:
    speaker_accept_threshold = 0.7
    speaker_margin = 0.1

    def __init__(self) -> None:
        self.push_started = threading.Event()
        self.release_push = threading.Event()
        self.pushed: list[bytes] = []

    def open_speech_session(self, session_id: str, **kwargs):
        return {"session_id": session_id}

    def push_speech_pcm(self, session_id: str, pcm: bytes):
        self.pushed.append(bytes(pcm))
        self.push_started.set()
        self.release_push.wait(timeout=5)
        return []

    def finalize_speech_session(self, session_id: str):
        return []

    def close_speech_session(self, session_id: str) -> None:
        pass


class FailingSpeechWorker(BlockingSpeechWorker):
    def push_speech_pcm(self, session_id: str, pcm: bytes):
        self.pushed.append(bytes(pcm))
        self.push_started.set()
        raise RuntimeError("simulated ASR failure")


class ReplaySpeechWorker:
    def __init__(self, *, emit_final: bool, crash_before_finalize: bool = False) -> None:
        self.emit_final = emit_final
        self.crash_before_finalize = crash_before_finalize
        self.push_started = threading.Event()
        self.finalize_called = threading.Event()
        self.open_base_samples: list[int] = []
        self.pushed: list[bytes] = []

    def open_speech_session(self, session_id: str, **kwargs):
        self.open_base_samples.append(int(kwargs.get("base_sample", 0)))
        return {"session_id": session_id}

    def push_speech_pcm(self, session_id: str, pcm: bytes):
        self.pushed.append(bytes(pcm))
        self.push_started.set()
        if not self.emit_final:
            return [
                SpeechEvent(
                    type=SpeechEventType.VAD_START,
                    session_id=session_id,
                    start_ms=0,
                    details={"replay_start_sample": 0},
                )
            ]
        return [
            SpeechEvent(
                type=SpeechEventType.VAD_START,
                session_id=session_id,
                start_ms=0,
                details={"replay_start_sample": 0},
            ),
            SpeechEvent(
                type=SpeechEventType.VAD_END,
                session_id=session_id,
                start_ms=0,
                end_ms=1000,
            ),
            SpeechEvent(
                type=SpeechEventType.ASR_FINAL,
                session_id=session_id,
                start_ms=0,
                end_ms=1000,
                text="完整记录",
                confidence=0.95,
                model_id="paraformer",
                details={
                    "stage_one_asr_only": True,
                    "asr_start_sample": 0,
                    "asr_end_sample": 16_000,
                    "model_version": "test-v1",
                },
            ),
        ]

    def finalize_speech_session(self, session_id: str):
        self.finalize_called.set()
        if self.crash_before_finalize:
            raise RuntimeError("simulated crash before VAD finalization")
        return []

    def close_speech_session(self, session_id: str) -> None:
        pass


class EventCollector:
    def __init__(self) -> None:
        self.events: list[tuple[str, str, dict]] = []

    def __call__(self, session_id: str, event: str, payload: dict) -> None:
        self.events.append((session_id, event, payload))


def _seed_database(tmp_path: Path):
    engine = make_engine(f"sqlite:///{tmp_path / 'capture.db'}")
    init_database(engine)
    factory = make_session_factory(engine)
    with factory() as db:
        case = case_repo.create(db, {"id": "CASE-COORD", "suspectName": "待识别"})
        session = session_repo.create(db, case.id)
        db.commit()
        return factory, case.id, session.id


def _source_service(factory, device, speech, events) -> SourceAwareAsrCaptureService:
    return SourceAwareAsrCaptureService(
        session_factory=factory,
        device_manager=device,
        browser_audio_input=None,
        ai_supervisor=speech,
        publish_event=events,
        read_timeout=0.01,
    )


def _wait_for(predicate, timeout: float = 2.0) -> None:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        if predicate():
            return
        time.sleep(0.005)
    raise AssertionError("condition was not met before timeout")


def _asr_cursor(factory, capture_id: str) -> int:
    with factory() as db:
        capture = db.get(ASRCaptureSession, capture_id)
        return -1 if capture is None else int(capture.asr_cursor_sample)


def test_capture_persists_audio_while_asr_worker_is_blocked(tmp_path: Path):
    factory, case_id, _session_id = _seed_database(tmp_path)
    frames = [b"\x01\x00" * 160, b"\x02\x00" * 160, b"\x03\x00" * 160]
    device = FakeDevice(frames)
    speech = BlockingSpeechWorker()
    events = EventCollector()
    capture_service = _source_service(factory, device, speech, events)
    coordinator = LiveSpeechCoordinator(
        data_dir=tmp_path / "data",
        session_factory=factory,
        capture_service=capture_service,
        ai_supervisor=speech,
    )
    coordinator.start()
    try:
        started = capture_service.start(case_id)
        assert started["active"] is True
        assert speech.push_started.wait(timeout=1)
        _wait_for(lambda: device.read_count >= 4)

        capture_id = started["captureSessionId"]
        with factory() as db:
            capture = db.get(ASRCaptureSession, capture_id)
            assert capture is not None
            assert capture.audio_sample_count == 480
            assert capture.speaker_status == "PENDING"
        assert coordinator.archive.read_samples(capture_id, 0, 480) == b"".join(
            [b"\x01\x00" * 160, b"\x02\x00" * 160, b"\x03\x00" * 160]
        )
        assert capture_service.stop(case_id)["active"] is False
        assert len(speech.pushed) == 1
    finally:
        speech.release_push.set()
        capture_service.shutdown()
        coordinator.shutdown()


def test_startup_recovers_and_queues_unfinished_audio_before_speaker_work(tmp_path: Path):
    factory, case_id, session_id = _seed_database(tmp_path)
    with factory() as db:
        capture = asr_repo.create_capture_session(
            db,
            case_id=case_id,
            interrogation_session_id=session_id,
            sample_rate=16_000,
        )
        capture_id = capture.id
        db.commit()

    data_dir = tmp_path / "data"
    archive = DurableAudioArchive(data_dir, factory)
    archive.open_capture(capture_id, case_id=case_id)
    archive.append(capture_id, b"\x05\x00" * 160)

    speech = BlockingSpeechWorker()
    speech.release_push.set()
    capture_service = _source_service(factory, FakeDevice([]), speech, EventCollector())
    coordinator = LiveSpeechCoordinator(
        data_dir=data_dir,
        session_factory=factory,
        capture_service=capture_service,
        ai_supervisor=speech,
    )
    speaker_work = threading.Event()
    coordinator.start()
    coordinator.enqueue_speaker_work(speaker_work.set)
    try:
        assert speech.push_started.wait(timeout=1)
        assert not speaker_work.is_set()
        speech.release_push.set()
        _wait_for(speaker_work.is_set)
        assert speech.pushed == [b"\x05\x00" * 160]
        with factory() as db:
            capture = db.get(ASRCaptureSession, capture_id)
            assert capture is not None
            assert capture.recording_status == "COMPLETE"
            assert capture.asr_cursor_sample == 160
    finally:
        speech.release_push.set()
        coordinator.shutdown()


def test_startup_replays_only_unprocessed_audio_for_completed_capture(tmp_path: Path):
    factory, case_id, session_id = _seed_database(tmp_path)
    with factory() as db:
        capture = asr_repo.create_capture_session(
            db,
            case_id=case_id,
            interrogation_session_id=session_id,
            sample_rate=16_000,
        )
        capture_id = capture.id
        db.commit()

    data_dir = tmp_path / "data"
    archive = DurableAudioArchive(data_dir, factory)
    archive.open_capture(capture_id, case_id=case_id)
    audio = b"\x06\x00" * 480
    archive.append(capture_id, audio)
    archive.finalize_capture(capture_id)
    with factory() as db:
        capture = db.get(ASRCaptureSession, capture_id)
        assert capture is not None
        capture.asr_cursor_sample = 160
        db.commit()

    speech = BlockingSpeechWorker()
    speech.release_push.set()
    capture_service = _source_service(factory, FakeDevice([]), speech, EventCollector())
    coordinator = LiveSpeechCoordinator(
        data_dir=data_dir,
        session_factory=factory,
        capture_service=capture_service,
        ai_supervisor=speech,
    )
    coordinator.start()
    try:
        assert speech.push_started.wait(timeout=1)
        _wait_for(lambda: _asr_cursor(factory, capture_id) == 480)
        assert speech.pushed == [audio[160 * 2 :]]
        with factory() as db:
            capture = db.get(ASRCaptureSession, capture_id)
            assert capture is not None
            assert capture.recording_status == "COMPLETE"
            assert capture.asr_cursor_sample == capture.audio_sample_count == 480
    finally:
        coordinator.shutdown()


def test_restart_replays_unfinished_vad_when_complete_cursor_reached_audio_end(tmp_path: Path):
    factory, case_id, session_id = _seed_database(tmp_path)
    with factory() as db:
        capture = asr_repo.create_capture_session(
            db,
            case_id=case_id,
            interrogation_session_id=session_id,
            sample_rate=16_000,
        )
        capture_id = capture.id
        db.commit()

    data_dir = tmp_path / "data"
    archive = DurableAudioArchive(data_dir, factory)
    audio = b"\x0a\x00" * 16_000
    archive.open_capture(capture_id, case_id=case_id)
    archive.append(capture_id, audio)
    archive.finalize_capture(capture_id)

    crashed_worker = ReplaySpeechWorker(emit_final=False, crash_before_finalize=True)
    first_service = _source_service(factory, FakeDevice([]), crashed_worker, EventCollector())
    first = LiveSpeechCoordinator(
        data_dir=data_dir,
        session_factory=factory,
        capture_service=first_service,
        ai_supervisor=crashed_worker,
    )
    first.start()
    try:
        assert crashed_worker.push_started.wait(timeout=1)
        assert crashed_worker.finalize_called.wait(timeout=1)
        _wait_for(lambda: _asr_cursor(factory, capture_id) == 16_000)
        with factory() as db:
            capture = db.get(ASRCaptureSession, capture_id)
            assert capture is not None
            assert capture.recording_status == "COMPLETE"
            assert capture.asr_cursor_sample == capture.audio_sample_count == 16_000
            assert capture.asr_unfinished_start_sample == 0
    finally:
        first.shutdown()

    replay_worker = ReplaySpeechWorker(emit_final=True)
    replay_service = _source_service(factory, FakeDevice([]), replay_worker, EventCollector())
    replay = LiveSpeechCoordinator(
        data_dir=data_dir,
        session_factory=factory,
        capture_service=replay_service,
        ai_supervisor=replay_worker,
    )
    replay.start()
    try:
        _wait_for(lambda: len(_fragments(factory, capture_id)) == 1)
        _wait_for(lambda: _unfinished_start(factory, capture_id) is None)
        assert replay_worker.finalize_called.wait(timeout=1)
        first_result = replay.process_asr_range(capture_id, 0, 16_000)
        second_result = replay.process_asr_range(capture_id, 0, 16_000)
        assert first_result.fragment_ids == second_result.fragment_ids
        assert replay_worker.open_base_samples == [0, 0]
        fragments = _fragments(factory, capture_id)
        assert len(fragments) == 1
        assert fragments[0].ordinal == 0
        assert fragments[0].raw_text == "完整记录"
        assert fragments[0].speaker == "UNKNOWN"
        assert fragments[0].speaker_source == "PENDING_ANALYSIS"
        assert fragments[0].asr_idempotency_key
    finally:
        replay.shutdown()


def _fragments(factory, capture_id: str):
    with factory() as db:
        return asr_repo.list_for_capture(db, capture_id)


def _unfinished_start(factory, capture_id: str) -> int | None:
    with factory() as db:
        capture = db.get(ASRCaptureSession, capture_id)
        return None if capture is None else capture.asr_unfinished_start_sample


def test_coordinator_inference_failure_does_not_stop_durable_capture(tmp_path: Path):
    factory, case_id, _session_id = _seed_database(tmp_path)
    frames = [b"\x07\x00" * 160, b"\x08\x00" * 160, b"\x09\x00" * 160]
    device = FakeDevice(frames)
    speech = FailingSpeechWorker()
    events = EventCollector()
    capture_service = _source_service(factory, device, speech, events)
    coordinator = LiveSpeechCoordinator(
        data_dir=tmp_path / "data",
        session_factory=factory,
        capture_service=capture_service,
        ai_supervisor=speech,
    )
    coordinator.start()
    try:
        started = capture_service.start(case_id)
        assert speech.push_started.wait(timeout=1)
        _wait_for(lambda: device.read_count >= 4)
        status = capture_service.status(case_id)
        assert status["active"] is True
        assert status["lastError"] == "simulated ASR failure"
        expected_audio = b"".join(frames)
        with factory() as db:
            capture = db.get(ASRCaptureSession, started["captureSessionId"])
            assert capture is not None
            assert capture.audio_sample_count == 480
        assert coordinator.archive.read_samples(started["captureSessionId"], 0, 480) == expected_audio
        assert capture_service.stop(case_id)["active"] is False
    finally:
        capture_service.shutdown()
        coordinator.shutdown()


def test_disk_failure_marks_capture_incomplete_and_publishes_storage_error(tmp_path: Path):
    factory, case_id, _session_id = _seed_database(tmp_path)
    device = FakeDevice([b"\x01\x00" * 160])
    speech = BlockingSpeechWorker()
    speech.release_push.set()
    events = EventCollector()
    capture_service = _source_service(factory, device, speech, events)
    coordinator = LiveSpeechCoordinator(
        data_dir=tmp_path / "data",
        session_factory=factory,
        capture_service=capture_service,
        ai_supervisor=speech,
    )
    coordinator.start()

    def fail_append(*args, **kwargs):
        raise OSError("simulated disk full")

    coordinator.archive.append = fail_append
    try:
        started = capture_service.start(case_id)
        _wait_for(lambda: not capture_service.status(case_id).get("active"))

        with factory() as db:
            capture = db.get(ASRCaptureSession, started["captureSessionId"])
            assert capture is not None
            assert capture.recording_status == "INCOMPLETE"
        assert any(event == "ASR_STORAGE_ERROR" for _, event, _ in events.events)
        assert any(
            payload.get("message") == "simulated disk full"
            for _, event, payload in events.events
            if event == "ASR_STORAGE_ERROR"
        )
    finally:
        capture_service.shutdown()
        coordinator.shutdown()
