# Durable Live Speech Pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Preserve live interrogation audio and finalized text through ASR/voiceprint worker restarts, then asynchronously split turns and assign police/suspect roles without losing the original transcript.

**Architecture:** Add a durable file-backed PCM/WAV archive and SQLite manifest/job ledger. The capture writer persists audio independently from inference; a replayable ASR consumer creates UNKNOWN fragments first; after the 10-second voiced/3-fragment threshold, a lower-priority speaker workflow splits turns, matches voiceprints, and re-transcribes split ranges while preserving fragment lineage.

**Tech Stack:** FastAPI, SQLAlchemy, Alembic, SQLite, Python threads/Unix-socket speech worker, Vue 3/TypeScript, WebSocket/WSS, systemd, shell backup/restore scripts.

---

## File Map

### Backend persistence and processing

- `linux/backend/app/database/models.py` — archive segment manifest, browser-frame receipt ledger, durable job state, separate recording/ASR/speaker cursors, transcript idempotency key, and fragment-lineage tables/fields.
- `linux/backend/alembic/versions/0016_durable_live_speech.py` — migration from revision `0015_case_voice_role_draft`.
- `linux/backend/app/repositories/audio_archive.py` — idempotent manifest allocation, sample-range lookup, cursor/job transitions, and recovery queries.
- `linux/backend/app/repositories/asr_fragments.py` — idempotent transcript creation, fragment replacement lineage, and role update guards.
- `linux/backend/app/services/durable_audio_archive.py` — bounded WAV segment writer, one-second durable checkpoints, sample-range reads, finalization, hash validation, and tail recovery.
- `linux/backend/app/services/live_speech_coordinator.py` — audio ingestion, ASR replay, threshold tracking, prioritized speaker jobs, recovery, and lifecycle.
- `linux/backend/app/services/asr_capture_service.py` — keep existing capture API/status compatibility while removing synchronous inference from the device reader and the enrollment gate.
- `linux/backend/app/services/source_aware_asr_capture_service.py` — pass the shared archive/coordinator into ALSA and browser capture instances without switching an active input.
- `linux/backend/app/main.py` — start/stop the coordinator in FastAPI lifespan and recover unfinished jobs at startup.
- `linux/backend/speech_worker/session.py` — Stage 1 VAD+ASR without speaker embedding or speaker-turn splitting; preserve current final/partial event semantics.
- `linux/backend/speech_worker/main.py` — support restartable replay sessions with capture-global sample/time offsets.
- `linux/backend/app/services/interrogation_projection_service.py` and `linux/backend/app/api/asr.py` — defer unknown-fragment projection; trigger idempotent projection after manual or automatic role resolution; reject confirmation of superseded parents.
- `linux/backend/app/websocket/browser_asr.py` and `linux/backend/app/services/browser_audio_input.py` — sequence-aware browser frames and acknowledgement after durable persistence.

### Frontend, archive operations, and tests

- `webapp/src/audio/browserAsrCapture.ts` — sequence/offset framing, bounded IndexedDB outbox, acknowledgement deletion, and reconnect replay for formal capture.
- `webapp/src/types/interrogation.ts` and `webapp/src/api/interrogation.ts` — typed audio/job/lineage status and event payload decoding.
- `webapp/src/stores/interrogation.ts` — merge ASR-final, speaker-resolved, and fragment-replacement events idempotently.
- `webapp/src/components/LiveDialoguePanel.vue` and `webapp/src/components/TranscriptPanel.vue` — show transcript before role analysis, independent progress/errors, and hide superseded parents from the active timeline while retaining history.
- `scripts/backup.sh` and `scripts/restore.sh` — exclude the permanent audio directory from rolling database snapshots, preserve it on same-device restore, and validate manifest references.
- `docs/release/DEPLOYMENT.md` and `docs/security/LINUX-HARDENING.md` — document archive layout, capacity, permissions, recovery, backup, and the 10 GB free-space reserve.
- Backend tests: `linux/backend/tests/test_database.py`, `test_migrations.py`, `test_dual_speaker_voiceprint_migration.py`, `test_moss_transcription_models.py`, `test_speaker_calibration_migration_contract.py`, `test_durable_audio_archive.py`, `test_live_speech_coordinator.py`, `test_asr_capture_service.py`, `test_speech_worker_server.py`, `test_asr_api.py`, `test_interrogation_projection_service.py`, `test_browser_audio_input.py`, and `test_browser_asr_transport.py`.
- Frontend tests: `webapp/src/audio/browserAsrCapture.test.ts` and new `webapp/src/stores/interrogation.test.ts`.
- Release tests: `tests/release/test_lan_https_tls.py`, `tests/release/test_backup_restore.py`, and `tests/release/test_restore_security.py`.

## Task 1: Add Durable Audio and Job Schema

**Files:**
- Modify: `linux/backend/app/database/models.py`
- Create: `linux/backend/alembic/versions/0016_durable_live_speech.py`
- Modify: `linux/backend/tests/test_database.py`
- Modify: `linux/backend/tests/test_migrations.py`
- Modify: `linux/backend/tests/test_dual_speaker_voiceprint_migration.py`
- Modify: `linux/backend/tests/test_moss_transcription_models.py`
- Modify: `linux/backend/tests/test_speaker_calibration_migration_contract.py`
- Modify: `tests/release/test_lan_https_tls.py`
- Modify: `.github/workflows/rk3588-production-redeploy.yml`

- [x] **Step 1: Add a failing schema test**

