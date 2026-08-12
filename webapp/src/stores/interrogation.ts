import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import {
  backendErrorMessage,
  changeSessionStage,
  confirmAsrFragment,
  confirmAsrFragmentBatch,
  createCase,
  discardAsrFragment,
  fetchAsrCaptureStatus,
  fetchCase,
  fetchCaseAiAnalyses,
  fetchFacts,
  fetchMessages,
  fetchRevisions,
  fetchSessionState,
  fetchTimeline,
  finishSession as finishSessionApi,
  generateCaseAiAnalysis,
  markTranscriptMessage,
  pauseSession as pauseSessionApi,
  persistQuestionOrAnswer,
  resumeSession as resumeSessionApi,
  startAsrCapture,
  startSession as startSessionApi,
  stopAsrCapture,
  streamInquiry,
  updateAsrFragment,
  updateTranscriptMessage,
} from '../api/interrogation'
import { isNativeBusinessRuntime, onNativeEvent } from '../native/rpcBridge'
import type {
  AsrCaptureStatus,
  CaseAiAnalysis,
  CaseSummary,
  FactItem,
  InterrogationStage,
  RecordRevision,
  SessionState,
  TemporaryAsrSpeaker,
  TimelineEvent,
  TranscriptMessage,
} from '../types/interrogation'

const uid = () => `${Date.now()}-${Math.random().toString(16).slice(2)}`
const stageOrder: InterrogationStage[] = ['IDENTITY', 'STATEMENT', 'FOLLOW_UP', 'SIGNING']

const stateTextMap: Record<string, string> = {
  DRAFT: '草稿',
  IDENTITY_VERIFYING: '身份核验中',
  READY: '待开始',
  INTERROGATING: '审讯中',
  REVIEWING: '复核中',
  SIGNING: '签名中',
  COMPLETED: '已完成',
  ARCHIVED: '已归档',
}

const stageTextMap: Record<InterrogationStage, string> = {
  IDENTITY: '身份核验',
  STATEMENT: '案情陈述',
  FOLLOW_UP: '重点追问',
  SIGNING: '确认签名',
}

