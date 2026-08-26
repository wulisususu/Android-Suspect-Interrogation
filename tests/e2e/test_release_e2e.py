import json
import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


EXPECTED_EVENTS = [
    "boot",
    "case_created",
    "identity_read",
    "session_start",
    "recording_mock",
    "asr_mock",
    "message_added",
    "ai_mock",
    "message_edit",
    "revision_created",
    "message_marked",
    "session_pause",
    "session_resume",
    "session_finish",
    "freeze",
    "signature_mock",
    "report_created",
    "service_restart",
    "data_verified",
    "backup_created",
    "restore_verified",
]


def test_mock_release_e2e_covers_full_offline_lifecycle(tmp_path):
    result = subprocess.run(
        [
            "python3",
            str(ROOT / "scripts" / "mock_e2e.py"),
            "--state-dir",
            str(tmp_path / "state"),
            "--backup-dir",
            str(tmp_path / "backups"),
        ],
        cwd=ROOT,
        check=True,
        text=True,
        capture_output=True,
    )
    payload = json.loads(result.stdout)

    assert payload["events"] == EXPECTED_EVENTS
    assert payload["case_id"] == "E2E-CASE-001"
    assert len(payload["freeze_sha256"]) == 64
    assert payload["signature_binding"].endswith(payload["freeze_sha256"])
    assert payload["restored_integrity"] == "ok"
    assert payload["model_downloads"] == 0
