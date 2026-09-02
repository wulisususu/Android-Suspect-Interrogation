from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
HEAD = "0011_speaker_backend_comparison_evidence"


def replace_once(path: str, old: str, new: str) -> None:
    target = ROOT / path
    text = target.read_text(encoding="utf-8")
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"{path}: expected exactly one anchor, found {count}: {old!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


replace_once(
    "linux/backend/tests/test_migrations.py",
    'RECOGNITION_EVIDENCE_TABLES = {\n    "asr_recognition_evidence", "asr_recognition_revisions",\n}',
    'RECOGNITION_EVIDENCE_TABLES = {\n    "asr_recognition_evidence", "asr_recognition_revisions",\n    "speaker_backend_comparison_evidence",\n}',
)
replace_once(
    "linux/backend/tests/test_migrations.py",
    'ALEMBIC_HEAD = "0010_backend_scoped_speaker_calibration"',
    f'ALEMBIC_HEAD = "{HEAD}"',
)
replace_once(
    "linux/backend/tests/test_migrations.py",
    '        revision_columns = {item["name"] for item in inspector.get_columns("asr_recognition_revisions")}\n        assert {\n            "fragment_id", "revision_no", "before_speaker", "after_speaker", "before_text",\n            "after_text", "actor_id", "reason",\n        } <= revision_columns',
    '        revision_columns = {item["name"] for item in inspector.get_columns("asr_recognition_revisions")}\n        assert {\n            "fragment_id", "revision_no", "before_speaker", "after_speaker", "before_text",\n            "after_text", "actor_id", "reason",\n        } <= revision_columns\n        compare_columns = {item["name"] for item in inspector.get_columns("speaker_backend_comparison_evidence")}\n        assert {\n            "fragment_id", "capture_session_id", "case_id", "backend_key", "authoritative",\n            "available", "role", "speaker_source", "voiceprint_verified", "score",\n            "second_best_score", "threshold", "margin", "calibration_id", "calibration_status",\n            "model_id", "model_version", "model_fingerprint", "latency_ms", "error_code",\n            "candidate_scores_json",\n        } <= compare_columns\n        assert {"embedding", "pcm", "audio"}.isdisjoint(compare_columns)',
)

replace_once(
    "linux/backend/tests/test_dual_speaker_voiceprint_migration.py",
    'EXPECTED_HEAD = "0010_backend_scoped_speaker_calibration"',
    f'EXPECTED_HEAD = "{HEAD}"',
)

replace_once(
    "linux/backend/tests/test_speaker_calibration_migration_contract.py",
    '        assert "asr_recognition_revisions" in tables',
    '        assert "asr_recognition_revisions" in tables\n        assert "speaker_backend_comparison_evidence" in tables',
)
replace_once(
    "linux/backend/tests/test_speaker_calibration_migration_contract.py",
    '        assert revision == "0010_backend_scoped_speaker_calibration"',
    f'        assert revision == "{HEAD}"',
)

print("Task 9 compare persistence migration contracts aligned with 0011")
