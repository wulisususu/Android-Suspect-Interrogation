<script lang="ts">
import type { TemporaryAsrSpeaker, VoiceprintReadiness, VoiceRecognitionMode } from '../types/interrogation'

export function voiceprintStartGuard(readiness: VoiceprintReadiness) {
  if (!readiness.suspectReady || !readiness.canStart) {
    return {
      disabled: true,
      reason: '必须先完成嫌疑人声纹注册，才能开始正式语音审讯',
    }
  }
  return { disabled: false, reason: '' }
}

export function voiceprintModeLabel(mode: VoiceRecognitionMode) {
  const labels: Record<VoiceRecognitionMode, string> = {
    SUSPECT_ONLY: '仅嫌疑人声纹识别',
    SUSPECT_PLUS_INTERROGATOR: '嫌疑人 + 主审民警',
    SUSPECT_PLUS_RECORDER: '嫌疑人 + 记录民警',
    FULL: '嫌疑人 + 主审民警 + 记录民警',
  }
  return labels[mode]
}

export function temporarySpeakerPresentation(speaker: TemporaryAsrSpeaker, speakerName?: string | null) {
  if (speaker === 'SUSPECT') {
    return { label: `嫌疑人 · ${speakerName || '未命名'}`, detail: 'XVector 声纹匹配', needsConfirmation: false }
  }
  if (speaker === 'INTERROGATOR') {
    return { label: `主审民警 · ${speakerName || '未命名'}`, detail: 'XVector 声纹匹配', needsConfirmation: false }
  }
  if (speaker === 'RECORDER') {
    return { label: `记录民警 · ${speakerName || '未命名'}`, detail: 'XVector 声纹匹配', needsConfirmation: false }
  }
  if (speaker === 'OFFICER_FALLBACK') {
    return { label: '民警', detail: '未启用/未匹配民警声纹，按非嫌疑人规则归类', needsConfirmation: false }
  }
  return { label: '待确认', detail: '声纹结果不足以可靠归属，请人工确认', needsConfirmation: true }
}
</script>

<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import type {
  OfficerVoiceprint,
  SessionStatus,
  VoiceprintEnrollmentState,
  VoiceprintReadiness,
} from '../types/interrogation'

const props = defineProps<{
  suspectName: string
  readiness: VoiceprintReadiness
  officers: OfficerVoiceprint[]
  selectedInterrogatorOfficerId: string | null
  selectedRecorderOfficerId: string | null
  enrollmentState: VoiceprintEnrollmentState
  busy: boolean
  sessionStatus: SessionStatus
}>()

const emit = defineEmits<{
  suspectStart: []
  suspectStop: []
  selectInterrogator: [officerId: string | null]
  selectRecorder: [officerId: string | null]
  officerStart: [officerId: string, officerName: string]
  officerStop: [officerId: string]
  revokeOfficer: [officerId: string]
  bindRoles: []
}>()

const officerId = ref('')
const officerName = ref('')
const guard = computed(() => voiceprintStartGuard(props.readiness))
const enrollmentRecording = computed(() => props.enrollmentState.phase === 'RECORDING')
const suspectRecording = computed(() => enrollmentRecording.value && props.enrollmentState.kind === 'SUSPECT')
const officerRecording = computed(() => enrollmentRecording.value && props.enrollmentState.kind === 'OFFICER')
const selectedOfficerName = computed(() => props.officers.find((item) => item.officerId === props.enrollmentState.subjectId)?.officerName || props.enrollmentState.officerName || '')
const usableSeconds = computed(() => Math.floor((props.enrollmentState.usableDurationMs || 0) / 1000))
const sessionActive = computed(() => ['RUNNING', 'PAUSED'].includes(props.sessionStatus))

watch(
  () => props.enrollmentState,
  (state) => {
    if (state.kind === 'OFFICER' && state.subjectId) {
      officerId.value = state.subjectId
      if (state.officerName) officerName.value = state.officerName
    }
  },
  { deep: true },
)

function normalizedSelect(event: Event) {
  const value = (event.target as HTMLSelectElement).value.trim()
  return value || null
}

function beginOfficerEnrollment() {
  const id = officerId.value.trim()
  const name = officerName.value.trim()
  if (!id || !name) return
  emit('officerStart', id, name)
}
</script>

