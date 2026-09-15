from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session

from app.api.deps import get_db
from app.api.responses import envelope
from app.api.schemas import ActorRequest, DocumentSignRequest, SignatureRequest
from app.domain.errors import DomainError
from app.services.document_finalization_service import DocumentFinalizationService
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


@router.post("/cases/{case_id}/document/finalize")
def finalize_document(
    case_id: str,
    request: Request,
    body: ActorRequest | None = None,
    db: Session = Depends(get_db),
):
    capture_service = getattr(request.app.state, "asr_capture_service", None)
    if capture_service is None:
        raise DomainError("ASR_CAPTURE_UNAVAILABLE", "语音采集服务未配置，不能结束并冻结笔录", 503)
    actor_id = body.actor_id if body else None
    return envelope(
        DocumentFinalizationService(
            db,
            capture_service=capture_service,
            routing_coordinator=getattr(request.app.state, "qa_routing_coordinator", None),
        ).finalize(case_id, actor_id),
        "审讯已结束，笔录已冻结",
    )


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
