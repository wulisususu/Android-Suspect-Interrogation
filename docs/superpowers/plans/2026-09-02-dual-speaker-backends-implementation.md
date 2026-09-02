# Dual Speaker Verification Backends Implementation Plan

> **For agentic workers:** Follow `superpowers:test-driven-development` during implementation; use `superpowers:verification-before-completion` before claiming any task complete. Execute task-by-task with `superpowers:subagent-driven-development` (recommended) or `superpowers:executing-plans`.

**Goal:** Add XVector + ERes2Net-large as coexisting, selectable speaker-verification backends so one enrollment capture can generate independent references for both models, both can be calibrated and compared on the same RK3588/microphone/utterances, and the final authoritative backend can be selected by configuration without another code rewrite.

**Architecture:** Introduce a backend-neutral speaker-embedding contract and registry. Preserve the existing XVector path as one implementation; add a local/offline ERes2Net-large implementation. Keep `speaker_policy.py` shared and deterministic. Persist voiceprint references by logical identity + speaker backend/model key instead of assuming one vector per identity. Calibration remains model-fingerprint + microphone-fingerprint scoped. `compare` mode runs both models but emits exactly one authoritative business decision and stores/returns the other as diagnostics only.

**Tech Stack:** Python 3.10/3.11, FastAPI, SQLAlchemy 2, Alembic, SQLite, FunASR, ModelScope/3D-Speaker PyTorch inference, NumPy, Vue 3, TypeScript, Axios, Vitest, GitHub Actions, RK3588 Ubuntu 22.04.

**Spec:** `docs/superpowers/specs/2026-09-02-dual-speaker-backends-design.md`

## Global Constraints

- Default remains `xvector` until the user explicitly selects another backend after RK3588 comparison.
- XVector and ERes2Net embeddings are never copied/converted across feature spaces.
- One enrollment PCM may be reused in memory to generate two independent references.
- No automatic historical ERes2Net backfill without source enrollment audio.
- A normal Alembic schema migration is allowed/required; this is not a biometric data migration.
- XVector and ERes2Net thresholds/margins/calibrations are independent.
- `compare` mode has exactly one authoritative backend for business mutation.
- `speaker_policy.py` stays shared unless real evidence demonstrates incompatible score semantics.
- Paraformer, FSMN-VAD, Qwen routing, formal-record behavior and TCP/8000 are out of scope.
- No NPU/RKNN conversion of ERes2Net in this phase; benchmark CPU correctness and latency first.
- Never persist or fabricate model chain-of-thought or unrelated data; speaker evidence remains model/provenance/audit metadata only.

---

### Task 1: Introduce backend identifiers, configuration, and backend-neutral contract

**Files:**
- Create: `linux/backend/speech_worker/speaker/__init__.py`
- Create: `linux/backend/speech_worker/speaker/base.py`
- Create: `linux/backend/speech_worker/speaker/registry.py`
- Modify: `linux/backend/speech_worker/funasr_runtime.py`
- Modify: `linux/backend/config/model-registry.yaml`
- Create: `linux/backend/tests/test_speaker_backend_registry.py`
- Modify: `linux/backend/tests/test_funasr_runtime_adapter.py`

**Interfaces:**
- `SpeakerBackendKey`: `xvector`, `eres2net_large`, `compare` only at runtime-selection layer.
- `SpeakerEmbeddingBackend.extract_embedding(pcm, sample_rate) -> SpeakerEmbeddingResult`.
- Result fields: embedding, backend key, model id/version/fingerprint, latency metadata.
- Registry resolves installed backend implementations without importing UI/DB code.

- [ ] Write RED tests proving unknown backend names fail closed, default is XVector, and returned speaker metadata is backend-neutral.
- [ ] Run: `cd linux/backend && pytest -q tests/test_speaker_backend_registry.py tests/test_funasr_runtime_adapter.py`.
- [ ] Verify failure is only missing abstraction/registry behavior.
- [ ] Implement the protocol/dataclass/registry with no behavior change to current XVector inference yet.
- [ ] Generalize hardcoded `speaker_model_id="xvector"` fields in runtime where safe; keep XVector as the selected default.
- [ ] Re-run targeted tests GREEN.
- [ ] Commit: `refactor: introduce speaker backend abstraction`.

