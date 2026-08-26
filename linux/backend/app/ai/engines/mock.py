from __future__ import annotations

import time
from collections.abc import Iterable
from typing import Any

from ..interfaces import ASREngine, LLMEngine, OCREngine
from ..types import AIStreamChunk, AITextResult, ASRResult, EngineState, OCRResult


class _MockBase:
    def __init__(self, model_id: str):
        self.model_id = model_id
        self._state = EngineState.STOPPED

    def load(self) -> None:
        self._state = EngineState.READY

    def health(self) -> EngineState:
        return self._state

    def cancel(self) -> None:
        self._state = EngineState.READY

    def unload(self) -> None:
        self._state = EngineState.STOPPED

    @staticmethod
    def _delay(options: dict[str, Any] | None) -> None:
        delay = float((options or {}).get("delay_seconds", 0.0))
        if delay > 0:
            time.sleep(delay)


class MockLLM(_MockBase, LLMEngine):
    def generate(self, prompt: str, *, session_id: str, options: dict[str, Any] | None = None) -> AITextResult:
        self._delay(options)
        text = f"[mock-llm] {prompt.strip()}"
        return AITextResult(text=text, model_id=self.model_id, session_id=session_id)

    def stream(self, prompt: str, *, session_id: str, options: dict[str, Any] | None = None) -> Iterable[AIStreamChunk]:
        self._delay(options)
        text = f"[mock-llm] {prompt.strip()}"
        if not text:
            yield AIStreamChunk(text="", model_id=self.model_id, session_id=session_id, final=True)
            return
        words = text.split(" ")
        for index, word in enumerate(words):
            suffix = " " if index < len(words) - 1 else ""
            yield AIStreamChunk(
                text=word + suffix,
                model_id=self.model_id,
                session_id=session_id,
                final=index == len(words) - 1,
            )


class MockASR(_MockBase, ASREngine):
    def transcribe(self, audio: bytes, *, session_id: str, options: dict[str, Any] | None = None) -> ASRResult:
        self._delay(options)
        try:
            text = audio.decode("utf-8").strip()
        except UnicodeDecodeError:
            text = "mock transcript"
        if not text:
            text = "mock transcript"
        return ASRResult(text=text, confidence=1.0, model_id=self.model_id, session_id=session_id)

    def stream(self, audio: bytes, *, session_id: str, options: dict[str, Any] | None = None) -> Iterable[ASRResult]:
        final = self.transcribe(audio, session_id=session_id, options=options)
        words = final.text.split()
        if not words:
            yield final
            return
        for index in range(len(words)):
            yield ASRResult(
                text=" ".join(words[: index + 1]),
                confidence=1.0,
                model_id=self.model_id,
                session_id=session_id,
                final=index == len(words) - 1,
            )


class MockOCR(_MockBase, OCREngine):
    def recognize(
        self,
        image: bytes,
        *,
        capability: str,
        session_id: str,
        options: dict[str, Any] | None = None,
    ) -> OCRResult:
        self._delay(options)
        try:
            text = image.decode("utf-8").strip()
        except UnicodeDecodeError:
            text = "mock ocr text"
        if not text:
            text = "mock ocr text"
        return OCRResult(
            text=text,
            confidence=1.0,
            fields={"mock_capability": capability},
            model_id=self.model_id,
            session_id=session_id,
        )
