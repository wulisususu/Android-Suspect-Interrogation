import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import {
  backendErrorMessage,
  changeSessionStage,
  connectRuntimeSession,
  confirmAsrFragment,
  confirmAsrFragmentBatch,
  createCase,
  discardAsrFragment,
  fetchAsrCaptureStatus,
  fetchCase,
  fetchCaseAiAnalyses,
  fetchFacts,
  fetchMessages,
  fetchOfficerVoiceprints,
  fetchRevisions,
  fetchRuntimeCapabilities,
  fetchSessionState,
  fetchTimeline,
  fetchVoiceprintReadiness,
  finishSession as finishSessionApi,
  generateCaseAiAnalysis,
  markTranscriptMessage,
  normalizeTemporaryAsrFragment,
  pauseSession as pauseSessionApi,
  persistQuestionOrAnswer,
  resumeSession as resumeSessionApi,
  revokeOfficerVoiceprint as revokeOfficerVoiceprintApi,
  startAsrCapture,
  startOfficerVoiceprintEnrollment as startOfficerVoiceprintEnrollmentApi,
  startSession as startSessionApi,
  startSuspectVoiceprintEnrollment as startSuspectVoiceprintEnrollmentApi,
  stopAsrCapture,
  stopOfficerVoiceprintEnrollment as stopOfficerVoiceprintEnrollmentApi,
  stopSuspectVoiceprintEnrollment as stopSuspectVoiceprintEnrollmentApi,
  streamInquiry,
  updateAsrFragment,
  updateTranscriptMessage,
  updateVoiceprintAssignments,
} from '../api/interrogation'
import type { RuntimeSessionConnection } from '../runtime'
import type {
  AsrCaptureStatus,
  AsrInsertionReceipt,
  AsrInsertionTarget,
  CaseAiAnalysis,
  CaseSummary,
  FactItem,
  InterrogationStage,
  OfficerVoiceprint,
  RecordRevision,
  SessionState,
  TemporaryAsrFragment,
  TemporaryAsrSpeaker,
  TimelineEvent,
  TranscriptMessage,
  VoiceprintEnrollmentState,
  VoiceprintReadiness,
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

interface CaseScope {
  caseId: string
  generation: number
}

function emptyCaseSummary(caseId = ''): CaseSummary {
  return {
    id: caseId,
    suspectName: '',
    gender: '',
    age: '',
    officerName: '',
    state: 'DRAFT',
    stage: 'IDENTITY',
  }
}

function emptySession(caseId = ''): SessionState {
  return {
    id: null,
    caseId,
    status: 'READY',
    stage: 'IDENTITY',
    startedAt: null,
    pausedAt: null,
    endedAt: null,
    updatedAt: Date.now(),
  }
}

function emptyCapture(caseId = ''): AsrCaptureStatus {
  return {
    caseId,
    captureSessionId: null,
    running: false,
    startedAt: null,
    endedAt: null,
    sampleRate: 16_000,
    partialText: '',
    fragments: [],
    error: null,
  }
}

function emptyVoiceprintReadiness(): VoiceprintReadiness {
  return {
    suspectReady: false,
    interrogatorReady: false,
    recorderReady: false,
    recognitionMode: 'SUSPECT_ONLY',
    canStart: false,
  }
}

function idleEnrollmentState(): VoiceprintEnrollmentState {
  return { phase: 'IDLE', kind: null, subjectId: null, officerName: null, usableDurationMs: null, message: null }
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
  const captureAvailable = ref(false)
  const captureBusy = ref(false)
  const captureInsertionReceipt = ref<AsrInsertionReceipt | null>(null)
  const captureClock = ref(Date.now())
  const selectedFragmentIds = ref<string[]>([])
  const capture = ref<AsrCaptureStatus>(emptyCapture(caseId.value))
  const caseSummary = ref<CaseSummary>(emptyCaseSummary(caseId.value))
  const session = ref<SessionState>(emptySession(caseId.value))
  const transcript = ref<TranscriptMessage[]>([])
  const timeline = ref<TimelineEvent[]>([])
  const facts = ref<FactItem[]>([])
  const caseAiAnalyses = ref<CaseAiAnalysis[]>([])
  const caseAiBusy = ref(false)
  const caseAiError = ref('')
  const voiceprintReadiness = ref<VoiceprintReadiness>(emptyVoiceprintReadiness())
  const officerVoiceprints = ref<OfficerVoiceprint[]>([])
  const selectedInterrogatorOfficerId = ref<string | null>(null)
  const selectedRecorderOfficerId = ref<string | null>(null)
  const voiceprintEnrollmentState = ref<VoiceprintEnrollmentState>(idleEnrollmentState())
  const voiceprintBusy = ref(false)

  let caseGeneration = 0
  let feedbackTimer: ReturnType<typeof setTimeout> | undefined
  let captureTimer: ReturnType<typeof setInterval> | undefined
  let sessionConnection: RuntimeSessionConnection | undefined
  let inquiryController: AbortController | undefined

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

  function currentScope(): CaseScope {
    return { caseId: caseId.value, generation: caseGeneration }
  }

  function isCurrentScope(scope: CaseScope) {
    return scope.generation === caseGeneration && scope.caseId === caseId.value
  }

  function disposeCaptureEvents() {
    sessionConnection?.close()
    sessionConnection = undefined
    if (captureTimer) clearInterval(captureTimer)
    captureTimer = undefined
  }

  function resetCaseContext(nextCaseId = '') {
    caseGeneration += 1
    inquiryController?.abort()
    inquiryController = undefined
    disposeCaptureEvents()
    if (feedbackTimer) clearTimeout(feedbackTimer)
    feedbackTimer = undefined

    caseId.value = nextCaseId
    loading.value = true
    streaming.value = false
    error.value = ''
    actionMessage.value = ''
    actionError.value = ''
    revisions.value = []
    revisionsOpen.value = false
    captureAvailable.value = false
    captureBusy.value = false
    captureInsertionReceipt.value = null
    captureClock.value = Date.now()
    selectedFragmentIds.value = []
    capture.value = emptyCapture(nextCaseId)
    caseSummary.value = emptyCaseSummary(nextCaseId)
    session.value = emptySession(nextCaseId)
    transcript.value = []
    timeline.value = []
    facts.value = []
    caseAiAnalyses.value = []
    caseAiBusy.value = false
    caseAiError.value = ''
    voiceprintReadiness.value = emptyVoiceprintReadiness()
    officerVoiceprints.value = []
    selectedInterrogatorOfficerId.value = null
    selectedRecorderOfficerId.value = null
    voiceprintEnrollmentState.value = idleEnrollmentState()
    voiceprintBusy.value = false
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

  function feedbackIfCurrent(scope: CaseScope, message: string, isError = false) {
    if (isCurrentScope(scope)) feedback(message, isError)
  }

  function applyCaptureStatus(status: AsrCaptureStatus, scope = currentScope()) {
    if (!isCurrentScope(scope) || status.caseId !== scope.caseId) return
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

  function upsertAsrFragment(fragment: TemporaryAsrFragment, scope = currentScope()) {
    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return
    const index = capture.value.fragments.findIndex((item) => item.id === fragment.id)
    if (index >= 0) capture.value.fragments[index] = fragment
    else capture.value.fragments = [...capture.value.fragments, fragment].sort((left, right) => left.ordinal - right.ordinal)
    if (!capture.value.captureSessionId) capture.value.captureSessionId = fragment.captureSessionId
  }

  function initializeRuntimeEvents(scope: CaseScope) {
    if (sessionConnection || !scope.caseId || !session.value.id) return
    sessionConnection = connectRuntimeSession(session.value.id, (event) => {
      if (!isCurrentScope(scope)) return
      if (event.event === 'ASR_PARTIAL') {
        const payload = event.payload as { text?: string; partialText?: string }
        capture.value.partialText = payload.partialText ?? payload.text ?? capture.value.partialText
        return
      }
      if (event.event === 'ASR_FINAL') {
        const payload = event.payload as { text?: string }
        if (payload.text) capture.value.partialText = payload.text
        return
      }
      if (event.event === 'ASR_FRAGMENT') {
        const fragment = normalizeTemporaryAsrFragment(event.payload)
        upsertAsrFragment(fragment, scope)
        return
      }
      if (event.event === 'RECORDING_STATE' || event.event === 'asr.capture.status') {
        const status = event.payload as Partial<AsrCaptureStatus>
        if (status.caseId === scope.caseId && typeof status.running === 'boolean' && Array.isArray(status.fragments)) {
          applyCaptureStatus(status as AsrCaptureStatus, scope)
        }
        return
      }
      if (event.event === 'SESSION_STATE') {
        const next = event.payload as Partial<SessionState>
        if (next.caseId && next.caseId !== scope.caseId) return
        session.value = {
          ...session.value,
          ...next,
          caseId: scope.caseId,
          updatedAt: next.updatedAt ?? Date.now(),
        }
      }
    })
  }

  async function initialize() {
    const generation = caseGeneration
    let requestedCaseId = caseId.value
    loading.value = true
    error.value = ''

    try {
      let summary: CaseSummary
      if (!requestedCaseId) {
        const created = await createCase({ officerName: '当前警官' })
        if (generation !== caseGeneration || caseId.value !== '') return
        requestedCaseId = created.id
        caseId.value = requestedCaseId
        const next = new URL(location.href)
        next.searchParams.set('caseId', requestedCaseId)
        history.replaceState(null, '', next)
        summary = created
      } else {
        summary = await fetchCase(requestedCaseId)
      }

      const scope: CaseScope = { caseId: requestedCaseId, generation }
      if (!isCurrentScope(scope) || summary.id !== requestedCaseId) return

      const runtimeCapabilities = await fetchRuntimeCapabilities()
      captureAvailable.value = runtimeCapabilities.recording.state === 'AVAILABLE' || runtimeCapabilities.asr.state === 'AVAILABLE'
      const [messages, factItems, timelineItems, sessionState, captureStatus, analyses, readiness, officers] = await Promise.all([
        fetchMessages(requestedCaseId),
        fetchFacts(requestedCaseId),
        fetchTimeline(requestedCaseId),
        fetchSessionState(requestedCaseId),
        captureAvailable.value ? fetchAsrCaptureStatus(requestedCaseId) : Promise.resolve(null),
        fetchCaseAiAnalyses(requestedCaseId),
        fetchVoiceprintReadiness(requestedCaseId),
        fetchOfficerVoiceprints(true),
      ])

      if (!isCurrentScope(scope)) return
      if (sessionState.caseId !== requestedCaseId) throw new Error('会话状态案件号与当前案件不一致')
      if (captureStatus && captureStatus.caseId !== requestedCaseId) throw new Error('录音状态案件号与当前案件不一致')

      caseSummary.value = summary
      transcript.value = messages
      facts.value = factItems
      timeline.value = timelineItems
      session.value = sessionState
      voiceprintReadiness.value = readiness
      officerVoiceprints.value = officers
      initializeRuntimeEvents(scope)
      if (captureStatus) applyCaptureStatus(captureStatus, scope)
      caseAiAnalyses.value = analyses.filter((item) => item.caseId === requestedCaseId)
    } catch (err) {
      const scope: CaseScope = { caseId: requestedCaseId, generation }
      if (!isCurrentScope(scope)) return
      error.value = backendErrorMessage(err)
      feedback(`后端初始化失败：${error.value}`, true)
    } finally {
      const scope: CaseScope = { caseId: requestedCaseId, generation }
      if (isCurrentScope(scope)) loading.value = false
    }
  }

  async function refreshTranscript(scope = currentScope()) {
    const messages = await fetchMessages(scope.caseId)
    if (!isCurrentScope(scope)) return
    transcript.value = messages
  }

  async function startCapture() {
    if (!captureAvailable.value) return feedback('连续离线录音 Runtime 当前不可用，请检查 ASR/麦克风能力状态', true)
    if (!voiceprintReadiness.value.canStart) return feedback('请先完成嫌疑人声纹注册，再启动正式语音采集', true)
    if (!canRecord.value) return feedback('请先开始审讯再录音', true)
    if (captureBusy.value || capture.value.running) return

    const scope = currentScope()
    captureBusy.value = true
    try {
      const status = await startAsrCapture(scope.caseId)
      applyCaptureStatus(status, scope)
      feedbackIfCurrent(scope, '录音已开始；每个语音片段需确认后才写入正式笔录')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    } finally {
      if (isCurrentScope(scope)) captureBusy.value = false
    }
  }

  async function stopCapture(_target?: AsrInsertionTarget, showFeedback = true) {
    if (!captureAvailable.value || captureBusy.value || !capture.value.running) return

    const scope = currentScope()
    captureBusy.value = true
    try {
      const status = await stopAsrCapture(scope.caseId)
      applyCaptureStatus(status, scope)
      if (showFeedback) feedbackIfCurrent(scope, '录音已停止，识别结果保留为待确认片段，不会自动改写正式笔录')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    } finally {
      if (isCurrentScope(scope)) captureBusy.value = false
    }
  }

  async function updatePendingFragment(fragmentId: string, editedText: string, speaker: TemporaryAsrSpeaker) {
    const scope = currentScope()
    try {
      const updated = await updateAsrFragment(scope.caseId, fragmentId, editedText, speaker)
      upsertAsrFragment(updated, scope)
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function confirmPendingFragment(fragmentId: string) {
    const scope = currentScope()
    try {
      const confirmed = await confirmAsrFragment(scope.caseId, fragmentId)
      if (!isCurrentScope(scope) || confirmed.caseId !== scope.caseId) return
      await refreshTranscript(scope)
      if (!isCurrentScope(scope)) return
      capture.value.fragments = capture.value.fragments.filter((fragment) => fragment.id !== confirmed.id)
      selectedFragmentIds.value = selectedFragmentIds.value.filter((id) => id !== confirmed.id)
      feedbackIfCurrent(scope, '片段已确认并写入正式笔录')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function confirmSelectedFragments() {
    if (!selectedFragmentIds.value.length) return

    const scope = currentScope()
    const fragmentIds = [...selectedFragmentIds.value]
    try {
      const result = await confirmAsrFragmentBatch(scope.caseId, fragmentIds)
      if (!isCurrentScope(scope) || result.fragments.some((item) => item.caseId !== scope.caseId)) return
      await refreshTranscript(scope)
      if (!isCurrentScope(scope)) return
      const confirmedIds = new Set(result.fragments.map((item) => item.id))
      capture.value.fragments = capture.value.fragments.filter((fragment) => !confirmedIds.has(fragment.id))
      selectedFragmentIds.value = selectedFragmentIds.value.filter((id) => !confirmedIds.has(id))
      feedbackIfCurrent(scope, `已确认并入库 ${result.confirmedCount} 条片段`)
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function discardPendingFragment(fragmentId: string) {
    const scope = currentScope()
    try {
      const discarded = await discardAsrFragment(scope.caseId, fragmentId)
      if (!isCurrentScope(scope) || discarded.caseId !== scope.caseId) return
      capture.value.fragments = capture.value.fragments.filter((fragment) => fragment.id !== fragmentId)
      selectedFragmentIds.value = selectedFragmentIds.value.filter((id) => id !== fragmentId)
      feedbackIfCurrent(scope, '临时片段已丢弃')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  function toggleFragmentSelection(fragmentId: string) {
    selectedFragmentIds.value = selectedFragmentIds.value.includes(fragmentId)
      ? selectedFragmentIds.value.filter((id) => id !== fragmentId)
      : [...selectedFragmentIds.value, fragmentId]
  }

  async function refreshCase(scope = currentScope()) {
    const summary = await fetchCase(scope.caseId)
    if (!isCurrentScope(scope) || summary.id !== scope.caseId) return
    caseSummary.value = summary
  }

  async function refreshVoiceprintState(scope = currentScope()) {
    const [readiness, officers] = await Promise.all([
      fetchVoiceprintReadiness(scope.caseId),
      fetchOfficerVoiceprints(true),
    ])
    if (!isCurrentScope(scope)) return
    voiceprintReadiness.value = readiness
    officerVoiceprints.value = officers
  }

  function selectInterrogatorOfficer(officerId: string | null) {
    selectedInterrogatorOfficerId.value = officerId || null
  }

  function selectRecorderOfficer(officerId: string | null) {
    selectedRecorderOfficerId.value = officerId || null
  }

  async function startSuspectVoiceprintEnrollment(actorId?: string) {
    if (voiceprintBusy.value) return
    const scope = currentScope()
    voiceprintBusy.value = true
    voiceprintEnrollmentState.value = { phase: 'RECORDING', kind: 'SUSPECT', subjectId: scope.caseId, message: '正在录制嫌疑人声纹' }
    try {
      const result = await startSuspectVoiceprintEnrollmentApi(scope.caseId, actorId)
      if (!isCurrentScope(scope)) return
      voiceprintEnrollmentState.value = {
        ...voiceprintEnrollmentState.value,
        phase: 'RECORDING',
        simulated: Boolean(result.simulated),
      }
    } catch (err) {
      if (isCurrentScope(scope)) voiceprintEnrollmentState.value = { phase: 'ERROR', kind: 'SUSPECT', subjectId: scope.caseId, message: backendErrorMessage(err) }
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    } finally {
      if (isCurrentScope(scope)) voiceprintBusy.value = false
    }
  }

  async function stopSuspectVoiceprintEnrollment(actorId?: string) {
    if (voiceprintBusy.value) return
    const scope = currentScope()
    voiceprintBusy.value = true
    voiceprintEnrollmentState.value = { ...voiceprintEnrollmentState.value, phase: 'PROCESSING' }
    try {
      const result = await stopSuspectVoiceprintEnrollmentApi(scope.caseId, actorId)
      if (!isCurrentScope(scope)) return
      await refreshVoiceprintState(scope)
      if (!isCurrentScope(scope)) return
      voiceprintEnrollmentState.value = {
        phase: 'COMPLETE',
        kind: 'SUSPECT',
        subjectId: scope.caseId,
        usableDurationMs: Number(result.usableDurationMs ?? 0),
        simulated: Boolean(result.simulated),
        message: result.simulated ? '浏览器开发模拟完成；未形成真实声纹验证' : '嫌疑人声纹已注册',
      }
      feedbackIfCurrent(scope, voiceprintEnrollmentState.value.message || '嫌疑人声纹已注册')
    } catch (err) {
      if (isCurrentScope(scope)) voiceprintEnrollmentState.value = { phase: 'ERROR', kind: 'SUSPECT', subjectId: scope.caseId, message: backendErrorMessage(err) }
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    } finally {
      if (isCurrentScope(scope)) voiceprintBusy.value = false
    }
  }

  async function startOfficerVoiceprintEnrollment(officerId: string, officerName: string, actorId?: string) {
    if (voiceprintBusy.value) return
    const scope = currentScope()
    voiceprintBusy.value = true
    voiceprintEnrollmentState.value = { phase: 'RECORDING', kind: 'OFFICER', subjectId: officerId, officerName, message: '正在录制民警声纹' }
    try {
      const result = await startOfficerVoiceprintEnrollmentApi(officerId, officerName, actorId)
      if (!isCurrentScope(scope)) return
      voiceprintEnrollmentState.value = { ...voiceprintEnrollmentState.value, phase: 'RECORDING', simulated: Boolean(result.simulated) }
    } catch (err) {
      if (isCurrentScope(scope)) voiceprintEnrollmentState.value = { phase: 'ERROR', kind: 'OFFICER', subjectId: officerId, officerName, message: backendErrorMessage(err) }
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    } finally {
      if (isCurrentScope(scope)) voiceprintBusy.value = false
    }
  }

  async function stopOfficerVoiceprintEnrollment(officerId: string, actorId?: string) {
    if (voiceprintBusy.value) return
    const scope = currentScope()
    voiceprintBusy.value = true
    voiceprintEnrollmentState.value = { ...voiceprintEnrollmentState.value, phase: 'PROCESSING' }
    try {
      const result = await stopOfficerVoiceprintEnrollmentApi(officerId, actorId)
      if (!isCurrentScope(scope)) return
      await refreshVoiceprintState(scope)
      if (!isCurrentScope(scope)) return
      voiceprintEnrollmentState.value = {
        phase: 'COMPLETE',
        kind: 'OFFICER',
        subjectId: officerId,
        officerName: String(result.officerName ?? voiceprintEnrollmentState.value.officerName ?? ''),
        usableDurationMs: Number(result.usableDurationMs ?? 0),
        simulated: Boolean(result.simulated),
        message: result.simulated ? '浏览器开发模拟完成；未形成真实民警声纹' : '民警声纹已保存',
      }
      feedbackIfCurrent(scope, voiceprintEnrollmentState.value.message || '民警声纹已保存')
    } catch (err) {
      if (isCurrentScope(scope)) voiceprintEnrollmentState.value = { ...voiceprintEnrollmentState.value, phase: 'ERROR', message: backendErrorMessage(err) }
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    } finally {
      if (isCurrentScope(scope)) voiceprintBusy.value = false
    }
  }

  async function revokeOfficerVoiceprint(officerId: string, actorId?: string) {
    const scope = currentScope()
    try {
      await revokeOfficerVoiceprintApi(officerId, actorId)
      if (!isCurrentScope(scope)) return
      if (selectedInterrogatorOfficerId.value === officerId) selectedInterrogatorOfficerId.value = null
      if (selectedRecorderOfficerId.value === officerId) selectedRecorderOfficerId.value = null
      await refreshVoiceprintState(scope)
      feedbackIfCurrent(scope, '民警声纹已撤销')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function bindVoiceprintRoles(actorId?: string) {
    const scope = currentScope()
    if (session.value.status === 'READY') {
      feedbackIfCurrent(scope, '民警角色选择已暂存；开始审讯后会绑定到本次 session')
      return
    }
    try {
      const readiness = await updateVoiceprintAssignments(
        scope.caseId,
        selectedInterrogatorOfficerId.value,
        selectedRecorderOfficerId.value,
        actorId,
      )
      if (!isCurrentScope(scope)) return
      voiceprintReadiness.value = readiness
      feedbackIfCurrent(scope, '本次审讯的民警声纹角色已绑定')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
      throw err
    }
  }

  async function ask(text: string) {
    const clean = text.trim()
    if (!clean || streaming.value) return
    if (!canRecord.value) {
      feedback(session.value.status === 'PAUSED' ? '审讯已暂停，请先恢复' : '请先点击“开始审讯”', true)
      return
    }

    const scope = currentScope()
    error.value = ''
    actionError.value = ''
    try {
      const persisted = await persistQuestionOrAnswer(scope.caseId, clean, '民警')
      if (!isCurrentScope(scope)) return
      transcript.value.push(persisted)
      feedbackIfCurrent(scope, `Q${persisted.seq || transcript.value.length} 已保存`)
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
      return
    }

    if (!isCurrentScope(scope)) return
    const aiMessage: TranscriptMessage = { id: uid(), speaker: 'AI', text: '', streaming: true }
    transcript.value.push(aiMessage)
    streaming.value = true
    const controller = new AbortController()
    inquiryController = controller

    try {
      await streamInquiry(scope.caseId, clean, (payload) => {
        if (!isCurrentScope(scope)) return
        if (payload.code) {
          error.value = payload.message || `AI 上游返回错误 ${payload.code}`
          return
        }
        if (payload.text_chunk) aiMessage.text += payload.text_chunk
      }, controller.signal)
    } catch (err) {
      if (isCurrentScope(scope) && !controller.signal.aborted) error.value = backendErrorMessage(err)
    } finally {
      aiMessage.streaming = false
      if (inquiryController === controller) inquiryController = undefined
      if (isCurrentScope(scope)) streaming.value = false
    }
  }

  async function generateCaseAnalysis() {
    if (caseAiBusy.value) return

    const scope = currentScope()
    caseAiBusy.value = true
    caseAiError.value = ''
    try {
      const analysis = await generateCaseAiAnalysis(scope.caseId)
      if (!isCurrentScope(scope)) return
      if (analysis.caseId !== scope.caseId) {
        caseAiError.value = 'AI 推理返回的案件号与当前案件不一致'
        feedback(caseAiError.value, true)
        return
      }
      caseAiAnalyses.value = [analysis, ...caseAiAnalyses.value.filter((item) => item.id !== analysis.id && item.caseId === scope.caseId)]
      feedbackIfCurrent(scope, '本案 AI 推理已生成并保存到当前案件')
    } catch (err) {
      if (!isCurrentScope(scope)) return
      caseAiError.value = backendErrorMessage(err)
      feedback(caseAiError.value, true)
    } finally {
      if (isCurrentScope(scope)) caseAiBusy.value = false
    }
  }

  async function editMessage(messageId: string, text: string) {
    const scope = currentScope()
    try {
      const updated = await updateTranscriptMessage(scope.caseId, messageId, text)
      if (!isCurrentScope(scope)) return
      const index = transcript.value.findIndex((item) => item.id === messageId)
      if (index >= 0) transcript.value[index] = updated
      feedbackIfCurrent(scope, `Q/A ${updated.seq || ''} 已修订，旧内容已进入版本历史`)
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function markMessage(messageId: string) {
    const scope = currentScope()
    try {
      const updated = await markTranscriptMessage(scope.caseId, messageId, 'conflict')
      if (!isCurrentScope(scope)) return
      const index = transcript.value.findIndex((item) => item.id === messageId)
      if (index >= 0) transcript.value[index] = updated
      feedbackIfCurrent(scope, '已标记为“存在矛盾”，后端审计日志已记录')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function markLatestConflict() {
    const target = [...transcript.value].reverse().find((item) => item.speaker !== 'AI')
    if (!target) return feedback('当前没有可标记的正式问答', true)
    await markMessage(target.id)
  }

  async function openRevisions(messageId?: string) {
    const scope = currentScope()
    try {
      const nextRevisions = await fetchRevisions(scope.caseId, messageId)
      if (!isCurrentScope(scope)) return
      revisions.value = nextRevisions
      revisionsOpen.value = true
      feedbackIfCurrent(scope, revisions.value.length ? `已读取 ${revisions.value.length} 条版本记录` : '当前暂无修订历史')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  function closeRevisions() {
    revisionsOpen.value = false
  }

  async function startSession() {
    const scope = currentScope()
    if (!voiceprintReadiness.value.canStart) {
      feedbackIfCurrent(scope, voiceprintReadiness.value.simulated ? '浏览器模拟声纹不能解锁正式审讯' : '请先完成嫌疑人声纹注册', true)
      return
    }
    try {
      const nextSession = await startSessionApi(scope.caseId)
      if (!isCurrentScope(scope) || nextSession.caseId !== scope.caseId) return
      session.value = nextSession
      try {
        await bindVoiceprintRoles()
      } catch {
        if (!isCurrentScope(scope)) return
        try {
          const paused = await pauseSessionApi(scope.caseId)
          if (isCurrentScope(scope) && paused.caseId === scope.caseId) session.value = paused
        } catch {
          // Keep the original role-binding failure visible; capture remains blocked while not RUNNING.
        }
        return
      }
      if (!isCurrentScope(scope)) return
      disposeCaptureEvents()
      initializeRuntimeEvents(scope)
      await refreshCase(scope)
      feedbackIfCurrent(scope, '审讯已开始：嫌疑人声纹门禁已通过，民警角色已绑定到本次 session')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function togglePause() {
    const scope = currentScope()
    try {
      if (session.value.status === 'RUNNING') {
        if (capture.value.running) await stopCapture(undefined, false)
        if (!isCurrentScope(scope)) return
        const nextSession = await pauseSessionApi(scope.caseId)
        if (!isCurrentScope(scope) || nextSession.caseId !== scope.caseId) return
        session.value = nextSession
        feedbackIfCurrent(scope, '审讯已暂停，新的正式问答将被后端拒绝')
      } else if (session.value.status === 'PAUSED') {
        const nextSession = await resumeSessionApi(scope.caseId)
        if (!isCurrentScope(scope) || nextSession.caseId !== scope.caseId) return
        session.value = nextSession
        feedbackIfCurrent(scope, '审讯已恢复')
      }
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function finishSession() {
    const scope = currentScope()
    try {
      if (capture.value.running) await stopCapture(undefined, false)
      if (!isCurrentScope(scope)) return
      const nextSession = await finishSessionApi(scope.caseId)
      if (!isCurrentScope(scope) || nextSession.caseId !== scope.caseId) return
      session.value = nextSession
      await refreshCase(scope)
      feedbackIfCurrent(scope, '本次审讯已结束并进入复核状态')
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
    }
  }

  async function nextStage() {
    const index = stageOrder.indexOf(session.value.stage)
    if (index < 0 || index >= stageOrder.length - 1) return feedback('当前已经是最后的“确认签名”阶段', true)

    const scope = currentScope()
    try {
      const nextSession = await changeSessionStage(scope.caseId, stageOrder[index + 1])
      if (!isCurrentScope(scope) || nextSession.caseId !== scope.caseId) return
      session.value = nextSession
      await refreshCase(scope)
      feedbackIfCurrent(scope, `已进入：${stageTextMap[nextSession.stage]}`)
    } catch (err) {
      feedbackIfCurrent(scope, backendErrorMessage(err), true)
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
    nativeCaptureAvailable: captureAvailable,
    capture,
    captureBusy,
    captureInsertionReceipt,
    captureElapsedMs,
    selectedFragmentIds,
    voiceprintReadiness,
    officerVoiceprints,
    selectedInterrogatorOfficerId,
    selectedRecorderOfficerId,
    voiceprintEnrollmentState,
    voiceprintBusy,
    resetCaseContext,
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
    refreshVoiceprintState,
    selectInterrogatorOfficer,
    selectRecorderOfficer,
    startSuspectVoiceprintEnrollment,
    stopSuspectVoiceprintEnrollment,
    startOfficerVoiceprintEnrollment,
    stopOfficerVoiceprintEnrollment,
    revokeOfficerVoiceprint,
    bindVoiceprintRoles,
    disposeCaptureEvents,
    feedback,
  }
})