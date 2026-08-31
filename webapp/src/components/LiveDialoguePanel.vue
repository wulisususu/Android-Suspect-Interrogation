<script setup lang="ts">
import { computed, nextTick, onMounted, ref, watch } from 'vue'

import type { TemporaryAsrFragment, TemporaryAsrSpeaker } from '../types/interrogation'
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
  correctFragment: [fragmentId: string, speaker: TemporaryAsrSpeaker, reason: string]
}>()

const feed = ref<HTMLElement | null>(null)
const pinnedToBottom = ref(true)
const correctionSpeaker = ref<Record<string, TemporaryAsrSpeaker>>({})
const correctionReason = ref<Record<string, string>>({})

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

          <details v-if="item.recognitionEvidence" class="recognition-evidence-card">
            <summary>
              <span class="evidence-title">识别证据</span>
              <span class="evidence-store-badge">独立证据已入库</span>
              <span>AI 原判：{{ speakerLabel(item.recognitionEvidence.aiSpeaker) }}</span>
              <span v-if="item.recognitionEvidence.score != null">Score {{ scoreText(item.recognitionEvidence.score) }}</span>
            </summary>

            <div class="evidence-grid">
              <div><small>AI 原判</small><strong>{{ speakerLabel(item.recognitionEvidence.aiSpeaker) }}</strong></div>
              <div><small>Score</small><strong>{{ scoreText(item.recognitionEvidence.score) }}</strong></div>
              <div><small>第二候选</small><strong>{{ scoreText(item.recognitionEvidence.secondBestScore) }}</strong></div>
              <div><small>Threshold</small><strong>{{ scoreText(item.recognitionEvidence.threshold) }}</strong></div>
              <div><small>Margin</small><strong>{{ scoreText(item.recognitionEvidence.margin) }}</strong></div>
              <div><small>阈值来源</small><strong>{{ thresholdSourceLabel(item.recognitionEvidence.thresholdSource) }}</strong></div>
              <div><small>声纹模型</small><strong>{{ item.recognitionEvidence.speakerModelId || 'xvector' }} {{ item.recognitionEvidence.speakerModelVersion || '—' }}</strong></div>
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

          <div v-else class="recognition-evidence-missing">
            识别证据尚未独立入库（历史数据迁移后将自动补齐）
          </div>

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

<style scoped>
.recognition-evidence-card {
  margin-top: 8px;
  border: 1px solid rgba(76, 112, 156, .28);
  border-radius: 10px;
  background: rgba(245, 249, 253, .9);
  font-size: 12px;
}
.recognition-evidence-card summary {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  align-items: center;
  cursor: pointer;
  padding: 8px 10px;
  color: #48596b;
}
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
</style>