```python
def test_live_speech_tables_are_registered(tmp_path):
    engine = make_engine(f"sqlite:///{tmp_path / 'live-speech.sqlite3'}")
    init_database(engine)
    names = set(inspect(engine).get_table_names())
    assert {
        "asr_audio_segments",
        "asr_audio_frames",
        "live_speech_jobs",
        "asr_fragment_lineage",
    } <= names
```

Run from `linux/backend`: `python -m pytest tests/test_database.py::test_live_speech_tables_are_registered -q`

Expected: FAIL because the four tables do not exist.

- [x] **Step 2: Add the persistence models and Alembic migration**

Add these persisted facts, with foreign keys and indexes:

```text
ASRCaptureSession additions: audio_sample_count, asr_cursor_sample,
                             voiced_ms, recording_status, asr_status,
                             speaker_status
ASRAudioSegment: capture_session_id, sequence, relative_path,
                 start_sample, committed_samples, finalized_samples,
                 sha256, status; unique(capture_session_id, sequence)
ASRAudioFrame: capture_session_id, source_sequence, start_sample,
               end_sample, payload_sha256, durable_sample_end;
               unique(capture_session_id, source_sequence)
LiveSpeechJob: idempotency_key, kind(ASR|SPEAKER), capture_session_id,
               fragment_id?, start_sample, end_sample, state, attempts,
               model_version?, last_error_code?; unique(idempotency_key)
ASRFragment: add unique asr_idempotency_key, derived from capture/time range/model version
ASRFragmentLineage: analysis_job_id, parent_fragment_id, child_fragment_id,
                    relation(SUPERSEDES); unique(parent_fragment_id, child_fragment_id)
```

Keep audio bytes out of SQLite. Add `SUPERSEDED` as a fragment state and enforce that only never-confirmed parents can be superseded, including a previously `CONFIRMED` fragment whose message reference was deleted. Apply the guard in both migrated and fresh SQLite schemas. The migration must chain from `0015_case_voice_role_draft`, preserve every existing row, and add no data backfill that changes old speaker roles. Advance existing latest-head expectations in the migration contract tests from `0015_case_voice_role_draft` to `0016_durable_live_speech`.

Update the production redeploy workflow's post-deploy Alembic assertion from `0015_case_voice_role_draft (head)` to `0016_durable_live_speech (head)`. This keeps the required `.109` production deployment gate aligned with the schema migration.

- [x] **Step 3: Verify new-schema and upgrade paths**

Run: `python -m pytest tests/test_database.py tests/test_migrations.py tests/test_dual_speaker_voiceprint_migration.py tests/test_moss_transcription_models.py tests/test_speaker_calibration_migration_contract.py -q`

Expected: PASS for fresh `create_all`, the `0015` to `0016` migration, existing database compatibility, and all current migration-head contracts.

Run from repository root: `python -m pytest tests/release/test_lan_https_tls.py::test_production_workflow_uses_https_and_verifies_certificate_identity -q`

Expected: PASS with the production workflow and TLS contract both expecting migration head `0016_durable_live_speech`. The two Git Bash path-helper cases in the full file require Linux CI; the Windows host cannot resolve this workspace's `D:\` path inside Git Bash.

Run from `linux/backend` against a temporary database so the project database is never touched:

```powershell
$env:PYTHONPATH = '.'
$env:SUSPECT_DB_PATH = Join-Path $env:TEMP 'durable-live-speech-alembic.sqlite3'
alembic upgrade head
```

Expected: database revision is `0016_durable_live_speech` and all four new tables are present. Remove the temporary database and clear `SUSPECT_DB_PATH` after the check.

- [x] **Step 4: Commit the schema boundary**

```text
git add linux/backend/app/database/models.py linux/backend/alembic/versions/0016_durable_live_speech.py linux/backend/tests/test_database.py linux/backend/tests/test_migrations.py linux/backend/tests/test_dual_speaker_voiceprint_migration.py linux/backend/tests/test_moss_transcription_models.py linux/backend/tests/test_speaker_calibration_migration_contract.py tests/release/test_lan_https_tls.py .github/workflows/rk3588-production-redeploy.yml
git commit -m "feat: add durable live speech job schema"
```

## Task 2: Implement the File-Backed Audio Archive

**Files:**
- Create: `linux/backend/app/repositories/audio_archive.py`
- Create: `linux/backend/app/services/durable_audio_archive.py`
- Create: `linux/backend/tests/test_durable_audio_archive.py`

- [x] **Step 1: Add archive lifecycle and crash-recovery tests**

```python
def test_archive_reopens_only_durable_pcm_and_finalizes_hash(tmp_path, session_factory):
    archive = DurableAudioArchive(tmp_path, session_factory, sample_rate=16_000)
    archive.open_capture("capture-1", case_id="case-1")
    archive.append("capture-1", b"\x01\x00" * 16_000)
    archive.finalize_capture("capture-1")

    segments = archive.list_segments("capture-1")
    assert len(segments) == 1
    assert segments[0].finalized_samples == 16_000
    assert len(segments[0].sha256) == 64
```

Add sibling cases for restart recovery of an active segment, incomplete PCM16 frames, path traversal attempts, and a simulated disk-full exception. Each must report an explicit gap/incomplete state rather than returning a complete archive.

Run: `python -m pytest tests/test_durable_audio_archive.py -q`

Expected: FAIL because `DurableAudioArchive` does not exist.

- [x] **Step 2: Implement the archive interface**

Implement this public surface in `durable_audio_archive.py`:

