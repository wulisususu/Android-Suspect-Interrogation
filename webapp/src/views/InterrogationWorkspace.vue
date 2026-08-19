<script setup lang="ts">
import { onUnmounted, ref, watch } from 'vue'
import AiSettingsPanel from '../components/AiSettingsPanel.vue'
import CaseOverviewPage from '../components/CaseOverviewPage.vue'
import CaseProfilePage from '../components/CaseProfilePage.vue'
import DeviceStatusBar from '../components/DeviceStatusBar.vue'
import InterrogationPage from '../components/InterrogationPage.vue'
import { useInterrogationStore } from '../stores/interrogation'

type WorkspacePage = 'profile' | 'overview' | 'interrogation'

const props = defineProps<{ caseId: string }>()
defineEmits<{ back: [] }>()
const store = useInterrogationStore()
const activePage = ref<WorkspacePage>('profile')

watch(
  () => props.caseId,
  async (nextCaseId) => {
    activePage.value = 'profile'
    store.resetCaseContext(nextCaseId)
    await store.initialize()
  },
  { immediate: true },
)

onUnmounted(() => {
  if (store.caseId === props.caseId) store.resetCaseContext()
})

async function refreshCaseWorkspace() {
  await store.initialize()
}

async function openInterrogation() {
  activePage.value = 'interrogation'
  if (store.session.status === 'READY') await store.startSession()
  else if (store.session.status === 'PAUSED') await store.togglePause()
}

async function generateCaseOverview() {
  await store.generateCaseAnalysis()
  if (store.caseAiError) return
  await store.initialize()
  activePage.value = 'overview'
}
</script>

<template>
  <main class="workspace">
    <section v-if="store.loading" class="case-loading" aria-live="polite" aria-busy="true">
      <h1>正在加载案件</h1>
      <p>正在读取案件身份、审讯记录和案件梳理数据…</p>
    </section>

    <template v-else>
      <header class="topbar">
        <div class="case-meta">
          <button class="back-btn" @click="$emit('back')">‹ 返回</button>
          <div>
            <h1>案件审讯工作台</h1>
            <p>案件：{{ store.caseSummary.id || store.caseId }}　｜　对象：{{ store.caseSummary.suspectName || '待录入' }}</p>
          </div>
          <span class="state-chip">{{ store.stateText }}</span>
        </div>
        <div class="operator-meta">
          <AiSettingsPanel />
          <DeviceStatusBar />
          <span>主审：{{ store.caseSummary.officerName || '当前警官' }}</span>
          <span class="recording" :class="{ muted: store.session.status !== 'RUNNING' }">● {{ store.session.status === 'RUNNING' ? '审讯中' : '未录入' }}</span>
        </div>
      </header>

      <nav class="workspace-page-tabs" aria-label="案件工作区页面">
        <button :class="{ active: activePage === 'profile' }" @click="activePage = 'profile'">
          <b>A</b><span>身份信息</span>
        </button>
        <button :class="{ active: activePage === 'overview' }" @click="activePage = 'overview'">
          <b>B</b><span>案件梳理</span>
        </button>
        <button :class="{ active: activePage === 'interrogation' }" @click="openInterrogation">
          <b>C</b><span>审讯记录</span>
        </button>
      </nav>

      <div class="workspace-toast-region" aria-live="polite">
        <div v-if="store.actionError" class="workspace-toast error">{{ store.actionError }}</div>
        <div v-else-if="store.actionMessage" class="workspace-toast success">{{ store.actionMessage }}</div>
      </div>

      <section class="workspace-page-body" :class="{ 'interrogation-body': activePage === 'interrogation' }">
        <CaseProfilePage
          v-if="activePage === 'profile'"
          :summary="store.caseSummary"
          :facts="store.facts"
          @saved="refreshCaseWorkspace"
        />

        <CaseOverviewPage
          v-else-if="activePage === 'overview'"
          :timeline="store.timeline"
          :facts="store.facts"
        />

        <InterrogationPage
          v-else
          :case-id="store.caseId"
          :summary="store.caseSummary"
          :messages="store.transcript"
          :capture="store.capture"
          :can-record="store.canRecord"
          :can-finish="store.session.status === 'RUNNING' || store.session.status === 'PAUSED'"
          :native-capture-available="store.nativeCaptureAvailable"
          :capture-busy="store.captureBusy"
          :capture-elapsed-ms="store.captureElapsedMs"
          :ai-busy="store.caseAiBusy"
          :ai-error="store.caseAiError"
          @saved="refreshCaseWorkspace"
          @capture-start="store.startCapture"
          @capture-stop="store.stopCapture"
          @finish-session="store.finishSession"
          @generate-ai="generateCaseOverview"
        />
      </section>
    </template>
  </main>
</template>
