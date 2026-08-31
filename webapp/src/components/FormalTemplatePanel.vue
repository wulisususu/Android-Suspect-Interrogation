<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue'

import type {
  DocumentSignerRole,
  DocumentSigningState,
} from '../types/interrogation'
import type {
  CaseQuestionUpdateInput,
  FormalQuestion,
  FormalQuestionRound,
  RoundReassociateInput,
} from '../types/templateInterrogation'

const props = defineProps<{
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
  updateAnswer: [roundId: string, answerText: string]
  reassociate: [roundId: string, input: RoundReassociateInput]
  saveLibrary: [questionId: string]
  generateAi: []
  freeze: []
  sign: [role: DocumentSignerRole]
}>()

const questionDrafts = reactive<Record<string, string>>({})
const answerDrafts = reactive<Record<string, string>>({})
const reassociateTargets = reactive<Record<string, string>>({})
const expandedQuestionIds = ref<Set<string>>(new Set())

const orderedQuestions = computed(() => [...props.questions].sort((left, right) => left.sortOrder - right.sortOrder))

watch(
  () => props.questions,
  (items) => {
    for (const item of items) {
      if (!(item.id in questionDrafts)) questionDrafts[item.id] = item.text
      if (questionDrafts[item.id] === undefined) questionDrafts[item.id] = item.text
    }
  },
  { immediate: true, deep: true },
)

watch(
  () => props.rounds,
  (items) => {
    for (const item of items) {
      if (!(item.id in answerDrafts)) answerDrafts[item.id] = item.answerText
    }
  },
  { immediate: true, deep: true },
)

function roundsFor(questionId: string) {
  return props.rounds
    .filter((round) => round.caseQuestionId === questionId && round.status !== 'DETACHED')
    .sort((left, right) => {
      const leftTime = left.startedAt ? Date.parse(left.startedAt) : Number.MAX_SAFE_INTEGER
      const rightTime = right.startedAt ? Date.parse(right.startedAt) : Number.MAX_SAFE_INTEGER
      return leftTime - rightTime || left.roundNo - right.roundNo
    })
}

function latestRound(questionId: string) {
  const items = roundsFor(questionId)
  return items[items.length - 1]
}

function visibleRounds(questionId: string) {
  const items = roundsFor(questionId)
  if (expandedQuestionIds.value.has(questionId) || items.length <= 1) return items
  return items.slice(-1)
}

function toggleRounds(questionId: string) {
  const next = new Set(expandedQuestionIds.value)
  if (next.has(questionId)) next.delete(questionId)
  else next.add(questionId)
  expandedQuestionIds.value = next
}

function saveQuestion(question: FormalQuestion) {
  if (props.documentFrozen || props.busy) {
    questionDrafts[question.id] = question.text
    return
  }
  const text = (questionDrafts[question.id] || '').trim()
  if (!text || text === question.text.trim()) return
  emit('updateQuestion', question.id, { text })
}

function saveAnswer(round: FormalQuestionRound) {
  if (props.documentFrozen || props.busy) {
    answerDrafts[round.id] = round.answerText
    return
  }
  const answerText = (answerDrafts[round.id] || '').trim()
  if (answerText === round.answerText.trim()) return
  emit('updateAnswer', round.id, answerText)
}

function moveQuestion(questionId: string, direction: -1 | 1) {
  if (props.documentFrozen || props.busy) return
  const ids = orderedQuestions.value.map((item) => item.id)
  const index = ids.indexOf(questionId)
  const target = index + direction
  if (index < 0 || target < 0 || target >= ids.length) return
  ;[ids[index], ids[target]] = [ids[target], ids[index]]
  emit('reorder', ids)
}

function applyReassociation(round: FormalQuestionRound) {
  const targetId = reassociateTargets[round.id]
  if (!targetId || props.documentFrozen || props.busy) return
  emit('reassociate', round.id, { caseQuestionId: targetId })
  reassociateTargets[round.id] = ''
}

function createQuestionFromRound(round: FormalQuestionRound) {
  if (props.documentFrozen || props.busy) return
  emit('reassociate', round.id, { newQuestionText: round.actualQuestionText || '现场新增问题' })
}

function signatureFor(role: DocumentSignerRole) {
  return props.signingState?.signatures.find((item) => item.signerRole === role)
}

function formatSignedAt(value?: number) {
  if (!value) return ''
  return new Intl.DateTimeFormat('zh-CN', {
    year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hour12: false,
  }).format(new Date(value))
}
</script>

