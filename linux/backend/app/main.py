from fastapi import FastAPI
from .websocket.manager import router as websocket_router

app = FastAPI(
    title="Linux Suspect Interrogation API",
    version="0.1.0"
)

app.include_router(websocket_router)


@app.get("/health")
def health():
    return {"status": "ok", "platform": "linux"}
