# Qwen Formal Record Routing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the current near-exact regex/alias speech-to-formal-record projection with a safe Qwen3-4B-assisted QA routing pipeline: A/B/C auto-route into the formal record, D becomes highlighted human review with drag/drop resolution, E stays raw-only, and same-semantic follow-up rounds merge into one formal answer while preserving immutable ASR provenance.

**Architecture:** Keep FunASR/XVector as the source of immutable speech facts. Persist explicit `QAUnit` provenance between ASR fragments and the formal record. A deterministic `QAUnitBuilder` groups officer question fragments and suspect answer fragments; a background `QARoutingCoordinator` sends closed units to a strict-JSON `FormalRecordRouter` backed by the existing `AISupervisor`; a deterministic `FormalRecordRoutingService` validates and applies only allowed A/B/C/D/E decisions. Qwen never writes the database. The existing regex `InterrogationProjectionService` remains available behind a rollout fallback but stops being the primary production path once the RK3588 acceptance gate passes.

**Tech Stack:** FastAPI, SQLAlchemy 2.x, Alembic, SQLite, pytest, existing `AISupervisor` multiprocessing worker, local LlamaPi OpenAI-compatible API for Qwen3-4B, Vue 3, Pinia, TypeScript, Axios, Vitest, Vite, WebSocket runtime events, RK3588 self-hosted GitHub Actions.

**Spec:** `docs/superpowers/specs/2026-09-01-qwen-formal-record-routing-design.md`

## Global Constraints

- Target branch: `linux-adaptation`. Re-read branch HEAD before every write batch; never overwrite unrelated newer work.
- Right-side ASR dialogue is immutable provenance. AI routing may only create/update the formal projection and routing metadata.
- C-class questions must come from actual officer speech fragments. The model may lightly formalize wording but may not invent a question or any unspoken fact.
- Qwen may remove fillers, repetition, obvious oral redundancy, and improve word order; it may not invent exact times, people, places, quantities, motives, causality, certainty, or resolve contradictions.
- Contradictory or materially ambiguous content must become D (`NEEDS_REVIEW`), not an auto-merged A/B/C result.
- A keeps the fixed template question text. B keeps the existing CASE/LIVE question text. Only C creates a new LIVE question from real officer speech.
- Same-semantic follow-ups produce additional provenance rounds but one canonical merged formal answer on the left.
- BODY business order follows first actual officer-question occurrence. Protected OPENING/CLOSING sections keep their legal/template boundaries.
- No LLM call may execute inside the audio capture thread. Raw fragment persistence must remain fast even if Qwen is slow or unavailable.
- Model timeout, malformed JSON, unavailable LlamaPi, invalid target IDs, or failed policy validation must degrade to D without dropping raw evidence.
- Never persist or display hidden chain-of-thought. Store only the classification, target/candidates, confidence, model ID, compact machine `reasonCode`, and cleaned text.
- Production LLM traffic must stay on loopback. Do not bind vendor `librkllmrt.so` into this application; use LlamaPi's local OpenAI-compatible HTTP service.
- Keep a temporary `SUSPECT_FORMAL_ROUTING_MODE=legacy|qwen` rollout switch. Code default stays `legacy` until Task 11 real-device acceptance; production env switches to `qwen` only after acceptance.
- Existing identity, voiceprint, session lifecycle, freeze/sign/report, browser/ALSA audio, backup/restore, and release flows must remain green.

---

### Task 1: Persist QA units and canonical merged formal answers

**Files:**
- Modify: `linux/backend/app/database/models.py`
- Create: `linux/backend/alembic/versions/0008_qwen_formal_record_routing.py`
- Create: `linux/backend/app/repositories/qa_units.py`
- Modify: `linux/backend/app/repositories/template_questions.py`
- Modify: `linux/backend/app/services/serializers.py`
- Create: `linux/backend/tests/test_qwen_routing_schema.py`

**Interfaces:**

```python
class QAUnit(...):
    id: str
    case_id: str
    session_id: str | None
    status: str  # OPEN|CLOSED|ROUTING|ROUTED|NEEDS_REVIEW|IGNORED
    raw_question_text: str
    raw_answer_text: str
    classification: str | None
    target_question_id: str | None
    formal_question_text: str | None
    formal_answer_text: str | None
    confidence: float | None
    model_id: str | None
    reason_code: str | None
    started_at: datetime
    ended_at: datetime | None

class QAUnitFragment(...):
    qa_unit_id: str
    fragment_id: str
    role: str  # QUESTION|ANSWER
    position: int
```

Add to `CaseQuestion`:

```python
formal_answer_text: Mapped[str] = mapped_column(Text, default="", nullable=False)
first_asked_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True, index=True)
```

- [ ] **Step 1: Write failing schema tests**

Create `test_qwen_routing_schema.py` with assertions that `QAUnit.__tablename__ == "qa_units"`, `QAUnitFragment.__tablename__ == "qa_unit_fragments"`, `CaseQuestion` exposes `formal_answer_text`/`first_asked_at`, and `qa_unit_fragments.fragment_id` is unique so one ASR fragment cannot be routed twice.

- [ ] **Step 2: Run the test and verify failure**

