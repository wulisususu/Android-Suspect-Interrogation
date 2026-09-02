from __future__ import annotations

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
RouterFactory = Callable[[Any, Any], Any]


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
        router_factory: RouterFactory | None = None,
    ) -> None:
        self.session_factory = session_factory
        self.ai_supervisor = ai_supervisor
        self.publish_event = publish_event
        # Injection is intentionally limited to semantic classification. The
        # deterministic write service remains production-owned, so tests can
        # drive A/B/C/D/E without granting a fake router database write access.
        self.router_factory = router_factory or (lambda db, ai: FormalRecordRouter(db, ai_supervisor=ai))
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
                decision = self.router_factory(db, self.ai_supervisor).route(unit.id)
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
