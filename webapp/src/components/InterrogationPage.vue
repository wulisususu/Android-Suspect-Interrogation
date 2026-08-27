<script setup lang="ts">
import { computed, nextTick, reactive, ref, watch } from 'vue'
import {
  backendErrorMessage,
  finishSession,
  markTranscriptMessage,
  persistQuestionOrAnswer,
  updateTranscriptMessage,
} from '../api/interrogation'
import {
  fetchDocumentSigningState,
  freezeDocument,
  signDocument,
} from '../api/documentSigning'
import { temporarySpeakerPresentation } from './VoiceprintPreparationPanel.vue'
import type {
  AsrCaptureStatus,
  AsrInsertionReceipt,
  AsrInsertionTarget,
  CaseSummary,
  DocumentSignerRole,
  DocumentSigningState,
  FactItem,
  SessionState,
  TemporaryAsrFragment,
  TranscriptMessage,
} from '../types/interrogation'

const props = defineProps<{
  caseId: string
  summary: CaseSummary
  facts: FactItem[]
  session: SessionState
  messages: TranscriptMessage[]
  capture: AsrCaptureStatus
  canRecord: boolean
  nativeCaptureAvailable: boolean
  captureBusy: boolean
  captureElapsedMs: number
  aiBusy: boolean
  aiError: string
  captureInsertionReceipt?: AsrInsertionReceipt | null
}>()
const emit = defineEmits<{
  saved: []
  captureStart: []
  captureStop: [target?: AsrInsertionTarget]
  generateAi: []
}>()

type EntryRole = '民警' | '嫌疑人'
type QaPair = { question?: TranscriptMessage; answer?: TranscriptMessage }
type SignaturePoint = { x: number; y: number; t: number; p: number }

const text = ref('')
const entryRole = ref<EntryRole>('嫌疑人')
const saving = ref(false)
const localError = ref('')
const editingIds = ref<string[]>([])
const drafts = reactive<Record<string, string>>({})
const signingState = ref<DocumentSigningState | null>(null)
const signingBusy = ref('')
const signatureRole = ref<DocumentSignerRole | null>(null)
const signatureCanvas = ref<HTMLCanvasElement | null>(null)
const signatureStrokes = ref<SignaturePoint[][]>([])
const insertionTarget = ref<AsrInsertionTarget | null>(null)
const recordingTarget = ref<AsrInsertionTarget | null>(null)
const pageRoot = ref<HTMLElement | null>(null)
let activeStroke: SignaturePoint[] | null = null

const formalRecords = computed(() => props.messages.filter((item) => item.speaker !== 'AI'))
const qaPairs = computed<QaPair[]>(() => {
  const pairs: QaPair[] = []
  let current: QaPair | null = null

  for (const record of formalRecords.value) {
    if (record.speaker === '民警') {
      if (current?.question || current?.answer) pairs.push(current)
      current = { question: record }
      continue
    }

    if (record.speaker === '嫌疑人') {
      if (!current) current = {}
      if (current.answer) {
        pairs.push(current)
        current = {}
      }
      current.answer = record
      pairs.push(current)
      current = null
    }
  }

  if (current?.question || current?.answer) pairs.push(current)
  return pairs
})
const elapsed = computed(() => {
  const total = Math.floor(props.captureElapsedMs / 1000)
  return `${String(Math.floor(total / 60)).padStart(2, '0')}:${String(total % 60).padStart(2, '0')}`
})
const isDemo = computed(() => props.caseId.startsWith('CASE-DEMO-'))
const documentFrozen = computed(() => !!signingState.value)
const documentLocked = computed(() => signingState.value?.status === 'LOCKED')
const currentQuestion = computed(() => [...formalRecords.value].reverse().find((item) => item.speaker === '民警')?.text || '等待民警提出问题')
const answeredCount = computed(() => qaPairs.value.filter((item) => item.answer).length)
const conflictCount = computed(() => formalRecords.value.filter((item) => item.mark === 'conflict').length)
const sessionStatusText = computed(() => ({ READY: '待开始', RUNNING: '审讯中', PAUSED: '已暂停', COMPLETED: '已结束' }[props.session.status] || props.session.status))

watch(
  () => props.messages,
  (items) => {
    items.forEach((item) => {
      if (!(item.id in drafts) || !editingIds.value.includes(item.id)) drafts[item.id] = item.text
    })
  },
  { immediate: true, deep: true },
)

watch(
  () => props.caseId,
  () => {
    insertionTarget.value = null
    recordingTarget.value = null
    void loadSigningState()
  },
  { immediate: true },
)

watch(
  () => props.captureInsertionReceipt,
  async (receipt) => {
    if (!receipt || receipt.caseId !== props.caseId) return
    await nextTick()
    const inputs = pageRoot.value?.querySelectorAll<HTMLTextAreaElement>('[data-record-id]') ?? []
    const input = Array.from(inputs).find((item) => item.dataset.recordId === receipt.recordId)
    if (!input) return
    input.focus()
    input.setSelectionRange(receipt.caretPosition, receipt.caretPosition)
    insertionTarget.value = {
      caseId: props.caseId,
      recordId: receipt.recordId,
      selectionStart: receipt.caretPosition,
      selectionEnd: receipt.caretPosition,
      sourceText: input.value,
    }
    recordingTarget.value = null
  },
)