Run:

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qwen_routing_schema.py -q
```

Expected: model/table attributes are missing.

- [ ] **Step 3: Add migration `0008_qwen_formal_record_routing`**

Set:

```python
revision = "0008_qwen_formal_record_routing"
down_revision = "0007_formal_record_sections"
```

Create `qa_units`, `qa_unit_fragments`; add the two `case_questions` columns. Use FK cascade for case/unit fragment ownership and `SET NULL` for `target_question_id` so historical routing evidence survives question deactivation/removal semantics.

- [ ] **Step 4: Add repository primitives**

Implement exact operations:

```python
def create_open(db, *, case_id: str, session_id: str | None, started_at: datetime) -> QAUnit: ...
def get(db, qa_unit_id: str) -> QAUnit: ...
def active_for_session(db, case_id: str, session_id: str) -> QAUnit | None: ...
def append_fragment(db, row: QAUnit, *, fragment_id: str, role: str, position: int) -> QAUnitFragment: ...
def close(db, row: QAUnit, *, raw_question_text: str, raw_answer_text: str, ended_at: datetime) -> QAUnit: ...
def list_for_case(db, case_id: str) -> list[QAUnit]: ...
def list_recent_closed(db, case_id: str, *, limit: int = 2) -> list[QAUnit]: ...
def mark_routing(db, row: QAUnit) -> None: ...
def save_decision(db, row: QAUnit, *, classification: str, target_question_id: str | None, formal_question_text: str | None, formal_answer_text: str | None, confidence: float | None, model_id: str | None, reason_code: str | None, status: str) -> None: ...
```

- [ ] **Step 5: Serialize canonical answer and QA units**

`case_question_dict()` must emit `formalAnswerText` and `firstAskedAt`. Add `qa_unit_dict()` with raw/formal text, fragment IDs split into `questionFragmentIds` and `answerFragmentIds`, classification/status, candidates if stored, confidence/model/reason.

- [ ] **Step 6: Run focused + migration/backend tests**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qwen_routing_schema.py linux/backend/tests/test_template_workspace_service.py -q
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add linux/backend/app/database/models.py linux/backend/alembic/versions/0008_qwen_formal_record_routing.py linux/backend/app/repositories/qa_units.py linux/backend/app/repositories/template_questions.py linux/backend/app/services/serializers.py linux/backend/tests/test_qwen_routing_schema.py
git commit -m "feat: persist qwen formal routing units"
```

---

### Task 2: Build deterministic QA units from speaker-attributed ASR fragments

**Files:**
- Create: `linux/backend/app/services/qa_unit_builder.py`
- Modify: `linux/backend/app/repositories/asr_fragments.py`
- Create: `linux/backend/tests/test_qa_unit_builder.py`

**Interfaces:**

```python
OFFICER_SPEAKERS = {"INTERROGATOR", "RECORDER", "OFFICER_FALLBACK"}

class QAUnitBuilder:
    def consume_fragment(self, case_id: str, fragment_id: str) -> list[str]: ...
    def close_idle(self, *, now: datetime) -> list[str]: ...
    def flush_session(self, case_id: str, session_id: str) -> list[str]: ...
```

Rules:
- first officer fragment opens a unit;
- consecutive officer fragments before suspect speech join the question side;
- suspect fragments append to the answer side;
- a new officer fragment after at least one suspect answer closes the prior unit and opens the next;
- a unit with suspect answer closes after configurable 4 seconds of no new final fragment;
- capture stop flushes the unit;
- `UNKNOWN` never gets guessed into officer/suspect and stays raw-only;
- orphan suspect speech with no active question becomes a closed D-candidate unit with `reason_code="ORPHAN_ANSWER"` so it can be highlighted and dragged rather than silently lost;
- do not use `is_question_utterance()` as the grouping gate: natural officer prompts such as `说一下昨晚的经过` must reach Qwen.

- [ ] **Step 1: Write failing grouping tests**

Cover:

```python
def test_officer_then_two_suspect_fragments_forms_one_unit(...): ...
def test_next_officer_question_closes_previous_unit(...): ...
def test_consecutive_officer_fragments_before_answer_stay_one_question(...): ...
def test_unknown_fragment_is_not_assigned_to_a_unit(...): ...
def test_orphan_suspect_answer_becomes_review_unit(...): ...
def test_idle_close_after_four_seconds(...): ...
```

- [ ] **Step 2: Run and verify failure**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qa_unit_builder.py -q
```

Expected: import failure.

- [ ] **Step 3: Implement builder with DB idempotency**

Use the unique `qa_unit_fragments.fragment_id` constraint as the final duplicate guard. Build raw texts by reading `edited_text or raw_text`, preserving fragment order.

- [ ] **Step 4: Add recovery query for persisted-but-unassigned fragments**

Add:

```python
def list_unassigned_for_session(db, case_id: str, session_id: str, *, limit: int = 256) -> list[ASRFragment]: ...
```

This lets the later coordinator recover if its in-memory notification queue is saturated or the process restarts.

- [ ] **Step 5: Run tests**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qa_unit_builder.py linux/backend/tests/test_asr_capture_service.py -q
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add linux/backend/app/services/qa_unit_builder.py linux/backend/app/repositories/asr_fragments.py linux/backend/tests/test_qa_unit_builder.py
git commit -m "feat: build qa units from live speech"
```

---

