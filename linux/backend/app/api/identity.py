from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.api.deps import get_db, get_hardware
from app.api.responses import envelope
from app.api.schemas import IdentityConfirmRequest, IdentityReadRequest
from app.services.identity_service import IdentityService

router = APIRouter(prefix="/identity", tags=["identity"])


@router.get("/status")
def identity_status(db: Session = Depends(get_db), hardware=Depends(get_hardware)):
    return envelope(IdentityService(db, hardware).status())


@router.post("/read")
def read_identity(body: IdentityReadRequest | None = None, db: Session = Depends(get_db), hardware=Depends(get_hardware)):
    body = body or IdentityReadRequest()
    data = IdentityService(db, hardware).read(case_id=body.case_id, actor_id=body.actor_id)
    return envelope(data, "身份信息已读取")


@router.post("/confirm")
def confirm_identity(body: IdentityConfirmRequest, db: Session = Depends(get_db), hardware=Depends(get_hardware)):
    data = body.model_dump(exclude={"case_id", "actor_id"}, exclude_none=True)
    confirmed = IdentityService(db, hardware).confirm(case_id=body.case_id, data=data, actor_id=body.actor_id)
    return envelope(confirmed, "身份信息已核对并绑定案件")
