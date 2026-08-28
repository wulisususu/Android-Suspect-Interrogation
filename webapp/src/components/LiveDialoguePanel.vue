<script setup lang="ts">
import { computed, nextTick, onMounted, ref, watch } from 'vue'

import type { TemporaryAsrFragment } from '../types/interrogation'
import type {
  FormalQuestion,
  PendingFormalQuestion,
  PendingResolution,
} from '../types/templateInterrogation'
import { dialoguePresentation } from '../utils/templateInterrogation'

const props = defineProps<{
  dialogue: TemporaryAsrFragment[]
  partialText: string
  pendingQuestions: PendingFormalQuestion[]
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
}>()

const feed = ref<HTMLElement | null>(null)
const pinnedToBottom = ref(true)

const elapsed = computed(() => {
  const total = Math.floor(props.captureElapsedMs / 1000)
  return `${String(Math.floor(total / 60)).padStart(2, '0')}:${String(total % 60).padStart(2, '0')}`
})

function visibleText(item: TemporaryAsrFragment) {
  return (item.editedText || item.rawText || '').trim()
}

function formatTime(item: TemporaryAsrFragment) {
  if (!item.createdAt) return ''
  return new Intl.DateTimeFormat('zh-CN', {
    hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: false,
  }).format(new Date(item.createdAt))
}

function speakerName(item: TemporaryAsrFragment) {
  const presentation = dialoguePresentation(item)
  if (item.speaker === 'SUSPECT') return props.suspectName || item.speakerName || presentation.badge
  return item.speakerName || presentation.badge
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
  () => [props.dialogue.length, props.partialText, props.pendingQuestions.map((item) => `${item.id}:${item.status}`).join('|')],
  () => { void scrollToLatest() },
)

onMounted(() => { void scrollToLatest(true) })
</script>

<template>
  <aside class="live-dialogue-panel">
    <header class="live-dialogue-header">
      <div>
        <span class="panel-kicker">原始对话流</span>
        <h2>实时语音对话</h2>
      </div>
      <button
        class="capture-toggle"
        :class="{ active: captureRunning }"
        :disabled="captureBusy || !captureAvailable"
        @click="emit('captureToggle')"
      >
        <span class="record-dot"></span>
        {{ captureRunning ? `停止录音 ${elapsed}` : '开始录音' }}
      </button>
    </header>

    <div ref="feed" class="dialogue-feed" @scroll="onFeedScroll">
      <div v-if="!dialogue.length && !partialText" class="dialogue-empty">
        <strong>等待现场对话</strong>
        <p>这里按实际说话顺序保留原始识别结果；正式笔录在左侧独立整理。</p>
      </div>

      <template v-for="item in dialogue" :key="item.id">
        <article
          class="dialogue-turn"
          :class="`side-${dialoguePresentation(item).side}`"
          :data-fragment-id="item.id"
        >
          <div class="dialogue-meta">
            <strong>{{ speakerName(item) }}</strong>
            <span>{{ dialoguePresentation(item).badge }}</span>
            <time>{{ formatTime(item) }}</time>
          </div>
          <div class="dialogue-bubble">{{ visibleText(item) || '（无可显示文本）' }}</div>

          <section v-if="pendingFor(item.id)" class="pending-resolution-card">
            <template v-if="pendingFor(item.id)?.matchStatus === 'UNMATCHED'">
              <p>未匹配正式笔录问题</p>
              <div class="pending-actions">
                <button class="primary" @click="resolve(pendingFor(item.id)!, { action: 'ADD' })">加入本案笔录</button>
                <button @click="resolve(pendingFor(item.id)!, { action: 'IGNORE' })">忽略</button>
              </div>
            </template>

            <template v-else-if="pendingFor(item.id)?.matchStatus === 'AMBIGUOUS'">
              <p>可能对应多个正式问题，请人工确认</p>
              <div class="candidate-list">
                <button
                  v-for="candidate in candidateQuestions(pendingFor(item.id)!)"
                  :key="candidate.id"
                  @click="resolve(pendingFor(item.id)!, { action: 'LINK', caseQuestionId: candidate.id, roundMode: 'NEW_ROUND' })"
                >
                  对应：{{ candidate.text }}
                </button>
              </div>
              <div class="pending-actions">
                <button class="primary" @click="resolve(pendingFor(item.id)!, { action: 'ADD' })">新建本案问题</button>
                <button @click="resolve(pendingFor(item.id)!, { action: 'IGNORE' })">忽略</button>
              </div>
            </template>

            <template v-else-if="pendingFor(item.id)?.matchStatus === 'MATCHED_EXISTING'">
              <p>该问题已在本案笔录中出现，请选择本次问答如何记录</p>
              <div class="pending-actions">
                <button
                  v-if="pendingFor(item.id)!.candidateQuestionIds[0]"
                  class="primary"
                  @click="resolve(pendingFor(item.id)!, { action: 'LINK', caseQuestionId: pendingFor(item.id)!.candidateQuestionIds[0], roundMode: 'APPEND_EXISTING' })"
                >追加到原回答</button>
                <button
                  v-if="pendingFor(item.id)!.candidateQuestionIds[0]"
                  @click="resolve(pendingFor(item.id)!, { action: 'LINK', caseQuestionId: pendingFor(item.id)!.candidateQuestionIds[0], roundMode: 'NEW_ROUND' })"
                >新增一轮问答</button>
              </div>
            </template>
          </section>
        </article>
      </template>

      <article v-if="partialText" class="dialogue-turn side-neutral partial-turn">
        <div class="dialogue-meta"><strong>正在识别…</strong></div>
        <div class="dialogue-bubble">{{ partialText }}</div>
      </article>
    </div>

    <button v-if="!pinnedToBottom" class="latest-button" @click="scrollToLatest(true)">↓ 最新消息</button>
  </aside>
</template>
