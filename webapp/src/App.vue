<script setup lang="ts">
import { ref } from 'vue'
import MaintenanceGate from './components/MaintenanceGate.vue'
import CaseListView from './views/CaseListView.vue'
import InterrogationWorkspace from './views/InterrogationWorkspace.vue'

const caseId = ref(new URLSearchParams(location.search).get('caseId') || '')

function openCase(id: string) {
  caseId.value = id
  history.replaceState(null, '', `?caseId=${encodeURIComponent(id)}`)
}

function backToList() {
  caseId.value = ''
  history.replaceState(null, '', location.pathname)
}
</script>

<template>
  <MaintenanceGate>
    <CaseListView v-if="!caseId" @open="openCase" />
    <InterrogationWorkspace v-else :key="caseId" :case-id="caseId" @back="backToList" />
  </MaintenanceGate>
</template>
