# commit: feat: add qa review drag and drop
from __future__ import annotations

from pathlib import Path


def replace_once(path: str, old: str, new: str) -> None:
    target = Path(path)
    text = target.read_text(encoding="utf-8")
    if old not in text:
        raise SystemExit(f"expected source block missing in {path}: {old[:180]!r}")
    target.write_text(text.replace(old, new, 1), encoding="utf-8")


def insert_before(path: str, marker: str, content: str) -> None:
    target = Path(path)
    text = target.read_text(encoding="utf-8")
    if marker not in text:
        raise SystemExit(f"marker missing in {path}: {marker[:120]!r}")
    target.write_text(text.replace(marker, content + marker, 1), encoding="utf-8")


# Keep the raw-fragment refresh as a compatibility fallback for the default
# legacy projection mode. Qwen mode still gets an authoritative post-commit
# revision refresh, so this fallback cannot be the correctness signal there.
replace_once(
    "webapp/src/stores/templateInterrogation.ts",
    '''  function handleAsrFragment(fragment: TemporaryAsrFragment, scope = currentScope()) {
    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return
    upsertDialogue(fragment, scope)
  }
''',
    '''  function handleAsrFragment(fragment: TemporaryAsrFragment, scope = currentScope()) {
    if (!isCurrentScope(scope) || fragment.caseId !== scope.caseId) return
    upsertDialogue(fragment, scope)
    // Legacy projection mode has no committed QA routing revision event.
    scheduleWorkspaceRefresh(scope)
  }
''',
)

# Shared frontend resolution contract.
types_path = "webapp/src/types/templateInterrogation.ts"
replace_once(
    types_path,
    "  id: string; caseId: string; sessionId: string | null; status: 'OPEN' | 'CLOSED' | 'ROUTING' | 'ROUTED' | 'APPLIED' | 'NEEDS_REVIEW' | 'IGNORED'\n",
    "  id: string; caseId: string; sessionId: string | null; status: 'OPEN' | 'CLOSED' | 'ROUTING' | 'APPLIED' | 'NEEDS_REVIEW' | 'IGNORED'\n",
)
replace_once(
    types_path,
    "export interface RoundReassociateInput { caseQuestionId?: string | null; newQuestionText?: string | null }\n",
    "export interface RoundReassociateInput { caseQuestionId?: string | null; newQuestionText?: string | null }\nexport type QAUnitResolution =\n  | { action: 'CREATE_LIVE'; formalQuestion?: string | null; formalAnswer?: string | null }\n  | { action: 'LINK_QA'; caseQuestionId: string; formalAnswer?: string | null }\n  | { action: 'LINK_ANSWER'; caseQuestionId: string; formalAnswer?: string | null }\n  | { action: 'IGNORE' }\n",
)

# HTTP seam for Task 6's manual resolution endpoint.
api_path = "webapp/src/api/templateInterrogation.ts"
replace_once(
    api_path,
    "  PendingFormalQuestion,\n  RoundReassociateInput,\n",
    "  PendingFormalQuestion,\n  QAUnitResolution,\n  RoundReassociateInput,\n",
)
insert_before(
    api_path,
    "\nexport async function ensureFormalRecord",
    '''
export async function resolveQaUnit(caseId: string, qaUnitId: string, resolution: QAUnitResolution): Promise<unknown> {
  return unwrap(await http.post<BackendEnvelope<unknown>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/qa-units/${encodeURIComponent(qaUnitId)}/resolve`,
    resolution,
  ))
}

''',
)

# Pinia mutation: reload workspace after any manual resolution so drag/drop is
# immediately reflected even though the manual endpoint itself does not need a WS push.
store_path = "webapp/src/stores/templateInterrogation.ts"
replace_once(
    store_path,
    "  reorderCaseQuestions as reorderCaseQuestionsApi,\n  saveQuestionToLibrary as saveQuestionToLibraryApi,\n",
    "  reorderCaseQuestions as reorderCaseQuestionsApi,\n  resolveQaUnit as resolveQaUnitApi,\n  saveQuestionToLibrary as saveQuestionToLibraryApi,\n",
)
replace_once(
    store_path,
    "  PendingResolution,\n  RoundReassociateInput,\n",
    "  PendingResolution,\n  QAUnitResolution,\n  RoundReassociateInput,\n",
)
replace_once(
    store_path,
    "  async function reassociateRound(roundId: string, input: RoundReassociateInput) {\n",
    "  async function resolveQaUnit(qaUnitId: string, resolution: QAUnitResolution) {\n    await runMutation((scope) => resolveQaUnitApi(scope.caseId, qaUnitId, resolution))\n  }\n\n  async function reassociateRound(roundId: string, input: RoundReassociateInput) {\n",
)
replace_once(
    store_path,
    "    resolvePendingQuestion,\n    reassociateRound,\n",
    "    resolvePendingQuestion,\n    resolveQaUnit,\n    reassociateRound,\n",
)

