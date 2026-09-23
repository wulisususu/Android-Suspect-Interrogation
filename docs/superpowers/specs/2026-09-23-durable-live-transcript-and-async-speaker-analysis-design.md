# Durable Live Transcript and Asynchronous Speaker Analysis

Date: 2026-09-23  
Branch: `linux-adaptation`  
Status: Initial architecture approved; turn-segmentation detail updated and awaiting review

## 1. Goal

Make the live interrogation path preserve the audio and recognized text independently of ASR and voiceprint model lifetimes. A model restart, slow inference, or unavailable voiceprint must not silently discard already captured speech or prevent the transcript from being saved.

The production target is the RK3588 at `192.168.2.109`. The deployed source revision and local `linux-adaptation` checkout are currently aligned at `835e9bce`.

## 2. Scope

This design changes the live capture, transcription, and speaker-attribution path:

- Persist the normalized audio received by the live ASR path as long-term case evidence.
- Persist finalized ASR fragments with timestamps before role attribution is available.
- Run voiceprint analysis asynchronously after a defined amount of transcript/audio has accumulated.
- Recover queued ASR and speaker work after worker restarts, without duplicate transcript fragments.
- Keep manually corrected speaker assignments authoritative.

The long-audio MOSS transcription flow is separate and is not used as the live capture or voiceprint worker. Enrollment policy and voiceprint model calibration remain separate concerns. This design does not promise perfect word recognition in overlapping speech or severe noise; it ensures that the received audio remains available for recovery and review.

## 3. Existing Behavior and Failure Surface

The current `AsrCaptureService` reads audio and calls the speech worker synchronously from its capture loop. The worker keeps active speech-session state in memory. `ASR_PARTIAL` is only published as a live preview; only `ASR_FINAL` creates a database fragment. Speaker inference is coupled to finalized speech processing, and capture startup currently requires an enrolled suspect voiceprint.

The browser input path is also transient: `BrowserAudioInput` uses a bounded in-memory queue, and the WebSocket closes on queue overflow. The browser sender does not have a durable acknowledgement/replay contract. Consequently, an audio/model service interruption can end a capture or leave already-sent audio unavailable for recovery. The `.109` deployment had no AI-worker restart since the latest deployment, so historical restart logs do not prove that restarts caused prior missing speech; the in-memory-only recovery boundary is confirmed by the code.

## 4. Considered Approaches

1. **Only make voiceprint inference asynchronous.** This reduces model coupling but still loses audio when capture or ASR stops before a final fragment is committed. Not sufficient.
2. **Store audio as SQLite BLOBs.** This gives transactional metadata but grows and locks the live application database with large binary writes; every database backup would also copy the audio. Not recommended.
3. **Store an append-only audio archive in files, with a durable database manifest and independent work queues.** This keeps audio out of the SQLite hot path, allows recovery/replay, and makes retention explicit. Recommended.

## 5. Architecture

```text
ALSA capture / browser audio
             │
             ▼
Durable audio ingress ─────► case audio archive + ordered manifest
             │                              │
             ▼                              ├──► ASR replay queue (priority)
     live preview only                      │        │
                                            │        ▼
                                            │   durable ASR fragments
                                            │   speaker = UNKNOWN initially
                                            │        │
                                            └──► voiceprint queue (async)
                                                     │
                                                     ▼
                                           role results/backfill
                                           UNKNOWN → police/suspect
```

### 5.1 Durable audio ingress

