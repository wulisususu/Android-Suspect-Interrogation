from __future__ import annotations

from ..registry import ModelRegistry
from ..settings import AISettings
from ..supervisor import AISupervisor


class LocalModelManager:
    """Backward-compatible facade over the process-isolated LLM worker."""

    def __init__(self, supervisor: AISupervisor | None = None):
        self.backend = None
        self.model_path = None
        self._owns_supervisor = supervisor is None
        self._supervisor = supervisor or self._build_supervisor()

    @staticmethod
    def _build_supervisor() -> AISupervisor:
        settings = AISettings.from_env()
        registry = ModelRegistry.load(settings.registry_path, settings.model_root).with_backend_overrides({"asr": settings.asr_backend, "ocr": settings.ocr_backend, "llm": settings.llm_backend})
        return AISupervisor(registry, mode=settings.mode, request_timeout=settings.request_timeout, idle_unload_seconds=settings.idle_unload_seconds, memory_budget_mb=settings.memory_budget_mb)

    def load(self, model_path: str):
        self.model_path = model_path
        return self._supervisor.health()

    def generate(self, prompt: str, *, session_id: str = "legacy") -> str:
        return self._supervisor.generate(prompt, session_id=session_id).text

    def health(self):
        return self._supervisor.health()

    def close(self) -> None:
        if self._owns_supervisor:
            self._supervisor.shutdown()
