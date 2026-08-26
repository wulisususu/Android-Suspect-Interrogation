import asyncio

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.ai_gateway.mock import DeterministicAIGateway
from app.api.cases import router as cases_router
from app.api.compat import router as compat_router
from app.api.device_events import router as device_router
from app.api.errors import install_error_handlers
from app.api.identity import router as identity_router
from app.api.interrogation import router as interrogation_router
from app.api.responses import envelope
from app.api.signature import router as signature_router
from app.database.session import init_database, make_engine, make_session_factory
from app.hardware_gateway.linux import LinuxHardwareGateway
from app.websocket.manager import ConnectionManager, router as websocket_router
from hardware.factory import create_device_manager


def create_app(
    database_url: str | None = None,
    hardware_gateway=None,
    ai_gateway=None,
    hardware_manager=None,
) -> FastAPI:
    app = FastAPI(title="Linux Suspect Interrogation API", version="1.0.0")
    engine = make_engine(database_url)
    init_database(engine)
    app.state.engine = engine
    app.state.session_factory = make_session_factory(engine)

    manager = hardware_manager
    if hardware_gateway is None:
        manager = manager or create_device_manager()
        hardware_gateway = LinuxHardwareGateway(manager)
    app.state.hardware_manager = manager
    app.state.hardware_gateway = hardware_gateway
    app.state.ai_gateway = ai_gateway or DeterministicAIGateway()
    app.state.websocket_manager = ConnectionManager()

    event_loop: dict[str, asyncio.AbstractEventLoop | None] = {"loop": None}

    def publish_hardware_event(event) -> None:
        loop = event_loop["loop"]
        if loop is None or not loop.is_running():
            return
        payload = event.to_dict() if hasattr(event, "to_dict") else dict(event)

        def schedule() -> None:
            asyncio.create_task(app.state.websocket_manager.broadcast_all("DEVICE_EVENT", payload))

        loop.call_soon_threadsafe(schedule)

    if manager is not None and manager.device_monitor is not None:
        manager.device_monitor.subscribe(publish_hardware_event)

    install_error_handlers(app)
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=False,
        allow_methods=["GET", "POST", "PUT", "PATCH", "OPTIONS"],
        allow_headers=["*"],
    )

    app.include_router(cases_router, prefix="/api/v1")
    app.include_router(identity_router, prefix="/api/v1")
    app.include_router(interrogation_router, prefix="/api/v1")
    app.include_router(signature_router, prefix="/api/v1")
    app.include_router(device_router, prefix="/api/v1")
    app.include_router(compat_router)
    app.include_router(websocket_router)

    if manager is not None:
        @app.on_event("startup")
        async def hardware_startup() -> None:
            event_loop["loop"] = asyncio.get_running_loop()
            manager.open_all(strict=False)
            manager.start_monitor()

        @app.on_event("shutdown")
        async def hardware_shutdown() -> None:
            try:
                manager.stop_monitor()
            finally:
                manager.close_all()
                event_loop["loop"] = None

    @app.get("/health")
    def health():
        hardware = app.state.hardware_gateway.status()
        return envelope({"status": "ok", "platform": "linux", "hardware": hardware})

    return app


app = create_app()
