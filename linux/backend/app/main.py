from __future__ import annotations

from contextlib import asynccontextmanager
from fastapi import FastAPI
from .ai.registry import ModelRegistry
from .ai.settings import AISettings
from .ai.supervisor import AISupervisor
from .api.ai_runtime import router as ai_router
from .api.cases import router as cases_router
from .api.identity import router as identity_router
from .api.interrogation import router as interrogation_router
from .api.signature import router as signature_router
from .websocket.manager import router as websocket_router


def _build_supervisor() -> AISupervisor:
    settings = AISettings.from_env()
    registry = ModelRegistry.load(settings.registry_path, settings.model_root).with_backend_overrides({"asr": settings.asr_backend, "ocr": settings.ocr_backend, "llm": settings.llm_backend})
    return AISupervisor(registry, mode=settings.mode, request_timeout=settings.request_timeout, idle_unload_seconds=settings.idle_unload_seconds, memory_budget_mb=settings.memory_budget_mb)


def create_app() -> FastAPI:
    @asynccontextmanager
    async def lifespan(app: FastAPI):
        app.state.ai_supervisor = _build_supervisor()
        try: yield
        finally: app.state.ai_supervisor.shutdown()
    app = FastAPI(title="Linux Suspect Interrogation API", version="0.2.0", lifespan=lifespan)
    app.include_router(websocket_router)
    app.include_router(cases_router, prefix="/api/v1")
    app.include_router(identity_router, prefix="/api/v1")
    app.include_router(interrogation_router, prefix="/api/v1")
    app.include_router(signature_router, prefix="/api/v1")
    app.include_router(ai_router, prefix="/api/v1")
    @app.get("/health")
    def health(): return {"status":"ok","platform":"linux"}
    return app

app = create_app()
