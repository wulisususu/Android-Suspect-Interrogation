<script setup lang="ts">
import { ref } from 'vue'
import OfficerVoiceprintLibrary from '../components/OfficerVoiceprintLibrary.vue'
import SpeakerCalibrationCenter from '../components/SpeakerCalibrationCenter.vue'

defineEmits<{ back: [] }>()

const activeTab = ref<'library' | 'calibration'>('library')
</script>

<template>
  <main class="system-settings-view">
    <header class="settings-topbar">
      <div>
        <button class="back-button" @click="$emit('back')">‹ 返回案件管理</button>
        <span>系统设置</span>
        <h1>声纹系统管理</h1>
        <p>ERes2Net-large 声纹登记、状态与设备校准统一在此维护。</p>
      </div>
    </header>

    <nav class="settings-tabs" aria-label="声纹系统设置">
      <button :class="{ active: activeTab === 'library' }" @click="activeTab = 'library'">民警声纹库</button>
      <button :class="{ active: activeTab === 'calibration' }" @click="activeTab = 'calibration'">设备校准中心</button>
    </nav>

    <OfficerVoiceprintLibrary v-if="activeTab === 'library'" />
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
