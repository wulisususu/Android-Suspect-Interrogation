from fastapi import FastAPI
from .websocket.manager import router as websocket_router
from .api.cases import router as cases_router
from .api.identity import router as identity_router
from .api.interrogation import router as interrogation_router
from .api.signature import router as signature_router

app = FastAPI(
    title="Linux Suspect Interrogation API",
    version="0.1.0"
)

# WebSocket communication
app.include_router(websocket_router)

# REST API v1
app.include_router(cases_router, prefix="/api/v1")
app.include_router(identity_router, prefix="/api/v1")
app.include_router(interrogation_router, prefix="/api/v1")
app.include_router(signature_router, prefix="/api/v1")


@app.get("/health")
def health():
    return {"status": "ok", "platform": "linux"}