### Task 3: Define the strict Qwen A/B/C/D/E routing contract and prompt

**Files:**
- Create: `linux/backend/app/ai/prompt/formal_record_routing.py`
- Create: `linux/backend/app/services/formal_record_router.py`
- Create: `linux/backend/tests/test_formal_record_router.py`

**Interfaces:**

```python
class RouteClass(str, Enum):
    MATCH_FIXED = "MATCH_FIXED"
    MATCH_EXISTING = "MATCH_EXISTING"
    CREATE_LIVE_FROM_SPEECH = "CREATE_LIVE_FROM_SPEECH"
    NEEDS_REVIEW = "NEEDS_REVIEW"
    IGNORE = "IGNORE"

@dataclass(frozen=True)
class FormalRecordRouteDecision:
    classification: RouteClass
    target_question_id: str | None
    formal_question: str | None
    formal_answer: str | None
    confidence: float | None
    candidate_question_ids: tuple[str, ...]
    reason_code: str
    model_id: str | None
```

Router API:

```python
class FormalRecordRouter:
    def route(self, qa_unit_id: str) -> FormalRecordRouteDecision: ...
```

Strict model response shape:

```json
{
  "classification": "MATCH_FIXED",
  "target_question_id": "question-id-or-null",
  "formal_question": null,
  "formal_answer": "整理后的完整合并答案",
  "confidence": 0.94,
  "candidate_question_ids": [],
  "reason_code": "SEMANTIC_MATCH"
}
```

No free-form explanation and no reasoning trace.

- [ ] **Step 1: Add failing parser/validation tests**

Cover direct JSON, one fenced JSON block, prose-wrapped invalid output, unknown classification, confidence outside `[0,1]`, A pointing to LIVE, B pointing to fixed, C with no real question fragments, C with empty formal question, and model exception -> D.

- [ ] **Step 2: Run and verify failure**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_formal_record_router.py -q
```

- [ ] **Step 3: Implement prompt builder**

The prompt must include:
- raw officer question;
- raw suspect answer;
- current unit fragment IDs/times;
- previous 1-2 QA units;
- every current formal question as `{id,text,source,section,formalAnswerText}`;
- current/most recent target question;
- explicit A/B/C/D/E definitions;
- fact-preservation prohibitions;
- instruction that `formal_answer` is the complete canonical merged answer after considering the existing formal answer for A/B;
- instruction that C's `formal_question` must be a faithful rewrite of actual officer speech;
- instruction that contradiction/uncertainty becomes D;
- JSON-only response.

Call the supervisor with:

```python
result = ai_supervisor.generate(
    prompt,
    session_id=f"formal-route:{qa_unit.id}",
    options={
        "temperature": 0.1,
        "top_p": 0.8,
        "max_tokens": 512,
        "enable_thinking": False,
    },
)
```

- [ ] **Step 4: Add deterministic post-model policy validation**

A is valid only if target is a fixed/locked template question. B is valid only if target belongs to this case and is non-fixed CASE/LIVE. C requires at least one officer fragment and non-empty real raw question. Invalid model output becomes:

```python
FormalRecordRouteDecision(
    classification=RouteClass.NEEDS_REVIEW,
    target_question_id=None,
    formal_question=None,
    formal_answer=None,
    confidence=None,
    candidate_question_ids=(),
    reason_code="INVALID_MODEL_OUTPUT",
    model_id=result.model_id,
)
```

- [ ] **Step 5: Run tests**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_formal_record_router.py -q
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add linux/backend/app/ai/prompt/formal_record_routing.py linux/backend/app/services/formal_record_router.py linux/backend/tests/test_formal_record_router.py
git commit -m "feat: define qwen formal routing contract"
```

---

### Task 4: Apply A/B/C/D/E decisions through a deterministic routing service

**Files:**
- Create: `linux/backend/app/services/formal_record_routing_service.py`
- Modify: `linux/backend/app/repositories/question_rounds.py`
- Modify: `linux/backend/app/services/formal_record_answer_service.py`
- Modify: `linux/backend/app/services/template_workspace_service.py`
- Modify: `linux/backend/app/repositories/audit.py`
- Create: `linux/backend/tests/test_formal_record_routing_service.py`

**Interfaces:**

```python
class FormalRecordRoutingService:
    def apply_auto(self, qa_unit_id: str, decision: FormalRecordRouteDecision) -> dict: ...
    def resolve_manual(self, qa_unit_id: str, *, action: str, case_question_id: str | None, formal_question: str | None, formal_answer: str | None) -> dict: ...
```

- [ ] **Step 1: Write failing A/B/C/D/E behavior tests**

Required scenarios:
1. A maps natural speech `今天为什么过来的？` to fixed `你因何事来公安机关？`; fixed question text remains unchanged; canonical answer is updated.
2. B maps to an existing BODY CASE question.
3. Follow-up B creates a second `QuestionRound` but updates one `CaseQuestion.formal_answer_text` rather than rendering a duplicate question.
4. C creates `source=LIVE` using the model's faithful cleaned real question and answer.
5. C is rejected to D if the QA unit has no officer question fragment.
6. D makes no `CaseQuestion` or `QuestionRound` mutation.
7. E makes no formal mutation and marks the unit ignored.
8. A/B/C on a frozen record raises the existing formal-record immutable domain error.
9. A/B first actual BODY ask sets `first_asked_at`; later follow-up never changes it.
10. BODY order follows `first_asked_at`, while OPENING/CLOSING remain protected.

