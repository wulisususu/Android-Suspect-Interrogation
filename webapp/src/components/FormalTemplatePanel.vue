<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue'
import type { CaseSummary, DocumentSignerRole, DocumentSigningState, SessionState } from '../types/interrogation'
import type { CaseQuestionUpdateInput, FormalQuestion, FormalQuestionRound } from '../types/templateInterrogation'

const props = defineProps<{
  summary: CaseSummary
  session: SessionState
  questions: FormalQuestion[]
  rounds: FormalQuestionRound[]
  busy: boolean
  documentFrozen: boolean
  documentLocked: boolean
  signingState: DocumentSigningState | null
  signingBusy: string
  captureRunning: boolean
  aiBusy: boolean
  aiError: string
}>()

const emit = defineEmits<{
  updateQuestion: [questionId: string, input: CaseQuestionUpdateInput]
  reorder: [questionIds: string[]]
  removeQuestion: [questionId: string]
  updateAnswer: [targetId: string, answerText: string]
  saveLibrary: [questionId: string]
  insertPending: [pendingId: string, afterQuestionId: string | null]
  generateAi: []
  freeze: []
  sign: [role: DocumentSignerRole]
}>()

const questionDrafts = reactive<Record<string, string>>({})
const canonicalAnswerDrafts = reactive<Record<string, string>>({})
const draggingBodyId = ref('')
const dragOverKey = ref('')
const orderedQuestions = computed(() => [...props.questions].sort((a, b) => a.sortOrder - b.sortOrder))
const openingQuestions = computed(() => orderedQuestions.value.filter((q) => q.sectionType === 'OPENING'))
const bodyQuestions = computed(() => orderedQuestions.value.filter((q) => q.sectionType === 'BODY'))
const closingQuestions = computed(() => orderedQuestions.value.filter((q) => q.sectionType === 'CLOSING'))
const lastOpeningId = computed(() => openingQuestions.value.at(-1)?.id ?? null)

watch(() => props.questions, (items) => {
  for (const item of items) {
    questionDrafts[item.id] = item.text
    canonicalAnswerDrafts[item.id] = item.formalAnswerText ?? ''
  }
}, { immediate: true, deep: true })

function roundsFor(questionId: string) {
  return props.rounds.filter((r) => r.caseQuestionId === questionId && r.status !== 'DETACHED').sort((a, b) => a.roundNo - b.roundNo)
}
function latestRound(questionId: string) { return roundsFor(questionId).at(-1) }
function saveQuestion(question: FormalQuestion) {
  if (question.locked || props.documentFrozen || props.busy) return
  const text = (questionDrafts[question.id] || '').trim()
  if (text && text !== question.text.trim()) emit('updateQuestion', question.id, { text })
}
function saveCanonicalAnswer(question: FormalQuestion) {
  if (props.documentFrozen || props.busy) return
  const answer = (canonicalAnswerDrafts[question.id] || '').trim()
  if (answer !== (question.formalAnswerText ?? '').trim()) emit('updateAnswer', question.id, answer)
}
function signatureFor(role: DocumentSignerRole) { return props.signingState?.signatures.find((s) => s.signerRole === role) }
function formatSignedAt(value?: number) {
  return value ? new Intl.DateTimeFormat('zh-CN', { month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hour12: false }).format(new Date(value)) : ''
}
function formatRecordTime(value?: number | null) {
  if (!value) return '____年__月__日__时__分'
  const d = new Date(value)
  return `${d.getFullYear()}年${d.getMonth() + 1}月${d.getDate()}日 ${String(d.getHours()).padStart(2, '0')}时${String(d.getMinutes()).padStart(2, '0')}分`
}
function startBodyDrag(event: DragEvent, id: string) {
  if (props.documentFrozen || props.busy || !event.dataTransfer) return
  draggingBodyId.value = id
  event.dataTransfer.effectAllowed = 'move'
  event.dataTransfer.setData('application/x-formal-body-question', id)
}
function dropBody(event: DragEvent, targetId: string) {
  event.preventDefault()
  const sourceId = event.dataTransfer?.getData('application/x-formal-body-question') || draggingBodyId.value
  if (!sourceId || sourceId === targetId) return
  const ids = bodyQuestions.value.map((q) => q.id)
  const from = ids.indexOf(sourceId); const to = ids.indexOf(targetId)
  if (from < 0 || to < 0) return
  ids.splice(to, 0, ids.splice(from, 1)[0])
  emit('reorder', ids)
  draggingBodyId.value = ''; dragOverKey.value = ''
}
function allowPendingDrop(event: DragEvent, key: string) {
  if (!props.documentFrozen && event.dataTransfer?.types.includes('application/x-formal-pending-question')) {
    event.preventDefault(); event.dataTransfer.dropEffect = 'copy'; dragOverKey.value = key
  }
}
function dropPending(event: DragEvent, afterQuestionId: string | null) {
  event.preventDefault(); dragOverKey.value = ''
  const raw = event.dataTransfer?.getData('application/x-formal-pending-question')
  if (!raw || props.documentFrozen) return
  try { const payload = JSON.parse(raw) as { pendingId?: string }; if (payload.pendingId) emit('insertPending', payload.pendingId, afterQuestionId) } catch { /* invalid external drag */ }
}
</script>

