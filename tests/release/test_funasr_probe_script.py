import json
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts" / "ci" / "probe-funasr-runtime.py"
WORKFLOW = ROOT / ".github" / "workflows" / "linux-ai-runtime-rk3588.yml"


def test_probe_exists_and_is_offline_and_non_destructive():
    text = SCRIPT.read_text(encoding="utf-8")
    assert "disable_update=True" in text
    assert "MODEL_ROOT" in text
    assert "paraformer" in text
    assert "fsmn-vad" in text
    assert "xvector" in text
    assert "AutoModel" in text
    assert "unlink(" not in text
    assert "rmtree(" not in text


def test_probe_output_is_restricted_to_actions_runtime_roots():
    text = SCRIPT.read_text(encoding="utf-8")
    assert 'for name in ("GITHUB_WORKSPACE", "RUNNER_TEMP")' in text
    assert "allowed_roots.append(Path.cwd().resolve())" not in text
    assert "GITHUB_WORKSPACE or RUNNER_TEMP is required" in text


def test_rk3588_ai_runtime_probe_runs_before_merge_on_pull_requests():
    workflow = WORKFLOW.read_text(encoding="utf-8")
    assert "pull_request:" in workflow
    assert "branches:\n      - linux-adaptation" in workflow
    assert "Probe installed FunASR models without downloads" in workflow
    assert "/opt/suspect-interrogation/runtime/funasr-env/bin/python" in workflow
    assert "/home/youyeetoo/rkllm_model_zoo/funasr_env/bin/python" in workflow


def test_rk3588_probe_inventories_models_and_fails_closed_without_runtime():
    workflow = WORKFLOW.read_text(encoding="utf-8")
    assert 'find "$MODEL_ROOT" -type f -printf' in workflow
    assert "FunASR interpreter diagnostic" in workflow
    assert "FunASR-capable Python interpreter not found" in workflow
    missing_runtime = workflow.index("FunASR-capable Python interpreter not found")
    following = workflow[missing_runtime:missing_runtime + 300]
    assert "exit 1" in following
    assert "real-model probe skipped" not in following


def test_rk3588_ai_pytest_is_focused_and_uses_isolated_mutable_paths():
    workflow = WORKFLOW.read_text(encoding="utf-8")
    assert 'AI_TEST_ROOT="$RUNNER_TEMP/suspect-ai-runtime-test"' in workflow
    assert 'export SUSPECT_DATA_DIR="$AI_TEST_ROOT/data"' in workflow
    assert 'export SUSPECT_LOG_DIR="$AI_TEST_ROOT/log"' in workflow
    assert 'export SUSPECT_DB_PATH="$AI_TEST_ROOT/interrogation.db"' in workflow
    assert "tests/test_speech_protocol.py" in workflow
    assert "tests/test_supervisor.py" in workflow
    assert "PYTHONPATH=. python3 -m pytest -q" not in workflow


def test_probe_preserves_successful_load_evidence_when_optional_inference_fails(tmp_path: Path):
    model_root = tmp_path / "models"
    for name in ("paraformer", "fsmn-vad", "xvector"):
        model_dir = model_root / name
        model_dir.mkdir(parents=True)
        (model_dir / "config.yaml").write_text("model: test\n", encoding="utf-8")

    stubs = tmp_path / "stubs"
    (stubs / "funasr").mkdir(parents=True)
    (stubs / "funasr" / "__init__.py").write_text(
        "__version__ = 'test'\n"
        "class AutoModel:\n"
        "    def __init__(self, *, model, **kwargs): self.model = model\n"
        "    def generate(self, *, input, **kwargs):\n"
        "        if self.model.endswith('xvector'): raise RuntimeError('bad embedding contract')\n"
        "        return [{}]\n",
        encoding="utf-8",
    )
    (stubs / "torch.py").write_text("__version__ = 'test'\n", encoding="utf-8")
    speaker_wav = tmp_path / "speaker.wav"
    speaker_wav.write_bytes(b"RIFF-test")
    output = tmp_path / "report.json"
    env = os.environ.copy()
    env.update(
        {
            "GITHUB_WORKSPACE": os.fspath(tmp_path),
            "MODEL_ROOT": os.fspath(model_root),
            "PYTHONPATH": os.fspath(stubs),
        }
    )

    result = subprocess.run(
        [sys.executable, os.fspath(SCRIPT), "--output", os.fspath(output), "--speaker-wav", os.fspath(speaker_wav)],
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )

    assert result.returncode == 1
    report = json.loads(output.read_text(encoding="utf-8"))
    xvector = report["models"]["xvector"]
    assert xvector["load_ok"] is True
    assert xvector["load_seconds"] >= 0
    assert xvector["files"][0]["path"] == "config.yaml"
    assert xvector["inference_ok"] is False
    assert "bad embedding contract" in xvector["inference_error"]