- [ ] **Step 2: Run and verify failure**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_formal_record_routing_service.py -q
```

- [ ] **Step 3: Extend round creation with provenance timestamps**

Change repository signature to:

```python
def create_round(..., started_at: datetime | None = None, ended_at: datetime | None = None) -> QuestionRound:
```

Use QA unit timing, not the later AI processing time.

- [ ] **Step 4: Make `CaseQuestion.formal_answer_text` the canonical left-side answer**

`FormalRecordAnswerService.upsert()` must edit canonical `formal_answer_text`. If no provenance round exists, preserve current behavior by creating one manual round, but do not fabricate fragment IDs.

- [ ] **Step 5: Implement auto application rules**

A/B:
- validate target;
- create one new provenance round with raw actual question + answer fragment IDs;
- set `question.formal_answer_text = decision.formal_answer`;
- set first asked timestamp if absent;
- do not change existing question text.

C:
- create LIVE question from `decision.formal_question`;
- create provenance round referencing the real officer/suspect fragments;
- set canonical answer;
- set `first_asked_at = qa_unit.started_at`.

D:
- save decision/status `NEEDS_REVIEW` only.

E:
- save decision/status `IGNORED` only.

- [ ] **Step 6: Reorder only BODY by actual ask time**

Add `TemplateWorkspaceService.apply_actual_body_order(case_id)`:
- answered/asked BODY items first sorted by `first_asked_at`;
- unasked prepared BODY items follow in their existing relative `sort_order`;
- fixed OPENING before BODY, CLOSING after BODY.

- [ ] **Step 7: Audit without chain-of-thought**

Emit:
- `QA_ROUTE_AUTO_APPLIED`
- `QA_ROUTE_REVIEW_REQUIRED`
- `QA_ROUTE_IGNORED`
- `QA_ROUTE_MANUAL_APPLIED`

Audit detail may include `qa_unit_id`, classification, target ID, confidence, model ID, reason code, fragment IDs; never raw model reasoning.

- [ ] **Step 8: Run tests**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_formal_record_routing_service.py linux/backend/tests/test_template_workspace_service.py linux/backend/tests/test_template_workspace_api.py -q
```

Expected: PASS after updating old expectations to canonical formal answers without removing legacy endpoints.

- [ ] **Step 9: Commit**

```bash
git add linux/backend/app/services/formal_record_routing_service.py linux/backend/app/repositories/question_rounds.py linux/backend/app/services/formal_record_answer_service.py linux/backend/app/services/template_workspace_service.py linux/backend/app/repositories/audit.py linux/backend/tests/test_formal_record_routing_service.py linux/backend/tests/test_template_workspace_service.py linux/backend/tests/test_template_workspace_api.py
git commit -m "feat: apply qwen formal routing decisions"
```

---

### Task 5: Run routing asynchronously and integrate with the live ASR pipeline

**Files:**
- Create: `linux/backend/app/services/qa_routing_coordinator.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `linux/backend/app/services/source_aware_asr_capture_service.py`
- Modify: `linux/backend/app/main.py`
- Modify: `linux/backend/app/runtime_settings.py`
- Create: `linux/backend/tests/test_qa_routing_coordinator.py`
- Modify: `linux/backend/tests/test_asr_capture_service.py`
- Modify: `linux/backend/tests/test_asr_main_wiring.py`

**Interfaces:**

```python
class QARoutingCoordinator:
    def start(self) -> None: ...
    def enqueue_fragment(self, case_id: str, fragment_id: str) -> None: ...
    def flush_capture(self, case_id: str, session_id: str) -> None: ...
    def shutdown(self) -> None: ...
```

Runtime setting:

```python
formal_routing_mode: str = "legacy"  # legacy|qwen
qa_idle_close_seconds: float = 4.0
```

- [ ] **Step 1: Write failing non-blocking coordinator tests**

Prove:
- `AsrCaptureService._persist_fragment()` returns after DB/event work without waiting for an injected slow router;
- coordinator eventually builds/routes the unit;
- model timeout becomes D;
- restart recovery scans persisted unassigned fragments;
- capture stop flushes the last QA unit;
- qwen mode never invokes `InterrogationProjectionService.process_fragment()`.

- [ ] **Step 2: Run and verify failure**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qa_routing_coordinator.py linux/backend/tests/test_asr_capture_service.py -q
```

- [ ] **Step 3: Replace direct projection call with a fragment sink seam**

`AsrCaptureService.__init__()` gains:

```python
fragment_sink: Callable[[str, str], None] | None = None
capture_finished_sink: Callable[[str, str], None] | None = None
```

After fragment commit:
1. publish `ASR_FRAGMENT` immediately for right-side raw dialogue;
2. if qwen sink configured, enqueue only the IDs;
3. otherwise execute current legacy projection for compatibility.

Do not call Qwen in this method.

- [ ] **Step 4: Implement worker-loop coordinator**

Use `queue.Queue(maxsize=256)`. On `Full`, do not block capture; log/audit a recovery-needed marker. Every worker loop iteration and startup runs `list_unassigned_for_session()` recovery so dropped notifications are recoverable from persisted fragments.

