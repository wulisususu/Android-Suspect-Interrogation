<script setup lang="ts">
import { computed, nextTick, onMounted, onUnmounted, ref, watch } from 'vue'

import type { TemporaryAsrFragment, TemporaryAsrSpeaker } from '../types/interrogation'
import { judgeDevBotReply, devBotAsk, devBotNextQuestion } from '../api/devBot'
import type {
  FormalQAUnit,
  FormalQuestion,
  PendingFormalQuestion,
  PendingResolution,
  QAUnitResolution,
} from '../types/templateInterrogation'
import { dialoguePresentation, groupLiveDialogueFragments } from '../utils/templateInterrogation'

const props = defineProps<{
  caseId: string
  dialogue: TemporaryAsrFragment[]
  partialText: string
  pendingQuestions: PendingFormalQuestion[]
  qaUnits: FormalQAUnit[]
  questions: FormalQuestion[]
  suspectName?: string
  captureRunning: boolean
  captureBusy: boolean
  captureAvailable: boolean
  captureElapsedMs: number
}>()

const emit = defineEmits<{
  captureToggle: []
  resolvePending: [pendingId: string, resolution: PendingResolution]
  resolveQaUnit: [qaUnitId: string, resolution: QAUnitResolution]
  rollbackQaUnit: [qaUnitId: string]
  correctFragment: [fragmentId: string, speaker: TemporaryAsrSpeaker, reason: string]
}>()

const feed = ref<HTMLElement | null>(null)
const pinnedToBottom = ref(true)
const correctionSpeaker = ref<Record<string, TemporaryAsrSpeaker>>({})
const correctionReason = ref<Record<string, string>>({})
const qaReviewUnits = computed(() => props.qaUnits.filter((unit) => unit.status === 'NEEDS_REVIEW'))
const qaResolvedUnits = computed(() => props.qaUnits.filter((unit) => unit.status === 'APPLIED' || unit.status === 'IGNORED' || unit.status === 'ROLLED_BACK'))
const visibleDialogue = computed(() => groupLiveDialogueFragments([...props.dialogue, ...botTurns.value]))

// ---------------------------------------------------------------------------
// Dev-only BOT interrogator: one person plays both roles. The bot asks the
// case's formal questions as text; the tester replies by voice through the
// normal ASR capture. A reply counts when no new suspect fragment arrives for
// 10s, then the cloud LLM judges whether it answers the question. This whole
// block is a test rig and must never grow into the production flow.
// ---------------------------------------------------------------------------
const BOT_SILENCE_MS = 20_000
const BOT_MAX_DYNAMIC = 10
const BOT_STORAGE_PREFIX = 'dev-bot-turns:'
let botSeq = 0
let botQueue: FormalQuestion[] = []
let botCurrent: { id: string; text: string } | null = null
let botBaselineIds = new Set<string>()
let botEmptyStreak = 0
let botDynamicCount = 0
let botAskedTexts: string[] = []
let botAnswerTexts: string[] = []
let botSilenceTimer: ReturnType<typeof setTimeout> | undefined
const botActive = ref(false)
const botJudging = ref(false)
const botGenerating = ref(false)
const botTurns = ref<TemporaryAsrFragment[]>([])

const botStorageKey = computed(() => `${BOT_STORAGE_PREFIX}${props.caseId}`)
const botAnsweredKey = computed(() => `dev-bot-answered:${props.caseId}`)
let botAnsweredIds = new Set<string>()

function loadBotAnswered() {
  try {
    const raw = localStorage.getItem(botAnsweredKey.value)
    botAnsweredIds = new Set(raw ? (JSON.parse(raw) as string[]) : [])
  } catch {
    botAnsweredIds = new Set()
  }
}

function markBotAnswered(questionId: string) {
  botAnsweredIds.add(questionId)
  try {
    localStorage.setItem(botAnsweredKey.value, JSON.stringify([...botAnsweredIds]))
  } catch { /* storage unavailable */ }
}

function isBotFragment(item: TemporaryAsrFragment) {
  return item.id.startsWith('dev-bot-') || item.modelId === 'dev-bot'
}