# Workspace -> page event bridge.
workspace_path = "webapp/src/views/InterrogationWorkspace.vue"
replace_once(
    workspace_path,
    "  PendingResolution,\n  RoundReassociateInput,\n",
    "  PendingResolution,\n  QAUnitResolution,\n  RoundReassociateInput,\n",
)
replace_once(
    workspace_path,
    "function resolvePendingQuestion(pendingId: string, resolution: PendingResolution) { return runTemplateAction(() => templateStore.resolvePendingQuestion(pendingId, resolution)) }\n",
    "function resolvePendingQuestion(pendingId: string, resolution: PendingResolution) { return runTemplateAction(() => templateStore.resolvePendingQuestion(pendingId, resolution)) }\nfunction resolveQaUnit(qaUnitId: string, resolution: QAUnitResolution) { return runTemplateAction(() => templateStore.resolveQaUnit(qaUnitId, resolution)) }\n",
)
replace_once(
    workspace_path,
    "            @resolve-pending=\"resolvePendingQuestion\"\n            @reassociate-round=\"reassociateFormalRound\"\n",
    "            @resolve-pending=\"resolvePendingQuestion\"\n            @resolve-qa-unit=\"resolveQaUnit\"\n            @reassociate-round=\"reassociateFormalRound\"\n",
)

# Page passes persisted QA units to the raw-dialogue review rail and routes both
# panels' resolution events to the workspace store.
page_path = "webapp/src/components/TemplateDrivenInterrogationPage.vue"
replace_once(
    page_path,
    "  PendingResolution,\n  RoundReassociateInput,\n",
    "  PendingResolution,\n  QAUnitResolution,\n  RoundReassociateInput,\n",
)
replace_once(
    page_path,
    "  resolvePending: [pendingId: string, resolution: PendingResolution]\n  reassociateRound: [roundId: string, input: RoundReassociateInput]\n",
    "  resolvePending: [pendingId: string, resolution: PendingResolution]\n  resolveQaUnit: [qaUnitId: string, resolution: QAUnitResolution]\n  reassociateRound: [roundId: string, input: RoundReassociateInput]\n",
)
replace_once(
    page_path,
    "          @insert-pending=\"(pendingId, afterQuestionId) => emit('resolvePending', pendingId, { action: 'ADD', afterQuestionId })\"\n          @update-answer=\"(id, text) => emit('updateAnswer', id, text)\"\n",
    "          @insert-pending=\"(pendingId, afterQuestionId) => emit('resolvePending', pendingId, { action: 'ADD', afterQuestionId })\"\n          @resolve-qa-unit=\"(qaUnitId, resolution) => emit('resolveQaUnit', qaUnitId, resolution)\"\n          @update-answer=\"(id, text) => emit('updateAnswer', id, text)\"\n",
)
replace_once(
    page_path,
    "        :pending-questions=\"workspace.pendingQuestions\"\n        :questions=\"workspace.questions\"\n",
    "        :pending-questions=\"workspace.pendingQuestions\"\n        :qa-units=\"workspace.qaUnits\"\n        :questions=\"workspace.questions\"\n",
)
replace_once(
    page_path,
    "        @resolve-pending=\"(id, resolution) => emit('resolvePending', id, resolution)\"\n        @correct-fragment=\"(id, speaker, reason) => emit('correctFragment', id, speaker, reason)\"\n",
    "        @resolve-pending=\"(id, resolution) => emit('resolvePending', id, resolution)\"\n        @resolve-qa-unit=\"(id, resolution) => emit('resolveQaUnit', id, resolution)\"\n        @correct-fragment=\"(id, speaker, reason) => emit('correctFragment', id, speaker, reason)\"\n",
)

