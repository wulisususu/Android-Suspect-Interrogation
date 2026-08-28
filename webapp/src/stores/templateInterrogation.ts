import { computed, ref, watch, type WatchStopHandle } from 'vue'
import { defineStore } from 'pinia'

import { backendErrorMessage, listAsrFragments } from '../api/interrogation'
import {
  addPendingQuestion,
  createCaseQuestion as createCaseQuestionApi,
  fetchQuestionLibrary,
  fetchTemplateWorkspace,
  ignorePendingQuestion,
  linkPendingQuestion,
  reassociateRound as reassociateRoundApi,
  reorderCaseQuestions as reorderCaseQuestionsApi,
  saveQuestionToLibrary as saveQuestionToLibraryApi,
  updateCaseQuestion as updateCaseQuestionApi,
  updateRoundAnswer as updateRoundAnswerApi,
} from '../api/templateInterrogation'
import type { TemporaryAsrFragment } from '../types/interrogation'
import type {
  CaseQuestionCreateInput,
  CaseQuestionUpdateInput,
  PendingResolution,
  RoundReassociateInput,
  StandardQuestion,
  TemplateWorkspace,
} from '../types/templateInterrogation'
import { roundGroups } from '../utils/templateInterrogation'
import { useInterrogationStore } from './interrogation'

function emptyWorkspace(caseId = ''): TemplateWorkspace {
  return { caseId, questions: [], rounds: [], pendingQuestions: [] }
}

function dialogueOrder(left: TemporaryAsrFragment, right: TemporaryAsrFragment): number {
  return left.startedAtMs - right.startedAtMs || left.ordinal - right.ordinal || left.id.localeCompare(right.id)
}

interface StoreScope {
  caseId: string
  generation: number
}

