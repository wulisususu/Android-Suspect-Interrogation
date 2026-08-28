# Browser/ALSA Voiceprint Audio Source Design

Date: 2026-08-28
Branch: `linux-adaptation`
Status: proposed for implementation

## 1. Goal

Add a second voiceprint-enrollment capture path so a remote operator opening the RK3588 web UI can use the browser computer's microphone, while preserving the existing RK3588 ALSA microphone path for on-site use.

The product behavior is AUTO at the UI level:

1. At enrollment start, the browser first attempts `getUserMedia()` when the page is a secure context and microphone APIs are available.
2. If browser microphone acquisition succeeds, the enrollment uses the browser microphone for the entire capture.
3. If browser microphone acquisition fails before enrollment starts, the UI falls back to RK3588 ALSA capture and displays a prominent source warning.
4. An enrollment never mixes browser and ALSA PCM. A source is selected once and remains fixed until completion/cancel/restart.

This change applies to voiceprint enrollment only. Formal interrogation ASR capture remains RK3588 ALSA in this iteration.

## 2. Why this is needed

The current web page can be opened through a public tunnel from a different location, but the backend `AudioCaptureService` still reads the RK3588's local ALSA device. Clicking "开始录制" remotely therefore starts the microphone physically attached to the board, not the microphone on the remote computer.

The network tunnel is only transporting HTTP/WebSocket control traffic today; it is not transporting browser microphone PCM.

## 3. Chosen architecture

### 3.1 Browser capture

Create a focused browser audio module under `webapp/src/audio/`.

Responsibilities:

- request microphone access with `navigator.mediaDevices.getUserMedia({audio: ...})`;
- request mono capture with browser processing disabled where supported (`echoCancellation=false`, `noiseSuppression=false`, `autoGainControl=false`);
- convert browser float PCM to mono signed PCM16;
- resample the actual `AudioContext.sampleRate` to 16 kHz;
- send approximately 100-250 ms binary PCM chunks over a dedicated WebSocket;
- expose start/stop/dispose methods and capture-source diagnostics;
- never persist audio in browser storage.

`MediaRecorder`/Opus is intentionally not used because the backend voiceprint runtime already consumes PCM16 and should not gain a browser-codec/ffmpeg dependency.

### 3.2 Backend source-aware capture

Keep `AudioCaptureService` as the single enrollment buffer/VAD owner and add a capture source field:

- `ALSA`: existing collector thread calls `device_manager.start_record()` and reads audio frames;
- `BROWSER`: no ALSA device is opened; binary PCM is pushed into the active capture from the browser WebSocket.

Both sources feed the same internal path:

`PCM16 16 kHz -> buffer -> streaming FSMN-VAD -> usableSpeechMs -> 20s target -> final batch VAD -> XVector enrollment`.

The existing 20-second effective-speech threshold remains unchanged.

### 3.3 Capture identity

Every enrollment start creates a random `captureId` and returns it with the selected `source`.

The browser WebSocket uses:

`/ws/voiceprints/enrollment/{captureId}`

The backend accepts binary frames only if that `captureId` is the currently active BROWSER capture. Stale or mismatched capture IDs are rejected.

The browser stream is not allowed to push PCM to an ALSA capture.

### 3.4 Source selection

AUTO is orchestrated by the frontend because only the browser can know whether its microphone is usable.

For suspect and officer enrollment:

1. UI checks `window.isSecureContext`, `navigator.mediaDevices`, and `getUserMedia` support.
2. UI attempts to acquire the browser microphone before calling the enrollment start API.
3. If successful, REST start is sent with `source=BROWSER`, then the returned `captureId` is used to open the binary WebSocket and stream PCM.
4. If browser acquisition fails before REST start, REST start is sent with `source=ALSA`.
5. The selected source is displayed throughout recording.

There is no mid-capture automatic fallback. If a BROWSER stream disconnects, that capture is cancelled/invalidated and the user must restart. This prevents one XVector enrollment from mixing two acoustic channels.

## 4. API changes

### 4.1 Enrollment start

Suspect start and officer start bodies gain:

`source: "ALSA" | "BROWSER" = "ALSA"`

Response/status gains:

- `captureId`
- `source`
- `recordedDurationMs`
- `usableSpeechMs`
- `requiredUsableSpeechMs`
- `complete`
- `completeReason`

Backward compatibility is preserved because omitted `source` defaults to ALSA.

### 4.2 Enrollment status

`GET /api/v1/voiceprints/enrollment/status` remains the authoritative polling endpoint.

The frontend must stop overloading `capturedDurationMs` as effective-speech duration. It will explicitly consume:

- `recordedDurationMs`: total PCM actually received for the selected source;
- `usableSpeechMs`: streaming VAD effective-speech duration.

The progress bar is driven only by `usableSpeechMs / requiredUsableSpeechMs`.

### 4.3 Cancellation

Add an explicit cancel operation for capture cleanup without attempting XVector enrollment.

It is used when:

- browser WebSocket setup fails after REST start;
- browser microphone track ends unexpectedly;
- user changes page/case during a browser capture;
- browser stream disconnects before effective-speech completion.

Cancel clears the active capture and enrollment context and does not write a voiceprint.

## 5. Browser WebSocket behavior

The dedicated endpoint accepts binary frames only.

Server rules:

- active capture must exist;
- active capture source must be BROWSER;
- path `captureId` must match the active capture;
- each binary payload must be non-empty and bounded in size;
- received PCM length must be even (PCM16 sample alignment);
- buffer still obeys the existing five-minute safety ceiling;
- reaching effective speech >=20 seconds marks the capture complete exactly as ALSA does.

The WebSocket does not perform enrollment itself. Existing REST stop remains the transaction that runs final VAD/XVector and writes the database record. The existing frontend 500 ms status polling observes `complete=true`, closes browser capture, then calls stop.

## 6. UX

During recording show one of:

- `音源：本机浏览器麦克风（远程）`
- `音源：RK3588 开发板麦克风（现场）`

If AUTO fallback occurs, show a visible warning:

`浏览器麦克风不可用，已切换到开发板麦克风。远程电脑说话不会被采集。`

For browser capture, if the page is not a secure context, explain that browser microphone access generally requires HTTPS (or localhost) rather than silently implying the microphone is active.

Effective-speech UI remains:

`有效语音 X / 20 秒`

and may additionally display total received duration for diagnostics.

## 7. Security and privacy

- Audio bytes are streamed only for the currently active enrollment.
- No browser audio is stored in localStorage/IndexedDB.
- No raw voice audio is added to CI artifacts or application logs.
- `captureId` is random and scoped to one active enrollment.
- Only the enrollment WebSocket accepts binary voiceprint PCM; the normal interrogation WebSocket protocol remains unchanged.
- Capture IDs and PCM payloads must not be logged.
- Existing database storage continues to store the derived voiceprint data/metadata, not a new browser-audio artifact.

## 8. Failure behavior

- Browser permission denied before start -> fall back to ALSA and display source warning.
- Browser API unavailable/non-secure context -> fall back to ALSA and display reason.
- Browser WebSocket cannot connect after BROWSER REST start -> cancel BROWSER capture; do not silently switch source inside the same enrollment.
- Browser microphone track ends -> cancel current BROWSER capture and require restart.
- Network interruption during BROWSER capture -> cancel/expire current capture; no partial XVector is written.
- RK3588 VAD/speech runtime unavailable -> return the existing runtime error; do not fall back to client-side VAD.
- ALSA selected -> existing behavior remains unchanged.

## 9. Testing

TDD coverage will include:

### Backend

- BROWSER start does not call `device_manager.start_record()`;
- ALSA start still does;
- browser PCM push is rejected for the wrong captureId/source;
- browser PCM enters the same streaming VAD accumulator;
- 20 seconds effective speech marks BROWSER capture complete;
- cancel releases BROWSER capture without enrollment;
- status distinguishes total recorded duration from effective speech;
- legacy start without `source` still selects ALSA.

### Frontend

- browser PCM resampling/PCM16 conversion unit tests;
- AUTO selects BROWSER when microphone acquisition succeeds;
- AUTO falls back to ALSA before enrollment start when browser mic is unavailable;
- source label/warning is rendered;
- browser stream cleanup happens before REST stop/enrollment;
- browser disconnect does not silently continue using ALSA.

### Release / RK3588

- hosted Python/Vue/typecheck/build/screenshot/E2E gates remain green;
- RK3588 ALSA enrollment path remains green;
- production deployment confirms new endpoints and frontend bundle;
- browser-transport integration is exercised with deterministic PCM without saving raw audio artifacts.

## 10. Acceptance criteria

The change is complete when:

1. A remote HTTPS browser can grant microphone permission and `usableSpeechMs` increases when the person speaks into the remote computer microphone.
2. Reaching 20 seconds effective speech automatically stops and completes enrollment through the existing final VAD/XVector flow.
3. On-site operation can still enroll using the RK3588 ALSA microphone without browser microphone support.
4. The UI always makes the selected source explicit.
5. One enrollment never mixes BROWSER and ALSA audio.
6. All hosted gates pass and the updated frontend/backend are deployed to the RK3588 production service on port 18080.
