from __future__ import annotations

from collections.abc import Iterable
from typing import Any

from ..errors import BackendUnavailableError
from ..interfaces import ASREngine, LLMEngine, OCREngine
from ..registry import ModelSpec
from ..types import AIStreamChunk, AITextResult, ASRResult, EngineState, OCRResult


class _AdapterShell:
    """Stable plug-in seam for device-specific SDK adapters.

    Real model weights and vendor SDK bindings are intentionally not bundled.
    A backend adapter can replace these methods without changing supervisor,
    API, registry, IPC, lifecycle, cancellation, or health contracts.
    """

    def __init__(self, spec: ModelSpec, model_dir: str):
        self.spec = spec
        self.model_id = spec.model_id
        self.model_dir = model_dir
        self._state = EngineState.STOPPED

    def load(self) -> None:
        self._state = EngineState.ERROR
        raise BackendUnavailableError(
            f"Backend adapter {self.spec.backend!r} is not installed for {self.model_id}",
            details={"backend": self.spec.backend, "model_dir": self.model_dir},
        )

    def health(self) -> EngineState:
        return self._state

    def cancel(self) -> None:
        pass

    def unload(self) -> None:
        self._state = EngineState.STOPPED

    def _unavailable(self):
        raise BackendUnavailableError(
            f"Backend adapter {self.spec.backend!r} is not installed",
            details={"backend": self.spec.backend, "model_id": self.model_id},
        )


class RealLLMEngine(_AdapterShell, LLMEngine):
    def generate(self, prompt: str, *, session_id: str, options: dict[str, Any] | None = None) -> AITextResult:
        self._unavailable()

    def stream(self, prompt: str, *, session_id: str, options: dict[str, Any] | None = None) -> Iterable[AIStreamChunk]:
        self._unavailable()
        yield  # pragma: no cover


class RealASREngine(_AdapterShell, ASREngine):
    def transcribe(self, audio: bytes, *, session_id: str, options: dict[str, Any] | None = None) -> ASRResult:
        self._unavailable()

    def stream(self, audio: bytes, *, session_id: str, options: dict[str, Any] | None = None) -> Iterable[ASRResult]:
        self._unavailable()
        yield  # pragma: no cover


class RealOCREngine(_AdapterShell, OCREngine):
    def recognize(self, image: bytes, *, capability: str, session_id: str, options: dict[str, Any] | None = None) -> OCRResult:
        self._unavailable()
