<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue'
import OfficerVoiceprintLibrary from '../components/OfficerVoiceprintLibrary.vue'
import SpeakerCalibrationCenter from '../components/SpeakerCalibrationCenter.vue'
import {
  fetchSpeakerRuntimeStatus,
  speakerBackendLabel,
  updateSpeakerRuntimeSelection,
  validateSpeakerRuntimeSelection,
  type SpeakerBackendKey,
  type SpeakerRuntimeMode,
  type SpeakerRuntimeState,
} from '../api/speakerCalibration'

defineEmits<{ back: [] }>()

const activeTab = ref<'runtime' | 'library' | 'calibration'>('runtime')
const runtime = ref<SpeakerRuntimeState | null>(null)
const selectedMode = ref<SpeakerRuntimeMode>('xvector')
const selectedAuthority = ref<SpeakerBackendKey>('xvector')
const loadingRuntime = ref(true)
const savingRuntime = ref(false)
const runtimeError = ref('')

const selectionValidation = computed(() => validateSpeakerRuntimeSelection(
  selectedMode.value,
  selectedMode.value === 'compare' ? selectedAuthority.value : null,
))

function backendReady(backend: SpeakerBackendKey): boolean {
  return runtime.value?.backends[backend]?.ready === true
}

function syncSelection(next: SpeakerRuntimeState) {
  runtime.value = next
  selectedMode.value = next.selection.mode
  selectedAuthority.value = next.selection.authoritativeBackend
}

async function loadRuntime() {
  loadingRuntime.value = true
  runtimeError.value = ''
  try {
    syncSelection(await fetchSpeakerRuntimeStatus())
  } catch (cause) {
    runtimeError.value = cause instanceof Error ? cause.message : '无法读取声纹运行状态'
  } finally {
    loadingRuntime.value = false
  }
}

async function saveRuntimeSelection() {
  if (!selectionValidation.value.valid) {
    runtimeError.value = selectionValidation.value.reason
    return
  }
  savingRuntime.value = true
  runtimeError.value = ''
  try {
    syncSelection(await updateSpeakerRuntimeSelection(
      selectedMode.value,
      selectedMode.value === 'compare' ? selectedAuthority.value : null,
    ))
  } catch (cause) {
    runtimeError.value = cause instanceof Error ? cause.message : '声纹运行模式切换失败'
  } finally {
    savingRuntime.value = false
  }
}

watch(selectedMode, (mode) => {
  if (mode === 'compare' && !backendReady(selectedAuthority.value)) {
    selectedAuthority.value = backendReady('xvector') ? 'xvector' : 'eres2net_large'
  }
})

onMounted(() => void loadRuntime())
</script>

<template>
  <main class="system-settings-view">
    <header class="settings-topbar">
      <div>
        <button class="back-button" @click="$emit('back')">‹ 返回案件管理</button>
        <span>系统设置</span>
        <h1>声纹系统管理</h1>
        <p>运行模式、双后端模型状态、民警声纹资产和设备校准统一在此维护；切换只影响后续新会话。</p>
      </div>
    </header>

    <nav class="settings-tabs" aria-label="声纹系统设置">
      <button :class="{ active: activeTab === 'runtime' }" @click="activeTab = 'runtime'">运行模式</button>
      <button :class="{ active: activeTab === 'library' }" @click="activeTab = 'library'">民警声纹库</button>
      <button :class="{ active: activeTab === 'calibration' }" @click="activeTab = 'calibration'">设备校准中心</button>
    </nav>

    <section v-if="activeTab === 'runtime'" class="runtime-panel">
      <div class="runtime-header">
        <div>
          <h2>Speaker backend</h2>
          <p>可选择 XVector、ERes2Net-large 或 Compare。Compare 必须明确指定业务 authoritative backend，secondary 只提供诊断证据。</p>
        </div>
        <button :disabled="loadingRuntime || savingRuntime || !selectionValidation.valid" @click="saveRuntimeSelection">
          {{ savingRuntime ? '正在应用…' : '应用到后续新会话' }}
        </button>
      </div>

      <p v-if="runtimeError" class="runtime-error">{{ runtimeError }}</p>
      <p v-if="loadingRuntime" class="runtime-loading">正在读取双后端状态…</p>

      <template v-else-if="runtime">
        <div class="mode-grid" role="group" aria-label="声纹运行模式">
          <label><input v-model="selectedMode" type="radio" value="xvector" :disabled="!backendReady('xvector')"> XVector</label>
          <label><input v-model="selectedMode" type="radio" value="eres2net_large" :disabled="!backendReady('eres2net_large')"> ERes2Net-large</label>
          <label><input v-model="selectedMode" type="radio" value="compare"> Compare</label>
        </div>

        <div v-if="selectedMode === 'compare'" class="authority-row">
          <label for="speaker-authority">业务 authoritative backend</label>
          <select id="speaker-authority" v-model="selectedAuthority">
            <option value="xvector" :disabled="!backendReady('xvector')">XVector</option>
            <option value="eres2net_large" :disabled="!backendReady('eres2net_large')">ERes2Net-large</option>
          </select>
          <span>只有 authoritative 结果可以改变正式审讯业务角色；另一后端永不自动晋升。</span>
        </div>

        <div class="backend-health-grid">
          <article v-for="backend in (['xvector', 'eres2net_large'] as SpeakerBackendKey[])" :key="backend">
            <div class="backend-title">
              <strong>{{ speakerBackendLabel(backend) }}</strong>
              <span :class="runtime.backends[backend].ready ? 'ready' : 'unavailable'">
                {{ runtime.backends[backend].ready ? 'READY' : 'UNAVAILABLE' }}
              </span>
            </div>
            <small>{{ runtime.backends[backend].modelId || '模型未识别' }} · {{ runtime.backends[backend].modelVersion || 'version unknown' }}</small>
            <code>{{ runtime.backends[backend].modelFingerprint || 'fingerprint unavailable' }}</code>
            <small v-if="runtime.backends[backend].errorCode">{{ runtime.backends[backend].errorCode }} · {{ runtime.backends[backend].errorType || 'runtime error' }}</small>
          </article>
        </div>

        <p v-if="runtime.degraded" class="degraded-warning">Compare 当前为 degraded：secondary backend 不可用，但 authoritative backend 可继续承担业务判定。</p>
        <p class="runtime-note">当前选择：{{ runtime.selection.mode }} · authoritative={{ runtime.selection.authoritativeBackend }}。运行时切换不覆盖启动配置，服务重启后仍以 SUSPECT_SPEAKER_BACKEND 为默认。</p>
      </template>
    </section>

    <OfficerVoiceprintLibrary v-else-if="activeTab === 'library'" />
    <SpeakerCalibrationCenter v-else />
  </main>
