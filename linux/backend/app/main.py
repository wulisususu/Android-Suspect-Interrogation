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
from app.hardware_gateway.mock import MockHardwareGateway
from app.websocket.manager import ConnectionManager, router as websocket_router


def create_app(database_url: str | None = None, hardware_gateway=None, ai_gateway=None) -> FastAPI:
    app = FastAPI(title="Linux Suspect Interrogation API", version="1.0.0")
    engine = make_engine(database_url)
    init_database(engine)
    app.state.engine = engine
    app.state.session_factory = make_session_factory(engine)
    app.state.hardware_gateway = hardware_gateway or MockHardwareGateway()
    app.state.ai_gateway = ai_gateway or DeterministicAIGateway()
    app.state.websocket_manager = ConnectionManager()

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

    @app.get("/health")
    def health():
        return envelope({"status": "ok", "platform": "linux"})

    return app


app = create_app()