export const useTemplateInterrogationStore = defineStore('template-interrogation', () => {
  const caseId = ref('')
  const workspace = ref<TemplateWorkspace>(emptyWorkspace())
  const dialogueHistory = ref<TemporaryAsrFragment[]>([])
  const questionLibrary = ref<StandardQuestion[]>([])
  const loading = ref(false)
  const mutating = ref(false)
  const error = ref('')

  let generation = 0
  let workspaceRefreshTimer: ReturnType<typeof setTimeout> | undefined
  let captureBridgeStop: WatchStopHandle | undefined

  const groupedRounds = computed(() => roundGroups(workspace.value.questions, workspace.value.rounds))
  const unresolvedPending = computed(() => workspace.value.pendingQuestions.filter((item) => item.status === 'PENDING' || item.status === 'DEFERRED'))

  function currentScope(): StoreScope {
    return { caseId: caseId.value, generation }
  }

  function isCurrentScope(scope: StoreScope): boolean {
    return scope.generation === generation && scope.caseId === caseId.value
  }

  function clearScheduledRefresh() {
    if (workspaceRefreshTimer) clearTimeout(workspaceRefreshTimer)
    workspaceRefreshTimer = undefined
  }

  function reset(nextCaseId = '') {
    generation += 1
    clearScheduledRefresh()
    captureBridgeStop?.()
    captureBridgeStop = undefined
    caseId.value = nextCaseId
    workspace.value = emptyWorkspace(nextCaseId)
    dialogueHistory.value = []
    questionLibrary.value = []
    loading.value = false
    mutating.value = false
    error.value = ''
  }

  function upsertDialogue(fragment: TemporaryAsrFragment, scope = currentScope()) {
    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return
    const index = dialogueHistory.value.findIndex((item) => item.id === fragment.id)
    if (index >= 0) {
      dialogueHistory.value[index] = fragment
      dialogueHistory.value = [...dialogueHistory.value].sort(dialogueOrder)
      return
    }
    dialogueHistory.value = [...dialogueHistory.value, fragment].sort(dialogueOrder)
  }

  function scheduleWorkspaceRefresh(scope = currentScope(), delayMs = 90) {
    if (!isCurrentScope(scope)) return
    clearScheduledRefresh()
    workspaceRefreshTimer = setTimeout(() => {
      workspaceRefreshTimer = undefined
      if (!isCurrentScope(scope)) return
      void refreshWorkspace(scope).catch(() => undefined)
    }, delayMs)
  }

  function handleAsrFragment(fragment: TemporaryAsrFragment, scope = currentScope()) {
    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return
    upsertDialogue(fragment, scope)
    scheduleWorkspaceRefresh(scope)
  }

  function attachCaptureBridge(scope: StoreScope) {
    captureBridgeStop?.()
    const interrogation = useInterrogationStore()
    captureBridgeStop = watch(
      () => interrogation.capture.fragments,
      (fragments) => {
        if (!isCurrentScope(scope)) return
        for (const fragment of fragments) handleAsrFragment(fragment, scope)
      },
      { deep: true, immediate: true },
    )
  }

  async function loadTemplateWorkspace(scope = currentScope()) {
    const next = await fetchTemplateWorkspace(scope.caseId)
    if (!isCurrentScope(scope)) return
    if (next.caseId !== scope.caseId) throw new Error('模板工作台案件号与当前案件不一致')
    workspace.value = next
  }

  async function loadDialogueHistory(scope = currentScope()) {
    const fragments = await listAsrFragments(scope.caseId, true)
    if (!isCurrentScope(scope)) return
    dialogueHistory.value = [...fragments].sort(dialogueOrder)
  }

  async function initialize(nextCaseId: string) {
    const cleanCaseId = nextCaseId.trim()
    if (!cleanCaseId) {
      reset('')
      return
    }

    reset(cleanCaseId)
    const scope = currentScope()
    loading.value = true
    try {
      await Promise.all([loadTemplateWorkspace(scope), loadDialogueHistory(scope)])
      if (!isCurrentScope(scope)) return
      attachCaptureBridge(scope)
    } catch (err) {
      if (!isCurrentScope(scope)) return
      error.value = backendErrorMessage(err)
      throw err
    } finally {
      if (isCurrentScope(scope)) loading.value = false
    }
  }

  async function refreshWorkspace(scope = currentScope()) {
    try {
      await loadTemplateWorkspace(scope)
      if (isCurrentScope(scope)) error.value = ''
    } catch (err) {
      if (isCurrentScope(scope)) error.value = backendErrorMessage(err)
      throw err
    }
  }

  async function runMutation(action: (scope: StoreScope) => Promise<unknown>) {
    if (mutating.value) return
    const scope = currentScope()
    mutating.value = true
    error.value = ''
    try {
      await action(scope)
      if (!isCurrentScope(scope)) return
      await loadTemplateWorkspace(scope)
    } catch (err) {
      if (isCurrentScope(scope)) error.value = backendErrorMessage(err)
      throw err
    } finally {
      if (isCurrentScope(scope)) mutating.value = false
    }
  }

  async function createCaseQuestion(input: CaseQuestionCreateInput) {
    await runMutation((scope) => createCaseQuestionApi(scope.caseId, input))
  }

  async function updateCaseQuestion(questionId: string, input: CaseQuestionUpdateInput) {
    await runMutation((scope) => updateCaseQuestionApi(scope.caseId, questionId, input))
  }

  async function reorderCaseQuestions(questionIds: string[]) {
    await runMutation((scope) => reorderCaseQuestionsApi(scope.caseId, questionIds))
  }

  async function resolvePendingQuestion(pendingId: string, resolution: PendingResolution) {
    await runMutation(async (scope) => {
      if (resolution.action === 'ADD') {
        await addPendingQuestion(scope.caseId, pendingId, resolution.afterQuestionId)
        return
      }
      if (resolution.action === 'LINK') {
        await linkPendingQuestion(scope.caseId, pendingId, resolution.caseQuestionId, resolution.roundMode)
        return
      }
      await ignorePendingQuestion(scope.caseId, pendingId)
    })
  }

  async function reassociateRound(roundId: string, input: RoundReassociateInput) {
    await runMutation((scope) => reassociateRoundApi(scope.caseId, roundId, input))
  }

  async function updateRoundAnswer(roundId: string, answerText: string) {
    await runMutation((scope) => updateRoundAnswerApi(scope.caseId, roundId, answerText))
  }

  async function loadQuestionLibrary(category?: string) {
    const scope = currentScope()
    try {
      const rows = await fetchQuestionLibrary(category)
      if (isCurrentScope(scope)) questionLibrary.value = rows
    } catch (err) {
      if (isCurrentScope(scope)) error.value = backendErrorMessage(err)
      throw err
    }
  }

  async function saveQuestionToLibrary(questionId: string, category = '通用') {
    await runMutation(async (scope) => {
      await saveQuestionToLibraryApi(scope.caseId, questionId, category)
      const rows = await fetchQuestionLibrary()
      if (isCurrentScope(scope)) questionLibrary.value = rows
    })
  }

  return {
    caseId,
    workspace,
    dialogueHistory,
    questionLibrary,
    loading,
    mutating,
    error,
    groupedRounds,
    unresolvedPending,
    reset,
    initialize,
    loadTemplateWorkspace,
    loadDialogueHistory,
    refreshWorkspace,
    handleAsrFragment,
    createCaseQuestion,
    updateCaseQuestion,
    reorderCaseQuestions,
    resolvePendingQuestion,
    reassociateRound,
    updateRoundAnswer,
    loadQuestionLibrary,
    saveQuestionToLibrary,
  }
})
