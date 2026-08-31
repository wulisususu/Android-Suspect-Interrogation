# Speaker Device Calibration Center Design

Date: 2026-08-31
Branch: `linux-adaptation`
Status: Approved in chat; implementation not started

## 1. Purpose

Introduce a system-level **Device Calibration Center** for speaker recognition. It automatically derives production speaker-recognition operating parameters from the global officer voiceprint library, persists calibration history, exposes FAR/FRR/EER metrics, and detects when a calibration has become stale because the XVector model or microphone changed.

This feature must preserve the existing P0 behavior:

- Missing or stale device calibration **must never block interrogation**.
- A missing suspect voiceprint remains the only voiceprint-related hard gate for formal voiceprint interrogation.
- If no valid device calibration is available, runtime falls back to the model baseline threshold.

## 2. Non-goals

- Do not persist raw PCM/WAV calibration audio.
- Do not make browser-test microphone calibration authoritative for Linux production.
- Do not automatically rewrite historical case/session decisions when a newer calibration appears.
- Do not claim population-level biometric certification from the internal officer corpus. FAR/FRR/EER reported here are **observed estimates on the local calibration corpus**.

## 3. Architecture

Add an independent calibration subsystem under system settings:

```text
System Settings
├── Officer Voiceprint Library
└── Device Calibration Center
        │
        ├── Calibration corpus resolver
        ├── Trial builder
        ├── Threshold/margin optimizer
        ├── FAR/FRR/EER calculator
        ├── Calibration history repository
        └── Staleness evaluator
```

`speaker_policy.py` remains a pure decision function. It continues receiving `threshold` and `margin` from the caller and does not read the database, environment, model registry, or hardware state.

A new runtime calibration resolver chooses the active operating point before a speech session starts.

## 4. Calibration corpus

### 4.1 Source

The calibration corpus is built automatically from active `OfficerVoiceSample` records in the global officer voiceprint library.

Each sample must contribute:

- officer/profile identity
- embedding
- quality
- usable speech duration
- captured time
- audio source
- device identifier/name/fingerprint
- speaker model id/version/fingerprint

Raw audio is not required and is not persisted.

### 4.2 Production microphone isolation

A production calibration is microphone-specific.

For Linux production (`ALSA`), only officer samples compatible with the target production microphone fingerprint are eligible for authoritative calibration. Samples recorded through `BROWSER` are excluded from an ALSA production calibration.

Browser-mode calibration may be computed for development diagnostics, but it is stored as `BROWSER_TEST` and must never become the authoritative Linux production calibration.

### 4.3 Model isolation

Only samples produced with the current XVector model fingerprint are eligible for authoritative calibration. Samples from older model fingerprints remain in the voiceprint library for history/audit but are excluded from the current calibration corpus unless they are re-embedded by an explicit future migration process.

### 4.4 Minimum data

A full threshold + margin + FAR/FRR/EER calibration requires:

- at least **3 distinct eligible officer identities**;
- each eligible identity must have at least **3 active compatible samples**;
- therefore at least **9 total compatible samples**.

If the corpus does not meet this requirement, status is `INSUFFICIENT_DATA`. Interrogation still works using fallback threshold policy.

## 5. Trial construction

For each eligible sample of officer `A`:

1. Build a leave-one-out reference for `A` from A's other eligible samples.
2. Compare the held-out sample against A's leave-one-out reference to create a **genuine trial**.
3. Compare the same held-out sample against aggregate references for every other eligible officer to create **impostor trials**.
4. Retain the highest wrong-identity score and, where applicable, the second-highest competing score for margin analysis.

All embeddings are L2-normalized before cosine similarity is calculated.

This prevents a sample from being evaluated against a reference containing itself.

## 6. Metrics

For an operating threshold `T`:

- `FRR = false_reject_genuine_trials / genuine_trials`
- `FAR = false_accept_impostor_trials / impostor_trials`

For multi-speaker attribution, a candidate additionally must satisfy a top-1/top-2 margin `M`.

### 6.1 EER

EER is computed by sweeping candidate thresholds over observed genuine and impostor score boundaries and selecting the point where `abs(FAR - FRR)` is minimized.

Persist:

- `eer`
- `eer_threshold`
- `eer_far`
- `eer_frr`

If multiple candidates tie, prefer the higher threshold to preserve the system's security-first bias.

### 6.2 Production operating point

The production threshold/margin search is separate from EER reporting.

Primary objective:

1. Prefer candidates with observed `FAR == 0`.
2. Among those, minimize FRR.
3. Among ties, maximize robustness buffer.
4. Among remaining ties, prefer higher threshold, then higher margin.

If no candidate achieves observed `FAR == 0`, minimize:

`10 * FAR + FRR`

then maximize robustness buffer and prefer the higher threshold.

The UI must label the result as a local finite-corpus estimate rather than biometric certification.

## 7. Persistent model

Add Alembic migration `0005_speaker_device_calibration.py`.