```python
class DurableAudioArchive:
    def open_capture(self, capture_id: str, *, case_id: str) -> None: ...
    def append(self, capture_id: str, pcm: bytes, *, source_sequence: int | None = None) -> int: ...
    def read_samples(self, capture_id: str, start: int, end: int) -> bytes: ...
    def list_segments(self, capture_id: str) -> list[ASRAudioSegment]: ...
    def finalize_capture(self, capture_id: str) -> list[ASRAudioSegment]: ...
    def recover_incomplete(self) -> list[str]: ...
```

Write 16 kHz mono PCM16 to one-minute WAV segments under `data_dir/audio/<case_id>/<capture_id>/`; checkpoint and `fsync` the active segment at least once per second. Persist committed sample counts and segment hashes through `audio_archive.py`. For a browser `source_sequence`, atomically persist its sample range, payload hash, and durable end sample in `asr_audio_frames` with the append; an identical replay returns that stored receipt, while a conflicting replay fails the capture. On recovery, truncate uncommitted tail bytes, repair the partial WAV header, and accept only complete PCM frames through the last durable checkpoint. Finalized files are immutable and mode `0640`; directories are mode `0750`.

- [x] **Step 3: Verify file bytes, manifest, and failure behavior**

Run: `python -m pytest tests/test_durable_audio_archive.py -q`

Expected: PASS; the 16,000-sample fixture reads back as exactly 32,000 PCM payload bytes and the stored hash matches the finalized file.

- [x] **Step 4: Commit the archive unit**

```text
git add linux/backend/app/repositories/audio_archive.py linux/backend/app/services/durable_audio_archive.py linux/backend/tests/test_durable_audio_archive.py
git commit -m "feat: persist live audio archive segments"
```

## Task 3: Separate Device Capture from Inference

**Files:**
- Create: `linux/backend/app/services/live_speech_coordinator.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `linux/backend/app/repositories/audio_archive.py`
- Modify: `linux/backend/app/services/source_aware_asr_capture_service.py`
- Modify: `linux/backend/app/main.py`
- Create: `linux/backend/tests/test_live_speech_coordinator.py`

- [x] **Step 1: Add an inference-stall capture test**

Use a fake device that yields three known PCM frames and a fake speech worker blocked on an event. Assert that the archive contains all three frames and the reader continues until stopped while the worker remains blocked. Also assert that a configured disk failure marks the capture `INCOMPLETE` and publishes a storage error.

Run: `python -m pytest tests/test_live_speech_coordinator.py::test_capture_persists_audio_while_asr_worker_is_blocked -q`

Expected: FAIL because capture currently invokes the speech worker in the read loop.

- [x] **Step 2: Add the lifecycle-owned coordinator**

`LiveSpeechCoordinator` owns the archive writer, capture reader, ordered durable cursors, ASR queue, lower-priority speaker queue, and recovery loop. Device capture must perform `read -> durable append -> notify coordinator`; it must not invoke `push_speech_pcm`, `speaker_embedding`, or block on model calls. The ASR consumer reads only committed samples. The coordinator keeps independent states for recording, ASR backlog, and speaker analysis.

In `main.py`, construct the coordinator from `runtime_settings.data_dir`, `session_factory`, `SourceAwareAsrCaptureService`, and `ai_supervisor`; call `start()` before serving and `shutdown()` in the existing lifespan `finally` block. Recovery on startup scans unfinished captures and queues their remaining audio before speaker work.

- [x] **Step 3: Keep the capture API compatible and remove the voiceprint start gate**

Keep existing `start`, `stop`, and `status` response keys in `AsrCaptureService`. Remove the `SUSPECT_VOICEPRINT_REQUIRED` / `SUSPECT_VOICEPRINT_BACKEND_REQUIRED` start rejection. Capture may start with no suspect/officer references; speaker state then remains pending/unknown. Preserve calibration snapshots when available and record an unavailable-calibration status when not.

- [x] **Step 4: Verify capture independence and compatibility**

Run: `python -m pytest tests/test_live_speech_coordinator.py tests/test_asr_capture_service.py tests/test_asr_capture_fail_safe.py tests/test_asr_audio_source_routing.py -q`

Expected: PASS; blocked/failed inference does not stop durable capture, and existing capture/status routes remain compatible.

- [x] **Step 5: Commit the capture boundary**

```text
git add linux/backend/app/services/live_speech_coordinator.py linux/backend/app/services/asr_capture_service.py linux/backend/app/services/source_aware_asr_capture_service.py linux/backend/app/main.py linux/backend/tests/test_live_speech_coordinator.py linux/backend/tests/test_asr_capture_service.py
git commit -m "feat: decouple audio capture from speech inference"
```

## Task 4: Make Stage 1 ASR-Only and Replayable

**Files:**
- Modify: `linux/backend/speech_worker/session.py`
- Modify: `linux/backend/speech_worker/main.py`
- Modify: `linux/backend/app/services/live_speech_coordinator.py`
- Modify: `linux/backend/app/repositories/asr_fragments.py`
- Modify: `linux/backend/tests/test_speech_worker_server.py`
- Modify: `linux/backend/tests/test_live_speech_coordinator.py`

- [x] **Step 1: Specify ASR-only worker and idempotent replay tests**

```python
def test_stage_one_emits_final_text_without_speaker_inference():
    runtime = FakeRuntime()  # Reuse the deterministic fake in test_speech_worker_server.py.
    speech_session = SpeechSession("capture-1", 16_000, runtime)
    events = speech_session.push_pcm(_pcm(200)) + speech_session.finalize()
    assert any(event.type is SpeechEventType.ASR_FINAL for event in events)
    assert not any(event.type in {SpeechEventType.SPEAKER_RESULT, SpeechEventType.SPEAKER_COMPARE_RESULT} for event in events)
