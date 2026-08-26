from __future__ import annotations

from abc import ABC, abstractmethod
from collections.abc import Iterable
from typing import Any

from .types import AIStreamChunk, AITextResult, ASRResult, EngineState, OCRResult


class Engine(ABC):
    model_id: str

    @abstractmethod
    def load(self) -> None: ...

    @abstractmethod
    def health(self) -> EngineState: ...

    @abstractmethod
    def cancel(self) -> None: ...

    @abstractmethod
    def unload(self) -> None: ...


class LLMEngine(Engine, ABC):
    @abstractmethod
    def generate(self, prompt: str, *, session_id: str, options: dict[str, Any] | None = None) -> AITextResult: ...

    @abstractmethod
    def stream(self, prompt: str, *, session_id: str, options: dict[str, Any] | None = None) -> Iterable[AIStreamChunk]: ...


class ASREngine(Engine, ABC):
    @abstractmethod
    def transcribe(self, audio: bytes, *, session_id: str, options: dict[str, Any] | None = None) -> ASRResult: ...

    @abstractmethod
    def stream(self, audio: bytes, *, session_id: str, options: dict[str, Any] | None = None) -> Iterable[ASRResult]: ...


class OCREngine(Engine, ABC):
    @abstractmethod
    def recognize(
        self,
        image: bytes,
        *,
        capability: str,
        session_id: str,
        options: dict[str, Any] | None = None,
    ) -> OCRResult: ...


class VADEngine(Engine, ABC):
    @abstractmethod
    def speech_segments(self, pcm: bytes, *, sample_rate: int) -> list[tuple[int, int]]: ...


class SpeakerEngine(Engine, ABC):
    @abstractmethod
    def identify(self, pcm: bytes, *, session_id: str) -> dict[str, Any]: ...
