# Task 9 post-apply validation

Task 9 adds non-authoritative speaker compare execution and evidence while preserving exactly one business speaker mutation per ASR fragment.

## Production commit

- `653aba2e07578d20f5e3adf337eeb77b3df40a6b` — `feat: add non-authoritative speaker compare mode`

## RED evidence

- Linux CI `33585869381`: 3 failed / 379 passed.
- The failures were the intended missing contracts only:
  - `AsrCaptureService` did not accept `speaker_authoritative_backend` (2 tests).
  - `SpeechWorkerClient.open_session()` did not accept/forward `authoritative_backend` (1 test).

## GREEN gate

- Task 9 Compare Capture GREEN `33586081397`.
- Targeted compare/capture/session/protocol/evidence suite: 28 passed.
- Full backend regression: 382 passed.
- Production files were committed only after both gates passed.

## Invariants

- `speaker_backend=compare` requires an explicit concrete authoritative backend.
- The same utterance PCM is evaluated by XVector and ERes2Net-large.
- Only the authoritative backend may create the business `SPEAKER_RESULT` decision and mutate the ASR fragment.
- Secondary output is diagnostic-only `SPEAKER_COMPARE_RESULT` and persists to the separate comparison evidence table.
- Authoritative failure remains conservative `UNKNOWN`; a successful secondary result is never promoted.
- Secondary backend failure, missing reference, or calibration unavailability cannot corrupt the authoritative fragment.
- Comparison evidence stores scores, roles, candidate scores, calibration/model metadata, latency, and errors; it does not store embeddings, PCM, or audio payloads.
- Single-backend XVector remains the default compatibility path and still omits the new backend arguments where legacy callers expect the historical call shape.

## Remaining acceptance

The bot-authored production commit caused standard GitHub workflows to report `action_required`, so this user-authored evidence commit intentionally retriggers the standard hosted Linux CI. Task 9 is not considered fully closed until that standard hosted chain passes through Browser screenshot QA and release integration/E2E.