Poll every 250 ms to run `builder.close_idle(now=...)`.

For each closed unit:
- mark `ROUTING`;
- call `FormalRecordRouter.route()`;
- call `FormalRecordRoutingService.apply_auto()`;
- commit;
- publish `QA_UNIT_UPDATED` and, for A/B/C/manual later, `FORMAL_RECORD_UPDATED` only after commit.

- [ ] **Step 5: Wire lifecycle in `main.py`**

When `formal_routing_mode == "qwen"`, construct/start coordinator during lifespan before accepting capture. Pass sinks into both ALSA and browser-backed `AsrCaptureService` instances through `SourceAwareAsrCaptureService`. Shut coordinator down after captures stop.

- [ ] **Step 6: Run tests**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qa_routing_coordinator.py linux/backend/tests/test_asr_capture_service.py linux/backend/tests/test_asr_main_wiring.py -q
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
```

- [ ] **Step 7: Commit**

```bash
git add linux/backend/app/services/qa_routing_coordinator.py linux/backend/app/services/asr_capture_service.py linux/backend/app/services/source_aware_asr_capture_service.py linux/backend/app/main.py linux/backend/app/runtime_settings.py linux/backend/tests/test_qa_routing_coordinator.py linux/backend/tests/test_asr_capture_service.py linux/backend/tests/test_asr_main_wiring.py
git commit -m "feat: route live qa units asynchronously"
```

---

### Task 6: Add D-class manual resolution API for whole-QA and answer-only drag/drop

**Files:**
- Modify: `linux/backend/app/api/schemas.py`
- Modify: `linux/backend/app/api/template_workspace.py`
- Modify: `linux/backend/app/services/template_workspace_service.py`
- Modify: `linux/backend/app/services/formal_record_routing_service.py`
- Modify: `linux/backend/app/services/serializers.py`
- Modify: `linux/backend/tests/test_template_workspace_api.py`
- Create: `linux/backend/tests/test_qa_unit_manual_resolution.py`

**Request contract:**

```python
class QAUnitResolutionRequest(FlexibleModel):
    action: Literal["CREATE_LIVE", "LINK_QA", "LINK_ANSWER", "IGNORE"]
    case_question_id: str | None = Field(default=None, alias="caseQuestionId")
    formal_question: str | None = Field(default=None, alias="formalQuestion")
    formal_answer: str | None = Field(default=None, alias="formalAnswer")
```

Endpoint:

```text
POST /api/v1/cases/{case_id}/qa-units/{qa_unit_id}/resolve
```

- [ ] **Step 1: Write failing API tests**

Cover:
- `CREATE_LIVE` creates from the QA unit's real question and answer, not from arbitrary unrelated model text;
- `LINK_QA` creates a provenance round under an existing question and updates canonical answer;
- `LINK_ANSWER` associates only the answer while retaining the raw QA unit untouched;
- `IGNORE` resolves D without formal mutation;
- resolved/ignored unit cannot be resolved twice;
- unit from another case is 404;
- fixed/frozen policy remains enforced;
- manual resolution preserves original `qa_unit.started_at` ordering.

- [ ] **Step 2: Run and verify failure**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qa_unit_manual_resolution.py -q
```

- [ ] **Step 3: Implement endpoint and service**

Allowed default text selection:
- `formalQuestion`: request value, else stored D suggestion, else raw officer question;
- `formalAnswer`: request value, else stored D suggestion, else raw suspect answer.

Still validate C-like fact provenance: `CREATE_LIVE` requires actual officer question fragment(s). `LINK_ANSWER` requires suspect answer fragment(s).

- [ ] **Step 4: Include QA units in workspace**

`TemplateWorkspaceService.workspace()` returns:

```python
{
    "caseId": case_id,
    "questions": ...,
    "rounds": ...,
    "pendingQuestions": ...,  # legacy compatibility
    "qaUnits": [qa_unit_dict(row) for row in qa_repo.list_for_case(...)],
}
```

- [ ] **Step 5: Run tests and commit**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qa_unit_manual_resolution.py linux/backend/tests/test_template_workspace_api.py -q
git add linux/backend/app/api/schemas.py linux/backend/app/api/template_workspace.py linux/backend/app/services/template_workspace_service.py linux/backend/app/services/formal_record_routing_service.py linux/backend/app/services/serializers.py linux/backend/tests/test_template_workspace_api.py linux/backend/tests/test_qa_unit_manual_resolution.py
git commit -m "feat: resolve uncertain qa units manually"
```

---

### Task 7: Make the frontend consume canonical answers and committed routing events

**Files:**
- Modify: `webapp/src/types/templateInterrogation.ts`
- Modify: `webapp/src/api/templateInterrogation.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/stores/templateInterrogation.ts`
- Modify: `webapp/src/components/FormalTemplatePanel.vue`
- Modify: `webapp/src/components/FormalRecordEditor.contract.test.ts`

**Types:**

```ts
export type QARouteClass = 'MATCH_FIXED' | 'MATCH_EXISTING' | 'CREATE_LIVE_FROM_SPEECH' | 'NEEDS_REVIEW' | 'IGNORE'

