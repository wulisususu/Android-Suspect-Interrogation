from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WORKFLOW = ROOT / ".github" / "workflows" / "linux-ci.yml"


def test_rk3588_tests_use_isolated_mutable_runtime_paths():
    workflow = WORKFLOW.read_text(encoding="utf-8")
    assert 'RK3588_TEST_ROOT="$RUNNER_TEMP/suspect-linux-ci"' in workflow
    assert 'export SUSPECT_DATA_DIR="$RK3588_TEST_ROOT/data"' in workflow
    assert 'export SUSPECT_LOG_DIR="$RK3588_TEST_ROOT/log"' in workflow
    assert 'export SUSPECT_DB_PATH="$RK3588_TEST_ROOT/interrogation.db"' in workflow
    assert 'export SUSPECT_MIN_FREE_MB=0' in workflow
    assert 'rm -rf "$RK3588_TEST_ROOT"' in workflow


def test_rk3588_checkout_falls_back_to_sha_pinned_source_archive():
    workflow = WORKFLOW.read_text(encoding="utf-8")

    assert "codeload.github.com/${GITHUB_REPOSITORY}/tar.gz/${GITHUB_SHA}" in workflow
    assert "--strip-components=1" in workflow
    assert "source archive root does not match requested SHA" in workflow