Introduce immutable calibration history rows, conceptually:

```text
SpeakerDeviceCalibration
├── id
├── status_at_creation
├── threshold
├── margin
├── far
├── frr
├── eer
├── eer_threshold
├── genuine_trial_count
├── impostor_trial_count
├── officer_count
├── sample_count
├── corpus_digest
├── algorithm_version
├── speaker_model_id
├── speaker_model_version
├── speaker_model_fingerprint
├── audio_source
├── microphone_id
├── microphone_name
├── microphone_fingerprint
├── created_at
└── created_by
```

Rows are never updated to replace statistical results. Recalibration creates a new row. Runtime status is computed relative to current model/device/corpus state.

## 8. Fingerprints

### 8.1 XVector fingerprint

The speech worker exposes a stable `speaker_model_fingerprint` in health/capability metadata.

The fingerprint is computed once when the XVector runtime initializes and cached. It is a SHA-256 manifest derived from the actual model files, using deterministic sorted relative paths and content hashes. This is intentionally stronger than path/version strings so replacing model bytes automatically changes the fingerprint.

Persist both human-readable `model_id/model_version` and the machine-authoritative fingerprint.

### 8.2 Microphone fingerprint

For Linux ALSA production, compute a stable microphone fingerprint from available hardware identity:

- ALSA card/device identity;
- USB/vendor/product identifiers when available;
- device serial when available.

The canonical fingerprint is a SHA-256 hash of normalized identity fields. If a serial number is unavailable, use the most stable available ALSA + udev identity and surface that the fingerprint has reduced hardware certainty.

For browser mode, use browser device metadata only for development records and mark source `BROWSER_TEST`.

## 9. Calibration status model

The API exposes one effective status:

- `NOT_CALIBRATED`: no historical DB calibration exists.
- `VALID`: latest applicable calibration matches current XVector fingerprint and microphone fingerprint.
- `STALE_MODEL`: calibration exists but XVector fingerprint changed.
- `STALE_MIC`: calibration exists but production microphone fingerprint changed.
- `RECOMPUTE_RECOMMENDED`: calibration remains usable, but the compatible officer corpus has grown materially.
- `INSUFFICIENT_DATA`: current compatible corpus cannot produce a full calibration.

Precedence when multiple conditions apply:

`STALE_MODEL > STALE_MIC > INSUFFICIENT_DATA > RECOMPUTE_RECOMMENDED > VALID`

`NOT_CALIBRATED` applies only when no DB calibration history exists.

## 10. Recalibration triggers

### 10.1 XVector replacement — hard expiry

If current `speaker_model_fingerprint` differs from the stored calibration fingerprint:

- status becomes `STALE_MODEL` immediately;
- the stored calibrated threshold/margin must not be used for new sessions;
- runtime falls back to the model baseline threshold;
- UI displays a red "XVector 已更换，需要重新校准" warning.

### 10.2 Microphone replacement — hard expiry with prompt

If the current production microphone fingerprint differs:

- status becomes `STALE_MIC`;
- the stored calibrated threshold/margin must not be used for new sessions;
- runtime falls back to the model baseline threshold;
- UI displays a red "检测到麦克风已更换，请重新校准" warning.

This is intentionally stricter than a passive reminder because microphone frequency response, gain, DSP/noise suppression, and placement can alter XVector score distributions.

### 10.3 Material corpus growth — advisory recomputation

At calibration time persist the compatible `sample_count`, eligible `officer_count`, and `corpus_digest`.

Afterward, set `RECOMPUTE_RECOMMENDED` when either:

- eligible compatible sample count increased by **at least 3 samples**, or
- eligible compatible sample count increased by **at least 25%** relative to the calibration corpus,

whichever threshold is reached first; or when at least one new eligible officer identity becomes available.

This status is advisory. The prior calibration remains usable because model and microphone are unchanged.

Small corpus changes do not continuously churn calibration values.

## 11. Runtime calibration resolver

For every **new** formal speech session, resolve and snapshot the operating point once.

Resolution order:

1. If a DB calibration exists and status is `VALID` or `RECOMPUTE_RECOMMENDED`, use its threshold/margin and report `thresholdSource=DEVICE_CALIBRATED`.
2. If DB calibration history exists but the applicable calibration is `STALE_MODEL`, `STALE_MIC`, or `INSUFFICIENT_DATA`, do **not** use legacy env calibration values. Use `MODEL_BASELINE` for threshold and degrade to suspect-only behavior when no trustworthy margin exists.
3. Only when **no DB calibration history exists at all**, allow existing `SUSPECT_SPEAKER_ACCEPT_THRESHOLD` / `SUSPECT_SPEAKER_MARGIN` values as a temporary backward-compatibility source, reported as `LEGACY_ENV`.
4. Otherwise use `MODEL_BASELINE`.

This prevents stale env values from silently bypassing automatic expiry.

## 12. Session immutability

Calibration changes must not mutate an active interrogation.