```

```python
def test_replaying_committed_audio_range_does_not_duplicate_fragment(coordinator, capture_id, fragment_repository):
    first = coordinator.process_asr_range(capture_id, 0, 16_000)
    second = coordinator.process_asr_range(capture_id, 0, 16_000)
    assert first.fragment_ids == second.fragment_ids
    assert len(fragment_repository.list_for_capture(capture_id)) == 1
```

Run the two focused test names. Expected: FAIL because `SpeechSession` embeds/splits before ASR and the coordinator has no durable replay path.

- [x] **Step 2: Remove speaker work from Stage 1**

In `SpeechSession._finish_utterance`, emit the VAD-bounded ASR result without `_split_turns`, `_embed_for_split`, `_extract_speaker`, `SPEAKER_RESULT`, or compare events. Keep `ASR_PARTIAL` as provisional preview. In the coordinator, persist every non-empty `ASR_FINAL` with `speaker="UNKNOWN"`, `speaker_source="PENDING_ANALYSIS"`, and the global capture-relative range before advancing the ASR cursor. Add `list_for_capture(capture_id)` to the fragment repository so replay tests can verify that only one database row exists for the idempotency key. Supply a `fragment_repository` fixture backed by the same test database used by the coordinator.

- [x] **Step 3: Recover uncommitted utterances after worker restart**

Store the last committed ASR sample boundary and the start of any unfinished VAD range. Re-open a speech session with a capture-global base offset and replay from the unfinished range start, including the existing VAD pre-roll. Use a unique `(capture_session_id, start_sample, end_sample, model_version)` replay key. Advance a range only after its final fragment transaction commits. A replayed final updates/reuses its existing fragment; it never creates a second ordinal for the same key.

- [x] **Step 4: Verify model-independent text persistence**

Run: `python -m pytest tests/test_speech_worker_server.py tests/test_live_speech_coordinator.py tests/test_asr_capture_service.py -q`

Expected: PASS; Stage 1 still persists text when the speaker backend is unavailable, and a simulated worker restart replays the unfinished range exactly once.

- [x] **Step 5: Commit the ASR recovery unit**

```text
git add linux/backend/speech_worker/session.py linux/backend/speech_worker/main.py linux/backend/app/services/live_speech_coordinator.py linux/backend/app/repositories/asr_fragments.py linux/backend/tests/test_speech_worker_server.py linux/backend/tests/test_live_speech_coordinator.py
git commit -m "feat: replay durable audio into ASR"
```

## Task 5: Add the Delayed Speaker Workflow and Turn Re-Transcription

**Files:**
- Create: `linux/backend/alembic/versions/0019_deferred_speaker_analysis.py`
- Modify: `linux/backend/app/database/recognition_models.py`
- Modify: `linux/backend/app/api/asr.py` (order fragments by their capture timeline)
- Modify: `linux/backend/app/services/live_speech_coordinator.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `linux/backend/app/repositories/asr_fragments.py`
- Modify: `linux/backend/speech_worker/session.py`
- Create: `linux/backend/tests/test_live_speaker_analysis.py`
- Modify: `linux/backend/tests/test_asr_api.py`

- [x] **Step 1: Add threshold, backfill, split, and preservation tests**

Cover these cases with a fake archive and fake speaker embeddings:

```python
assert coordinator.speaker_jobs_ready(capture_id, voiced_ms=9_999, final_count=3) is False
assert coordinator.speaker_jobs_ready(capture_id, voiced_ms=10_000, final_count=2) is False
assert coordinator.speaker_jobs_ready(capture_id, voiced_ms=10_000, final_count=3) is True
```

Also assert that stop schedules a final batch below the threshold; a two-turn VAD range creates two child fragments only after both re-transcriptions succeed; the parent raw text stays in lineage; a manual/confirmed parent is never replaced; and ambiguous/short segments remain `UNKNOWN`.

Run: `python -m pytest tests/test_live_speaker_analysis.py -q`

Expected: FAIL because there is no persistent speaker queue or deferred splitter.

- [x] **Step 2: Schedule low-priority speaker jobs**

Queue speaker analysis only after `voiced_ms >= 10_000` and `final_fragment_count >= 3`. At capture stop, schedule the remaining available ranges regardless of the threshold. On first activation, enqueue every unresolved range from the start of the session; subsequently enqueue each new final fragment. The coordinator processes ASR backlog before speaker jobs and yields before each speaker embedding or child transcription so new ASR can regain priority between inference calls. Persist jobs and requeue pending/interrupted jobs after restart.

- [x] **Step 3: Split turns and map voiceprints**

For each speaker job, run the existing `SpeakerTurnSplitter` against the archived PCM, then compare stable turn embeddings to voiceprints enabled for the active interrogation session using `decide_speaker` and the existing calibration snapshot. Persist scores, threshold/margin, model version/fingerprint, overlap, and decision source. Do not move the calibrated turn-splitter thresholds in this feature.

- [x] **Step 4: Re-transcribe and preserve mixed-turn fragments**

When a pending Stage 1 fragment contains multiple stable turns, run ASR against each exact turn range. In one transaction, write the child text fragments, lineage rows, speaker results, and a parent `SUPERSEDED` state only after all child ASR calls succeed. After commit, publish `ASR_FRAGMENT_REPLACED` with `{ parentFragmentId, fragments, jobId }`. If any child ASR fails or a boundary is ambiguous, retain the parent as active `UNKNOWN` and mark the job `NEEDS_REVIEW`. Never replace a manually edited or confirmed parent.

- [x] **Step 5: Verify asynchronous role completion**

Run: `python -m pytest tests/test_live_speaker_analysis.py tests/test_asr_capture_service.py tests/test_asr_recognition_evidence.py tests/test_asr_api.py -q`

