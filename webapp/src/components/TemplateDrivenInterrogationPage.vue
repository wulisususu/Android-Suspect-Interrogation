<script setup lang="ts">
import { computed, nextTick, ref, watch } from 'vue'

import { backendErrorMessage, finishSession } from '../api/interrogation'
import { fetchDocumentSigningState, freezeDocument, signDocument } from '../api/documentSigning'
import type {
  AsrCaptureStatus,
  AsrInsertionTarget,
  CaseSummary,
  DocumentSignerRole,
  DocumentSigningState,
  SessionState,
  TemporaryAsrFragment,
  TemporaryAsrSpeaker,
} from '../types/interrogation'
import type {
  CaseQuestionCreateInput,
  CaseQuestionUpdateInput,
  PendingResolution,
  RoundReassociateInput,
  StandardQuestion,
  TemplateWorkspace,
} from '../types/templateInterrogation'
import FormalTemplatePanel from './FormalTemplatePanel.vue'
import LiveDialoguePanel from './LiveDialoguePanel.vue'
import QuestionPreparationPanel from './QuestionPreparationPanel.vue'
import './templateInterrogation.css'

const props = defineProps<{
  caseId: string
  summary: CaseSummary
  session: SessionState
  capture: AsrCaptureStatus
  canRecord: boolean
  nativeCaptureAvailable: boolean
  captureBusy: boolean
  captureElapsedMs: number
  aiBusy: boolean
  aiError: string
  workspace: TemplateWorkspace
  dialogueHistory: TemporaryAsrFragment[]
  questionLibrary: StandardQuestion[]
  templateBusy: boolean
  templateError: string
  questionDictationAvailable: boolean
  questionDictationActive: boolean
  questionDictationBusy: boolean
  questionDictationDraft: string
  questionDictationError: string
}>()

const emit = defineEmits<{
  saved: []
  captureStart: []
  captureStop: [target?: AsrInsertionTarget]
  questionDictationStart: []
  questionDictationStop: []
  generateAi: []
  loadLibrary: [category?: string]
  createQuestion: [input: CaseQuestionCreateInput]
  updateQuestion: [questionId: string, input: CaseQuestionUpdateInput]
  reorderQuestions: [questionIds: string[]]
  removeQuestion: [questionId: string]
  resolvePending: [pendingId: string, resolution: PendingResolution]
  reassociateRound: [roundId: string, input: RoundReassociateInput]
  updateAnswer: [roundId: string, answerText: string]
  saveLibrary: [questionId: string]
  correctFragment: [fragmentId: string, speaker: TemporaryAsrSpeaker, reason: string]
}>()

type SignaturePoint = { x: number; y: number; t: number; p: number }

const signingState = ref<DocumentSigningState | null>(null)
const signingBusy = ref('')
const signingError = ref('')
const signatureRole = ref<DocumentSignerRole | null>(null)
const signatureCanvas = ref<HTMLCanvasElement | null>(null)
const signatureStrokes = ref<SignaturePoint[][]>([])
let activeStroke: SignaturePoint[] | null = null

const documentFrozen = computed(() => !!signingState.value)
const documentLocked = computed(() => signingState.value?.status === 'LOCKED')

watch(
  () => props.caseId,
  () => { void loadSigningState() },
  { immediate: true },
)

async function loadSigningState() {
  signingError.value = ''
  if (!props.caseId) {
    signingState.value = null
    return
  }
  try {
    signingState.value = await fetchDocumentSigningState(props.caseId)
  } catch (err) {
    signingError.value = backendErrorMessage(err)
  }
}

function toggleCapture() {
  if (documentFrozen.value) {
    signingError.value = '笔录已经冻结，不能继续录音。'
    return
  }
  if (props.capture.running) emit('captureStop', undefined)
  else emit('captureStart')
}

async function finishAndFreeze() {
  if (signingBusy.value || documentFrozen.value) return
  if (props.capture.running) {
    signingError.value = '请先停止当前录音，再结束审讯并冻结笔录。'
    return
  }
  signingBusy.value = 'freeze'
  signingError.value = ''
  try {
    if (props.session.status !== 'COMPLETED') await finishSession(props.caseId)
    signingState.value = await freezeDocument(props.caseId)
    emit('saved')
  } catch (err) {
    signingError.value = backendErrorMessage(err)
  } finally {
    signingBusy.value = ''
  }
}

function signatureFor(role: DocumentSignerRole) {
  return signingState.value?.signatures.find((item) => item.signerRole === role)
}

function signerName(role: DocumentSignerRole) {
  return role === 'SUSPECT' ? (props.summary.suspectName || '被讯问人') : (props.summary.officerName || '询问人')
}

