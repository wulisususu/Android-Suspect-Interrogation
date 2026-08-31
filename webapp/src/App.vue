<script setup lang="ts">
import { ref } from 'vue'
import MaintenanceGate from './components/MaintenanceGate.vue'
import CaseListView from './views/CaseListView.vue'
import InterrogationWorkspace from './views/InterrogationWorkspace.vue'

const caseId = ref(new URLSearchParams(location.search).get('caseId') || '')

function openCase(id: string) {
  caseId.value = id
  const next = new URL(location.href)
  next.searchParams.set('caseId', id)
  history.replaceState(null, '', next)
}

function backToList() {
  caseId.value = ''
  const next = new URL(location.href)
  next.searchParams.delete('caseId')
  history.replaceState(null, '', next)
}
</script>

<template>
  <MaintenanceGate>
    <CaseListView v-if="!caseId" @open="openCase" />
    <InterrogationWorkspace v-else :key="caseId" :case-id="caseId" @back="backToList" />
  </MaintenanceGate>
</template>