<template>
  <section class="formal-record-shell">
    <article class="formal-record-paper" aria-label="正式询问笔录编辑器">
      <header class="record-paper-header">
        <div class="record-title-block"><h1>询问笔录</h1><span>第 1 次</span></div>
        <div class="record-top-actions record-no-print">
          <button :disabled="aiBusy" @click="emit('generateAi')">{{ aiBusy ? 'AI 梳理中…' : '案件 AI 梳理' }}</button>
          <button class="primary" :disabled="documentFrozen || signingBusy !== '' || captureRunning" @click="emit('freeze')">
            {{ signingBusy === 'freeze' ? '正在冻结…' : documentFrozen ? '笔录已冻结' : '结束并冻结笔录' }}
          </button>
          <button :disabled="!signingState || !!signatureFor('SUSPECT') || signingBusy !== '' || documentLocked" @click="emit('sign', 'SUSPECT')">
            {{ signatureFor('SUSPECT') ? `被询问人已签 ${formatSignedAt(signatureFor('SUSPECT')?.signedAt)}` : '被询问人签名' }}
          </button>
          <button :disabled="!signingState || !!signatureFor('OFFICER') || signingBusy !== '' || documentLocked" @click="emit('sign', 'OFFICER')">
            {{ signatureFor('OFFICER') ? `民警已签 ${formatSignedAt(signatureFor('OFFICER')?.signedAt)}` : '民警签名' }}
          </button>
        </div>
      </header>

      <p v-if="aiError" class="inline-error record-no-print">{{ aiError }}</p>
      <section class="record-meta-grid">
        <p><b>时间</b><span>{{ formatRecordTime(session.startedAt || summary.createdAt) }} 至 {{ session.endedAt ? formatRecordTime(session.endedAt) : '____________' }}</span></p>
        <p><b>地点</b><span>____________________________________________</span></p>
        <p><b>询问人</b><span>{{ summary.officerName || '________' }}　工作单位 ________________________</span></p>
        <p><b>记录人</b><span>________　工作单位 ______________________________</span></p>
        <p><b>被询问人</b><span>{{ summary.suspectName || '________' }}</span></p>
        <p><b>身份证证件种类及号码</b><span>身份证，{{ summary.idNumber || '________________________' }}</span></p>
        <p><b>性别</b><span>{{ summary.gender || '____' }}　出生日期 {{ summary.birthDate || '____________' }}</span></p>
        <p><b>联系方式</b><span>____________________________________________</span></p>
        <p><b>现住址</b><span>{{ summary.address || '____________________________________________' }}</span></p>
        <p><b>户籍所在地</b><span>____________________________________________</span></p>
      </section>

      <section class="record-qa-section fixed-opening">
        <div v-for="q in openingQuestions" :key="q.id" class="record-qa fixed-question">
          <p class="record-question"><b>问：</b><span>{{ q.text }}</span></p>
          <label class="record-answer"><b>答：</b><textarea v-model="canonicalAnswerDrafts[q.id]" :disabled="busy || documentFrozen" rows="1" @blur="saveCanonicalAnswer(q)"></textarea></label>
          <small v-if="latestRound(q.id)?.actualQuestionText && latestRound(q.id)?.actualQuestionText !== q.text" class="actual-question record-no-print">现场原问法：{{ latestRound(q.id)?.actualQuestionText }}</small>
        </div>
      </section>

      <div class="record-section-label record-no-print"><span>案件动态问答区</span><small>右侧实时对话可拖入；本区可拖动排序、编辑或移出</small></div>
      <div class="record-drop-zone record-no-print" :class="{ active: dragOverKey === 'body-start' }" @dragover="allowPendingDrop($event, 'body-start')" @dragleave="dragOverKey = ''" @drop="dropPending($event, lastOpeningId)">拖到这里插入为第一条案件问题</div>

      <section class="record-qa-section body-section">
        <article v-for="q in bodyQuestions" :key="q.id" class="record-qa body-question" draggable="true" @dragstart="startBodyDrag($event, q.id)" @dragover.prevent @drop="dropBody($event, q.id)">
          <div class="body-question-tools record-no-print"><span class="drag-handle" title="拖动排序">⋮⋮</span><span>{{ q.source === 'LIVE' ? '实时对话' : q.source === 'STANDARD' ? '问题库' : '本案问题' }}</span><button :disabled="busy || documentFrozen" @click="emit('saveLibrary', q.id)">存入题库</button><button class="danger-link" :disabled="busy || documentFrozen" @click="emit('removeQuestion', q.id)">移出笔录</button></div>
          <label class="record-question editable-question"><b>问：</b><textarea v-model="questionDrafts[q.id]" :disabled="busy || documentFrozen" rows="1" @blur="saveQuestion(q)"></textarea></label>
          <label class="record-answer"><b>答：</b><textarea v-model="canonicalAnswerDrafts[q.id]" :disabled="busy || documentFrozen" rows="2" placeholder="等待现场回答" @blur="saveCanonicalAnswer(q)"></textarea></label>
          <small v-if="latestRound(q.id)?.actualQuestionText && latestRound(q.id)?.actualQuestionText !== q.text" class="actual-question record-no-print">现场原问法：{{ latestRound(q.id)?.actualQuestionText }}</small>
          <div class="record-drop-zone compact record-no-print" :class="{ active: dragOverKey === q.id }" @dragover="allowPendingDrop($event, q.id)" @dragleave="dragOverKey = ''" @drop="dropPending($event, q.id)">拖到这里，插入在本题之后</div>
        </article>
        <div v-if="!bodyQuestions.length" class="record-body-empty record-no-print">案件动态问答区暂为空。将右侧民警提问拖到这里，或从问题准备区加入。</div>
      </section>

      <section class="record-qa-section fixed-closing">
        <div v-for="q in closingQuestions" :key="q.id" class="record-qa fixed-question">
          <p class="record-question"><b>问：</b><span>{{ q.text }}</span></p>
          <label class="record-answer"><b>答：</b><textarea v-model="canonicalAnswerDrafts[q.id]" :disabled="busy || documentFrozen" rows="1" @blur="saveCanonicalAnswer(q)"></textarea></label>
          <small v-if="latestRound(q.id)?.actualQuestionText && latestRound(q.id)?.actualQuestionText !== q.text" class="actual-question record-no-print">现场原问法：{{ latestRound(q.id)?.actualQuestionText }}</small>
        </div>
      </section>

      <footer class="record-integrity-footer">
        <span v-if="signingState">冻结版本 {{ signingState.version }} · 完整性{{ signingState.integrityValid ? '已校验' : '异常' }}</span>
        <span v-else>正式问题 {{ orderedQuestions.length }} · 问答轮次 {{ rounds.filter((r) => r.status !== 'DETACHED').length }}</span>
      </footer>
    </article>
  </section>
</template>
