from __future__ import annotations

import math
import struct
from pathlib import Path

import pytest

from app.ai.errors import BackendUnavailableError, ModelNotInstalledError, WorkerCrashedError
from speech_worker.speaker.base import SpeakerBackendKey
from speech_worker.speaker.eres2net_large import ERes2NetLargeBackend


class FakeEmbeddingModel:
    def __init__(self, embedding=None) -> None:
        self.embedding = [3.0, 4.0] if embedding is None else embedding
        self.calls: list[list[float]] = []

    def extract_embedding(self, waveform: list[float]) -> object:
        self.calls.append(list(waveform))
        return self.embedding


def _pcm16(*values: int) -> bytes:
    return b"".join(struct.pack("<h", value) for value in values)


def _model_dir(tmp_path: Path) -> Path:
    model_dir = tmp_path / "eres2net-large"
    model_dir.mkdir()
    (model_dir / "configuration.json").write_text('{"task":"speaker-verification"}\n', encoding="utf-8")
    (model_dir / "weights.fixture").write_bytes(b"eres2net-large")
    return model_dir


def test_eres2net_large_is_local_only_and_normalizes_embedding(tmp_path: Path) -> None:
    model_dir = _model_dir(tmp_path)
    model = FakeEmbeddingModel()
    factory_calls: list[Path] = []

    def factory(path: Path) -> FakeEmbeddingModel:
        factory_calls.append(path)
        return model

    backend = ERes2NetLargeBackend(
        model_path=model_dir,
        model_factory=factory,
        model_version="v1.0.0",
    )
    backend.load()
    result = backend.extract_embedding(_pcm16(-32768, 0, 32767), 16000)

    assert factory_calls == [model_dir]
    assert backend.key is SpeakerBackendKey.ERES2NET_LARGE
    assert result.backend_key is SpeakerBackendKey.ERES2NET_LARGE
    assert result.model_id == "iic/speech_eres2net_large_200k_sv_zh-cn_16k-common"
    assert result.model_version == "v1.0.0"
    assert result.model_fingerprint
    assert result.latency_ms is not None and result.latency_ms >= 0.0
    assert model.calls == [pytest.approx([-1.0, 0.0, 32767 / 32768.0])]
    assert result.embedding == pytest.approx([0.6, 0.8], abs=1e-6)
    assert math.sqrt(sum(value * value for value in result.embedding)) == pytest.approx(1.0, abs=1e-6)


def test_eres2net_large_rejects_non_16k_audio_before_inference(tmp_path: Path) -> None:
    model = FakeEmbeddingModel()
    backend = ERes2NetLargeBackend(model_path=_model_dir(tmp_path), model_factory=lambda _: model)
    backend.load()

    with pytest.raises(ValueError, match="16 kHz"):
        backend.extract_embedding(_pcm16(1, 2), 8000)
    assert model.calls == []


def test_eres2net_large_rejects_non_pcm16_frame(tmp_path: Path) -> None:
    model = FakeEmbeddingModel()
    backend = ERes2NetLargeBackend(model_path=_model_dir(tmp_path), model_factory=lambda _: model)
    backend.load()

    with pytest.raises(ValueError, match="PCM16"):
        backend.extract_embedding(b"\x01", 16000)
    assert model.calls == []


def test_eres2net_large_requires_local_directory(tmp_path: Path) -> None:
    with pytest.raises(ModelNotInstalledError):
        ERes2NetLargeBackend(
            model_path=tmp_path / "missing",
            model_factory=lambda _: FakeEmbeddingModel(),
        ).load()


def test_eres2net_large_wraps_factory_failure_as_backend_unavailable(tmp_path: Path) -> None:
    def failing_factory(_: Path):
        raise RuntimeError("cannot load local checkpoint")

    backend = ERes2NetLargeBackend(model_path=_model_dir(tmp_path), model_factory=failing_factory)
    with pytest.raises(BackendUnavailableError, match="ERes2Net-large"):
        backend.load()


def test_eres2net_large_rejects_empty_or_invalid_embedding(tmp_path: Path) -> None:
    model = FakeEmbeddingModel([])
    backend = ERes2NetLargeBackend(model_path=_model_dir(tmp_path), model_factory=lambda _: model)
    backend.load()
    with pytest.raises(WorkerCrashedError, match="empty"):
        backend.extract_embedding(_pcm16(1, 2), 16000)

    model.embedding = [0.0, 0.0]
    with pytest.raises(WorkerCrashedError, match="zero or invalid"):
        backend.extract_embedding(_pcm16(1, 2), 16000)

    model.embedding = [float("nan"), 1.0]
    with pytest.raises(WorkerCrashedError, match="non-finite"):
        backend.extract_embedding(_pcm16(1, 2), 16000)