Run from the repository root: `python -m pytest tests/release/test_lan_https_tls.py::test_production_workflow_uses_https_and_verifies_certificate_identity -q`

Expected: PASS; transcript rows exist before the threshold, analysis backfills them after the threshold, speaker-worker failure leaves the transcript unchanged, delayed replacements stay in audio order, and the production workflow checks migration head `0019_deferred_speaker_analysis`.

- [x] **Step 6: Commit the speaker workflow**

```text
git add .github/workflows/rk3588-production-redeploy.yml docs/superpowers/plans/2026-09-23-durable-live-speech-pipeline.md linux/backend/alembic/versions/0019_deferred_speaker_analysis.py linux/backend/app/api/asr.py linux/backend/app/database/recognition_models.py linux/backend/app/repositories/asr_fragments.py linux/backend/app/services/asr_capture_service.py linux/backend/app/services/live_speech_coordinator.py linux/backend/speech_worker/session.py linux/backend/tests/test_asr_api.py linux/backend/tests/test_live_speaker_analysis.py linux/backend/tests/test_dual_speaker_voiceprint_migration.py linux/backend/tests/test_migrations.py linux/backend/tests/test_moss_transcription_models.py linux/backend/tests/test_speaker_calibration_migration_contract.py tests/release/test_lan_https_tls.py
git commit -m "feat: add deferred speaker analysis and transcript lineage"
```

## Task 6: Resolve Speaker Roles into Interrogation Projection

