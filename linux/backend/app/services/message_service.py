from __future__ import annotations

from sqlalchemy.orm import Session

from app.domain.enums import SessionStatus
from app.domain.errors import DomainError
from app.repositories import audit as audit_repo
from app.repositories import cases as case_repo
from app.repositories import messages as message_repo
from app.repositories import sessions as session_repo
from app.services.serializers import message_dict, revision_dict


class MessageService:
    def __init__(self, db: Session):
        self.db = db

    def list(self, case_id: str, limit: int = 1000) -> list[dict]:
        case_repo.get(self.db, case_id)
        return [message_dict(row) for row in message_repo.list_for_case(self.db, case_id, limit)]

    def create(
        self,
        case_id: str,
        *,
        text: str,
        speaker: str,
        actor_id: str | None = None,
        commit: bool = True,
    ) -> dict:
        case_repo.get(self.db, case_id)
        active = session_repo.active_for_case(self.db, case_id)
        if active is None:
            raise DomainError("SESSION_NOT_ACTIVE", "请先开始审讯再记录问答", 409)
        if active.status == SessionStatus.PAUSED.value:
            raise DomainError("SESSION_PAUSED", "审讯已暂停，恢复后才能继续记录", 409)
        row = message_repo.create(self.db, case_id=case_id, session_id=active.id, speaker=speaker, text=text)
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="QA_CREATE", target_type="QA", target_id=row.id,
                       after={"seq": row.seq, "speaker": row.speaker, "text": row.text})
        if commit:
            self.db.commit()
        return message_dict(row)

    def revise(self, case_id: str, message_id: str, *, text: str, reason: str = "警官修订", actor_id: str | None = None) -> dict:
        before_row = message_repo.get(self.db, case_id, message_id)
        old = before_row.text
        row, revision = message_repo.revise(self.db, case_id=case_id, message_id=message_id, new_text=text, reason=reason, actor_id=actor_id)
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="QA_UPDATE", target_type="QA", target_id=message_id,
                       before={"text": old, "version": revision.version - 1},
                       after={"text": row.text, "version": revision.version},
                       detail={"revision_id": revision.id, "reason": reason})
        self.db.commit()
        return message_dict(row)

    def mark(self, case_id: str, message_id: str, mark: str, actor_id: str | None = None) -> dict:
        before_row = message_repo.get(self.db, case_id, message_id)
        old_mark = before_row.mark
        row = message_repo.mark(self.db, case_id=case_id, message_id=message_id, mark=mark)
        audit_repo.add(self.db, case_id=case_id, actor_id=actor_id, action="QA_MARK", target_type="QA", target_id=message_id,
                       before={"mark": old_mark}, after={"mark": row.mark})
        self.db.commit()
        return message_dict(row)

    def revisions(self, case_id: str, message_id: str | None = None) -> list[dict]:
        case_repo.get(self.db, case_id)
        return [revision_dict(row) for row in message_repo.list_revisions(self.db, case_id=case_id, message_id=message_id)]