function headerFact(key: string, fallback = '') {
  const value = props.facts.find((item) => item.key === key)?.value?.trim()
  if (!value || value === '未录入') return fallback
  return value
}

function formatSignedAt(value?: number) {
  if (!value) return ''
  return new Intl.DateTimeFormat('zh-CN', {
    year: 'numeric', month: '2-digit', day: '2-digit',
    hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false,
  }).format(new Date(value))
}

function rowsFor(value: string | undefined, minimum = 2) {
  const textValue = value || ''
  const visualLines = textValue.split('\n').reduce((sum, line) => sum + Math.max(1, Math.ceil(line.length / 42)), 0)
  return Math.max(minimum, Math.min(10, visualLines))
}

function fragmentSpeakerPresentation(fragment: TemporaryAsrFragment) {
  if (fragment.lowConfidence) return temporarySpeakerPresentation('UNKNOWN')
  return temporarySpeakerPresentation(fragment.speaker, fragment.speakerName)
}

function markEditing(id: string, editing: boolean) {
  if (editing && !editingIds.value.includes(id)) editingIds.value.push(id)
  if (!editing) editingIds.value = editingIds.value.filter((item) => item !== id)
}

function rememberInsertionTarget(item: TranscriptMessage, event: Event) {
  if (props.capture.running || props.captureBusy || documentFrozen.value) return
  const input = event.currentTarget as HTMLTextAreaElement
  insertionTarget.value = {
    caseId: props.caseId,
    recordId: item.id,
    selectionStart: input.selectionStart ?? input.value.length,
    selectionEnd: input.selectionEnd ?? input.value.length,
    sourceText: input.value,
  }
}

function focusRecordEditor(item: TranscriptMessage, event: FocusEvent) {
  markEditing(item.id, true)
  rememberInsertionTarget(item, event)
}

async function loadSigningState() {
  if (!props.caseId) {
    signingState.value = null
    return
  }
  try {
    signingState.value = await fetchDocumentSigningState(props.caseId)
  } catch (err) {
    localError.value = backendErrorMessage(err)
  }
}

async function saveEdit(item?: TranscriptMessage) {
  if (!item || editingIds.value.includes(`saving:${item.id}`)) return
  if (documentFrozen.value) {
    drafts[item.id] = item.text
    localError.value = '笔录已经冻结，不能继续修改正式问答。'
    return
  }
  const nextText = (drafts[item.id] || '').trim()
  markEditing(item.id, false)
  if (!nextText || nextText === item.text.trim()) {
    drafts[item.id] = item.text
    return
  }

  editingIds.value.push(`saving:${item.id}`)
  localError.value = ''
  try {
    await updateTranscriptMessage(props.caseId, item.id, nextText)
    emit('saved')
  } catch (err) {
    drafts[item.id] = item.text
    localError.value = backendErrorMessage(err)
  } finally {
    editingIds.value = editingIds.value.filter((id) => id !== `saving:${item.id}`)
  }
}

async function toggleConflict(item: TranscriptMessage) {
  if (documentFrozen.value) return
  localError.value = ''
  try {
    await markTranscriptMessage(props.caseId, item.id, item.mark === 'conflict' ? '' : 'conflict')
    emit('saved')
  } catch (err) {
    localError.value = backendErrorMessage(err)
  }
}

async function appendRecord() {
  const clean = text.value.trim()
  if (!clean || saving.value) return
  if (documentFrozen.value) {
    localError.value = '笔录已经冻结，不能继续新增正式问答。'
    return
  }
  if (!props.canRecord) {
    localError.value = '当前审讯未处于可记录状态。请先使用上方“开始审讯/恢复”按钮。'
    return
  }
  saving.value = true
  localError.value = ''
  try {
    await persistQuestionOrAnswer(props.caseId, clean, entryRole.value)
    text.value = ''
    emit('saved')
  } catch (err) {
    localError.value = backendErrorMessage(err)
  } finally {
    saving.value = false
  }
}

function toggleCapture() {
  if (documentFrozen.value) {
    localError.value = '笔录已经冻结，不能继续录音。'
    return
  }
  localError.value = ''
  recordingTarget.value = null
  if (props.capture.running) {
    emit('captureStop', undefined)
    return
  }
  emit('captureStart')
}

async function finishAndFreeze() {
  if (signingBusy.value || documentFrozen.value) return
  if (props.capture.running) {
    localError.value = '请先停止当前录音，再结束审讯并冻结笔录。'
    return
  }
  signingBusy.value = 'freeze'
  localError.value = ''
  try {
    if (props.session.status !== 'COMPLETED') await finishSession(props.caseId)
    signingState.value = await freezeDocument(props.caseId)
    emit('saved')
  } catch (err) {
    localError.value = backendErrorMessage(err)
  } finally {
    signingBusy.value = ''
  }
}

