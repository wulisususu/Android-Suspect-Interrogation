from fastapi import APIRouter

router = APIRouter(prefix="/identity", tags=["identity"])

@router.get("/status")
def identity_status():
    return {
        "device": "idcard_reader",
        "status": "waiting"
    }

@router.post("/read")
def read_identity():
    # Hardware layer will be connected later
    return {
        "status": "pending",
        "message": "waiting for idcard hardware adapter"
    }
