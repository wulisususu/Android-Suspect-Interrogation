from fastapi import APIRouter, Depends

from app.api.deps import get_hardware
from app.api.responses import envelope
from app.api.schemas import DeviceActionRequest
from app.services.device_service import DeviceService

router = APIRouter(prefix="/device", tags=["device"])


@router.get("/status")
def device_status(hardware=Depends(get_hardware)):
    return envelope(DeviceService(hardware).status())


@router.post("/action")
def device_action(body: DeviceActionRequest, hardware=Depends(get_hardware)):
    return envelope(DeviceService(hardware).action(body.type), "设备操作完成")