function botTurnFrom(text: string, createdAt: number, id: string): TemporaryAsrFragment {
  const seq = Number(id.slice('dev-bot-'.length)) || 0
  return {
    id,
    captureSessionId: 'dev-bot',
    caseId: '',
    ordinal: 1_000_000 + seq,
    startedAtMs: createdAt,
    endedAtMs: createdAt,
    rawText: text,
    editedText: '',
    speaker: 'INTERROGATOR',
    speakerId: null,
    speakerName: 'BOT 民警',
    speakerScore: null,
    secondBestScore: null,
    speakerThreshold: null,
    speakerMargin: null,
    speakerSource: 'MANUAL',
    voiceprintVerified: false,
    confidence: null,
    confidenceSource: 'UNAVAILABLE',
    lowConfidence: false,
    state: 'CONFIRMED',
    confirmedQaId: null,
    confirmedMessageId: null,
    recognitionEvidence: null,
    recognitionRevisions: [],
    audio: { captureSessionId: 'dev-bot', startOffsetMs: 0, endOffsetMs: 0, available: false },
    createdAt,
    updatedAt: createdAt,
  }
}

function botTurn(text: string): TemporaryAsrFragment {
  botSeq += 1
  return botTurnFrom(text, Date.now(), `dev-bot-${botSeq}`)
}

function persistBotTurns() {
  try {
    const data = botTurns.value.map((item) => ({ id: item.id, text: item.rawText, createdAt: item.createdAt }))
    localStorage.setItem(botStorageKey.value, JSON.stringify(data.slice(-300)))
  } catch { /* storage unavailable — bot turns stay in-memory only */ }
}

function restoreBotTurns() {
  try {
    const raw = localStorage.getItem(botStorageKey.value)
    if (!raw) return
    const parsed = JSON.parse(raw) as Array<{ id?: unknown; text?: unknown; createdAt?: unknown }>
    if (!Array.isArray(parsed)) return
    let maxSeq = 0
    const restored: TemporaryAsrFragment[] = []
    for (const item of parsed) {
      if (typeof item?.id !== 'string' || typeof item?.text !== 'string' || typeof item?.createdAt !== 'number') continue
      restored.push(botTurnFrom(item.text, item.createdAt, item.id))
      maxSeq = Math.max(maxSeq, Number(item.id.slice('dev-bot-'.length)) || 0)
    }
    botTurns.value = restored
    botSeq = Math.max(botSeq, maxSeq)
  } catch { /* corrupted snapshot — start clean */ }
}

function pushBotTurn(text: string) {
  botTurns.value = [...botTurns.value, botTurn(text)]
  persistBotTurns()
}

function clearBotSilenceTimer() {
  if (botSilenceTimer) clearTimeout(botSilenceTimer)
  botSilenceTimer = undefined
}

function suspectFragmentIds() {
  return new Set(props.dialogue.filter((item) => item.speaker === 'SUSPECT').map((item) => item.id))
}

function armSilenceTimer() {
  clearBotSilenceTimer()
  botSilenceTimer = setTimeout(() => { void onBotSilence() }, BOT_SILENCE_MS)
}

async function toggleBot() {
  if (botActive.value) {
    stopBot()
    return
  }
  if (!props.captureAvailable) {
    pushBotTurn('（BOT）当前录音不可用：请先点「开始审讯」让会话进入审讯中，确认录音可用后再点 BOT。')
    return
  }
  botActive.value = true
  botEmptyStreak = 0
  botDynamicCount = 0
  botAskedTexts = []
  botAnswerTexts = []
  loadBotAnswered()
  // Skip questions already routed into the formal record (rounds) and ones the
  // judge already accepted, so a refresh never re-asks answered questions.
  botQueue = props.questions.filter(
    (item) => item.active && !(item.rounds && item.rounds.length) && !botAnsweredIds.has(item.id),
  )
  if (!props.captureRunning) {
    emit('captureToggle')
    // The REST start is async: wait until the backend capture session really
    // exists before injecting the first question, otherwise the injection is
    // rejected with "no active capture".
    const started = await waitForCaptureRunning(10_000)
    if (!started) {
      pushBotTurn('（BOT）录音未能自动开启，请手动点击「开始录音」后再点 BOT。')
      stopBot()
      return
    }
  }
  await askNextBotQuestion()
}

