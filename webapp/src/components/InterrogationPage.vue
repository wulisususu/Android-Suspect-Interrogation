<script setup lang="ts">
import { computed, ref } from 'vue'
import { backendErrorMessage, persistQuestionOrAnswer } from '../api/interrogation'
import type { AsrCaptureStatus, TranscriptMessage } from '../types/interrogation'

const props = defineProps<{
  caseId: string
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

const text = ref('')
const saving = ref(false)
const localError = ref('')
const formalRecords = computed(() => props.messages.filter((item) => item.speaker !== 'AI'))
const elapsed = computed(() => {
  const total = Math.floor(props.captureElapsedMs / 1000)
  return `${String(Math.floor(total / 60)).padStart(2, '0')}:${String(total % 60).padStart(2, '0')}`
})

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
    // 当前版本界面暂不区分发言角色；先按口供记录写入正式笔录，后续可再接说话人归属。
    await persistQuestionOrAnswer(props.caseId, clean, '嫌疑人')
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
  <section class="interrogation-page page-card">
    <header class="page-card-header interrogation-header">
      <div>
        <h2>审讯记录</h2>
        <p>当前阶段先专注于连续记录问题与口供，不在界面上区分民警和嫌疑人。</p>
      </div>
      <button class="ai-generate-button" :disabled="aiBusy" @click="$emit('generateAi')">
        {{ aiBusy ? 'AI 梳理中…' : '✦ 生成 AI 案件梳理' }}
      </button>
    </header>

    <div class="interrogation-record-area">
      <div v-if="!formalRecords.length && !capture.partialText && !capture.fragments.length" class="interrogation-placeholder">
        <strong>审讯内容将在这里连续显示</strong>
        <span>可在底部手工录入，或点击左下角录音按钮开始离线语音记录。</span>
      </div>

      <article v-for="(item, index) in formalRecords" :key="item.id" class="plain-record-row">
        <span>{{ String(index + 1).padStart(2, '0') }}</span>
        <p>{{ item.text }}</p>
      </article>

      <article v-for="fragment in capture.fragments" :key="fragment.id" class="plain-record-row draft">
        <span>录音</span>
        <p>{{ fragment.editedText || fragment.rawText || '等待识别文本…' }}</p>
        <small>临时识别片段 · 后续版本再接角色确认与正式入库</small>
      </article>

      <div v-if="capture.partialText" class="live-record-row">
        <span>实时识别</span>
        <strong>{{ capture.partialText }}</strong>
      </div>
    </div>

    <div v-if="localError || aiError || capture.error" class="interrogation-error">
      {{ localError || aiError || capture.error }}
    </div>

    <footer class="interrogation-composer">
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
      <textarea
        v-model="text"
        :disabled="!canRecord || saving"
        rows="1"
        placeholder="输入审讯记录……"
        @keydown.ctrl.enter.prevent="appendRecord"
      ></textarea>
      <button class="primary-action record-save" :disabled="!text.trim() || !canRecord || saving" @click="appendRecord">
        {{ saving ? '保存中…' : '保存记录' }}
      </button>
    </footer>
  </section>
</template>