**Files:**
- Modify: `linux/backend/app/api/asr.py`
- Modify: `linux/backend/app/repositories/asr_fragments.py`
- Modify: `linux/backend/app/services/qa_routing_coordinator.py`
- Modify: `linux/backend/app/services/interrogation_projection_service.py`
- Modify: `linux/backend/app/services/live_speech_coordinator.py`
- Modify: `linux/backend/tests/test_asr_api.py`
- Modify: `linux/backend/tests/test_interrogation_projection_service.py`
- Modify: `linux/backend/tests/test_qa_routing_coordinator.py`
- Modify: `linux/backend/tests/test_qa_unit_builder.py`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/stores/templateInterrogation.ts`
- Modify: `webapp/src/runtime/linuxHttpWsAdapter.ts`
- Modify: `webapp/src/runtime/__tests__/apiFacade.test.ts`
- Modify: `webapp/src/runtime/__tests__/linuxHttpWsAdapter.test.ts`
- Modify: `webapp/src/utils/asrFragments.ts`
- Modify: `webapp/src/utils/asrFragments.test.ts`

- [x] **Step 1: Add projection ordering tests**

Assert that an UNKNOWN final fragment remains available in the transcript but is not projected into a police/suspect question/answer; when its role becomes known, it is projected once; repeating the same role-resolution event does not append a duplicate answer or question; and a manually assigned role is not overwritten by an automatic result.
When a delayed replacement arrives after later speech, active transcript rows remain ordered by capture start and audio time, not by result creation time or arrival order.

Run: `python -m pytest tests/test_interrogation_projection_service.py tests/test_asr_api.py -q`

Expected: FAIL because current processing records UNKNOWN as `RAW_ONLY` and returns that result on every retry.

- [x] **Step 2: Defer projection until identity is known**

Publish UNKNOWN fragments immediately to the live transcript but do not enqueue them into `QARoutingCoordinator` or `InterrogationProjectionService`. After automatic resolution, enqueue the resolved fragment. In `api/asr.py`, when a manual edit changes an UNKNOWN role to a known role, commit the edit then enqueue that fragment through the same sink.

- [x] **Step 3: Guard lineage and replay**

Exclude `SUPERSEDED` parents from normal fragment listing and confirmation. Keep a history response/payload containing lineage. Process child fragments once. Add an explicit retry path for a previously persisted `RAW_ONLY` fragment only when its former role was UNKNOWN and the new role is resolved; never replay rows with a non-RAW_ONLY action.

- [x] **Step 4: Verify no duplicate formal projection**

Run: `python -m pytest tests/test_interrogation_projection_service.py tests/test_interrogation_projection_freeze.py tests/test_qa_routing_coordinator.py tests/test_asr_api.py -q`

Expected: PASS; UNKNOWN text remains visible, resolved children route once, and confirmed/manual records are unchanged.
Additional recovery checks cover stopped captures, queue saturation, legacy projection replay, capture-time order, and batches larger than 256 rows.

- [x] **Step 5: Commit the projection boundary**

```text
git add docs/superpowers/plans/2026-09-23-durable-live-speech-pipeline.md linux/backend/app/api/asr.py linux/backend/app/repositories/asr_fragments.py linux/backend/app/services/qa_routing_coordinator.py linux/backend/tests/test_asr_api.py linux/backend/tests/test_qa_routing_coordinator.py linux/backend/tests/test_qa_unit_builder.py webapp/src/stores/interrogation.ts webapp/src/utils/asrFragments.ts webapp/src/utils/asrFragments.test.ts
git commit -m "fix: harden deferred fragment routing recovery"
```

## Task 7: Make Browser Audio Frames Replayable

**Files:**
- Modify: `linux/backend/app/repositories/audio_archive.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `linux/backend/app/services/durable_audio_archive.py`
- Modify: `linux/backend/app/services/live_speech_coordinator.py`
- Modify: `linux/backend/app/services/source_aware_asr_capture_service.py`
- Modify: `linux/backend/app/websocket/browser_asr.py`
- Modify: `linux/backend/tests/test_durable_audio_archive.py`
- Modify: `linux/backend/tests/test_browser_asr_transport.py`
- Modify: `linux/backend/tests/test_live_speech_coordinator.py`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/audio/browserAsrCapture.ts`
- Modify: `webapp/src/audio/browserAsrCapture.test.ts`
- Create: `webapp/src/audio/browserCaptureResumeGate.ts`
- Create: `webapp/src/audio/browserCaptureResumeGate.test.ts`
- Modify: `webapp/src/runtime/linuxHttpWsAdapter.ts`
- Modify: `webapp/src/runtime/__tests__/apiFacade.test.ts`
- Modify: `webapp/src/runtime/__tests__/linuxBrowserStop.test.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/types/interrogation.ts`

- [x] **Step 1: Add transport sequence/ack tests**

Use the formal capture socket to send sequence `1` twice and assert one durable sample range plus the same acknowledgement both times, including after backend restart. Assert the server sends no acknowledgement before durable append and reports a missing sequence as a discontinuity. Keep question-preparation transport on its current path.

Run: `python -m pytest tests/test_browser_audio_input.py tests/test_browser_asr_transport.py -q`

Expected: FAIL because the current socket accepts unsequenced binary PCM and closes on queue full.

- [x] **Step 2: Define and implement the formal frame envelope**

Formal binary frames begin with a fixed 12-byte little-endian header: `uint32 sequence`, `uint64 start_sample`, followed by aligned PCM16. The WebSocket server validates monotonic sequence/sample ranges, passes the frame to the durable ingress, and replies with JSON `{ "ackSequence": n, "durableSampleEnd": end }` only after archive checkpoint/manifest commit. An identical retransmission returns the prior acknowledgement; a conflicting retransmission or sequence gap marks a discontinuity.

- [x] **Step 3: Add bounded browser outbox/reconnect**

Persist only unacknowledged formal frames in IndexedDB. Delete a frame after its durable acknowledgement. Reconnect the existing capture socket, replay unacknowledged frames in sequence order, and continue reading the same microphone stream. If the bounded outbox or browser storage quota is exhausted, pause/stop microphone capture and show an explicit incomplete-capture state; never drop unacknowledged frames silently. A confirmed stop clears the remaining outbox only after the server confirms finalization. `QUESTION_PREP` stays on its existing protocol.

- [x] **Step 4: Verify frame delivery and secure URL behavior**

Run: `python -m pytest tests/test_browser_audio_input.py tests/test_browser_asr_transport.py -q`

Expected: PASS; duplicate frames are idempotent and sequence gaps are explicit.

Run from repository root: `npm --prefix webapp test -- src/audio/browserAsrCapture.test.ts`

Expected: PASS; reconnect resends only unacknowledged sequences and HTTPS origins still produce WSS URLs.

- [x] **Step 5: Commit the browser transport**

```text
git add docs/superpowers/plans/2026-09-23-durable-live-speech-pipeline.md linux/backend/app/repositories/audio_archive.py linux/backend/app/services/asr_capture_service.py linux/backend/app/services/durable_audio_archive.py linux/backend/app/services/live_speech_coordinator.py linux/backend/app/services/source_aware_asr_capture_service.py linux/backend/app/websocket/browser_asr.py linux/backend/tests/test_durable_audio_archive.py linux/backend/tests/test_browser_asr_transport.py linux/backend/tests/test_live_speech_coordinator.py webapp/src/api/interrogation.ts webapp/src/audio/browserAsrCapture.ts webapp/src/audio/browserAsrCapture.test.ts webapp/src/audio/browserCaptureResumeGate.ts webapp/src/audio/browserCaptureResumeGate.test.ts webapp/src/runtime/linuxHttpWsAdapter.ts webapp/src/runtime/__tests__/apiFacade.test.ts webapp/src/runtime/__tests__/linuxBrowserStop.test.ts webapp/src/stores/interrogation.ts webapp/src/types/interrogation.ts
git commit -m "feat: acknowledge and replay browser ASR audio"
```

## Task 8: Expose Workflow State and Lineage in the UI

Task 8 must also provide a user-accessible way to inspect and recover retained browser outbox frames after an incomplete capture is stopped. The frames remain in IndexedDB, but there is currently no UI to list or export them; they must not be deleted silently.

**Files:**
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `linux/backend/app/services/source_aware_asr_capture_service.py`
- Modify: `linux/backend/app/services/live_speech_coordinator.py`
- Modify: `linux/backend/app/services/durable_audio_archive.py`
- Modify: `linux/backend/app/websocket/browser_asr.py`
- Modify: `linux/backend/tests/test_asr_capture_service.py`
- Modify: `linux/backend/tests/test_live_speech_coordinator.py`
- Modify: `linux/backend/tests/test_browser_asr_transport.py`
- Modify: `webapp/src/types/interrogation.ts`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/audio/browserAsrCapture.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Create: `webapp/src/components/AsrWorkflowStatus.vue`
- Modify: `webapp/src/components/LiveDialoguePanel.vue`
- Modify: `webapp/src/components/TranscriptPanel.vue`
- Modify: `webapp/src/components/TemplateDrivenInterrogationPage.vue`
- Modify: `webapp/src/components/VoiceprintPreparationPanel.vue`
- Modify: `webapp/src/components/VoiceprintPreparationPanel.test.ts`
- Modify: `webapp/src/views/InterrogationWorkspace.vue`
- Modify: `webapp/src/utils/templateInterrogation.ts`
- Create: `webapp/src/stores/interrogation.test.ts`
- Modify: `webapp/src/utils/templateInterrogation.test.ts`

- [x] **Step 1: Add event reducer and browser recovery tests**

```ts
it('keeps final text visible before speaker resolution and replaces superseded parents once', () => {
  const store = useInterrogationStore()
  const fragment = (id: string, ordinal: number) => ({
    id, caseId: 'case-1', captureSessionId: 'capture-1', ordinal,
    startedAtMs: ordinal * 1000, endedAtMs: (ordinal + 1) * 1000,
    rawText: '问到哪了？', editedText: '问到哪了？', speaker: 'UNKNOWN',
    speakerSource: 'UNASSIGNED', state: 'PENDING',
  })
  const replacement = {
    event: 'ASR_FRAGMENT_REPLACED',
    payload: { parentFragmentId: 'f1', fragments: [fragment('f2', 1), fragment('f3', 2)] },
  }
  store.applyCaptureEvent({ event: 'ASR_FRAGMENT', payload: fragment('f1', 0) })
  expect(store.activeFragments[0].speaker).toBe('UNKNOWN')
  store.applyCaptureEvent(replacement)
  store.applyCaptureEvent(replacement)
  expect(store.activeFragments.map((item) => item.id)).toEqual(['f2', 'f3'])
  expect(store.fragmentHistory('f1').map((item) => item.id)).toEqual(['f1'])
})
```

Run: `npm --prefix webapp test -- src/stores/interrogation.test.ts`

Expected: FAIL because the store has no speaker-resolution/lineage reducer.

- [x] **Step 2: Add typed API and store reducers**

Extend the fragment state union with `SUPERSEDED`; add `recordingStatus`, `asrStatus`, `speakerStatus`, and lineage IDs to the capture/fragment types. Parse these fields in `api/interrogation.ts`. Add `applyCaptureEvent(event)`, `activeFragments`, and `fragmentHistory(parentId)` to the store. Handle the existing `ASR_FRAGMENT` event and the new `ASR_FRAGMENT_REPLACED` payload `{ parentFragmentId, fragments }` idempotently by fragment and job/revision ID; retain superseded rows in history, but exclude them from active transcript rows. Route websocket events through the same reducer.

- [x] **Step 3: Render capture and identity states**

In the two transcript panels, display finalized UNKNOWN text immediately with “说话人待识别”, then update role when resolved. Show recording, ASR backlog, voiceprint progress, and incomplete/audio-gap status independently. Keep the current manual speaker selector; disable confirmation only for UNKNOWN or SUPERSEDED fragments.

- [x] **Step 4: Verify frontend and durable recovery behavior**

Run: `npm --prefix webapp test -- src/stores/interrogation.test.ts src/audio/browserAsrCapture.test.ts`

Expected: PASS.

Run: `npm --prefix webapp run typecheck`

Expected: exit code `0`.

- [x] **Step 5: Commit the live transcript UI**

```text
git add webapp/src/types/interrogation.ts webapp/src/api/interrogation.ts webapp/src/stores/interrogation.ts webapp/src/components/LiveDialoguePanel.vue webapp/src/components/TranscriptPanel.vue webapp/src/stores/interrogation.test.ts
git commit -m "feat: show transcript before speaker analysis"
```

## Task 9: Preserve Audio Through Backup and Restore

**Files:**
- Modify: `scripts/backup.sh`
- Modify: `scripts/restore.sh`
- Modify: `tests/release/test_backup_restore.py`
- Modify: `tests/release/test_restore_security.py`
- Create: `tests/release/shell_scripts.py`

- [x] **Step 1: Add archive exclusion and same-device restore tests**

Create a temporary data directory with SQLite, one audio file, and one unrelated mutable file. Assert a rolling archive contains the database and unrelated file but not `audio/`; after restore, assert the same audio file remains and its SHA-256 matches the database manifest. Assert a missing or mismatched audio hash is reported as incomplete. Retain existing traversal/symlink rejection assertions.

Run: `python -m pytest tests/release/test_backup_restore.py tests/release/test_restore_security.py -q`

Expected: FAIL because backup currently archives all non-database mutable files and restore deletes `audio/`.

- [x] **Step 2: Exclude only the evidence bytes from rolling snapshots**

Update `backup.sh` to exclude exactly `./audio` from the data tar and include a sorted audio manifest of relative paths, capture IDs, committed sample counts, and SHA-256 values in the snapshot metadata. Do not exclude other mutable data. Keep the current seven-snapshot database retention.

- [x] **Step 3: Preserve and verify audio during restore**

Update `restore.sh` to preserve `/var/lib/suspect-interrogation/audio` alongside the existing `backups` directory while replacing snapshot-managed data. Validate each manifest path stays under `audio/`, verify every referenced hash, and return a nonzero incomplete-restore result if any referenced evidence is absent or corrupted. Never remove audio as part of rolling snapshot rotation.

- [x] **Step 4: Verify backup/restore security and evidence preservation**

Run: `python -m pytest tests/release/test_backup_restore.py tests/release/test_restore_security.py -q`

Expected: PASS; snapshots do not duplicate audio bytes, and same-device restore preserves validated audio.

- [x] **Step 5: Commit backup behavior**

```text
git add scripts/backup.sh scripts/restore.sh tests/release/test_backup_restore.py tests/release/test_restore_security.py
git commit -m "feat: retain live audio outside rolling snapshots"
```

## Task 10: Enforce and Document Operations and Storage Limits

**Files:**
- Modify: `linux/backend/app/runtime_settings.py`
- Modify: `linux/backend/app/main.py`
- Modify: `linux/backend/app/services/live_speech_coordinator.py`
- Modify: `linux/backend/app/services/durable_audio_archive.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `linux/backend/app/repositories/audio_archive.py`
- Modify: `linux/backend/tests/test_durable_audio_archive.py`
- Modify: `linux/backend/tests/test_asr_capture_service.py`
- Modify: `docs/release/DEPLOYMENT.md`
- Modify: `docs/security/LINUX-HARDENING.md`

