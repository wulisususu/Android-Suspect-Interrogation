<script setup lang="ts">
import { onUnmounted, ref, watch } from 'vue'
import AiSettingsPanel from '../components/AiSettingsPanel.vue'
import CaseOverviewPage from '../components/CaseOverviewPage.vue'
import CaseProfilePage from '../components/CaseProfilePage.vue'
import DeviceStatusBar from '../components/DeviceStatusBar.vue'
import InterrogationPage from '../components/InterrogationPage.vue'
import SessionControls from '../components/SessionControls.vue'
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

function openInterrogation() {
  // Entering the page must never mutate session state. Operators explicitly
  // start / pause / resume / finish from the dedicated touch controls.
  activePage.value = 'interrogation'
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
          <span class="recording" :class="{ muted: store.session.status !== 'RUNNING' }">● {{ store.session.status === 'RUNNING' ? '审讯中' : store.session.status === 'PAUSED' ? '已暂停' : '未录入' }}</span>
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

      <section
        class="workspace-page-body"
        :class="{ 'interrogation-workspace-body': activePage === 'interrogation' }"
      >
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

        <div v-else class="interrogation-workspace-stack">
          <SessionControls
            :session="store.session"
            :stage-text="store.stageText"
            @start="store.startSession"
            @toggle-pause="store.togglePause"
            @finish="store.finishSession"
            @next-stage="store.nextStage"
          />
          <InterrogationPage
            :case-id="store.caseId"
            :summary="store.caseSummary"
            :facts="store.facts"
            :session="store.session"
            :messages="store.transcript"
            :capture="store.capture"
            :can-record="store.canRecord"
            :native-capture-available="store.nativeCaptureAvailable"
            :capture-busy="store.captureBusy"
            :capture-elapsed-ms="store.captureElapsedMs"
            :capture-insertion-receipt="store.captureInsertionReceipt"
            :ai-busy="store.caseAiBusy"
            :ai-error="store.caseAiError"
            @saved="refreshCaseWorkspace"
            @capture-start="store.startCapture"
            @capture-stop="store.stopCapture($event)"
            @generate-ai="generateCaseOverview"
          />
        </div>
      </section>
    </template>
  </main>
</template>

<style scoped>
.interrogation-workspace-body {
  padding: 0;
  overflow: hidden;
}
.interrogation-workspace-stack {
  min-height: 0;
  height: 100%;
  display: grid;
  grid-template-rows: auto minmax(0, 1fr);
}
.interrogation-workspace-stack :deep(.session-controls) {
  min-height: 68px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  padding: 10px 18px;
  border-bottom: 1px solid #c9d7e2;
  background: #f7fbff;
}
.interrogation-workspace-stack :deep(.session-state) {
  display: flex;
  gap: 20px;
  color: #43586c;
  font-size: 14px;
}
.interrogation-workspace-stack :deep(.session-buttons) {
  display: flex;
  gap: 10px;
  align-items: center;
}
.interrogation-workspace-stack :deep(.session-buttons button) {
  min-width: 112px;
  min-height: 48px;
  border: 1px solid #aebfcd;
  border-radius: 7px;
  background: #fff;
  color: #29455d;
  font-weight: 700;
  font-size: 15px;
  touch-action: manipulation;
}
.interrogation-workspace-stack :deep(.session-buttons .session-primary) {
  border-color: #2476c9;
  background: #2476c9;
  color: #fff;
}
.interrogation-workspace-stack :deep(.session-buttons .danger-button) {
  border-color: #d95045;
  color: #b02d24;
}
.interrogation-workspace-stack :deep(.session-buttons button:disabled) {
  opacity: .45;
}
</style>
