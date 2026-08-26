from uuid import uuid4

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.database.models import DocumentSnapshot, SignatureRecord
from app.domain.errors import DomainError


def next_version(db: Session, case_id: str) -> int:
    return int(db.scalar(select(func.coalesce(func.max(DocumentSnapshot.version), 0) + 1).where(DocumentSnapshot.case_id == case_id)) or 1)


def create_snapshot(db: Session, *, case_id: str, session_id: str | None, content_json: str, content_hash: str) -> DocumentSnapshot:
    row = DocumentSnapshot(
        id=str(uuid4()), case_id=case_id, session_id=session_id, version=next_version(db, case_id),
        status="FROZEN", content_json=content_json, content_hash=content_hash,
    )
    db.add(row)
    db.flush()
    return row


def latest_snapshot(db: Session, case_id: str) -> DocumentSnapshot | None:
    return db.scalar(select(DocumentSnapshot).where(DocumentSnapshot.case_id == case_id).order_by(DocumentSnapshot.version.desc()).limit(1))


def create_signature(
    db: Session,
    *, case_id: str, session_id: str | None, snapshot_id: str | None,
    signer_role: str, signer_name: str, image_data: str, strokes_json: str,
) -> SignatureRecord:
    if not str(image_data or "").strip():
        raise DomainError("EMPTY_SIGNATURE", "签名数据不能为空", 400)
    row = SignatureRecord(
        id=str(uuid4()), case_id=case_id, session_id=session_id, snapshot_id=snapshot_id,
        signer_role=signer_role, signer_name=signer_name, image_data=image_data,
        strokes_json=strokes_json or "[]", status="SAVED",
    )
    db.add(row)
    db.flush()
    return row


def list_signatures(db: Session, case_id: str) -> list[SignatureRecord]:
    return list(db.scalars(select(SignatureRecord).where(SignatureRecord.case_id == case_id).order_by(SignatureRecord.created_at.asc())))
