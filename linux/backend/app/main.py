from pathlib import Path

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

from .api.cases import router as cases_router
from .api.identity import router as identity_router
from .api.interrogation import router as interrogation_router
from .api.signature import router as signature_router
from .health import router as health_router
from .runtime_settings import RuntimeSettings
from .websocket.manager import router as websocket_router


settings = RuntimeSettings()

app = FastAPI(
    title="Linux Suspect Interrogation API",
    version="0.2.0",
    debug=settings.debug,
)

if settings.cors_origins_list:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.cors_origins_list,
        allow_credentials=False,
        allow_methods=["GET", "POST", "PUT", "PATCH", "DELETE"],
        allow_headers=["Accept", "Authorization", "Content-Type"],
    )

app.include_router(health_router)
app.include_router(websocket_router)
app.include_router(cases_router, prefix="/api/v1")
app.include_router(identity_router, prefix="/api/v1")
app.include_router(interrogation_router, prefix="/api/v1")
app.include_router(signature_router, prefix="/api/v1")


@app.get("/health")
def legacy_health():
    """Backward-compatible liveness endpoint for older kiosk clients."""
    return {"status": "ok", "platform": "linux"}


# Mount the production Vue bundle last so REST/WebSocket/health routes keep
# precedence. Development remains Vite-driven when dist does not exist.
web_dist = Path(settings.web_dist_dir)
if web_dist.is_dir():
    app.mount("/", StaticFiles(directory=web_dist, html=True), name="webapp")
