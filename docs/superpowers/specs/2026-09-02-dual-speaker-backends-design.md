# Dual Speaker Verification Backends Design

Date: 2026-09-02
Branch: `feat/dual-speaker-backends`
Status: Approved in chat; implementation not started

## 1. Purpose

Add two coexisting speaker-verification backends to the RK3588 Linux interrogation system:

- existing XVector;
- ERes2Net-large (`iic/speech_eres2net_large_200k_sv_zh-cn_16k-common`).

The operator must be able to deploy both, enroll once, generate model-specific references for both backends, test both under the same microphone and speaker conditions, compare accuracy/UNKNOWN rate/false accepts/false rejects/latency/resource usage, and then choose the authoritative backend by configuration rather than by another code rewrite.

This feature is a speaker-embedding/backend change only. It must not change Paraformer ASR, FSMN-VAD, Qwen formal-record routing, formal-record persistence, or the existing service on TCP/8000.

## 2. Product decisions

### 2.1 One codebase, two backends

Do not create separate XVector and ERes2Net application branches or duplicate speech pipelines. Introduce one backend contract with two implementations:

```text
PCM utterance
  -> SpeakerEmbeddingBackend
       |- XVectorBackend
       `- ERes2NetLargeBackend
  -> normalized embedding
  -> shared cosine scoring
  -> shared threshold + margin speaker_policy
  -> SUSPECT / INTERROGATOR / RECORDER / OFFICER_FALLBACK / UNKNOWN
```

### 2.2 Runtime modes

Support three runtime modes:

- `xvector`: XVector is authoritative.
- `eres2net_large`: ERes2Net-large is authoritative.
- `compare`: both backends run against the same utterance and same enrolled identities for diagnostics.

`compare` must have exactly one explicitly configured authoritative backend for business mutation. The secondary result is diagnostic evidence only; it must never create a second conflicting role assignment on the same ASR fragment.

Recommended configuration:

```text
SUSPECT_SPEAKER_BACKEND=xvector|eres2net_large|compare
SUSPECT_SPEAKER_AUTHORITATIVE_BACKEND=xvector|eres2net_large
```

Default remains `xvector` until RK3588 comparison acceptance is complete and the operator explicitly selects another backend.

## 3. Enrollment and the meaning of "copy the voiceprint"

### 3.1 Embeddings are not copied across models

XVector and ERes2Net-large embeddings belong to different feature spaces. An XVector vector must never be relabeled or copied as an ERes2Net vector.

### 3.2 One capture can create two references

For a new suspect/officer enrollment, the same validated 16 kHz PCM capture is reused in memory:

```text
one enrollment PCM
  |- XVector -> XVector reference
  `- ERes2Net-large -> ERes2Net reference
```

The user records only once.

### 3.3 Existing enrolled identities

There is no automatic XVector-to-ERes2Net embedding migration.

If an original enrollment WAV/PCM is still available during deployment, an explicit rebuild/copy tool may read that audio and generate the missing ERes2Net reference. If original audio is not available, the existing XVector reference remains valid and the ERes2Net reference is reported as `NEEDS_REENROLL`; the system must never fabricate one from the XVector embedding.

This design therefore has a normal Alembic schema migration but no cross-model biometric-data migration/backfill.

### 3.4 Raw audio retention

Do not introduce indefinite raw enrollment-audio retention merely to support this feature. New dual-reference enrollment can feed the same request PCM to both backends before the request ends. An operational rebuild tool may consume explicitly supplied/staged enrollment audio when available.

## 4. Speaker backend abstraction

Create a backend-neutral interface, conceptually:

```python
class SpeakerEmbeddingBackend(Protocol):
    key: str

    def health(self) -> dict: ...
    def extract_embedding(self, pcm: bytes, sample_rate: int) -> dict: ...
```

Returned metadata must include:

- normalized `embedding`;
- `backend_key`;
- `model_id`;
- `model_version`;
- `model_fingerprint`;
- inference latency where available.

The existing `SpeechRuntime.speaker_embedding()` contract remains the boundary seen by `session.py`. The runtime/registry selects one backend or invokes both in compare mode.

## 5. XVector implementation

Refactor the current XVector behavior behind `XVectorBackend` without changing its production semantics:

- retain current FunASR `AutoModel` attempt;
- retain the current legacy subprocess fallback using `xvector_legacy.py` and `SUSPECT_XVECTOR_LEGACY_PYTHON`;
- retain L2 normalization and model-directory fingerprinting;
- retain graceful degradation when speaker inference is unavailable.

The initial dual-backend release must keep XVector as a clean rollback path.

## 6. ERes2Net-large implementation

Target model:

`iic/speech_eres2net_large_200k_sv_zh-cn_16k-common`

The official model is a 16 kHz Chinese speaker-verification model. The implementation must use a local, offline inference path after deployment. Before hardcoding required model artifacts, inspect the actual downloaded model package on RK3588 and lock the registry contract to those files.

Preferred first implementation:

- PyTorch CPU on RK3588 using the supported ModelScope/3D-Speaker inference code path;
- no network access during runtime;
- produce one normalized embedding from PCM;
- expose model id/version/fingerprint through the same backend contract.

NPU/RKNN conversion is explicitly deferred until CPU accuracy and latency are measured. The first goal is an apples-to-apples correctness comparison, not premature accelerator conversion.

## 7. Persistence model

Current persistence assumes one active suspect reference per case and one active officer reference per officer. Dual backends require multiple model-specific references.

Alembic `0009_dual_speaker_backends.py` should change the uniqueness model so references are model-aware.

Conceptually:

```text
SuspectVoiceprint
  case_id
  model_key
  model_id
  model_version
  model_fingerprint
  embedding / dim / quality / duration
  active / created_at
  UNIQUE(case_id, model_key)

OfficerVoiceprint
  officer_id
  model_key
  model_id
  model_version
  model_fingerprint
  embedding / dim / quality / duration
  active / revoked_at / created_at
  UNIQUE(officer_id, model_key)
```

Existing rows are retained as XVector references by the schema transition. This is metadata preservation, not generation of ERes2Net embeddings.

Repositories must always resolve a reference by subject plus backend/model key. Cross-model comparison is forbidden.

## 8. Session role binding

`SessionVoiceAssignment` must stop assuming that one stored voiceprint row is valid for every speaker model.

Preferred behavior:

- persist the logical suspect/officer identities and selected speaker backend/model key for the session;
- resolve the matching model-specific reference at capture start;
- snapshot the selected backend/model fingerprint and calibration operating point for the session;
- fail closed to UNKNOWN or readiness-not-prepared when the selected backend has no compatible reference.

Do not silently fall back from ERes2Net to an XVector reference under the same role.

## 9. Calibration isolation

XVector and ERes2Net-large must have separate thresholds and margins.

Calibration identity includes at minimum:

- backend/model key;
- model id/version/fingerprint;
- microphone fingerprint.

A calibration generated for XVector must never be reused for ERes2Net-large. Existing model/microphone staleness logic remains, generalized from "XVector fingerprint" to "speaker-model fingerprint".

Compare mode may show both calibrated operating points side by side.

## 10. Shared speaker policy and provenance

`speaker_policy.py` remains the shared deterministic decision policy. It continues consuming cosine-similarity candidates, threshold, margin, duration and overlap information.

Do not fork decision policy by model unless RK3588 evidence later proves a model requires a different score semantics contract.

The existing provenance name `X_VECTOR` is too model-specific for new decisions. Preserve historical stored `X_VECTOR` values, but use a generic new source for future model-backed decisions, for example:

`SPEAKER_EMBEDDING`

Exact provenance is supplied by `model_id`, `model_version`, `model_fingerprint`, backend key and calibration snapshot. Historical audit rows are not rewritten.

## 11. Compare mode

Compare mode is a diagnostic mode, not a dual-authority mode.

For each usable utterance it should produce an evidence record containing, per backend:

- embedding inference latency;
- candidate cosine scores;
- top-1/top-2 scores and margin;
- threshold/margin and calibration id/source;
- final speaker role;
- confidence/UNKNOWN state;
- model id/version/fingerprint.

The comparison layer also records the human/ground-truth label when provided during a controlled acceptance session.

Aggregated metrics:

- correct-role rate;
- suspect false accept / false reject;
- officer false accept / false reject;
- UNKNOWN rate;
- confusion matrix;
- embedding latency p50/p95/max;
- process CPU time and RSS/cgroup memory where practical.

Only the configured authoritative backend's decision is emitted into normal business flow.

## 12. API and UI

Expose backend status through system settings/voiceprint diagnostics, not by complicating the normal interrogation page.