- [x] **Step 1: Enforce and document archive, recovery, and storage-reserve behavior**

Enforce the configurable free-space reserve (default 10 GB) before formal capture and before each new durable audio append. A reserve breach refuses a new capture or stops an active capture visibly as incomplete while preserving committed samples. Document `/var/lib/suspect-interrogation/audio/<case-id>/<capture-id>/`, `0750` directory/`0640` file permissions, 16 kHz mono PCM16, approximately 115 MB/hour, one-second checkpoints, ASR-before-speaker recovery order, no automatic audio purge, browser outbox recovery, and the limitation that off-device disaster recovery is not included.

- [x] **Step 2: Verify documentation matches scripts and code**

Run: `rg -n "audio/<case-id>/<capture-id>|115 MB|10 GB|off-device|checkpoint" docs/release/DEPLOYMENT.md docs/security/LINUX-HARDENING.md`

Expected: each operational value appears in both the deployment instructions and security storage policy, with no conflicting backup retention statement.

- [x] **Step 3: Commit operations documentation**

```text
git add docs/release/DEPLOYMENT.md docs/security/LINUX-HARDENING.md
git commit -m "docs: describe live audio retention and recovery"
```

## Task 11: Run Focused Verification and Deploy to `.109`

**Files:**
- No new code files; verify the previous tasks and deploy the exact branch commit.

