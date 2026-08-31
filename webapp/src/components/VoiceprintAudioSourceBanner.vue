<script setup lang="ts">
import type { VoiceprintAudioSource } from '../api/browserVoiceprint'

defineProps<{
  source: VoiceprintAudioSource | null
  reason: string
  secureContext: boolean
}>()
</script>

<template>
  <aside class="voiceprint-source-banner" :class="source?.toLowerCase() || 'auto'" aria-live="polite">
    <div>
      <strong v-if="source === 'BROWSER'">音源：本机浏览器麦克风（远程）</strong>
      <strong v-else-if="source === 'ALSA'">音源：RK3588 开发板麦克风（现场）</strong>
      <strong v-else>AUTO 声纹音源</strong>
      <span>{{ reason }}</span>
    </div>
    <span class="security-chip" :class="{ secure: secureContext }">{{ secureContext ? 'HTTPS/安全上下文' : 'HTTP/非安全上下文' }}</span>
  </aside>
</template>

<style scoped>
.voiceprint-source-banner { display:flex; align-items:center; justify-content:space-between; gap:16px; padding:10px 18px; border-bottom:1px solid #c9d7e2; background:#f7fbff; color:#29465f; }
.voiceprint-source-banner > div { display:flex; flex-direction:column; gap:3px; min-width:0; }
.voiceprint-source-banner strong { font-size:14px; }
.voiceprint-source-banner span { font-size:12px; color:#62788c; }
.voiceprint-source-banner.browser { background:#eef9f2; border-bottom-color:#add1ba; }
.voiceprint-source-banner.alsa { background:#fff8e8; border-bottom-color:#e5c77e; }
.security-chip { flex:none; border:1px solid #d7b36b; border-radius:999px; padding:5px 9px; background:#fff; color:#895c0b !important; font-weight:700; }
.security-chip.secure { border-color:#8fc6a6; color:#267647 !important; }
</style>