export const useInterrogationStore = defineStore('interrogation', () => {
  const params = new URLSearchParams(location.search)
  const caseId = ref(params.get('caseId') || '')
  const loading = ref(true)
  const streaming = ref(false)
  const error = ref('')
  const actionMessage = ref('')
  const actionError = ref('')
  const revisions = ref<RecordRevision[]>([])
  const revisionsOpen = ref(false)
  const nativeCaptureAvailable = isNativeBusinessRuntime()
  const captureBusy = ref(false)
  const captureClock = ref(Date.now())
  const selectedFragmentIds = ref<string[]>([])
  const capture = ref<AsrCaptureStatus>({
    caseId: caseId.value,
    captureSessionId: null,
    running: false,
    startedAt: null,
    endedAt: null,
    sampleRate: 16_000,
    partialText: '',
    fragments: [],
    error: null,
  })
  let feedbackTimer: ReturnType<typeof setTimeout> | undefined
  let captureTimer: ReturnType<typeof setInterval> | undefined
  let removeCaptureListener: (() => void) | undefined

  const caseSummary = ref<CaseSummary>({
    id: caseId.value,
    suspectName: '待录入',
    gender: '',
    age: '',
    officerName: '当前警官',
    state: 'DRAFT',
    stage: 'IDENTITY',
  })
  const session = ref<SessionState>({
    id: null,
    caseId: caseId.value,
    status: 'READY',
    stage: 'IDENTITY',
    startedAt: null,
    pausedAt: null,
    endedAt: null,
    updatedAt: Date.now(),
  })
  const transcript = ref<TranscriptMessage[]>([])
  const timeline = ref<TimelineEvent[]>([])
  const facts = ref<FactItem[]>([])
  const caseAiAnalyses = ref<CaseAiAnalysis[]>([])
  const caseAiBusy = ref(false)
  const caseAiError = ref('')

  const completion = computed(() => {
    if (!facts.value.length) return 0
    const done = facts.value.filter((item) => item.status === 'confirmed').length
    return Math.round((done / facts.value.length) * 100)
  })
  const stateText = computed(() => stateTextMap[caseSummary.value.state] || caseSummary.value.state)
  const stageText = computed(() => stageTextMap[session.value.stage])
  const canRecord = computed(() => session.value.status === 'RUNNING')
  const captureElapsedMs = computed(() => capture.value.running && capture.value.startedAt
    ? Math.max(0, captureClock.value - capture.value.startedAt)
    : 0)

  function applyCaptureStatus(status: AsrCaptureStatus) {
    if (status.caseId && status.caseId !== caseId.value) return
    capture.value = status
    const visibleIds = new Set(status.fragments.map((fragment) => fragment.id))
    selectedFragmentIds.value = selectedFragmentIds.value.filter((id) => visibleIds.has(id))
    if (status.running && !captureTimer) {
      captureTimer = setInterval(() => { captureClock.value = Date.now() }, 500)
    } else if (!status.running && captureTimer) {
      clearInterval(captureTimer)
      captureTimer = undefined
    }
  }

  function initializeCaptureEvents() {
    if (!nativeCaptureAvailable || removeCaptureListener) return
    removeCaptureListener = onNativeEvent<AsrCaptureStatus>('asr.capture.status', applyCaptureStatus)
  }

  function feedback(message: string, isError = false) {
    if (feedbackTimer) clearTimeout(feedbackTimer)
    if (isError) {
      actionError.value = message
      actionMessage.value = ''
    } else {
      actionMessage.value = message
      actionError.value = ''
    }
    feedbackTimer = setTimeout(() => {
      actionMessage.value = ''
      actionError.value = ''
    }, isError ? 5000 : 3000)
  }

  async function ensureCurrentCase() {
    if (!caseId.value) {
      const created = await createCase({ officerName: '当前警官' })
      caseId.value = created.id
      const next = new URL(location.href)
      next.searchParams.set('caseId', created.id)
      history.replaceState(null, '', next)
      return created
    }

    return fetchCase(caseId.value)
  }

  async function initialize() {
    loading.value = true
    error.value = ''
    try {
      caseSummary.value = await ensureCurrentCase()
      initializeCaptureEvents()
      const [messages, factItems, timelineItems, sessionState, captureStatus, analyses] = await Promise.all([
        fetchMessages(caseId.value),
        fetchFacts(caseId.value),
        fetchTimeline(caseId.value),
        fetchSessionState(caseId.value),
        nativeCaptureAvailable ? fetchAsrCaptureStatus(caseId.value) : Promise.resolve(null),
        fetchCaseAiAnalyses(caseId.value),
      ])
      transcript.value = messages
      facts.value = factItems
      timeline.value = timelineItems
      session.value = sessionState
      if (captureStatus) applyCaptureStatus(captureStatus)
      caseAiAnalyses.value = analyses
    } catch (err) {
      error.value = backendErrorMessage(err)
      feedback(`后端初始化失败：${error.value}`, true)
    } finally {
      loading.value = false
    }
  }

  function mergeConfirmedRecord(record: TranscriptMessage) {
    const index = transcript.value.findIndex((item) => item.id === record.id)
    if (index >= 0) transcript.value[index] = record
    else transcript.value.push(record)
    transcript.value.sort((left, right) => (left.seq || Number.MAX_SAFE_INTEGER) - (right.seq || Number.MAX_SAFE_INTEGER))
  }

  async function startCapture() {
    if (!nativeCaptureAvailable) return feedback('连续离线录音仅在 Android APK 中可用', true)
    if (!canRecord.value) return feedback('请先开始审讯再录音', true)
    if (captureBusy.value || capture.value.running) return
    captureBusy.value = true
    try {
      applyCaptureStatus(await startAsrCapture(caseId.value))
      feedback('连续录音已开始，识别结果将先进入临时片段')
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    } finally {
      captureBusy.value = false
    }
  }

  async function stopCapture(showFeedback = true) {
    if (!nativeCaptureAvailable || captureBusy.value || !capture.value.running) return
    captureBusy.value = true
    try {
      applyCaptureStatus(await stopAsrCapture(caseId.value))
      if (showFeedback) feedback('录音已停止，待确认片段仍保留')
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    } finally {
      captureBusy.value = false
    }
  }

  async function updatePendingFragment(fragmentId: string, editedText: string, speaker: TemporaryAsrSpeaker) {
    try {
      const updated = await updateAsrFragment(caseId.value, fragmentId, editedText, speaker)
      const index = capture.value.fragments.findIndex((item) => item.id === fragmentId)
      if (index >= 0) capture.value.fragments[index] = updated
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function confirmPendingFragment(fragmentId: string) {
    try {
      const result = await confirmAsrFragment(caseId.value, fragmentId)
      mergeConfirmedRecord(result.record)
      capture.value.fragments = capture.value.fragments.filter((fragment) => fragment.id !== fragmentId)
      selectedFragmentIds.value = selectedFragmentIds.value.filter((id) => id !== fragmentId)
      feedback(`片段已确认并保存为第 ${result.record.seq} 条正式记录`)
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function confirmSelectedFragments() {
    if (!selectedFragmentIds.value.length) return
    try {
      const result = await confirmAsrFragmentBatch(caseId.value, selectedFragmentIds.value)
      result.confirmed.forEach((item) => mergeConfirmedRecord(item.record))
      const confirmedIds = new Set(result.confirmed.map((item) => item.fragment.id))
      capture.value.fragments = capture.value.fragments.filter((fragment) => !confirmedIds.has(fragment.id))
      selectedFragmentIds.value = result.failures.map((item) => item.fragmentId)
      if (result.failures.length) {
        feedback(`已确认 ${result.confirmed.length} 条，${result.failures.length} 条需补充说话人或文本`, true)
      } else {
        feedback(`已确认并入库 ${result.confirmed.length} 条片段`)
      }
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function discardPendingFragment(fragmentId: string) {
    try {
      await discardAsrFragment(caseId.value, fragmentId)
      capture.value.fragments = capture.value.fragments.filter((fragment) => fragment.id !== fragmentId)
      selectedFragmentIds.value = selectedFragmentIds.value.filter((id) => id !== fragmentId)
      feedback('临时片段已丢弃')
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  function toggleFragmentSelection(fragmentId: string) {
    selectedFragmentIds.value = selectedFragmentIds.value.includes(fragmentId)
      ? selectedFragmentIds.value.filter((id) => id !== fragmentId)
      : [...selectedFragmentIds.value, fragmentId]
  }

  function disposeCaptureEvents() {
    removeCaptureListener?.()
    removeCaptureListener = undefined
    if (captureTimer) clearInterval(captureTimer)
    captureTimer = undefined
  }

  async function refreshCase() {
    caseSummary.value = await fetchCase(caseId.value)
  }

  async function ask(text: string) {
    const clean = text.trim()
    if (!clean || streaming.value) return
    if (!canRecord.value) {
      feedback(session.value.status === 'PAUSED' ? '审讯已暂停，请先恢复' : '请先点击“开始审讯”', true)
      return
    }

    error.value = ''
    actionError.value = ''
    try {
      const persisted = await persistQuestionOrAnswer(caseId.value, clean, '民警')
      transcript.value.push(persisted)
      feedback(`Q${persisted.seq || transcript.value.length} 已保存`)
    } catch (err) {
      feedback(backendErrorMessage(err), true)
      return
    }

    const aiMessage: TranscriptMessage = { id: uid(), speaker: 'AI', text: '', streaming: true }
    transcript.value.push(aiMessage)
    streaming.value = true
    try {
      await streamInquiry(caseId.value, clean, (payload) => {
        if (payload.code) {
          error.value = payload.message || `AI 上游返回错误 ${payload.code}`
          return
        }
        if (payload.text_chunk) aiMessage.text += payload.text_chunk
      })
    } catch (err) {
      error.value = backendErrorMessage(err)
    } finally {
      aiMessage.streaming = false
      streaming.value = false
    }
  }

  async function generateCaseAnalysis() {
    if (caseAiBusy.value) return
    caseAiBusy.value = true
    caseAiError.value = ''
    try {
      const analysis = await generateCaseAiAnalysis(caseId.value)
      caseAiAnalyses.value = [analysis, ...caseAiAnalyses.value.filter((item) => item.id !== analysis.id)]
      feedback('本案 AI 推理已生成并保存到当前案件')
    } catch (err) {
      caseAiError.value = backendErrorMessage(err)
      feedback(caseAiError.value, true)
    } finally {
      caseAiBusy.value = false
    }
  }

  async function editMessage(messageId: string, text: string) {
    try {
      const updated = await updateTranscriptMessage(caseId.value, messageId, text)
      const index = transcript.value.findIndex((item) => item.id === messageId)
      if (index >= 0) transcript.value[index] = updated
      feedback(`Q/A ${updated.seq || ''} 已修订，旧内容已进入版本历史`)
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function markMessage(messageId: string) {
    try {
      const updated = await markTranscriptMessage(caseId.value, messageId, 'conflict')
      const index = transcript.value.findIndex((item) => item.id === messageId)
      if (index >= 0) transcript.value[index] = updated
      feedback('已标记为“存在矛盾”，后端审计日志已记录')
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function markLatestConflict() {
    const target = [...transcript.value].reverse().find((item) => item.speaker !== 'AI')
    if (!target) return feedback('当前没有可标记的正式问答', true)
    await markMessage(target.id)
  }

  async function openRevisions(messageId?: string) {
    try {
      revisions.value = await fetchRevisions(caseId.value, messageId)
      revisionsOpen.value = true
      feedback(revisions.value.length ? `已读取 ${revisions.value.length} 条版本记录` : '当前暂无修订历史')
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  function closeRevisions() {
    revisionsOpen.value = false
  }

  async function startSession() {
    try {
      session.value = await startSessionApi(caseId.value)
      await refreshCase()
      feedback('审讯已开始：录入问答和 AI SSE 主链路已解锁')
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function togglePause() {
    try {
      if (session.value.status === 'RUNNING') {
        if (capture.value.running) await stopCapture(false)
        session.value = await pauseSessionApi(caseId.value)
        feedback('审讯已暂停，新的正式问答将被后端拒绝')
      } else if (session.value.status === 'PAUSED') {
        session.value = await resumeSessionApi(caseId.value)
        feedback('审讯已恢复')
      }
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function finishSession() {
    try {
      if (capture.value.running) await stopCapture(false)
      session.value = await finishSessionApi(caseId.value)
      await refreshCase()
      feedback('本次审讯已结束并进入复核状态')
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function nextStage() {
    const index = stageOrder.indexOf(session.value.stage)
    if (index < 0 || index >= stageOrder.length - 1) return feedback('当前已经是最后的“确认签名”阶段', true)
    try {
      session.value = await changeSessionStage(caseId.value, stageOrder[index + 1])
      await refreshCase()
      feedback(`已进入：${stageTextMap[session.value.stage]}`)
    } catch (err) {
      feedback(backendErrorMessage(err), true)
    }
  }

  async function useSuggestion(text: string) {
    feedback('已采用事实核对中的追问建议')
    await ask(text)
  }

  return {
    caseId,
    loading,
    caseSummary,
    session,
    transcript,
    timeline,
    facts,
    caseAiAnalyses,
    caseAiBusy,
    caseAiError,
    completion,
    stateText,
    stageText,
    canRecord,
    streaming,
    error,
    actionMessage,
    actionError,
    revisions,
    revisionsOpen,
    nativeCaptureAvailable,
    capture,
    captureBusy,
    captureElapsedMs,
    selectedFragmentIds,
    initialize,
    ask,
    generateCaseAnalysis,
    editMessage,
    markMessage,
    markLatestConflict,
    openRevisions,
    closeRevisions,
    startSession,
    togglePause,
    finishSession,
    nextStage,
    useSuggestion,
    startCapture,
    stopCapture,
    updatePendingFragment,
    confirmPendingFragment,
    confirmSelectedFragments,
    discardPendingFragment,
    toggleFragmentSelection,
    disposeCaptureEvents,
    feedback,
  }
})
