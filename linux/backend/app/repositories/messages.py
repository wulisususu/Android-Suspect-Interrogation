from uuid import uuid4

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.database.models import Message, MessageRevision
from app.domain.errors import DomainError


def get(db: Session, case_id: str, message_id: str) -> Message:
    item = db.scalar(select(Message).where(Message.id == message_id, Message.case_id == case_id))
    if item is None:
        raise DomainError("QA_NOT_FOUND", "问答记录不存在", 404)
    return item


def list_for_case(db: Session, case_id: str, limit: int = 1000) -> list[Message]:
    return list(db.scalars(select(Message).where(Message.case_id == case_id).order_by(Message.seq.asc()).limit(limit)))


def create(db: Session, *, case_id: str, session_id: str | None, speaker: str, text: str) -> Message:
    clean = str(text or "").strip()
    if not clean:
        raise DomainError("EMPTY_MESSAGE", "问答内容不能为空", 400)
    if speaker not in {"民警", "嫌疑人"}:
        raise DomainError("INVALID_SPEAKER", "仅允许民警或嫌疑人写入正式问答", 400)
    next_seq = db.scalar(select(func.coalesce(func.max(Message.seq), 0) + 1).where(Message.case_id == case_id)) or 1
    item = Message(
        id=str(uuid4()), case_id=case_id, session_id=session_id, seq=int(next_seq),
        speaker=speaker, text=clean, mark="", confirmed=True, current_version=1,
    )
    db.add(item)
    db.flush()
    return item


def revise(
    db: Session,
    *,
    case_id: str,
    message_id: str,
    new_text: str,
    reason: str = "警官修订",
    actor_id: str | None = None,
) -> tuple[Message, MessageRevision]:
    item = get(db, case_id, message_id)
    clean = str(new_text or "").strip()
    if not clean:
        raise DomainError("EMPTY_MESSAGE", "修订内容不能为空", 400)
    if clean == item.text:
        raise DomainError("NO_MESSAGE_CHANGE", "修订内容与当前版本一致", 409)
    revision = MessageRevision(
        id=str(uuid4()),
        message_id=item.id,
        case_id=case_id,
        version=item.current_version + 1,
        old_text=item.text,
        new_text=clean,
        reason=reason,
        actor_id=actor_id,
    )
    db.add(revision)
    item.text = clean
    item.current_version = revision.version
    db.flush()
    return item, revision


def mark(db: Session, *, case_id: str, message_id: str, mark: str) -> Message:
    allowed = {"", "conflict", "confirmed", "pending", "highlight"}
    if mark not in allowed:
        raise DomainError("INVALID_MARK", "无效标记类型", 400)
    item = get(db, case_id, message_id)
    item.mark = mark
    db.flush()
    return item


def list_revisions(db: Session, *, case_id: str, message_id: str | None = None) -> list[MessageRevision]:
    stmt = select(MessageRevision).where(MessageRevision.case_id == case_id)
    if message_id:
        stmt = stmt.where(MessageRevision.message_id == message_id)
    stmt = stmt.order_by(MessageRevision.created_at.desc(), MessageRevision.version.desc())
    return list(db.scalars(stmt))
