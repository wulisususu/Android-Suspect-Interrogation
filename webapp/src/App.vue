<script setup lang="ts">
import { ref } from 'vue'
import MaintenanceGate from './components/MaintenanceGate.vue'
import CaseListView from './views/CaseListView.vue'
import InterrogationWorkspace from './views/InterrogationWorkspace.vue'
import SystemSettingsView from './views/SystemSettingsView.vue'

type RootPage = 'cases' | 'settings'

const params = new URLSearchParams(location.search)
const caseId = ref(params.get('caseId') || '')
const rootPage = ref<RootPage>(params.get('view') === 'settings' ? 'settings' : 'cases')

function writeLocation() {
  const next = new URL(location.href)
  if (caseId.value) next.searchParams.set('caseId', caseId.value)
  else next.searchParams.delete('caseId')
  if (!caseId.value && rootPage.value === 'settings') next.searchParams.set('view', 'settings')
  else next.searchParams.delete('view')
  history.replaceState(null, '', next)
}

function openCase(id: string) {
  rootPage.value = 'cases'
  caseId.value = id
  writeLocation()
}

function backToList() {
  caseId.value = ''
  rootPage.value = 'cases'
  writeLocation()
}

function openSettings() {
  caseId.value = ''
  rootPage.value = 'settings'
  writeLocation()
}
</script>

<template>
  <MaintenanceGate>
    <InterrogationWorkspace v-if="caseId" :key="caseId" :case-id="caseId" @back="backToList" />
    <SystemSettingsView v-else-if="rootPage === 'settings'" @back="backToList" />
    <div v-else class="case-root-shell">
      <nav class="root-navigation" aria-label="系统一级导航">
        <div><strong>审讯系统</strong><span>案件业务与系统级资产分离管理</span></div>
        <div class="root-navigation-actions">
          <button class="active">案件管理</button>
          <button @click="openSettings">系统设置 · 民警声纹库</button>
        </div>
      </nav>
      <CaseListView @open="openCase" />
    </div>
  </MaintenanceGate>
</template>

<style scoped>
.case-root-shell { min-height:100vh; background:#edf3f7; }
.root-navigation { display:flex; align-items:center; justify-content:space-between; gap:20px; padding:14px 22px; border-bottom:1px solid #c4d3df; background:#f8fbfd; color:#20384d; }
.root-navigation > div:first-child { display:grid; gap:2px; }
.root-navigation span { color:#687e90; font-size:12px; }
.root-navigation-actions { display:flex; gap:8px; }
.root-navigation-actions button { min-height:38px; border:1px solid #adc0cf; border-radius:6px; padding:0 13px; background:#fff; color:#31506a; font-weight:700; }
.root-navigation-actions button.active { border-color:#2476c9; background:#2476c9; color:#fff; }
@media (max-width:760px) { .root-navigation { align-items:flex-start; flex-direction:column; } .root-navigation-actions { width:100%; } .root-navigation-actions button { flex:1; } }
</style>