function waitForCaptureRunning(timeoutMs: number): Promise<boolean> {
  return new Promise((resolve) => {
    const deadline = Date.now() + timeoutMs
    const timer = setInterval(() => {
      if (props.captureRunning || Date.now() > deadline) {
        clearInterval(timer)
        resolve(props.captureRunning)
      }
    }, 300)
  })
}

function stopBot() {
  botActive.value = false
  botCurrent = null
  botGenerating.value = false
  clearBotSilenceTimer()
}

async function askNextBotQuestion() {
  clearBotSilenceTimer()
  const question = botQueue.shift()
  if (!question) {
    await askDynamicQuestion()
    return
  }
  botCurrent = question
  botBaselineIds = suspectFragmentIds()
  // The question is injected as a REAL interrogator fragment so the suspect
  // answer flows through the normal QA-unit / formal-record routing pipeline.
  try {
    await devBotAsk(props.caseId, question.text)
    botAskedTexts.push(question.text)
  } catch (err) {
    pushBotTurn(`（BOT 提问失败：${err instanceof Error ? err.message : '未知错误'}）BOT 已暂停。`)
    stopBot()
    return
  }
  armSilenceTimer()
}

async function askDynamicQuestion() {
  if (!botActive.value) return
  if (botDynamicCount >= BOT_MAX_DYNAMIC) {
    botCurrent = null
    pushBotTurn(`（BOT）动态追问已达测试上限 ${BOT_MAX_DYNAMIC} 条，停止提问。`)
    stopBot()
    return
  }
  botGenerating.value = true
  try {
    const text = await devBotNextQuestion(props.caseId, botAskedTexts, botAnswerTexts)
    if (!botActive.value) return
    botDynamicCount += 1
    botCurrent = { id: `dynamic-${botDynamicCount}`, text }
    botBaselineIds = suspectFragmentIds()
    await devBotAsk(props.caseId, text)
    botAskedTexts.push(text)
  } catch (err) {
    pushBotTurn(`（BOT 生成追问失败：${err instanceof Error ? err.message : '未知错误'}）BOT 已暂停。`)
    stopBot()
    return
  } finally {
    botGenerating.value = false
  }
  armSilenceTimer()
}

async function onBotSilence() {
  const question = botCurrent
  if (!botActive.value || !question) return
  const reply = props.dialogue
    .filter((item) => item.speaker === 'SUSPECT' && !botBaselineIds.has(item.id))
    .map((item) => (item.editedText || item.rawText || '').trim())
    .filter(Boolean)
    .join(' ')
  if (!reply) {
    botEmptyStreak += 1
    if (!props.captureRunning || botEmptyStreak >= 3) {
      pushBotTurn('（BOT）连续 20 秒都没有转写到你的回复，BOT 已暂停。请确认「开始审讯」和录音已开启，再点 BOT 重试。')
      stopBot()
      return
    }
    pushBotTurn('（BOT）20 秒内没有转写到你的回复，请对着麦克风说话。')
    botBaselineIds = suspectFragmentIds()
    armSilenceTimer()
    return
  }
  botEmptyStreak = 0
  botJudging.value = true
  try {
    const verdict = await judgeDevBotReply(question.text, reply)
    if (verdict.isAnswer) {
      markBotAnswered(question.id)
      botAnswerTexts.push(reply)
      botCurrent = null
      askNextBotQuestion()
    } else {
      pushBotTurn(`（BOT 判定：还不算回答）${verdict.comment || '请再说明一下。'}`)
      botBaselineIds = suspectFragmentIds()
      armSilenceTimer()
    }
  } catch (err) {
    pushBotTurn(`（BOT 判定失败：${err instanceof Error ? err.message : '未知错误'}）跳过本题，继续下一题。`)
    botCurrent = null
    askNextBotQuestion()
  } finally {
    botJudging.value = false
  }
}

watch(() => props.dialogue.length, () => {
  if (!botActive.value || !botCurrent) return
  const hasNewSuspectText = props.dialogue.some(
    (item) => item.speaker === 'SUSPECT' && !botBaselineIds.has(item.id) && (item.editedText || item.rawText || '').trim(),
  )
  if (hasNewSuspectText) armSilenceTimer()
})

// While capture runs, the transcription bubble stays mounted (with a 待输入
// placeholder when idle) so the partial text does not flash between utterances.

onUnmounted(() => {
  clearBotSilenceTimer()
})

