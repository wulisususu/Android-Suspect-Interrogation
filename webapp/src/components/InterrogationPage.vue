<script setup lang="ts">
import { computed, nextTick, reactive, ref, watch } from 'vue'
import {
  backendErrorMessage,
  finishSession,
  persistQuestionOrAnswer,
  updateTranscriptMessage,
} from '../api/interrogation'
import {
  fetchDocumentSigningState,
  freezeDocument,
  signDocument,
} from '../api/documentSigning'
import type {
  AsrCaptureStatus,
  AsrInsertionReceipt,
  AsrInsertionTarget,
  CaseSummary,
  DocumentSignerRole,
  DocumentSigningState,
  FactItem,
  SessionState,
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
const interrogationRound = computed(() => headerFact('interrogation_round', '1'))
const interrogationTime = computed(() => {
  const start = formatDateTime(props.session.startedAt)
  const end = props.session.endedAt ? formatDateTime(props.session.endedAt) : '____年__月__日 __时__分'
  return `${start} 至 ${end}`
})

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

function formatDateTime(value?: number | null) {
  if (!value) return '____年__月__日 __时__分'
  const date = new Date(value)
  const pad = (n: number) => String(n).padStart(2, '0')
  return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日 ${pad(date.getHours())}时${pad(date.getMinutes())}分`
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
  const visualLines = textValue.split('\n').reduce((sum, line) => sum + Math.max(1, Math.ceil(line.length / 38)), 0)
  return Math.max(minimum, Math.min(14, visualLines))
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

async function appendRecord() {
  const clean = text.value.trim()
  if (!clean || saving.value) return
  if (documentFrozen.value) {
    localError.value = '笔录已经冻结，不能继续新增正式问答。'
    return
  }
  if (!props.canRecord) {
    localError.value = '当前审讯未处于可记录状态。'
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
  if (props.capture.running) {
    const target = recordingTarget.value
    if (!target) localError.value = '当前录音缺少写入目标，停止后将保留为待确认片段。'
    emit('captureStop', target || undefined)
    return
  }
  const target = insertionTarget.value
  const valid = target
    && target.caseId === props.caseId
    && formalRecords.value.some((item) => item.id === target.recordId)
  if (!valid) {
    localError.value = '请先点击要写入的问或答，并放置输入光标。'
    return
  }
  localError.value = ''
  recordingTarget.value = { ...target }
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
  <section ref="pageRoot" class="interrogation-page page-card document-mode">
    <div class="document-actions">
      <button
        class="finish-interrogation-button"
        :disabled="!!signingBusy || documentFrozen || capture.running"
        @click="finishAndFreeze"
      >
        {{ signingBusy === 'freeze' ? '正在冻结…' : '结束审讯' }}
      </button>
      <button class="ai-generate-button" :disabled="aiBusy" @click="$emit('generateAi')">
        {{ aiBusy ? 'AI 梳理中…' : '✦ 生成 AI 案件梳理' }}
      </button>
    </div>

    <div class="document-scroll">
      <article class="interrogation-paper" aria-label="询问笔录文档">
        <div class="document-round">第 {{ interrogationRound }} 次</div>
        <div v-if="isDemo" class="demo-watermark">模拟案件 · 全部信息均为虚构</div>
        <h1>询 问 笔 录</h1>

        <div class="official-header">
          <div class="full-row"><span>时间</span><strong>{{ interrogationTime }}</strong></div>
          <div class="full-row"><span>地点</span><strong>{{ headerFact('interrogation_place', '________________') }}</strong></div>
          <div><span>询问人</span><strong>{{ summary.officerName || '________' }}</strong></div>
          <div><span>工作单位</span><strong>{{ headerFact('officer_unit', '________________') }}</strong></div>
          <div><span>记录人</span><strong>{{ headerFact('recorder_name', '________') }}</strong></div>
          <div><span>工作单位</span><strong>{{ headerFact('recorder_unit', '________________') }}</strong></div>
          <div class="full-row"><span>被询问人</span><strong>{{ summary.suspectName || '________' }}</strong></div>
          <div class="full-row"><span>身份证件种类及号码</span><strong>{{ headerFact('id_document_type', '身份证') }}　{{ summary.idNumber || '__________________' }}</strong></div>
          <div><span>性别</span><strong>{{ summary.gender || '____' }}</strong></div>
          <div><span>出生日期</span><strong>{{ summary.birthDate || '____-__-__' }}</strong></div>
          <div class="full-row"><span>人大代表</span><strong>{{ headerFact('peoples_representative', '否') }}</strong></div>
          <div class="full-row"><span>联系方式</span><strong>{{ headerFact('contact', '________________') }}</strong></div>
          <div class="full-row"><span>现住址</span><strong>{{ headerFact('current_address', '________________') }}</strong></div>
          <div class="full-row"><span>户籍所在地</span><strong>{{ headerFact('household_registration', '________________') }}</strong></div>
        </div>

        <div v-if="!qaPairs.length && !capture.partialText && !capture.fragments.length" class="document-empty">
          <p>正文尚无正式问答记录。</p>
          <p>可在页面底部新增“民警问 / 嫌疑人答”，也可以启动录音生成临时转写。</p>
        </div>

        <section v-for="(pair, index) in qaPairs" :key="`${pair.question?.id || 'q'}-${pair.answer?.id || 'a'}-${index}`" class="qa-block">
          <div class="qa-number">{{ String(index + 1).padStart(2, '0') }}</div>

          <div v-if="pair.question" class="qa-line question-line">
            <strong class="qa-label">问：</strong>
            <textarea
              v-model="drafts[pair.question.id]"
              class="document-editor"
              :class="{
                locked: documentFrozen,
                'recording-target': (recordingTarget || insertionTarget)?.recordId === pair.question.id,
              }"
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
          </div>

          <div v-if="pair.answer" class="qa-line answer-line">
            <strong class="qa-label">答：</strong>
            <textarea
              v-model="drafts[pair.answer.id]"
              class="document-editor answer-editor"
              :class="{
                locked: documentFrozen,
                'recording-target': (recordingTarget || insertionTarget)?.recordId === pair.answer.id,
              }"
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
          </div>
        </section>

        <section v-if="capture.fragments.length || capture.partialText" class="voice-draft-section">
          <h2>语音转写草稿</h2>
          <p class="voice-draft-note">以下内容尚未作为正式问答归档，结束审讯前请确认或丢弃。</p>
          <div v-for="fragment in capture.fragments" :key="fragment.id" class="voice-draft-row">
            {{ fragment.editedText || fragment.rawText || '等待识别文本……' }}
          </div>
          <div v-if="capture.partialText" class="voice-live-row">{{ capture.partialText }}</div>
        </section>

        <section class="signature-section">
          <h2>笔录确认与电子签名</h2>
          <div v-if="!signingState" class="signature-intro">
            结束审讯后将冻结当前笔录版本并计算 SHA-256，随后开放被询问人和询问人电子签名。
          </div>
          <template v-else>
            <div class="document-integrity" :class="{ invalid: !signingState.integrityValid }">
              <div><strong>版本 V{{ signingState.version }}</strong><span>{{ documentLocked ? '已锁定' : '已冻结，待完成签名' }}</span></div>
              <p>SHA-256：{{ signingState.documentHash }}</p>
              <small>{{ signingState.integrityValid ? '当前内容与冻结版本一致' : '完整性校验失败：冻结后内容发生变化' }}</small>
            </div>

            <div class="signature-cards">
              <article class="signature-card">
                <header><strong>被询问人签名</strong><span>{{ summary.suspectName || '被询问人' }}</span></header>
                <template v-if="signatureFor('SUSPECT')">
                  <img :src="signatureFor('SUSPECT')?.imageDataUrl" alt="被询问人电子签名" />
                  <small>{{ formatSignedAt(signatureFor('SUSPECT')?.signedAt) }}</small>
                  <small class="hash-small">签名摘要：{{ signatureFor('SUSPECT')?.signatureHash }}</small>
                </template>
                <button v-else :disabled="!signingState.integrityValid || !!signingBusy" @click="openSignature('SUSPECT')">手写签名</button>
              </article>

              <article class="signature-card">
                <header><strong>询问人签名</strong><span>{{ summary.officerName || '询问人' }}</span></header>
                <template v-if="signatureFor('OFFICER')">
                  <img :src="signatureFor('OFFICER')?.imageDataUrl" alt="询问人民警电子签名" />
                  <small>{{ formatSignedAt(signatureFor('OFFICER')?.signedAt) }}</small>
                  <small class="hash-small">签名摘要：{{ signatureFor('OFFICER')?.signatureHash }}</small>
                </template>
                <button v-else :disabled="!signingState.integrityValid || !!signingBusy" @click="openSignature('OFFICER')">手写签名</button>
              </article>
            </div>

            <p v-if="documentLocked" class="locked-notice">双方签名已完成，本版本已锁定。后续不得直接修改已签笔录。</p>
          </template>
        </section>

        <div class="document-end">—— 本页以下无正文 ——</div>
      </article>
    </div>

    <div v-if="localError || aiError || capture.error" class="interrogation-error floating-error">
      {{ localError || aiError || capture.error }}
    </div>

    <footer v-if="!documentFrozen" class="interrogation-composer document-composer">
      <button
        class="record-button"
        :class="{ active: capture.running }"
        :disabled="captureBusy || !nativeCaptureAvailable || (!canRecord && !capture.running)"
        :title="nativeCaptureAvailable ? '开始 / 停止离线录音' : '连续离线录音 Runtime 当前不可用'"
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
        rows="1"
        :placeholder="entryRole === '民警' ? '输入新的询问问题……' : '输入新的被询问人回答……'"
        @keydown.ctrl.enter.prevent="appendRecord"
      ></textarea>
      <button class="primary-action record-save" :disabled="!text.trim() || !canRecord || saving" @click="appendRecord">
        {{ saving ? '保存中…' : '加入笔录' }}
      </button>
    </footer>

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
.document-mode {
  position: relative;
  display: flex;
  flex-direction: column;
  background: #eef1f4;
  border-radius: 0;
}
.document-actions {
  position: absolute;
  z-index: 8;
  top: 12px;
  right: 18px;
  display: flex;
  gap: 10px;
}
.finish-interrogation-button,
.ai-generate-button {
  border-radius: 9px;
  padding: 9px 14px;
  font-weight: 700;
  background: rgba(255,255,255,.94);
}
.finish-interrogation-button { border: 1px solid #efb8b2; color: #b42318; }
.ai-generate-button { border: 1px solid #8eb8e4; color: #1c68b6; }
.document-scroll {
  flex: 1 1 auto;
  min-height: 0;
  overflow: auto;
  padding: 18px 30px 42px;
  background: #e8ebee;
}
.interrogation-paper {
  position: relative;
  box-sizing: border-box;
  width: min(210mm, 100%);
  min-height: 297mm;
  margin: 0 auto;
  padding: 20mm 21mm 24mm 25mm;
  background: #fff;
  box-shadow: 0 8px 28px rgba(26, 39, 51, .14);
  color: #111;
  font-family: SimSun, "宋体", "Songti SC", serif;
  font-size: 12pt;
  line-height: 1.75;
}
.document-round {
  position: absolute;
  top: 13mm;
  right: 21mm;
  font-size: 11pt;
  letter-spacing: .35em;
}
.demo-watermark {
  position: absolute;
  top: 20mm;
  right: 21mm;
  color: #9a4b4b;
  border: 1px solid #d7aaaa;
  padding: 2px 8px;
  font: 8.5pt/1.5 SimSun, "宋体", serif;
  letter-spacing: .06em;
}
.interrogation-paper > h1 {
  margin: 5mm 0 9mm;
  text-align: center;
  font-family: SimHei, "黑体", sans-serif;
  font-size: 22pt;
  line-height: 1.35;
  letter-spacing: .24em;
  font-weight: 700;
}
.official-header {
  display: grid;
  grid-template-columns: 1fr 1fr;
  column-gap: 8mm;
  margin-bottom: 8mm;
  font-size: 10.5pt;
}
.official-header > div {
  min-height: 9mm;
  display: grid;
  grid-template-columns: auto 1fr;
  gap: 3mm;
  align-items: end;
  padding: 1.5mm 0 1mm;
  border-bottom: 1px solid #555;
}
.official-header > .full-row { grid-column: 1 / -1; }
.official-header span { white-space: nowrap; }
.official-header strong { min-width: 0; font-weight: 400; word-break: break-all; }
.document-empty { margin: 20mm 0; text-align: center; color: #777; }
.document-empty p { margin: 2mm 0; text-indent: 0; }
.qa-block {
  position: relative;
  padding: 3.5mm 0 4.5mm;
  border-bottom: 1px dotted #c9c9c9;
}
.qa-number {
  position: absolute;
  left: -12mm;
  top: 5mm;
  color: #aaa;
  font: 9pt/1 "Times New Roman", serif;
}
.qa-line {
  display: grid;
  grid-template-columns: 2.2em minmax(0, 1fr);
  align-items: start;
  gap: .3em;
  margin: 0 0 2mm;
}
.qa-label {
  padding-top: 2px;
  font-family: SimHei, "黑体", sans-serif;
  font-size: 12pt;
  line-height: 1.75;
  font-weight: 700;
}
.document-editor {
  width: 100%;
  box-sizing: border-box;
  min-height: 2.8em;
  margin: 0;
  padding: 0 2px;
  resize: vertical;
  overflow: hidden;
  border: 1px solid transparent;
  border-radius: 2px;
  outline: none;
  background: transparent;
  color: #111;
  font: 12pt/1.75 SimSun, "宋体", "Songti SC", serif;
}
.answer-editor { text-indent: 2em; }
.document-editor:hover:not(:disabled) { background: #fbfcfd; border-color: #edf0f2; }
.document-editor:focus { background: #fffef5; border-color: #8fb6d8; box-shadow: 0 0 0 2px rgba(47, 128, 237, .08); }
.document-editor.locked { resize: none; opacity: 1; -webkit-text-fill-color: #111; }
.document-editor.recording-target:not(:disabled) { background: #fff9e8; border-color: #d69b2d; box-shadow: 0 0 0 2px rgba(214, 155, 45, .14); }
.voice-draft-section { margin-top: 10mm; padding-top: 6mm; border-top: 1px solid #aaa; }
.voice-draft-section h2,
.signature-section h2 { margin: 0 0 2mm; font: 700 14pt/1.5 SimHei, "黑体", sans-serif; }
.voice-draft-note { margin: 0 0 4mm; color: #666; font-size: 10.5pt; text-indent: 2em; }
.voice-draft-row, .voice-live-row { margin: 2mm 0; padding: 3mm 4mm; background: #f6f8fa; border-left: 3px solid #9eb9ce; font-size: 10.5pt; }
.voice-live-row { border-left-color: #d66; background: #fff8f8; }
.signature-section { margin-top: 12mm; padding-top: 6mm; border-top: 1px solid #333; }
.signature-intro { padding: 5mm; border: 1px dashed #aaa; color: #666; text-align: center; font-size: 10.5pt; }
.document-integrity { margin: 4mm 0; padding: 3mm 4mm; border: 1px solid #b8d8c7; background: #f4fbf7; font-size: 9.5pt; }
.document-integrity.invalid { border-color: #e3a6a0; background: #fff4f3; }
.document-integrity > div { display: flex; justify-content: space-between; gap: 10px; }
.document-integrity p { margin: 2mm 0 1mm; word-break: break-all; font-family: Consolas, monospace; font-size: 8.5pt; }
.signature-cards { display: grid; grid-template-columns: 1fr 1fr; gap: 8mm; margin-top: 5mm; }
.signature-card { min-height: 42mm; padding: 4mm; border: 1px solid #777; display: flex; flex-direction: column; }
.signature-card header { display: flex; justify-content: space-between; gap: 8px; font-size: 10.5pt; }
.signature-card img { width: 100%; height: 23mm; margin: 3mm 0 1mm; object-fit: contain; }
.signature-card button { margin: auto; padding: 3mm 8mm; border: 1px solid #789ec0; background: #f3f8fd; color: #235e91; }
.signature-card small { color: #555; font-size: 8.5pt; }
.hash-small { overflow-wrap: anywhere; font-family: Consolas, monospace; font-size: 7.5pt !important; }
.locked-notice { margin: 5mm 0 0; text-align: center; font-weight: 700; color: #17613f; }
.document-end { margin-top: 12mm; text-align: center; color: #777; font-size: 10.5pt; letter-spacing: .08em; }
.document-composer {
  flex: 0 0 auto;
  display: grid;
  grid-template-columns: auto auto minmax(240px, 1fr) auto;
  align-items: center;
  gap: 10px;
  padding: 12px 16px;
  background: #fff;
  border-top: 1px solid #dce3e8;
}
.role-switch { display: inline-flex; border: 1px solid #c8d4dd; border-radius: 8px; overflow: hidden; }
.role-switch button { border: 0; border-right: 1px solid #c8d4dd; background: #fff; color: #5f7180; padding: 8px 10px; white-space: nowrap; }
.role-switch button:last-child { border-right: 0; }
.role-switch button.active { background: #edf5ff; color: #1769c8; font-weight: 700; }
.document-composer > textarea { width: 100%; box-sizing: border-box; min-height: 40px; max-height: 110px; resize: vertical; border: 1px solid #ccd7df; border-radius: 8px; padding: 9px 11px; font: 14px/1.5 "Microsoft YaHei", sans-serif; }
.floating-error { position: absolute; z-index: 12; left: 18px; bottom: 86px; max-width: 620px; box-shadow: 0 4px 18px rgba(0,0,0,.08); }
.signature-modal-backdrop { position: fixed; z-index: 120; inset: 0; display: grid; place-items: center; padding: 24px; background: rgba(12, 29, 43, .66); }
.signature-modal { width: min(920px, 94vw); border-radius: 14px; overflow: hidden; background: #fff; box-shadow: 0 24px 70px rgba(0,0,0,.3); font-family: "Microsoft YaHei", sans-serif; }
.signature-modal > header { padding: 16px 20px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #dfe6eb; }
.signature-modal h2 { margin: 0; color: #213b51; font-size: 20px; }
.signature-modal header p { margin: 5px 0 0; color: #738493; font-size: 12px; }
.signature-modal header button,
.signature-modal footer button { border: 1px solid #cbd7e0; border-radius: 8px; background: #fff; padding: 9px 14px; }
.signature-canvas { display: block; width: calc(100% - 40px); height: 300px; margin: 20px; border: 2px dashed #92a7b6; background: #fff; touch-action: none; cursor: crosshair; }
.signature-modal-note { margin: 0 20px 16px; color: #6c7b86; font-size: 12px; }
.signature-modal footer { display: flex; justify-content: flex-end; gap: 10px; padding: 14px 20px; border-top: 1px solid #e2e8ed; background: #f8fafb; }
.signature-modal footer .confirm-signature { border-color: #2f80ed; background: #2f80ed; color: #fff; font-weight: 700; }
@media (max-width: 900px) {
  .document-actions { position: static; justify-content: flex-end; padding: 8px 12px; background: #e8ebee; }
  .document-scroll { padding: 10px; }
  .interrogation-paper { min-height: 0; padding: 56px 24px 44px; }
  .official-header, .signature-cards { grid-template-columns: 1fr; }
  .official-header > .full-row { grid-column: auto; }
  .document-composer { grid-template-columns: auto 1fr auto; }
  .role-switch { grid-column: 1 / -1; width: max-content; }
}
</style>