### Task 2: Move current XVector implementation behind `XVectorBackend` with zero semantic drift

**Files:**
- Create: `linux/backend/speech_worker/speaker/xvector.py`
- Modify: `linux/backend/speech_worker/funasr_runtime.py`
- Keep: `linux/backend/speech_worker/xvector_legacy.py`
- Modify: `linux/backend/tests/test_funasr_runtime_adapter.py`
- Create: `linux/backend/tests/test_xvector_backend.py`
- Modify: `linux/backend/tests/test_speech_session.py`

**Interfaces:**
- `XVectorBackend` owns current AutoModel load, legacy subprocess fallback, fingerprint, L2 normalization and error mapping.
- `FunASRSpeechRuntime` owns ASR/VAD and delegates speaker extraction to the configured speaker backend.
- `session.py` must no longer default missing model metadata to the literal string `xvector`.

- [ ] Capture current XVector behavior in RED/characterization tests: load success, AutoModel failure -> legacy fallback, missing model -> degraded health, normalized embedding, model metadata, speaker-unavailable -> UNKNOWN path.
- [ ] Verify characterization tests against pre-refactor behavior.
- [ ] Move code without changing public speech-worker protocol or current output semantics.
- [ ] Remove XVector-specific comments/defaults from `session.py`; require runtime result metadata.
- [ ] Run targeted tests and existing voiceprint/session tests GREEN.
- [ ] Commit: `refactor: isolate xvector speaker backend`.

### Task 3: Add ERes2Net-large offline adapter and model-package probe

**Files:**
- Create: `linux/backend/speech_worker/speaker/eres2net_large.py`
- Modify: `linux/backend/speech_worker/speaker/registry.py`
- Modify: `linux/backend/config/model-registry.yaml`
- Modify: `scripts/ci/probe-funasr-runtime.py`
- Create: `scripts/ci/probe-eres2net-large.py`
- Create: `linux/backend/tests/test_eres2net_large_backend.py`
- Modify: `tests/release/test_funasr_probe_script.py`

**Precondition:**
- Inspect the actual offline model directory used on RK3588 before locking `required_files`; do not guess package artifacts from documentation alone.

**Interfaces:**
- Model id: `iic/speech_eres2net_large_200k_sv_zh-cn_16k-common`.
- Local-only load after deployment; inference must not require network access.
- Input: 16 kHz PCM16 utterance.
- Output: L2-normalized embedding + backend/model/version/fingerprint metadata.

- [ ] Write RED unit tests around a fake ModelScope/3D-Speaker model proving PCM conversion, 16 kHz enforcement, normalized output, empty/invalid embedding failure and deterministic fingerprint propagation.
- [ ] Verify red because adapter does not exist.
- [ ] Implement a minimal CPU adapter behind an injectable model factory so hosted tests do not need the actual checkpoint.
- [ ] Add a read-only package-inspection/probe script for RK3588 and lock the registry's actual required files only after inspection evidence.
- [ ] Block runtime network access in the production adapter path or validate that only local model paths are accepted.
- [ ] Run targeted backend/release tests GREEN.
- [ ] Commit: `feat: add eres2net large speaker backend`.

### Task 4: Add model-aware voiceprint persistence with migration 0009

**Files:**
- Modify: `linux/backend/app/database/voiceprint_models.py`
- Modify: `linux/backend/app/database/models.py`
- Create: `linux/backend/alembic/versions/0009_dual_speaker_backends.py`
- Modify: `linux/backend/app/repositories/voiceprints.py`
- Modify: `linux/backend/tests/test_migrations.py`
- Modify: `linux/backend/tests/test_voiceprint_repositories.py`
- Modify: `linux/backend/tests/test_officer_voiceprint_library.py`

**Schema contract:**
- Add `model_key` / backend identity to suspect and officer references.
- Replace one-row uniqueness with model-aware uniqueness, conceptually `(case_id, model_key)` and `(officer_id, model_key)`.
- Existing rows remain XVector references during schema upgrade.
- Preserve model id/version/fingerprint/dimension/quality/duration/audit fields.

