# ASR Continuous Transcript Capture Design

## Goal

Add a microphone control to the realtime interrogation transcript panel. A capture session continuously records microphone audio and displays ASR partial text, but only endpoint final results become persistent temporary fragments. Temporary fragments can be edited and confirmed individually while recording, or confirmed in a batch later. Only confirmation creates formal interrogation records.

The design must preserve a clean path to future speaker diarization without changing the current ASR model-management or single-active-model rules.

## User Experience

- Add a microphone icon button before the transcript composer textarea.
- The button is enabled only while the interrogation session is `RUNNING` and the Android NativeBridge is available.
- Starting capture uses the ASR model currently selected in ModelManager. No second recognizer is created.
- While recording, the button changes to a red stop control and a compact elapsed-time indicator is shown.
- The current ASR partial result appears in a dedicated live strip above the composer. Partial text is never inserted into Room and is never added to the formal transcript.
- Every ASR endpoint appends one temporary fragment to a review area in the transcript panel.
- Each temporary fragment shows its time range, editable text, speaker selector, confidence state, confirmation state, and audio availability.
- Speaker choices are `待定`, `民警`, and `嫌疑人`. New fragments default to `待定` until diarization or a person assigns a speaker.
- A fragment with known confidence below `0.55` receives a prominent low-confidence warning. Missing model probabilities are shown as `置信度不可用`, not as a synthetic score.
- A user can edit and confirm a fragment while recording continues.
- Batch confirmation confirms all selected fragments that have non-empty edited text and a non-unknown speaker. Invalid fragments remain temporary and receive an inline reason.
- Stopping capture ends only the ASR/audio capture session. It does not confirm, delete, or otherwise mutate pending fragments.
- Pending fragments survive closing and reopening the page or restarting the app.

## Architecture

### Native capture ownership

`AsrController` remains the sole owner of the active `AsrEngine`. A new `AsrCaptureSessionManager` coordinates capture metadata, audio writing, and temporary-fragment persistence. Model settings and the diagnostic ASR console continue to use the existing controller; attempting to start a second capture returns the existing running state rather than loading another model.

The audio engine sends each normalized microphone batch to an audio sink in addition to sending it to sherpa-onnx. This is an in-process callback on the existing recording thread and does not create a second `AudioRecord`.

### Continuous audio file

Each capture session writes one continuous 16 kHz, mono, PCM16 WAV file under the app-private directory:

`files/asr-audio/<case-id>/<capture-session-id>/capture.wav`

The writer creates a placeholder WAV header and appends the original `ShortArray` microphone samples. It refreshes the WAV data length after every endpoint and finalizes it on stop, allowing already-confirmed fragments to retain a stable logical reference while recording continues.

Fragments do not duplicate or slice audio. Their audio reference contains a logical capture-session ID plus `audioStartOffsetMs` and `audioEndOffsetMs`. Absolute filesystem paths are never sent to the WebView.

If audio writing fails or usable storage drops below 256 MB, capture stops with an explicit error. Existing finalized audio and temporary fragments remain available.

### Temporary persistence

Add two Room entities and migrate the encrypted database from version 1 to version 2:

`AsrCaptureSessionEntity`

- `id`
- `caseId`
- `interrogationSessionId`
- `modelId`, `modelName`, `provider`, `sherpaVersion`
- `sampleRate`
- `audioRelativePath`
- `startedAt`, `endedAt`
- `state`: `RECORDING`, `STOPPED`, or `FAILED`
- `error`

`AsrTemporaryFragmentEntity`

- `id`, `captureSessionId`, `caseId`, `ordinal`
- `startedAtMs`, `endedAtMs`
- `audioStartOffsetMs`, `audioEndOffsetMs`
- `rawText` (immutable ASR output)
- `editedText` (human-editable working text)
- `speaker`: `UNKNOWN`, `OFFICER`, or `SUSPECT`
- `speakerSource`: `UNASSIGNED`, `MANUAL`, or later `DIARIZATION`
- `confidence` nullable
- `confidenceSource`: `SHERPA_TOKEN_LOG_PROBS` or `UNAVAILABLE`
- `state`: `PENDING`, `CONFIRMED`, or `DISCARDED`
- `confirmedQaId` nullable
- `createdAt`, `updatedAt`, `confirmedAt`

