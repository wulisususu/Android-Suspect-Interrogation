from __future__ import annotations

import math
from pathlib import Path

import pytest

from app.ai.errors import BackendUnavailableError, ModelNotInstalledError, WorkerCrashedError
from speech_worker.funasr_runtime import FunASRSpeechRuntime


class FakeAutoModel:
    calls: list[dict] = []
    outputs: dict[str, object] = {}
    fail_for: dict[str, Exception] = {}

    def __init__(self, **kwargs):
        name = Path(kwargs["model"]).name
        self.name = name
        self.generate_calls: list[dict] = []
        self.outputs_override: object | None = None
        type(self).calls.append(dict(kwargs))
        failure = type(self).fail_for.get(name)
        if failure is not None:
            raise failure

    def generate(self, **kwargs):
        self.generate_calls.append(dict(kwargs))
        value = self.outputs_override if self.outputs_override is not None else type(self).outputs.get(self.name)
        if isinstance(value, Exception):
            raise value
        return value


class FakeLegacySpeaker:
    def __init__(self) -> None:
        self.generate_calls: list[dict] = []

    def generate(self, **kwargs):
        self.generate_calls.append(dict(kwargs))
        return [{"spk_embedding": [[3.0, 4.0]]}]


@pytest.fixture(autouse=True)
def reset_fake_model():
    FakeAutoModel.calls = []
    FakeAutoModel.fail_for = {}
    FakeAutoModel.outputs = {
        "paraformer": [{"text": "测试文本", "confidence": 0.91}],
        "fsmn-vad": [{"value": [[120, 820], [1000, 1450]]}],
        "xvector": [{"spk_embedding": [[3.0, 4.0]]}],
    }


def _loaded_runtime(tmp_path: Path) -> FunASRSpeechRuntime:
    root = tmp_path / "funasr"
    for name in ("paraformer", "fsmn-vad", "xvector"):
        (root / name).mkdir(parents=True, exist_ok=True)
    runtime = FunASRSpeechRuntime(model_root=root, model_factory=FakeAutoModel)
    runtime.load()
    return runtime


def test_default_model_paths_are_stable_opt_layout(monkeypatch):
    monkeypatch.setattr(Path, "is_dir", lambda self: True)
    runtime = FunASRSpeechRuntime(model_factory=FakeAutoModel)
    runtime.load()

    assert runtime.model_root == Path("/opt/suspect-interrogation/models/funasr")
    assert [call["model"] for call in FakeAutoModel.calls] == [
        "/opt/suspect-interrogation/models/funasr/paraformer",
        "/opt/suspect-interrogation/models/funasr/fsmn-vad",
        "/opt/suspect-interrogation/models/funasr/xvector",
    ]
    for call in FakeAutoModel.calls:
        assert call["device"] == "cpu"
        assert call["disable_update"] is True
        assert call["disable_pbar"] is True


def test_vad_and_asr_outputs_are_normalized_without_fabricated_partials(tmp_path: Path):
    runtime = _loaded_runtime(tmp_path)
    pcm = b"\x00\x00" * 1600

    assert runtime.vad(pcm, 16000) == [[120, 820], [1000, 1450]]
    result = runtime.transcribe(pcm, 16000)
    assert result == {"text": "测试文本", "confidence": pytest.approx(0.91)}
    assert "partial" not in result

    vad_call = runtime.vad_model.generate_calls[-1]
    asr_call = runtime.asr_model.generate_calls[-1]
    assert vad_call["input"] == pcm and vad_call["fs"] == 16000
    assert asr_call["input"] == pcm and asr_call["fs"] == 16000


def test_streaming_vad_passes_only_new_pcm_and_session_cache(tmp_path: Path):
    runtime = _loaded_runtime(tmp_path)
    cache: dict = {}
    runtime.vad_model.outputs_override = [{"value": [[25, -1]]}]
    chunk = b"\x01\x00" * 3200

    events = runtime.vad_stream(chunk, 16000, cache=cache, is_final=False, chunk_size_ms=200)
    assert events == [[25, -1]]
    call = runtime.vad_model.generate_calls[-1]
    assert call["input"] == chunk
    assert call["cache"] is cache
    assert call["is_final"] is False
    assert call["chunk_size"] == 200


def test_speaker_embedding_is_flat_normalized_float_list(tmp_path: Path):
    runtime = _loaded_runtime(tmp_path)
    result = runtime.speaker_embedding(b"\x00\x00" * 1600, 16000)

    embedding = result["embedding"]
    assert result["model_id"] == "xvector"
    assert embedding == pytest.approx([0.6, 0.8], abs=1e-6)
    assert all(isinstance(value, float) for value in embedding)
    assert math.sqrt(sum(value * value for value in embedding)) == pytest.approx(1.0, abs=1e-6)


def test_legacy_xvector_falls_back_without_downgrading_asr_vad_runtime(tmp_path: Path):
    root = tmp_path / "funasr"
    for name in ("paraformer", "fsmn-vad", "xvector"):
        (root / name).mkdir(parents=True, exist_ok=True)
    (root / "xvector" / "sv.pth").write_bytes(b"checkpoint")
    (root / "xvector" / "sv.yaml").write_text("model: xvector\n", encoding="utf-8")
    FakeAutoModel.fail_for["xvector"] = RuntimeError("legacy xvector is not registered")
    legacy = FakeLegacySpeaker()
    calls: list[Path] = []

    def legacy_factory(path: Path):
        calls.append(path)
        return legacy

    runtime = FunASRSpeechRuntime(
        model_root=root,
        model_factory=FakeAutoModel,
        legacy_speaker_factory=legacy_factory,
    )
    runtime.load()

    assert runtime.health()["status"] == "ready"
    assert runtime.health()["models"] == {"asr": True, "vad": True, "speaker": True}
    assert calls == [root / "xvector"]
    assert runtime.speaker_backend == "modelscope-legacy-xvector"
    assert runtime.speaker_embedding(b"\x00\x00" * 1600, 16000)["embedding"] == pytest.approx([0.6, 0.8])
    assert legacy.generate_calls[-1]["fs"] == 16000


def test_speaker_embedding_rejects_missing_contract(tmp_path: Path):
    runtime = _loaded_runtime(tmp_path)
    runtime.speaker_model.outputs_override = [{"text": "wrong contract"}]
    with pytest.raises(WorkerCrashedError, match="spk_embedding"):
        runtime.speaker_embedding(b"\x00\x00" * 1600, 16000)


def test_missing_model_directory_is_typed_not_installed(tmp_path: Path):
    root = tmp_path / "missing-funasr"
    root.mkdir()
    with pytest.raises(ModelNotInstalledError):
        FunASRSpeechRuntime(model_root=root, model_factory=FakeAutoModel).load()


def test_model_factory_failure_becomes_backend_unavailable(tmp_path: Path):
    root = tmp_path / "funasr"
    for name in ("paraformer", "fsmn-vad", "xvector"):
        (root / name).mkdir(parents=True, exist_ok=True)
    FakeAutoModel.fail_for["fsmn-vad"] = RuntimeError("bad checkpoint")

    with pytest.raises(BackendUnavailableError, match="fsmn-vad"):
        FunASRSpeechRuntime(model_root=root, model_factory=FakeAutoModel).load()
