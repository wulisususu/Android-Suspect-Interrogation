from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
HEAD = "0010_backend_scoped_speaker_calibration"


def replace_once(path: str, old: str, new: str) -> None:
    target = ROOT / path
    text = target.read_text(encoding="utf-8")
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"{path}: expected exactly one anchor, found {count}: {old!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


replace_once(
    "linux/backend/tests/test_dual_speaker_voiceprint_migration.py",
    'EXPECTED_HEAD = "0009_dual_speaker_backends"',
    f'EXPECTED_HEAD = "{HEAD}"',
)

replace_once(
    "linux/backend/tests/test_speaker_calibration_migration_contract.py",
    '            "speaker_model_fingerprint", "microphone_fingerprint", "corpus_digest",',
    '            "speaker_backend_key", "speaker_model_fingerprint", "microphone_fingerprint", "corpus_digest",',
)
replace_once(
    "linux/backend/tests/test_speaker_calibration_migration_contract.py",
    '        assert revision == "0009_dual_speaker_backends"',
    f'        assert revision == "{HEAD}"',
)

print("Task 8 migration contracts aligned with 0010")