When formal ASR starts, snapshot:

- calibration id, if any
- threshold
- margin
- threshold source
- XVector fingerprint
- microphone fingerprint
- calibration status at session start

A recalibration performed during an active interrogation affects only later sessions.

This matches the existing frozen officer-reference policy and provides reproducible audit evidence.

## 13. API

Add a system-level calibration API, for example:

- `GET /speaker-calibration/status`
- `GET /speaker-calibration/history`
- `POST /speaker-calibration/recompute`

`POST /recompute` does not accept arbitrary threshold/margin values. It computes them from the eligible global voiceprint corpus and current model/device identity.

Response includes:

- status/reason
- threshold/margin/source
- FAR/FRR/EER
- counts
- model metadata/fingerprint
- microphone metadata/fingerprint
- calibration date
- recompute recommendation reason

Calibration actions emit a global audit event (`case_id = null`).

## 14. System Settings UI

Extend `SystemSettingsView` with two system-owned sections/tabs:

```text
系统设置
├── 民警声纹库
└── 设备校准中心
```

The calibration center shows:

- current status with red/yellow/green severity;
- XVector model/version;
- production microphone;
- last calibration date;
- threshold;
- margin;
- observed FAR;
- observed FRR;
- observed EER;
- eligible officer/sample counts;
- explicit stale/recompute reason;
- `重新计算校准` action;
- immutable history list.

When `INSUFFICIENT_DATA`, show exactly what is missing, e.g. "需要至少 3 名民警，每人至少 3 个当前模型/当前麦克风下的有效样本".

Calibration warnings are system-setting warnings, not case-preparation blockers.

## 15. Interaction with officer voiceprint library

Adding or disabling officer samples updates the corpus evaluator but does not immediately change current threshold/margin.

- Sample addition may produce `RECOMPUTE_RECOMMENDED` according to the growth rule.
- Disabled samples are excluded from future calibration corpora.
- Existing calibration history remains immutable.
- The officer profile aggregate reference and calibration corpus are related but distinct: runtime identification uses aggregate officer references; calibration uses individual compatible samples to construct genuine/impostor trials.

## 16. Backward compatibility

Existing environment-based calibration remains readable only as `LEGACY_ENV` when the installation has never created a database calibration record.

After the first database calibration exists, DB calibration lifecycle rules become authoritative.

Existing P0 model baseline behavior remains the final fallback and continues to permit interrogation.

## 17. Testing strategy

Use TDD. Required regression coverage:

### Backend math

- genuine/impostor leave-one-out trial construction;
- FAR calculation;
- FRR calculation;
- EER threshold selection and tie behavior;
- threshold/margin optimizer security-first ordering;
- insufficient corpus handling.

### Lifecycle

- matching model + mic => `VALID`;
- XVector fingerprint change => `STALE_MODEL` and baseline fallback;
- microphone fingerprint change => `STALE_MIC` and baseline fallback;
- +3 samples triggers recompute recommendation;
- +25% samples triggers recompute recommendation;
- new eligible officer triggers recompute recommendation;
- small corpus growth does not trigger recommendation;
- stale DB calibration cannot be bypassed by legacy env values;
- no DB history may still use legacy env values.

### Persistence/API

- Alembic upgrade/downgrade gate;
- immutable calibration history;
- status/history/recompute API contract;
- audit event emission;
- no raw audio persistence.

### Runtime/session

- new session snapshots calibration id/threshold/margin/source/model/mic fingerprints;
- recalibration during an active session does not alter that session;
- stale/missing calibration never blocks formal interrogation;
- missing suspect voiceprint still blocks as previously specified.

### Frontend

- calibration center renders status and metrics;
- stale model/mic warnings;
- insufficient-data explanation;
- recompute recommendation warning;
- history display;
- no calibration controls reappear in case pages.

### Verification gates

- Hosted Linux CI;
- Python backend full test suite;
- Alembic migration gate;
- Vue unit tests;
- TypeScript typecheck;
- production frontend build;
- release/E2E gates;
- RK3588 backend + Vue + release smoke;
- RK3588 device fingerprint/model fingerprint smoke where hardware is available.

## 18. Acceptance criteria

The feature is complete only when all of the following hold:

1. A production operator can open System Settings → Device Calibration Center and compute a calibration using only eligible global officer voiceprint samples.
2. The result persists threshold, margin, observed FAR/FRR/EER, model identity, microphone identity, corpus counts, and date.
3. Replacing XVector automatically makes prior calibration unusable for new sessions.
4. Replacing the microphone automatically makes prior calibration unusable for new sessions and prompts recalibration.
5. Material sample growth produces an advisory recomputation state without blocking interrogation.
6. Missing/stale calibration falls back safely and does not block interrogation.
7. Active sessions keep the calibration snapshot they started with.
8. Historical calibration rows remain auditable and immutable.
9. No raw calibration audio is persisted.
10. Hosted and RK3588 verification gates pass for the final implementation commit.
