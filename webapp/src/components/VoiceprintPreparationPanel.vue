<script lang="ts">
import type { TemporaryAsrSpeaker, VoiceprintReadiness as VoiceprintReadinessModel, VoiceRecognitionMode } from '../types/interrogation'

export function voiceprintEnrollmentProgress(value: {
  capturedDurationMs?: number | null
  targetDurationMs?: number | null
  usableSpeechMs?: number | null
  requiredUsableSpeechMs?: number | null
}) {
  const targetDurationMs = Math.max(1, Number(value.requiredUsableSpeechMs ?? value.targetDurationMs ?? 20000))
  const usableDurationMs = Math.max(0, Math.min(Number(value.usableSpeechMs ?? value.capturedDurationMs ?? 0), targetDurationMs))
  const recordedDurationMs = Math.max(0, Number(value.capturedDurationMs ?? 0))
  return {
    percent: Math.round(usableDurationMs / targetDurationMs * 100),
    usableSeconds: Math.floor(usableDurationMs / 1000),
    targetSeconds: Math.floor(targetDurationMs / 1000),
    recordedSeconds: Math.floor(recordedDurationMs / 1000),
    complete: usableDurationMs >= targetDurationMs,
  }
}

export function voiceprintStartGuard(readiness: VoiceprintReadinessModel) {
  if (!readiness.suspectReady || !readiness.canStart) {
    return { disabled: true, reason: '必须先完成嫌疑人声纹注册，才能开始正式语音审讯' }
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
  if (speaker === 'SUSPECT') return { label: `嫌疑人 · ${speakerName || '未命名'}`, detail: 'XVector 声纹匹配', needsConfirmation: false }
  if (speaker === 'INTERROGATOR') return { label: `主审民警 · ${speakerName || '未命名'}`, detail: 'XVector 声纹匹配', needsConfirmation: false }
  if (speaker === 'RECORDER') return { label: `记录民警 · ${speakerName || '未命名'}`, detail: 'XVector 声纹匹配', needsConfirmation: false }
  if (speaker === 'OFFICER_FALLBACK') return { label: '民警', detail: '未启用/未匹配民警声纹，按非嫌疑人规则归类', needsConfirmation: false }
  return { label: '待确认', detail: '声纹结果不足以可靠归属，请人工确认', needsConfirmation: true }
}
</script>

<script setup lang="ts">
import { computed } from 'vue'
import type { OfficerVoiceprint, SessionStatus, VoiceprintEnrollmentState, VoiceprintReadiness } from '../types/interrogation'

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

defineEmits<{
  suspectStart: []
  suspectStop: []
  selectInterrogator: [officerId: string | null]
  selectRecorder: [officerId: string | null]
  bindRoles: []
}>()

const guard = computed(() => voiceprintStartGuard(props.readiness))
const enrollmentRecording = computed(() => props.enrollmentState.phase === 'RECORDING')
const suspectRecording = computed(() => enrollmentRecording.value && props.enrollmentState.kind === 'SUSPECT')
const finalUsableSeconds = computed(() => Math.floor((props.enrollmentState.usableDurationMs || 0) / 1000))
const enrollmentProgress = computed(() => voiceprintEnrollmentProgress(props.enrollmentState))
const sessionActive = computed(() => ['RUNNING', 'PAUSED'].includes(props.sessionStatus))
const showSuspectProgress = computed(() => props.enrollmentState.phase !== 'IDLE' && props.enrollmentState.kind !== 'OFFICER')

function normalizedSelect(event: Event) {
  const value = (event.target as HTMLSelectElement).value.trim()
  return value || null
}
</script>

<template>
  <section class="voiceprint-preparation-panel" aria-label="声纹准备">
    <header class="voiceprint-preparation-header">
      <div><span class="section-kicker">正式语音审讯前置条件</span><h2>声纹准备</h2></div>
      <div class="voiceprint-mode-chip" :class="{ ready: readiness.suspectReady }">{{ voiceprintModeLabel(readiness.recognitionMode) }}</div>
    </header>

    <div v-if="readiness.simulated" class="voiceprint-warning">当前为浏览器开发模拟；模拟结果不能解锁正式声纹审讯。</div>

    <div class="voiceprint-preparation-grid">
      <article class="voiceprint-person-row required">
        <div class="voiceprint-person-main"><strong>嫌疑人 · {{ suspectName || '待录入姓名' }}</strong><span>必须</span></div>
        <div class="voiceprint-status" :class="{ ok: readiness.suspectReady }">{{ readiness.suspectReady ? '已注册' : '未注册' }}</div>
        <button v-if="!suspectRecording" class="voiceprint-action primary" :disabled="busy || sessionActive" @click="$emit('suspectStart')">{{ readiness.suspectReady ? '重新录制' : '开始录制' }}</button>
        <button v-else class="voiceprint-action danger" :disabled="busy" @click="$emit('suspectStop')">提前停止并尝试注册</button>
      </article>

      <article class="voiceprint-person-row">
        <div class="voiceprint-person-main"><strong>主审民警</strong><span>从全局声纹库选择</span></div>
        <select :value="selectedInterrogatorOfficerId || ''" :disabled="busy || sessionActive" aria-label="选择主审民警声纹" @change="$emit('selectInterrogator', normalizedSelect($event))">
          <option value="">不启用民警声纹</option>
          <option v-for="officer in officers" :key="officer.officerId" :value="officer.officerId">{{ officer.officerName }} · {{ officer.officerId }}</option>
        </select>
        <span class="voiceprint-status" :class="{ ok: readiness.interrogatorReady }">{{ readiness.interrogatorReady ? '本次已绑定' : '未绑定' }}</span>
      </article>

      <article class="voiceprint-person-row">
        <div class="voiceprint-person-main"><strong>记录民警</strong><span>从全局声纹库选择</span></div>
        <select :value="selectedRecorderOfficerId || ''" :disabled="busy || sessionActive" aria-label="选择记录民警声纹" @change="$emit('selectRecorder', normalizedSelect($event))">
          <option value="">不启用民警声纹</option>
          <option v-for="officer in officers" :key="officer.officerId" :value="officer.officerId">{{ officer.officerName }} · {{ officer.officerId }}</option>
        </select>
        <span class="voiceprint-status" :class="{ ok: readiness.recorderReady }">{{ readiness.recorderReady ? '本次已绑定' : '未绑定' }}</span>
      </article>
    </div>

    <p class="global-library-hint">民警声纹的注册、补录样本、停用和维护统一在“系统设置 → 民警声纹库”完成；案件内只绑定已有档案。</p>

    <div v-if="showSuspectProgress" class="voiceprint-enrollment-progress" :class="enrollmentState.phase.toLowerCase()">
      <strong>嫌疑人声纹</strong>
      <template v-if="enrollmentState.phase === 'RECORDING'">
        <span>请自然说话；有效语音达到 20 秒后会自动停止并注册，停顿和语速慢不会按总时长判失败。</span>
        <div class="voiceprint-capture-meter" role="progressbar" :aria-valuemin="0" :aria-valuemax="enrollmentProgress.targetSeconds" :aria-valuenow="enrollmentProgress.usableSeconds" :aria-label="`有效语音 ${enrollmentProgress.usableSeconds} / ${enrollmentProgress.targetSeconds} 秒`">
          <i :style="{ width: `${enrollmentProgress.percent}%` }"></i>
        </div>
        <small>有效语音 {{ enrollmentProgress.usableSeconds }} / {{ enrollmentProgress.targetSeconds }} 秒</small>
      </template>
      <span v-else-if="enrollmentState.phase === 'PROCESSING'">有效语音已达标，正在进行最终 VAD 复核与 XVector 声纹聚合…</span>
      <span v-else>{{ enrollmentState.message }}</span>
      <small v-if="finalUsableSeconds && enrollmentState.phase !== 'RECORDING'">有效语音 {{ finalUsableSeconds }} 秒</small>
    </div>

    <footer class="voiceprint-preparation-footer">
      <div><strong>{{ guard.disabled ? '尚未满足开始条件' : '可以开始正式审讯' }}</strong><span>{{ guard.reason || '嫌疑人声纹已就绪；民警声纹为可选项，绑定后冻结本次审讯使用的 reference 版本' }}</span></div>
      <button v-if="sessionStatus === 'READY'" :disabled="busy || guard.disabled" @click="$emit('bindRoles')">保存本次角色选择</button>
    </footer>
  </section>
</template>

<style scoped>
.voiceprint-preparation-panel { padding: 16px 18px; border-bottom: 1px solid #c9d7e2; background: linear-gradient(180deg, #f8fbfe 0%, #eef5fa 100%); color: #21384d; }
.voiceprint-preparation-header,.voiceprint-preparation-footer { display:flex; align-items:center; justify-content:space-between; gap:16px; }
.voiceprint-preparation-header h2 { margin:3px 0 0; font-size:22px; }
.section-kicker { color:#5d7184; font-size:12px; letter-spacing:.08em; }
.voiceprint-mode-chip,.voiceprint-status { border:1px solid #b7c8d7; border-radius:999px; padding:5px 10px; background:#fff; color:#566b7e; font-size:12px; font-weight:700; }
.voiceprint-mode-chip.ready,.voiceprint-status.ok { border-color:#8fc6a6; background:#edf8f1; color:#267647; }
.voiceprint-warning { margin-top:10px; padding:9px 12px; border:1px solid #e5b763; border-radius:7px; background:#fff8e8; color:#8b5c0a; font-weight:700; }
.voiceprint-preparation-grid { display:grid; gap:8px; margin-top:12px; }
.voiceprint-person-row { display:grid; grid-template-columns:minmax(190px,1fr) minmax(220px,1.4fr) auto; align-items:center; gap:12px; min-height:50px; padding:9px 12px; border:1px solid #d0dde8; border-radius:8px; background:rgba(255,255,255,.9); }
.voiceprint-person-row.required { border-left:4px solid #2d78bb; }
.voiceprint-person-main { display:flex; align-items:center; gap:8px; }
.voiceprint-person-main > span { color:#73879a; font-size:12px; }
.voiceprint-person-row select { min-height:38px; border:1px solid #b9c9d7; border-radius:6px; padding:0 10px; background:#fff; color:#243c52; }
.voiceprint-action,.voiceprint-preparation-footer button { min-height:38px; border:1px solid #9eb3c5; border-radius:6px; padding:0 13px; background:#fff; color:#29465f; font-weight:700; }
.voiceprint-action.primary,.voiceprint-preparation-footer > button { border-color:#2476c9; background:#2476c9; color:#fff; }
.voiceprint-action.danger { border-color:#d95045; color:#b02d24; }
button:disabled,select:disabled { opacity:.5; }
.global-library-hint { margin:10px 0 0; padding:9px 12px; border:1px solid #d2dee8; border-radius:7px; background:#fff; color:#5d7184; font-size:12px; }
.voiceprint-capture-meter { height:8px; overflow:hidden; border-radius:999px; background:#d7e3ec; flex:1 1 180px; min-width:160px; }
.voiceprint-capture-meter > i { display:block; height:100%; border-radius:inherit; background:#2476c9; transition:width .25s ease; }
.voiceprint-enrollment-progress { display:flex; align-items:center; flex-wrap:wrap; gap:10px; margin-top:10px; padding:9px 12px; border-radius:7px; background:#eaf3fb; color:#315d82; }
.voiceprint-enrollment-progress.error { background:#fff0ef; color:#a3352e; }
.voiceprint-enrollment-progress.complete { background:#edf8f1; color:#267647; }
.voiceprint-enrollment-progress small { margin-left:auto; }
.voiceprint-preparation-footer { margin-top:11px; padding-top:10px; border-top:1px solid #d2dee8; }
.voiceprint-preparation-footer > div { display:grid; gap:3px; }
.voiceprint-preparation-footer span { color:#657a8c; font-size:12px; }
@media (max-width:980px) { .voiceprint-person-row { grid-template-columns:1fr; } .voiceprint-preparation-footer,.voiceprint-preparation-header { align-items:flex-start; flex-direction:column; } }
</style>