const elapsed = computed(() => {
  const total = Math.floor(props.captureElapsedMs / 1000)
  return `${String(Math.floor(total / 60)).padStart(2, '0')}:${String(total % 60).padStart(2, '0')}`
})

function formatTime(item: TemporaryAsrFragment) {
  if (!item.createdAt) return ''
  return new Intl.DateTimeFormat('zh-CN', {
    hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false,
  }).format(new Date(item.createdAt))
}

function formatDate(value?: number | null) {
  if (!value) return '—'
  return new Intl.DateTimeFormat('zh-CN', {
    month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false,
  }).format(new Date(value))
}

function speakerLabel(role?: TemporaryAsrSpeaker | null) {
  if (role === 'SUSPECT') return '嫌疑人'
  if (role === 'INTERROGATOR') return '主审民警'
  if (role === 'RECORDER') return '记录民警'
  if (role === 'OFFICER_FALLBACK') return '非嫌疑人 / 未确认民警'
  return '未知人员'
}

function thresholdSourceLabel(source?: string | null) {
  if (source === 'DEVICE_CALIBRATED') return '设备实测'
  if (source === 'MODEL_BASELINE') return '模型基线'
  if (source === 'LEGACY_ENV') return '旧版配置'
  return source || '未记录'
}

function scoreText(value?: number | null) {
  return value == null ? '—' : value.toFixed(4)
}

function shortFingerprint(value?: string | null) {
  if (!value) return '—'
  return value.length <= 16 ? value : `${value.slice(0, 8)}…${value.slice(-8)}`
}

function speakerName(item: TemporaryAsrFragment) {
  const presentation = dialoguePresentation(item)
  if (item.speaker === 'SUSPECT') return props.suspectName || item.speakerName || presentation.badge
  return item.speakerName || presentation.badge
}

function speakerPrefix(item: TemporaryAsrFragment) {
  return item.speaker === 'UNKNOWN' ? '' : `${speakerName(item)}：`
}

function pendingFor(fragmentId: string) {
  return props.pendingQuestions.find((item) => item.officerFragmentId === fragmentId && (item.status === 'PENDING' || item.status === 'DEFERRED'))
}

function candidateQuestions(pending: PendingFormalQuestion) {
  const ids = new Set(pending.candidateQuestionIds)
  return props.questions.filter((question) => ids.has(question.id))
}

function resolve(pending: PendingFormalQuestion, resolution: PendingResolution) {
  emit('resolvePending', pending.id, resolution)
}

function startPendingDrag(event: DragEvent, fragmentId: string) {
  const pending = pendingFor(fragmentId)
  if (!pending || !event.dataTransfer) return
  event.dataTransfer.effectAllowed = 'copy'
  event.dataTransfer.setData('application/x-formal-pending-question', JSON.stringify({ pendingId: pending.id }))
}

function startQaDrag(event: DragEvent, payload: { qaUnitId: string; mode: 'QA' | 'ANSWER' }) {
  if (!event.dataTransfer) return
  event.dataTransfer.effectAllowed = 'copy'
  event.dataTransfer.setData('application/x-formal-qa-unit', JSON.stringify(payload))
}

function startWholeQaDrag(event: DragEvent, unit: FormalQAUnit) {
  startQaDrag(event, { qaUnitId: unit.id, mode: 'QA' })
}

function startAnswerDrag(event: DragEvent, unit: FormalQAUnit) {
  startQaDrag(event, { qaUnitId: unit.id, mode: 'ANSWER' })
}

function resolveQa(unit: FormalQAUnit, resolution: QAUnitResolution) {
  emit('resolveQaUnit', unit.id, resolution)
}

function rollbackQa(unit: FormalQAUnit) {
  if (unit.status !== 'APPLIED') return
  if (!window.confirm('仅回退本次正式笔录回答，问题和原始对话会保留。确定继续吗？')) return
  emit('rollbackQaUnit', unit.id)
}

function qaStatusLabel(unit: FormalQAUnit) {
  if (unit.status === 'IGNORED' || unit.classification === 'IGNORE') return '已忽略·仅原始对话'
  if (unit.status === 'NEEDS_REVIEW') return '待处理'
  if (unit.status === 'ROLLED_BACK') return '已回退·问题保留'
  if (unit.classification === 'MATCH_FIXED') return '已归档·固定模板'
  if (unit.classification === 'MATCH_EXISTING') return '已归档·已有问题'
  if (unit.classification === 'CREATE_LIVE_FROM_SPEECH') return '已新增·现场问题'
  return unit.status
}