Required operator controls/status:

- installed/ready state for XVector;
- installed/ready state for ERes2Net-large;
- active mode;
- authoritative backend when mode is `compare`;
- whether suspect/interrogator/recorder references exist for each backend;
- per-backend calibration status;
- comparison-session results.

The normal enrollment UI should continue to say "record once". If both backends are installed, the backend creates both references automatically from the same capture.

## 13. Model registry and directories

Keep independent model directories:

```text
/opt/suspect-interrogation/models/funasr/xvector/
/opt/suspect-interrogation/models/funasr/eres2net-large/
```

Generalize `model-registry.yaml` to separate entries such as:

- `speaker.xvector`
- `speaker.eres2net_large`

Do not guess ERes2Net `required_files`; lock them after inspecting the actual offline package used on the board.

## 14. Deployment-copy tool

Provide an explicit, idempotent deployment helper for existing identities, conceptually:

```text
rebuild-speaker-reference --backend eres2net_large --case ... --audio ...
rebuild-speaker-reference --backend eres2net_large --officer ... --audio ...
```

Requirements:

- takes original/staged PCM or WAV as input;
- validates audio with the same enrollment rules;
- generates ERes2Net reference only;
- never edits the XVector vector;
- refuses overwrite unless explicit `--replace`;
- records audit metadata;
- reports `NEEDS_REENROLL` when no source audio is available rather than fabricating data.

This is the implementation of "copy the voiceprint" for deployment: reuse audio, recompute a model-specific embedding.

## 15. RK3588 acceptance design

The final comparison must use the same RK3588, microphone and enrollment audio for both models.

Minimum acceptance corpus:

- suspect + interrogator + recorder where available;
- multiple utterances per role;
- short-duration buckets around 1 s, 2 s, 3 s and 5 s;
- same-speaker and impostor trials;
- noisy/normal-distance samples if practical.

Sequence:

1. verify both model directories/fingerprints;
2. enroll once and confirm both references exist;
3. calibrate XVector independently;
4. calibrate ERes2Net-large independently;
5. run compare mode on the same utterances;
6. generate side-by-side artifact;
7. user selects final authoritative backend;
8. selection is made by config only.

No production backend flip occurs automatically after the benchmark.

## 16. Rollback

Rollback is configuration-only:

```text
SUSPECT_SPEAKER_BACKEND=xvector
```

ERes2Net model files, references and calibration history may remain on disk/database for future testing. No destructive rollback is required.

## 17. Non-goals

- No copying/conversion of an XVector embedding into an ERes2Net embedding.
- No deletion of XVector.
- No shared threshold or margin between models.
- No automatic historical ERes2Net data backfill without source audio.
- No change to Paraformer, FSMN-VAD, Qwen routing or formal-record semantics.
- No use of compare mode to write two competing speaker roles.
- No ERes2Net NPU/RKNN conversion in the first implementation phase.
- No changes to the existing service on TCP/8000.

## 18. Acceptance criteria

The feature is ready for user comparison only when:

- both backends can be loaded independently on RK3588;
- XVector behavior remains compatible with the current system;
- one enrollment capture creates separate references for all installed backends;
- reference lookup is backend/model-safe and rejects model mismatch;
- calibration is independent per model fingerprint and microphone;
- `xvector`, `eres2net_large`, and `compare` modes are testable without code changes;
- compare mode produces one authoritative business decision and two diagnostic result sets;
- a controlled RK3588 report compares accuracy/error/UNKNOWN/latency/resource data;
- switching the authoritative backend requires only configuration;
- full backend/frontend/release regression is green;
- production remains XVector until the user explicitly chooses otherwise.

## 19. Prior constraints and references

This design extends rather than replaces:

- `docs/superpowers/specs/2026-08-27-funasr-voiceprint-speech-pipeline-design.md`
- `docs/superpowers/specs/2026-08-31-global-officer-voiceprint-library-design.md`
- `docs/superpowers/specs/2026-08-31-speaker-device-calibration-center-design.md`

External implementation references:

- ModelScope model: `iic/speech_eres2net_large_200k_sv_zh-cn_16k-common`
- 3D-Speaker repository: `modelscope/3D-Speaker`

The external published threshold examples are documentation examples only and are not production thresholds for this device. RK3588 thresholds/margins must be calibrated locally.