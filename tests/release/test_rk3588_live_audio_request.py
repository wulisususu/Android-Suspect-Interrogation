from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
REQUEST = ROOT / ".github" / "live-audio-request.json"
WORKFLOW = ROOT / ".github" / "workflows" / "rk3588-live-audio-request.yml"


def test_live_audio_request_defaults_disabled_and_has_bounded_inputs():
    assert REQUEST.is_file()
    payload = json.loads(REQUEST.read_text(encoding="utf-8"))

    assert payload["enabled"] is False
    assert payload["requestId"] == "idle"
    assert 5 <= int(payload["captureSeconds"]) <= 30
    assert payload["alsaDevice"] == "default"
    assert isinstance(payload["requireAsrText"], bool)


def test_branch_request_workflow_is_allowlisted_and_has_no_arbitrary_shell_input():
    assert WORKFLOW.is_file(), "branch-scoped live audio request workflow is missing"
    source = WORKFLOW.read_text(encoding="utf-8")

    for required in (
        "push:",
        "linux-adaptation",
        ".github/live-audio-request.json",
        "runs-on: [self-hosted, rk3588]",
        "rk3588-live-audio-acceptance.py",
        "captureSeconds",
        "alsaDevice",
        "requireAsrText",
        "enabled",
        "requestId",
        "codeload.github.com",
        "START SPEAKING NOW",
    ):
        assert required in source

    lowered = source.lower()
    assert "workflow_dispatch:" not in source
    assert "pull_request:" not in source
    assert "shell_command" not in lowered
    assert "bash -c" not in lowered
    assert "eval " not in lowered
    assert "upload-artifact" not in lowered
    assert ".wav" not in lowered
    assert ".pcm" not in lowered
