# Speaker Device Calibration Center Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a system-level speaker device calibration center that derives threshold/margin and observed FAR/FRR/EER from the global officer voiceprint library, persists immutable calibration history, detects XVector/microphone drift, recommends recalibration after material corpus growth, and snapshots the selected operating point for each formal interrogation session.

**Architecture:** Keep `speaker_policy.py` pure. Add a calibration math module, immutable SQLAlchemy/Alembic persistence, model/microphone fingerprint helpers, a calibration lifecycle service and runtime resolver. The service reads individual active officer samples, filters them by current XVector and production microphone identity, computes leave-one-out genuine/impostor trials, stores one immutable calibration row per recompute, and reports an effective lifecycle status. `AsrCaptureService` resolves calibration once at formal capture start and freezes that result in the capture/session runtime. The system-settings UI exposes status, metrics, history and recompute; case pages remain calibration-free.

**Tech Stack:** Python 3.11+, FastAPI, SQLAlchemy 2, Alembic, SQLite, FunASR/XVector speech worker, ALSA HAL, Vue 3, TypeScript, Axios, Vitest.

**Spec:** `docs/superpowers/specs/2026-08-31-speaker-device-calibration-center-design.md`

## Global Constraints

- Calibration is system-owned and must never become a case-preparation hard gate.
- Missing/stale calibration falls back safely; missing suspect voiceprint remains the only voiceprint-related hard gate for formal interrogation.
- Production calibration is scoped to current XVector fingerprint and current Linux ALSA microphone fingerprint.
- Browser calibration is development-only (`BROWSER_TEST`) and cannot become authoritative for Linux production.
- No raw PCM/WAV calibration audio is persisted.
- Historical calibration rows are immutable; recomputation creates a new row.
- A formal interrogation snapshots calibration values once; later recompute must not alter the active session.
- Once DB calibration history exists, stale DB lifecycle state must not be bypassed by legacy env threshold/margin values.
- FAR/FRR/EER are explicitly local finite-corpus estimates, not biometric certification.

---

### Task 1: Persistence contract and migration 0005

**Files:**
- Modify: `linux/backend/app/database/voiceprint_models.py`
- Modify: `linux/backend/app/database/session.py`
- Create: `linux/backend/alembic/versions/0005_speaker_device_calibration.py`
- Modify: `linux/backend/tests/test_migrations.py`
- Create: `linux/backend/tests/test_speaker_calibration_repository.py`

**Interfaces:**
- `SpeakerDeviceCalibration` immutable ORM row with threshold, margin, FAR/FRR/EER, trial/corpus counts, corpus digest, algorithm version, model identity/fingerprint, audio source, microphone identity/fingerprint, creator and timestamp.
- `SessionSpeakerCalibrationSnapshot` persists the operating point frozen for a formal capture/session.

- [ ] Write failing migration/repository tests for 0005 tables, immutable history append behavior, and snapshot persistence.
- [ ] Push tests and verify CI is red only on the missing schema/repository contract.
- [ ] Implement ORM models, import registration and Alembic 0005 upgrade/downgrade.
- [ ] Implement a focused repository for latest/history/create/snapshot operations.
- [ ] Re-run targeted tests and make them green.

### Task 2: Pure calibration math and local metrics

**Files:**
- Create: `linux/backend/app/services/speaker_calibration_math.py`
- Create: `linux/backend/tests/test_speaker_calibration_math.py`
- Modify: `scripts/ci/rk3588-speech-calibrate.py`

**Interfaces:**
- L2 normalize/cosine/centroid helpers.
- Leave-one-out genuine and impostor trial builder.
- `compute_eer(...)` returning EER, threshold, FAR and FRR.
- `choose_operating_point(...)` implementing security-first threshold/margin optimization.

- [ ] Write failing deterministic tests for trial construction, FAR, FRR, EER tie behavior, and operating-point ordering.
- [ ] Verify red.
- [ ] Implement the pure math module with no DB/hardware dependency.
- [ ] Refactor the RK3588 calibration script to reuse the shared math rather than maintain a divergent algorithm.
- [ ] Verify targeted math/script tests green.

### Task 3: XVector and microphone fingerprints

**Files:**
- Create: `linux/backend/app/ai/speech/fingerprint.py`
- Modify: `linux/backend/speech_worker/funasr_runtime.py`
- Modify: `linux/backend/hardware/audio/alsa.py`
- Modify: `linux/backend/app/services/officer_voiceprint_library.py`
- Modify: `linux/backend/app/database/voiceprint_models.py`
- Modify: `linux/backend/alembic/versions/0005_speaker_device_calibration.py`
- Create: `linux/backend/tests/test_speaker_fingerprints.py`
- Modify: `linux/backend/tests/test_funasr_runtime_adapter.py`

**Interfaces:**
- Deterministic SHA-256 XVector model-directory manifest cached after runtime load and exposed by speech-worker health as `speaker_model_fingerprint`.
- Stable microphone fingerprint helper from normalized ALSA/device metadata, with certainty metadata.
- New officer samples retain model and microphone fingerprints so corpus filtering is possible.

- [ ] Write failing tests proving stable fingerprints and change-on-model-bytes / change-on-device-identity behavior.
- [ ] Verify red.
- [ ] Implement fingerprint helpers and expose XVector fingerprint through speech health.
- [ ] Capture current model/mic fingerprints with newly enrolled officer samples; keep legacy migrated samples audit-only/unqualified when fingerprints are missing.
- [ ] Verify targeted tests green.