function signatureFor(role: DocumentSignerRole) {
  return signingState.value?.signatures.find((item) => item.signerRole === role)
}

function signerName(role: DocumentSignerRole) {
  return role === 'SUSPECT' ? (props.summary.suspectName || '被询问人') : (props.summary.officerName || '询问人')
}

async function openSignature(role: DocumentSignerRole) {
  if (!signingState.value) {
    localError.value = '请先结束审讯并冻结询问笔录。'
    return
  }
  if (!signingState.value.integrityValid) {
    localError.value = '当前冻结版本完整性校验失败，不能继续签名。'
    return
  }
  if (signatureFor(role)) return
  signatureRole.value = role
  signatureStrokes.value = []
  activeStroke = null
  await nextTick()
  prepareCanvas()
}

function closeSignature() {
  if (signingBusy.value === 'sign') return
  signatureRole.value = null
  signatureStrokes.value = []
  activeStroke = null
}

function prepareCanvas() {
  const canvas = signatureCanvas.value
  if (!canvas) return
  const rect = canvas.getBoundingClientRect()
  const ratio = Math.max(1, window.devicePixelRatio || 1)
  canvas.width = Math.max(1, Math.round(rect.width * ratio))
  canvas.height = Math.max(1, Math.round(rect.height * ratio))
  const ctx = canvas.getContext('2d')
  if (!ctx) return
  ctx.setTransform(ratio, 0, 0, ratio, 0, 0)
  ctx.clearRect(0, 0, rect.width, rect.height)
  ctx.lineCap = 'round'
  ctx.lineJoin = 'round'
  ctx.strokeStyle = '#111'
}

function pointFromEvent(event: PointerEvent): SignaturePoint {
  const rect = signatureCanvas.value?.getBoundingClientRect()
  return {
    x: event.clientX - (rect?.left || 0),
    y: event.clientY - (rect?.top || 0),
    t: Date.now(),
    p: event.pressure || 0.5,
  }
}

function drawSegment(from: SignaturePoint, to: SignaturePoint) {
  const ctx = signatureCanvas.value?.getContext('2d')
  if (!ctx) return
  ctx.lineWidth = 1.7 + Math.min(1, to.p || 0.5) * 1.8
  ctx.beginPath()
  ctx.moveTo(from.x, from.y)
  ctx.lineTo(to.x, to.y)
  ctx.stroke()
}

function startSignatureStroke(event: PointerEvent) {
  if (!signatureCanvas.value) return
  signatureCanvas.value.setPointerCapture(event.pointerId)
  const point = pointFromEvent(event)
  activeStroke = [point]
  signatureStrokes.value.push(activeStroke)
}

function moveSignatureStroke(event: PointerEvent) {
  if (!activeStroke) return
  const next = pointFromEvent(event)
  const previous = activeStroke[activeStroke.length - 1]
  activeStroke.push(next)
  drawSegment(previous, next)
}

function endSignatureStroke(event: PointerEvent) {
  if (signatureCanvas.value?.hasPointerCapture(event.pointerId)) {
    signatureCanvas.value.releasePointerCapture(event.pointerId)
  }
  activeStroke = null
}

function clearSignature() {
  signatureStrokes.value = []
  activeStroke = null
  prepareCanvas()
}

async function confirmSignature() {
  const role = signatureRole.value
  const canvas = signatureCanvas.value
  const hasInk = signatureStrokes.value.some((stroke) => stroke.length > 1)
  if (!role || !canvas || !hasInk) {
    localError.value = '请先在签名区域完成手写签名。'
    return
  }

  signingBusy.value = 'sign'
  localError.value = ''
  try {
    const imageDataUrl = canvas.toDataURL('image/png')
    signingState.value = await signDocument(
      props.caseId,
      role,
      signerName(role),
      imageDataUrl,
      JSON.stringify(signatureStrokes.value),
    )
    signatureRole.value = null
    signatureStrokes.value = []
    emit('saved')
  } catch (err) {
    localError.value = backendErrorMessage(err)
  } finally {
    signingBusy.value = ''
  }
}
</script>

