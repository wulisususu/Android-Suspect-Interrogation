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
        <p>民警声纹属于跨案件复用的系统资产；设备校准独立维护，不进入案件准备流程。</p>
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
.settings-topbar { margin-bottom:12px; padding:18px 20px; border:1px solid #c7d5e0; border-radius:10px; background:#fff; color:#20384d; }
.settings-topbar > div { display:grid; gap:4px; }
.settings-topbar span { color:#607588; font-size:12px; letter-spacing:.08em; }
.settings-topbar h1 { margin:0; font-size:27px; }
.settings-topbar p { margin:0; color:#617588; }
.back-button { width:max-content; min-height:36px; margin-bottom:6px; border:1px solid #afc0ce; border-radius:6px; padding:0 12px; background:#fff; color:#31526c; font-weight:700; }
.settings-tabs { display:flex; gap:8px; margin:0 0 16px; padding:8px; border:1px solid #c7d5e0; border-radius:9px; background:#fff; }
.settings-tabs button { min-height:38px; border:1px solid transparent; border-radius:6px; padding:0 16px; background:transparent; color:#49647a; font-weight:700; }
.settings-tabs button.active { border-color:#9bb2c3; background:#edf5fa; color:#1f4a6a; }
</style>
