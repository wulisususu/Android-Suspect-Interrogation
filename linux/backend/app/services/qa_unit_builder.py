from __future__ import annotations

from datetime import datetime, timedelta, timezone

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.database.models import ASRFragment, QAUnit, QAUnitFragment
from app.domain.errors import DomainError
from app.repositories import asr_fragments as asr_repo
from app.repositories import qa_units as qa_repo


OFFICER_SPEAKERS = {"INTERROGATOR", "RECORDER", "OFFICER_FALLBACK"}
_ASSIGNABLE_SPEAKERS = OFFICER_SPEAKERS | {"SUSPECT"}


def _aware(value: datetime) -> datetime:
    return value if value.tzinfo is not None else value.replace(tzinfo=timezone.utc)


class QAUnitBuilder:
    """Deterministically group final speaker-attributed ASR fragments into QA units.

    The builder performs no semantic question classification. Natural officer prompts
    are grouped solely from speaker order so Qwen receives the complete real exchange.
    """

    def __init__(self, db: Session, *, idle_close_seconds: float = 4.0):
        self.db = db
        self.idle_close_seconds = max(0.0, float(idle_close_seconds))

    def consume_fragment(self, case_id: str, fragment_id: str) -> list[str]:
        fragment = asr_repo.get_fragment(self.db, fragment_id)
        if fragment.case_id != case_id:
            raise DomainError("ASR_FRAGMENT_NOT_FOUND", "ASR 临时片段不存在", 404)
        if self._assigned(fragment.id):
            return []

        speaker = str(fragment.speaker or "UNKNOWN").upper()
        text = str(fragment.edited_text or fragment.raw_text or "").strip()
        if speaker not in _ASSIGNABLE_SPEAKERS or not text:
            return []

        capture = asr_repo.get_capture_session(self.db, fragment.capture_session_id)
        session_id = capture.interrogation_session_id
        if not session_id:
            return []

        active = qa_repo.active_for_session(self.db, case_id, session_id)
        closed_ids: list[str] = []

        if speaker in OFFICER_SPEAKERS:
            if active is not None and self._has_answer(active):
                self._close(active)
                closed_ids.append(active.id)
                active = None
            if active is None:
                active = qa_repo.create_open(
                    self.db,
                    case_id=case_id,
                    session_id=session_id,
                    started_at=self._fragment_time(fragment, start=True),
                )
            qa_repo.append_fragment(
                self.db,
                active,
                fragment_id=fragment.id,
                role="QUESTION",
                position=self._next_position(active),
            )
            return closed_ids

        if active is None:
            orphan = qa_repo.create_open(
                self.db,
                case_id=case_id,
                session_id=session_id,
                started_at=self._fragment_time(fragment, start=True),
            )
            qa_repo.append_fragment(
                self.db,
                orphan,
                fragment_id=fragment.id,
                role="ANSWER",
                position=1,
            )
            question_text, answer_text = self._texts(orphan)
            qa_repo.close(
                self.db,
                orphan,
                raw_question_text=question_text,
                raw_answer_text=answer_text,
                ended_at=self._fragment_time(fragment),
            )
            orphan.classification = "NEEDS_REVIEW"
            orphan.reason_code = "ORPHAN_ANSWER"
            orphan.status = "NEEDS_REVIEW"
            self.db.flush()
            return [orphan.id]

        qa_repo.append_fragment(
            self.db,
            active,
            fragment_id=fragment.id,
            role="ANSWER",
            position=self._next_position(active),
        )
        return []

    def close_idle(self, *, now: datetime) -> list[str]:
        now = _aware(now)
        open_units = list(self.db.scalars(select(QAUnit).where(QAUnit.status == "OPEN")))
        closed: list[str] = []
        for unit in open_units:
            if not self._has_answer(unit):
                continue
            last = self._last_fragment(unit)
            if last is None:
                continue
            if now - self._fragment_time(last) < timedelta(seconds=self.idle_close_seconds):
                continue
            self._close(unit)
            closed.append(unit.id)
        return closed

    def flush_session(self, case_id: str, session_id: str) -> list[str]:
        active = qa_repo.active_for_session(self.db, case_id, session_id)
        if active is None:
            return []
        self._close(active)
        return [active.id]

    def _assigned(self, fragment_id: str) -> bool:
        return self.db.scalar(
            select(QAUnitFragment.fragment_id).where(QAUnitFragment.fragment_id == fragment_id).limit(1)
        ) is not None

    def _links(self, unit: QAUnit) -> list[QAUnitFragment]:
        return list(
            self.db.scalars(
                select(QAUnitFragment)
                .where(QAUnitFragment.qa_unit_id == unit.id)
                .order_by(QAUnitFragment.position.asc())
            )
        )

    def _next_position(self, unit: QAUnit) -> int:
        links = self._links(unit)
        return (links[-1].position + 1) if links else 1

    def _has_answer(self, unit: QAUnit) -> bool:
        return any(link.role == "ANSWER" for link in self._links(unit))

    def _last_fragment(self, unit: QAUnit) -> ASRFragment | None:
        links = self._links(unit)
        return asr_repo.get_fragment(self.db, links[-1].fragment_id) if links else None

    def _texts(self, unit: QAUnit) -> tuple[str, str]:
        question: list[str] = []
        answer: list[str] = []
        for link in self._links(unit):
            fragment = asr_repo.get_fragment(self.db, link.fragment_id)
            text = str(fragment.edited_text or fragment.raw_text or "").strip()
            if not text:
                continue
            (question if link.role == "QUESTION" else answer).append(text)
        return " ".join(question), " ".join(answer)

    def _close(self, unit: QAUnit) -> None:
        question_text, answer_text = self._texts(unit)
        last = self._last_fragment(unit)
        ended_at = self._fragment_time(last) if last is not None else _aware(unit.started_at)
        qa_repo.close(
            self.db,
            unit,
            raw_question_text=question_text,
            raw_answer_text=answer_text,
            ended_at=ended_at,
        )

    def _fragment_time(self, fragment: ASRFragment, *, start: bool = False) -> datetime:
        capture = asr_repo.get_capture_session(self.db, fragment.capture_session_id)
        base = _aware(capture.started_at)
        offset_ms = fragment.started_at_ms if start else fragment.ended_at_ms
        return base + timedelta(milliseconds=int(offset_ms))
