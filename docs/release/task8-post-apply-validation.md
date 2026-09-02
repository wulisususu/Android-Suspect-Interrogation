# Task 8 Post-Apply Validation

Task 8 isolates speaker calibration by backend/model/microphone identity.

Production implementation commit:

- `fe2a80644d8e3416a62be41cc5ec7c29f8658c95` — `feat: calibrate speaker backends independently`

Deterministic Task 8 gate evidence:

- Workflow run `33583730209`
- Calibration targeted tests: 21 passed
- Migration contract tests: 8 passed
- Full backend regression: 365 passed
- Alembic head: `0010_backend_scoped_speaker_calibration`

Implemented invariants:

- Calibration rows and immutable capture snapshots persist `speaker_backend_key` separately from model fingerprint.
- Exact calibration lookup is scoped by backend key + speaker model fingerprint + microphone fingerprint.
- XVector and ERes2Net-large calibration histories cannot become each other's operating point.
- Stale-model and stale-microphone decisions are evaluated only within the selected backend's history.
- Existing calibration rows are migrated as historical XVector rows; no embedding data is rewritten.
- Formal ASR capture freezes the selected backend and calibration identity into the session calibration snapshot.
- Runtime model identity resolves the selected speaker backend from worker backend health.

This document is a user-authored trigger for the standard Linux hosted gate because GitHub marks workflows triggered by the bot-authored production commit as `action_required`. Task 8 is not considered fully closed until the standard Linux hosted gate, including Browser screenshot QA and release integration/E2E, passes on this tree.
