from __future__ import annotations

import asyncio
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.ai.registry import ModelRegistry
from app.ai.settings import AISettings
from app.ai.supervisor import AISupervisor
from app.ai_gateway.mock import DeterministicAIGateway
from app.api.ai_runtime import router as ai_router
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


def _build_supervisor() -> AISupervisor:
    settings = AISettings.from_env()
    registry = ModelRegistry.load(settings.registry_path, settings.model_root).with_backend_overrides(
        {"asr": settings.asr_backend, "ocr": settings.ocr_backend, "llm": settings.llm_backend}
    )
    return AISupervisor(
        registry,
        mode=settings.mode,
        request_timeout=settings.request_timeout,
        idle_unload_seconds=settings.idle_unload_seconds,
        memory_budget_mb=settings.memory_budget_mb,
    )


def create_app(
    database_url: str | None = None,
    hardware_gateway=None,
    ai_gateway=None,
    hardware_manager=None,
    ai_supervisor: AISupervisor | None = None,
) -> FastAPI:
    engine = make_engine(database_url)
    init_database(engine)

    manager = hardware_manager
    if hardware_gateway is None:
        manager = manager or create_device_manager()
        hardware_gateway = LinuxHardwareGateway(manager)

    websocket_manager = ConnectionManager()
    event_loop: dict[str, asyncio.AbstractEventLoop | None] = {"loop": None}

    async def publish_hardware_event_async(payload: dict) -> None:
        await websocket_manager.broadcast_all("DEVICE_EVENT", payload)

    def publish_hardware_event(event) -> None:
        loop = event_loop["loop"]
        if loop is None or not loop.is_running():
            return
        payload = event.to_dict() if hasattr(event, "to_dict") else dict(event)
        loop.call_soon_threadsafe(lambda: asyncio.create_task(publish_hardware_event_async(payload)))

    if manager is not None and manager.device_monitor is not None:
        manager.device_monitor.subscribe(publish_hardware_event)

    @asynccontextmanager
    async def lifespan(app: FastAPI):
        event_loop["loop"] = asyncio.get_running_loop()
        supervisor = ai_supervisor or _build_supervisor()
        app.state.ai_supervisor = supervisor
        if manager is not None:
            manager.open_all(strict=False)
            manager.start_monitor()
        try:
            yield
        finally:
            if manager is not None:
                try:
                    manager.stop_monitor()
                finally:
                    manager.close_all()
            event_loop["loop"] = None
            supervisor.shutdown()

    app = FastAPI(title="Linux Suspect Interrogation API", version="1.0.0", lifespan=lifespan)
    app.state.engine = engine
    app.state.session_factory = make_session_factory(engine)
    app.state.hardware_manager = manager
    app.state.hardware_gateway = hardware_gateway
    # Legacy deterministic gateway remains only for the existing interrogation
    # USER_TEXT transport. Formal model execution lives in AISupervisor.
    app.state.ai_gateway = ai_gateway or DeterministicAIGateway()
    app.state.websocket_manager = websocket_manager

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
    app.include_router(ai_router, prefix="/api/v1")
    app.include_router(compat_router)
    app.include_router(websocket_router)

    @app.get("/health")
    def health():
        hardware = app.state.hardware_gateway.status()
        return envelope({"status": "ok", "platform": "linux", "hardware": hardware})

    return app


app = create_app()
