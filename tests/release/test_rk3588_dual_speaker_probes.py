from __future__ import annotations

import importlib.util
import inspect
import struct
import wave
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
CALIBRATE = ROOT / "scripts" / "ci" / "rk3588-speech-calibrate.py"
SMOKE = ROOT / "scripts" / "ci" / "rk3588-speech-smoke.py"
ERES_PROBE = ROOT / "scripts" / "ci" / "probe-eres2net-large.py"
WORKFLOW = ROOT / ".github" / "workflows" / "rk3588-dual-speaker-probe.yml"


def load_script(path: Path, name: str):
    spec = importlib.util.spec_from_file_location(name, path)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def wav16(path: Path, *, duration_ms: int = 3000, sample: int = 900) -> bytes:
    count = duration_ms * 16_000 // 1000
    pcm = struct.pack(f"<{count}h", *([sample] * count))
    with wave.open(str(path), "wb") as handle:
        handle.setnchannels(1)
        handle.setsampwidth(2)
        handle.setframerate(16_000)
        handle.writeframes(pcm)
    return pcm


class FakeCalibrationClient:
    def __init__(self) -> None:
        self.backends: list[str | None] = []

    def speech_segments(self, pcm: bytes, sample_rate: int = 16_000):
        assert pcm and sample_rate == 16_000
        return [[0, 2500]]

    def extract_embedding(self, pcm: bytes, sample_rate: int = 16_000, backend: str | None = None):
        assert pcm and sample_rate == 16_000
        self.backends.append(backend)
        return {
            "backend_key": backend,
            "embedding": [0.0, 1.0, 0.0],
            "model_id": "fixture-model",
            "model_version": "fixture-v1",
            "model_fingerprint": "f" * 64,
            "latency_ms": 12.5,
        }


def test_calibration_is_backend_parameterized_and_preserves_model_metadata(tmp_path: Path):
    module = load_script(CALIBRATE, "task12_calibrate")
    signature = inspect.signature(module._embedding_for_wav)
    assert "speaker_backend" in signature.parameters

    source = tmp_path / "sample.wav"
    wav16(source)
    client = FakeCalibrationClient()
    vector, speech_ms, metadata = module._embedding_for_wav(client, source, "eres2net_large")

    assert len(vector) == 3
    assert speech_ms == 2500
    assert client.backends == ["eres2net_large"]
    assert metadata["speaker_backend"] == "eres2net_large"
    assert metadata["model_id"] == "fixture-model"
    assert metadata["model_fingerprint"] == "f" * 64

    text = CALIBRATE.read_text(encoding="utf-8")
    assert "--speaker-backend" in text
    assert "xvector" in text and "eres2net_large" in text
    assert '"speaker_backend"' in text
    assert '"model_fingerprint"' in text
    assert '"calibration_id"' in text


def test_non_xvector_calibration_cannot_apply_to_production_env():
    module = load_script(CALIBRATE, "task12_calibrate_apply")
    module._validate_apply_policy("xvector", True)
    with pytest.raises(ValueError, match="xvector"):
        module._validate_apply_policy("eres2net_large", True)


def test_speech_smoke_accepts_concrete_backend_and_forwards_it_to_embedding(tmp_path: Path):
    module = load_script(SMOKE, "task12_smoke")
    signature = inspect.signature(module._embedding)
    assert "speaker_backend" in signature.parameters

    source = tmp_path / "sample.wav"
    pcm = wav16(source)
    client = FakeCalibrationClient()
    vector = module._embedding(client, pcm, "eres2net_large")
    assert len(vector) == 3
    assert client.backends == ["eres2net_large"]

    text = SMOKE.read_text(encoding="utf-8")
    assert "--speaker-backend" in text
    assert "--no-restart" in text
    assert "backend=speaker_backend" in text or "backend=backend" in text
    assert "speaker_backend=speaker_backend" in text or "speaker_backend=backend" in text


def test_eres_package_probe_can_run_real_read_only_embedding_smoke():
    text = ERES_PROBE.read_text(encoding="utf-8")
    assert "--socket" in text
    assert "--embedding-wav" in text
    assert "SpeechWorkerClient" in text
    assert 'backend="eres2net_large"' in text
    assert '"embedding_dim"' in text
    assert '"embedding_latency_ms"' in text
    assert '"runtime_model_fingerprint"' in text
    assert '"embedding"' not in text.split("report =", 1)[-1]


def test_task12_workflow_has_hosted_gate_before_board_and_is_non_destructive():
    text = WORKFLOW.read_text(encoding="utf-8")
    assert "hosted-contract" in text
    assert "runs-on: ubuntu-24.04" in text
    assert "runs-on: [self-hosted, rk3588]" in text
    assert "needs: hosted-contract" in text
    assert "$RUNNER_TEMP" in text
    assert "--speaker-backend xvector" in text
    assert "--speaker-backend eres2net_large" in text
    assert "xvector-calibration.json" in text
    assert "eres2net-calibration.json" in text
    assert "--apply" not in text
    assert "systemctl restart" not in text
    assert ":8000" not in text
    assert "SUSPECT_SPEAKER_BACKEND=" not in text


def test_task12_workflow_calibrates_both_backends_from_same_corpus_arguments():
    text = WORKFLOW.read_text(encoding="utf-8")
    assert text.count('--suspect-wavs "${SUSPECT_WAVS[@]}"') == 2
    assert text.count('--interrogator-wavs "${INTERROGATOR_WAVS[@]}"') == 2
    assert text.count('--recorder-wavs "${RECORDER_WAVS[@]}"') == 2
    assert "xvector-calibration.json" in text
    assert "eres2net-calibration.json" in text


def test_task12_workflow_records_independent_calibration_identity_and_thresholds():
    text = WORKFLOW.read_text(encoding="utf-8")
    for token in (
        "calibration_id",
        "speaker_backend",
        "model_fingerprint",
        "recommended_threshold",
        "recommended_margin",
        "TASK12_DUAL_SPEAKER_PROBE_COMPLETE",
    ):
        assert token in text
