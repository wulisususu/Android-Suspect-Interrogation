from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter(prefix="/signature", tags=["signature"])

class SignatureRequest(BaseModel):
    session_id: str
    data: str

@router.post("")
def submit_signature(req: SignatureRequest):
    return {
        "session_id": req.session_id,
        "status": "saved"
    }
