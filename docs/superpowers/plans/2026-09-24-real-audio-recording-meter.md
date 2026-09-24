# Real Audio Recording Meter Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** Show a waveform measured from actual PCM for both browser and ALSA capture, and make the recording button display the real active capture duration.

**Architecture:** Measure PCM in the shared backend capture loop and publish throttled `AUDIO_LEVEL` events containing only audio metrics and capture identity. Preserve a bounded set of matching samples in the frontend capture state; render them under the capture button. Return the persisted capture start time in active status so the existing wall-clock timer can advance.

**Tech Stack:** Python, FastAPI service layer, SQLAlchemy, Vue 3, Pinia, TypeScript, pytest, Vitest.

---

## Files and responsibilities

- `linux/backend/app/services/asr_capture_service.py`: active status timestamp, PCM metric calculation, and throttled event emission from the shared ALSA/browser ingress loop.
- `linux/backend/tests/test_asr_capture_service.py`: real PCM metric payload, event throttling, and active start-time regression coverage using existing fake device/database fixtures.
- `webapp/src/types/interrogation.ts`: frontend audio-meter sample and client capture-state fields.
- `webapp/src/stores/interrogation.ts`: session-scoped event reduction, bounded history, new-session reset, and elapsed timer state.
- `webapp/src/stores/interrogation.test.ts`: event filtering, silence, bounded history, and actual timer progression coverage.
- `webapp/src/components/LiveDialoguePanel.vue`: compact, non-animated waveform below the recording button, with waiting/stale states.
- `webapp/src/components/LiveDialoguePanel.audioMeter.test.ts`: server-rendered checks for measured bar heights, waiting/stale states, stop visibility, and the displayed duration.

Run backend pytest commands with `linux/backend` as the working directory so its `app` package resolves. Run frontend commands from `webapp`.

## Task 1: Publish measurements from received PCM

**Files:**
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Test: `linux/backend/tests/test_asr_capture_service.py`

- [x] **Step 1: Add failing tests for actual PCM metrics and the event cap**

Append a metrics test that builds the existing fake runtime and calls the new private measurement publisher with three signed PCM16 samples. Assert the emitted event is sent to the runtime's interrogation session and contains the case/capture IDs, sample count, sample rate, RMS, and peak. Use samples `(0, 3000, -4000)` and assert `sampleCount == 3`, `peak == 4000`, and `rms` is approximately `2886.75`. Also test the cap by calling the publisher with two-sample PCM buffers at `now=1.0`, `now=1.05`, and `now=1.1`; only two events should be emitted and the second event's cumulative `sampleCount` should be 6.

```python
def test_audio_level_event_reports_metrics_from_pcm16(tmp_path: Path):
    _engine, factory, case_id, session_id = _seed_database(tmp_path)
    events = EventCollector()
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=FakeDeviceManager([]),
        ai_supervisor=FakeSpeechSupervisor(),
        publish_event=events,
    )
    runtime = capture_module._CaptureRuntime(
        case_id=case_id,
        interrogation_session_id=session_id,
        capture_session_id="capture-meter",
        speech_session_id="speech-meter",
        speaker_threshold=0.7,
        speaker_margin=0.1,
        threshold_source="TEST",
        calibration_id=None,
        calibration_status="TEST",
        speaker_model_fingerprint=None,
        microphone_fingerprint=None,
    )

    service._publish_audio_level(runtime, struct.pack("<hhh", 0, 3000, -4000), now=1.0)

    assert len(events.events) == 1
    event_session, event_name, payload = events.events[0]
    assert event_session == session_id
    assert event_name == "AUDIO_LEVEL"
    assert payload["caseId"] == case_id
    assert payload["captureSessionId"] == "capture-meter"
    assert payload["sampleCount"] == 3
    assert payload["sampleRate"] == 16_000
    assert payload["peak"] == 4000
    assert payload["rms"] == pytest.approx(2886.75, abs=0.01)
```

Add the throttle test before production code as well:

```python
def test_audio_level_event_is_throttled_and_counts_suppressed_pcm(tmp_path: Path):
    _engine, factory, case_id, session_id = _seed_database(tmp_path)
    events = EventCollector()
    service = AsrCaptureService(
        session_factory=factory,
        device_manager=FakeDeviceManager([]),
        ai_supervisor=FakeSpeechSupervisor(),
        publish_event=events,
    )
    runtime = capture_module._CaptureRuntime(
        case_id=case_id,
        interrogation_session_id=session_id,
        capture_session_id="capture-throttle",
        speech_session_id="speech-throttle",
        speaker_threshold=0.7,
        speaker_margin=0.1,
        threshold_source="TEST",
        calibration_id=None,
        calibration_status="TEST",
        speaker_model_fingerprint=None,
        microphone_fingerprint=None,
    )
    pcm = struct.pack("<hh", 1000, -1000)

    service._publish_audio_level(runtime, pcm, now=1.0)
    service._publish_audio_level(runtime, pcm, now=1.05)
    service._publish_audio_level(runtime, pcm, now=1.1)

    assert len(events.events) == 2
    assert events.events[-1][2]["sampleCount"] == 6
```

