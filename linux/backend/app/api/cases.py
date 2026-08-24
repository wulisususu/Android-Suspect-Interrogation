from fastapi import APIRouter
from pydantic import BaseModel
from datetime import datetime
import uuid

router = APIRouter(prefix="/cases", tags=["cases"])

class CaseCreateRequest(BaseModel):
    operator_id: str
    case_type: str = "suspect_interrogation"

@router.post("")
def create_case(req: CaseCreateRequest):
    return {
        "case_id": str(uuid.uuid4()),
        "operator_id": req.operator_id,
        "case_type": req.case_type,
        "created_at": datetime.utcnow().isoformat()
    }