- [ ] Write RED migration/repository tests proving one identity can own both `xvector` and `eres2net_large` references while duplicate same-model active reference is rejected.
- [ ] Write a migration test proving pre-0009 rows survive and are classified as XVector, with embedding bytes unchanged.
- [ ] Verify migration tests fail only on missing 0009 contract.
- [ ] Implement SQLite-safe Alembic batch changes and update migration head assertions.
- [ ] Update repository APIs to require/accept model key on lookup/enroll/update/revoke.
- [ ] Add explicit cross-model lookup rejection; never return XVector when ERes2Net was requested.
- [ ] Run migration/repository suites GREEN.
- [ ] Commit: `feat: persist model-specific voiceprint references`.

### Task 5: Generate dual references from one enrollment capture

**Files:**
- Modify: `linux/backend/app/services/voiceprint_service.py`
- Modify: `linux/backend/app/services/officer_voiceprint_library.py`
- Modify: `linux/backend/app/ai/speech/client.py` or current speech-client implementation used by enrollment
- Modify: `linux/backend/app/api/voiceprints.py`
- Modify: `linux/backend/tests/test_voiceprint_service.py`
- Modify: `linux/backend/tests/test_voiceprint_api.py`
- Modify: `linux/backend/tests/test_officer_voiceprint_library.py`

**Behavior:**
- Validate/VAD/chunk the enrollment PCM once.
- For each installed/configured enrollment backend, extract an embedding from the same chunk set.
- Aggregate independently; never average embeddings across models.
- Persist independent references atomically where practical.
- Return readiness per backend.

- [ ] Write RED tests: one PCM -> two extraction calls/backends -> two references; one backend failure must be visible and must not masquerade as success for that backend.
- [ ] Add tests proving dimensions may differ and aggregation is isolated by backend.
- [ ] Implement a backend-aware `extract_embedding(..., backend=...)` speech-client contract.
- [ ] Refactor `_build_reference` into backend-neutral preprocessing plus per-backend reference building.
- [ ] Decide transaction behavior explicitly: preserve successfully generated XVector reference if optional ERes2Net is unavailable, but response must mark ERes2Net `NOT_READY`; do not silently claim dual readiness.
- [ ] Run service/API/library tests GREEN.
- [ ] Commit: `feat: build dual voiceprint references from one capture`.

### Task 6: Make session role binding and readiness backend-aware

