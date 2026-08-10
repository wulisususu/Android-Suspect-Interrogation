import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import {
  backendErrorMessage,
  changeSessionStage,
  createCase,
  fetchCase,
  fetchFacts,
  fetchMessages,
  fetchRevisions,
  fetchSessionState,
  fetchTimeline,
  finishSession as finishSessionApi,
  markTranscriptMessage,
  pauseSession as pauseSessionApi,
  persistQuestionOrAnswer,
  resumeSession as resumeSessionApi,
  startSession as startSessionApi,
  streamInquiry,
  updateTranscriptMessage,
} from '../api/interrogation'
import type {
  CaseSummary,
  FactItem,
  InterrogationStage,
  RecordRevision,
  SessionState,
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

  const completion = computed(() => {
    if (!facts.value.length) return 0
    const done = facts.value.filter((item) => item.status === 'confirmed').length
    return Math.round((done / facts.value.length) * 100)
  })
  const stateText = computed(() => stateTextMap[caseSummary.value.state] || caseSummary.value.state)
  const stageText = computed(() => stageTextMap[session.value.stage])
  const canRecord = computed(() => session.value.status === 'RUNNING')

  function feedback(message: string, isError = false) {
    if (isError) {
      actionError.value = message
      actionMessage.value = ''
    } else {
      actionMessage.value = message
      actionError.value = ''
    }
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

    try {
      return await fetchCase(caseId.value)
    } catch {
      return createCase({ id: caseId.value, officerName: '当前警官' })
    }
  }

  async function initialize() {
    loading.value = true
    error.value = ''
    try {
      caseSummary.value = await ensureCurrentCase()
      const [messages, factItems, timelineItems, sessionState] = await Promise.all([
        fetchMessages(caseId.value),
        fetchFacts(caseId.value),
        fetchTimeline(caseId.value),
        fetchSessionState(caseId.value),
      ])
      transcript.value = messages
      facts.value = factItems
      timeline.value = timelineItems
      session.value = sessionState
      feedback('专属后端已连接，当前案件状态已加载')
    } catch (err) {
      error.value = backendErrorMessage(err)
      feedback(`后端初始化失败：${error.value}`, true)
    } finally {
      loading.value = false
    }
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
      feedback(`Q${persisted.seq || transcript.value.length} 已落库`)
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
    initialize,
    ask,
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
    feedback,
  }
})