- [ ] **Step 1: Run focused backend and release suites**

From repository root in PowerShell:

```powershell
$env:PYTHONPATH = 'linux/backend'
python -m pytest linux/backend/tests/test_database.py linux/backend/tests/test_durable_audio_archive.py linux/backend/tests/test_live_speech_coordinator.py linux/backend/tests/test_live_speaker_analysis.py linux/backend/tests/test_asr_capture_service.py linux/backend/tests/test_speech_worker_server.py linux/backend/tests/test_asr_api.py linux/backend/tests/test_interrogation_projection_service.py linux/backend/tests/test_qa_routing_coordinator.py linux/backend/tests/test_browser_audio_input.py linux/backend/tests/test_browser_asr_transport.py tests/release/test_backup_restore.py tests/release/test_restore_security.py -q
```

Expected: exit code `0`.

- [ ] **Step 2: Run frontend and full backend checks**

```powershell
npm --prefix webapp test
npm --prefix webapp run typecheck
$env:PYTHONPATH = 'linux/backend'
python -m pytest linux/backend/tests -q
```

Expected: all commands exit `0`. Preserve unrelated pre-existing CI failures as separate findings; do not weaken the new focused checks.

- [ ] **Step 3: Push the approved source revision**

Run `git status --short --branch`, then push the committed `linux-adaptation` branch. The local code baseline already matches `.109` at `835e9bce`; do not reset, force-push, or overwrite user changes. The push must trigger `RK3588 Production Redeploy` for that exact commit as required by `AGENTS.md`. Keep `.109` deployment and board behavior as the primary acceptance target; run the relevant CI gates without letting unrelated GitHub checks replace or delay production verification.

Expected: the deployed release marker on `.109` equals the pushed commit SHA.

- [ ] **Step 4: Verify `.109` without touching port 8000**

With the project LAN CA trusted, verify `https://192.168.2.109:18080/health/live` and `/health/ready` without disabling certificate verification. Verify browser audio uses WSS, release frontend/backend share one SHA, SQLite is at `0019_deferred_speaker_analysis`, and TCP/8000 is unchanged before/after deployment.

Expected: live/ready return HTTP 200, migration head matches, WSS is selected, and the existing port-8000 FunASR process remains untouched.

- [ ] **Step 5: Perform the board behavior acceptance**

With ASR model files restored on `.109` and voiceprint calibration complete, capture rapid police/suspect turns, stop/restart only the AI worker during capture, then confirm: audio checkpoints continue; ASR catches up without duplicate fragments; speaker analysis starts at 10 seconds plus 3 final fragments; split-turn child transcripts retain parent history; unresolved audio/roles show explicit gaps or review state. Do not use TCP/8000 for this feature's listener or restart it.

Expected: all user-visible behavior matches the architecture. If ASR model files or calibration are still absent, report deployment state separately and do not claim speech/role acceptance.

---

## Plan Self-Review

- **Spec coverage:** audio durability/checkpoints, ALSA and browser ingress, one-second recovery, Stage 1 ASR-only fragments, 10-second/3-fragment threshold, delayed turn split and re-ASR lineage, manual-role protection, downstream projection, backup/restore, 10 GB reserve, `.109` rollout, TLS/18080, and port-8000 preservation each have explicit tasks.
- **Placeholders:** each task names concrete files, tests, and expected outcomes; no implementation step is left as a placeholder.
- **Type/API consistency:** `ASRAudioSegment`, `LiveSpeechJob`, `ASRFragmentLineage`, `DurableAudioArchive`, and `LiveSpeechCoordinator` are defined in Task 1-3 before later tasks use them. `SUPERSEDED` is included in backend state and frontend types before UI handling.
- **Scope:** one end-to-end live pipeline redesign. MOSS, model-weight installation, and off-device disaster recovery remain out of scope. The board behavior task explicitly depends on restoring the model files and voiceprint calibration that are currently absent on `.109`. `.109` verification remains the primary deployment acceptance; the repository-required redeploy workflow is part of that chain.
