from __future__ import annotations

from contextvars import ContextVar
from typing import Any, Mapping

from app.api.client_context import resolve_client_audio_context


AUDIO_INPUT_OVERRIDE_HEADER = "x-suspect-audio-input"
_VALID_SOURCES = {"ALSA", "BROWSER"}
_current_audio_source: ContextVar[str | None] = ContextVar("suspect_audio_source", default=None)


def normalize_audio_source(value: Any) -> str | None:
    normalized = str(value or "").strip().upper()
    return normalized if normalized in _VALID_SOURCES else None


def resolve_request_audio_source(*, headers: Mapping[str, str], client_host: str) -> str:
    explicit = normalize_audio_source(headers.get(AUDIO_INPUT_OVERRIDE_HEADER))
    if explicit is not None:
        return explicit
    context = resolve_client_audio_context(headers=headers, client_host=client_host)
    recommended = normalize_audio_source(context.get("recommendedAudioInputMode"))
    return recommended or "ALSA"


def current_request_audio_source(default: str = "ALSA") -> str:
    return normalize_audio_source(_current_audio_source.get()) or normalize_audio_source(default) or "ALSA"


class AudioSourceContextMiddleware:
    """Bind one audio-source decision to the lifetime of every HTTP request.

    The browser may explicitly send ``X-Suspect-Audio-Input`` after the page has
    resolved its URL override/client topology. Without that header, the backend
    independently derives the source from the real client address and request
    platform headers. WebSocket audio itself does not need this context: the
    preceding HTTP start call has already activated the matching input object.
    """

    def __init__(self, app) -> None:
        self.app = app

    async def __call__(self, scope, receive, send) -> None:
        if scope.get("type") != "http":
            await self.app(scope, receive, send)
            return

        headers: dict[str, str] = {}
        for raw_key, raw_value in scope.get("headers") or []:
            try:
                key = raw_key.decode("latin-1").lower()
                value = raw_value.decode("latin-1")
            except Exception:
                continue
            headers[key] = value

        client = scope.get("client")
        client_host = str(client[0]) if client else ""
        source = resolve_request_audio_source(headers=headers, client_host=client_host)
        token = _current_audio_source.set(source)
        try:
            await self.app(scope, receive, send)
        finally:
            _current_audio_source.reset(token)