function correctionRole(item: TemporaryAsrFragment): TemporaryAsrSpeaker {
  return correctionSpeaker.value[item.id] || item.speaker
}

function submitCorrection(item: TemporaryAsrFragment) {
  const reason = (correctionReason.value[item.id] || '').trim()
  if (!reason) return
  emit('correctFragment', item.id, correctionRole(item), reason)
}

function onFeedScroll() {
  const element = feed.value
  if (!element) return
  pinnedToBottom.value = element.scrollHeight - element.scrollTop - element.clientHeight <= 80
}

async function scrollToLatest(force = false) {
  await nextTick()
  const element = feed.value
  if (!element || (!force && !pinnedToBottom.value)) return
  element.scrollTop = element.scrollHeight
  pinnedToBottom.value = true
}

watch(
  () => [visibleDialogue.value.length, props.partialText, props.qaUnits.map((unit) => `${unit.id}:${unit.updatedAt}`).join('|'), props.pendingQuestions.map((item) => `${item.id}:${item.status}`).join('|')],
  () => { void scrollToLatest() },
)

watch(() => props.caseId, () => {
  stopBot()
  restoreBotTurns()
  loadBotAnswered()
  void scrollToLatest(true)
})

onMounted(() => {
  restoreBotTurns()
  loadBotAnswered()
  void scrollToLatest(true)
})
</script>

