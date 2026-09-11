<script setup lang="ts">
import { computed, ref } from 'vue'
import type { VoiceprintAudioSource } from '../api/browserVoiceprint'
import { voiceprintEnrollmentProgress } from './VoiceprintPreparationPanel.vue'
import VoiceprintAudioSourceBanner from './VoiceprintAudioSourceBanner.vue'
import type { OfficerVoiceprint, VoiceprintEnrollmentState, VoiceprintReadiness } from '../types/interrogation'

const props = withDefaults(defineProps<{
  suspectName: string
  readiness: VoiceprintReadiness
  officers: OfficerVoiceprint[]
  selectedInterrogatorOfficerId: string | null
  selectedRecorderOfficerId: string | null
  enrollmentState: VoiceprintEnrollmentState
  busy: boolean
  source: VoiceprintAudioSource | null
  reason: string
  secureContext: boolean
  /** Registered suspects get the condensed status card instead of the full recording card. */
  compact?: boolean
}>(), { compact: false })

const emits = defineEmits<{
  suspectStart: []
  suspectStop: []
  selectInterrogator: [officerId: string | null]
  selectRecorder: [officerId: string | null]
  bindRoles: []
}>()

const suspectRecording = computed(() => props.enrollmentState.phase === 'RECORDING' && props.enrollmentState.kind === 'SUSPECT')
const showProgress = computed(() => props.enrollmentState.phase !== 'IDLE' && props.enrollmentState.kind !== 'OFFICER')
const progress = computed(() => voiceprintEnrollmentProgress({
  ...props.enrollmentState,
  usableSpeechMs: props.enrollmentState.usableDurationMs,
  requiredUsableSpeechMs: props.enrollmentState.targetDurationMs,
}))
const finalUsableSeconds = computed(() => Math.floor((props.enrollmentState.usableDurationMs || 0) / 1000))
function normalizedSelect(event: Event) {
  const value = (event.target as HTMLSelectElement).value.trim()
  return value || null
}
const liveStatus = computed(() => {
  if (props.enrollmentState.phase === 'RECORDING') return `正在采集嫌疑人有效语音，当前有效语音 ${progress.value.usableSeconds} / ${progress.value.targetSeconds} 秒。`
  if (props.enrollmentState.phase === 'PROCESSING') return '正在进行最终声纹注册，请稍候。'
  if (props.enrollmentState.phase === 'ERROR') return `声纹注册失败：${props.enrollmentState.message || '请检查麦克风连接后重新录制。'}`
  if (props.enrollmentState.phase === 'COMPLETE') return '声纹注册完成，已解锁正式审讯与实时对话。'
  return props.enrollmentState.message || ''
})

// A failed re-recording must never read as if the already registered voiceprint was lost: the
// backend only calls replace_suspect after the new quality checks passed, so the previous
// reference keeps working. Keep reporting that instead of showing a bare failure.
const reEnrollFailure = computed(() => props.readiness.suspectReady && props.enrollmentState.phase === 'ERROR')
const reEnrollLabel = computed(() => (reEnrollFailure.value ? '再次重新录制' : '重新录制'))
const registeredLabel = computed(() => (reEnrollFailure.value ? '✓ 当前已有声纹仍然有效' : '✓ 已注册'))
const suspectRowClass = computed(() => (props.compact ? 'suspect-row compact' : 'suspect-row'))

let lastMeasuredUsableSeconds = 0

// Prefer the registered reference measurement from readiness; fall back to whatever this
// session most recently measured while enrolling.
const referenceUsableSeconds = computed(() => {
  const durationMs = Number(props.readiness.usableDurationMs || 0)
  return durationMs > 0 ? Number((durationMs / 1000).toFixed(2)) : 0
})

function measuredUsableSeconds() {
  const measured = Number(props.enrollmentState.usableDurationMs || 0)
  return measured > 0 ? Number((measured / 1000).toFixed(2)) : 0
}

