import json
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts" / "ci" / "probe-funasr-runtime.py"
ERES2NET_SCRIPT = ROOT / "scripts" / "ci" / "probe-eres2net-large.py"
WORKFLOW = ROOT / ".github" / "workflows" / "linux-ai-runtime-rk3588.yml"


def test_probe_exists_and_is_offline_and_non_destructive():
    text = SCRIPT.read_text(encoding="utf-8")
    assert "disable_update=True" in text
    assert "MODEL_ROOT" in text
    assert "paraformer" in text
    assert "fsmn-vad" in text
    assert "xvector" in text
    assert "AutoModel" in text
    assert "_ModelScopeLegacyXVectorAdapter" not in text
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


def test_rk3588_ai_runtime_heals_pinned_modelscope_for_legacy_xvector():
    workflow = WORKFLOW.read_text(encoding="utf-8")
    assert "MODELSCOPE_PACKAGE_VERSION: '1.39.1'" in workflow
    assert '"modelscope==${MODELSCOPE_PACKAGE_VERSION}"' in workflow
    assert "import funasr, torch, torchaudio, modelscope" in workflow


def test_eres2net_probe_is_read_only_and_does_not_guess_required_files():
    text = ERES2NET_SCRIPT.read_text(encoding="utf-8")
    assert "speech_eres2net_large_200k_sv_zh-cn_16k-common" in text
    assert "fingerprint" in text
    assert "search-root" in text
    assert "allow-missing" in text
    assert "unlink(" not in text
    assert "rmtree(" not in text
    assert "pip install" not in text
    assert "snapshot_download" not in text
    assert "required_files" not in text


def test_eres2net_probe_reports_real_file_inventory_and_fingerprint(tmp_path: Path):
    model_dir = tmp_path / "speech_eres2net_large_200k_sv_zh-cn_16k-common"
    model_dir.mkdir()
    (model_dir / "configuration.json").write_text('{"task":"speaker-verification"}\n', encoding="utf-8")
    (model_dir / "weights.bin").write_bytes(b"fixture-weights")
    output = tmp_path / "eres2net-probe.json"
    env = os.environ.copy()
    env["GITHUB_WORKSPACE"] = os.fspath(tmp_path)

    result = subprocess.run(
        [
            sys.executable,
            os.fspath(ERES2NET_SCRIPT),
            "--model-dir",
            os.fspath(model_dir),
            "--output",
            os.fspath(output),
        ],
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )

    assert result.returncode == 0, result.stderr
    report = json.loads(output.read_text(encoding="utf-8"))
    assert report["status"] == "INSTALLED"
    assert report["model_dir"] == os.fspath(model_dir.resolve())
    assert len(report["fingerprint"]) == 64
    assert [item["path"] for item in report["files"]] == ["configuration.json", "weights.bin"]
    assert all(item["bytes"] > 0 for item in report["files"])


def test_eres2net_probe_can_report_missing_without_mutating_host(tmp_path: Path):
    output = tmp_path / "missing.json"
    env = os.environ.copy()
    env["RUNNER_TEMP"] = os.fspath(tmp_path)

    result = subprocess.run(
        [
            sys.executable,
            os.fspath(ERES2NET_SCRIPT),
            "--model-dir",
            os.fspath(tmp_path / "missing-model"),
            "--allow-missing",
            "--output",
            os.fspath(output),
        ],
        env=env,
        text=True,
        capture_output=True,
        check=False,
    )

    assert result.returncode == 0, result.stderr
    report = json.loads(output.read_text(encoding="utf-8"))
    assert report["status"] == "NOT_INSTALLED"
    assert report["files"] == []
    assert report["fingerprint"] is None


def test_rk3588_workflow_runs_read_only_eres2net_package_probe():
    workflow = WORKFLOW.read_text(encoding="utf-8")
    assert "Probe ERes2Net-large package without downloads" in workflow
    assert "scripts/ci/probe-eres2net-large.py" in workflow
    assert "--allow-missing" in workflow
    assert "/opt/suspect-interrogation/models" in workflow
    assert "/home/youyeetoo/.cache/modelscope" in workflow


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
