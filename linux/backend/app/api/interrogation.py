from fastapi import APIRouter
from pydantic import BaseModel
import uuid

router = APIRouter(prefix="/interrogation", tags=["interrogation"])

class StartRequest(BaseModel):
    case_id: str

@router.post("/start")
def start_interrogation(req: StartRequest):
    return {
        "session_id": str(uuid.uuid4()),
        "case_id": req.case_id,
        "state": "QUESTIONING"
    }

@router.post("/stop/{session_id}")
def stop_interrogation(session_id: str):
    return {
        "session_id": session_id,
        "state": "SUMMARY"
    }
