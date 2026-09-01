from __future__ import annotations

import os
from dataclasses import dataclass
from typing import Mapping

from speech_worker.speaker.base import (
    SpeakerBackendKey,
    SpeakerEmbeddingBackend,
    SpeakerRuntimeMode,
)


@dataclass(frozen=True, slots=True)
class SpeakerBackendSelection:
    mode: SpeakerRuntimeMode
    authoritative_backend: SpeakerBackendKey
    backends: tuple[SpeakerBackendKey, ...]


class SpeakerBackendRegistry:
    def __init__(self) -> None:
        self._backends: dict[SpeakerBackendKey, SpeakerEmbeddingBackend] = {}

    def register(self, backend: SpeakerEmbeddingBackend) -> None:
        key = SpeakerBackendKey(backend.key)
        self._backends[key] = backend

    def get(self, key: SpeakerBackendKey | str) -> SpeakerEmbeddingBackend:
        normalized = SpeakerBackendKey(key)
        return self._backends[normalized]

    def available(self) -> tuple[SpeakerBackendKey, ...]:
        return tuple(self._backends)


def resolve_speaker_backend_selection(
    environ: Mapping[str, str] | None = None,
) -> SpeakerBackendSelection:
    env = os.environ if environ is None else environ
    raw_mode = env.get("SUSPECT_SPEAKER_BACKEND", SpeakerRuntimeMode.XVECTOR.value).strip().lower()
    try:
        mode = SpeakerRuntimeMode(raw_mode)
    except ValueError as exc:
        raise ValueError(
            "SUSPECT_SPEAKER_BACKEND must be xvector, eres2net_large, or compare"
        ) from exc

    if mode is SpeakerRuntimeMode.XVECTOR:
        return SpeakerBackendSelection(
            mode=mode,
            authoritative_backend=SpeakerBackendKey.XVECTOR,
            backends=(SpeakerBackendKey.XVECTOR,),
        )

    if mode is SpeakerRuntimeMode.ERES2NET_LARGE:
        return SpeakerBackendSelection(
            mode=mode,
            authoritative_backend=SpeakerBackendKey.ERES2NET_LARGE,
            backends=(SpeakerBackendKey.ERES2NET_LARGE,),
        )

    raw_authoritative = env.get("SUSPECT_SPEAKER_AUTHORITATIVE_BACKEND", "").strip().lower()
    if not raw_authoritative:
        raise ValueError(
            "SUSPECT_SPEAKER_AUTHORITATIVE_BACKEND is required when speaker mode is compare"
        )
    try:
        authoritative = SpeakerBackendKey(raw_authoritative)
    except ValueError as exc:
        raise ValueError(
            "SUSPECT_SPEAKER_AUTHORITATIVE_BACKEND must be xvector or eres2net_large"
        ) from exc

    return SpeakerBackendSelection(
        mode=mode,
        authoritative_backend=authoritative,
        backends=(SpeakerBackendKey.XVECTOR, SpeakerBackendKey.ERES2NET_LARGE),
    )
