<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref } from 'vue'
import { backendErrorMessage, fetchAsrStatus, startAsr, stopAsr } from '../api/interrogation'
import { isNativeBusinessRuntime, onNativeEvent } from '../native/rpcBridge'
import type { AsrRuntimeStatus } from '../types/interrogation'

const status = ref<AsrRuntimeStatus | null>(null)
const busy = ref(false)
const error = ref('')
let unsubscribe: (() => void) | undefined

const native = computed(() => isNativeBusinessRuntime())
const actionText = computed(() => {
  if (busy.value) return status.value?.running ? '停止中…' : '初始化中…'
  return status.value?.running ? '停止识别' : '开始识别'
})

function metric(value?: number | null) {
  return value == null ? '—' : `${value} ms`
}

function signal(status: AsrRuntimeStatus) {
  const label = status.audioSignalState === 'ACTIVE'
    ? '有效'
    : status.audioSignalState === 'SILENT'
      ? '无有效信号'
      : '等待声音'
  return `${label} · 峰值 ${status.audioPeak ?? '—'}`
}

async function load() {
  if (!native.value) return
  try { status.value = await fetchAsrStatus() }
  catch (e) { error.value = backendErrorMessage(e) }
}

async function toggle() {
  busy.value = true
  error.value = ''
  try {
    status.value = status.value?.running ? await stopAsr() : await startAsr()
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    busy.value = false
  }
}

onMounted(() => {
  unsubscribe = onNativeEvent<AsrRuntimeStatus>('asr.status', (next) => { status.value = next })
  void load()
})
onUnmounted(() => unsubscribe?.())
</script>

<template>
  <section class="asr-console">
    <header>
      <div>
        <h3>实时离线 ASR</h3>
        <span>{{ status?.selectedModelName || '正在读取当前模型' }}</span>
      </div>
      <button class="session-primary" :disabled="!native || busy" @click="toggle">{{ actionText }}</button>
    </header>

    <div v-if="!native" class="ai-settings-note warning">麦克风离线识别需要在 Android APK 中运行。</div>
    <div v-if="error || status?.error" class="ai-settings-note error">{{ error || status?.error }}</div>

    <div v-if="status" class="asr-metrics">
      <div><span>当前模型</span><strong>{{ status.selectedModelName }}</strong></div>
      <div><span>Provider</span><strong>{{ status.provider }}</strong></div>
      <div><span>初始化耗时</span><strong>{{ metric(status.initializationMs) }}</strong></div>
      <div><span>首字延迟</span><strong>{{ metric(status.firstTokenLatencyMs) }}</strong></div>
      <div><span>单句耗时</span><strong>{{ metric(status.utteranceLatencyMs) }}</strong></div>
      <div><span>Runtime</span><strong>sherpa {{ status.sherpaVersion }} · {{ status.sampleRate }} Hz</strong></div>
      <div><span>首选输入</span><strong>{{ status.preferredAudioInput || '系统默认' }}</strong></div>
      <div><span>实际输入</span><strong>{{ status.routedAudioInput || '等待路由' }}</strong></div>
      <div><span>输入信号</span><strong>{{ signal(status) }}</strong></div>
    </div>

    <div class="asr-results">
      <div>
        <span>实时结果</span>
        <p :class="{ empty: !status?.partialText }">{{ status?.partialText || (status?.running ? '正在监听…' : '尚未开始识别') }}</p>
      </div>
      <div>
        <span>最终结果</span>
        <p :class="{ empty: !status?.finalText }">{{ status?.finalText || '暂无最终结果' }}</p>
      </div>
    </div>
  </section>
</template>
