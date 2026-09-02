from __future__ import annotations

import pytest

from speech_worker.speaker.base import (
    SpeakerBackendKey,
    SpeakerEmbeddingResult,
    SpeakerRuntimeMode,
)
from speech_worker.speaker.registry import (
    SpeakerBackendRegistry,
    resolve_speaker_backend_selection,
)


class FakeBackend:
    key = SpeakerBackendKey.XVECTOR

    def extract_embedding(self, pcm: bytes, sample_rate: int) -> SpeakerEmbeddingResult:
        assert pcm == b"\x00\x00"
        assert sample_rate == 16000
        return SpeakerEmbeddingResult(
            embedding=[1.0, 0.0],
            backend_key=SpeakerBackendKey.XVECTOR,
            model_id="fixture-xvector",
            model_version="fixture-v1",
            model_fingerprint="sha256:fixture",
            latency_ms=3.25,
        )


def test_production_selection_is_eres2net_large_only(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.delenv("SUSPECT_SPEAKER_BACKEND", raising=False)
    monkeypatch.delenv("SUSPECT_SPEAKER_AUTHORITATIVE_BACKEND", raising=False)

    selection = resolve_speaker_backend_selection()

    assert selection.mode is SpeakerRuntimeMode.ERES2NET_LARGE
    assert selection.authoritative_backend is SpeakerBackendKey.ERES2NET_LARGE
    assert selection.backends == (SpeakerBackendKey.ERES2NET_LARGE,)


@pytest.mark.parametrize("legacy_mode", ("xvector", "compare"))
def test_production_selection_rejects_legacy_modes(
    legacy_mode: str, monkeypatch: pytest.MonkeyPatch
) -> None:
    monkeypatch.setenv("SUSPECT_SPEAKER_BACKEND", legacy_mode)

    with pytest.raises(ValueError, match="eres2net_large"):
        resolve_speaker_backend_selection()


def test_unknown_backend_configuration_fails_closed(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("SUSPECT_SPEAKER_BACKEND", "mystery")

    with pytest.raises(ValueError, match="SUSPECT_SPEAKER_BACKEND"):
        resolve_speaker_backend_selection()


def test_embedding_result_is_backend_neutral_and_carries_provenance() -> None:
    result = FakeBackend().extract_embedding(b"\x00\x00", 16000)

    assert result.embedding == [1.0, 0.0]
    assert result.backend_key is SpeakerBackendKey.XVECTOR
    assert result.model_id == "fixture-xvector"
    assert result.model_version == "fixture-v1"
    assert result.model_fingerprint == "sha256:fixture"
    assert result.latency_ms == pytest.approx(3.25)


def test_registry_resolves_only_registered_concrete_backends() -> None:
    registry = SpeakerBackendRegistry()
    backend = FakeBackend()
    registry.register(backend)

    assert registry.get(SpeakerBackendKey.XVECTOR) is backend
    with pytest.raises(KeyError):
        registry.get(SpeakerBackendKey.ERES2NET_LARGE)