# Right-side review rail. It is deliberately separate from dialogue turns so
# raw ASR text/order remain immutable evidence while review state can change.
live_path = "webapp/src/components/LiveDialoguePanel.vue"
replace_once(
    live_path,
    "  FormalQuestion,\n  PendingFormalQuestion,\n  PendingResolution,\n",
    "  FormalQAUnit,\n  FormalQuestion,\n  PendingFormalQuestion,\n  PendingResolution,\n  QAUnitResolution,\n",
)
replace_once(
    live_path,
    "  pendingQuestions: PendingFormalQuestion[]\n  questions: FormalQuestion[]\n",
    "  pendingQuestions: PendingFormalQuestion[]\n  qaUnits: FormalQAUnit[]\n  questions: FormalQuestion[]\n",
)
replace_once(
    live_path,
    "  resolvePending: [pendingId: string, resolution: PendingResolution]\n  correctFragment: [fragmentId: string, speaker: TemporaryAsrSpeaker, reason: string]\n",
    "  resolvePending: [pendingId: string, resolution: PendingResolution]\n  resolveQaUnit: [qaUnitId: string, resolution: QAUnitResolution]\n  correctFragment: [fragmentId: string, speaker: TemporaryAsrSpeaker, reason: string]\n",
)
replace_once(
    live_path,
    "const correctionReason = ref<Record<string, string>>({})\n\nconst elapsed = computed(() => {\n",
    "const correctionReason = ref<Record<string, string>>({})\nconst qaReviewUnits = computed(() => props.qaUnits.filter((unit) => unit.status === 'NEEDS_REVIEW'))\nconst qaResolvedUnits = computed(() => props.qaUnits.filter((unit) => unit.status === 'APPLIED' || unit.status === 'IGNORED'))\n\nconst elapsed = computed(() => {\n",
)
replace_once(
    live_path,
    "function correctionRole(item: TemporaryAsrFragment): TemporaryAsrSpeaker {\n",
    '''function startQaDrag(event: DragEvent, payload: { qaUnitId: string; mode: 'QA' | 'ANSWER' }) {
  if (!event.dataTransfer) return
  event.dataTransfer.effectAllowed = 'copy'
  event.dataTransfer.setData('application/x-formal-qa-unit', JSON.stringify(payload))
}

function startWholeQaDrag(event: DragEvent, unit: FormalQAUnit) {
  startQaDrag(event, { qaUnitId: unit.id, mode: 'QA' })
}

function startAnswerDrag(event: DragEvent, unit: FormalQAUnit) {
  startQaDrag(event, { qaUnitId: unit.id, mode: 'ANSWER' })
}

function resolveQa(unit: FormalQAUnit, resolution: QAUnitResolution) {
  emit('resolveQaUnit', unit.id, resolution)
}

function qaStatusLabel(unit: FormalQAUnit) {
  if (unit.status === 'IGNORED' || unit.classification === 'IGNORE') return '已忽略·仅原始对话'
  if (unit.status === 'NEEDS_REVIEW') return '待处理'
  if (unit.classification === 'MATCH_FIXED') return '已归档·固定模板'
  if (unit.classification === 'MATCH_EXISTING') return '已归档·已有问题'
  if (unit.classification === 'CREATE_LIVE_FROM_SPEECH') return '已新增·现场问题'
  return unit.status
}

function correctionRole(item: TemporaryAsrFragment): TemporaryAsrSpeaker {
''',
)
replace_once(
    live_path,
    "    <div ref=\"feed\" class=\"dialogue-feed\" @scroll=\"onFeedScroll\">\n",
    '''    <div ref="feed" class="dialogue-feed" @scroll="onFeedScroll">
      <section v-if="qaReviewUnits.length || qaResolvedUnits.length" class="qa-review-rail" aria-label="Qwen 正式笔录路由状态">
        <article v-for="unit in qaReviewUnits" :key="unit.id" class="qa-review-card">
          <header><span class="qa-status-chip">待处理</span><small>{{ unit.reasonCode || 'NEEDS_REVIEW' }}</small></header>
          <p v-if="unit.rawQuestionText"><b>原始问：</b>{{ unit.rawQuestionText }}</p>
          <p v-if="unit.rawAnswerText"><b>原始答：</b>{{ unit.rawAnswerText }}</p>
          <p v-if="unit.formalQuestionText" class="qa-suggestion"><b>建议问：</b>{{ unit.formalQuestionText }}</p>
          <p v-if="unit.formalAnswerText" class="qa-suggestion"><b>建议答：</b>{{ unit.formalAnswerText }}</p>
          <div class="qa-review-actions">
            <button draggable="true" @dragstart="startWholeQaDrag($event, unit)">拖动整组问答</button>
            <button v-if="unit.answerFragmentIds.length" draggable="true" @dragstart="startAnswerDrag($event, unit)">仅拖动答案</button>
            <button class="qa-ignore" @click="resolveQa(unit, { action: 'IGNORE' })">忽略</button>
          </div>
        </article>
        <div v-for="unit in qaResolvedUnits" :key="`status-${unit.id}`" class="qa-routing-status" :class="{ 'qa-status-muted': unit.status === 'IGNORED' || unit.classification === 'IGNORE' }">
          <span>{{ qaStatusLabel(unit) }}</span>
          <small v-if="unit.rawQuestionText">{{ unit.rawQuestionText }}</small>
        </div>
      </section>
''',
)
insert_before(
    live_path,
    "</style>",
    '''.qa-review-rail { display: grid; gap: 8px; margin-bottom: 10px; }
.qa-review-card { border: 1px solid #d5a73f; background: #fff9e8; border-radius: 10px; padding: 10px; }
.qa-review-card header { display: flex; justify-content: space-between; gap: 8px; align-items: center; }
.qa-review-card p { margin: 6px 0; line-height: 1.45; }
.qa-status-chip { display: inline-flex; padding: 2px 8px; border-radius: 999px; background: #f3c760; color: #5b4308; font-weight: 800; }
.qa-suggestion { color: #536274; }
.qa-review-actions { display: flex; gap: 6px; flex-wrap: wrap; margin-top: 8px; }
.qa-review-actions button { cursor: grab; }
.qa-review-actions .qa-ignore { cursor: pointer; }
.qa-routing-status { display: flex; gap: 8px; align-items: center; padding: 6px 8px; border-radius: 8px; background: #edf6ef; color: #2d6040; font-size: 12px; }
.qa-routing-status small { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.qa-status-muted { background: #f2f3f5; color: #7a8088; opacity: .78; }
''',
)

