<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import {
  backendErrorMessage,
  captureOcrImage,
  fetchOcrStatus,
  pickOcrImage,
  recognizeOcrImage,
  releaseOcr,
} from '../api/interrogation'
import { RuntimeAdapterError } from '../runtime'
import type { OcrResult, OcrRuntimeStatus } from '../types/interrogation'

const status = ref<OcrRuntimeStatus | null>(null)
const result = ref<OcrResult | null>(null)
const busy = ref('')
const error = ref('')
const previewError = ref('')

const selectedText = computed(() => status.value?.selectedModelName || '未选择 OCR 模型')
const canRecognize = computed(() => !!status.value?.selectedModelId && !!status.value?.imageReady && !status.value?.busy && !busy.value)

function metric(value?: number | null) {
  return value == null ? '—' : `${value} ms`
}

function confidence(value?: number | null) {
  return value == null ? '—' : `${(value * 100).toFixed(1)}%`
}

async function load() {
  try {
    status.value = await fetchOcrStatus()
    result.value = status.value.lastResult || null
    error.value = ''
  } catch (e) {
    error.value = backendErrorMessage(e)
  }
}

async function runAction(action: 'pick' | 'camera' | 'recognize' | 'release') {
  busy.value = action
  error.value = ''
  try {
    if (action === 'pick') status.value = await pickOcrImage()
    if (action === 'camera') status.value = await captureOcrImage()
    if (action === 'pick' || action === 'camera') {
      result.value = null
      previewError.value = ''
    }
    if (action === 'release') status.value = await releaseOcr()
    if (action === 'recognize') {
      result.value = await recognizeOcrImage()
      status.value = await fetchOcrStatus()
    }
  } catch (e) {
    const cancelled = e instanceof RuntimeAdapterError && ['OCR_IMAGE_PICK_CANCELLED', 'OCR_CAMERA_CANCELLED'].includes(e.code)
    if (!cancelled) error.value = backendErrorMessage(e)
  } finally {
    busy.value = ''
  }
}

onMounted(() => {
  void load()
})
</script>

<template>
  <section class="ocr-console">
    <header>
      <div>
        <h3>离线 OCR</h3>
        <span>{{ selectedText }}</span>
      </div>
      <div class="ocr-actions">
        <button :disabled="!!busy" @click="runAction('pick')">{{ busy === 'pick' ? '选择中…' : '选择图片' }}</button>
        <button :disabled="!!busy" @click="runAction('camera')">{{ busy === 'camera' ? '拍照中…' : '拍照' }}</button>
        <button class="session-primary" :disabled="!canRecognize" @click="runAction('recognize')">{{ busy === 'recognize' ? '识别中…' : '开始识别' }}</button>
        <button :disabled="!!busy || !status?.initialized" @click="runAction('release')">释放</button>
      </div>
    </header>

    <div v-if="error || status?.error" class="ai-settings-note error">{{ error || status?.error }}</div>

    <div v-if="status" class="ocr-metrics">
      <div><span>当前模型</span><strong>{{ status.selectedModelName || '未选择' }}</strong></div>
      <div><span>格式</span><strong>{{ status.modelFormat || '—' }}</strong></div>
      <div><span>Provider</span><strong>{{ status.provider || '—' }}</strong></div>
      <div><span>初始化耗时</span><strong>{{ metric(status.initializationMs) }}</strong></div>
      <div><span>识别耗时</span><strong>{{ metric(status.recognitionMs) }}</strong></div>
      <div><span>图片</span><strong>{{ status.imageReady ? '已就绪' : '未选择' }}</strong></div>
    </div>

    <div class="ocr-workbench">
      <div class="ocr-preview">
        <img
          v-if="status?.previewUri"
          :src="status.previewUri"
          alt="OCR 图片预览"
          @load="previewError = ''"
          @error="previewError = '图片预览加载失败，请重新选择图片或拍照。'"
        />
        <span v-else>暂无图片</span>
        <span v-if="previewError" class="error">{{ previewError }}</span>
      </div>
      <div class="ocr-result-pane">
        <section>
          <span>OCR 文本</span>
          <p v-if="result && !result.text" class="ai-settings-note warning">识别已完成，但未检测到文字。请确认图片方向、清晰度和文字区域后重试。</p>
          <p v-else :class="{ empty: !result?.text }">{{ result?.text || '尚未开始识别' }}</p>
        </section>
        <section>
          <span>文本块</span>
          <div v-if="result?.blocks.length" class="ocr-block-list">
            <article v-for="(block, index) in result.blocks" :key="`${block.text}-${index}`">
              <strong>{{ block.text }}</strong>
              <small>置信度 {{ confidence(block.confidence) }}</small>
            </article>
          </div>
          <p v-else class="empty">{{ result ? '未检测到文本块' : '尚未开始识别' }}</p>
        </section>
      </div>
    </div>
  </section>
</template>
