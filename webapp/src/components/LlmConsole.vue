<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import {
  backendErrorMessage,
  cancelLlm,
  fetchLlmStatus,
  generateLlm,
  releaseLlm,
} from '../api/interrogation'
import type { LlmResult, LlmRuntimeStatus } from '../types/interrogation'

const emit = defineEmits<{ rescan: [] }>()
const status = ref<LlmRuntimeStatus | null>(null)
const result = ref<LlmResult | null>(null)
const prompt = ref('请简要说明讯问笔录中需要重点核对的事实。')
const output = ref('')
const maxNewTokens = ref(64)
const maxContextLen = ref(1024)
const action = ref('')
const error = ref('')
const activeGenerationId = ref('')

const canGenerate = computed(() => !!status.value?.selectedModelId && !status.value?.busy && !action.value && prompt.value.trim().length > 0)

function metric(value?: number | null) {
  return value == null ? '—' : `${value} ms`
}

function generationId() {
  return typeof crypto !== 'undefined' && 'randomUUID' in crypto
    ? crypto.randomUUID()
    : `llm-${Date.now()}-${Math.random().toString(36).slice(2)}`
}

async function load() {
  try {
    status.value = await fetchLlmStatus()
    maxNewTokens.value = status.value.config.maxNewTokens
    maxContextLen.value = status.value.config.maxContextLen
    error.value = ''
  } catch (e) {
    error.value = backendErrorMessage(e)
  }
}

async function generate() {
  const id = generationId()
  activeGenerationId.value = id
  action.value = 'generate'
  error.value = ''
  output.value = ''
  result.value = null
  try {
    result.value = await generateLlm({
      generationId: id,
      prompt: prompt.value.trim(),
      maxNewTokens: Number(maxNewTokens.value),
      maxContextLen: Number(maxContextLen.value),
    })
    output.value = result.value.outputText
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    action.value = ''
    activeGenerationId.value = ''
    await load()
  }
}

async function stop() {
  action.value = 'cancel'
  error.value = ''
  try { status.value = await cancelLlm() }
  catch (e) { error.value = backendErrorMessage(e) }
  finally { action.value = '' }
}

async function release() {
  action.value = 'release'
  error.value = ''
  try {
    status.value = await releaseLlm()
    emit('rescan')
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    action.value = ''
  }
}

onMounted(() => {
  void load()
})
</script>

<template>
  <section class="llm-console">
    <header>
      <div>
        <h3>完全离线 LLM</h3>
        <span>{{ status?.selectedModelName || '未选择 LLM 模型' }}</span>
      </div>
      <div class="llm-actions">
        <button class="session-primary" :disabled="!canGenerate" @click="generate">{{ action === 'generate' ? '测试中…' : '测试模型' }}</button>
        <button :disabled="!status?.busy && action !== 'generate'" @click="stop">停止生成</button>
        <button :disabled="!!action || !status?.initialized" @click="release">释放模型</button>
      </div>
    </header>

    <div class="ai-settings-note">这里仅测试所选模型能否推理，不读取当前案件数据，也不会把测试结果保存到案件。正式分析请使用案件页面的“生成本案 AI 推理”。</div>
    <div v-if="error || status?.error" class="ai-settings-note error">{{ error || status?.error }}</div>

    <div v-if="status" class="llm-metrics">
      <div><span>Provider</span><strong>{{ status.provider }}</strong></div>
      <div><span>初始化耗时</span><strong>{{ metric(result?.initializationMs ?? status.initializationMs) }}</strong></div>
      <div><span>首分片耗时</span><strong>{{ metric(result?.firstTokenLatencyMs ?? status.firstTokenLatencyMs) }}</strong></div>
      <div><span>总推理耗时</span><strong>{{ metric(result?.totalInferenceMs ?? status.totalInferenceMs) }}</strong></div>
    </div>

    <div class="llm-config">
      <label><span>max_new_tokens</span><input v-model.number="maxNewTokens" type="number" min="1" max="4096" /></label>
      <label><span>max_context_len</span><input v-model.number="maxContextLen" type="number" min="128" max="32768" /></label>
    </div>
    <label class="llm-prompt"><span>Prompt</span><textarea v-model="prompt" rows="4" :disabled="!!action" /></label>
    <div class="llm-output" :class="{ empty: !output }">{{ output || '生成结果将在这里显示。' }}</div>
  </section>
</template>