- [x] **Step 2: Run both new tests and confirm they fail for the missing publisher**

Run from `linux/backend`: `python -m pytest tests/test_asr_capture_service.py -k 'audio_level_event_reports_metrics_from_pcm16 or audio_level_event_is_throttled' -q`  
Expected: FAIL because `_publish_audio_level` does not exist.

- [x] **Step 3: Add the minimal PCM16 meter and throttle state**

Add a 100 ms publish interval. Add `audio_level_sample_count: int = 0` and `last_audio_level_published_at: float | None = None` to `_CaptureRuntime`. Implement the publisher so it counts complete PCM16 samples on every call, suppresses events less than 100 ms after the previous event, computes RMS and peak from the current complete samples only when it emits, and skips empty/odd trailing bytes. Emit:

```python
{
    "caseId": runtime.case_id,
    "captureSessionId": runtime.capture_session_id,
    "sampleCount": runtime.audio_level_sample_count,
    "sampleRate": runtime.sample_rate,
    "rms": rms,
    "peak": peak,
}
```

Call the publisher on actual non-empty PCM reads in `_capture_loop`, before forwarding the same bytes into durable archive/ASR. Never synthesize samples or retain PCM in meter state.

- [x] **Step 4: Run backend meter tests**

Run from `linux/backend`: `python -m pytest tests/test_asr_capture_service.py -q`  
Expected: all tests pass, including real sample metrics and the 10 Hz cap.

## Task 2: Return the start time while capture is active

**Files:**
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Test: `linux/backend/tests/test_asr_capture_service.py`

- [x] **Step 1: Add a failing assertion to the existing capture-start test**

In `test_capture_pushes_each_pcm_chunk_once_persists_verified_fragment_and_broadcasts`, assert that `started["startedAt"]` is a non-empty ISO timestamp before waiting for the fake device to exhaust.

```python
assert isinstance(started["startedAt"], str)
assert started["startedAt"]
```

- [x] **Step 2: Run the capture-start test and confirm the missing-field failure**

Run from `linux/backend`: `python -m pytest tests/test_asr_capture_service.py::test_capture_pushes_each_pcm_chunk_once_persists_verified_fragment_and_broadcasts -q`  
Expected: FAIL because the active status has no `startedAt`.

- [x] **Step 3: Add the persisted timestamp to active status**

Add `startedAt` to the active workflow status and to `initial_workflow_status` in `start()`, using `capture.started_at.isoformat()` when present. Keep the field name and ISO format aligned with the existing stopped status response.

- [x] **Step 4: Re-run the capture-start test**

Run from `linux/backend`: `python -m pytest tests/test_asr_capture_service.py::test_capture_pushes_each_pcm_chunk_once_persists_verified_fragment_and_broadcasts -q`  
Expected: PASS and active and stopped responses both contain the persisted start time.

## Task 3: Reduce audio events into bounded, session-scoped frontend state