// The request-scoped readiness payload does not carry the suspect enrollment metrics yet
// (17B-1), so the compact card reports the duration it can see and keeps the last known value
// instead of dropping the line when a later attempt has no measurement.
const compactUsableSpeechLabel = computed(() => {
  const measured = measuredUsableSeconds()
  if (measured > 0) lastMeasuredUsableSeconds = measured
  const seconds = [referenceUsableSeconds.value, measured, lastMeasuredUsableSeconds].find((value) => value > 0) || 0
  return seconds > 0 ? `有效语音：${seconds} 秒` : '有效语音：以本次注册结果为准'
})

const compactQualityLabel = computed(() => (props.readiness.enrollmentQuality ? `质量：${props.readiness.enrollmentQuality}` : '质量：未知'))

function startOrReRecord() {
  emits('suspectStart')
}
</script>

<template>
  <aside class="voiceprint-enrollment-gate" :class="{ compact }" aria-label="嫌疑人声纹注册">
    <VoiceprintAudioSourceBanner :source="source" :reason="reason" :secure-context="secureContext" />

    <div class="voiceprint-enrollment-content" :class="{ 'compact-card': compact }">
      <header v-if="!compact">
        <span class="section-kicker">正式审讯前置条件</span>
        <h2>完成嫌疑人声纹注册</h2>
        <p>完成声纹注册后，即可解锁正式审讯与实时对话。</p>
      </header>

      <div :class="suspectRowClass">
        <div class="suspect-identity">
          <strong>嫌疑人 · {{ suspectName || '待录入姓名' }}</strong>
          <span :class="{ ready: readiness.suspectReady }">{{ compact ? registeredLabel : readiness.suspectReady ? '声纹已注册' : '尚未注册' }}</span>
        </div>
        <dl v-if="compact">
          <dt>{{ compactQualityLabel }}</dt>
          <dt>{{ compactUsableSpeechLabel }}</dt>
        </dl>
        <button v-if="!suspectRecording" class="primary" :disabled="busy" @click="startOrReRecord">{{ compact ? reEnrollLabel : '开始录制' }}</button>
        <button v-else class="danger" :disabled="busy" @click="emits('suspectStop')">提前停止并尝试注册</button>
      </div>

      <details class="optional-officer-binding">
        <summary>可选：绑定民警声纹</summary>
        <p>嫌疑人声纹是唯一必需项；不选择民警声纹仍可开始正式审讯。</p>
        <label>
          主审民警
          <select :value="selectedInterrogatorOfficerId || ''" :disabled="busy" aria-label="选择主审民警声纹" @change="emits('selectInterrogator', normalizedSelect($event))">
            <option value="">不启用民警声纹</option>
            <option v-for="officer in officers" :key="officer.officerId" :value="officer.officerId">{{ officer.officerName }} · {{ officer.officerId }}</option>
          </select>
        </label>
        <label>
          记录民警
          <select :value="selectedRecorderOfficerId || ''" :disabled="busy" aria-label="选择记录民警声纹" @change="emits('selectRecorder', normalizedSelect($event))">
            <option value="">不启用民警声纹</option>
            <option v-for="officer in officers" :key="officer.officerId" :value="officer.officerId">{{ officer.officerName }} · {{ officer.officerId }}</option>
          </select>
        </label>
        <button :disabled="busy" @click="emits('bindRoles')">保存本次角色选择</button>
      </details>

      <div v-if="showProgress" class="voiceprint-enrollment-progress" :class="enrollmentState.phase.toLowerCase()">
        <template v-if="enrollmentState.phase === 'RECORDING'">
          <span>请自然说话；有效语音达到 20 秒后会自动停止并注册，停顿和语速慢不会按总时长判失败。</span>
          <div class="voiceprint-capture-meter" role="progressbar" :aria-valuemin="0" :aria-valuemax="progress.targetSeconds" :aria-valuenow="progress.usableSeconds" :aria-label="`有效语音 ${progress.usableSeconds} / ${progress.targetSeconds} 秒`">
            <i :style="{ width: `${progress.percent}%` }"></i>
          </div>
          <small>有效语音 {{ progress.usableSeconds }} / {{ progress.targetSeconds }} 秒</small>
        </template>
        <span v-else-if="enrollmentState.phase === 'PROCESSING'">有效语音已达标，正在进行最终声纹注册…</span>
        <span v-else>{{ enrollmentState.message }}</span>
        <small v-if="finalUsableSeconds && enrollmentState.phase !== 'RECORDING'">有效语音 {{ finalUsableSeconds }} 秒</small>
      </div>

      <p v-if="showProgress" class="voiceprint-enrollment-status" role="status" aria-live="polite" aria-atomic="true">{{ liveStatus }}</p>
    </div>
  </aside>
