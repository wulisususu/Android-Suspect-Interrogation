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

  function clearProgressTimer() {
    if (progressTimer) clearInterval(progressTimer)
    progressTimer = undefined
  }

  function clearActive() {
    clearProgressTimer()
    activeCaptureId = null
    activeKind = null
    activeSubjectId = null
    activeOfficerName = null
  }

  async function closeBrowserCapture() {
    const capture = browserCapture
    browserCapture = null
    if (capture) await capture.stop().catch(() => undefined)
  }

  async function abortCurrent(message: string) {
    const captureId = activeCaptureId
    if (!captureId) return
    clearProgressTimer()
    activeCaptureId = null
    const kind = activeKind
    const subjectId = activeSubjectId
    const officerName = activeOfficerName
    activeKind = null
    activeSubjectId = null
    activeOfficerName = null
    store.voiceprintBusy = true
    try {
      await cancelBrowserAwareVoiceprintEnrollment(captureId).catch(() => undefined)
      await closeBrowserCapture()
    } finally {
      store.voiceprintEnrollmentState = {
        phase: 'ERROR',
        kind,
        subjectId,
        officerName,
        message,
      }
      store.feedback(message, true)
      store.voiceprintBusy = false
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
    try {
      await capture.start(captureId, {
        onError: (message) => { void abortCurrent(message) },
        onTrackEnded: () => { void abortCurrent('当前电脑麦克风已断开，请重新开始声纹录制') },
      })
    } catch (error) {
      await cancelBrowserAwareVoiceprintEnrollment(captureId).catch(() => undefined)
      await closeBrowserCapture()
      throw error
    }
  }

  async function startSuspect(actorId?: string) {
    if (store.voiceprintBusy || activeCaptureId) return
    const caseId = store.caseId
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
    finalizing = true
    store.voiceprintBusy = true
    clearProgressTimer()
    browserCapture?.pause()
    store.voiceprintEnrollmentState = { ...store.voiceprintEnrollmentState, phase: 'PROCESSING' }
    try {
      const result = await stopBrowserAwareSuspectEnrollment(caseId, actorId)
      await closeBrowserCapture()
      clearActive()
      await store.refreshVoiceprintState()
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
      await closeBrowserCapture()
      clearActive()
      store.voiceprintEnrollmentState = { phase: 'ERROR', kind: 'SUSPECT', subjectId: caseId, message }
      store.feedback(message, true)
    } finally {
      finalizing = false
      store.voiceprintBusy = false
    }
  }

  async function startOfficer(officerId: string, officerName: string, actorId?: string) {
    if (store.voiceprintBusy || activeCaptureId) return
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
    finalizing = true
    store.voiceprintBusy = true
    clearProgressTimer()
    browserCapture?.pause()
    store.voiceprintEnrollmentState = { ...store.voiceprintEnrollmentState, phase: 'PROCESSING' }
    try {
      const result = await stopBrowserAwareOfficerEnrollment(officerId, actorId)
      await closeBrowserCapture()
      clearActive()
      await store.refreshVoiceprintState()
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
      await closeBrowserCapture()
      clearActive()
      store.voiceprintEnrollmentState = { phase: 'ERROR', kind: 'OFFICER', subjectId: officerId, officerName, message }
      store.feedback(message, true)
    } finally {
      finalizing = false
      store.voiceprintBusy = false
    }
  }

  async function dispose() {
    clearProgressTimer()
    const captureId = activeCaptureId
    clearActive()
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