export interface FormalQAUnit {
  id: string
  caseId: string
  status: 'OPEN' | 'CLOSED' | 'ROUTING' | 'ROUTED' | 'NEEDS_REVIEW' | 'IGNORED'
  classification: QARouteClass | null
  rawQuestionText: string
  rawAnswerText: string
  formalQuestionText: string | null
  formalAnswerText: string | null
  targetQuestionId: string | null
  questionFragmentIds: string[]
  answerFragmentIds: string[]
  confidence: number | null
  reasonCode: string | null
}
```

`FormalQuestion` gains `formalAnswerText` and `firstAskedAt`; `TemplateWorkspace` gains `qaUnits`.

- [ ] **Step 1: Update contract test first**

Add expectations that formal answer rendering uses `question.formalAnswerText` rather than `latestRound(question.id)?.answerText`, while provenance rounds remain available in details/history.

- [ ] **Step 2: Run frontend test and verify failure**

```bash
cd webapp && npm test -- FormalRecordEditor.contract.test.ts
```

- [ ] **Step 3: Add committed-event revision bridge**

In `interrogation.ts`:

```ts
const formalRecordRevision = ref(0)
```

On WebSocket `QA_UNIT_UPDATED` or `FORMAL_RECORD_UPDATED`, increment it. Keep `ASR_FRAGMENT` only for raw dialogue.

In `templateInterrogation.ts`, watch `formalRecordRevision` and refresh workspace. Stop relying on the 90 ms raw-fragment timer as the correctness mechanism; it may remain only as a compatibility fallback in legacy mode.

- [ ] **Step 4: Render canonical merged answer**

`FormalTemplatePanel.vue` should bind answer textarea/display to `question.formalAnswerText`. Existing manual save still calls `PUT /questions/{id}/answer`.

- [ ] **Step 5: Run tests/typecheck**

```bash
cd webapp
npm test -- FormalRecordEditor.contract.test.ts
npm run typecheck
npm run build
```

- [ ] **Step 6: Commit**

```bash
git add webapp/src/types/templateInterrogation.ts webapp/src/api/templateInterrogation.ts webapp/src/stores/interrogation.ts webapp/src/stores/templateInterrogation.ts webapp/src/components/FormalTemplatePanel.vue webapp/src/components/FormalRecordEditor.contract.test.ts
git commit -m "feat: render committed merged formal answers"
```

---

### Task 8: Implement D highlighting and two-mode drag/drop in the existing two-column UI

**Files:**
- Modify: `webapp/src/components/LiveDialoguePanel.vue`
- Modify: `webapp/src/components/FormalTemplatePanel.vue`
- Modify: `webapp/src/components/TemplateDrivenInterrogationPage.vue`
- Modify: `webapp/src/stores/templateInterrogation.ts`
- Modify: `webapp/src/api/templateInterrogation.ts`
- Modify: `webapp/src/components/templateInterrogation.css`
- Modify: `webapp/src/components/LiveDialogueEvidence.test.ts`
- Modify: `webapp/src/components/FormalRecordEditor.contract.test.ts`

**Drag MIME:**

```ts
const QA_MIME = 'application/x-formal-qa-unit'

type QADragPayload = {
  qaUnitId: string
  mode: 'QA' | 'ANSWER'
}
```

- [ ] **Step 1: Add failing UI contract tests**

Require source text for:
- D card label `待处理`;
- whole QA drag payload `mode: 'QA'`;
- answer-only drag handle payload `mode: 'ANSWER'`;
- existing question answer drop target;
- BODY blank/gap target for `CREATE_LIVE`;
- A/B/C status chips `已归档·固定模板`, `已归档·已有问题`, `已新增·现场问题`;
- E remains muted/raw and is not highlighted as pending.

- [ ] **Step 2: Run tests and verify failure**

```bash
cd webapp && npm test -- LiveDialogueEvidence.test.ts FormalRecordEditor.contract.test.ts
```

- [ ] **Step 3: Group/highlight QA units on the right**

Use QA unit fragment IDs to render a review card adjacent to its dialogue span. Do not duplicate the raw text as a replacement; the card references the existing raw fragments and shows AI candidate/suggestion metadata.

- [ ] **Step 4: Implement drag actions**

- drag whole QA to BODY gap -> `CREATE_LIVE`;
- drag whole QA onto existing question -> `LINK_QA`;
- drag answer-only onto existing question answer area -> `LINK_ANSWER`;
- explicit ignore button -> `IGNORE`.

The backend determines chronological placement from original QA time; the frontend must not send “current processing time” as ordering data.

- [ ] **Step 5: Run UI tests/typecheck/build**

```bash
cd webapp
npm test -- LiveDialogueEvidence.test.ts FormalRecordEditor.contract.test.ts
npm run typecheck
npm run build
```

- [ ] **Step 6: Commit**

```bash
git add webapp/src/components/LiveDialoguePanel.vue webapp/src/components/FormalTemplatePanel.vue webapp/src/components/TemplateDrivenInterrogationPage.vue webapp/src/stores/templateInterrogation.ts webapp/src/api/templateInterrogation.ts webapp/src/components/templateInterrogation.css webapp/src/components/LiveDialogueEvidence.test.ts webapp/src/components/FormalRecordEditor.contract.test.ts
git commit -m "feat: add qa review drag and drop"
```

---

### Task 9: Implement the real Qwen3-4B LlamaPi LLM adapter

**Files:**
- Create: `linux/backend/app/ai/engines/llamapi.py`
- Modify: `linux/backend/app/ai/worker.py`
- Modify: `linux/backend/app/ai/settings.py`
- Modify: `linux/backend/config/model-registry.yaml`
- Create: `linux/backend/tests/test_llamapi_llm_engine.py`
- Modify: `linux/backend/tests/test_ai_mock.py`

**Runtime configuration:**

```text
LLAMAPI_BASE_URL=http://127.0.0.1:9265/v1
LLAMAPI_MODEL_HINT=qwen3:4b
```

Registry `llm.default` becomes an external local service entry:

```json
{
  "kind": "llm",
  "backend": "llamapi",
  "path": "external/llamapi",
  "architecture": "qwen3",
  "required_files": [],
  "device": "npu",
  "context": 4096,
  "memory_mb": 4096,
  "capabilities": ["generate", "stream", "cancel"]
}
```

- [ ] **Step 1: Write failing adapter tests with a local fake HTTP server**

Test:
- `load()` GETs `/v1/models` and resolves exact configured model or one `qwen3:4b` match;
- zero/multiple ambiguous matches raise `BackendUnavailableError`;
- `generate()` POSTs `/v1/chat/completions` with `stream:false`, low temperature, and `enable_thinking:false` from options;
- response becomes `AITextResult` with exact resolved model ID;
- non-2xx/timeout/malformed response raises existing AI errors;
- adapter never contacts non-loopback default unless explicitly configured in tests.

- [ ] **Step 2: Run and verify failure**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_llamapi_llm_engine.py -q
```