**Files:**
- Modify: `linux/backend/app/database/voiceprint_models.py`
- Modify: `linux/backend/app/repositories/voiceprints.py`
- Modify: `linux/backend/app/services/voiceprint_service.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `linux/backend/app/main.py`
- Modify: `linux/backend/tests/test_voiceprint_service.py`
- Modify: `linux/backend/tests/test_speech_pipeline.py`
- Modify: `linux/backend/tests/test_asr_capture_service.py`

**Behavior:**
- Runtime mode selects a speaker backend/model key before formal capture.
- Session assignment resolves compatible references for that key.
- Missing selected-model reference is explicit readiness failure/degradation; no model-space fallback.
- Capture runtime snapshots selected backend/model fingerprint.

- [ ] Write RED tests for `xvector`, `eres2net_large`, and missing-reference behavior.
- [ ] Add a test proving ERes2Net-selected session cannot consume an XVector reference even for the same person.
- [ ] Implement backend-aware reference resolution and capture snapshot.
- [ ] Keep suspect-only/full/partial role logic otherwise unchanged.
- [ ] Verify targeted capture/voiceprint tests GREEN.
- [ ] Commit: `feat: bind sessions to selected speaker backend`.

### Task 7: Generalize speaker provenance while preserving historical XVector values

**Files:**
- Modify: `linux/backend/app/services/speaker_policy.py`
- Modify: any serializer/model enum storing `SpeakerSource`
- Modify: `linux/backend/tests/test_speaker_policy.py`
- Modify: `linux/backend/tests/test_speech_protocol.py`
- Modify: audit documentation if enum is externally documented

**Contract:**
- Keep historical `X_VECTOR` readable.
- New model-backed decisions use generic `SPEAKER_EMBEDDING` provenance (or equivalent approved generic name).
- Exact backend/model is carried separately in evidence metadata.

- [ ] Write RED compatibility tests for reading/serializing legacy `X_VECTOR` and producing generic provenance for new decisions.
- [ ] Ensure no database rewrite of historical audit/event rows.
- [ ] Implement provenance generalization without changing threshold/margin decision math.
- [ ] Run speaker policy/protocol tests GREEN.
- [ ] Commit: `refactor: generalize speaker embedding provenance`.

### Task 8: Isolate calibration by backend/model fingerprint

**Files:**
- Modify: `linux/backend/app/services/speaker_calibration_service.py`
- Modify: `linux/backend/app/services/speaker_calibration_runtime.py`
- Modify: `linux/backend/app/repositories/speaker_calibrations.py`
- Modify: `linux/backend/app/database/voiceprint_models.py` if schema index/key additions are required
- Modify: `linux/backend/tests/test_speaker_calibration_service.py`
- Modify: `linux/backend/tests/test_speaker_calibration_runtime.py`
- Modify: `linux/backend/tests/test_speaker_calibration_repository.py`
- Modify: `linux/backend/tests/test_speaker_baseline_fallback.py`

**Behavior:**
- Calibration lookup key includes current speaker backend/model fingerprint + microphone fingerprint.
- XVector calibration can never become ERes2Net calibration.
- Each backend gets independent threshold/margin/FAR/FRR/EER lifecycle.

- [ ] Write RED tests proving two calibrations may coexist for the same microphone and that selecting one backend never returns the other's operating point.
- [ ] Add stale-model tests for changing only ERes2Net fingerprint while XVector remains valid, and vice versa.
- [ ] Generalize XVector-specific names/text to speaker-model terminology where this is a new API/UI field; retain legacy compatibility where necessary.
- [ ] Implement model-aware resolver/repository indexes.
- [ ] Run full calibration suite GREEN.
- [ ] Commit: `feat: calibrate speaker backends independently`.

### Task 9: Add compare-mode execution and evidence without dual business mutation

**Files:**
- Create: `linux/backend/app/services/speaker_backend_compare.py`
- Modify: `linux/backend/speech_worker/funasr_runtime.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: recognition/evidence persistence models only if needed for compare evidence
- Create: `linux/backend/tests/test_speaker_backend_compare.py`
- Modify: `linux/backend/tests/test_asr_recognition_evidence.py`
- Modify: `linux/backend/tests/test_asr_capture_service.py`

**Interfaces:**
- Compare result contains both backend scores/roles/latencies/calibration metadata.
- `authoritative_backend` is mandatory in compare mode.
- Exactly one `SPEAKER_RESULT`/business role continues into ASR fragment mutation.
- Secondary result is diagnostic evidence only.

- [ ] Write RED tests proving both backends see identical utterance PCM, results are preserved separately, and only authoritative decision mutates fragment role.
- [ ] Add failure tests: secondary backend failure does not corrupt authoritative result; authoritative failure follows current conservative UNKNOWN behavior.
- [ ] Implement compare coordinator/evidence shape.
- [ ] Add latency/candidate-score/model metadata needed for final comparison report.
- [ ] Run targeted evidence/capture tests GREEN.
- [ ] Commit: `feat: add non-authoritative speaker compare mode`.

### Task 10: Add system-settings selector and comparison UI

**Files:**
- Modify/Create as appropriate: `webapp/src/api/speakerCalibration.ts`
- Modify: `webapp/src/components/SpeakerCalibrationCenter.vue`
- Modify: `webapp/src/components/SpeakerCalibrationCenter.test.ts`
- Modify: `webapp/src/components/VoiceprintPreparationPanel.vue`
- Modify: `webapp/src/components/VoiceprintPreparationPanel.test.ts`
- Modify: `webapp/src/views/SystemSettingsView.vue`
- Add backend API endpoint/tests under `linux/backend/app/api/` as required

**UI:**
- Display XVector installed/ready/reference/calibration status.
- Display ERes2Net-large installed/ready/reference/calibration status.
- Runtime selector: XVector / ERes2Net-large / Compare.
- Compare requires visible authoritative-backend selector.
- Enrollment UI still presents one recording operation and per-backend readiness results.
- Comparison results show accuracy/error/UNKNOWN/latency metrics; no auto-winner.

