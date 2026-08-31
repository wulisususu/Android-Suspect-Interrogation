<script setup lang="ts">
import OfficerVoiceprintLibrary from '../components/OfficerVoiceprintLibrary.vue'

defineEmits<{ back: [] }>()
</script>

<template>
  <main class="system-settings-view">
    <header class="settings-topbar">
      <div>
        <button class="back-button" @click="$emit('back')">‹ 返回案件管理</button>
        <span>系统设置</span>
        <h1>民警声纹库</h1>
        <p>维护跨案件复用的民警声纹档案、样本和聚合 reference。</p>
      </div>
    </header>
    <OfficerVoiceprintLibrary />
  </main>
</template>

<style scoped>
.system-settings-view { min-height:100vh; box-sizing:border-box; padding:22px; background:#edf3f7; }
.settings-topbar { margin-bottom:16px; padding:18px 20px; border:1px solid #c7d5e0; border-radius:10px; background:#fff; color:#20384d; }
.settings-topbar > div { display:grid; gap:4px; }
.settings-topbar span { color:#607588; font-size:12px; letter-spacing:.08em; }
.settings-topbar h1 { margin:0; font-size:27px; }
.settings-topbar p { margin:0; color:#617588; }
.back-button { width:max-content; min-height:36px; margin-bottom:6px; border:1px solid #afc0ce; border-radius:6px; padding:0 12px; background:#fff; color:#31526c; font-weight:700; }
</style>