### Task 4: Calibration lifecycle service and recalibration triggers

**Files:**
- Create: `linux/backend/app/repositories/speaker_calibrations.py`
- Create: `linux/backend/app/services/speaker_calibration_service.py`
- Create: `linux/backend/tests/test_speaker_calibration_service.py`

**Interfaces:**
- Status values: `NOT_CALIBRATED`, `VALID`, `STALE_MODEL`, `STALE_MIC`, `RECOMPUTE_RECOMMENDED`, `INSUFFICIENT_DATA`.
- Minimum corpus: 3 compatible officers, each with at least 3 compatible active samples.
- Recompute trigger: +3 compatible samples OR +25% compatible samples OR any new eligible officer.
- Status precedence: model stale > mic stale > insufficient > recompute recommended > valid.

- [ ] Write failing status/recompute tests for all lifecycle states and precedence.
- [ ] Verify red.
- [ ] Implement current identity resolver, compatible-corpus filtering, digesting, metrics, immutable recompute and lifecycle evaluation.
- [ ] Emit global audit records for recompute.
- [ ] Verify targeted tests green.

### Task 5: Runtime resolver and immutable formal-session snapshot

**Files:**
- Modify: `linux/backend/app/ai/speech/calibration.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `linux/backend/app/main.py`
- Modify: `linux/backend/tests/test_speaker_baseline_fallback.py`
- Create: `linux/backend/tests/test_speaker_calibration_runtime.py`

**Interfaces:**
- Runtime resolution order: valid/recompute DB calibration -> stale DB baseline fallback -> no-history legacy env -> model baseline.
- Sources: `DEVICE_CALIBRATED`, `LEGACY_ENV`, `MODEL_BASELINE`.
- `_CaptureRuntime` freezes calibration id, threshold, margin, source, model/mic fingerprints and status at start.

- [ ] Write failing tests proving stale DB cannot be bypassed by env, no-history env remains compatible, valid DB wins, and active capture stays frozen after recalibration.
- [ ] Verify red.
- [ ] Inject resolver into formal ASR start and persist session/capture snapshot.
- [ ] Ensure missing margin degrades to suspect-only without blocking.
- [ ] Verify targeted tests green.

### Task 6: System-level calibration API

**Files:**
- Create: `linux/backend/app/api/speaker_calibration.py`
- Modify: `linux/backend/app/main.py`
- Create: `linux/backend/tests/test_speaker_calibration_api.py`

**Interfaces:**
- `GET /api/v1/speaker-calibration/status`
- `GET /api/v1/speaker-calibration/history`
- `POST /api/v1/speaker-calibration/recompute`

- [ ] Write failing API tests for status/history/recompute, insufficient-data response, observed-metric labels, and global audit.
- [ ] Verify red.
- [ ] Implement router/service wiring; do not accept caller-provided threshold/margin.
- [ ] Verify API tests green.

### Task 7: Device Calibration Center UI

**Files:**
- Create: `webapp/src/api/speakerCalibration.ts`
- Create: `webapp/src/components/SpeakerCalibrationCenter.vue`
- Create: `webapp/src/components/SpeakerCalibrationCenter.test.ts`
- Modify: `webapp/src/views/SystemSettingsView.vue`
- Modify: `webapp/src/App.test.ts`

**Interfaces:**
- System Settings contains independent `民警声纹库` and `设备校准中心` tabs.
- Center displays lifecycle state/severity, threshold/margin, local FAR/FRR/EER, XVector/model, microphone, calibration date, corpus counts, recompute reason and immutable history.
- Red warnings for stale model/mic; yellow warning for recompute recommended; explicit minimum-corpus explanation for insufficient data.

- [ ] Write failing Vue tests for all required states and absence of case-scoped calibration controls.
- [ ] Verify red.
- [ ] Implement API/types/component/settings tabs.
- [ ] Run Vitest, typecheck and production build green.

### Task 8: Full regression, docs and RK3588 verification

**Files:**
- Modify as required: `linux/docs/api-contract-v1.md`
- Modify as required: `docs/security/AUDIT-EVENTS.md`
- Modify as required: RK3588 smoke tests/workflows only where necessary to verify fingerprints/status without touching production services.

- [ ] Run full backend suite and migration gates.
- [ ] Run Vue tests, TypeScript typecheck and production build.
- [ ] Run release/E2E/security gates from `linux-ci.yml`.
- [ ] Verify final HEAD on Hosted Linux CI.
- [ ] Verify final HEAD on RK3588 backend/Vue/release smoke; fingerprint checks must be read-only and must not restart or modify the existing FunASR service on port 8000.
- [ ] Update API/audit documentation.
- [ ] Perform placeholder/spec-coverage review and verification-before-completion.

## Acceptance Checklist

- [ ] Calibration can be recomputed using only eligible global officer voiceprint samples.
- [ ] threshold, margin, local FAR/FRR/EER, model/mic identity, counts and date are immutable history.
- [ ] XVector replacement causes `STALE_MODEL` and baseline fallback for new sessions.
- [ ] Microphone replacement causes `STALE_MIC` and baseline fallback for new sessions.
- [ ] Material corpus growth causes advisory `RECOMPUTE_RECOMMENDED` without blocking interrogation.
- [ ] Active formal sessions retain their frozen calibration snapshot.
- [ ] No raw calibration audio is stored.
- [ ] Case pages do not own calibration controls.
- [ ] Final Hosted Linux and RK3588 gates are green, excluding any explicitly pre-existing unrelated XVector vendor-compatibility gate documented separately.