- The recorder writes the exact normalized PCM stream used by the live ASR path: 16 kHz, mono, PCM16. It records sample offsets, capture-relative times, sequence, format, and SHA-256 in a manifest. Audio files live under `/var/lib/suspect-interrogation/audio`, not in the release tree or SQLite BLOBs.
- Store one-minute WAV segments under `/var/lib/suspect-interrogation/audio/<case-id>/<capture-id>/`, with service-owned `0750` directories and `0640` files. Persist/checkpoint the active segment at least once per second; ASR consumes each newly durable range without waiting for the one-minute file to close. Finalized files are immutable and carry a SHA-256. Recovery validates the last checkpoint, repairs the WAV header, and salvages only complete PCM frames; any invalid/missing range is explicitly marked as an audio gap.
- The database manifest is the durable index and job ledger. Audio-file creation and manifest updates must be idempotent and reconciled at startup, so a crash between file and database operations does not silently hide or duplicate a segment.
- The capture writer does not call ASR or voiceprint inference. Inference backlog therefore cannot block writing. If durable storage fails or the reserved free-space threshold is reached, mark the capture incomplete, stop it visibly, and preserve all successfully committed audio; do not report the session as complete.
- For browser audio, each frame needs a monotonically increasing sequence/sample offset and a server acknowledgement only after durable write. The browser keeps only unacknowledged frames in a bounded IndexedDB buffer, replays them after reconnect, and deletes each frame after acknowledgement. A gap or exhausted client buffer is reported as an explicit discontinuity. ALSA and browser input both feed the same archive/manifest contract over the existing HTTPS/WSS origin.

At the current PCM format, audio consumes about **115 MB per hour**. The latest read-only check on `.109` showed 63 GB available under `/var/lib/suspect-interrogation` and restrictive `0750` ownership by the service account. Refuse a new capture below a 10 GB free-space reserve and stop an active capture visibly if it reaches that reserve. The implementation must check actual free space before starting and during capture; this estimate does not account for other future case data.

### 5.2 First workflow: transcript capture

- Stage 1 ASR uses VAD boundaries only; it does not call speaker embedding or speaker-turn splitting. ASR consumes ordered durable audio ranges continuously and has priority over voiceprint work. Advance its recovery cursor only after all final fragments for a range commit; after worker restart, replay from the last committed boundary with a small overlap and deduplicate by capture/time range. This recovers an utterance that was still in memory when the worker stopped.
- `ASR_FINAL` is persisted immediately as the canonical text fragment with its capture-relative start/end times. Until the second workflow resolves identity, store `speaker=UNKNOWN` and an explicit pending-analysis source/state. `ASR_PARTIAL` remains a provisional UI preview and does not replace the durable final fragment.
- A replay result is idempotent by capture and time range. If the same range is reprocessed with the same model revision, update/reconcile that range rather than append a duplicate. A deliberate model/version change creates a transcript revision with provenance; it must not overwrite a user's edited text.
- Starting live capture no longer depends on suspect voiceprint enrollment. Missing models, unavailable workers, and unrecognized speech are visible in session status; archived audio remains available for later processing.

### 5.3 Second workflow: voiceprint and role mapping

- Store pending speaker-analysis jobs independently from ASR jobs. They consume the archived audio and finalized transcript time ranges; they never hold the recorder or Stage 1 ASR capture loop open.
- Start the first analysis batch when both conditions are met: **at least 10 seconds of VAD-detected voiced audio and at least 3 finalized transcript fragments**. This gives the model more than a single short utterance. If capture stops first, schedule analysis for available material at stop.
- On first activation, analyze earlier unresolved audio ranges as well as current ones. Thereafter enqueue new finalized ranges continuously. First run anonymous speaker-turn segmentation, then match each stable turn against the voiceprints enabled for the active interrogation session. Speech too short for the existing speaker policy, overlap, missing enrollment, low confidence, or ambiguous matching stays `UNKNOWN` for manual review.
- If one Stage 1 VAD fragment contains multiple stable turns, re-run ASR on each turn range and append a transcript revision with parent/child lineage. Keep the original text and audio reference in history. Replace the active pending fragment with the child fragments only if all required turn transcripts succeed and the parent has not been manually edited or confirmed; otherwise leave the original visible as `UNKNOWN` and expose the split result for review.
- Role results update a fragment only when its speaker source is still automatic/pending. A manual assignment is never overwritten. Persist score, threshold/calibration snapshot, model version, and decision provenance as today.
- Voiceprint-worker failure or restart leaves the ASR text and audio intact. Its durable queue retries; a terminal or ambiguous result is visible as requiring review rather than changing transcript text.

### 5.4 Downstream projection and user-visible state

