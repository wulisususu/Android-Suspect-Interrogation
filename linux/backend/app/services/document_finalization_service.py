from __future__ import annotations

from typing import Any

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import QAUnit
from app.database.session import begin_sqlite_immediate
from app.domain.enums import WorkflowState
from app.domain.errors import DomainError
from app.repositories import cases as case_repo
from app.repositories import sessions as session_repo
from app.services.document_service import DocumentService
from app.services.session_service import SessionService


_UNRESOLVED_QA_STATUSES = {"OPEN", "CLOSED", "ROUTING", "NEEDS_REVIEW"}


class DocumentFinalizationService:
    """Finish one interrogation only after its final speech routing is durable."""

    def __init__(
        self,
        db: Session,
        *,
        capture_service: Any,
        routing_coordinator: Any | None,
        drain_timeout: float = 60.0,
    ) -> None:
        self.db = db
        self.capture_service = capture_service
        self.routing_coordinator = routing_coordinator
        self.drain_timeout = max(1.0, float(drain_timeout))

    def finalize(self, case_id: str, actor_id: str | None = None) -> dict:
        case_id = str(case_id).strip()
        if not case_id:
            raise DomainError("CASE_ID_REQUIRED", "案件编号不能为空", 400)

        case = case_repo.get(self.db, case_id)
        session = session_repo.active_for_case(self.db, case_id) or session_repo.latest_for_case(self.db, case_id)
        session_id = None if session is None else session.id
        self.db.rollback()

        status = self.capture_service.status(case_id)
        if status.get("active"):
            self.capture_service.stop(case_id)

        if self.routing_coordinator is not None and session_id is not None:
            try:
                self.routing_coordinator.drain_capture(
                    case_id,
                    session_id,
                    timeout=self.drain_timeout,
                )
            except TimeoutError as exc:
                raise DomainError(
                    "QA_ROUTING_DRAIN_TIMEOUT",
                    "正式问答仍在整理，请稍后再次结束并冻结",
                    504,
                ) from exc
            except RuntimeError as exc:
                raise DomainError(
                    "QA_ROUTING_UNAVAILABLE",
                    "正式问答整理服务不可用，不能冻结笔录",
                    503,
                ) from exc

        begin_sqlite_immediate(self.db)
        try:
            case = case_repo.get(self.db, case_id)
            state = WorkflowState(case.workflow_state)
            active = session_repo.active_for_case(self.db, case_id)
            latest = session_repo.latest_for_case(self.db, case_id)
            target_session = active or latest
            if target_session is None:
                raise DomainError("SESSION_NOT_ACTIVE", "当前没有可结束的审讯", 409)

            unresolved = list(self.db.scalars(
                select(QAUnit).where(
                    QAUnit.case_id == case_id,
                    QAUnit.session_id == target_session.id,
                    QAUnit.status.in_(_UNRESOLVED_QA_STATUSES),
                )
            ))
            if unresolved:
                raise DomainError(
                    "FORMAL_RECORD_REVIEW_REQUIRED",
                    "仍有待处理的问答，完成处置后才能冻结笔录",
                    409,
                    data={"qa_unit_ids": [row.id for row in unresolved]},
                )

            if state in {WorkflowState.QUESTIONING, WorkflowState.PAUSED}:
                SessionService(self.db).finish(case_id, actor_id, commit=False)
            elif state != WorkflowState.SUMMARY:
                raise DomainError("DOCUMENT_FINALIZE_NOT_ALLOWED", "当前状态不可结束并冻结笔录", 409)

            result = DocumentService(self.db).freeze(case_id, actor_id, commit=False)
            self.db.commit()
            return result
        except Exception:
            self.db.rollback()
            raise