async function openSignature(role: DocumentSignerRole) {
  if (!signingState.value) {
    signingError.value = '请先结束审讯并冻结正式笔录。'
    return
  }
  if (!signingState.value.integrityValid) {
    signingError.value = '当前冻结版本完整性校验失败，不能继续签名。'
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
  ctx.strokeStyle = '#111827'
}

function pointFromEvent(event: PointerEvent): SignaturePoint {
  const rect = signatureCanvas.value?.getBoundingClientRect()
  return { x: event.clientX - (rect?.left || 0), y: event.clientY - (rect?.top || 0), t: Date.now(), p: event.pressure || 0.5 }
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
  const canvas = signatureCanvas.value
  if (!canvas) return
  canvas.setPointerCapture(event.pointerId)
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
  const canvas = signatureCanvas.value
  if (canvas?.hasPointerCapture(event.pointerId)) canvas.releasePointerCapture(event.pointerId)
  activeStroke = null
}

function clearSignature() {
  signatureStrokes.value = []
  activeStroke = null
  prepareCanvas()
}

function forwardQuestionUpdate(questionId: string, input: CaseQuestionUpdateInput) {
  emit('updateQuestion', questionId, input)
}

async function confirmSignature() {
  const role = signatureRole.value
  const canvas = signatureCanvas.value
  const hasInk = signatureStrokes.value.some((stroke) => stroke.length > 1)
  if (!role || !canvas || !hasInk) {
    signingError.value = '请先在签名区域完成手写签名。'
    return
  }

  signingBusy.value = 'sign'
  signingError.value = ''
  try {
    signingState.value = await signDocument(
      props.caseId,
      role,
      signerName(role),
      canvas.toDataURL('image/png'),
      JSON.stringify(signatureStrokes.value),
    )
    signatureRole.value = null
    signatureStrokes.value = []
    emit('saved')
  } catch (err) {
    signingError.value = backendErrorMessage(err)
  } finally {
    signingBusy.value = ''
  }
}
</script>

<template>
  <section class="template-driven-interrogation-page">
    <p v-if="templateError || signingError" class="template-page-error">{{ templateError || signingError }}</p>

    <div class="template-interrogation-grid">
      <div class="formal-column">
        <details v-if="session.status === 'READY'" class="record-preparation-drawer record-no-print">
          <summary>问题准备 / 常用问题库</summary>
        <QuestionPreparationPanel
          :library="questionLibrary"
          :busy="templateBusy"
          :voice-available="questionDictationAvailable"
          :voice-busy="questionDictationActive || questionDictationBusy"
          :voice-draft="questionDictationDraft"
          :voice-error="questionDictationError"
          @load-library="emit('loadLibrary', $event)"
          @add-question="emit('createQuestion', $event)"
          @voice-start="emit('questionDictationStart')"
          @voice-stop="emit('questionDictationStop')"
        />
        </details>

        <FormalTemplatePanel
          :summary="summary"
          :session="session"
          :questions="workspace.questions"
          :rounds="workspace.rounds"
          :busy="templateBusy"
          :document-frozen="documentFrozen"
          :document-locked="documentLocked"
          :signing-state="signingState"
          :signing-busy="signingBusy"
          :capture-running="capture.running"
          :ai-busy="aiBusy"
          :ai-error="aiError"
          @update-question="forwardQuestionUpdate"
          @reorder="emit('reorderQuestions', $event)"
          @remove-question="(id) => emit('removeQuestion', id)"
          @insert-pending="(pendingId, afterQuestionId) => emit('resolvePending', pendingId, { action: 'ADD', afterQuestionId })"
          @update-answer="(id, text) => emit('updateAnswer', id, text)"
          @save-library="emit('saveLibrary', $event)"
          @generate-ai="emit('generateAi')"
          @freeze="finishAndFreeze"
          @sign="openSignature"
        />
      </div>

      <LiveDialoguePanel
        :dialogue="dialogueHistory"
        :partial-text="capture.partialText"
        :pending-questions="workspace.pendingQuestions"
        :questions="workspace.questions"
        :suspect-name="summary.suspectName"
        :capture-running="capture.running"
        :capture-busy="captureBusy"
        :capture-available="nativeCaptureAvailable && canRecord && !documentFrozen"
        :capture-elapsed-ms="captureElapsedMs"
        @capture-toggle="toggleCapture"
        @resolve-pending="(id, resolution) => emit('resolvePending', id, resolution)"
        @correct-fragment="(id, speaker, reason) => emit('correctFragment', id, speaker, reason)"
      />
    </div>

    <div v-if="signatureRole" class="signature-modal" role="dialog" aria-modal="true" aria-label="电子签名">
      <section class="signature-dialog">
        <header>
          <div>
            <span class="panel-kicker">冻结版本签名</span>
            <h2>{{ signatureRole === 'SUSPECT' ? '被讯问人签名' : '民警签名' }}</h2>
          </div>
          <button :disabled="signingBusy === 'sign'" @click="closeSignature">关闭</button>
        </header>
        <p>签名人：{{ signerName(signatureRole) }}。请在下方区域完成手写签名。</p>
        <canvas
          ref="signatureCanvas"
          class="signature-canvas"
          @pointerdown.prevent="startSignatureStroke"
          @pointermove.prevent="moveSignatureStroke"
          @pointerup.prevent="endSignatureStroke"
          @pointercancel.prevent="endSignatureStroke"
        ></canvas>
        <footer>
          <button :disabled="signingBusy === 'sign'" @click="clearSignature">清空重写</button>
          <button class="primary" :disabled="signingBusy === 'sign'" @click="confirmSignature">{{ signingBusy === 'sign' ? '提交中…' : '确认签名' }}</button>
        </footer>
      </section>
    </div>
  </section>
</template>
