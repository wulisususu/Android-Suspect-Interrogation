import { ref } from 'vue'
import { backendErrorMessage } from '../api/interrogation'
import {
  cancelBrowserAwareVoiceprintEnrollment,
  fetchBrowserAwareVoiceprintStatus,
  startBrowserAwareOfficerEnrollment,
  startBrowserAwareSuspectEnrollment,
  stopBrowserAwareOfficerEnrollment,
  stopBrowserAwareSuspectEnrollment,
  type VoiceprintAudioSource,
} from '../api/browserVoiceprint'
import {
  browserVoiceprintCapability,
  type BrowserVoiceprintCapture,
} from '../audio/browserVoiceprintCapture'
import { selectAutoVoiceprintSource } from '../audio/voiceprintSourceSelection'
import { useInterrogationStore } from '../stores/interrogation'

const DEFAULT_REQUIRED_USABLE_MS = 20_000

type ActiveKind = 'SUSPECT' | 'OFFICER'

export function useAutoVoiceprintEnrollment() {
  const store = useInterrogationStore()
  const initialCapability = browserVoiceprintCapability()
  const source = ref<VoiceprintAudioSource | null>(null)
  const reason = ref(initialCapability.available
    ? 'AUTO 模式：优先使用当前电脑浏览器麦克风；仅在开始前无法获取时回退 RK3588 开发板麦克风。'
    : `${initialCapability.reason}；开始录制时将使用 RK3588 开发板麦克风（现场）。`)
  const browserAvailable = ref(initialCapability.available)
  const secureContext = ref(typeof window !== 'undefined' && window.isSecureContext)

  let browserCapture: BrowserVoiceprintCapture | null = null
  let activeCaptureId: string | null = null
  let activeKind: ActiveKind | null = null
  let activeSubjectId: string | null = null
  let activeOfficerName: string | null = null
  let progressTimer: ReturnType<typeof setInterval> | undefined
  let finalizing = false
  /**
   * Monotonic enrollment attempt counter. Every start attempt and every cancel
   * increments it; a transport callback can only act on the attempt that
   * registered it. Without this, a delayed close callback from a finished
   * attempt can overwrite the phase of the attempt that is running now.
   */
  let attemptId = 0
  /**
   * True while an attempt is being finalized or has finished. A transport
   * callback that arrives now must NOT start an error path: the backend can
   * register the voiceprint successfully and close the browser audio channel in
   * the same millisecond, and that close callback used to flip 'COMPLETE' into
   * 'ERROR' (the "registered but reported as failed" race).
   */
  let settling = false
  /**
   * Attempt id whose server-side cancel request is still in flight, or null.
   * While a cancellation is being applied no new recording may start, otherwise
   * the late cancel response would race a freshly started capture.
   */
  let cancellingFor: number | null = null

  function beginAttempt(): number {
    attemptId += 1
    settling = false
    cancellingFor = null
    return attemptId
  }

  function isCurrentAttempt(attempt: number) {
    return attempt === attemptId
  }

  function clearProgressTimer() {
    if (progressTimer) clearInterval(progressTimer)
    progressTimer = undefined
  }

  function clearActive() {
    // Whoever clears the active attempt ends it: any callback or awaited cancel
    // continuation still carrying this attempt id is stale from now on.
    attemptId += 1
    settling = true
    clearProgressTimer()
    activeCaptureId = null
    activeKind = null
    activeSubjectId = null
    activeOfficerName = null
    finalizing = false
  }

  /**
   * Stop and forget the active browser capture. When `expected` is given, only
   * that capture is closed and only if it is still the active one, so a stale
   * cancellation can never tear down a newer round's audio channel.
   */
  async function closeBrowserCapture(expected?: BrowserVoiceprintCapture | null) {
    if (expected && browserCapture !== expected) return
    const capture = browserCapture
    browserCapture = null
    if (capture) await capture.stop().catch(() => undefined)
  }

  async function abortCurrent(message: string, from?: BrowserVoiceprintCapture) {
    // A callback carrying a capture that is no longer the active one comes from
    // a round that already ended: it must not touch the current round's state.
    if (from && browserCapture !== from) return
    const captureId = activeCaptureId
    if (!captureId) return
    // A callback from a finalized attempt is not a failure. Once stopSuspect()
    // or stopOfficer() has committed the attempt to the backend's HTTP enroll
    // path, no transport event may start the cancel/ERROR path: the backend
    // closes the browser channel itself while audio capture is being torn down.
    if (settling) return
    // The previous attempt's cancellation is still being applied on the server.
    // Starting a competing error path here would cancel the wrong enrollment.
    if (cancellingFor !== null) return
    // Pinning the attempt and its capture means this call can only ever act on
    // the round it belongs to, even after the HTTP cancel below. If a newer
    // round starts meanwhile, that round bumps the attempt id and this stale
    // cancellation writes nothing.
    const attempt = beginAttempt()
    const capture = browserCapture
    clearProgressTimer()
    activeCaptureId = null
    const kind = activeKind
    const subjectId = activeSubjectId
    const officerName = activeOfficerName
    activeKind = null
    activeSubjectId = null
    activeOfficerName = null
    store.voiceprintBusy = true
    cancellingFor = attempt
    let stillCurrent = false
    try {
      // Cancel path: stop sending PCM, then let the server cancel the capture and
      // finally close the channel. Finalizing before the HTTP cancel keeps the
      // transport silent while the cancel request is in flight. It runs inside
      // the guarded region so a transport that refuses to finalize still
      // releases voiceprintBusy instead of locking every record button.
      capture?.beginFinalize()
      await cancelBrowserAwareVoiceprintEnrollment(captureId).catch(() => undefined)
      stillCurrent = isCurrentAttempt(attempt)
      if (stillCurrent) await closeBrowserCapture(capture)
    } catch {
      // The transport could not be finalized (or the cancel threw): the failure
      // path below still has to run so the state converges.
    } finally {
      // A newer attempt may have started while the cancel request was in
      // flight; its state belongs to that attempt, not to this message.
      if (isCurrentAttempt(attempt)) {
        cancellingFor = null
        if (stillCurrent) {
          finalizing = false
          store.voiceprintEnrollmentState = {
            phase: 'ERROR',
            kind,
            subjectId,
            officerName,
            message,
          }
          store.feedback(message, true)
        }
        store.voiceprintBusy = false
      }
    }
  }

  async function refreshProgress() {
    if (!activeCaptureId || finalizing) return
    try {
      const status = await fetchBrowserAwareVoiceprintStatus()
      if (!activeCaptureId || status.captureId !== activeCaptureId || !status.active) return
      const usableMs = Math.max(0, Number(status.usableSpeechMs ?? status.capturedDurationMs ?? 0))
      const requiredMs = Math.max(1, Number(status.requiredUsableSpeechMs ?? status.targetDurationMs ?? DEFAULT_REQUIRED_USABLE_MS))
      store.voiceprintEnrollmentState = {
        ...store.voiceprintEnrollmentState,
        phase: 'RECORDING',
        capturedDurationMs: usableMs,
        targetDurationMs: requiredMs,
        captureComplete: Boolean(status.complete),
      }
      if (!status.complete) return
      if (activeKind === 'SUSPECT') await stopSuspect()
      else if (activeKind === 'OFFICER' && activeSubjectId) await stopOfficer(activeSubjectId)
    } catch (error) {
      await abortCurrent(`声纹录制状态读取失败：${backendErrorMessage(error)}`)
    }
  }

  function startProgressPolling() {
    clearProgressTimer()
    void refreshProgress()
    progressTimer = setInterval(() => { void refreshProgress() }, 500)
  }

  async function attachBrowserStream(capture: BrowserVoiceprintCapture, captureId: string) {
    browserCapture = capture
    const owner = capture
    try {
      await capture.start(captureId, {
        // Transport callbacks belong to this capture object. A replay or a late
        // delivery from a previous round is therefore no longer mistaken for a
        // failure of the round that is recording now.
        onError: (message) => { void abortCurrent(message, owner) },
        onTrackEnded: () => { void abortCurrent('当前电脑麦克风已断开，请重新开始声纹录制', owner) },
      })
    } catch (error) {
      await cancelBrowserAwareVoiceprintEnrollment(captureId).catch(() => undefined)
      await closeBrowserCapture(capture)
      throw error
    }
  }

  async function startSuspect(actorId?: string) {
    // A new attempt must not start while the previous attempt's cancellation is
    // still being applied on the server: that cancellation would then race the
    // new capture id and could cancel the wrong enrollment.
    if (store.voiceprintBusy || activeCaptureId || cancellingFor !== null) return
    const caseId = store.caseId
    const attempt = beginAttempt()
    store.voiceprintBusy = true
    try {
      const selected = await selectAutoVoiceprintSource()
      source.value = selected.source
      reason.value = selected.source === 'BROWSER'
        ? '当前音源：本机浏览器麦克风（远程）。音频经 16 kHz PCM/WSS 发送到 RK3588。'
        : selected.reason
      browserAvailable.value = selected.source === 'BROWSER'
      store.voiceprintEnrollmentState = {
        phase: 'RECORDING',
        kind: 'SUSPECT',
        subjectId: caseId,
        message: selected.source === 'BROWSER' ? '正在使用本机浏览器麦克风录制嫌疑人声纹' : '正在使用 RK3588 开发板麦克风录制嫌疑人声纹',
      }
      const result = await startBrowserAwareSuspectEnrollment(caseId, selected.source, actorId)
      const captureId = String(result.captureId || '')
      if (!captureId) throw new Error('后端未返回声纹 captureId')
      activeCaptureId = captureId
      activeKind = 'SUSPECT'
      activeSubjectId = caseId
      if (selected.source === 'BROWSER' && selected.browserCapture) {
        await attachBrowserStream(selected.browserCapture, captureId)
      }
      startProgressPolling()
    } catch (error) {
      const message = backendErrorMessage(error)
      if (activeCaptureId) await cancelBrowserAwareVoiceprintEnrollment(activeCaptureId).catch(() => undefined)
      await closeBrowserCapture()
      if (!isCurrentAttempt(attempt)) return
      clearActive()
      store.voiceprintEnrollmentState = { phase: 'ERROR', kind: 'SUSPECT', subjectId: caseId, message }
      store.feedback(message, true)
    } finally {
      store.voiceprintBusy = false
    }
  }

  async function stopSuspect(actorId?: string) {
    if (finalizing || activeKind !== 'SUSPECT' || !activeSubjectId) return
    const caseId = activeSubjectId
    const attempt = attemptId
    // Pin the transport this attempt owns BEFORE the first await, so the HTTP
    // stop/enroll below can never touch a different round's audio channel.
    const capture = browserCapture
    // Stop accepting transport failures for this attempt: the channel close the
    // backend performs during the HTTP stop is the normal end of the recording.
    settling = true
    finalizing = true
    store.voiceprintBusy = true
    clearProgressTimer()
    // Finalize the transport FIRST, then let the backend register the
    // voiceprint over HTTP. Closing the browser channel before the HTTP stop
    // makes the backend's WebSocket handler take its cancel path and throw the
    // enrollment away; the backend closes the channel itself while the HTTP
    // stop is running, which the finalized transport now treats as normal.
    store.voiceprintEnrollmentState = { ...store.voiceprintEnrollmentState, phase: 'PROCESSING' }
    try {
      // Inside the guarded region: a transport that cannot leave STREAMING must
      // still release voiceprintBusy in the finally block below, otherwise the
      // record buttons stay disabled forever.
      capture?.beginFinalize()
      const result = await stopBrowserAwareSuspectEnrollment(caseId, actorId)
      if (!isCurrentAttempt(attempt)) return
      await store.refreshVoiceprintState()
      if (!isCurrentAttempt(attempt)) return
      clearActive()
      store.voiceprintEnrollmentState = {
        phase: 'COMPLETE',
        kind: 'SUSPECT',
        subjectId: caseId,
        usableDurationMs: Number(result.usableDurationMs ?? 0),
        simulated: Boolean(result.simulated),
        message: result.simulated ? '浏览器开发模拟完成；未形成真实声纹验证' : '嫌疑人声纹已注册',
      }
      store.feedback(store.voiceprintEnrollmentState.message || '嫌疑人声纹已注册')
    } catch (error) {
      const message = backendErrorMessage(error)
      if (!isCurrentAttempt(attempt)) return
      clearActive()
      store.voiceprintEnrollmentState = { phase: 'ERROR', kind: 'SUSPECT', subjectId: caseId, message }
      store.feedback(message, true)
    } finally {
      // The transport is released on every exit path — success, failure, a
      // rejected state refresh (the readiness/officer round trip can time out
      // long before the 120 s HTTP stop does) and an early stale-attempt return.
      // Leaving it open keeps the microphone hot and pins activeCaptureId, so a
      // retry would open a second getUserMedia channel. The close keeps its
      // place after the HTTP stop and the state refresh: the backend closes the
      // channel itself during the stop, and the finalized transport treats that
      // as the normal end of the recording.
      await closeBrowserCapture(capture)
      if (isCurrentAttempt(attempt)) finalizing = false
      store.voiceprintBusy = false
    }
  }

  async function startOfficer(officerId: string, officerName: string, actorId?: string) {
    if (store.voiceprintBusy || activeCaptureId || cancellingFor !== null) return
    const attempt = beginAttempt()
    store.voiceprintBusy = true
    try {
      const selected = await selectAutoVoiceprintSource()
      source.value = selected.source
      reason.value = selected.source === 'BROWSER'
        ? '当前音源：本机浏览器麦克风（远程）。音频经 16 kHz PCM/WSS 发送到 RK3588。'
        : selected.reason
      browserAvailable.value = selected.source === 'BROWSER'
      store.voiceprintEnrollmentState = {
        phase: 'RECORDING',
        kind: 'OFFICER',
        subjectId: officerId,
        officerName,
        message: selected.source === 'BROWSER' ? '正在使用本机浏览器麦克风录制民警声纹' : '正在使用 RK3588 开发板麦克风录制民警声纹',
      }
      const result = await startBrowserAwareOfficerEnrollment(officerId, officerName, selected.source, actorId)
      const captureId = String(result.captureId || '')
      if (!captureId) throw new Error('后端未返回声纹 captureId')
      activeCaptureId = captureId
      activeKind = 'OFFICER'
      activeSubjectId = officerId
      activeOfficerName = officerName
      if (selected.source === 'BROWSER' && selected.browserCapture) {
        await attachBrowserStream(selected.browserCapture, captureId)
      }
      startProgressPolling()
    } catch (error) {
      const message = backendErrorMessage(error)
      if (activeCaptureId) await cancelBrowserAwareVoiceprintEnrollment(activeCaptureId).catch(() => undefined)
      await closeBrowserCapture()
      if (!isCurrentAttempt(attempt)) return
      clearActive()
      store.voiceprintEnrollmentState = { phase: 'ERROR', kind: 'OFFICER', subjectId: officerId, officerName, message }
      store.feedback(message, true)
    } finally {
      store.voiceprintBusy = false
    }
  }

  async function stopOfficer(officerId: string, actorId?: string) {
    if (finalizing || activeKind !== 'OFFICER' || activeSubjectId !== officerId) return
    const officerName = activeOfficerName
    const attempt = attemptId
    // Pin the transport this attempt owns BEFORE the first await.
    const capture = browserCapture
    settling = true
    finalizing = true
    store.voiceprintBusy = true
    clearProgressTimer()
    // Same ordering contract as stopSuspect(): finalize the browser transport
    // before the HTTP stop, never after it.
    store.voiceprintEnrollmentState = { ...store.voiceprintEnrollmentState, phase: 'PROCESSING' }
    try {
      // Guarded like stopSuspect(): a throwing finalize still releases the
      // busy flag in the finally block.
      capture?.beginFinalize()
      const result = await stopBrowserAwareOfficerEnrollment(officerId, actorId)
      if (!isCurrentAttempt(attempt)) return
      await store.refreshVoiceprintState()
      if (!isCurrentAttempt(attempt)) return
      clearActive()
      store.voiceprintEnrollmentState = {
        phase: 'COMPLETE',
        kind: 'OFFICER',
        subjectId: officerId,
        officerName: String(result.officerName ?? officerName ?? ''),
        usableDurationMs: Number(result.usableDurationMs ?? 0),
        simulated: Boolean(result.simulated),
        message: result.simulated ? '浏览器开发模拟完成；未形成真实民警声纹' : '民警声纹已保存',
      }
      store.feedback(store.voiceprintEnrollmentState.message || '民警声纹已保存')
    } catch (error) {
      const message = backendErrorMessage(error)
      if (!isCurrentAttempt(attempt)) return
      clearActive()
      store.voiceprintEnrollmentState = { phase: 'ERROR', kind: 'OFFICER', subjectId: officerId, officerName, message }
      store.feedback(message, true)
    } finally {
      // Every exit path releases the transport, exactly as in stopSuspect().
      await closeBrowserCapture(capture)
      if (isCurrentAttempt(attempt)) finalizing = false
      store.voiceprintBusy = false
    }
  }

  async function dispose() {
    clearProgressTimer()
    const captureId = activeCaptureId
    clearActive()
    // Teardown path: stop producing PCM and keep the transport silent while the
    // cancel request runs; stop() below is what actually closes the channel.
    browserCapture?.beginFinalize()
    if (captureId) await cancelBrowserAwareVoiceprintEnrollment(captureId).catch(() => undefined)
    await closeBrowserCapture()
  }

  return {
    source,
    reason,
    browserAvailable,
    secureContext,
    startSuspect,
    stopSuspect,
    startOfficer,
    stopOfficer,
    dispose,
  }
}
