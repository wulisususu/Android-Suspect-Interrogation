# commit: feat: render committed canonical formal answers
from __future__ import annotations

from pathlib import Path


def replace_once(path: str, old: str, new: str) -> None:
    target = Path(path)
    text = target.read_text(encoding="utf-8")
    if old not in text:
        raise SystemExit(f"expected source block missing in {path}: {old[:180]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


types_path = "webapp/src/types/templateInterrogation.ts"
replace_once(
    types_path,
    "export type RoundStatus = 'ACTIVE' | 'CLOSED' | 'DETACHED'\n",
    "export type RoundStatus = 'ACTIVE' | 'CLOSED' | 'DETACHED'\nexport type QARouteClass = 'MATCH_FIXED' | 'MATCH_EXISTING' | 'CREATE_LIVE_FROM_SPEECH' | 'NEEDS_REVIEW' | 'IGNORE'\n\nexport interface FormalQAUnit {\n  id: string; caseId: string; sessionId: string | null; status: 'OPEN' | 'CLOSED' | 'ROUTING' | 'ROUTED' | 'APPLIED' | 'NEEDS_REVIEW' | 'IGNORED'\n  classification: QARouteClass | null; rawQuestionText: string; rawAnswerText: string\n  formalQuestionText: string | null; formalAnswerText: string | null; targetQuestionId: string | null\n  candidateQuestionIds: string[]; questionFragmentIds: string[]; answerFragmentIds: string[]\n  confidence: number | null; modelId: string | null; reasonCode: string | null\n  startedAt: string | null; endedAt: string | null; createdAt: string | null; updatedAt: string | null\n}\n",
)
replace_once(
    types_path,
    "  templateItemKey: string | null; locked: boolean; sortOrder: number; active: boolean; rounds: FormalQuestionRound[]\n  createdAt: string | null; updatedAt: string | null\n",
    "  templateItemKey: string | null; locked: boolean; formalAnswerText: string; firstAskedAt: string | null\n  sortOrder: number; active: boolean; rounds: FormalQuestionRound[]\n  createdAt: string | null; updatedAt: string | null\n",
)
replace_once(
    types_path,
    "export interface TemplateWorkspace {\n  caseId: string; templateKey?: string | null; questions: FormalQuestion[]; rounds: FormalQuestionRound[]; pendingQuestions: PendingFormalQuestion[]\n}\n",
    "export interface TemplateWorkspace {\n  caseId: string; templateKey?: string | null; questions: FormalQuestion[]; rounds: FormalQuestionRound[]; pendingQuestions: PendingFormalQuestion[]; qaUnits: FormalQAUnit[]\n}\n",
)

formal = "webapp/src/components/FormalTemplatePanel.vue"
replace_once(
    formal,
    "const questionDrafts = reactive<Record<string, string>>({})\nconst answerDrafts = reactive<Record<string, string>>({})\nconst manualAnswerDrafts = reactive<Record<string, string>>({})\n",
    "const questionDrafts = reactive<Record<string, string>>({})\nconst canonicalAnswerDrafts = reactive<Record<string, string>>({})\n",
)
replace_once(
    formal,
    "watch(() => props.questions, (items) => {\n  for (const item of items) {\n    questionDrafts[item.id] = item.text\n    if (!(item.id in manualAnswerDrafts)) manualAnswerDrafts[item.id] = ''\n  }\n}, { immediate: true, deep: true })\nwatch(() => props.rounds, (items) => {\n  for (const item of items) if (!(item.id in answerDrafts)) answerDrafts[item.id] = item.answerText\n}, { immediate: true, deep: true })\n",
    "watch(() => props.questions, (items) => {\n  for (const item of items) {\n    questionDrafts[item.id] = item.text\n    canonicalAnswerDrafts[item.id] = item.formalAnswerText ?? ''\n  }\n}, { immediate: true, deep: true })\n",
)
replace_once(
    formal,
    "function saveAnswer(round: FormalQuestionRound) {\n  if (props.documentFrozen || props.busy) return\n  const answer = (answerDrafts[round.id] || '').trim()\n  if (answer !== round.answerText.trim()) emit('updateAnswer', round.id, answer)\n}\nfunction saveManualAnswer(question: FormalQuestion) {\n  if (props.documentFrozen || props.busy) return\n  const answer = (manualAnswerDrafts[question.id] || '').trim()\n  if (answer) emit('updateAnswer', question.id, answer)\n}\n",
    "function saveCanonicalAnswer(question: FormalQuestion) {\n  if (props.documentFrozen || props.busy) return\n  const answer = (canonicalAnswerDrafts[question.id] || '').trim()\n  if (answer !== (question.formalAnswerText ?? '').trim()) emit('updateAnswer', question.id, answer)\n}\n",
)
replace_once(
    formal,
    "          <label v-if=\"latestRound(q.id)\" class=\"record-answer\"><b>答：</b><textarea v-model=\"answerDrafts[latestRound(q.id)!.id]\" :disabled=\"busy || documentFrozen\" rows=\"1\" @blur=\"saveAnswer(latestRound(q.id)!)\"></textarea></label>\n          <label v-else class=\"record-answer\"><b>答：</b><textarea v-model=\"manualAnswerDrafts[q.id]\" :disabled=\"busy || documentFrozen\" rows=\"1\" @blur=\"saveManualAnswer(q)\"></textarea></label>\n",
    "          <label class=\"record-answer\"><b>答：</b><textarea v-model=\"canonicalAnswerDrafts[q.id]\" :disabled=\"busy || documentFrozen\" rows=\"1\" @blur=\"saveCanonicalAnswer(q)\"></textarea></label>\n          <small v-if=\"latestRound(q.id)?.actualQuestionText && latestRound(q.id)?.actualQuestionText !== q.text\" class=\"actual-question record-no-print\">现场原问法：{{ latestRound(q.id)?.actualQuestionText }}</small>\n",
)
replace_once(
    formal,
    "          <template v-if=\"latestRound(q.id)\">\n            <label class=\"record-answer\"><b>答：</b><textarea v-model=\"answerDrafts[latestRound(q.id)!.id]\" :disabled=\"busy || documentFrozen\" rows=\"2\" @blur=\"saveAnswer(latestRound(q.id)!)\"></textarea></label>\n            <small v-if=\"latestRound(q.id)?.actualQuestionText && latestRound(q.id)?.actualQuestionText !== q.text\" class=\"actual-question record-no-print\">现场原问法：{{ latestRound(q.id)?.actualQuestionText }}</small>\n          </template>\n          <label v-else class=\"record-answer\"><b>答：</b><textarea v-model=\"manualAnswerDrafts[q.id]\" :disabled=\"busy || documentFrozen\" rows=\"2\" placeholder=\"等待现场回答\" @blur=\"saveManualAnswer(q)\"></textarea></label>\n",
    "          <label class=\"record-answer\"><b>答：</b><textarea v-model=\"canonicalAnswerDrafts[q.id]\" :disabled=\"busy || documentFrozen\" rows=\"2\" placeholder=\"等待现场回答\" @blur=\"saveCanonicalAnswer(q)\"></textarea></label>\n          <small v-if=\"latestRound(q.id)?.actualQuestionText && latestRound(q.id)?.actualQuestionText !== q.text\" class=\"actual-question record-no-print\">现场原问法：{{ latestRound(q.id)?.actualQuestionText }}</small>\n",
)
replace_once(
    formal,
    "          <label v-if=\"latestRound(q.id)\" class=\"record-answer\"><b>答：</b><textarea v-model=\"answerDrafts[latestRound(q.id)!.id]\" :disabled=\"busy || documentFrozen\" rows=\"1\" @blur=\"saveAnswer(latestRound(q.id)!)\"></textarea></label>\n          <label v-else class=\"record-answer\"><b>答：</b><textarea v-model=\"manualAnswerDrafts[q.id]\" :disabled=\"busy || documentFrozen\" rows=\"1\" @blur=\"saveManualAnswer(q)\"></textarea></label>\n",
    "          <label class=\"record-answer\"><b>答：</b><textarea v-model=\"canonicalAnswerDrafts[q.id]\" :disabled=\"busy || documentFrozen\" rows=\"1\" @blur=\"saveCanonicalAnswer(q)\"></textarea></label>\n          <small v-if=\"latestRound(q.id)?.actualQuestionText && latestRound(q.id)?.actualQuestionText !== q.text\" class=\"actual-question record-no-print\">现场原问法：{{ latestRound(q.id)?.actualQuestionText }}</small>\n",
)

interrogation = "webapp/src/stores/interrogation.ts"
replace_once(
    interrogation,
    "  const capture = ref<AsrCaptureStatus>(emptyCapture(caseId.value))\n  const caseSummary = ref<CaseSummary>(emptyCaseSummary(caseId.value))\n",
    "  const capture = ref<AsrCaptureStatus>(emptyCapture(caseId.value))\n  const formalRecordRevision = ref(0)\n  const caseSummary = ref<CaseSummary>(emptyCaseSummary(caseId.value))\n",
)
replace_once(
    interrogation,
    "    capture.value = emptyCapture(nextCaseId)\n    caseSummary.value = emptyCaseSummary(nextCaseId)\n",
    "    capture.value = emptyCapture(nextCaseId)\n    formalRecordRevision.value = 0\n    caseSummary.value = emptyCaseSummary(nextCaseId)\n",
)
replace_once(
    interrogation,
    "      if (event.event === 'ASR_PARTIAL') {\n",
    "      if (event.event === 'QA_UNIT_UPDATED' || event.event === 'FORMAL_RECORD_UPDATED') {\n        formalRecordRevision.value += 1\n        return\n      }\n      if (event.event === 'ASR_PARTIAL') {\n",
)
replace_once(
    interrogation,
    "    capture,\n    captureBusy,\n",
    "    capture,\n    formalRecordRevision,\n    captureBusy,\n",
)

template_store = "webapp/src/stores/templateInterrogation.ts"
replace_once(
    template_store,
    "function emptyWorkspace(caseId = ''): TemplateWorkspace {\n  return { caseId, questions: [], rounds: [], pendingQuestions: [] }\n}\n",
    "function emptyWorkspace(caseId = ''): TemplateWorkspace {\n  return { caseId, questions: [], rounds: [], pendingQuestions: [], qaUnits: [] }\n}\n",
)
replace_once(
    template_store,
    "  let workspaceRefreshTimer: ReturnType<typeof setTimeout> | undefined\n  let captureBridgeStop: WatchStopHandle | undefined\n",
    "  let workspaceRefreshTimer: ReturnType<typeof setTimeout> | undefined\n  let captureBridgeStop: WatchStopHandle | undefined\n  let formalRevisionBridgeStop: WatchStopHandle | undefined\n",
)
replace_once(
    template_store,
    "    captureBridgeStop?.()\n    captureBridgeStop = undefined\n",
    "    captureBridgeStop?.()\n    captureBridgeStop = undefined\n    formalRevisionBridgeStop?.()\n    formalRevisionBridgeStop = undefined\n",
)
replace_once(
    template_store,
    "  function handleAsrFragment(fragment: TemporaryAsrFragment, scope = currentScope()) {\n    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return\n    upsertDialogue(fragment, scope)\n    scheduleWorkspaceRefresh(scope)\n  }\n",
    "  function handleAsrFragment(fragment: TemporaryAsrFragment, scope = currentScope()) {\n    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return\n    upsertDialogue(fragment, scope)\n  }\n",
)
replace_once(
    template_store,
    "  function attachCaptureBridge(scope: StoreScope) {\n    captureBridgeStop?.()\n    const interrogation = useInterrogationStore()\n    captureBridgeStop = watch(\n      () => interrogation.capture.fragments,\n      (fragments) => {\n        if (!isCurrentScope(scope)) return\n        for (const fragment of fragments) handleAsrFragment(fragment, scope)\n      },\n      { deep: true, immediate: true },\n    )\n  }\n",
    "  function attachCaptureBridge(scope: StoreScope) {\n    captureBridgeStop?.()\n    formalRevisionBridgeStop?.()\n    const interrogation = useInterrogationStore()\n    captureBridgeStop = watch(\n      () => interrogation.capture.fragments,\n      (fragments) => {\n        if (!isCurrentScope(scope)) return\n        for (const fragment of fragments) handleAsrFragment(fragment, scope)\n      },\n      { deep: true, immediate: true },\n    )\n    formalRevisionBridgeStop = watch(\n      () => interrogation.formalRecordRevision,\n      (revision, previousRevision) => {\n        if (!isCurrentScope(scope) || revision === previousRevision) return\n        scheduleWorkspaceRefresh(scope, 0)\n      },\n    )\n  }\n",
)
