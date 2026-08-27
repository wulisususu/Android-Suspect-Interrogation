from __future__ import annotations

import asyncio
import os
from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

from app.ai.registry import ModelRegistry
from app.ai.settings import AISettings
from app.ai.speech.client import SpeechWorkerClient
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
from app.api.voiceprints import router as voiceprints_router
from app.database.session import init_database, make_engine, make_session_factory
from app.hardware_gateway.linux import LinuxHardwareGateway
from app.health import router as health_router
from app.runtime_settings import RuntimeSettings
from app.services.audio_capture_service import AudioCaptureService
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
        speech_socket=settings.speech_socket,
        speaker_accept_threshold=settings.speaker_accept_threshold,
        speaker_margin=settings.speaker_margin,
    )


def _database_url(database_url: str | None, settings: RuntimeSettings) -> str | None:
    if database_url is not None:
        return database_url
    # Production systemd always sets SUSPECT_DB_PATH. Development/tests retain
    # the repository-local SQLite default unless they explicitly opt into the
    # production path.
    if "SUSPECT_DB_PATH" in os.environ:
        settings.db_path.parent.mkdir(parents=True, exist_ok=True)
        return f"sqlite:///{settings.db_path}"
    return None


def create_app(
    database_url: str | None = None,
    hardware_gateway=None,
    ai_gateway=None,
    hardware_manager=None,
    ai_supervisor: AISupervisor | None = None,
    runtime_settings: RuntimeSettings | None = None,
) -> FastAPI:
    settings = runtime_settings or RuntimeSettings()
    ai_settings = AISettings.from_env()
    engine = make_engine(_database_url(database_url, settings))
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

    app = FastAPI(
        title="Linux Suspect Interrogation API",
        version="1.0.0",
        debug=settings.debug,
        lifespan=lifespan,
    )
    app.state.runtime_settings = settings
    app.state.engine = engine
    app.state.session_factory = make_session_factory(engine)
    app.state.hardware_manager = manager
    app.state.hardware_gateway = hardware_gateway
    # Construction is side-effect free: the AF_UNIX socket is opened only
    # when an enrollment or speech request is actually made.
    app.state.speech_client = SpeechWorkerClient(
        ai_settings.speech_socket,
        timeout=ai_settings.request_timeout,
    )
    # Enrollment capture is available only when this process owns the real
    # DeviceManager. Tests and alternate hardware gateways may inject a fake.
    app.state.voiceprint_capture = AudioCaptureService(manager) if manager is not None else None
    app.state.voiceprint_enrollment_context = {}
    # Compatibility only: formal offline AI execution is owned by AISupervisor.
    app.state.ai_gateway = ai_gateway or DeterministicAIGateway()
    app.state.websocket_manager = websocket_manager

    install_error_handlers(app)
    if settings.cors_origins_list:
        app.add_middleware(
            CORSMiddleware,
            allow_origins=settings.cors_origins_list,
            allow_credentials=False,
            allow_methods=["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
            allow_headers=["Accept", "Authorization", "Content-Type"],
        )

    app.include_router(health_router)
    app.include_router(cases_router, prefix="/api/v1")
    app.include_router(identity_router, prefix="/api/v1")
    app.include_router(interrogation_router, prefix="/api/v1")
    app.include_router(signature_router, prefix="/api/v1")
    app.include_router(device_router, prefix="/api/v1")
    app.include_router(ai_router, prefix="/api/v1")
    app.include_router(voiceprints_router, prefix="/api/v1")
    app.include_router(compat_router)
    app.include_router(websocket_router)

    @app.get("/health")
    def legacy_health():
        hardware = app.state.hardware_gateway.status()
        return envelope({"status": "ok", "platform": "linux", "hardware": hardware})

    # REST/WebSocket/health routes are registered first. In production the Vue
    # bundle is mounted last as the kiosk fallback; Vite remains responsible in
    # development when dist does not exist.
    web_dist = Path(settings.web_dist_dir)
    if web_dist.is_dir():
        app.mount("/", StaticFiles(directory=web_dist, html=True), name="webapp")

    return app


app = create_app()