<template>
  <aside class="live-dialogue-panel">
    <header class="live-dialogue-header">
      <div>
        <span class="panel-kicker">原文 / 实时转写</span>
        <h2>实时语音对话</h2>
      </div>
      <div class="live-dialogue-actions">
        <button
          class="bot-toggle"
          :class="{ active: botActive, judging: botJudging || botGenerating }"
          :title="botActive ? '停止 BOT 民警' : 'BOT 扮演民警自动提问（测试用）'"
          @click="toggleBot"
        >{{ botActive ? (botGenerating ? 'BOT 生成中…' : botJudging ? 'BOT 判定中…' : 'BOT 提问中') : 'BOT' }}</button>
        <button
          class="capture-toggle"
          :class="{ active: captureRunning }"
          :disabled="captureBusy || !captureAvailable"
          @click="emit('captureToggle')"
        >
          <span class="record-dot"></span>
          {{ captureRunning ? `停止录音 ${elapsed}` : '开始录音' }}
        </button>
      </div>
    </header>

    <div ref="feed" class="dialogue-feed" @scroll="onFeedScroll">
      <details v-if="qaReviewUnits.length || qaResolvedUnits.length" class="qa-review-rail" aria-label="Qwen 正式笔录路由状态">
        <summary>笔录归档处理（{{ qaReviewUnits.length }} 项待处理）</summary>
        <article v-for="unit in qaReviewUnits" :key="unit.id" class="qa-review-card">
          <header><span class="qa-status-chip">待处理</span><small>{{ unit.reasonCode || 'NEEDS_REVIEW' }}</small></header>
          <p v-if="unit.rawQuestionText"><b>原始问：</b>{{ unit.rawQuestionText }}</p>
          <p v-if="unit.rawAnswerText"><b>原始答：</b>{{ unit.rawAnswerText }}</p>
          <p v-if="unit.aiSuggestedQuestionText" class="qa-suggestion"><b>AI 建议问：</b>{{ unit.aiSuggestedQuestionText }}</p>
          <p v-if="unit.aiSuggestedAnswerText" class="qa-suggestion"><b>AI 建议答：</b>{{ unit.aiSuggestedAnswerText }}</p>
          <div class="qa-review-actions">
            <button draggable="true" @dragstart="startWholeQaDrag($event, unit)">拖动整组问答</button>
            <button v-if="unit.answerFragmentIds.length" draggable="true" @dragstart="startAnswerDrag($event, unit)">仅拖动答案</button>
            <button class="qa-ignore" @click="resolveQa(unit, { action: 'IGNORE' })">忽略</button>
          </div>
        </article>
        <div v-for="unit in qaResolvedUnits" :key="`status-${unit.id}`" class="qa-routing-status" :class="{ 'qa-status-muted': unit.status === 'IGNORED' || unit.status === 'ROLLED_BACK' || unit.classification === 'IGNORE' }">
           <span>{{ qaStatusLabel(unit) }}</span>
           <small v-if="unit.rawQuestionText">{{ unit.rawQuestionText }}</small>
           <button v-if="unit.status === 'APPLIED'" class="qa-rollback" @click="rollbackQa(unit)">回退本次匹配</button>
        </div>
      </details>
      <div v-if="!visibleDialogue.length && !partialText" class="dialogue-empty">
        <strong>等待现场对话</strong>
        <p>原始转写会先显示在这里；说话人归属完成后自动补上姓名。</p>
      </div>

      <template v-for="turn in visibleDialogue" :key="turn.key">
        <article
          class="dialogue-turn"
          :class="[`side-${dialoguePresentation(turn.primary).side}`, { 'pending-draggable': !!pendingFor(turn.primary.id) }]"
          :data-fragment-id="turn.primary.id"
          :draggable="!!pendingFor(turn.primary.id)"
          @dragstart="startPendingDrag($event, turn.primary.id)"
        >
          <div class="dialogue-meta">
            <span>{{ dialoguePresentation(turn.primary).badge }}</span>
            <time>{{ formatTime(turn.primary) }}</time>
          </div>
          <div class="dialogue-bubble"><strong v-if="speakerPrefix(turn.primary)" class="speaker-prefix">{{ speakerPrefix(turn.primary) }}</strong>{{ turn.text }}</div>

          <template v-for="item in turn.fragments" :key="item.id">
            <details v-if="item.recognitionEvidence" class="recognition-evidence-card">
              <summary>查看识别依据<span v-if="turn.fragments.length > 1">（第 {{ turn.fragments.indexOf(item) + 1 }} 段）</span></summary>

            <div class="evidence-grid">
              <div><small>AI 原判</small><strong>{{ speakerLabel(item.recognitionEvidence.aiSpeaker) }}</strong></div>
              <div><small>Score</small><strong>{{ scoreText(item.recognitionEvidence.score) }}</strong></div>
              <div><small>第二候选</small><strong>{{ scoreText(item.recognitionEvidence.secondBestScore) }}</strong></div>
              <div><small>Threshold</small><strong>{{ scoreText(item.recognitionEvidence.threshold) }}</strong></div>
              <div><small>Margin</small><strong>{{ scoreText(item.recognitionEvidence.margin) }}</strong></div>
              <div><small>阈值来源</small><strong>{{ thresholdSourceLabel(item.recognitionEvidence.thresholdSource) }}</strong></div>
              <div><small>声纹模型</small><strong>{{ item.recognitionEvidence.speakerModelId || 'eres2net_large' }} {{ item.recognitionEvidence.speakerModelVersion || '—' }}</strong></div>
              <div><small>ASR 模型</small><strong>{{ item.recognitionEvidence.asrModelId || '—' }} {{ item.recognitionEvidence.asrModelVersion || '' }}</strong></div>
              <div><small>校准状态</small><strong>{{ item.recognitionEvidence.calibrationStatus || '—' }}</strong></div>
              <div><small>模型指纹</small><strong>{{ shortFingerprint(item.recognitionEvidence.speakerModelFingerprint) }}</strong></div>
              <div><small>麦克风指纹</small><strong>{{ shortFingerprint(item.recognitionEvidence.microphoneFingerprint) }}</strong></div>
              <div><small>证据时间</small><strong>{{ formatDate(item.recognitionEvidence.createdAt) }}</strong></div>
            </div>

            <div v-if="item.recognitionRevisions.length" class="revision-history">
              <h4>人工修正历史</h4>
              <div v-for="revision in item.recognitionRevisions" :key="revision.revisionId" class="revision-row">
                <strong>#{{ revision.revisionNo }}</strong>
                <span>{{ speakerLabel(revision.beforeSpeaker) }} → {{ speakerLabel(revision.afterSpeaker) }}</span>
                <span>{{ revision.reason || '未填写原因' }}</span>
                <span>{{ revision.actorId || '未记录人员' }}</span>
                <time>{{ formatDate(revision.createdAt) }}</time>
              </div>
            </div>

            <div v-if="item.state !== 'CONFIRMED'" class="recognition-correction">
              <h4>人工修正</h4>
              <p>修正只改变当前工作结果；上方 AI 原判、分数和模型证据永久保留。</p>
              <div class="correction-controls">
                <select
                  :value="correctionRole(item)"
                  @change="correctionSpeaker[item.id] = ($event.target as HTMLSelectElement).value as TemporaryAsrSpeaker"
                >
                  <option value="SUSPECT">嫌疑人</option>
                  <option value="INTERROGATOR">主审民警</option>
                  <option value="RECORDER">记录民警</option>
                  <option value="UNKNOWN">未知人员</option>
                </select>
                <input
                  v-model="correctionReason[item.id]"
                  placeholder="填写人工修正原因（必填）"
                  maxlength="512"
                />
                <button
                  class="correction-submit"
                  :disabled="!(correctionReason[item.id] || '').trim()"
                  @click="submitCorrection(item)"
                >保存修正</button>
              </div>
            </div>
            </details>

            <div v-else-if="!isBotFragment(item)" class="recognition-evidence-missing">
              识别证据尚未独立入库（历史数据迁移后将自动补齐）
            </div>
          </template>

          <section v-if="pendingFor(turn.primary.id)" class="pending-resolution-card">
            <template v-if="pendingFor(turn.primary.id)?.matchStatus === 'UNMATCHED'">
              <p>未匹配正式笔录问题 · 可直接拖到左侧正式笔录指定位置</p>
              <div class="pending-actions">
                <button class="primary" @click="resolve(pendingFor(turn.primary.id)!, { action: 'ADD' })">加入本案笔录</button>
                <button @click="resolve(pendingFor(turn.primary.id)!, { action: 'IGNORE' })">忽略</button>
              </div>
            </template>

            <template v-else-if="pendingFor(turn.primary.id)?.matchStatus === 'AMBIGUOUS'">
              <p>可能对应多个正式问题，请人工确认</p>
              <div class="candidate-list">
                <button
                  v-for="candidate in candidateQuestions(pendingFor(turn.primary.id)!)"
                  :key="candidate.id"
                  @click="resolve(pendingFor(turn.primary.id)!, { action: 'LINK', caseQuestionId: candidate.id, roundMode: 'NEW_ROUND' })"
                >
                  对应：{{ candidate.text }}
                </button>
              </div>
              <div class="pending-actions">
                <button class="primary" @click="resolve(pendingFor(turn.primary.id)!, { action: 'ADD' })">新建本案问题</button>
                <button @click="resolve(pendingFor(turn.primary.id)!, { action: 'IGNORE' })">忽略</button>
              </div>
            </template>

            <template v-else-if="pendingFor(turn.primary.id)?.matchStatus === 'MATCHED_EXISTING'">
              <p>该问题已在本案笔录中出现，请选择本次问答如何记录</p>
              <div class="pending-actions">
                <button
                  v-if="pendingFor(turn.primary.id)!.candidateQuestionIds[0]"
                  class="primary"
                  @click="resolve(pendingFor(turn.primary.id)!, { action: 'LINK', caseQuestionId: pendingFor(turn.primary.id)!.candidateQuestionIds[0], roundMode: 'APPEND_EXISTING' })"
                >追加到原回答</button>
                <button
                  v-if="pendingFor(turn.primary.id)!.candidateQuestionIds[0]"
                  @click="resolve(pendingFor(turn.primary.id)!, { action: 'LINK', caseQuestionId: pendingFor(turn.primary.id)!.candidateQuestionIds[0], roundMode: 'NEW_ROUND' })"
                >新增一轮问答</button>
              </div>
            </template>
          </section>
        </article>
      </template>

      <article v-if="captureRunning" class="dialogue-turn side-left partial-turn" :class="{ idle: !partialText }">
        <div class="dialogue-meta"><span>{{ partialText ? '正在转写' : '待输入' }}</span></div>
        <div class="dialogue-bubble">{{ partialText || '（待输入…请说话）' }}</div>
      </article>
    </div>

    <button v-if="!pinnedToBottom" class="latest-button" @click="scrollToLatest(true)">↓ 最新消息</button>
  </aside>