- [ ] Write failing Vue/API tests for all three modes and unavailable ERes2Net state.
- [ ] Verify compare cannot be enabled without an authoritative backend.
- [ ] Implement API/types/components.
- [ ] Run: `cd webapp && npm test -- --run`.
- [ ] Run: `cd webapp && npm run typecheck`.
- [ ] Run: `cd webapp && npm run build`.
- [ ] Commit: `feat: expose dual speaker backend controls`.

### Task 11: Add explicit reference rebuild/copy tool for existing enrollment audio

**Files:**
- Create: `scripts/ci/rebuild-speaker-reference.py` or `linux/backend/scripts/rebuild-speaker-reference.py` following repository conventions
- Create: `tests/release/test_rebuild_speaker_reference.py`
- Modify: audit event documentation
- Modify: deployment documentation

**Behavior:**
- Input: case/officer identity + explicit WAV/PCM path + target backend.
- Target for first release: `eres2net_large`.
- Reuse the same audio validation/chunk/reference-building code as enrollment.
- Never read an XVector embedding as input for ERes2Net creation.
- Idempotent; refuse existing target reference unless `--replace`.
- If source audio is unavailable, operator gets an explicit `NEEDS_REENROLL` result.

- [ ] Write RED CLI/service tests for new reference, duplicate refusal, explicit replace, invalid audio and no-source behavior.
- [ ] Implement tool without adding permanent raw-audio storage.
- [ ] Verify audit entry identifies source audio digest/path class, target model and resulting fingerprint without copying raw audio into audit logs.
- [ ] Run release/tool tests GREEN.
- [ ] Commit: `feat: rebuild model-specific voiceprint references from audio`.

### Task 12: RK3588 model install/read-only probe and independent calibration

**Files:**
- Modify/Create: `scripts/ci/probe-eres2net-large.py`
- Modify: `scripts/ci/rk3588-speech-calibrate.py`
- Modify: `scripts/ci/rk3588-speech-smoke.py`
- Modify: `.github/workflows/rk3588-voiceprint-diagnostics.yml`
- Create if clearer: `.github/workflows/rk3588-speaker-backend-compare.yml`
- Modify: release tests for these scripts/workflows

**Safety:**
- Hosted gate verifies scripts before self-hosted execution.
- Board steps are read-only except explicit test/reference files in a test namespace.
- Do not restart/replace the existing unrelated service on port 8000.
- Do not switch production authoritative backend.

- [ ] Write RED release tests requiring backend parameterization and separate calibration outputs.
- [ ] Implement read-only model-directory/fingerprint/embedding smoke for both models.
- [ ] Inspect actual ERes2Net package and lock registry artifacts.
- [ ] Run per-backend calibration using the same production microphone corpus.
- [ ] Confirm XVector and ERes2Net calibration ids/thresholds/margins remain independent.
- [ ] Commit: `test: add rk3588 dual speaker backend probes`.

### Task 13: Controlled side-by-side RK3588 comparison

**Files:**
- Create: `scripts/ci/rk3588-speaker-backend-compare.py`
- Create: `tests/release/test_rk3588_speaker_backend_compare.py`
- Modify: `.github/workflows/rk3588-speaker-backend-compare.yml`
- Create/update: `docs/release/SPEAKER-BACKEND-COMPARISON.md`

**Dataset/metrics:**
- Same registered suspect/interrogator/recorder references for both backends, generated from the same source enrollment captures.
- Controlled utterances in approximately 1 s / 2 s / 3 s / 5 s buckets.
- Record ground-truth speaker labels for test samples only.
- Per backend: correct-role rate, confusion matrix, FAR/FRR-like local counts, UNKNOWN rate, p50/p95/max embedding latency, CPU time, process RSS/cgroup memory.

- [ ] Write RED deterministic comparison-report tests using fake backend score streams.
- [ ] Implement reporter and artifact schema.
- [ ] Run hosted fake-data gate.
- [ ] Run XVector + ERes2Net-large on the same RK3588 samples in one comparison job.
- [ ] Assert both pipelines complete; do not assert one model must win.
- [ ] Store the side-by-side artifact and document exact model fingerprints/calibration ids/microphone fingerprint.
- [ ] Commit: `test: compare xvector and eres2net on rk3588`.

