<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue'
import {
  backendErrorMessage,
  persistQuestionOrAnswer,
  updateTranscriptMessage,
} from '../api/interrogation'
import type { AsrCaptureStatus, CaseSummary, TranscriptMessage } from '../types/interrogation'

const props = defineProps<{
  caseId: string
  summary: CaseSummary
  messages: TranscriptMessage[]
  capture: AsrCaptureStatus
  canRecord: boolean
  nativeCaptureAvailable: boolean
  captureBusy: boolean
  captureElapsedMs: number
  aiBusy: boolean
  aiError: string
}>()
const emit = defineEmits<{
  saved: []
  captureStart: []
  captureStop: []
  generateAi: []
}>()

type EntryRole = '民警' | '嫌疑人'
type QaPair = { question?: TranscriptMessage; answer?: TranscriptMessage }

const text = ref('')
const entryRole = ref<EntryRole>('嫌疑人')
const saving = ref(false)
const localError = ref('')
const editingIds = ref<string[]>([])
const drafts = reactive<Record<string, string>>({})

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

const documentDate = computed(() => {
  const value = props.summary.createdAt
  if (!value) return '未记录'
  return new Intl.DateTimeFormat('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
  }).format(new Date(value))
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

function rowsFor(value: string | undefined, minimum = 2) {
  const textValue = value || ''
  const visualLines = textValue.split('\n').reduce((sum, line) => sum + Math.max(1, Math.ceil(line.length / 38)), 0)
  return Math.max(minimum, Math.min(12, visualLines))
}

function markEditing(id: string, editing: boolean) {
  if (editing && !editingIds.value.includes(id)) editingIds.value.push(id)
  if (!editing) editingIds.value = editingIds.value.filter((item) => item !== id)
}

async function saveEdit(item?: TranscriptMessage) {
  if (!item || editingIds.value.includes(`saving:${item.id}`)) return
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
  if (!props.canRecord) {
    localError.value = '请先开始审讯，再保存审讯记录。'
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
  if (props.capture.running) emit('captureStop')
  else emit('captureStart')
}
</script>

<template>
  <section class="interrogation-page page-card document-mode">
    <header class="page-card-header interrogation-header">
      <div>
        <h2>审讯记录</h2>
        <p>单栏 A4 文档式笔录；问答正文可直接编辑，失焦后保存并保留修订记录。</p>
      </div>
      <button class="ai-generate-button" :disabled="aiBusy" @click="$emit('generateAi')">
        {{ aiBusy ? 'AI 梳理中…' : '✦ 生成 AI 案件梳理' }}
      </button>
    </header>

    <div class="document-scroll">
      <article class="interrogation-paper" aria-label="讯问笔录文档">
        <div class="demo-watermark">模拟案件 · 全部信息均为虚构</div>
        <h1>讯 问 笔 录</h1>
        <p class="document-subtitle">案件审讯记录（演示稿）</p>

        <div class="document-meta">
          <div><span>案件编号</span><strong>{{ summary.id || caseId }}</strong></div>
          <div><span>被讯问人</span><strong>{{ summary.suspectName || '待录入' }}</strong></div>
          <div><span>讯问人</span><strong>{{ summary.officerName || '当前警官' }}</strong></div>
          <div><span>建档时间</span><strong>{{ documentDate }}</strong></div>
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
              :rows="rowsFor(drafts[pair.question.id], 2)"
              aria-label="民警问题，可编辑"
              @focus="markEditing(pair.question.id, true)"
              @blur="saveEdit(pair.question)"
            ></textarea>
          </div>

          <div v-if="pair.answer" class="qa-line answer-line">
            <strong class="qa-label">答：</strong>
            <textarea
              v-model="drafts[pair.answer.id]"
              class="document-editor answer-editor"
              :rows="rowsFor(drafts[pair.answer.id], 3)"
              aria-label="嫌疑人回答，可编辑"
              @focus="markEditing(pair.answer.id, true)"
              @blur="saveEdit(pair.answer)"
            ></textarea>
          </div>
        </section>

        <section v-if="capture.fragments.length || capture.partialText" class="voice-draft-section">
          <h2>语音转写草稿</h2>
          <p class="voice-draft-note">以下内容尚未作为正式问答归档，可继续录音或人工整理后再保存。</p>
          <div v-for="fragment in capture.fragments" :key="fragment.id" class="voice-draft-row">
            {{ fragment.editedText || fragment.rawText || '等待识别文本……' }}
          </div>
          <div v-if="capture.partialText" class="voice-live-row">{{ capture.partialText }}</div>
        </section>

        <div class="document-end">—— 本页以下无正文 ——</div>
      </article>
    </div>

    <div v-if="localError || aiError || capture.error" class="interrogation-error">
      {{ localError || aiError || capture.error }}
    </div>

    <footer class="interrogation-composer document-composer">
      <button
        class="record-button"
        :class="{ active: capture.running }"
        :disabled="captureBusy || !nativeCaptureAvailable || (!canRecord && !capture.running)"
        :title="nativeCaptureAvailable ? '开始 / 停止离线录音' : '录音仅在 Android APK 中可用'"
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
        :placeholder="entryRole === '民警' ? '输入新的讯问问题……' : '输入新的嫌疑人回答……'"
        @keydown.ctrl.enter.prevent="appendRecord"
      ></textarea>
      <button class="primary-action record-save" :disabled="!text.trim() || !canRecord || saving" @click="appendRecord">
        {{ saving ? '保存中…' : '加入笔录' }}
      </button>
    </footer>
  </section>
</template>

<style scoped>
.document-mode { display: flex; flex-direction: column; background: #eef1f4; }
.interrogation-header { flex: 0 0 auto; }
.document-scroll {
  flex: 1 1 auto;
  min-height: 0;
  overflow: auto;
  padding: 24px 30px 42px;
  background: #e8ebee;
}
.interrogation-paper {
  position: relative;
  box-sizing: border-box;
  width: min(210mm, 100%);
  min-height: 297mm;
  margin: 0 auto;
  padding: 24mm 23mm 26mm 28mm;
  background: #fff;
  box-shadow: 0 8px 28px rgba(26, 39, 51, .14);
  color: #111;
  font-family: SimSun, "宋体", "Songti SC", serif;
  font-size: 12pt;
  line-height: 1.75;
}
.demo-watermark {
  position: absolute;
  top: 12mm;
  right: 14mm;
  color: #9a4b4b;
  border: 1px solid #d7aaaa;
  padding: 2px 8px;
  font: 9pt/1.5 SimSun, "宋体", serif;
  letter-spacing: .08em;
}
.interrogation-paper > h1 {
  margin: 8mm 0 2mm;
  text-align: center;
  font-family: SimHei, "黑体", sans-serif;
  font-size: 22pt;
  line-height: 1.35;
  letter-spacing: .24em;
  font-weight: 700;
}
.document-subtitle {
  margin: 0 0 9mm;
  text-align: center;
  font-size: 12pt;
  letter-spacing: .08em;
}
.document-meta {
  display: grid;
  grid-template-columns: 1fr 1fr;
  column-gap: 12mm;
  row-gap: 3mm;
  margin-bottom: 9mm;
  padding: 4mm 0;
  border-top: 1px solid #333;
  border-bottom: 1px solid #333;
  font-size: 10.5pt;
  line-height: 1.6;
}
.document-meta div { display: grid; grid-template-columns: 4.5em 1fr; gap: 4px; min-width: 0; }
.document-meta span { color: #444; }
.document-meta strong { font-weight: 400; word-break: break-all; }
.document-empty { margin: 24mm 0; text-align: center; color: #777; }
.document-empty p { margin: 2mm 0; text-indent: 0; }
.qa-block {
  position: relative;
  padding: 4mm 0 5mm;
  border-bottom: 1px dotted #c9c9c9;
}
.qa-block:last-of-type { border-bottom: 0; }
.qa-number {
  position: absolute;
  left: -13mm;
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
  letter-spacing: 0;
}
.answer-editor { text-indent: 2em; }
.document-editor:hover { background: #fbfcfd; border-color: #edf0f2; }
.document-editor:focus {
  background: #fffef5;
  border-color: #8fb6d8;
  box-shadow: 0 0 0 2px rgba(47, 128, 237, .08);
}
.voice-draft-section {
  margin-top: 10mm;
  padding-top: 6mm;
  border-top: 1px solid #aaa;
}
.voice-draft-section h2 {
  margin: 0 0 2mm;
  font: 700 14pt/1.5 SimHei, "黑体", sans-serif;
}
.voice-draft-note { margin: 0 0 4mm; color: #666; font-size: 10.5pt; text-indent: 2em; }
.voice-draft-row, .voice-live-row {
  margin: 2mm 0;
  padding: 3mm 4mm;
  background: #f6f8fa;
  border-left: 3px solid #9eb9ce;
  font-size: 10.5pt;
}
.voice-live-row { border-left-color: #d66; background: #fff8f8; }
.document-end {
  margin-top: 12mm;
  text-align: center;
  color: #777;
  font-size: 10.5pt;
  letter-spacing: .08em;
}
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
.role-switch button {
  border: 0;
  border-right: 1px solid #c8d4dd;
  background: #fff;
  color: #5f7180;
  padding: 8px 10px;
  white-space: nowrap;
}
.role-switch button:last-child { border-right: 0; }
.role-switch button.active { background: #edf5ff; color: #1769c8; font-weight: 700; }
.document-composer > textarea {
  width: 100%;
  box-sizing: border-box;
  min-height: 40px;
  max-height: 110px;
  resize: vertical;
  border: 1px solid #ccd7df;
  border-radius: 8px;
  padding: 9px 11px;
  font: 14px/1.5 "Microsoft YaHei", sans-serif;
}
@media (max-width: 900px) {
  .document-scroll { padding: 12px; }
  .interrogation-paper { min-height: 0; padding: 64px 28px 44px; }
  .document-meta { grid-template-columns: 1fr; }
  .document-composer { grid-template-columns: auto 1fr auto; }
  .role-switch { grid-column: 1 / -1; width: max-content; }
}
</style>
