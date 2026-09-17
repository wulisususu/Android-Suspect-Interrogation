<script setup lang="ts">
import VoiceprintEnrollmentGate from './VoiceprintEnrollmentGate.vue'
import type { OfficerVoiceprint, VoiceprintEnrollmentState, VoiceprintReadiness } from '../types/interrogation'

defineProps<{
  suspectName: string
  readiness: VoiceprintReadiness
  officers: OfficerVoiceprint[]
  selectedInterrogatorOfficerId: string | null
  selectedRecorderOfficerId: string | null
  enrollmentState: VoiceprintEnrollmentState
  busy: boolean
}>()

defineEmits<{
  suspectStart: []
  suspectStop: []
  selectInterrogator: [officerId: string | null]
  selectRecorder: [officerId: string | null]
  bindRoles: []
}>()
</script>

<template>
  <section class="voiceprint-setup-page">
    <header class="voiceprint-setup-header">
      <h2>声纹注册</h2>
      <p>先注册嫌疑人声纹，审讯中的实时对话与说话人识别都依赖它；民警声纹为可选项，绑定后可区分主审与记录员。</p>
    </header>
    <VoiceprintEnrollmentGate
      :suspect-name="suspectName"
      :readiness="readiness"
      :officers="officers"
      :selected-interrogator-officer-id="selectedInterrogatorOfficerId"
      :selected-recorder-officer-id="selectedRecorderOfficerId"
      :enrollment-state="enrollmentState"
      :busy="busy"
      @suspect-start="$emit('suspectStart')"
      @suspect-stop="$emit('suspectStop')"
      @select-interrogator="$emit('selectInterrogator', $event)"
      @select-recorder="$emit('selectRecorder', $event)"
      @bind-roles="$emit('bindRoles')"
    />
  </section>
</template>

<style scoped>
.voiceprint-setup-page {
  height: 100%;
  min-height: 0;
  overflow: auto;
  padding: 16px 20px 24px;
}
.voiceprint-setup-header { margin-bottom: 12px; }
.voiceprint-setup-header h2 { margin: 0 0 4px; font-size: 17px; color: #1f3d5c; }
.voiceprint-setup-header p { margin: 0; font-size: 13px; color: #5d7186; }
</style>
