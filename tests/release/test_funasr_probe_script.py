import json
import os
import struct
import subprocess
import sys
import wave
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts" / "ci" / "probe-funasr-runtime.py"
ERES2NET_SCRIPT = ROOT / "scripts" / "ci" / "probe-eres2net-large.py"
WORKFLOW = ROOT / ".github" / "workflows" / "linux-ai-runtime-rk3588.yml"


def _write_wav(path: Path) -> None:
    with wave.open(str(path), "wb") as handle:
        handle.setnchannels(1)
        handle.setsampwidth(2)
        handle.setframerate(16_000)
        handle.writeframes(struct.pack("<1600h", *([900] * 1600)))


def test_funasr_probe_is_offline_and_limited_to_asr_and_vad():
    text = SCRIPT.read_text(encoding="utf-8")
    assert "disable_update=True" in text
    assert 'MODEL_DIRS = {"paraformer": "paraformer", "fsmn-vad": "fsmn-vad"}' in text
    assert "XVectorBackend" not in text
    assert "SUSPECT_XVECTOR_LEGACY_PYTHON" not in text
    assert "unlink(" not in text
    assert "rmtree(" not in text


def test_funasr_probe_reports_asr_and_vad_load_evidence(tmp_path: Path):
    model_root = tmp_path / "models"
    for name in ("paraformer", "fsmn-vad"):
        model_dir = model_root / name
        model_dir.mkdir(parents=True)
        (model_dir / "config.yaml").write_text("model: test\n", encoding="utf-8")
    stubs = tmp_path / "stubs"
    (stubs / "funasr").mkdir(parents=True)
    (stubs / "funasr" / "__init__.py").write_text(
        "__version__ = 'test'\nclass AutoModel:\n    def __init__(self, **kwargs): pass\n    def generate(self, **kwargs): return [{'text': 'ok', 'value': [[0, 10]]}]\n",
        encoding="utf-8",
    )
    (stubs / "torch.py").write_text("__version__ = 'test'\n", encoding="utf-8")
    wav = tmp_path / "sample.wav"
    _write_wav(wav)
    output = tmp_path / "report.json"
    env = os.environ | {"GITHUB_WORKSPACE": str(tmp_path), "MODEL_ROOT": str(model_root), "PYTHONPATH": str(stubs)}
    result = subprocess.run([sys.executable, str(SCRIPT), "--speech-wav", str(wav), "--output", str(output)], env=env, text=True, capture_output=True)
    assert result.returncode == 0, result.stderr
    report = json.loads(output.read_text(encoding="utf-8"))
    assert report["success"] is True
    assert set(report["models"]) == {"paraformer", "fsmn-vad"}
    assert all(item["inference_ok"] is True for item in report["models"].values())


def test_linux_ai_runtime_does_not_require_or_probe_xvector():
    text = WORKFLOW.read_text(encoding="utf-8")
    assert "pull_request:" in text
    assert "Probe installed FunASR models without downloads" in text
    assert "XVECTOR_LEGACY_PYTHON" not in text
    assert "--legacy-xvector-python" not in text
    assert "xvector/example" not in text
    assert "scripts/ci/probe-eres2net-large.py" in text


def test_eres2net_probe_remains_read_only():
    text = ERES2NET_SCRIPT.read_text(encoding="utf-8")
    assert "speech_eres2net_large_200k_sv_zh-cn_16k-common" in text
    assert "fingerprint" in text
    assert "snapshot_download" not in text
    assert "pip install" not in text
