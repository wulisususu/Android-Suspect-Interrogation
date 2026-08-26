from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class AISettings:
    mode: str
    model_root: Path
    registry_path: Path
    request_timeout: float
    idle_unload_seconds: float
    memory_budget_mb: int
    asr_backend: str | None
    ocr_backend: str | None
    llm_backend: str | None

    @classmethod
    def from_env(cls) -> "AISettings":
        backend_dir = Path(__file__).resolve().parents[2]
        mode = os.getenv("AI_MODE", "mock").strip().lower()
        if mode not in {"mock", "real"}:
            raise ValueError("AI_MODE must be 'mock' or 'real'")
        return cls(
            mode=mode,
            model_root=Path(os.getenv("MODEL_ROOT", str(backend_dir / "models"))).expanduser(),
            registry_path=Path(os.getenv("MODEL_REGISTRY", str(backend_dir / "config/model-registry.yaml"))).expanduser(),
            request_timeout=max(0.05, float(os.getenv("AI_REQUEST_TIMEOUT", "30"))),
            idle_unload_seconds=max(0.0, float(os.getenv("AI_IDLE_UNLOAD_SECONDS", "300"))),
            memory_budget_mb=max(0, int(os.getenv("AI_MEMORY_BUDGET_MB", "6144"))),
            asr_backend=os.getenv("ASR_BACKEND"),
            ocr_backend=os.getenv("OCR_BACKEND"),
            llm_backend=os.getenv("LLM_BACKEND"),
        )
