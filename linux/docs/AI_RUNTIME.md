# Linux Offline AI Runtime

The Linux deployment is offline-first. FastAPI owns business state, persistence, speaker policy, transcript confirmation, and AI supervision. The FunASR speech stack is isolated in `ai-worker.service` and communicates with FastAPI over a Unix-domain socket; it does not expose another public TCP service.

OCR/LLM and the legacy non-speech AI supervisor workers remain isolated from the business process. The dedicated speech worker owns FunASR/PyTorch model objects and streaming VAD session state.

## Speech pipeline

Production speech flow is:

```text
ALSA microphone
  -> 16 kHz mono PCM16 chunks
  -> FastAPI AsrCaptureService
  -> AF_UNIX /run/suspect-interrogation/speech.sock
  -> FSMN-VAD streaming state
  -> utterance boundary
  -> Paraformer ASR + XVector speaker embedding
  -> FastAPI speaker policy
  -> temporary ASR fragment
  -> operator review/correction
  -> official transcript message
```

Each new PCM chunk is sent once. The worker does not receive case rows, officer names, badge numbers, or other business identity data. Speaker embeddings are returned only for transient comparison and are not written to ordinary logs or ASR fragment audit payloads.

## Stable production layout

Speech model/runtime assets are intentionally outside Git releases:

- FunASR model root: `/opt/suspect-interrogation/models/funasr`
  - `paraformer/`
  - `fsmn-vad/`
  - `xvector/`
- isolated FunASR Python runtime: `/opt/suspect-interrogation/runtime/funasr-env`
- speech socket: `/run/suspect-interrogation/speech.sock`

The RK3588 bootstrap exposes the preinstalled model directory at the stable model root as a read-only bind mount and reuses a validated isolated runtime. Model weights are never downloaded by ordinary hosted CI and are not committed to Git.

The currently approved `.pt`/`.pth` FunASR baseline is PyTorch **CPU** execution on RK3588. Do not describe this path as RKNN/NPU-accelerated unless a separately converted and measured runtime is introduced and verified later.

## Model isolation and degradation

Paraformer ASR, FSMN-VAD, and XVector are reported independently. A live worker process alone is not sufficient to claim every speech capability is available.

- Paraformer load/inference failure makes ASR unavailable; no transcript text is fabricated.
- FSMN-VAD failure makes VAD unavailable; no utterance boundaries are invented.
- XVector load failure does not clear already loaded Paraformer/FSMN-VAD models.
- XVector inference failure does not discard a successful ASR result. The temporary fragment is retained and speaker attribution degrades to a fail-safe state.
- A missing/revoked optional officer template is skipped; if the suspect reference remains valid, policy can degrade to suspect-only mode.
- A missing suspect voiceprint blocks formal voice-enabled capture/start.
- overlap, insufficient voiced duration, threshold failure, or insufficient best-vs-second margin resolves to `UNKNOWN` rather than guessing a person.

Business roles are:

```text
SUSPECT
INTERROGATOR
RECORDER
OFFICER_FALLBACK
UNKNOWN
```

Business provenance sources are:

```text
X_VECTOR
SUSPECT_EXCLUSION
MANUAL
UNASSIGNED
```

`OFFICER_FALLBACK` is intentionally unverified. In suspect-only mode it means the utterance passed the approved suspect-exclusion rule; it does not claim the identity of a particular officer.

## Voiceprint calibration is mandatory

Production speaker verification has **no built-in numeric threshold or margin**. Both values must be obtained from Task 12 calibration on the target RK3588 using the production microphone/environment:

```text
SUSPECT_SPEAKER_ACCEPT_THRESHOLD=<calibrated decimal 0..1>
SUSPECT_SPEAKER_MARGIN=<calibrated decimal 0..1>
```

Both must be finite values in `[0.0, 1.0]`. Missing either value reports speaker calibration as `NOT_CONFIGURED`; invalid values fail configuration validation. Formal calibrated ASR capture fails closed rather than silently substituting a default.

After Task 12 calibration, both values belong in:

```text
/etc/suspect-interrogation/ai-worker.env
```

Both `ai-worker.service` and `interrogation-api.service` read that optional environment file because the worker performs model inference while FastAPI performs the speaker decision policy.

## Health and capability reporting

`GET /health/ready` reports storage/database readiness plus independent optional capabilities:

```text
asr
vad
speaker
voiceprintCalibration
audioCapture
```

`GET /api/v1/ai/health` and `GET /api/v1/ai/capabilities` expose the lower-level supervisor/worker state. Speaker is `AVAILABLE` only when the speech worker reports XVector available **and** both calibrated values are valid.

The core API may remain operational when an optional AI/hardware capability is degraded. This is deliberate: optional model failure must not crash the evidence/case service.

## Speech APIs

Business capture routes include:

```text
GET  /api/v1/asr/status
POST /api/v1/asr/start
POST /api/v1/asr/stop
GET  /api/v1/cases/{case_id}/asr/capture
POST /api/v1/cases/{case_id}/asr/capture/start
POST /api/v1/cases/{case_id}/asr/capture/stop
GET  /api/v1/cases/{case_id}/asr/fragments
PUT  /api/v1/cases/{case_id}/asr/fragments/{fragment_id}
POST /api/v1/cases/{case_id}/asr/fragments/{fragment_id}/confirm
POST /api/v1/cases/{case_id}/asr/fragments/confirm
POST /api/v1/cases/{case_id}/asr/fragments/apply
POST /api/v1/cases/{case_id}/asr/fragments/{fragment_id}/discard
```

The low-level `WS /api/v1/ai/asr/stream?session_id=...` opens one worker speech session, pushes only newly received binary PCM chunks, finalizes explicitly, and closes the worker session in disconnect cleanup. It must never resend whole accumulated buffers as `A`, `AB`, `ABC`.

## Temporary transcript and audit rules

`raw_text` and raw model attribution metadata are source provenance. Human review changes `edited_text` and the effective speaker; a manual speaker correction becomes `speaker_source=MANUAL` and `voiceprint_verified=false` without rewriting the original audio/ASR provenance.

Speaker fallback and low-confidence decisions append business audit events without PCM/audio/embedding data. See `docs/security/AUDIT-EVENTS.md` for the current action names and the distinction between business audit rows and operational service failures.

## Services and ports

Normal production deployment keeps the project API loopback-only and the RK3588 bootstrap configures it on TCP **18080**. The speech worker uses the Unix socket above and does not allocate a new public TCP port.

An unrelated pre-existing service may own TCP **8000** on the RK3588. Deployment/CI must preserve that owner and must not stop, reconfigure, or repurpose it for this project.

## Verification status

Hosted CI verifies protocol, policy, persistence, fail-safe behavior, systemd contracts, frontend build/visual QA, and release/E2E behavior without downloading production model weights.

Real RK3588 evidence is separate. A queued/cancelled/skipped self-hosted job is **not** proof that Paraformer, FSMN-VAD, XVector, microphone capture, or calibrated speaker recognition works on the board. Task 12 must provide target-device calibration and real-device smoke evidence before real voice interrogation is considered accepted.