- [ ] **Step 3: Implement adapter using Python stdlib HTTP**

Use `urllib.request` so no new runtime package is required. `stream()` may initially call non-stream generate and yield one final chunk because formal routing uses generate only; preserve the LLM interface.

- [ ] **Step 4: Select adapter in worker**

```python
if kind == "llm" and spec.backend == "llamapi":
    return LlamaPiLLMEngine(spec, base_url=settings...)
```

Because workers are spawned, pass LlamaPi settings explicitly through `worker_main` kwargs rather than relying on accidental process globals.

- [ ] **Step 5: Run AI/backend tests**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_llamapi_llm_engine.py linux/backend/tests/test_ai_mock.py -q
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
```

- [ ] **Step 6: Commit**

```bash
git add linux/backend/app/ai/engines/llamapi.py linux/backend/app/ai/worker.py linux/backend/app/ai/settings.py linux/backend/config/model-registry.yaml linux/backend/tests/test_llamapi_llm_engine.py linux/backend/tests/test_ai_mock.py
git commit -m "feat: connect qwen3 through llamapi"
```

---

### Task 10: Add end-to-end mock routing acceptance and rollback safety

**Files:**
- Create: `linux/backend/tests/test_qwen_formal_routing_e2e.py`
- Modify: `linux/backend/app/services/interrogation_projection_service.py`
- Modify: `linux/backend/tests/test_template_workspace_api.py`
- Modify: `.github/workflows/linux-ci.yml`

- [ ] **Step 1: Write a deterministic end-to-end test without a real model**

Inject a fake router that returns, in sequence:
1. A for `今天为什么过来的？` -> fixed `你因何事来公安机关？`;
2. B follow-up to the same semantic question with a merged canonical answer;
3. C for a real new officer question;
4. D ambiguity;
5. E operational chatter.

Assert:
- right-side ASR fragment rows for all five remain intact;
- left has one fixed question with merged answer, one new LIVE question, no D/E auto entries;
- D is exposed in `workspace.qaUnits`;
- chronology uses actual question time;
- frozen record rejects any later auto mutation;
- WebSocket formal update event is emitted after commit-visible workspace state.

- [ ] **Step 2: Run RED, then implement any missing integration seams**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_qwen_formal_routing_e2e.py -q
```

- [ ] **Step 3: Keep legacy route as explicit fallback only**

Do not delete `InterrogationProjectionService` yet. Add comments/tests that it is selected only when `formal_routing_mode == "legacy"` or through the existing manual `/speech-fragments/{id}/process` compatibility endpoint.

- [ ] **Step 4: Add focused files to hosted CI**

Ensure Linux CI executes routing schema/router/service/coordinator/E2E tests and the existing frontend test/typecheck/build stages.