### Task 14: Full regression, selection readiness, rollback, and completion verification

**Files:**
- Modify: `linux/docs/api-contract-v1.md`
- Modify: `docs/security/AUDIT-EVENTS.md`
- Modify: deployment docs/env examples
- Update: `docs/release/SPEAKER-BACKEND-COMPARISON.md`
- No production config flip unless explicitly requested after user reviews comparison results.

- [ ] Run backend targeted voiceprint/speaker suites.
- [ ] Run full backend suite: `cd linux/backend && pytest -q` with CI-required environment/PYTHONPATH.
- [ ] Run migrations from clean DB to latest head and upgrade from a representative pre-0009 DB.
- [ ] Run frontend `npm test -- --run`, `npm run typecheck`, `npm run build`.
- [ ] Run release/workflow contract tests.
- [ ] Run final RK3588 dual-backend comparison on the exact commit under review.
- [ ] Verify no temporary workflow, generated model binary, PCM/WAV test capture, `__pycache__` or secret/env file is committed.
- [ ] Verify `SUSPECT_SPEAKER_BACKEND` default remains `xvector`.
- [ ] Verify rollback to XVector is config-only and does not delete ERes2Net references/calibration history.
- [ ] Run `superpowers:verification-before-completion` and record exact Hosted/RK3588 run ids + model fingerprints + test counts.
- [ ] Commit docs: `docs: record dual speaker backend acceptance`.

## Dependency Order

```text
Task 1 backend contract
  -> Task 2 XVector refactor
  -> Task 3 ERes2Net adapter
  -> Task 4 model-aware persistence
  -> Task 5 one-capture dual enrollment
  -> Task 6 runtime/session model selection
  -> Task 7 provenance
  -> Task 8 independent calibration
  -> Task 9 compare execution/evidence
  -> Task 10 UI/API
  -> Task 11 existing-audio rebuild tool
  -> Task 12 RK3588 probes/calibration
  -> Task 13 controlled comparison
  -> Task 14 final verification/selection readiness
```

Tasks 7 and 11 can be developed in parallel after Task 5 if their tests do not share migrations. Task 10 can begin after Task 6/8 API shapes are stable. Do not start Task 13 before both model-specific calibration paths have passed on RK3588.

## Acceptance Checklist

- [ ] XVector remains functional and is still the default/rollback backend.
- [ ] ERes2Net-large loads locally/offline on RK3588 and returns normalized embeddings.
- [ ] One enrollment capture can create independent XVector and ERes2Net references.
- [ ] Existing XVector embeddings are never copied or relabeled as ERes2Net.
- [ ] Existing source audio, when available, can explicitly rebuild an ERes2Net reference without a new recording.
- [ ] Missing source audio is reported as `NEEDS_REENROLL`, not fabricated.
- [ ] Same identity can safely hold model-specific references without cross-model lookup.
- [ ] XVector and ERes2Net calibration histories/thresholds/margins are independent.
- [ ] `xvector`, `eres2net_large`, and `compare` can be selected through configuration/API/UI without code changes.
- [ ] Compare mode produces two diagnostic results but exactly one authoritative business role.
- [ ] Speaker policy decision math remains shared and regression-tested.
- [ ] Historical `X_VECTOR` provenance remains readable; new decisions have backend-neutral provenance plus exact model metadata.
- [ ] RK3588 report contains same-sample accuracy/error/UNKNOWN and latency/resource comparison.
- [ ] No automatic production winner is selected from the benchmark.
- [ ] No change to Paraformer/FSMN-VAD/Qwen/formal-record semantics/TCP-8000.
- [ ] Hosted Linux and RK3588 gates are green on the final commit.

## Rollback Plan

If ERes2Net is unavailable, inaccurate, or too slow:

1. Set `SUSPECT_SPEAKER_BACKEND=xvector`.
2. Restart only the project service(s) required to reload project configuration; do not touch unrelated TCP/8000 service.
3. Confirm health reports XVector model/fingerprint and applicable XVector calibration.
4. Leave ERes2Net model files, references and calibration history intact for later diagnostics.
5. Run a short XVector voiceprint smoke and confirm normal role assignment.

No database downgrade or deletion of ERes2Net data is required for operational rollback.