<template>
  <section class="voiceprint-preparation-panel" aria-label="声纹准备">
    <header class="voiceprint-preparation-header">
      <div>
        <span class="section-kicker">正式语音审讯前置条件</span>
        <h2>声纹准备</h2>
      </div>
      <div class="voiceprint-mode-chip" :class="{ ready: readiness.suspectReady }">
        {{ voiceprintModeLabel(readiness.recognitionMode) }}
      </div>
    </header>

    <div v-if="readiness.simulated" class="voiceprint-warning">
      当前为浏览器开发模拟；模拟结果不能解锁正式声纹审讯。
    </div>

    <div class="voiceprint-preparation-grid">
      <article class="voiceprint-person-row required">
        <div class="voiceprint-person-main">
          <strong>嫌疑人 · {{ suspectName || '待录入姓名' }}</strong>
          <span>必须</span>
        </div>
        <div class="voiceprint-status" :class="{ ok: readiness.suspectReady }">
          {{ readiness.suspectReady ? '已注册' : '未注册' }}
        </div>
        <button
          v-if="!suspectRecording"
          class="voiceprint-action primary"
          :disabled="busy || sessionActive"
          @click="$emit('suspectStart')"
        >
          {{ readiness.suspectReady ? '重新录制' : '开始录制' }}
        </button>
        <button
          v-else
          class="voiceprint-action danger"
          :disabled="busy"
          @click="$emit('suspectStop')"
        >
          停止并注册
        </button>
      </article>

      <article class="voiceprint-person-row">
        <div class="voiceprint-person-main">
          <strong>主审民警</strong>
          <span>可选</span>
        </div>
        <select
          :value="selectedInterrogatorOfficerId || ''"
          :disabled="busy || sessionActive"
          aria-label="选择主审民警声纹"
          @change="$emit('selectInterrogator', normalizedSelect($event))"
        >
          <option value="">不启用民警声纹</option>
          <option v-for="officer in officers" :key="officer.officerId" :value="officer.officerId">
            {{ officer.officerName }} · {{ officer.officerId }}
          </option>
        </select>
        <span class="voiceprint-status" :class="{ ok: readiness.interrogatorReady }">
          {{ readiness.interrogatorReady ? '本次已绑定' : '未绑定' }}
        </span>
      </article>

      <article class="voiceprint-person-row">
        <div class="voiceprint-person-main">
          <strong>记录民警</strong>
          <span>可选</span>
        </div>
        <select
          :value="selectedRecorderOfficerId || ''"
          :disabled="busy || sessionActive"
          aria-label="选择记录民警声纹"
          @change="$emit('selectRecorder', normalizedSelect($event))"
        >
          <option value="">不启用民警声纹</option>
          <option v-for="officer in officers" :key="officer.officerId" :value="officer.officerId">
            {{ officer.officerName }} · {{ officer.officerId }}
          </option>
        </select>
        <span class="voiceprint-status" :class="{ ok: readiness.recorderReady }">
          {{ readiness.recorderReady ? '本次已绑定' : '未绑定' }}
        </span>
      </article>
    </div>

    <section class="officer-enrollment-box">
      <header>
        <strong>民警声纹库</strong>
        <span>可复用；角色只绑定到本次审讯</span>
      </header>
      <div class="officer-enrollment-form">
        <input v-model="officerId" :disabled="busy || officerRecording || sessionActive" placeholder="民警编号" aria-label="民警编号" />
        <input v-model="officerName" :disabled="busy || officerRecording || sessionActive" placeholder="民警姓名" aria-label="民警姓名" />
        <button v-if="!officerRecording" :disabled="busy || !officerId.trim() || !officerName.trim() || sessionActive" @click="beginOfficerEnrollment">
          新注册 / 更新
        </button>
        <button v-else class="danger" :disabled="busy" @click="$emit('officerStop', String(enrollmentState.subjectId || officerId))">
          停止并保存
        </button>
      </div>
      <div v-if="officers.length" class="officer-library-list">
        <span v-for="officer in officers" :key="officer.officerId" class="officer-library-item">
          <b>{{ officer.officerName }}</b> · {{ officer.officerId }}
          <button :disabled="busy || sessionActive" @click="$emit('revokeOfficer', officer.officerId)">撤销</button>
        </span>
      </div>
    </section>

    <div v-if="enrollmentState.phase !== 'IDLE'" class="voiceprint-enrollment-progress" :class="enrollmentState.phase.toLowerCase()">
      <strong v-if="enrollmentState.kind === 'SUSPECT'">嫌疑人声纹</strong>
      <strong v-else>民警声纹 · {{ selectedOfficerName || enrollmentState.subjectId }}</strong>
      <span v-if="enrollmentState.phase === 'RECORDING'">正在录制，建议持续讲话 20–30 秒</span>
      <span v-else-if="enrollmentState.phase === 'PROCESSING'">正在进行 VAD 质检与 XVector 声纹聚合…</span>
      <span v-else>{{ enrollmentState.message }}</span>
      <small v-if="usableSeconds">有效语音 {{ usableSeconds }} 秒</small>
    </div>

    <footer class="voiceprint-preparation-footer">
      <div>
        <strong>{{ guard.disabled ? '尚未满足开始条件' : '可以开始正式审讯' }}</strong>
        <span>{{ guard.reason || '嫌疑人声纹已就绪；民警声纹为可选项' }}</span>
      </div>
      <button
        v-if="sessionStatus === 'READY'"
        :disabled="busy || guard.disabled"
        @click="$emit('bindRoles')"
      >
        保存本次角色选择
      </button>
    </footer>
  </section>
</template>