**Files:**
- Modify: `webapp/src/types/interrogation.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Test: `webapp/src/stores/interrogation.test.ts`

- [x] **Step 1: Add failing reducer, bounded-history, and elapsed-time tests**

Set the store to `case-1`, send a running `RECORDING_STATE` for `capture-1`, then send one nonzero `AUDIO_LEVEL`, one zero-level `AUDIO_LEVEL`, and one event for `capture-old`. Assert the first two values are retained in order, zero is retained as true silence, and the mismatched event is ignored. Also add tests that send 85 matching events and expect exactly 80 samples, and set fake system time to `10000` before applying a running capture status with `startedAt: 8000`; elapsed time must be at least 2000 ms and advance after another 1000 ms. Give the status `caseId`, `captureSessionId`, `running`, `startedAt`, `sampleRate`, `partialText`, and `fragments: []` so the existing reducer accepts it.

```typescript
store.applyCaptureEvent({ event: 'RECORDING_STATE', payload: {
  caseId: 'case-1', captureSessionId: 'capture-1', running: true,
  startedAt: 8000, sampleRate: 16000, partialText: '', fragments: [],
} })
store.applyCaptureEvent({ event: 'AUDIO_LEVEL', payload: {
  caseId: 'case-1', captureSessionId: 'capture-1', sampleCount: 160, sampleRate: 16000, rms: 12, peak: 40,
} })
store.applyCaptureEvent({ event: 'AUDIO_LEVEL', payload: {
  caseId: 'case-1', captureSessionId: 'capture-1', sampleCount: 320, sampleRate: 16000, rms: 0, peak: 0,
} })
```

- [x] **Step 2: Run the reducer test and confirm it fails**

Run from `webapp`: `npm test -- src/stores/interrogation.test.ts`  
Expected: FAIL because `AUDIO_LEVEL` is not reduced into capture state and elapsed time is not driven by the active status start time.

- [x] **Step 3: Add the meter sample type and reducer behavior**

Add a typed sample with `sampleCount`, `sampleRate`, `rms`, and `peak`; add an optional bounded `audioLevels` array and `audioLevelUpdatedAt` timestamp to `AsrCaptureStatus`. In `applyCaptureEvent`, accept `AUDIO_LEVEL` only when both `caseId` and `captureSessionId` match current capture state. Append a copy of the measured values, keep only the latest 80, and record `Date.now()` for signal freshness. In `applyCaptureStatus`, preserve those client-only fields only for the same capture ID and clear them when a new capture starts. Include `AUDIO_LEVEL` in the runtime event dispatch list.

- [x] **Step 4: Run frontend reducer tests**

Run from `webapp`: `npm test -- src/stores/interrogation.test.ts`  
Expected: PASS for scope filtering, silence, bounded history, reset, and elapsed time.

## Task 4: Render a real waveform below the recording button

**Files:**
- Modify: `webapp/src/components/LiveDialoguePanel.vue`
- Test: `webapp/src/components/LiveDialoguePanel.audioMeter.test.ts`

- [x] **Step 1: Group the recording control and meter in the header**

Keep the current BOT and recording behavior. Place the button and a compact waveform in a dedicated wrapper so the waveform sits directly below the button without changing the dialogue-feed layout.

```vue
<div class="capture-control">
  <button class="capture-toggle" ...>
    <span class="record-dot"></span>
    {{ captureRunning ? `停止录音 ${elapsed}` : '开始录音' }}
  </button>
  <div v-if="captureRunning" class="capture-meter" role="img" aria-label="实时麦克风输入波形">
    <!-- One bar per received AUDIO_LEVEL sample; no animation or generated values. -->
  </div>
</div>
```

- [x] **Step 2: Render only received sample amplitudes and signal state**

Map the last 48 measured samples to bar heights using their normalized `peak` (full-scale PCM16 is 32768). Render zero values at a 2 px baseline. Before the first sample show “等待音频输入”; when the most recent sample is older than 1500 ms, compute staleness from `Date.now() - audioLevelUpdatedAt` and read `props.captureElapsedMs` in the computed expression so the existing 500 ms capture-clock updates re-evaluate it; then show “暂无新音频信号” and freeze the bars. Hide the meter when capture is stopped. Do not add CSS animation, random values, timers that alter bars, or prerecorded data.

- [x] **Step 3: Run frontend checks**

Run from `webapp`: `npm run typecheck`  
Expected: PASS with the new capture state and Vue bindings.

Run from `webapp`: `npm test`  
Expected: all frontend tests pass.

## Task 5: Verify the integrated backend and frontend behavior

- [x] **Step 1: Run targeted backend tests**

Run from `linux/backend`: `python -m pytest tests/test_asr_capture_service.py -q`  
Expected: PASS, including existing capture persistence and the new meter/time coverage.

- [x] **Step 2: Run frontend typecheck and full test suite**

Run from `webapp`: `npm run typecheck` and `npm test`  
Expected: both pass.

- [x] **Step 3: Review the final diff**

Run: `git diff --check` and inspect `git diff -- linux/backend/app/services/asr_capture_service.py linux/backend/tests/test_asr_capture_service.py webapp/src/types/interrogation.ts webapp/src/stores/interrogation.ts webapp/src/stores/interrogation.test.ts webapp/src/components/LiveDialoguePanel.vue`. Confirm changes are limited to the approved specification and no captured PCM bytes are added to events or frontend state.

## Self-review against the approved specification

- Shared capture loop measurement covers ALSA and browser sources; only received PCM contributes to events and visible bars.
- Silence is retained as zero amplitude; stale input stops updating and has an explicit UI state; stopped capture hides the meter.
- The meter sends only numeric metrics, is rate-limited to 10 Hz, and the browser retains at most 80 samples.
- Active status returns the persisted `startedAt`; elapsed duration remains wall-clock based and is independent of speech energy.
- New capture IDs clear old meter history; case and capture IDs gate each event.
- Durable archive, ASR, and speaker-analysis ordering are not changed.
