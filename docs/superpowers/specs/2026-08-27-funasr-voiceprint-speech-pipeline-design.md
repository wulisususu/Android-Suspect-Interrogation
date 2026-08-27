# FunASR Speech Pipeline + Voiceprint Design

Date: 2026-08-27
Branch: `linux-adaptation`
Status: Approved architecture

## 1. Goal

Integrate the existing local FunASR model set into the Linux/RK3588 interrogation system without bundling model weights into Git releases:

- Paraformer: offline Chinese ASR
- FSMN-VAD: voice activity detection / utterance boundary detection
- XVector: speaker embedding, enrollment, verification, and role attribution

The system must support mandatory suspect voiceprint enrollment, optional police officer voiceprint recognition, a persistent police officer voiceprint library, session-scoped role assignment for interrogating and recording officers, and auditable downgrade behavior when police voiceprints are not enabled.

## 2. Existing Architecture Fit

The current Linux AI runtime already provides engine abstractions for ASR, VAD, and speaker recognition, and the model registry already understands `asr`, `vad`, and `speaker` model kinds. The current real-engine layer remains an adapter seam and should be used for vendor/runtime integration rather than putting FunASR inference directly into FastAPI route handlers.

The existing ASR workflow already models temporary fragments before they are confirmed into the official transcript. This design extends that workflow with richer speaker metadata and voiceprint verification rather than replacing it.

## 3. Chosen Runtime Architecture

Use one isolated **Speech Pipeline Worker** for the speech path instead of exposing three public model services or sending the same PCM through three independent workers.

Pipeline:

```text
ALSA microphone
    -> 16 kHz mono PCM
    -> FSMN-VAD
    -> utterance segment
       -> Paraformer ASR
       -> XVector embedding / speaker decision
    -> temporary ASR fragment
    -> human confirmation / correction
    -> official interrogation transcript
```

Paraformer and XVector process the same VAD-delimited utterance. They may run concurrently after a segment closes. If the installed Paraformer package is a true streaming model, the worker may additionally emit partial text while retaining final VAD-bounded recognition as the authoritative fragment. If it is an offline Paraformer model, the UI must not fabricate token-streaming behavior.

The worker remains behind the existing AI-runtime boundary and should use the established timeout, restart, cancellation, lazy-load, memory-budget, and idle-unload mechanisms where practical.

## 4. Model Storage and Deployment

Do not copy approximately 924 MB of FunASR weights into the repository or each immutable application release.

Source models currently live at:

```text
/home/youyeetoo/funasr-models/
  paraformer/
  fsmn-vad/
  xvector/
```

Production services run under systemd hardening with `ProtectHome=true`, so the application must not depend on direct access to `/home/youyeetoo/...`.

Expose the model tree read-only at a stable production path, for example:

```text
/opt/suspect-interrogation/models/funasr/
  paraformer/
  fsmn-vad/
  xvector/
```

Preferred deployment mechanism: a read-only bind mount from the source model directory to the stable production model path, managed explicitly by deployment/systemd configuration. Application configuration references only the stable `/opt/...` path.

The exact required file list for each model must be discovered from the real RK3588 filesystem before finalizing model-registry validation. Do not assume that `model.pt` or `sv.pth` are the only required artifacts.

## 5. Registry Changes

Replace the current ASR assumption that `asr.default` is `sherpa-onnx` with `model.onnx` when the selected production model is the installed FunASR Paraformer package.

Target logical registry entries:

```text
asr.default
  kind: asr
  backend: funasr
  architecture: paraformer
  path: paraformer

vad.default
  kind: vad
  backend: funasr
  architecture: fsmn-vad
  path: fsmn-vad

speaker.default
  kind: speaker
  backend: funasr
  architecture: xvector
  path: xvector
```

Exact filenames, runtime capabilities, memory estimates, and package/API details are finalized only after runner-side inspection of the installed model directories and FunASR environment.

## 6. Voiceprint Domain Model

### 6.1 Suspect voiceprint

Suspect enrollment is mandatory before a voice-enabled interrogation session may start.

Suspect voiceprints are case/session-scoped by default. They are not automatically promoted into a cross-case biometric repository.

Enrollment flow:

```text
record approximately 20-30 seconds
 -> VAD removes silence
 -> validate usable voiced duration and audio quality
 -> split into multiple valid speech segments
 -> extract XVector embeddings
 -> reject low-quality/outlier segments
 -> normalize / aggregate into reference embedding
 -> persist reference + model/version + quality metadata
```