<template>
  <section class="formal-template-panel">
    <div class="formal-toolbar">
      <div class="formal-summary">
        <span>正式问题 <strong>{{ orderedQuestions.length }}</strong></span>
        <span>问答轮次 <strong>{{ rounds.filter((item) => item.status !== 'DETACHED').length }}</strong></span>
        <span v-if="documentFrozen">当前版本已冻结</span>
      </div>
      <div class="formal-toolbar-actions">
        <button :disabled="aiBusy" @click="emit('generateAi')">{{ aiBusy ? '案件 AI 梳理中…' : '案件 AI 梳理' }}</button>
        <button
          class="primary"
          :disabled="documentFrozen || signingBusy !== '' || captureRunning"
          @click="emit('freeze')"
        >{{ signingBusy === 'freeze' ? '正在冻结…' : documentFrozen ? '笔录已冻结' : '结束并冻结笔录' }}</button>
      </div>
    </div>
    <p v-if="aiError" class="inline-error">{{ aiError }}</p>

    <div class="formal-question-list">
      <article v-if="!orderedQuestions.length" class="formal-empty">
        <strong>本案尚未配置正式问题</strong>
        <p>审讯开始前可从问题库选择或手动加入；现场新问题也可从右侧对话流加入本案笔录。</p>
      </article>

      <article v-for="(question, index) in orderedQuestions" :key="question.id" class="formal-question-card">
        <header class="formal-question-heading">
          <span class="formal-index">{{ String(index + 1).padStart(2, '0') }}</span>
          <div class="question-source">
            <strong>{{ question.source === 'STANDARD' ? '标准问题' : question.source === 'LIVE' ? '现场新增' : '本案问题' }}</strong>
            <span>{{ roundsFor(question.id).length }} 轮问答</span>
          </div>
          <div class="question-order-actions">
            <button :disabled="index === 0 || busy || documentFrozen" aria-label="问题上移" @click="moveQuestion(question.id, -1)">↑</button>
            <button :disabled="index === orderedQuestions.length - 1 || busy || documentFrozen" aria-label="问题下移" @click="moveQuestion(question.id, 1)">↓</button>
          </div>
        </header>

        <label class="formal-question-editor">
          <span>问：</span>
          <textarea
            v-model="questionDrafts[question.id]"
            :disabled="busy || documentFrozen"
            rows="2"
            @blur="saveQuestion(question)"
          ></textarea>
        </label>

        <div v-if="roundsFor(question.id).length" class="formal-rounds">
          <button
            v-if="roundsFor(question.id).length > 1"
            class="round-toggle"
            @click="toggleRounds(question.id)"
          >
            {{ expandedQuestionIds.has(question.id) ? '收起历史轮次' : `展开前 ${roundsFor(question.id).length - 1} 轮` }}
          </button>

          <section v-for="round in visibleRounds(question.id)" :key="round.id" class="formal-round">
            <div class="round-meta">
              <strong>第 {{ round.roundNo }} 轮</strong>
              <span>{{ round.status === 'ACTIVE' ? '当前问答' : '已记录' }}</span>
              <span v-if="round.actualQuestionText && round.actualQuestionText !== question.text">现场问法：{{ round.actualQuestionText }}</span>
            </div>
            <label class="formal-answer-editor">
              <span>答：</span>
              <textarea
                v-model="answerDrafts[round.id]"
                :disabled="busy || documentFrozen"
                :placeholder="round.status === 'ACTIVE' ? '等待嫌疑人回答…' : '未记录回答'"
                rows="3"
                @blur="saveAnswer(round)"
              ></textarea>
            </label>
            <div v-if="!documentFrozen" class="round-reassociate">
              <span>重新关联</span>
              <select v-model="reassociateTargets[round.id]" :disabled="busy">
                <option value="">选择已有正式问题</option>
                <option v-for="target in orderedQuestions" :key="target.id" :value="target.id">{{ target.text }}</option>
              </select>
              <button :disabled="!reassociateTargets[round.id] || busy" @click="applyReassociation(round)">确认</button>
              <button :disabled="busy" @click="createQuestionFromRound(round)">新建本案问题</button>
            </div>
          </section>
        </div>
        <div v-else class="formal-no-answer">尚未产生本题现场问答</div>

        <footer class="formal-question-footer">
          <span v-if="latestRound(question.id)">最近一轮：第 {{ latestRound(question.id)?.roundNo }} 轮</span>
          <button v-if="question.source !== 'STANDARD'" :disabled="busy || documentFrozen" @click="emit('saveLibrary', question.id)">保存为常用问题</button>
        </footer>
      </article>
    </div>

    <footer class="formal-signing-footer">
      <div>
        <strong>电子签名</strong>
        <p v-if="!signingState">结束审讯并冻结正式笔录后，方可签名。</p>
        <p v-else>冻结版本 {{ signingState.version }} · 完整性{{ signingState.integrityValid ? '已校验' : '异常' }}</p>
      </div>
      <div class="signature-actions">
        <button
          :disabled="!signingState || !!signatureFor('SUSPECT') || signingBusy !== '' || documentLocked"
          @click="emit('sign', 'SUSPECT')"
        >
          {{ signatureFor('SUSPECT') ? `被讯问人已签 ${formatSignedAt(signatureFor('SUSPECT')?.signedAt)}` : '被讯问人签名' }}
        </button>
        <button
          :disabled="!signingState || !!signatureFor('OFFICER') || signingBusy !== '' || documentLocked"
          @click="emit('sign', 'OFFICER')"
        >
          {{ signatureFor('OFFICER') ? `民警已签 ${formatSignedAt(signatureFor('OFFICER')?.signedAt)}` : '民警签名' }}
        </button>
      </div>
    </footer>
  </section>
</template>
