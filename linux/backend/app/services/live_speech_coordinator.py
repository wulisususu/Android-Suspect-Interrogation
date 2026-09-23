from __future__ import annotations

import logging
import queue
import threading
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Callable

from sqlalchemy import select
from sqlalchemy.orm import Session, sessionmaker

from app.database.models import ASRCaptureSession
from app.repositories import audio_archive as archive_repo
from app.services.durable_audio_archive import DurableAudioArchive


logger = logging.getLogger(__name__)
_MAX_INFERENCE_SAMPLES = 16_000


@dataclass(frozen=True)
class _AudioRange:
    runtime: Any
    start_sample: int
    end_sample: int


@dataclass(frozen=True)
class _FinishCapture:
    runtime: Any


class LiveSpeechCoordinator:
    """Keep microphone reads independent from the slower speech worker."""

    def __init__(
        self,
        *,
        data_dir: str | Path,
        session_factory: sessionmaker[Session],
        capture_service: Any,
        ai_supervisor: Any,
    ) -> None:
        self.session_factory = session_factory
        self.capture_service = capture_service
        self.ai_supervisor = ai_supervisor
        self.archive = DurableAudioArchive(data_dir, session_factory)
        self.asr_queue: queue.Queue[_AudioRange | _FinishCapture | None] = queue.Queue()
        self.speaker_queue: queue.Queue[Callable[[], None] | None] = queue.Queue()
        self._lock = threading.RLock()
        self._started = False
        self._stopping = threading.Event()
        self._asr_thread: threading.Thread | None = None
        self._speaker_thread: threading.Thread | None = None
        self._durable_cursors: dict[str, int] = {}
        self._asr_cursors: dict[str, int] = {}
        self._asr_blocked: set[str] = set()
        self._asr_busy = threading.Event()
        self.capture_service.set_live_speech_coordinator(self)

    def start(self) -> None:
        with self._lock:
            if self._started:
                return
            recovered = self.archive.recover_incomplete()
            with self.session_factory() as db:
                completed_with_backlog = list(
                    db.scalars(
                        select(ASRCaptureSession.id)
                        .where(
                            ASRCaptureSession.recording_status == "COMPLETE",
                            ASRCaptureSession.asr_cursor_sample < ASRCaptureSession.audio_sample_count,
                        )
                        .order_by(ASRCaptureSession.started_at, ASRCaptureSession.id)
                    )
                )
            recovered = list(dict.fromkeys([*recovered, *completed_with_backlog]))
            recovery_jobs: list[_AudioRange | _FinishCapture] = []
            for capture_id in recovered:
                finalization_error: Exception | None = None
                with self.session_factory() as db:
                    capture = db.get(ASRCaptureSession, capture_id)
                    if capture is None:
                        continue
                    should_finalize = capture.recording_status == "CAPTURING"
                if should_finalize:
                    try:
                        self.archive.finalize_capture(capture_id)
                    except Exception as exc:
                        finalization_error = exc
                with self.session_factory() as db:
                    capture = db.get(ASRCaptureSession, capture_id)
                    if capture is None or capture.interrogation_session_id is None:
                        continue
                    runtime = self.capture_service.build_recovery_runtime(capture)
                    cursor = max(0, int(capture.asr_cursor_sample or 0))
                    end = max(cursor, int(capture.audio_sample_count or 0))
                    self._asr_cursors[capture_id] = cursor
                    self._durable_cursors[capture_id] = int(capture.audio_sample_count or 0)
                if runtime is None:
                    continue
                if finalization_error is not None:
                    self._mark_storage_error(runtime, finalization_error)
                while cursor < end:
                    next_cursor = min(end, cursor + _MAX_INFERENCE_SAMPLES)
                    recovery_jobs.append(_AudioRange(runtime, cursor, next_cursor))
                    cursor = next_cursor
                recovery_jobs.append(_FinishCapture(runtime))

            self._asr_thread = threading.Thread(
                target=self._asr_loop,
                daemon=True,
                name="live-speech-asr",
            )
            self._asr_thread.start()
            for job in recovery_jobs:
                self.asr_queue.put(job)
            self._speaker_thread = threading.Thread(
                target=self._speaker_loop,
                daemon=True,
                name="live-speech-speaker",
            )
            self._speaker_thread.start()
            self._started = True

    def open_capture(self, runtime: Any) -> None:
        try:
            self.archive.open_capture(runtime.capture_session_id, case_id=runtime.case_id)
        except Exception as exc:
            self._mark_storage_error(runtime, exc)
            raise
        runtime.durable_sample_cursor = 0
        with self._lock:
            self._durable_cursors[runtime.capture_session_id] = 0
            self._asr_cursors[runtime.capture_session_id] = 0

    def append_audio(self, runtime: Any, pcm: bytes) -> int:
        """Commit audio first, then queue only its durable sample range."""
        with self._lock:
            start_sample = self._durable_cursors.get(runtime.capture_session_id, 0)
        try:
            end_sample = self.archive.append(runtime.capture_session_id, pcm)
        except Exception as exc:
            self._mark_storage_error(runtime, exc)
            raise
        if end_sample != start_sample + len(pcm) // 2:
            exc = RuntimeError("audio archive returned a non-contiguous durable cursor")
            self._mark_storage_error(runtime, exc)
            raise exc
        with self._lock:
            self._durable_cursors[runtime.capture_session_id] = end_sample
            runtime.durable_sample_cursor = end_sample
        self.asr_queue.put(_AudioRange(runtime, start_sample, end_sample))
        return end_sample

    def finish_capture(self, runtime: Any) -> None:
        if runtime.storage_error is None:
            try:
                self.archive.finalize_capture(runtime.capture_session_id)
            except Exception as exc:
                self._mark_storage_error(runtime, exc)
        self.asr_queue.put(_FinishCapture(runtime))

    def _mark_storage_error(self, runtime: Any, exc: Exception) -> None:
        runtime.storage_error = str(exc)
        try:
            with archive_repo.archive_transaction(self.session_factory) as db:
                archive_repo.mark_capture_incomplete(db, runtime.capture_session_id)
        except Exception:
            logger.exception("failed to mark audio capture %s incomplete", runtime.capture_session_id)
        try:
            runtime.capture_error_sink(exc)
        except Exception:
            logger.exception("failed to publish storage failure for capture %s", runtime.capture_session_id)
        try:
            self.capture_service.publish_event(
                runtime.interrogation_session_id,
                "ASR_STORAGE_ERROR",
                {
                    "caseId": runtime.case_id,
                    "captureSessionId": runtime.capture_session_id,
                    "code": "AUDIO_STORAGE_ERROR",
                    "message": str(exc),
                },
            )
        except Exception:
            logger.exception("failed to publish audio storage error for capture %s", runtime.capture_session_id)

    def _asr_loop(self) -> None:
        opened: set[str] = set()
        while True:
            task = self.asr_queue.get()
            if task is None:
                self.asr_queue.task_done()
                return
            runtime = task.runtime
            session_id = runtime.speech_session_id
            if isinstance(task, _AudioRange):
                self._asr_busy.set()
            else:
                try:
                    if session_id in opened:
                        try:
                            runtime.consume_events(self.ai_supervisor.finalize_speech_session(session_id))
                        except Exception as exc:
                            runtime.inference_error_sink(exc)
                        finally:
                            self.ai_supervisor.close_speech_session(session_id)
                            opened.discard(session_id)
                except Exception as exc:
                    runtime.inference_error_sink(exc)
                finally:
                    try:
                        runtime.capture_finished_sink()
                    except Exception:
                        logger.exception("capture finished callback failed for %s", runtime.capture_session_id)
                    self.asr_queue.task_done()
                continue
            try:
                if runtime.capture_session_id in self._asr_blocked:
                    continue
                expected_start = self._asr_cursors.setdefault(
                    runtime.capture_session_id,
                    task.start_sample,
                )
                if expected_start != task.start_sample:
                    raise RuntimeError("ASR queue received a non-contiguous durable audio range")
                if session_id not in opened:
                    self.ai_supervisor.open_speech_session(
                        session_id,
                        sample_rate=runtime.sample_rate,
                        speaker_backend=runtime.speaker_backend,
                    )
                    opened.add(session_id)
                pcm = self.archive.read_samples(
                    runtime.capture_session_id,
                    task.start_sample,
                    task.end_sample,
                )
                events = self.ai_supervisor.push_speech_pcm(session_id, pcm)
                runtime.consume_events(events)
                self._advance_asr_cursor(runtime.capture_session_id, task.end_sample)
            except Exception as exc:
                if isinstance(task, _AudioRange):
                    self._asr_blocked.add(runtime.capture_session_id)
                try:
                    runtime.inference_error_sink(exc)
                except Exception:
                    logger.exception("failed to report inference error for capture %s", runtime.capture_session_id)
            finally:
                self._asr_busy.clear()
                self.asr_queue.task_done()

    def _advance_asr_cursor(self, capture_id: str, end_sample: int) -> None:
        with self.session_factory() as db:
            capture = db.get(ASRCaptureSession, capture_id)
            if capture is not None:
                capture.asr_cursor_sample = max(int(capture.asr_cursor_sample or 0), int(end_sample))
                db.commit()
        with self._lock:
            self._asr_cursors[capture_id] = max(self._asr_cursors.get(capture_id, 0), int(end_sample))

    def enqueue_speaker_work(self, work: Callable[[], None]) -> None:
        self.speaker_queue.put(work)

    def _speaker_loop(self) -> None:
        while not self._stopping.is_set():
            try:
                work = self.speaker_queue.get(timeout=0.1)
            except queue.Empty:
                continue
            if work is None:
                self.speaker_queue.task_done()
                return
            try:
                while (
                    not self._stopping.is_set()
                    and (not self.asr_queue.empty() or self._asr_busy.is_set())
                ):
                    self._stopping.wait(0.02)
                if not self._stopping.is_set():
                    work()
            except Exception:
                logger.exception("deferred speaker work failed")
            finally:
                self.speaker_queue.task_done()

    def shutdown(self) -> None:
        with self._lock:
            if not self._started:
                return
            self._stopping.set()
            self.asr_queue.put(None)
            self.speaker_queue.put(None)
            asr_thread = self._asr_thread
            speaker_thread = self._speaker_thread
            self._started = False
        if asr_thread is not None:
            asr_thread.join(timeout=5)
        if speaker_thread is not None:
            speaker_thread.join(timeout=2)
