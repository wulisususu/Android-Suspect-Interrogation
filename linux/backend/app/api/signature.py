from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.api.deps import get_db
from app.api.responses import envelope
from app.api.schemas import ActorRequest, DocumentSignRequest, SignatureRequest
from app.services.document_service import DocumentService

router = APIRouter(tags=["documents"])


@router.get("/cases/{case_id}/document")
def document_signing_state(case_id: str, db: Session = Depends(get_db)):
    return envelope(DocumentService(db).signing_state(case_id))


@router.get("/cases/{case_id}/document/status")
def document_status(case_id: str, db: Session = Depends(get_db)):
    return envelope(DocumentService(db).status(case_id))


@router.post("/cases/{case_id}/document/freeze")
def freeze_document(case_id: str, body: ActorRequest | None = None, db: Session = Depends(get_db)):
    actor_id = body.actor_id if body else None
    return envelope(DocumentService(db).freeze(case_id, actor_id), "笔录已冻结")


@router.post("/cases/{case_id}/document/sign")
def sign_document(case_id: str, body: DocumentSignRequest, db: Session = Depends(get_db)):
    return envelope(
        DocumentService(db).sign(
            case_id,
            signer_role=body.signer_role,
            signer_name=body.signer_name,
            image_data=body.image_data,
            strokes_json=body.strokes_json,
            actor_id=body.actor_id,
        ),
        "签名已保存",
    )


@router.get("/cases/{case_id}/signatures")
def list_signatures(case_id: str, db: Session = Depends(get_db)):
    return envelope(DocumentService(db).list_signatures(case_id))


@router.post("/cases/{case_id}/signatures")
def create_signature(case_id: str, body: SignatureRequest, db: Session = Depends(get_db)):
    return envelope(
        DocumentService(db).sign(
            case_id,
            signer_role=body.signer_role,
            signer_name=body.signer_name,
            image_data=body.image_data,
            strokes_json=body.strokes_json,
            actor_id=body.actor_id,
        ),
        "签名已保存",
    )


@router.post("/cases/{case_id}/report/generated")
def report_generated(case_id: str, body: ActorRequest | None = None, db: Session = Depends(get_db)):
    actor_id = body.actor_id if body else None
    return envelope(DocumentService(db).mark_report_generated(case_id, actor_id), "报告状态已更新")
