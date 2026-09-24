<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import type { AsrCaptureStatus } from '../types/interrogation'
import { listRecoverableBrowserFormalCaptures, recoverBrowserFormalCapture } from '../audio/browserAsrCapture'

const props = defineProps<{ capture: AsrCaptureStatus }>()
const pendingLocalFrames = ref(0)
const recoveryBusy = ref(false)
const recoveryMessage = ref('')

const visible = computed(() => Boolean(
  props.capture.recordingStatus || props.capture.asrStatus || props.capture.speakerStatus || props.capture.error,
))
const incomplete = computed(() => props.capture.recordingStatus === 'INCOMPLETE')
const recordingLabel = computed(() => {
  switch (props.capture.recordingStatus) {
    case 'CAPTURING': return '原始录音持续归档中'
    case 'COMPLETE': return '原始录音已保存'
    case 'INCOMPLETE': return '录音不完整，存在音频缺口'
    case 'PENDING': return '录音等待启动'
    default: return ''
  }
})
const asrLabel = computed(() => {
  const status = props.capture.asrStatus
  if (!status) return ''
  const backlog = Math.max(0, (props.capture.audioSampleCount ?? 0) - (props.capture.asrCursorSample ?? 0))
  const backlogSeconds = Math.ceil(backlog / Math.max(1, props.capture.sampleRate))
  const state = status === 'FINALIZING' || status === 'PENDING'
    ? '文字识别处理中'
    : status === 'COMPLETE'
      ? '文字识别完成'
      : status === 'ERROR'
        ? '文字识别异常'
        : `文字识别：${status}`
  return backlogSeconds > 0 ? `${state}，待处理约 ${backlogSeconds} 秒音频` : state
})
const speakerLabel = computed(() => {
  const status = props.capture.speakerStatus
  if (!status) return ''
  if (status === 'COMPLETE') return '说话人分析完成'
  if (status === 'NEEDS_REVIEW') return '部分说话人需要人工复核'
  if (status === 'ERROR') return '说话人分析异常'
  if (status === 'QUEUED') return '说话人分析排队中'
  if (status === 'RUNNING') return '说话人分析中'
  if (status === 'PENDING') {
    const seconds = Math.floor((props.capture.voicedMs ?? 0) / 1000)
    const fragments = props.capture.finalFragmentCount ?? 0
    if (props.capture.running && (seconds < 10 || fragments < 3)) {
      return `说话人分析等待素材（有效语音 ${seconds}/10 秒，文字片段 ${fragments}/3 段）`
    }
    return '说话人分析等待开始'
  }
  return `说话人分析：${status}`
})

watch(
  () => [props.capture.caseId, props.capture.captureSessionId, props.capture.recordingStatus] as const,
  async ([caseId, captureId, recordingStatus]) => {
    pendingLocalFrames.value = 0
    recoveryMessage.value = ''
    if (!caseId || !captureId || recordingStatus !== 'INCOMPLETE') return
    try {
      const captures = await listRecoverableBrowserFormalCaptures(caseId)
      pendingLocalFrames.value = captures.find((capture) => capture.captureId === captureId)?.pendingFrameCount ?? 0
    } catch {
      pendingLocalFrames.value = 0
    }
  },
  { immediate: true },
)

async function recoverLocalAudio() {
  const caseId = props.capture.caseId
  const captureId = props.capture.captureSessionId
  if (!caseId || !captureId || recoveryBusy.value) return
  recoveryBusy.value = true
  recoveryMessage.value = ''
  try {
    await recoverBrowserFormalCapture(caseId, captureId)
    pendingLocalFrames.value = 0
    recoveryMessage.value = '本机音频已补录并进入文字识别'
  } catch (error) {
    try {
      const captures = await listRecoverableBrowserFormalCaptures(caseId)
      pendingLocalFrames.value = captures.find((capture) => capture.captureId === captureId)?.pendingFrameCount ?? 0
    } catch {
      pendingLocalFrames.value = 0
    }
    recoveryMessage.value = error instanceof Error ? error.message : String(error)
  } finally {
    recoveryBusy.value = false
  }
}
</script>

<template>
  <div v-if="visible" class="asr-workflow-status" :class="{ incomplete }" role="status" aria-live="polite">
    <span v-if="recordingLabel">{{ recordingLabel }}</span>
    <span v-if="asrLabel">{{ asrLabel }}</span>
    <span v-if="speakerLabel">{{ speakerLabel }}</span>
    <span v-if="capture.error" class="workflow-error">{{ capture.error }}</span>
    <div v-if="incomplete && pendingLocalFrames" class="local-recovery">
      <span>本机保留了 {{ pendingLocalFrames }} 个尚未归档的音频分片。</span>
      <button type="button" :disabled="recoveryBusy" @click="recoverLocalAudio">
        {{ recoveryBusy ? '正在补录…' : '补录本机音频' }}
      </button>
    </div>
    <span v-if="recoveryMessage" class="workflow-error">{{ recoveryMessage }}</span>
  </div>
</template>

<style scoped>
.asr-workflow-status {
  display: flex;
  flex-wrap: wrap;
  gap: 6px 14px;
  padding: 8px 12px;
  color: #35516d;
  background: #eff5fa;
  border-bottom: 1px solid #dbe6ef;
  font: 12px/1.45 system-ui, sans-serif;
}

.asr-workflow-status.incomplete {
  color: #8d4a08;
  background: #fff5e8;
  border-bottom-color: #f1d6b4;
}

.workflow-error {
  flex-basis: 100%;
}

.local-recovery {
  display: flex;
  flex-basis: 100%;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
}

.local-recovery button {
  border: 1px solid #b36b20;
  border-radius: 5px;
  padding: 4px 9px;
  color: #77430c;
  background: #fff;
  cursor: pointer;
}

.local-recovery button:disabled {
  cursor: wait;
  opacity: 0.65;
}
</style>
