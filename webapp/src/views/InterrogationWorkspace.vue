<script setup lang="ts">
import { onMounted, onUnmounted } from 'vue'
import AiSettingsPanel from '../components/AiSettingsPanel.vue'
import CaseAiAnalysisPanel from '../components/CaseAiAnalysisPanel.vue'
import DeviceStatusBar from '../components/DeviceStatusBar.vue'
import FactMatrix from '../components/FactMatrix.vue'
import RevisionDrawer from '../components/RevisionDrawer.vue'
import SessionControls from '../components/SessionControls.vue'
import TimelinePanel from '../components/TimelinePanel.vue'
import TranscriptPanel from '../components/TranscriptPanel.vue'
import { useInterrogationStore } from '../stores/interrogation'

const props = defineProps<{ caseId: string }>()
defineEmits<{ back: [] }>()
const store = useInterrogationStore()

onMounted(async () => {
  store.disposeCaptureEvents()
  store.caseId = props.caseId
  store.transcript = []
  store.timeline = []
  store.facts = []
  store.revisions = []
  store.revisionsOpen = false
  store.error = ''
  await store.initialize()
})
onUnmounted(() => store.disposeCaptureEvents())

function maskedId(idNumber?: string) {
  if (!idNumber) return ''
  return idNumber.length >= 8 ? `${idNumber.slice(0, 3)}***********${idNumber.slice(-4)}` : idNumber
}
</script>

<template>
  <main class="workspace">
    <header class="topbar">
      <div class="case-meta">
        <button class="back-btn" @click="$emit('back')">‹ 返回</button>
        <div>
          <h1>案件审讯工作台</h1>
          <p>
            案件：{{ store.caseSummary.id || '加载中' }}　｜　对象：{{ store.caseSummary.suspectName }}
            <template v-if="store.caseSummary.gender || store.caseSummary.age">　{{ store.caseSummary.gender }} {{ store.caseSummary.age ? `${store.caseSummary.age}岁` : '' }}</template>
            <template v-if="store.caseSummary.idNumber">　｜　身份证：{{ maskedId(store.caseSummary.idNumber) }}</template>
          </p>
        </div>
        <span class="state-chip">{{ store.stateText }}</span>
      </div>
      <div class="operator-meta">
        <AiSettingsPanel />
        <DeviceStatusBar />
        <span>主审：{{ store.caseSummary.officerName }}</span>
        <span class="recording" :class="{ muted: store.session.status !== 'RUNNING' }">● {{ store.session.status === 'RUNNING' ? '审讯中' : '未录入' }}</span>
      </div>
    </header>

    <div class="workspace-toast-region" aria-live="polite">
      <div v-if="store.loading" class="workspace-toast info">正在加载案件状态…</div>
      <div v-else-if="store.actionError" class="workspace-toast error">{{ store.actionError }}</div>
      <div v-else-if="store.actionMessage" class="workspace-toast success">{{ store.actionMessage }}</div>
    </div>

    <SessionControls :session="store.session" :stage-text="store.stageText" @start="store.startSession" @toggle-pause="store.togglePause" @finish="store.finishSession" @next-stage="store.nextStage" />

    <CaseAiAnalysisPanel
      :case-id="store.caseId"
      :analyses="store.caseAiAnalyses"
      :busy="store.caseAiBusy"
      :error="store.caseAiError"
      @generate="store.generateCaseAnalysis"
    />

    <section class="workspace-grid">
      <TimelinePanel :items="store.timeline" />
      <TranscriptPanel
        :messages="store.transcript"
        :streaming="store.streaming"
        :can-record="store.canRecord"
        :native-capture-available="store.nativeCaptureAvailable"
        :capture="store.capture"
        :capture-busy="store.captureBusy"
        :capture-elapsed-ms="store.captureElapsedMs"
        :selected-fragment-ids="store.selectedFragmentIds"
        :error="store.error"
        @send="store.ask"
        @edit="store.editMessage"
        @mark="store.markMessage"
        @mark-latest="store.markLatestConflict"
        @versions="store.openRevisions"
        @capture-start="store.startCapture"
        @capture-stop="store.stopCapture"
        @update-fragment="store.updatePendingFragment"
        @confirm-fragment="store.confirmPendingFragment"
        @discard-fragment="store.discardPendingFragment"
        @toggle-fragment="store.toggleFragmentSelection"
        @confirm-selected="store.confirmSelectedFragments"
      />
      <FactMatrix :items="store.facts" :completion="store.completion" @use-suggestion="store.useSuggestion" />
    </section>

    <RevisionDrawer v-if="store.revisionsOpen" :revisions="store.revisions" @close="store.closeRevisions" />
  </main>
</template>