# Left-side drop semantics. Existing pending-question MIME remains fully supported.
formal_path = "webapp/src/components/FormalTemplatePanel.vue"
replace_once(
    formal_path,
    "import type { CaseQuestionUpdateInput, FormalQuestion, FormalQuestionRound } from '../types/templateInterrogation'\n",
    "import type { CaseQuestionUpdateInput, FormalQuestion, FormalQuestionRound, QAUnitResolution } from '../types/templateInterrogation'\n",
)
replace_once(
    formal_path,
    "  insertPending: [pendingId: string, afterQuestionId: string | null]\n  generateAi: []\n",
    "  insertPending: [pendingId: string, afterQuestionId: string | null]\n  resolveQaUnit: [qaUnitId: string, resolution: QAUnitResolution]\n  generateAi: []\n",
)
replace_once(
    formal_path,
    "function allowPendingDrop(event: DragEvent, key: string) {\n  if (!props.documentFrozen && event.dataTransfer?.types.includes('application/x-formal-pending-question')) {\n    event.preventDefault(); event.dataTransfer.dropEffect = 'copy'; dragOverKey.value = key\n  }\n}\n",
    '''const QA_MIME = 'application/x-formal-qa-unit'
type QaDragPayload = { qaUnitId: string; mode: 'QA' | 'ANSWER' }

function qaDragPayload(event: DragEvent): QaDragPayload | null {
  const raw = event.dataTransfer?.getData(QA_MIME)
  if (!raw) return null
  try {
    const payload = JSON.parse(raw) as Partial<QaDragPayload>
    if (!payload.qaUnitId || (payload.mode !== 'QA' && payload.mode !== 'ANSWER')) return null
    return payload as QaDragPayload
  } catch { return null }
}

function allowPendingDrop(event: DragEvent, key: string) {
  const types = event.dataTransfer?.types ?? []
  if (!props.documentFrozen && (types.includes('application/x-formal-pending-question') || types.includes(QA_MIME))) {
    event.preventDefault(); if (event.dataTransfer) event.dataTransfer.dropEffect = 'copy'; dragOverKey.value = key
  }
}

function dropQaCreateLive(event: DragEvent) {
  event.preventDefault(); dragOverKey.value = ''
  if (props.documentFrozen) return
  const payload = qaDragPayload(event)
  if (payload?.mode === 'QA') emit('resolveQaUnit', payload.qaUnitId, { action: 'CREATE_LIVE' })
}

function dropQaOnQuestion(event: DragEvent, questionId: string) {
  event.preventDefault(); dragOverKey.value = ''
  if (props.documentFrozen) return
  const payload = qaDragPayload(event)
  if (payload?.mode === 'QA') emit('resolveQaUnit', payload.qaUnitId, { action: 'LINK_QA', caseQuestionId: questionId })
}

function dropAnswerOnQuestion(event: DragEvent, questionId: string) {
  event.preventDefault(); dragOverKey.value = ''
  if (props.documentFrozen) return
  const payload = qaDragPayload(event)
  if (payload?.mode === 'ANSWER') emit('resolveQaUnit', payload.qaUnitId, { action: 'LINK_ANSWER', caseQuestionId: questionId })
}

function dropGap(event: DragEvent, afterQuestionId: string | null) {
  if (event.dataTransfer?.types.includes(QA_MIME)) { dropQaCreateLive(event); return }
  dropPending(event, afterQuestionId)
}
''',
)
replace_once(
    formal_path,
    "@dragleave=\"dragOverKey = ''\" @drop=\"dropPending($event, lastOpeningId)\">拖到这里插入为第一条案件问题</div>\n",
    "@dragleave=\"dragOverKey = ''\" @drop=\"dropGap($event, lastOpeningId)\">拖到这里插入为第一条案件问题 / 整组问答</div>\n",
)
replace_once(
    formal_path,
    "          <label class=\"record-question editable-question\"><b>问：</b><textarea v-model=\"questionDrafts[q.id]\" :disabled=\"busy || documentFrozen\" rows=\"1\" @blur=\"saveQuestion(q)\"></textarea></label>\n          <label class=\"record-answer\"><b>答：</b><textarea v-model=\"canonicalAnswerDrafts[q.id]\" :disabled=\"busy || documentFrozen\" rows=\"2\" placeholder=\"等待现场回答\" @blur=\"saveCanonicalAnswer(q)\"></textarea></label>\n",
    '''          <label class="record-question editable-question qa-question-drop" @dragover="allowPendingDrop($event, `qa-${q.id}`)" @drop.stop="dropQaOnQuestion($event, q.id)"><b>问：</b><textarea v-model="questionDrafts[q.id]" :disabled="busy || documentFrozen" rows="1" @blur="saveQuestion(q)"></textarea><small class="record-no-print">整组 QA 可拖到本题</small></label>
          <label class="record-answer qa-answer-drop" @dragover="allowPendingDrop($event, `answer-${q.id}`)" @drop.stop="dropAnswerOnQuestion($event, q.id)"><b>答：</b><textarea v-model="canonicalAnswerDrafts[q.id]" :disabled="busy || documentFrozen" rows="2" placeholder="等待现场回答" @blur="saveCanonicalAnswer(q)"></textarea><small class="record-no-print">仅答案可拖到这里</small></label>
''',
)
replace_once(
    formal_path,
    "@dragleave=\"dragOverKey = ''\" @drop=\"dropPending($event, q.id)\">拖到这里，插入在本题之后</div>\n",
    "@dragleave=\"dragOverKey = ''\" @drop=\"dropGap($event, q.id)\">拖到这里，插入在本题之后 / 新建现场问题</div>\n",
)
insert_before(
    formal_path,
    "</template>\n",
    '''<style scoped>
.qa-question-drop, .qa-answer-drop { position: relative; border-radius: 6px; }
.qa-question-drop:has(textarea:focus), .qa-answer-drop:has(textarea:focus) { outline: none; }
.qa-question-drop > small, .qa-answer-drop > small { margin-left: 8px; color: #84909d; font-size: 10px; }
</style>
''',
)
