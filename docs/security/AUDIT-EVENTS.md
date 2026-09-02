# Append-Only Audit Event Contract

## Invariant

The business `AuditLog` implementation is append-only. Existing events are never edited or deleted through ordinary application APIs. Corrections are represented by later events that reference the affected entity/revision.

Audit payloads must minimize sensitive data. In particular, **raw PCM/audio, enrollment audio, speaker embeddings, biometric vectors, secret values, and raw identity-document numbers must never be written into `AuditLog` payloads or ordinary log messages**.

## Core business events

The normal case lifecycle should append events for case creation, identity operations, session transitions, transcript/revision changes, freeze/sign/report operations, and configuration administration where implemented. Payloads should contain stable record IDs and non-sensitive result/category metadata rather than duplicating evidence or PII.

## Voiceprint and speech events implemented by the Linux backend

The following action names are current application-level `AuditLog` events and are part of the voice/speech provenance contract:

| Action | Meaning | Allowed audit metadata |
| --- | --- | --- |
| `SUSPECT_VOICEPRINT_ENROLL` | First suspect voiceprint enrollment for the case | case/voiceprint IDs, model ID/version, quality and usable-duration metadata |
| `SUSPECT_VOICEPRINT_REENROLL` | Suspect voiceprint replaced by a new enrollment | old/new record references and non-biometric enrollment metadata |
| `OFFICER_VOICEPRINT_ENROLL` | New reusable officer voiceprint registered | officer/voiceprint IDs, model ID/version, quality and duration metadata |
| `OFFICER_VOICEPRINT_UPDATE` | Existing officer voiceprint re-enrolled/updated | officer/voiceprint references and non-biometric enrollment metadata |
| `OFFICER_VOICEPRINT_REVOKE` | Officer voiceprint revoked | officer/voiceprint reference and revocation state |
| `SESSION_VOICE_ROLE_BIND` | Officer templates selected for interrogator/recorder roles in one session | session ID and selected record references |
| `ASR_SPEAKER_FALLBACK` | Suspect-only exclusion classified the utterance as business-visible `OFFICER_FALLBACK` | fragment ID, effective role/source, verification flag, score/threshold/margin and usable duration |
| `ASR_SPEAKER_LOW_CONFIDENCE` | Speaker result could not be safely assigned and remained `UNKNOWN` | fragment ID, effective role/source, verification flag, score/threshold/margin, usable duration and non-sensitive error code when available |
| `ASR_FRAGMENT_UPDATE` | Operator edited temporary text and/or manually corrected the effective speaker | before/after text/speaker metadata; effective `speaker_source=MANUAL`, `voiceprint_verified=false`; raw ASR text remains immutable |
| `ASR_FRAGMENT_CONFIRM` | Reviewed temporary fragment entered the official transcript | fragment/message IDs and selected effective text/speaker metadata |
| `ASR_FRAGMENT_DISCARD` | Temporary fragment was discarded before confirmation | fragment ID and state transition |

New voiceprint-verified decisions use backend-neutral `speaker_source=SPEAKER_EMBEDDING`. The exact speaker backend/model is separate evidence metadata (`backend_key`, model ID/version/fingerprint where available). Historical persisted or audit values of `speaker_source=X_VECTOR` remain valid and readable; the append-only contract forbids rewriting those historical rows merely to adopt the generic provenance value.

`ASR_SPEAKER_FALLBACK` does **not** assert a voiceprint-verified officer identity. `OFFICER_FALLBACK` means the utterance was classified by the approved suspect-exclusion rule when officer identity was not voiceprint verified.

`ASR_SPEAKER_LOW_CONFIDENCE` is the fail-safe path. If the selected speaker-embedding backend is unavailable but Paraformer produced a valid ASR result, the text may still be retained as a temporary fragment with `speaker=UNKNOWN`, `speaker_source=UNASSIGNED`, `voiceprint_verified=false`, and `low_confidence=true` for human confirmation. The audit event may record a typed speaker error code and non-sensitive backend/model identifiers, but never the embedding or audio that caused it.

## Operational speech failures

Not every runtime failure has a case-scoped business `AuditLog` row. The following are operational health/service failures and must be observable through capability/status responses and service logs without fabricating business evidence:

- speech worker startup/socket/model-load failure;
- FSMN-VAD inference/protocol failure;
- Paraformer ASR inference failure;
- selected speaker-backend load/inference failure;
- ALSA/audio-capture failure.

The operational rules are fail-safe:

- VAD failure does not invent utterance boundaries; capture cleanup still runs.
- ASR failure creates no fabricated transcript text.
- Selected speaker-backend failure does not discard a successful ASR result; speaker attribution degrades to `UNKNOWN` unless an already-approved deterministic fallback rule applies.
- Missing selected-model reference does not permit cross-model fallback or relabeling of another backend's embedding.
- Missing or invalid speaker calibration keeps speaker verification `NOT_CONFIGURED` and blocks formal calibrated capture rather than using an undocumented operating point.
- Missing suspect voiceprint for the selected backend blocks formal voice-enabled capture/start.

When an operational speaker error reaches an otherwise valid temporary fragment, its typed error code can be attached to the corresponding `ASR_SPEAKER_LOW_CONFIDENCE` event. Worker/VAD/ASR failures that occur before a fragment exists remain operational telemetry rather than creating a misleading fragment-level audit record.

## Storage requirements

- Append-only semantics at the application layer.
- Stable event ID and server-side UTC timestamp.
- Actor and case/session correlation when applicable.
- Structured `before`, `after`, and `detail` payloads.
- PII/biometric minimization; reference authoritative records instead of duplicating sensitive content.
- Backup/restore includes the audit store.

## Verification requirements

Automated tests must prove that speaker fallback/low-confidence events are appended without raw audio/PCM/embedding data, that manual correction cannot mutate immutable source ASR text/model scores, that historical `X_VECTOR` provenance remains readable without rewriting existing rows, and that business audit history survives normal database/service lifecycle operations. Real-device calibration and RK3588 acceptance remain separate Task 12 evidence and must not be inferred from hosted CI.
