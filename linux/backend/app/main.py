import asyncio

from fastapi import FastAPI

from hardware.factory import create_device_manager
from .websocket.manager import broadcast_hardware_event, router as websocket_router
from .api.cases import router as cases_router
from .api.identity import router as identity_router
from .api.interrogation import router as interrogation_router
from .api.signature import router as signature_router

app = FastAPI(
    title="Linux Suspect Interrogation API",
    version="0.1.0",
)

hardware_manager = create_device_manager()
_hardware_event_loop = None


def _publish_hardware_event(event) -> None:
    loop = _hardware_event_loop
    if loop is None or not loop.is_running():
        return
    payload = event.to_dict() if hasattr(event, "to_dict") else dict(event)

    def schedule() -> None:
        asyncio.create_task(broadcast_hardware_event(payload))

    loop.call_soon_threadsafe(schedule)


if hardware_manager.device_monitor is not None:
    hardware_manager.device_monitor.subscribe(_publish_hardware_event)

app.include_router(websocket_router)
app.include_router(cases_router, prefix="/api/v1")
app.include_router(identity_router, prefix="/api/v1")
app.include_router(interrogation_router, prefix="/api/v1")
app.include_router(signature_router, prefix="/api/v1")


@app.on_event("startup")
async def hardware_startup() -> None:
    global _hardware_event_loop
    _hardware_event_loop = asyncio.get_running_loop()
    hardware_manager.open_all(strict=False)
    hardware_manager.start_monitor()


@app.on_event("shutdown")
async def hardware_shutdown() -> None:
    hardware_manager.close_all()


@app.get("/health")
def health():
    return {
        "status": "ok",
        "platform": "linux",
        "hardware_mode": hardware_manager.mode,
        "hardware": hardware_manager.capability_report(),
    }
