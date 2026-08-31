<script setup lang="ts">
import { computed, unref, type Ref } from 'vue'
import type { VoiceprintAudioSource } from '../api/browserVoiceprint'
import { audioInputMode } from '../config/audioInput'

const props = defineProps<{
  source: VoiceprintAudioSource | null | Ref<VoiceprintAudioSource | null>
  reason: string | Ref<string>
  secureContext: boolean | Ref<boolean>
}>()

const sourceValue = computed(() => unref(props.source))
const effectiveSource = computed<VoiceprintAudioSource>(() => sourceValue.value ?? audioInputMode)
const reasonValue = computed(() => {
  if (sourceValue.value) return unref(props.reason)
  return effectiveSource.value === 'BROWSER'
    ? '局域网测试模式：固定使用当前 Windows 浏览器麦克风；失败会直接提示，不回退 Linux 麦克风。'
    : '生产模式：固定使用 Linux 一体机 ALSA 麦克风，不请求浏览器权限。'
})
const secureContextValue = computed(() => unref(props.secureContext))
</script>

<template>
  <aside class="voiceprint-source-banner" :class="effectiveSource.toLowerCase()" aria-live="polite">
    <div>
      <strong v-if="effectiveSource === 'BROWSER'">音源：Windows 浏览器麦克风（局域网测试）</strong>
      <strong v-else>音源：Linux 一体机麦克风（生产）</strong>
      <span>{{ reasonValue }}</span>
    </div>
    <span v-if="effectiveSource === 'BROWSER'" class="security-chip" :class="{ secure: secureContextValue }">{{ secureContextValue ? '浏览器麦克风上下文可用' : '需用 LAN 测试启动脚本' }}</span>
    <span v-else class="security-chip secure">ALSA 本机音源</span>
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