</template>

<style scoped>
.system-settings-view { min-height:100vh; box-sizing:border-box; padding:22px; background:#edf3f7; }
.settings-topbar,.runtime-header { padding:18px 20px; border:1px solid #c7d5e0; border-radius:10px; background:#fff; color:#20384d; }
.settings-topbar { margin-bottom:12px; }
.settings-topbar > div { display:grid; gap:4px; }
.settings-topbar span,.settings-topbar p,.runtime-header p,.runtime-note,.backend-health-grid small { color:#607588; }
.settings-topbar h1,.runtime-header h2 { margin:0; }
.back-button { width:max-content; min-height:36px; margin-bottom:6px; border:1px solid #afc0ce; border-radius:6px; padding:0 12px; background:#fff; color:#31526c; font-weight:700; }
.settings-tabs { display:flex; gap:8px; margin:0 0 16px; padding:8px; border:1px solid #c7d5e0; border-radius:9px; background:#fff; }
.settings-tabs button { min-height:38px; border:1px solid transparent; border-radius:6px; padding:0 16px; background:transparent; color:#49647a; font-weight:700; }
.settings-tabs button.active { border-color:#9bb2c3; background:#edf5fa; color:#1f4a6a; }
.runtime-panel { display:grid; gap:14px; }
.runtime-header { display:flex; align-items:flex-start; justify-content:space-between; gap:16px; }
.runtime-header button { min-height:40px; border:1px solid #2476c9; border-radius:6px; padding:0 14px; background:#2476c9; color:#fff; font-weight:700; }
.runtime-header button:disabled { opacity:.5; }
.mode-grid,.backend-health-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:10px; }
.mode-grid { grid-template-columns:repeat(3,minmax(160px,1fr)); }
.mode-grid label,.backend-health-grid article { padding:14px; border:1px solid #c7d5e0; border-radius:8px; background:#fff; }
.authority-row { display:grid; grid-template-columns:auto minmax(180px,260px) 1fr; align-items:center; gap:12px; padding:14px; border:1px solid #b9cde0; border-radius:8px; background:#f8fbfe; }
.authority-row select { min-height:38px; border:1px solid #9fb2c3; border-radius:6px; padding:0 10px; background:#fff; }
.authority-row span { color:#607588; font-size:13px; }
.backend-health-grid article { display:grid; gap:7px; }
.backend-title { display:flex; justify-content:space-between; gap:12px; }
.backend-title span { border-radius:999px; padding:3px 8px; font-size:11px; font-weight:800; }
.backend-title .ready { background:#edf8f1; color:#267647; }
.backend-title .unavailable { background:#fff1ef; color:#a23b31; }
.backend-health-grid code { overflow-wrap:anywhere; color:#48667e; font-size:12px; }
.degraded-warning,.runtime-error { margin:0; padding:10px 12px; border:1px solid #e0b35f; border-radius:7px; background:#fff8e7; color:#875a0b; }
.runtime-loading { color:#607588; }
.runtime-note { margin:0; font-size:12px; }
@media (max-width:900px) { .mode-grid,.backend-health-grid,.authority-row { grid-template-columns:1fr; } .runtime-header { flex-direction:column; } }
</style>
