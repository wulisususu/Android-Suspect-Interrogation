<script setup lang="ts">
import { computed, onUnmounted, ref, watch } from 'vue'
import { backendErrorMessage } from '../api/interrogation'
import {
  startQuestionPreparationDictation,
  stopQuestionPreparationDictation,
} from '../api/templateInterrogation'
import AiSettingsPanel from '../components/AiSettingsPanel.vue'
import CaseOverviewPage from '../components/CaseOverviewPage.vue'
import CaseProfilePage from '../components/CaseProfilePage.vue'
import DeviceStatusBar from '../components/DeviceStatusBar.vue'
import SessionControls from '../components/SessionControls.vue'
import TemplateDrivenInterrogationPage from '../components/TemplateDrivenInterrogationPage.vue'
import VoiceprintPreparationPanel, { voiceprintStartGuard } from '../components/VoiceprintPreparationPanel.vue'
import { useInterrogationStore } from '../stores/interrogation'
import { useTemplateInterrogationStore } from '../stores/templateInterrogation'
import type {
  CaseQuestionCreateInput,
  CaseQuestionUpdateInput,
  PendingResolution,
  RoundReassociateInput,
} from '../types/templateInterrogation'

type WorkspacePage = 'profile' | 'overview' | 'interrogation'

const props = defineProps<{ caseId: string }>()
defineEmits<{ back: [] }>()
const store = useInterrogationStore()
const templateStore = useTemplateInterrogationStore()
const activePage = ref<WorkspacePage>('profile')
const voiceprintGuard = computed(() => voiceprintStartGuard(store.voiceprintReadiness))
const questionDictationDraft = ref('')
const questionDictationActive = ref(false)
const questionDictationBusy = ref(false)
const questionDictationError = ref('')

function resetQuestionDictationState() {
  questionDictationDraft.value = ''
  questionDictationActive.value = false
  questionDictationBusy.value = false
  questionDictationError.value = ''
}

watch(
  () => props.caseId,
  async (nextCaseId) => {
    const previousCaseId = store.caseId
    if (questionDictationActive.value && previousCaseId && previousCaseId !== nextCaseId) {
      void stopQuestionPreparationDictation(previousCaseId).catch(() => undefined)
    }
    resetQuestionDictationState()
    activePage.value = 'profile'
    store.resetCaseContext(nextCaseId)
    templateStore.reset(nextCaseId)
    await store.initialize()
    if (store.caseId !== nextCaseId) return
    try {
      await templateStore.initialize(nextCaseId)
    } catch {
      store.feedback(templateStore.error || '模板笔录工作台加载失败', true)
    }
  },
  { immediate: true },
)

onUnmounted(() => {
  if (questionDictationActive.value && store.caseId) {
    void stopQuestionPreparationDictation(store.caseId).catch(() => undefined)
  }
  if (store.caseId === props.caseId) store.resetCaseContext()
  if (templateStore.caseId === props.caseId) templateStore.reset()
})

async function startQuestionDictation() {
  if (!store.caseId || questionDictationBusy.value || questionDictationActive.value) return
  const caseId = store.caseId
  questionDictationBusy.value = true
  questionDictationError.value = ''
  try {
    const status = await startQuestionPreparationDictation(caseId)
    if (store.caseId !== caseId) return
    questionDictationDraft.value = ''
    questionDictationActive.value = status.active
  } catch (err) {
    if (store.caseId !== caseId) return
    questionDictationError.value = backendErrorMessage(err)
    store.feedback(questionDictationError.value, true)
  } finally {
    if (store.caseId === caseId) questionDictationBusy.value = false
  }
}

async function stopQuestionDictation() {
  if (!store.caseId || questionDictationBusy.value || !questionDictationActive.value) return
  const caseId = store.caseId
  questionDictationBusy.value = true
  questionDictationError.value = ''
  try {
    const status = await stopQuestionPreparationDictation(caseId)
    if (store.caseId !== caseId) return
    questionDictationActive.value = false
    questionDictationDraft.value = status.text || ''
    if (status.lastError) {
      questionDictationError.value = status.lastError
      store.feedback(status.lastError, true)
    }
  } catch (err) {
    if (store.caseId !== caseId) return
    questionDictationError.value = backendErrorMessage(err)
    store.feedback(questionDictationError.value, true)
  } finally {
    if (store.caseId === caseId) questionDictationBusy.value = false
  }
}

async function refreshCaseWorkspace() {
  await store.initialize()
  if (!store.caseId) return
  try {
    await templateStore.initialize(store.caseId)
  } catch {
    store.feedback(templateStore.error || '模板笔录工作台刷新失败', true)
  }
}

function openInterrogation() {
  // Entering the page must never mutate session state. Operators explicitly
  // start / pause / resume / finish from the dedicated touch controls.
  activePage.value = 'interrogation'
}

async function generateCaseOverview() {
  await store.generateCaseAnalysis()
  if (store.caseAiError) return
  await refreshCaseWorkspace()
  activePage.value = 'overview'
}

async function runTemplateAction(action: () => Promise<unknown>) {
  try {
    await action()
  } catch {
    store.feedback(templateStore.error || '模板笔录操作失败', true)
  }
}

function loadQuestionLibrary(category?: string) {
  return runTemplateAction(() => templateStore.loadQuestionLibrary(category))
}

