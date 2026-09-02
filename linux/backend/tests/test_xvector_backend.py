from __future__ import annotations

import math
from pathlib import Path

import pytest

from app.ai.errors import ModelNotInstalledError, WorkerCrashedError
from speech_worker.speaker.base import SpeakerBackendKey
from speech_worker.speaker.xvector import XVectorBackend


class FakeAutoModel:
    def __init__(self, **kwargs):
        self.kwargs = dict(kwargs)
        self.output = [{"spk_embedding": [[3.0, 4.0]]}]
        self.generate_calls: list[dict] = []

    def generate(self, **kwargs):
        self.generate_calls.append(dict(kwargs))
        return self.output


class FakeLegacySpeaker:
    def __init__(self) -> None:
        self.generate_calls: list[dict] = []

    def generate(self, **kwargs):
        self.generate_calls.append(dict(kwargs))
        return [{"spk_embedding": [[3.0, 4.0]]}]


def test_xvector_backend_preserves_automodel_loading_and_normalization(tmp_path: Path) -> None:
    model_path = tmp_path / "xvector"
    model_path.mkdir()
    (model_path / "fixture.bin").write_bytes(b"xvector")
    created: list[FakeAutoModel] = []

    def factory(**kwargs):
        model = FakeAutoModel(**kwargs)
        created.append(model)
        return model

    backend = XVectorBackend(model_path=model_path, model_factory=factory, model_version="fixture-v1")
    backend.load()
    result = backend.extract_embedding(b"\x00\x00" * 1600, 16000)

    assert backend.key is SpeakerBackendKey.XVECTOR
    assert backend.implementation == "funasr-automodel"
    assert created[0].kwargs == {
        "model": str(model_path),
        "device": "cpu",
        "disable_update": True,
        "disable_pbar": True,
    }
    assert created[0].generate_calls[-1]["input"] == b"\x00\x00" * 1600
    assert created[0].generate_calls[-1]["fs"] == 16000
    assert created[0].generate_calls[-1]["embedding"] is True
    assert result.backend_key is SpeakerBackendKey.XVECTOR
    assert result.model_id == "xvector"
    assert result.model_version == "fixture-v1"
    assert result.model_fingerprint
    assert result.embedding == pytest.approx([0.6, 0.8], abs=1e-6)
    assert math.sqrt(sum(value * value for value in result.embedding)) == pytest.approx(1.0, abs=1e-6)


def test_xvector_backend_preserves_legacy_fallback(tmp_path: Path) -> None:
    model_path = tmp_path / "xvector"
    model_path.mkdir()
    (model_path / "sv.pth").write_bytes(b"checkpoint")
    (model_path / "sv.yaml").write_text("model: xvector\n", encoding="utf-8")
    legacy = FakeLegacySpeaker()
    legacy_calls: list[Path] = []

    def failing_factory(**kwargs):
        raise RuntimeError("legacy xvector is not registered")

    def legacy_factory(path: Path):
        legacy_calls.append(path)
        return legacy

    backend = XVectorBackend(
        model_path=model_path,
        model_factory=failing_factory,
        legacy_speaker_factory=legacy_factory,
    )
    backend.load()
    result = backend.extract_embedding(b"\x00\x00" * 800, 16000)

    assert backend.implementation == "legacy-subprocess-xvector"
    assert legacy_calls == [model_path]
    assert result.embedding == pytest.approx([0.6, 0.8])
    assert legacy.generate_calls[-1]["fs"] == 16000


def test_xvector_backend_missing_directory_is_not_installed(tmp_path: Path) -> None:
    with pytest.raises(ModelNotInstalledError):
        XVectorBackend(model_path=tmp_path / "missing", model_factory=FakeAutoModel).load()


def test_xvector_backend_rejects_malformed_embedding(tmp_path: Path) -> None:
    model_path = tmp_path / "xvector"
    model_path.mkdir()
    backend = XVectorBackend(model_path=model_path, model_factory=FakeAutoModel)
    backend.load()
    assert backend.model is not None
    backend.model.output = [{"text": "wrong contract"}]

    with pytest.raises(WorkerCrashedError, match="spk_embedding"):
        backend.extract_embedding(b"\x00\x00" * 800, 16000)