<template>
  <section ref="pageRoot" class="interrogation-page workbench-mode">
    <div class="interrogation-grid">
      <aside class="subject-panel">
        <header class="panel-title">
          <span>案件信息</span>
          <strong>{{ sessionStatusText }}</strong>
        </header>
        <div class="subject-photo">人员<br />信息</div>
        <h2>{{ summary.suspectName || '待录入人员' }}</h2>
        <dl>
          <div><dt>案件编号</dt><dd>{{ summary.id || caseId }}</dd></div>
          <div><dt>性别</dt><dd>{{ summary.gender || '未录入' }}</dd></div>
          <div><dt>民族</dt><dd>{{ summary.nation || '未录入' }}</dd></div>
          <div><dt>出生日期</dt><dd>{{ summary.birthDate || '未录入' }}</dd></div>
          <div class="full"><dt>身份证号</dt><dd>{{ summary.idNumber || '未录入' }}</dd></div>
          <div class="full"><dt>住址</dt><dd>{{ summary.address || headerFact('current_address', '未录入') }}</dd></div>
          <div class="full"><dt>主审民警</dt><dd>{{ summary.officerName || '当前警官' }}</dd></div>
        </dl>
        <div class="subject-stats">
          <div><strong>{{ qaPairs.length }}</strong><span>问答轮次</span></div>
          <div><strong>{{ answeredCount }}</strong><span>已回答</span></div>
          <div><strong>{{ conflictCount }}</strong><span>矛盾标记</span></div>
        </div>
        <div v-if="isDemo" class="demo-chip">模拟案件</div>
      </aside>

      <main class="conversation-panel">
        <header class="conversation-header">
          <div>
            <span class="section-kicker">审讯记录</span>
            <h1>问答工作区</h1>
          </div>
          <div class="conversation-status" :class="session.status.toLowerCase()">
            <span></span>{{ sessionStatusText }}
          </div>
        </header>

        <div class="conversation-scroll">
          <div v-if="!qaPairs.length && !capture.partialText && !capture.fragments.length" class="conversation-empty">
            <strong>尚未开始记录问答</strong>
            <p>使用上方“开始审讯”后，可手工录入问答；语音识别先进入待确认片段，人工确认后才写入正式笔录。</p>
          </div>

          <section v-for="(pair, index) in qaPairs" :key="`${pair.question?.id || 'q'}-${pair.answer?.id || 'a'}-${index}`" class="qa-turn">
            <div class="turn-index">{{ String(index + 1).padStart(2, '0') }}</div>

            <article v-if="pair.question" class="speech-row officer" :class="{ conflict: pair.question.mark === 'conflict' }">
              <div class="role-badge">问</div>
              <div class="speech-content">
                <div class="speech-meta"><strong>民警</strong><span>Q{{ pair.question.seq || index + 1 }}</span></div>
                <textarea
                  v-model="drafts[pair.question.id]"
                  class="record-editor"
                  :class="{ locked: documentFrozen }"
                  :data-record-id="pair.question.id"
                  :disabled="documentFrozen"
                  :rows="rowsFor(drafts[pair.question.id], 2)"
                  aria-label="民警问题，可编辑"
                  @focus="focusRecordEditor(pair.question, $event)"
                  @click="rememberInsertionTarget(pair.question, $event)"
                  @keyup="rememberInsertionTarget(pair.question, $event)"
                  @select="rememberInsertionTarget(pair.question, $event)"
                  @input="rememberInsertionTarget(pair.question, $event)"
                  @blur="saveEdit(pair.question)"
                ></textarea>
                <div class="record-actions">
                  <span>点击正文可修订正式笔录</span>
                  <button :disabled="documentFrozen" @click="toggleConflict(pair.question)">{{ pair.question.mark === 'conflict' ? '取消标记' : '标记矛盾' }}</button>
                </div>
              </div>
            </article>

            <article v-if="pair.answer" class="speech-row suspect" :class="{ conflict: pair.answer.mark === 'conflict' }">
              <div class="role-badge">答</div>
              <div class="speech-content">
                <div class="speech-meta"><strong>{{ summary.suspectName || '被询问人' }}</strong><span>A{{ pair.answer.seq || index + 1 }}</span></div>
                <textarea
                  v-model="drafts[pair.answer.id]"
                  class="record-editor answer-editor"
                  :class="{ locked: documentFrozen }"
                  :data-record-id="pair.answer.id"
                  :disabled="documentFrozen"
                  :rows="rowsFor(drafts[pair.answer.id], 3)"
                  aria-label="嫌疑人回答，可编辑"
                  @focus="focusRecordEditor(pair.answer, $event)"
                  @click="rememberInsertionTarget(pair.answer, $event)"
                  @keyup="rememberInsertionTarget(pair.answer, $event)"
                  @select="rememberInsertionTarget(pair.answer, $event)"
                  @input="rememberInsertionTarget(pair.answer, $event)"
                  @blur="saveEdit(pair.answer)"
                ></textarea>
                <div class="record-actions">
                  <span>{{ pair.answer.mark === 'conflict' ? '已标记：存在矛盾' : '正式回答' }}</span>
                  <button :disabled="documentFrozen" @click="toggleConflict(pair.answer)">{{ pair.answer.mark === 'conflict' ? '取消标记' : '标记矛盾' }}</button>
                </div>
              </div>
            </article>
          </section>

          <section v-if="capture.fragments.length || capture.partialText" class="voice-draft-section">
            <header><strong>语音转写暂存区</strong><span>未确认内容不会冒充正式笔录</span></header>
            <div
              v-for="fragment in capture.fragments"
              :key="fragment.id"
              class="voice-draft-row"
              :class="{ 'needs-confirmation': fragmentSpeakerPresentation(fragment).needsConfirmation }"
            >
              <div class="voice-draft-meta">
                <strong>{{ fragmentSpeakerPresentation(fragment).label }}</strong>
                <span>{{ fragmentSpeakerPresentation(fragment).detail }}</span>
                <b v-if="fragmentSpeakerPresentation(fragment).needsConfirmation">待确认</b>
                <small v-else-if="fragment.voiceprintVerified">声纹已验证</small>
                <small v-else>身份未由民警声纹验证</small>
              </div>
              <p>{{ fragment.editedText || fragment.rawText || '等待识别文本……' }}</p>
            </div>
            <div v-if="capture.partialText" class="voice-live-row"><b>实时：</b>{{ capture.partialText }}</div>
          </section>
        </div>

        <div v-if="localError || aiError || capture.error" class="interrogation-error workbench-error">
          {{ localError || aiError || capture.error }}
        </div>

        <footer v-if="!documentFrozen" class="interrogation-composer">
          <button
            class="record-button"
            :class="{ active: capture.running }"
            :disabled="captureBusy || !nativeCaptureAvailable || (!canRecord && !capture.running)"
            :title="nativeCaptureAvailable ? '开始 / 停止离线连续录音；识别片段需人工确认' : '连续离线录音 Runtime 当前不可用'"
            @click="toggleCapture"
          >
            <span class="record-dot">●</span>
            {{ capture.running ? `停止 ${elapsed}` : '录音' }}
          </button>

          <div class="role-switch" aria-label="新增记录角色">
            <button :class="{ active: entryRole === '民警' }" @click="entryRole = '民警'">民警问</button>
            <button :class="{ active: entryRole === '嫌疑人' }" @click="entryRole = '嫌疑人'">嫌疑人答</button>
          </div>

          <textarea
            v-model="text"
            :disabled="!canRecord || saving"
            rows="2"
            :placeholder="entryRole === '民警' ? '输入当前询问问题…' : '输入被询问人回答…'"
            @keydown.ctrl.enter.prevent="appendRecord"
          ></textarea>
          <button class="send-record-button" :disabled="!text.trim() || !canRecord || saving" @click="appendRecord">
            {{ saving ? '保存中…' : '发送并记录' }}
          </button>
        </footer>
      </main>

      <aside class="operation-panel">
        <section class="current-question-card">
          <span>当前问题</span>
          <strong>{{ currentQuestion }}</strong>
        </section>

        <section class="asr-live-card" :class="{ active: capture.running }">
          <header><span class="mic-dot">●</span><strong>实时语音识别</strong></header>
          <p>{{ capture.partialText || (capture.running ? '正在监听，请开始讲话…' : '录音未启动') }}</p>
          <small>{{ capture.running ? `已录音 ${elapsed}` : nativeCaptureAvailable ? 'ASR / 麦克风 Runtime 已检测' : 'ASR / 麦克风 Runtime 未就绪' }}</small>
        </section>

        <section class="operation-actions">
          <button :disabled="aiBusy" @click="$emit('generateAi')">{{ aiBusy ? 'AI 梳理中…' : '案件 AI 梳理' }}</button>
          <button class="freeze-button" :disabled="!!signingBusy || documentFrozen || capture.running" @click="finishAndFreeze">
            {{ signingBusy === 'freeze' ? '正在冻结…' : session.status === 'COMPLETED' ? '冻结笔录并签名' : '结束并进入签名' }}
          </button>
        </section>

        <section class="signing-panel">
          <header><strong>笔录确认 / 签名</strong><span>{{ documentLocked ? '已锁定' : documentFrozen ? '已冻结' : '未冻结' }}</span></header>
          <div v-if="!signingState" class="signing-placeholder">结束审讯后冻结当前版本，系统计算 SHA-256，再进行双方手写签名。</div>
          <template v-else>
            <div class="integrity-state" :class="{ invalid: !signingState.integrityValid }">
              <b>V{{ signingState.version }}</b>
              <span>{{ signingState.integrityValid ? '完整性校验通过' : '完整性校验失败' }}</span>
              <small>{{ signingState.documentHash }}</small>
            </div>
            <article class="mini-signature">
              <div><strong>被询问人</strong><span>{{ summary.suspectName || '被询问人' }}</span></div>
              <img v-if="signatureFor('SUSPECT')" :src="signatureFor('SUSPECT')?.imageDataUrl" alt="被询问人电子签名" />
              <button v-else :disabled="!signingState.integrityValid || !!signingBusy" @click="openSignature('SUSPECT')">手写签名</button>
              <small v-if="signatureFor('SUSPECT')">{{ formatSignedAt(signatureFor('SUSPECT')?.signedAt) }}</small>
            </article>
            <article class="mini-signature">
              <div><strong>询问人</strong><span>{{ summary.officerName || '询问人' }}</span></div>
              <img v-if="signatureFor('OFFICER')" :src="signatureFor('OFFICER')?.imageDataUrl" alt="询问人民警电子签名" />
              <button v-else :disabled="!signingState.integrityValid || !!signingBusy" @click="openSignature('OFFICER')">手写签名</button>
              <small v-if="signatureFor('OFFICER')">{{ formatSignedAt(signatureFor('OFFICER')?.signedAt) }}</small>
            </article>
            <p v-if="documentLocked" class="locked-notice">双方签名完成，当前版本已锁定。</p>
          </template>
        </section>
      </aside>
    </div>

    <div v-if="signatureRole" class="signature-modal-backdrop" @click.self="closeSignature">
      <section class="signature-modal" role="dialog" aria-modal="true" aria-label="电子签名">
        <header>
          <div>
            <h2>{{ signatureRole === 'SUSPECT' ? '被询问人电子签名' : '询问人民警电子签名' }}</h2>
            <p>{{ signerName(signatureRole) }} · 签名将绑定当前笔录 SHA-256</p>
          </div>
          <button :disabled="signingBusy === 'sign'" @click="closeSignature">关闭</button>
        </header>
        <canvas
          ref="signatureCanvas"
          class="signature-canvas"
          @pointerdown.prevent="startSignatureStroke"
          @pointermove.prevent="moveSignatureStroke"
          @pointerup.prevent="endSignatureStroke"
          @pointercancel.prevent="endSignatureStroke"
        ></canvas>
        <div class="signature-modal-note">请使用手指或电容笔在框内签名。系统同时保存笔迹轨迹、时间、压力信息（设备支持时）及签名图像摘要。</div>
        <footer>
          <button :disabled="signingBusy === 'sign'" @click="clearSignature">清空</button>
          <button class="confirm-signature" :disabled="signingBusy === 'sign'" @click="confirmSignature">
            {{ signingBusy === 'sign' ? '保存签名中…' : '确认签名并绑定版本' }}
          </button>
        </footer>
      </section>
    </div>
  </section>
