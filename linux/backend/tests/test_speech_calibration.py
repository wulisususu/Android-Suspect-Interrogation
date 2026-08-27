from __future__ import annotations

from pathlib import Path

import pytest

from app.ai.errors import BackendUnavailableError
from app.ai.registry import ModelRegistry
from app.ai.speech.types import SpeechEventType
from app.ai.supervisor import AISupervisor
from speech_worker.funasr_runtime import FunASRSpeechRuntime
from speech_worker.session import SpeechSession


def _registry(tmp_path: Path) -> ModelRegistry:
    config = tmp_path / "model-registry.yaml"
    config.write_text(
        '''{
          "models": {
            "asr.default": {"kind":"asr","backend":"speech-worker","path":"asr/default","architecture":"paraformer","required_files":["model.onnx"],"device":"cpu","context":0,"memory_mb":512}
          }
        }''',
        encoding="utf-8",
    )
    return ModelRegistry.load(config, tmp_path / "models")


def test_calibration_uses_production_env_names_and_missing_values_are_not_configured(monkeypatch):
    from app.ai.speech.calibration import SpeakerCalibration

    monkeypatch.delenv("SUSPECT_SPEAKER_ACCEPT_THRESHOLD", raising=False)
    monkeypatch.delenv("SUSPECT_SPEAKER_MARGIN", raising=False)
    # Legacy/unscoped names must not silently configure production biometrics.
    monkeypatch.setenv("SPEAKER_ACCEPT_THRESHOLD", "0.70")
    monkeypatch.setenv("SPEAKER_MARGIN", "0.10")

    calibration = SpeakerCalibration.from_env()

    assert calibration.accept_threshold is None
    assert calibration.margin is None
    assert calibration.configured is False
    assert calibration.state == "NOT_CONFIGURED"


def test_calibration_rejects_non_finite_or_out_of_range_values(monkeypatch):
    from app.ai.speech.calibration import SpeakerCalibration

    invalid_pairs = [
        ("-0.01", "0.10"),
        ("1.01", "0.10"),
        ("0.70", "-0.01"),
        ("0.70", "1.01"),
        ("nan", "0.10"),
        ("inf", "0.10"),
    ]
    for threshold, margin in invalid_pairs:
        monkeypatch.setenv("SUSPECT_SPEAKER_ACCEPT_THRESHOLD", threshold)
        monkeypatch.setenv("SUSPECT_SPEAKER_MARGIN", margin)
        with pytest.raises(ValueError, match="0\.0.*1\.0"):
            SpeakerCalibration.from_env()


def test_xvector_load_failure_keeps_asr_and_vad_available(tmp_path: Path):
    model_root = tmp_path / "funasr"
    for name in ("paraformer", "fsmn-vad", "xvector"):
        (model_root / name).mkdir(parents=True)

    class FakeModel:
        def generate(self, **_kwargs):
            return []

    def factory(*, model: str, **_kwargs):
        if Path(model).name == "xvector":
            raise RuntimeError("xvector unavailable")
        return FakeModel()

    runtime = FunASRSpeechRuntime(model_root=model_root, model_factory=factory)
    runtime.load()

    health = runtime.health()
    assert health["models"] == {"asr": True, "vad": True, "speaker": False}
    assert runtime.asr_model is not None
    assert runtime.vad_model is not None
    assert runtime.speaker_model is None


def test_xvector_inference_failure_does_not_discard_successful_asr():
    class Runtime:
        def vad_stream(self, _pcm, _sample_rate, *, cache, is_final, chunk_size_ms):
            del cache, is_final, chunk_size_ms
            return [[0, 1000]]

        def transcribe(self, _pcm, _sample_rate):
            return {"text": "这是有效转写", "confidence": 0.91, "model_id": "paraformer"}

        def speaker_embedding(self, _pcm, _sample_rate):
            raise BackendUnavailableError("xvector inference failed")

    session = SpeechSession("s-1", 16000, Runtime(), pre_roll_ms=1200)
    events = session.push_pcm(b"\x01\x00" * 16000)

    assert any(event.type is SpeechEventType.ASR_FINAL and event.text == "这是有效转写" for event in events)
    assert not any(event.type is SpeechEventType.SPEAKER_RESULT for event in events)


def test_supervisor_reports_speaker_failure_independently_from_asr_and_vad(tmp_path: Path):
    class PartialSpeechClient:
        def health(self):
            return {
                "status": "degraded",
                "models": {"asr": True, "vad": True, "speaker": False},
            }

    supervisor = AISupervisor(
        _registry(tmp_path),
        mode="real",
        speech_client=PartialSpeechClient(),
        speaker_accept_threshold=0.70,
        speaker_margin=0.10,
    )
    try:
        capabilities = supervisor.capabilities()
        assert capabilities["asr"]["speech_state"] == "AVAILABLE"
        assert capabilities["vad"]["state"] == "AVAILABLE"
        assert capabilities["speaker"]["state"] == "ERROR"
        assert capabilities["speaker"]["threshold_configured"] is True
        assert capabilities["speaker"]["margin_configured"] is True
    finally:
        supervisor.shutdown()