</template>

<style scoped>
.recognition-evidence-card {
  margin-top: 4px;
  border: 0;
  background: transparent;
  font-size: 11px;
}
.recognition-evidence-card summary {
  cursor: pointer;
  padding: 2px 4px;
  color: #728194;
}
.speaker-prefix { color: #173f69; }
.evidence-title { font-weight: 700; color: #23384d; }
.evidence-store-badge {
  padding: 2px 6px;
  border-radius: 999px;
  background: #e6f6ed;
  color: #246a45;
  font-weight: 700;
}
.evidence-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 7px;
  padding: 9px 10px;
  border-top: 1px solid rgba(76, 112, 156, .16);
}
.partial-turn .dialogue-bubble { border-style: solid; }
.partial-turn.idle .dialogue-bubble { opacity: .4; }
.evidence-grid div { display: flex; flex-direction: column; gap: 2px; min-width: 0; }
.evidence-grid small { color: #728194; }
.evidence-grid strong { color: #27394b; overflow-wrap: anywhere; }
.revision-history,
.recognition-correction {
  margin: 0 10px 10px;
  padding-top: 9px;
  border-top: 1px solid rgba(76, 112, 156, .16);
}
.revision-history h4,
.recognition-correction h4 { margin: 0 0 6px; font-size: 12px; color: #27394b; }
.revision-row {
  display: grid;
  grid-template-columns: auto 1fr 1.4fr 1fr auto;
  gap: 6px;
  padding: 5px 0;
  color: #586879;
}
.recognition-correction p { margin: 0 0 7px; color: #6a7785; }
.correction-controls { display: grid; grid-template-columns: 120px 1fr auto; gap: 6px; }
.correction-controls select,
.correction-controls input {
  min-width: 0;
  border: 1px solid #cbd5df;
  border-radius: 7px;
  padding: 6px 8px;
  background: #fff;
}
.correction-submit {
  border: 0;
  border-radius: 7px;
  padding: 6px 10px;
  background: #315f8d;
  color: white;
  cursor: pointer;
}
.correction-submit:disabled { opacity: .45; cursor: not-allowed; }
.recognition-evidence-missing {
  margin-top: 7px;
  padding: 6px 8px;
  border-radius: 7px;
  background: #fff4dd;
  color: #8a6219;
  font-size: 11px;
}
@media (max-width: 900px) {
  .evidence-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .revision-row { grid-template-columns: auto 1fr; }
  .correction-controls { grid-template-columns: 1fr; }
}
.qa-review-rail { margin-bottom: 10px; color: #647587; font-size: 12px; }
.qa-review-rail summary { cursor: pointer; padding: 4px 2px; }
.qa-review-rail[open] { display: grid; gap: 8px; }
.qa-review-card { border: 1px solid #d5a73f; background: #fff9e8; border-radius: 10px; padding: 10px; }
.qa-review-card header { display: flex; justify-content: space-between; gap: 8px; align-items: center; }
.qa-review-card p { margin: 6px 0; line-height: 1.45; }
.qa-status-chip { display: inline-flex; padding: 2px 8px; border-radius: 999px; background: #f3c760; color: #5b4308; font-weight: 800; }
.qa-suggestion { color: #536274; }
.qa-review-actions { display: flex; gap: 6px; flex-wrap: wrap; margin-top: 8px; }
.qa-review-actions button { cursor: grab; }
.qa-review-actions .qa-ignore { cursor: pointer; }
.qa-routing-status { display: flex; gap: 8px; align-items: center; padding: 6px 8px; border-radius: 8px; background: #edf6ef; color: #2d6040; font-size: 12px; }
.qa-routing-status small { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.qa-rollback { margin-left: auto; border: 1px solid #d6a33a; border-radius: 6px; padding: 3px 7px; background: #fff; color: #815d13; cursor: pointer; }
.qa-status-muted { background: #f2f3f5; color: #7a8088; opacity: .78; }
.raw-fragment-list { display: grid; gap: 6px; padding: 9px 10px; border-top: 1px solid rgba(76, 112, 156, .16); }
.raw-fragment-list div { display: grid; gap: 2px; }
.raw-fragment-list strong { color: #334b62; }
.raw-fragment-list small { color: #728194; }
</style>