The transcript timeline displays finalized text as soon as Stage 1 saves it, labeled “说话人待识别” until Stage 2 returns. Superseded parent fragments remain available in revision history but are not duplicated in the active dialogue timeline. The capture/session status exposes recording, ASR backlog, speaker-analysis progress, and incomplete/error states independently.

When a speaker changes from `UNKNOWN` to a resolved police/suspect role, emit an idempotent role-resolution event and re-run downstream interrogation projection for that fragment if it has not been formally confirmed or manually edited. This is necessary because the existing projection treats unknown speakers as raw-only. Formal transcript confirmation continues to require an accepted speaker role. Existing manual speaker edits and confirmed records remain authoritative.

## 6. Persistence, Recovery, and Backup

The schema will add a durable audio-range manifest and persistent work states/cursors for ASR and speaker analysis. Audio bytes stay under `/var/lib/suspect-interrogation/audio`; transcript text, role results, audio hashes, and job states stay in SQLite. Unique capture/range/job keys prevent replay duplicates.

After service startup, recovery scans active/incomplete captures, validates archive files against the manifest, marks gaps explicitly, and resumes pending ASR before low-priority speaker analysis. The current `.109` backup script snapshots all mutable data into each rolling archive. To avoid multiplying permanent audio across all seven snapshots, update backup/restore so rolling archives include the audio manifest and hashes but exclude the audio bytes; same-device restore preserves `/var/lib/suspect-interrogation/audio` and verifies every referenced file. Database snapshot rotation must not automatically delete long-term case audio. If a referenced audio file is missing, restore reports the affected capture as incomplete rather than claiming the evidence was restored. Off-device disaster recovery is outside this design.

Long-term audio is stored with service-only access under `/var/lib/suspect-interrogation`. No automatic audio purge is introduced. If remaining space is below the 10 GB reserve, prevent a new recording from starting; if an active recording reaches the reserve, stop it visibly and preserve all successfully committed audio. Device/drive failure and off-device disaster recovery are outside this design; the guarantee is recovery from model/service-worker interruption while the storage remains available.

## 7. Deployment and Compatibility

- Treat `.109` as the production target and source of truth for deployment behavior. Keep local code aligned with the deployed `linux-adaptation` baseline before implementation.
- Preserve the existing HTTPS origin on port `18080`; TCP/`8000` belongs to the independent FunASR service and must not be bound, stopped, or restarted.
- Preserve existing ASR fragments and voiceprint/manual-confirmation APIs. New fragments default to pending identity; old fragments retain their current roles and confirmation states.
- The older `2026-08-27-funasr-voiceprint-speech-pipeline-design.md` specifies coupled ASR/speaker inference and mandatory enrollment before capture. This document supersedes those requirements for live capture only; the existing enrollment/calibration policies remain in force for deciding a role.
- The current `.109` health report says ASR model files are absent and voiceprint calibration is incomplete. Real recognition/role acceptance on the board requires those runtime assets and calibration to be restored; this design does not install or replace model weights.

## 8. Acceptance Criteria

- A live capture can start without a suspect voiceprint and persists audio independently of AI-worker availability.
- Restarting the ASR worker during capture resumes unprocessed audio, persists recognized fragments without duplicates, and reports any missing audio ranges explicitly.
- Rapid turn-taking remains archived and is transcribed in time order even when inference temporarily falls behind; any input/audio gap is visible. When Stage 2 finds multiple stable speakers inside one VAD fragment, successful per-turn ASR replaces the active pending fragment while preserving the original in revision history; uncertain splits remain reviewable without losing text.
- Final transcript text appears before role analysis completes and remains available if voiceprint analysis fails.
- Voiceprint analysis starts after 10 seconds of voiced audio plus 3 final fragments, backfills earlier unresolved fragments, and continues for later fragments. Short sessions schedule a final available analysis at stop.
- Automatic results do not overwrite manual speaker edits; role resolution safely retries downstream projection for previously unknown fragments.
- Permanent evidence is linked to the capture, has a verifiable hash/manifest, survives ordinary release deployment, and is not deleted by rolling database-backup retention.
- On `.109`, storage checks reflect the 115 MB/hour estimate and preserve the existing port-8000 FunASR service.
