# Global Officer Voiceprint Library Design

## Status

Approved 2026-08-31.

## Problem

Officer voiceprints are system-level reusable identity assets, but the current UI exposes officer enrollment/update/revocation inside the case preparation panel. The persistence model also stores exactly one mutable embedding per officer, so a new enrollment overwrites the previous reference and destroys sample provenance.

## Goals

1. Move officer voiceprint administration out of cases into a system-level settings entry.
2. Keep case pages limited to selecting and binding already-existing active officers.
3. Support multiple retained voice samples for one officer without overwriting older samples.
4. Preserve per-sample quality, capture time, audio source/device provenance, model identity/version, usable speech duration, and activation state.
5. Maintain an efficient aggregate officer reference derived from all active compatible samples.
6. Freeze the exact officer aggregate reference version used by a running interrogation so later global-library changes cannot silently change historical/running recognition behavior.
7. Preserve existing officer voiceprints through a lossless migration.
8. Continue not persisting raw enrollment audio.

## Domain model

### OfficerVoiceProfile

One global row per officer.

- `id`
- `officer_id` unique stable business identifier
- `officer_name`
- `aggregate_embedding`
- `embedding_dim`
- `model_id`
- `model_version`
- `aggregate_version` monotonically increasing integer
- `sample_count` active samples contributing to aggregate
- `active`
- `revoked_at`
- timestamps

### OfficerVoiceSample

One row per accepted enrollment capture.

- `id`
- `profile_id`
- `embedding`
- `embedding_dim`
- `model_id`
- `model_version`
- `quality`
- `usable_duration_ms`
- `segment_count`
- `audio_source`: `ALSA`, `BROWSER`, or `LEGACY_MIGRATED`
- `device_id`
- `device_name`
- `captured_at`
- `active`
- `disabled_at`
- `disabled_reason`
- `created_by`
- timestamps

Raw PCM/audio is never stored.

### SessionVoiceAssignment snapshot fields

The assignment keeps the officer business IDs, but also freezes the reference actually used by the session:

- interrogator profile ID
- interrogator aggregate version
- interrogator snapshot embedding and metadata
- recorder profile ID
- recorder aggregate version
- recorder snapshot embedding and metadata

Existing suspect voiceprint semantics remain case-scoped and unchanged.

## Aggregation

A capture is already reduced from several VAD-selected segment embeddings to one normalized sample reference. Officer aggregation adds a second level:

1. Load all active samples compatible with the profile model/dimension.
2. L2-normalize each sample reference.
3. Compute a bounded quality/duration weight for each sample; duration must not grow without bound.
4. Weighted-average the vectors.
5. L2-normalize the result.
6. Increment `aggregate_version` whenever active contributing samples change.

Initial implementation uses conservative weights: GOOD=1.0, FAIR=0.75, other accepted quality=0.5; duration factor is clamped to `[0.75, 1.25]` around 20 seconds. This prevents one long capture from dominating the profile.

## Mutation rules

- New enrollment for an existing officer means **add sample**, never overwrite.
- Disabling a sample keeps the row and rebuilds the aggregate from remaining active samples.
- Disabling the last active sample makes the profile unavailable for new case binding.
- Revoking an officer disables the profile for new bindings but does not delete samples or invalidate already-frozen session snapshots.
- Re-enabling/re-enrolling creates a new sample and aggregate version; it does not rewrite historical assignments.

## Session freeze rule

When the case binds officer roles for an active interrogation session, the service copies the then-current aggregate embedding, model metadata and aggregate version into the session assignment snapshot. Speaker recognition for that session uses this frozen snapshot.

If the global profile changes from v3 to v4 while Case A is running, Case A continues to use v3. A later Case B binds v4.

## API boundary

System-level endpoints own officer library administration:

- `GET /officer-voiceprints`
- `GET /officer-voiceprints/{officer_id}`
- enrollment start/stop adds a sample
- sample disable endpoint
- officer revoke endpoint

Case-level endpoints only:

- read readiness
- enroll/replace suspect voiceprint
- select/bind existing officer IDs to the current session

## UI boundary

Top-level application navigation adds `System Settings -> Officer Voiceprint Library` outside any case.

The officer library view supports search, profile status, aggregate version, active sample count, sample metadata, add-sample capture, sample disable, and officer revoke.

`VoiceprintPreparationPanel` keeps suspect enrollment and two selectors (`interrogator`, `recorder`) plus save binding. It must not contain officer ID/name inputs, officer enrollment, officer sample management, or revocation controls.

## Migration

Create new profile/sample structures in Alembic revision `0004_global_officer_voiceprint_library`.

For each legacy `officer_voiceprints` row:

- create one profile with the same business identity and aggregate embedding;
- create one sample with the same embedding/metadata, `audio_source=LEGACY_MIGRATED`, and capture time derived from the old row timestamp;
- set aggregate version=1 and sample count=1;
- map existing `session_voice_assignments` officer foreign keys to profile IDs and copy the legacy aggregate into frozen session snapshot fields.

No legacy embedding is discarded.

## Audit requirements

Audit globally with `case_id=None` for profile/sample administration and include officer ID, sample ID, aggregate version, sample count, quality, duration, source/device, and model metadata as applicable. Case role binding audit additionally records the frozen aggregate version for each role.

## Acceptance criteria

- Officer administration is available outside a case.
- Case preparation cannot create/update/revoke officer voiceprints.
- A second enrollment creates a second sample and increments aggregate version instead of overwriting sample 1.
- Disabling one sample preserves it and rebuilds the aggregate.
- Sample quality/time/source/device/model metadata is queryable.
- Existing legacy rows migrate to profile + sample without data loss.
- A bound/running session keeps its frozen reference when the global officer profile later changes.
- No raw voiceprint audio is persisted.
- Hosted Linux CI and RK3588 smoke gates stay green.