</template>

<style scoped>
.voiceprint-enrollment-gate { overflow:hidden; border:1px solid #c9d7e2; border-radius:10px; background:#f8fbfe; color:#21384d; }
.voiceprint-enrollment-content { padding:16px 18px; }
header h2 { margin:3px 0 0; font-size:22px; }
header p { margin:8px 0 0; color:#607588; }
.section-kicker { color:#5d7184; font-size:12px; letter-spacing:.08em; }
.suspect-row { display:flex; align-items:center; justify-content:space-between; gap:12px; margin-top:14px; padding:12px; border:1px solid #d0dde8; border-left:4px solid #2d78bb; border-radius:8px; background:#fff; }
.suspect-row > div { display:grid; gap:5px; }
.suspect-row span { color:#566b7e; font-size:12px; font-weight:700; }
.suspect-row span.ready { color:#267647; }
.optional-officer-binding { margin-top:12px; padding:9px 12px; border:1px solid #d0dde8; border-radius:8px; background:#fff; color:#526b80; }
.optional-officer-binding summary { cursor:pointer; color:#315d82; font-weight:700; }
.optional-officer-binding p { margin:9px 0; font-size:12px; }
.optional-officer-binding label { display:grid; gap:4px; margin-top:8px; color:#315d82; font-size:12px; font-weight:700; }
.optional-officer-binding select { min-height:34px; border:1px solid #b9cad8; border-radius:6px; padding:0 8px; background:#fff; color:#29465f; }
.optional-officer-binding button { margin-top:10px; }
button { min-height:38px; border:1px solid #9eb3c5; border-radius:6px; padding:0 13px; background:#fff; color:#29465f; font-weight:700; }
button.primary { border-color:#2476c9; background:#2476c9; color:#fff; }
button.danger { border-color:#d95045; color:#b02d24; }
button:disabled { opacity:.5; }
.voiceprint-enrollment-progress { display:flex; align-items:center; flex-wrap:wrap; gap:10px; margin-top:10px; padding:9px 12px; border-radius:7px; background:#eaf3fb; color:#315d82; }
.voiceprint-enrollment-progress.error { background:#fff0ef; color:#a3352e; }
.voiceprint-enrollment-progress.complete { background:#edf8f1; color:#267647; }
.voiceprint-capture-meter { height:8px; flex:1 1 180px; min-width:160px; overflow:hidden; border-radius:999px; background:#d7e3ec; }
.voiceprint-capture-meter > i { display:block; height:100%; border-radius:inherit; background:#2476c9; transition:width .25s ease; }
.voiceprint-enrollment-progress small { margin-left:auto; }
.voiceprint-enrollment-status { margin:8px 0 0; color:#526b80; font-size:13px; }
/* Registered suspects keep the same card, condensed: one status row plus a collapsible role drawer. */
.compact-card { padding:10px 12px; }
.compact-card .suspect-row { flex-wrap:wrap; gap:8px 14px; margin-top:0; padding:8px 10px; border-left-width:3px; }
.compact-card .suspect-row dl { display:flex; flex-wrap:wrap; gap:4px 14px; margin:0; color:#566b7e; font-size:12px; font-weight:700; }
.compact-card .suspect-row dt { margin:0; }
.compact-card .suspect-identity { flex:1 1 140px; }
.compact-card button { min-height:30px; padding:0 11px; font-size:12px; }
.compact-card .optional-officer-binding { margin-top:8px; padding:6px 9px; }
.compact-card .optional-officer-binding button { margin-top:7px; }
.compact-card .voiceprint-enrollment-progress { margin-top:8px; padding:7px 9px; font-size:12px; }
.compact-card .voiceprint-enrollment-status { margin-top:6px; font-size:12px; }
@media (max-width:980px) { .suspect-row { align-items:flex-start; flex-direction:column; } }
</style>