</template>

<style scoped>
.workbench-mode {
  --ui-blue: #185d8d;
  --ui-blue-dark: #103f61;
  --ui-line: #b8c9d5;
  --ui-soft: #eef4f7;
  --ui-text: #20384b;
  position: relative;
  min-width: 1320px;
  min-height: 0;
  height: 100%;
  overflow: hidden;
  background: #dce7ee;
  color: var(--ui-text);
  font-family: "Microsoft YaHei", "PingFang SC", sans-serif;
}
.interrogation-grid { height: 100%; min-height: 0; display: grid; grid-template-columns: 258px minmax(720px, 1fr) 320px; gap: 1px; background: #aebfca; }
.subject-panel, .conversation-panel, .operation-panel { min-height: 0; background: #f7fafc; }
.subject-panel { overflow: auto; padding: 0 16px 18px; }
.panel-title { margin: 0 -16px 18px; min-height: 54px; padding: 0 16px; display: flex; align-items: center; justify-content: space-between; background: var(--ui-blue-dark); color: #fff; }
.panel-title span { font-size: 17px; font-weight: 700; }
.panel-title strong { padding: 5px 8px; border-radius: 3px; background: rgba(255,255,255,.14); font-size: 12px; }
.subject-photo { width: 108px; height: 132px; margin: 0 auto 12px; display: grid; place-items: center; text-align: center; border: 1px solid #9db1bf; background: #e4ebef; color: #7b8d99; line-height: 1.8; }
.subject-panel h2 { margin: 0 0 16px; text-align: center; color: #173f5d; font-size: 21px; }
.subject-panel dl { margin: 0; }
.subject-panel dl > div { display: grid; grid-template-columns: 66px minmax(0,1fr); gap: 8px; padding: 9px 0; border-bottom: 1px solid #d8e1e7; font-size: 13px; }
.subject-panel dt { color: #718391; }
.subject-panel dd { margin: 0; color: #2c4354; font-weight: 600; overflow-wrap: anywhere; }
.subject-stats { display: grid; grid-template-columns: repeat(3,1fr); gap: 6px; margin-top: 18px; }
.subject-stats div { padding: 10px 2px; text-align: center; border: 1px solid #c6d4de; background: #fff; }
.subject-stats strong { display: block; color: var(--ui-blue); font-size: 20px; }
.subject-stats span { display: block; margin-top: 3px; color: #718493; font-size: 11px; }
.demo-chip { margin-top: 14px; padding: 7px; text-align: center; border: 1px solid #d4b08a; background: #fff8e9; color: #91602e; font-size: 12px; }
.conversation-panel { display: grid; grid-template-rows: auto minmax(0,1fr) auto auto; overflow: hidden; background: #edf3f6; }
.conversation-header { min-height: 66px; display: flex; align-items: center; justify-content: space-between; gap: 18px; padding: 0 20px; border-bottom: 1px solid var(--ui-line); background: #fff; }
.section-kicker { color: #6e8494; font-size: 12px; }
.conversation-header h1 { margin: 2px 0 0; color: #183f5b; font-size: 21px; }
.conversation-status { min-width: 92px; min-height: 36px; display: flex; align-items: center; justify-content: center; gap: 7px; border: 1px solid #b6c7d3; background: #f5f8fa; font-size: 13px; font-weight: 700; }
.conversation-status span { width: 8px; height: 8px; border-radius: 50%; background: #8294a0; }
.conversation-status.running { border-color: #9bc4a9; color: #2e7147; background: #f2fbf5; }
.conversation-status.running span { background: #3a975d; }
.conversation-status.paused { border-color: #d9bd88; color: #815c1f; background: #fff9ed; }
.conversation-status.paused span { background: #d19a31; }
.conversation-scroll { min-height: 0; overflow: auto; padding: 18px 22px 26px; }
.conversation-empty { max-width: 560px; margin: 100px auto; padding: 36px; text-align: center; border: 1px dashed #adbfcb; background: rgba(255,255,255,.72); }
.conversation-empty strong { color: #31546d; font-size: 18px; }
.conversation-empty p { margin: 10px 0 0; color: #728593; line-height: 1.7; }
.qa-turn { position: relative; margin-bottom: 18px; padding-left: 34px; }
.turn-index { position: absolute; left: 0; top: 18px; width: 26px; text-align: center; color: #8799a6; font: 12px/1 Consolas, monospace; }
.speech-row { display: grid; grid-template-columns: 42px minmax(0,1fr); gap: 11px; margin: 0 0 12px; }
.role-badge { width: 38px; height: 38px; display: grid; place-items: center; border-radius: 50%; color: #fff; font-weight: 700; font-size: 17px; }
.speech-row.officer .role-badge { background: #276c9d; }
.speech-row.suspect .role-badge { background: #4b7d5c; }
.speech-content { min-width: 0; padding: 11px 13px 8px; border: 1px solid #bacad5; border-left: 4px solid #3779a8; background: #fff; }
.speech-row.suspect .speech-content { border-left-color: #5a8c69; }
.speech-row.conflict .speech-content { border-color: #d59c94; border-left-color: #c3483c; background: #fff9f8; }
.speech-meta { display: flex; align-items: center; justify-content: space-between; gap: 12px; margin-bottom: 5px; }
.speech-meta strong { color: #284a62; font-size: 13px; }
.speech-meta span { color: #8798a4; font-size: 11px; }
.record-editor { width: 100%; box-sizing: border-box; min-height: 48px; padding: 7px 8px; resize: vertical; overflow: hidden; border: 1px solid transparent; outline: none; background: #fbfdfe; color: #1f3444; font: 16px/1.75 "Microsoft YaHei", sans-serif; }
.record-editor:focus { border-color: #5c96be; background: #fffef2; box-shadow: 0 0 0 2px rgba(48,125,179,.10); }
.record-editor.recording-target:not(:disabled) { border-color: #d99d2f; background: #fff8e5; }
.record-editor.locked { resize: none; opacity: 1; -webkit-text-fill-color: #1f3444; }
.record-actions { min-height: 32px; display: flex; align-items: center; justify-content: space-between; gap: 12px; color: #84949f; font-size: 11px; }
.record-actions button { min-width: 86px; min-height: 34px; border: 1px solid #c3d0d9; background: #f7fafc; color: #506a7c; font-weight: 700; touch-action: manipulation; }
.speech-row.conflict .record-actions button { border-color: #d39b94; color: #a83e34; background: #fff; }
.voice-draft-section { margin: 22px 0 0 34px; padding: 13px; border: 1px solid #c5d2db; background: #f8fbfd; }
.voice-draft-section header { display: flex; justify-content: space-between; gap: 12px; margin-bottom: 8px; }
.voice-draft-section header span { color: #7b8e9b; font-size: 11px; }
.voice-draft-row, .voice-live-row { margin-top: 7px; padding: 9px 10px; border-left: 3px solid #8aaac0; background: #fff; font-size: 13px; line-height: 1.6; }
.voice-draft-row.needs-confirmation { border-left-color: #d09736; background: #fffaf0; }
.voice-draft-meta { display: flex; align-items: center; flex-wrap: wrap; gap: 6px 10px; margin-bottom: 5px; }
.voice-draft-meta strong { color: #244c68; }
.voice-draft-meta span, .voice-draft-meta small { color: #788b98; font-size: 11px; }
.voice-draft-meta b { padding: 2px 6px; border-radius: 3px; background: #fff0c9; color: #8a5a08; font-size: 11px; }
.voice-draft-row p { margin: 0; color: #263f51; }
.voice-live-row { border-left-color: #cf6357; background: #fff8f7; }
.workbench-error { margin: 0 18px 8px; padding: 10px 12px; border: 1px solid #e0aaa3; background: #fff3f1; color: #962e26; font-size: 13px; }
.interrogation-composer { display: grid; grid-template-columns: auto auto minmax(280px,1fr) auto; gap: 9px; align-items: center; padding: 11px 14px; border-top: 1px solid #b9c8d3; background: #f9fcfe; }
.record-button, .role-switch button, .send-record-button, .operation-actions button, .mini-signature button { min-height: 48px; border: 1px solid #aabdc9; background: #fff; color: #31536a; font-weight: 700; touch-action: manipulation; }
.record-button { min-width: 92px; }
.record-button.active { border-color: #cb594d; background: #fff2f0; color: #b8372d; }
.record-dot { color: #cf4c41; }
.role-switch { display: grid; grid-template-columns: 1fr 1fr; min-width: 178px; }
.role-switch button { min-width: 88px; border-radius: 0; }
.role-switch button + button { border-left: 0; }
.role-switch button.active { background: #225f89; color: #fff; border-color: #225f89; }
.interrogation-composer textarea { width: 100%; box-sizing: border-box; min-height: 52px; max-height: 112px; resize: vertical; padding: 10px 12px; border: 1px solid #aebfca; background: #fff; color: #20384b; font: 15px/1.55 "Microsoft YaHei", sans-serif; }
.send-record-button { min-width: 116px; border-color: #1d6597; background: #1d6597; color: #fff; }
.operation-panel { overflow: auto; padding: 14px; background: #f3f7f9; }
.current-question-card, .asr-live-card, .operation-actions, .signing-panel { margin-bottom: 12px; border: 1px solid #b8c9d5; background: #fff; }
.current-question-card { padding: 14px; border-top: 4px solid #2b75a7; }
.current-question-card > span { display: block; margin-bottom: 8px; color: #668091; font-size: 12px; font-weight: 700; }
.current-question-card > strong { display: block; color: #213f54; font-size: 15px; line-height: 1.7; }
.asr-live-card { padding: 13px; }
.asr-live-card header { display: flex; align-items: center; gap: 7px; color: #31536b; }
.mic-dot { color: #8798a3; }
.asr-live-card.active .mic-dot { color: #d44439; }
.asr-live-card p { min-height: 72px; margin: 10px 0; padding: 9px; border: 1px solid #d7e0e6; background: #f8fafb; color: #354e60; line-height: 1.6; }
.asr-live-card small { color: #748795; }
.operation-actions { display: grid; gap: 8px; padding: 12px; }
.operation-actions button { width: 100%; }
.operation-actions .freeze-button { border-color: #c16b62; color: #a5372e; }
.signing-panel { padding: 12px; }
.signing-panel > header { display: flex; align-items: center; justify-content: space-between; gap: 10px; margin-bottom: 10px; }
.signing-panel > header strong { color: #284b62; }
.signing-panel > header span { color: #7a8c98; font-size: 11px; }
.signing-placeholder { padding: 16px 8px; border: 1px dashed #c0ccd4; color: #748692; font-size: 12px; line-height: 1.7; }
.integrity-state { margin-bottom: 10px; padding: 9px; border: 1px solid #a9cbb4; background: #f3fbf5; }
.integrity-state.invalid { border-color: #dfa9a3; background: #fff4f2; }
.integrity-state b { margin-right: 7px; color: #2f6f47; }
.integrity-state span { font-size: 12px; }
.integrity-state small { display: block; margin-top: 6px; overflow-wrap: anywhere; color: #70818d; font: 9px/1.4 Consolas, monospace; }
.mini-signature { margin-top: 9px; padding: 9px; border: 1px solid #c3d0d8; }
.mini-signature > div { display: flex; justify-content: space-between; gap: 8px; margin-bottom: 7px; font-size: 12px; }
.mini-signature img { width: 100%; height: 70px; object-fit: contain; border: 1px solid #e0e6ea; background: #fff; }
.mini-signature button { width: 100%; }
.mini-signature small { display: block; margin-top: 5px; color: #7c8d98; font-size: 10px; }
.locked-notice { margin: 10px 0 0; text-align: center; color: #2f7047; font-size: 12px; font-weight: 700; }
.signature-modal-backdrop { position: fixed; z-index: 120; inset: 0; display: grid; place-items: center; padding: 24px; background: rgba(12, 29, 43, .68); }
.signature-modal { width: min(920px, calc(100vw - 80px)); border: 1px solid #9eb3c1; background: #fff; box-shadow: 0 24px 70px rgba(0,0,0,.3); font-family: "Microsoft YaHei", sans-serif; }
.signature-modal > header { padding: 16px 20px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #d4dfe6; }
.signature-modal h2 { margin: 0; color: #213f55; font-size: 20px; }
.signature-modal header p { margin: 5px 0 0; color: #738493; font-size: 12px; }
.signature-modal header button, .signature-modal footer button { min-width: 96px; min-height: 48px; border: 1px solid #b4c5d0; background: #fff; font-weight: 700; touch-action: manipulation; }
.signature-canvas { display: block; width: calc(100% - 40px); height: 300px; margin: 20px; border: 2px dashed #879daa; background: #fff; touch-action: none; cursor: crosshair; }
.signature-modal-note { margin: 0 20px 16px; color: #6c7b86; font-size: 12px; }
.signature-modal footer { display: flex; justify-content: flex-end; gap: 10px; padding: 14px 20px; border-top: 1px solid #dbe4ea; background: #f8fafb; }
.signature-modal footer .confirm-signature { border-color: #1f6597; background: #1f6597; color: #fff; }
button:disabled { opacity: .46; cursor: not-allowed; }
</style>