The default policy should avoid retaining extra raw enrollment audio unless an explicit evidence/audit retention requirement calls for it.

### 6.2 Police officer voiceprint library

Police voiceprint enrollment is optional for any interrogation session, but enrolled officer templates may be persisted and reused.

Use one unified officer voiceprint library keyed by officer identity (for example officer ID / badge number), not separate databases for interrogating and recording officers.

Identity is persistent; role is session-specific.

Suggested logical record:

```text
officer_voiceprints
  id
  officer_id
  officer_name
  embedding
  model_id
  model_version
  enrollment_quality
  usable_duration_ms
  active
  created_at
  updated_at
  revoked_at
```

### 6.3 Session role binding

Each interrogation session binds identities to roles:

```text
session_voice_assignments
  session_id
  suspect_voiceprint_id
  interrogator_officer_id
  interrogator_voiceprint_id
  recorder_officer_id
  recorder_voiceprint_id
  recognition_mode
  created_at
```

The same officer can be interrogator in one case and recorder in another without duplicating biometric enrollment.

## 7. Speaker Recognition Modes

### Mode A: suspect only

Required state:

```text
suspect voiceprint: enabled
interrogating officer voiceprint: disabled
recording officer voiceprint: disabled
```

Decision rule:

- Strong suspect match -> `SUSPECT`, voiceprint verified.
- Otherwise -> UI/business role `OFFICER`, but internally mark the source as suspect-exclusion fallback rather than verified officer identity.

Required metadata example:

```text
speaker: OFFICER
speaker_source: SUSPECT_EXCLUSION
voiceprint_verified: false
```

This preserves the user's required business behavior (non-suspect speech is treated as police speech when police recognition is disabled) without falsely claiming that a specific officer was biometrically verified.

### Mode B: suspect + one enrolled officer

Compare the segment against the suspect and the enabled officer template. Possible outcomes include:

- `SUSPECT`
- `INTERROGATOR` or `RECORDER`, depending on the enabled role
- `OFFICER_FALLBACK`
- `UNKNOWN`

### Mode C: suspect + interrogating officer + recording officer

Compare each usable segment embedding with all three session reference templates:

- `SUSPECT`
- `INTERROGATOR`
- `RECORDER`
- `UNKNOWN`

Do not simply choose the largest similarity score. A positive classification must satisfy both a calibrated acceptance threshold and a separation margin from the second-best candidate.

Conceptually:

```text
best_score >= threshold
AND
best_score - second_best_score >= margin
```

Thresholds and margins must be calibrated on the real RK3588 microphone/audio path and must not be invented in code without validation.

## 8. Fragment and Audit Model

Extend the existing temporary ASR fragment model. Internally support at least:

```text
SUSPECT
INTERROGATOR
RECORDER
OFFICER_FALLBACK
UNKNOWN
```

For each fragment persist enough information to explain the machine decision:

```text
speaker
speaker_id
speaker_name
speaker_score
second_best_score
speaker_threshold
speaker_margin
speaker_source  # X_VECTOR | SUSPECT_EXCLUSION | MANUAL | UNASSIGNED
voiceprint_verified
low_confidence
asr_confidence
start_ms
end_ms
model_id
model_version
```

The frontend may simplify `OFFICER_FALLBACK` to the visible label `民警`, but the backend must preserve that it was a rule-based fallback rather than biometric officer verification.

Manual changes to recognized text or speaker labels must preserve the original machine output and create an audit record rather than destructively overwriting provenance.

## 9. Session Gate and Frontend Behavior

Add a pre-interrogation `声纹准备` stage.

Required behavior:

- Suspect voiceprint: mandatory; `开始审讯` is disabled until enrollment is valid.
- Interrogating officer voiceprint: optional; select an existing officer template or enroll/update one.
- Recording officer voiceprint: optional; select an existing officer template or enroll/update one.
- Display the active recognition mode explicitly.

Example:

```text
嫌疑人 王某        声纹已注册
主审民警 张某      已从民警声纹库加载
记录民警 李某      未启用声纹识别

当前模式：嫌疑人 + 主审民警声纹识别；记录民警按规则归类
```

During interrogation, visible speaker labels are:

- `嫌疑人 · <name>`
- `主审民警 · <name>`
- `记录民警 · <name>`
- `民警` for suspect-exclusion fallback
- `待确认` for ambiguous/unknown results

For fallback fragments, details should state that police voiceprint recognition was not enabled and the segment was classified by non-suspect exclusion.

## 10. Streaming State

The current WebSocket ASR path should not repeatedly resend/reprocess the entire accumulated session audio for every incoming chunk.

Refactor to session-scoped speech state:

```text
session
  -> streaming VAD state
  -> current speech buffer
  -> pre-roll / endpoint state
  -> optional ASR partial state
  -> utterance close
  -> final ASR + XVector
  -> fragment
```

A session close/failure must clean up buffers and model-side stream state deterministically.

## 11. Failure and Degradation Policy

The voice stack must fail safely without destroying captured evidence or silently fabricating speaker identity.

- VAD failure: retain/capture audio where possible and require manual processing; do not invent utterance boundaries.
- Paraformer failure: keep the fragment/audio reference, but do not invent transcript text.
- XVector failure: ASR continues; mark speaker `UNKNOWN` unless the approved suspect-exclusion mode can be applied from a valid negative suspect decision.
- Officer library unavailable: degrade to suspect-only recognition.
- Suspect voiceprint unavailable/invalid: block start of the voice-enabled interrogation workflow.
- Ambiguous similarity or insufficient voiced duration: mark `UNKNOWN` / `待确认`.
- Overlapping speakers: do not force a single identity; mark as ambiguous/overlap for review.

Voiceprint inference may update speaker metadata only. It must never modify the source audio or destructively replace the original ASR output.

## 12. Security and Privacy Requirements

Voiceprints are biometric data. The implementation must therefore:

- keep the officer library and suspect session references outside Git;
- run under the existing restricted service account and filesystem policy;
- limit read/write paths explicitly;
- record enrollment/update/revocation and manual override audit events;
- avoid exposing raw model inference endpoints publicly;
- keep suspect biometric references case/session-scoped unless a separately approved policy introduces cross-case retention;
- support deletion/revocation according to the case/evidence retention policy rather than silently accumulating biometric templates.

## 13. Implementation Phases

1. Runner-side discovery: inspect complete FunASR model directories, model metadata, installed Python environment, and actual load/inference APIs.
2. Stable read-only model mount under `/opt/suspect-interrogation/models/funasr`.
3. Registry and runtime adapter updates for Paraformer, FSMN-VAD, and XVector.
4. Speech Pipeline Worker with session-scoped VAD/ASR/speaker state.
5. Suspect enrollment and mandatory pre-session gate.
6. Persistent officer voiceprint library and enroll/update/revoke operations.
7. Session assignment of suspect/interrogator/recorder templates.
8. Speaker decision engine with threshold + margin + fallback provenance.
9. Temporary ASR fragment schema and audit extension.
10. Frontend `声纹准备` flow and richer speaker labels.
11. Real-device threshold, latency, audio-quality, and long-session calibration.
12. GitHub Runner deployment, restart, boot, failure/degradation, and end-to-end acceptance tests.

## 14. Acceptance Criteria

The feature is complete only when all of the following are verified on the target RK3588:

- all three installed FunASR models load from the stable production model path;
- no model weights are committed to Git or copied into every application release;
- suspect enrollment is required before voice interrogation can start;
- suspect-only mode marks verified suspect speech and classifies remaining speech as unverified police fallback;
- one-officer and two-officer enrollment modes work independently;
- a persistent officer template can be reused in later sessions and assigned a different session role;
- full mode distinguishes suspect, interrogating officer, and recording officer with calibrated confidence handling;
- ambiguous/short/overlap speech is not silently forced into a person identity;
- original ASR output, speaker decision provenance, and manual corrections remain auditable;
- ASR/VAD/speaker failures degrade according to policy without taking down the core interrogation service;
- systemd sandboxing still blocks unnecessary home-directory access and the model mount is read-only;
- continuous real microphone tests meet the project latency/reliability targets established during device calibration.

## 15. Explicit Non-Goals for This Phase

- Converting the `.pt` / `.pth` models to RKNN/NPU format.
- Building a cross-case suspect biometric database.
- Treating an unverified non-suspect segment as biometrically verified police identity.
- Replacing the human confirmation workflow for official transcript creation.
- Killing or taking ownership of unrelated services already using port 8000.