- [ ] **Step 5: Full verification**

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
cd webapp && npm test && npm run typecheck && npm run build
bash -n deploy/control.sh scripts/*.sh 2>/dev/null || true
```

Expected: all project-supported checks PASS.

- [ ] **Step 6: Commit**

```bash
git add linux/backend/tests/test_qwen_formal_routing_e2e.py linux/backend/app/services/interrogation_projection_service.py linux/backend/tests/test_template_workspace_api.py .github/workflows/linux-ci.yml
git commit -m "test: cover qwen formal routing end to end"
```

---

### Task 11: RK3588 real-device Qwen3-4B acceptance and production switch

**Files:**
- Create: `scripts/ci/probe-llamapi-qwen-routing.py`
- Create: `.github/workflows/rk3588-qwen-formal-routing-acceptance.yml`
- Modify: `docs/release/RK3588-EVIDENCE.md`
- Modify: `docs/release/DEPLOYMENT.md`
- Modify: `systemd/interrogation-api.service` only if an environment-file contract change is actually required; otherwise leave the unit untouched and document `/etc/suspect-interrogation/ai-worker.env` values.

**Required board preconditions:**

```bash
systemctl is-active llamapi-server.service
curl -fsS http://127.0.0.1:9265/v1/models
```

The loaded model must resolve to Qwen3-4B (for example a LlamaPi model ID whose model name/hint is `qwen3:4b`). Do not hard-code a platform suffix in application code.

- [ ] **Step 1: Add a read-only local probe**

The script must:
- query `/v1/models`;
- run five representative strict-JSON routing prompts for A/B/C/D/E;
- set thinking disabled;
- validate schema and fact-preservation contracts;
- record latency per request, exact model ID, and pass/fail JSON under the Actions workspace;
- never stop/restart LlamaPi, download models, or touch unrelated TCP port 8000.

- [ ] **Step 2: Add self-hosted workflow**

Run on `[self-hosted, rk3588]`. Gate on hosted Linux CI first. Archive the JSON probe result as artifact.

- [ ] **Step 3: Real conversation acceptance**

On the board, execute a two-speaker or correctly enrolled speaker test:

```text
民警：今天为什么过来的？
嫌疑人：昨天晚上和别人发生了一点冲突，今天通知我过来。

民警：你离开以后有没有又回来？
嫌疑人：回来过一次，手机落里面了。

民警：声音大一点。
嫌疑人：好。
```

Acceptance:
- first QA -> A and fixed question answer appears left;
- second QA -> C and a LIVE question appears left in occurrence order;
- operational exchange -> E and stays right only;
- add a deliberately ambiguous QA to verify D highlight and both whole-QA + answer-only drag resolution;
- follow-up same semantic question merges into the existing left answer;
- no raw ASR fragment is removed or rewritten.

- [ ] **Step 4: Measure operational thresholds**

Record p50/p95 routing latency for at least 20 QA units and peak process memory. Acceptance target for v1: no capture-thread stalls; no lost fragments; each closed QA unit reaches `ROUTED`, `NEEDS_REVIEW`, or `IGNORED`; no unit remains stuck in `ROUTING` after timeout recovery.

- [ ] **Step 5: Switch production mode only after evidence passes**

Set in the production environment file:

```text
SUSPECT_FORMAL_ROUTING_MODE=qwen
LLAMAPI_BASE_URL=http://127.0.0.1:9265/v1
LLAMAPI_MODEL_HINT=qwen3:4b
```

Restart only this project's API service through the existing deployment procedure; do not restart/repurpose unrelated services. Verify `/health`, `/api/v1/.../template-workspace`, live ASR, Qwen route events, freeze/sign/report.

- [ ] **Step 6: Document evidence**

Update `docs/release/RK3588-EVIDENCE.md` with workflow/run/job IDs, commit SHA, exact Qwen model ID, A/B/C/D/E results, latency, and explicit statement that real live routing is now (or is not yet) accepted.

- [ ] **Step 7: Commit**

```bash
git add scripts/ci/probe-llamapi-qwen-routing.py .github/workflows/rk3588-qwen-formal-routing-acceptance.yml docs/release/RK3588-EVIDENCE.md docs/release/DEPLOYMENT.md
git commit -m "test: accept qwen formal routing on rk3588"
```

---

## Final Verification Gate

Before declaring implementation complete, run and capture evidence for:

```bash
# Backend
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q

# Frontend
cd webapp
npm test
npm run typecheck
npm run build

# Return to repo root
cd ..

# Relevant workflow/config syntax is checked by existing CI; also inspect git diff/status
git status --short
git log --oneline -12
```

Required behavioral checklist:

- [ ] A: natural officer wording maps to fixed template; template question text is preserved.
- [ ] B: existing CASE/LIVE question is reused; follow-up rounds merge into one canonical answer.
- [ ] C: only a real spoken officer question can create LIVE; cleaned question+answer preserve facts.
- [ ] D: nothing auto-enters left; unit is highlighted; whole QA and answer-only drag both work.
- [ ] E: filler/operational/off-topic QA stays raw-only.
- [ ] BODY order follows first actual officer question time; OPENING/CLOSING remain protected.
- [ ] Qwen failure/timeout/invalid JSON becomes D, never silent data loss.
- [ ] ASR capture thread never waits for LLM inference.
- [ ] Raw dialogue/provenance remains intact after auto route, manual drag, reassociation, edit, freeze, signature, report, restart, backup/restore.
- [ ] Production qwen mode is enabled only after self-hosted RK3588 acceptance evidence exists.

## Implementation Order Rationale

Tasks 1-4 establish durable provenance and deterministic write policy before any live inference is allowed. Task 5 moves inference off the audio thread and fixes the current publish-before-projection race by emitting formal-record events only after commit. Tasks 6-8 complete the D-class human recovery path and frontend visibility. Task 9 connects the already-existing AI worker abstraction to the user's real Qwen3-4B through LlamaPi. Tasks 10-11 prove the complete chain first with deterministic mocks, then with the actual RK3588 appliance before production switches away from legacy routing.