Partial results exist only in `AsrRuntimeStatus` and NativeBridge events. They are never represented by a database entity.

### Confidence

The sherpa Kotlin result exposes per-token `ysProbs`, which are log probabilities. For a non-empty finite array, fragment confidence is the geometric mean:

`confidence = exp(mean(ysProbs))`, clamped to `[0, 1]`.

If `ysProbs` is empty, contains no finite values, or the active model does not expose it, confidence is `null`. The `0.55` warning threshold is a UI policy, not a claim that sherpa provides calibrated sentence probabilities.

### Confirmation and formal records

Confirmation is a native transaction:

1. Reload the pending fragment.
2. Require non-empty `editedText` and a non-unknown speaker.
3. Require the interrogation session to permit formal recording.
4. Create one `qa_records` entry through `RecordService` using `民警` or `嫌疑人`.
5. Mark the temporary fragment `CONFIRMED`, set `confirmedQaId`, and append an audit event containing fragment ID, capture-session ID, confidence, time range, and audio offsets.

The raw ASR text remains immutable. Later edits to a formal record continue using the existing revision history. Confirm is idempotent: repeating it returns the previously linked formal record and does not create a duplicate.

Batch confirmation processes selected fragments in chronological order. Each fragment uses its own transaction so one invalid fragment does not roll back valid confirmations. The response reports confirmed records and per-fragment failures.

## NativeBridge Contract

Add these actions while preserving existing `asr.status`, `asr.start`, and `asr.stop` for diagnostics:

- `asr.capture.status { caseId }`
- `asr.capture.start { caseId }`
- `asr.capture.stop { caseId }`
- `asr.fragment.list { caseId, includeConfirmed }`
- `asr.fragment.update { fragmentId, editedText, speaker }`
- `asr.fragment.confirm { fragmentId }`
- `asr.fragment.confirmBatch { fragmentIds }`
- `asr.fragment.discard { fragmentId }`

The existing `asr.status` event is extended with capture-session metadata and the newly created or updated fragment list. Events are serialized through the current NativeBridge event mechanism.

## Future Speaker Diarization

Speaker diarization will consume the continuous session WAV and return labeled time ranges. A later merger can overlap those ranges with each fragment's audio offsets and update only `speaker` plus `speakerSource=DIARIZATION` for pending fragments. Manual speaker assignments take precedence and are never overwritten automatically.

Adjacent pending fragments may later be merged or split without changing the audio file because every fragment is anchored to the same session timeline. Confirmed formal records remain immutable except through the existing audited revision flow.

## Error Handling

- Microphone permission denial leaves the capture stopped and does not create a capture session.
- ASR initialization failure marks a newly created session `FAILED` and retains the error for display.
- Audio write failure stops recognition and marks the capture `FAILED`; completed temporary fragments are retained.
- Page navigation does not implicitly confirm fragments. Activity destruction stops/finalizes active capture.
- Model switching while capture is running first stops and finalizes the active capture, then releases the recognizer.
- Formal confirmation failures remain visible on their fragment and can be retried.

## Testing

- Unit-test confidence calculation, including empty, non-finite, and low-confidence probabilities.
- Unit-test temporary-fragment state transitions and immutable raw text.
- Unit-test idempotent single confirmation and ordered partial-success batch confirmation.
- Unit-test that partial updates do not call a DAO.
- Unit-test model switching and capture stop finalize the current writer before engine release.
- Test the Room 1-to-2 migration and preservation of existing cases, sessions, and QA records.
- Typecheck and production-build the WebView UI.
- Run Android unit tests and build an arm64 APK.
- On RK3576, verify continuous capture, endpoint fragment creation, edge confirmation while still recording, batch confirmation, stop-with-pending-fragments, app restart recovery, Zipformer NPU load, Paraformer CPU routing, and audio-reference playback/range alignment.

## Out of Scope

- Speaker diarization inference and automatic identity assignment.
- Word-level timestamps for Paraformer.
- Cloud ASR, Python, Termux, or HTTP services.
- Automatic confirmation based on confidence.
- Destructive deletion of confirmed audio evidence.