function createFormalQuestion(input: CaseQuestionCreateInput) {
  return runTemplateAction(() => templateStore.createCaseQuestion(input))
}

function updateFormalQuestion(questionId: string, input: CaseQuestionUpdateInput) {
  return runTemplateAction(() => templateStore.updateCaseQuestion(questionId, input))
}

function reorderFormalQuestions(questionIds: string[]) {
  return runTemplateAction(() => templateStore.reorderCaseQuestions(questionIds))
}

function resolvePendingQuestion(pendingId: string, resolution: PendingResolution) {
  return runTemplateAction(() => templateStore.resolvePendingQuestion(pendingId, resolution))
}

function reassociateFormalRound(roundId: string, input: RoundReassociateInput) {
  return runTemplateAction(() => templateStore.reassociateRound(roundId, input))
}

function updateFormalAnswer(roundId: string, answerText: string) {
  return runTemplateAction(() => templateStore.updateRoundAnswer(roundId, answerText))
}

function saveFormalQuestionToLibrary(questionId: string) {
  return runTemplateAction(() => templateStore.saveQuestionToLibrary(questionId))
}
</script>

<template>
  <main class="workspace">
    <section v-if="store.loading" class="case-loading" aria-live="polite" aria-busy="true">
      <h1>正在加载案件</h1>
      <p>正在读取案件身份、审讯记录、声纹状态和案件梳理数据…</p>
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
          <VoiceprintPreparationPanel
            v-if="store.session.status === 'READY'"
            :suspect-name="store.caseSummary.suspectName"
            :readiness="store.voiceprintReadiness"
            :officers="store.officerVoiceprints"
            :selected-interrogator-officer-id="store.selectedInterrogatorOfficerId"
            :selected-recorder-officer-id="store.selectedRecorderOfficerId"
            :enrollment-state="store.voiceprintEnrollmentState"
            :busy="store.voiceprintBusy"
            :session-status="store.session.status"
            @suspect-start="store.startSuspectVoiceprintEnrollment()"
            @suspect-stop="store.stopSuspectVoiceprintEnrollment()"
            @select-interrogator="store.selectInterrogatorOfficer($event)"
            @select-recorder="store.selectRecorderOfficer($event)"
            @officer-start="(id, name) => store.startOfficerVoiceprintEnrollment(id, name)"
            @officer-stop="store.stopOfficerVoiceprintEnrollment($event)"
            @revoke-officer="store.revokeOfficerVoiceprint($event)"
            @bind-roles="store.bindVoiceprintRoles()"
          />

          <SessionControls
            :session="store.session"
            :stage-text="store.stageText"
            :start-disabled="voiceprintGuard.disabled || questionDictationActive || questionDictationBusy"
            :start-disabled-reason="questionDictationActive || questionDictationBusy ? '请先停止准备阶段语音输入，再开始正式审讯。' : voiceprintGuard.reason"
            @start="store.startSession"
            @toggle-pause="store.togglePause"
            @finish="store.finishSession"
            @next-stage="store.nextStage"
          />

          <TemplateDrivenInterrogationPage
            :case-id="store.caseId"
            :summary="store.caseSummary"
            :session="store.session"
            :capture="store.capture"
            :can-record="store.canRecord"
            :native-capture-available="store.nativeCaptureAvailable"
            :capture-busy="store.captureBusy"
            :capture-elapsed-ms="store.captureElapsedMs"
            :ai-busy="store.caseAiBusy"
            :ai-error="store.caseAiError"
            :workspace="templateStore.workspace"
            :dialogue-history="templateStore.dialogueHistory"
            :question-library="templateStore.questionLibrary"
            :template-busy="templateStore.loading || templateStore.mutating"
            :template-error="templateStore.error"
            :question-dictation-available="store.nativeCaptureAvailable && store.session.status === 'READY'"
            :question-dictation-active="questionDictationActive"
            :question-dictation-busy="questionDictationBusy"
            :question-dictation-draft="questionDictationDraft"
            :question-dictation-error="questionDictationError"
            @saved="refreshCaseWorkspace"
            @capture-start="store.startCapture"
            @capture-stop="store.stopCapture($event)"
            @question-dictation-start="startQuestionDictation"
            @question-dictation-stop="stopQuestionDictation"
            @generate-ai="generateCaseOverview"
            @load-library="loadQuestionLibrary"
            @create-question="createFormalQuestion"
            @update-question="updateFormalQuestion"
            @reorder-questions="reorderFormalQuestions"
            @resolve-pending="resolvePendingQuestion"
            @reassociate-round="reassociateFormalRound"
            @update-answer="updateFormalAnswer"
            @save-library="saveFormalQuestionToLibrary"
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
  grid-template-rows: auto auto minmax(0, 1fr);
}
.interrogation-workspace-stack > :deep(.voiceprint-preparation-panel) {
  max-height: 44vh;
  overflow: auto;
}
.interrogation-workspace-stack > :deep(.session-controls):first-child,
.interrogation-workspace-stack > :deep(.voiceprint-preparation-panel) + :deep(.session-controls) {
  min-height: 68px;
}
.interrogation-workspace-stack :deep(.session-controls) {
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
  flex-wrap: wrap;
  gap: 12px 20px;
  color: #43586c;
  font-size: 14px;
}
.interrogation-workspace-stack :deep(.session-start-guard) {
  flex-basis: 100%;
  color: #ad3c32;
  font-weight: 700;
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
