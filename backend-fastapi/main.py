from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from time import time

app = FastAPI(title="Suspect Interrogation Backend", version="0.1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/health")
def health():
    return {
        "ok": True,
        "code": "OK",
        "data": {
            "service": "suspect-interrogation-fastapi",
            "status": "ready",
            "timestamp": int(time()*1000)
        }
    }

@app.get("/api/ai/status")
def ai_status():
    return {
        "ok": True,
        "data": {
            "engine": "pending",
            "provider": "local",
            "enabled": False
        }
    }
