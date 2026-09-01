# commit: feat: route live qa units asynchronously
from __future__ import annotations

from pathlib import Path


def replace_once(path: str, old: str, new: str) -> None:
    target = Path(path)
    text = target.read_text(encoding="utf-8")
    if old not in text:
        raise SystemExit(f"expected source block missing in {path}: {old[:160]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


def write_new(path: str, content: str) -> None:
    target = Path(path)
    if target.exists():
        raise SystemExit(f"refusing to overwrite existing file: {path}")
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(content, encoding="utf-8")


coordinator = '''from __future__ import annotations

import logging
import queue
import threading
from datetime import datetime, timezone
from typing import Any, Callable

from sqlalchemy import select

from app.database.models import ASRCaptureSession
from app.repositories import audit as audit_repo
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo
from app.services.formal_record_router import FormalRecordRouteDecision, FormalRecordRouter, RouteClass
from app.services.formal_record_routing_service import FormalRecordRoutingService
from app.services.qa_unit_builder import QAUnitBuilder
from app.services.serializers import qa_unit_dict


logger = logging.getLogger(__name__)
PublishEvent = Callable[[str, str, dict[str, Any]], None]


class QARoutingCoordinator:
    """Move semantic formal-record routing off the realtime ASR capture thread.

    Fragment notifications are best-effort wakeups only. Persisted ASR rows are
    authoritative and are recovered while a capture is active and again when a
    capture flushes, so queue saturation or process restart cannot silently lose
    attributable speech.
    """

    def __init__(
        self,
        *,
        session_factory,
        ai_supervisor: Any,
        publish_event: PublishEvent,
        idle_close_seconds: float = 4.0,
        poll_interval: float = 0.25,
        queue_size: int = 256,
    ) -> None:
        self.session_factory = session_factory
        self.ai_supervisor = ai_supervisor
        self.publish_event = publish_event
        self.idle_close_seconds = max(0.01, float(idle_close_seconds))
        self.poll_interval = max(0.01, float(poll_interval))
        self._queue: queue.Queue[tuple[str, str, str] | None] = queue.Queue(maxsize=max(1, int(queue_size)))
        self._stop = threading.Event()
        self._thread: threading.Thread | None = None
        self._state_lock = threading.RLock()
        self._pending_flushes: set[tuple[str, str]] = set()
        self._recovery_markers: set[str] = set()

    @property
    def running(self) -> bool:
        thread = self._thread
        return bool(thread is not None and thread.is_alive())

    def start(self) -> None:
        with self._state_lock:
            if self.running:
                return
            self._stop.clear()
            thread = threading.Thread(target=self._run, daemon=True, name="qa-routing-coordinator")
            self._thread = thread
            thread.start()

    def enqueue_fragment(self, case_id: str, fragment_id: str) -> None:
        notice = ("fragment", str(case_id), str(fragment_id))
        try:
            self._queue.put_nowait(notice)
        except queue.Full:
            with self._state_lock:
                self._recovery_markers.add(str(case_id))
            logger.warning("qa routing queue full; persisted fragment will be recovered: %s", fragment_id)

    def flush_capture(self, case_id: str, session_id: str) -> None:
        pair = (str(case_id), str(session_id))
        with self._state_lock:
            self._pending_flushes.add(pair)
        try:
            self._queue.put_nowait(("wake", pair[0], pair[1]))
        except queue.Full:
            # Flush intent is retained in _pending_flushes, so a saturated queue
            # cannot lose the final unit even though this wakeup is dropped.
            pass

    def shutdown(self) -> None:
        self._stop.set()
        try:
            self._queue.put_nowait(None)
        except queue.Full:
            pass
        thread = self._thread
        if thread is not None and thread is not threading.current_thread():
            thread.join(timeout=5.0)
        with self._state_lock:
            if self._thread is thread and (thread is None or not thread.is_alive()):
                self._thread = None

    def _run(self) -> None:
        try:
            while not self._stop.is_set():
                try:
                    self._write_recovery_markers()
                    self._recover_active_sessions()
                    self._apply_pending_flushes()
                    self._close_idle()
                    try:
                        notice = self._queue.get(timeout=self.poll_interval)
                    except queue.Empty:
                        continue
                    if notice is None:
                        continue
                    kind, case_id, value = notice
                    if kind == "fragment":
                        self._consume_fragment(case_id, value)
                except Exception:
                    logger.exception("qa routing worker iteration failed")
        finally:
            # A normal application shutdown stops capture first, which records a
            # flush intent. Process those persisted fragments before exiting.
            try:
                self._write_recovery_markers()
                self._apply_pending_flushes()
            except Exception:
                logger.exception("qa routing final flush failed")

    def _consume_fragment(self, case_id: str, fragment_id: str) -> None:
        with self.session_factory() as db:
            builder = QAUnitBuilder(db, idle_close_seconds=self.idle_close_seconds)
            closed_ids = builder.consume_fragment(case_id, fragment_id)
            db.commit()
        for qa_unit_id in closed_ids:
            self._route_unit(qa_unit_id)

    def _recover_session(self, case_id: str, session_id: str) -> None:
        closed_ids: list[str] = []
        with self.session_factory() as db:
            builder = QAUnitBuilder(db, idle_close_seconds=self.idle_close_seconds)
            for fragment in asr_repo.list_unassigned_for_session(db, case_id, session_id):
                closed_ids.extend(builder.consume_fragment(case_id, fragment.id))
            db.commit()
        for qa_unit_id in dict.fromkeys(closed_ids):
            self._route_unit(qa_unit_id)

    def _recover_active_sessions(self) -> None:
        with self.session_factory() as db:
            pairs = list(db.execute(
                select(ASRCaptureSession.case_id, ASRCaptureSession.interrogation_session_id)
                .where(
                    ASRCaptureSession.status == "CAPTURING",
                    ASRCaptureSession.interrogation_session_id.is_not(None),
                )
                .distinct()
            ))
        for case_id, session_id in pairs:
            if session_id:
                self._recover_session(str(case_id), str(session_id))

    def _apply_pending_flushes(self) -> None:
        with self._state_lock:
            pending = list(self._pending_flushes)
        for case_id, session_id in pending:
            self._recover_session(case_id, session_id)
            with self.session_factory() as db:
                builder = QAUnitBuilder(db, idle_close_seconds=self.idle_close_seconds)
                closed_ids = builder.flush_session(case_id, session_id)
                db.commit()
            for qa_unit_id in closed_ids:
                self._route_unit(qa_unit_id)
            with self._state_lock:
                self._pending_flushes.discard((case_id, session_id))

    def _close_idle(self) -> None:
        with self.session_factory() as db:
            builder = QAUnitBuilder(db, idle_close_seconds=self.idle_close_seconds)
            closed_ids = builder.close_idle(now=datetime.now(timezone.utc))
            db.commit()
        for qa_unit_id in closed_ids:
            self._route_unit(qa_unit_id)

    def _route_unit(self, qa_unit_id: str) -> None:
        with self.session_factory() as db:
            unit = qa_repo.get(db, qa_unit_id)
            if unit.status in {"APPLIED", "IGNORED"}:
                return
            if unit.status == "NEEDS_REVIEW":
                payload = qa_unit_dict(unit)
                session_id = unit.session_id
                db.commit()
            else:
                if unit.status not in {"CLOSED", "ROUTING"}:
                    return
                qa_repo.mark_routing(db, unit)
                db.commit()
                decision = FormalRecordRouter(db, ai_supervisor=self.ai_supervisor).route(unit.id)
                try:
                    FormalRecordRoutingService(db).apply_auto(unit.id, decision)
                    payload = qa_unit_dict(unit)
                    session_id = unit.session_id
                    applied = unit.status == "APPLIED"
                    db.commit()
                except Exception:
                    db.rollback()
                    logger.exception("formal routing application failed for qa unit %s", qa_unit_id)
                    fallback = FormalRecordRouteDecision(
                        classification=RouteClass.NEEDS_REVIEW,
                        target_question_id=None,
                        formal_question=None,
                        formal_answer=None,
                        confidence=None,
                        candidate_question_ids=(),
                        reason_code="ROUTING_APPLICATION_FAILED",
                        model_id=decision.model_id,
                    )
                    unit = qa_repo.get(db, qa_unit_id)
                    FormalRecordRoutingService(db).apply_auto(unit.id, fallback)
                    payload = qa_unit_dict(unit)
                    session_id = unit.session_id
                    applied = False
                    db.commit()
                if session_id:
                    self.publish_event(session_id, "QA_UNIT_UPDATED", payload)
                    if applied:
                        self.publish_event(
                            session_id,
                            "FORMAL_RECORD_UPDATED",
                            {"qaUnitId": qa_unit_id, "targetQuestionId": unit.target_question_id},
                        )
                return

        if session_id:
            self.publish_event(session_id, "QA_UNIT_UPDATED", payload)

    def _write_recovery_markers(self) -> None:
        with self._state_lock:
            case_ids = list(self._recovery_markers)
            self._recovery_markers.clear()
        if not case_ids:
            return
        with self.session_factory() as db:
            for case_id in case_ids:
                audit_repo.add(
                    db,
                    case_id=case_id,
                    action="QA_ROUTING_RECOVERY_REQUIRED",
                    target_type="CASE",
                    target_id=case_id,
                    detail={"reason": "QUEUE_FULL", "recovery": "PERSISTED_FRAGMENT_SCAN"},
                )
            db.commit()
'''
write_new("linux/backend/app/services/qa_routing_coordinator.py", coordinator)

# Runtime feature flag and idle close setting.
replace_once(
    "linux/backend/app/runtime_settings.py",
    '    audio_input_mode: str = "ALSA"\n\n    data_dir: Path = Path("/var/lib/suspect-interrogation")',
    '    audio_input_mode: str = "ALSA"\n    formal_routing_mode: str = "legacy"\n    qa_idle_close_seconds: float = 4.0\n\n    data_dir: Path = Path("/var/lib/suspect-interrogation")',
)
replace_once(
    "linux/backend/app/runtime_settings.py",
    '    @property\n    def cors_origins_list(self) -> list[str]:',
    '    @field_validator("formal_routing_mode")\n    @classmethod\n    def validate_formal_routing_mode(cls, value: str) -> str:\n        normalized = str(value or "legacy").strip().lower()\n        if normalized not in {"legacy", "qwen"}:\n            raise ValueError("formal_routing_mode must be legacy or qwen")\n        return normalized\n\n    @field_validator("qa_idle_close_seconds")\n    @classmethod\n    def validate_qa_idle_close_seconds(cls, value: float) -> float:\n        seconds = float(value)\n        if seconds <= 0:\n            raise ValueError("qa_idle_close_seconds must be positive")\n        return seconds\n\n    @property\n    def cors_origins_list(self) -> list[str]:',
)

# Capture service sink seam: realtime capture publishes raw ASR first, then only
# enqueues IDs in qwen mode. Legacy projection remains the default fallback.
replace_once(
    "linux/backend/app/services/asr_capture_service.py",
    'PublishEvent = Callable[[str, str, dict[str, Any]], None]\nCalibrationResolver = Callable[[Any], ResolvedSpeakerCalibration]\n',
    'PublishEvent = Callable[[str, str, dict[str, Any]], None]\nFragmentSink = Callable[[str, str], None]\nCaptureFinishedSink = Callable[[str, str], None]\nCalibrationResolver = Callable[[Any], ResolvedSpeakerCalibration]\n',
)
replace_once(
    "linux/backend/app/services/asr_capture_service.py",
    '        read_timeout: float = 0.2,\n        calibration_resolver: CalibrationResolver | None = None,\n    ) -> None:',
    '        read_timeout: float = 0.2,\n        calibration_resolver: CalibrationResolver | None = None,\n        fragment_sink: FragmentSink | None = None,\n        capture_finished_sink: CaptureFinishedSink | None = None,\n    ) -> None:',
)
replace_once(
    "linux/backend/app/services/asr_capture_service.py",
    '        self.read_timeout = max(0.001, float(read_timeout))\n        self.calibration_resolver = calibration_resolver\n',
    '        self.read_timeout = max(0.001, float(read_timeout))\n        self.calibration_resolver = calibration_resolver\n        self.fragment_sink = fragment_sink\n        self.capture_finished_sink = capture_finished_sink\n',
)
replace_once(
    "linux/backend/app/services/asr_capture_service.py",
    '            try:\n                self._finish_capture_row(runtime.capture_session_id)\n            except Exception as exc:\n                if failure is None:\n                    failure = exc\n\n            with self._lock:',
    '            try:\n                self._finish_capture_row(runtime.capture_session_id)\n            except Exception as exc:\n                if failure is None:\n                    failure = exc\n            if self.capture_finished_sink is not None:\n                try:\n                    self.capture_finished_sink(runtime.case_id, runtime.interrogation_session_id)\n                except Exception:\n                    logger.exception("capture finished sink failed for case %s", runtime.case_id)\n\n            with self._lock:',
)
replace_once(
    "linux/backend/app/services/asr_capture_service.py",
    '        self.publish_event(runtime.interrogation_session_id, "ASR_FRAGMENT", payload)\n        try:\n            with self.session_factory() as projection_db:\n                InterrogationProjectionService(projection_db).process_fragment(runtime.case_id, fragment_id)\n                projection_db.commit()\n        except Exception:\n            logger.exception("formal interrogation projection failed for fragment %s", fragment_id)\n',
    '        self.publish_event(runtime.interrogation_session_id, "ASR_FRAGMENT", payload)\n        if self.fragment_sink is not None:\n            try:\n                self.fragment_sink(runtime.case_id, fragment_id)\n            except Exception:\n                # The ASR row is already committed. Qwen mode recovery scans\n                # persisted unassigned fragments, so never fall back to legacy\n                # projection or block the capture thread here.\n                logger.exception("qa fragment sink failed for fragment %s", fragment_id)\n            return\n        try:\n            with self.session_factory() as projection_db:\n                InterrogationProjectionService(projection_db).process_fragment(runtime.case_id, fragment_id)\n                projection_db.commit()\n        except Exception:\n            logger.exception("formal interrogation projection failed for fragment %s", fragment_id)\n',
)

# Propagate sink seam to both ALSA and browser-backed concrete capture services.
replace_once(
    "linux/backend/app/services/source_aware_asr_capture_service.py",
    '        read_timeout: float = 0.2,\n        calibration_resolver_factory: CalibrationResolverFactory | None = None,\n    ) -> None:',
    '        read_timeout: float = 0.2,\n        calibration_resolver_factory: CalibrationResolverFactory | None = None,\n        fragment_sink: Callable[[str, str], None] | None = None,\n        capture_finished_sink: Callable[[str, str], None] | None = None,\n    ) -> None:',
)
replace_once(
    "linux/backend/app/services/source_aware_asr_capture_service.py",
    '        self.read_timeout = float(read_timeout)\n        self._lock = threading.RLock()\n',
    '        self.read_timeout = float(read_timeout)\n        self.fragment_sink = fragment_sink\n        self.capture_finished_sink = capture_finished_sink\n        self._lock = threading.RLock()\n',
)
replace_once(
    "linux/backend/app/services/source_aware_asr_capture_service.py",
    '                read_timeout=read_timeout,\n                calibration_resolver=resolver,\n            )',
    '                read_timeout=read_timeout,\n                calibration_resolver=resolver,\n                fragment_sink=fragment_sink,\n                capture_finished_sink=capture_finished_sink,\n            )',
)

# Application lifecycle: qwen mode owns one coordinator and injects only its
# non-blocking sinks into capture. Legacy remains untouched by default.
replace_once(
    "linux/backend/app/main.py",
    'from app.services.source_aware_asr_capture_service import SourceAwareAsrCaptureService\n',
    'from app.services.source_aware_asr_capture_service import SourceAwareAsrCaptureService\nfrom app.services.qa_routing_coordinator import QARoutingCoordinator\n',
)
replace_once(
    "linux/backend/app/main.py",
    '        supervisor = ai_supervisor or _build_supervisor()\n        app.state.ai_supervisor = supervisor\n        capture_service = SourceAwareAsrCaptureService(\n',
    '        supervisor = ai_supervisor or _build_supervisor()\n        app.state.ai_supervisor = supervisor\n        routing_coordinator = None\n        if settings.formal_routing_mode == "qwen":\n            routing_coordinator = QARoutingCoordinator(\n                session_factory=app.state.session_factory,\n                ai_supervisor=supervisor,\n                publish_event=publish_asr_event,\n                idle_close_seconds=settings.qa_idle_close_seconds,\n            )\n            routing_coordinator.start()\n        app.state.qa_routing_coordinator = routing_coordinator\n        capture_service = SourceAwareAsrCaptureService(\n',
)
replace_once(
    "linux/backend/app/main.py",
    '            calibration_resolver_factory=runtime_calibration_resolver_factory,\n        )\n',
    '            calibration_resolver_factory=runtime_calibration_resolver_factory,\n            fragment_sink=None if routing_coordinator is None else routing_coordinator.enqueue_fragment,\n            capture_finished_sink=None if routing_coordinator is None else routing_coordinator.flush_capture,\n        )\n',
)
replace_once(
    "linux/backend/app/main.py",
    '        finally:\n            capture_service.shutdown()\n            if manager is not None:\n',
    '        finally:\n            capture_service.shutdown()\n            if routing_coordinator is not None:\n                routing_coordinator.shutdown()\n            if manager is not None:\n',
)
replace_once(
    "linux/backend/app/main.py",
    '    app.state.asr_capture_service = None\n    app.state.browser_audio_input = browser_audio_input\n',
    '    app.state.asr_capture_service = None\n    app.state.qa_routing_coordinator = None\n    app.state.browser_audio_input = browser_audio_input\n',
)
