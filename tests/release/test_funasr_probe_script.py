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
    assert "KNOWN_FUNASR_PYTHON=/home/youyeetoo/rkllm_model_zoo/funasr_env/bin/python" in workflow


def test_rk3588_probe_inventories_models_and_fails_closed_without_runtime():
    workflow = WORKFLOW.read_text(encoding="utf-8")
    assert 'find "$MODEL_ROOT" -type f -printf' in workflow
    assert "known FunASR interpreter diagnostic" in workflow
    assert "system Python FunASR diagnostic" in workflow
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
