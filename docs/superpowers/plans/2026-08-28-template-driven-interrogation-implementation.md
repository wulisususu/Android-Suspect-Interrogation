# Template-Driven Interrogation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the approved v1.0 template-driven interrogation workspace: persistent formal question templates on the left, complete ASR dialogue on the right, conservative deterministic question matching, buffered unmatched questions, multi-round answers, reassociation, pre-interrogation question preparation, and preserved signing/export flows.

**Architecture:** Keep ASR/xvector as the source of immutable dialogue facts and add a separate formal-note projection layer. Persist reusable `StandardQuestion`, per-case `CaseQuestion`, concrete `QuestionRound`, temporary `PendingQuestion`, and idempotent fragment-processing records; the frontend reads both the formal projection and the full `ASRFragment` stream. Matching remains pure/deterministic (`question_matching.py`), while orchestration lives in a dedicated service rather than `InterrogationPage.vue` or `asr.py`.

**Tech Stack:** FastAPI, SQLAlchemy 2.x, Alembic, SQLite/PostgreSQL-compatible SQLAlchemy models, pytest, Vue 3, Pinia, TypeScript, Axios, Vitest, Vite.

**Spec:** `docs/superpowers/specs/2026-08-28-template-driven-interrogation-design.md`

## Global Constraints

- Target branch: `linux-adaptation`; re-read branch HEAD before every write batch and never overwrite unrelated newer commits.
- Real-time matching is fully offline and deterministic; no LLM decides formal-question association.
- Never split one final police ASR utterance into multiple questions automatically.
- Prefer false negatives over false positives; 0 matches stays unmatched, 2+ matches requires human choice.
- `partialText` is display-only and never mutates formal notes.
- The right-side raw ASR dialogue is immutable provenance; reassociation changes only the formal projection.
- Police voiceprint enrollment must not be required to start interrogation; fallback police attribution remains valid.
- Old `Message`/`MessageRevision` data remains readable for compatibility; no destructive historical migration in v1.0.
- New C-page UI removes contradiction/low-confidence/suspicion business flags from the formal workflow, while low-level ASR confidence remains available for diagnostics.
- Existing identity, session start/pause/resume/finish, ASR capture, voiceprint, AI overview, document freeze, signature, and Linux/RK3588 CI flows must remain green.
- Standard-question seed data may only contain questions traceable to prior real templates. Until a question source is verified, keep it configurable rather than inventing a mandatory legal question.

---

### Task 1: Lock the deterministic question-matching core

**Files:**
- Modify: `linux/backend/app/services/question_matching.py`
- Modify: `linux/backend/tests/test_question_matching.py`

**Interfaces:**
- Consumes: `QuestionCandidate(id: str, text: str, patterns: tuple[str, ...])`
- Produces: `is_question_utterance(text: str) -> bool`
- Produces: `match_question(text: str, candidates: Iterable[QuestionCandidate]) -> QuestionMatchResult`
- Produces statuses: `NOT_QUESTION | UNMATCHED | MATCHED | AMBIGUOUS`

- [ ] **Step 1: Add failing regression tests for aliases, invalid regex, and non-question context preservation**

```python
def test_invalid_regex_does_not_break_other_candidates():
    questions = [
        QuestionCandidate(id="bad", text="bad", patterns=(r"(",)),
        QuestionCandidate(id="good", text="何时到现场", patterns=(r"什么时候.*现场",)),
    ]
    result = match_question("你什么时候到现场的？", questions)
    assert result.status is QuestionMatchStatus.MATCHED
    assert result.matched_question_ids == ("good",)


def test_plain_statement_with_question_word_inside_is_not_promoted_by_suffix_only():
    assert is_question_utterance("我不知道什么时候到的。") is False
```

- [ ] **Step 2: Run the focused tests and verify the new statement test fails before implementation**

Run: `PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_question_matching.py -q`

Expected: the new declarative-statement case fails while existing tests remain green.

- [ ] **Step 3: Refine the question classifier without adding semantic guessing**

Implement a narrow declarative-prefix guard before the existing cue check:

```python
_DECLARATIVE_PREFIXES = ("我不知道", "我不清楚", "我记不清", "我没注意")


def is_question_utterance(text: str) -> bool:
    normalized = normalize_question_text(text)
    if not normalized:
        return False
    if any(pattern.fullmatch(normalized) for pattern in _OPERATIONAL_UTTERANCES):
        return False
    if any(normalized.startswith(prefix) and not normalized.endswith("?") for prefix in _DECLARATIVE_PREFIXES):
        return False
    if "?" in normalized:
        return True
    return any(cue in normalized for cue in _QUESTION_CUES)
```

- [ ] **Step 4: Run focused + backend tests**

Run:

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_question_matching.py -q
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add linux/backend/app/services/question_matching.py linux/backend/tests/test_question_matching.py
git commit -m "test: harden deterministic question matching"
```

---

### Task 2: Add the v1.0 formal-template persistence schema

**Files:**
- Modify: `linux/backend/app/database/models.py`
- Create: `linux/backend/alembic/versions/0003_template_interrogation_workspace.py`
- Create: `linux/backend/tests/test_template_workspace_migration.py`

**Interfaces:**
- Produces SQLAlchemy models: `StandardQuestion`, `CaseQuestion`, `QuestionRound`, `PendingQuestion`, `ProcessedSpeechFragment`
- Foreign keys reuse existing `cases.id`, `interrogation_sessions.id`, and `asr_fragments.id`

- [ ] **Step 1: Write a failing migration/model contract test**

```python
from sqlalchemy import inspect
from app.database.models import CaseQuestion, PendingQuestion, ProcessedSpeechFragment, QuestionRound, StandardQuestion


def test_template_workspace_models_are_importable():
    assert StandardQuestion.__tablename__ == "standard_questions"
    assert CaseQuestion.__tablename__ == "case_questions"
    assert QuestionRound.__tablename__ == "question_rounds"
    assert PendingQuestion.__tablename__ == "pending_questions"
    assert ProcessedSpeechFragment.__tablename__ == "processed_speech_fragments"


def test_0003_creates_template_workspace_tables(migrated_engine):
    names = set(inspect(migrated_engine).get_table_names())
    assert {
        "standard_questions",
        "case_questions",
        "question_rounds",
        "pending_questions",
        "processed_speech_fragments",
    } <= names
```

Use the repository's existing Alembic test fixture pattern; if the migration tests currently construct the engine inline, follow that exact setup rather than inventing a second migration harness.

- [ ] **Step 2: Run the migration test and verify it fails because the models/revision do not exist**

Run: `PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_template_workspace_migration.py -q`

Expected: import/table failure.

- [ ] **Step 3: Add SQLAlchemy models with explicit constraints**

Add to `models.py`:

```python
class StandardQuestion(TimestampMixin, Base):
    __tablename__ = "standard_questions"
    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    text: Mapped[str] = mapped_column(Text, nullable=False)
    category: Mapped[str] = mapped_column(String(64), default="通用", nullable=False, index=True)
    regex_patterns_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    aliases_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    sort_order: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)


class CaseQuestion(TimestampMixin, Base):
    __tablename__ = "case_questions"
    __table_args__ = (UniqueConstraint("case_id", "sort_order", name="uq_case_questions_sort"),)
    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    source: Mapped[str] = mapped_column(String(16), nullable=False)  # STANDARD | CASE | LIVE
    standard_question_id: Mapped[str | None] = mapped_column(ForeignKey("standard_questions.id", ondelete="SET NULL"), nullable=True)
    text: Mapped[str] = mapped_column(Text, nullable=False)
    regex_patterns_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    aliases_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    sort_order: Mapped[int] = mapped_column(Integer, nullable=False)
    active: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)


class QuestionRound(TimestampMixin, Base):
    __tablename__ = "question_rounds"
    __table_args__ = (UniqueConstraint("case_question_id", "round_no", name="uq_question_round_no"),)
    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    session_id: Mapped[str | None] = mapped_column(ForeignKey("interrogation_sessions.id", ondelete="SET NULL"), nullable=True, index=True)
    case_question_id: Mapped[str] = mapped_column(ForeignKey("case_questions.id", ondelete="CASCADE"), nullable=False, index=True)
    round_no: Mapped[int] = mapped_column(Integer, nullable=False)
    actual_question_text: Mapped[str] = mapped_column(Text, nullable=False)
    officer_fragment_id: Mapped[str | None] = mapped_column(ForeignKey("asr_fragments.id", ondelete="SET NULL"), nullable=True, unique=True)
    answer_text: Mapped[str] = mapped_column(Text, default="", nullable=False)
    answer_fragment_ids_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    status: Mapped[str] = mapped_column(String(16), default="ACTIVE", nullable=False, index=True)
    started_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False)
    ended_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True)


class PendingQuestion(TimestampMixin, Base):
    __tablename__ = "pending_questions"
    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    session_id: Mapped[str | None] = mapped_column(ForeignKey("interrogation_sessions.id", ondelete="SET NULL"), nullable=True, index=True)
    officer_fragment_id: Mapped[str] = mapped_column(ForeignKey("asr_fragments.id", ondelete="CASCADE"), nullable=False, unique=True)
    question_text: Mapped[str] = mapped_column(Text, nullable=False)
    match_status: Mapped[str] = mapped_column(String(16), nullable=False)  # UNMATCHED | AMBIGUOUS
    candidate_question_ids_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    buffered_answer_text: Mapped[str] = mapped_column(Text, default="", nullable=False)
    buffered_fragment_ids_json: Mapped[str] = mapped_column(Text, default="[]", nullable=False)
    status: Mapped[str] = mapped_column(String(16), default="PENDING", nullable=False, index=True)


class ProcessedSpeechFragment(Base):
    __tablename__ = "processed_speech_fragments"
    fragment_id: Mapped[str] = mapped_column(ForeignKey("asr_fragments.id", ondelete="CASCADE"), primary_key=True)
    case_id: Mapped[str] = mapped_column(ForeignKey("cases.id", ondelete="CASCADE"), nullable=False, index=True)
    action: Mapped[str] = mapped_column(String(32), nullable=False)
    target_id: Mapped[str | None] = mapped_column(String(64), nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=utc_now, nullable=False)
```

- [ ] **Step 4: Implement Alembic revision `0003_template_interrogation_workspace`**

Set:

```python
revision = "0003_template_interrogation_workspace"
down_revision = "0002_voiceprint_speech_pipeline"
```

Create the five tables above with named FK/unique constraints and indexes; downgrade drops them in dependency-safe reverse order: `processed_speech_fragments`, `pending_questions`, `question_rounds`, `case_questions`, `standard_questions`.

- [ ] **Step 5: Run migration and full backend tests**

Run:

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_template_workspace_migration.py -q
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add linux/backend/app/database/models.py linux/backend/alembic/versions/0003_template_interrogation_workspace.py linux/backend/tests/test_template_workspace_migration.py
git commit -m "feat: add template interrogation schema"
```

---

### Task 3: Add repositories, serializers, and formal-template CRUD service

**Files:**
- Create: `linux/backend/app/repositories/template_questions.py`
- Create: `linux/backend/app/repositories/question_rounds.py`
- Create: `linux/backend/app/services/template_workspace_service.py`
- Modify: `linux/backend/app/services/serializers.py`
- Create: `linux/backend/tests/test_template_workspace_service.py`

**Interfaces:**
- Produces `TemplateWorkspaceService.workspace(case_id: str) -> dict`
- Produces `TemplateWorkspaceService.list_library(category: str | None = None) -> list[dict]`
- Produces `TemplateWorkspaceService.add_case_question(case_id: str, *, text: str, source: str, standard_question_id: str | None = None, regex_patterns: list[str] | None = None, after_question_id: str | None = None) -> dict`
- Produces `TemplateWorkspaceService.update_case_question(case_id: str, question_id: str, *, text: str | None = None, regex_patterns: list[str] | None = None) -> dict`
- Produces `TemplateWorkspaceService.reorder(case_id: str, ordered_ids: list[str]) -> list[dict]`
- Produces `TemplateWorkspaceService.save_to_library(case_id: str, question_id: str, category: str) -> dict`

- [ ] **Step 1: Write failing service tests for creation, alias preservation, ordering, and library isolation**

```python
def test_editing_case_question_preserves_previous_text_as_alias(db, case):
    svc = TemplateWorkspaceService(db)
    question = svc.add_case_question(case.id, text="你何时到现场？", source="CASE")
    updated = svc.update_case_question(case.id, question["id"], text="你什么时候到现场？")
    assert "你何时到现场？" in updated["aliases"]
    assert updated["text"] == "你什么时候到现场？"


def test_live_case_question_does_not_enter_global_library_without_explicit_save(db, case):
    svc = TemplateWorkspaceService(db)
    svc.add_case_question(case.id, text="你为什么第二次返回？", source="LIVE")
    assert svc.list_library() == []
```

Also cover insert-after-current and reorder rejecting missing/duplicate IDs.

- [ ] **Step 2: Run tests and verify service import fails**

Run: `PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_template_workspace_service.py -q`

Expected: FAIL because service/repositories are absent.

- [ ] **Step 3: Implement JSON helpers and serializers**

In `serializers.py` add stable helpers that parse JSON text into arrays and emit camelCase API fields:

```python
def case_question_dict(row: CaseQuestion) -> dict:
    return {
        "id": row.id,
        "caseId": row.case_id,
        "source": row.source,
        "standardQuestionId": row.standard_question_id,
        "text": row.text,
        "regexPatterns": json.loads(row.regex_patterns_json or "[]"),
        "aliases": json.loads(row.aliases_json or "[]"),
        "sortOrder": row.sort_order,
        "active": row.active,
    }
```

Add corresponding `standard_question_dict`, `question_round_dict`, and `pending_question_dict`.

- [ ] **Step 4: Implement repositories with deterministic sort and row locking where state transitions mutate active rounds/pending questions**

Repository rules:

```python
# template_questions.py
list_case_questions(db, case_id) -> order by sort_order, created_at
get_case_question(db, case_id, question_id) -> DomainError("CASE_QUESTION_NOT_FOUND", ..., 404)
next_sort_order(db, case_id) -> max + 10

# question_rounds.py
active_round(db, case_id, session_id) -> newest ACTIVE row or None
active_pending(db, case_id, session_id) -> newest PENDING row or None
```

- [ ] **Step 5: Implement `TemplateWorkspaceService` transactions**

Editing behavior must append the previous text to `aliases_json` exactly once before replacing `text`; reorder rewrites sort orders to `10, 20, 30...`; `save_to_library` clones text/patterns/aliases into a new `StandardQuestion`, never changes the source of the existing case question.

- [ ] **Step 6: Run focused + backend tests**

Run:

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_template_workspace_service.py -q
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add linux/backend/app/repositories/template_questions.py linux/backend/app/repositories/question_rounds.py linux/backend/app/services/template_workspace_service.py linux/backend/app/services/serializers.py linux/backend/tests/test_template_workspace_service.py
git commit -m "feat: add formal template workspace service"
```

---

### Task 4: Implement idempotent ASR-fragment orchestration and pending buffers

**Files:**
- Create: `linux/backend/app/services/interrogation_projection_service.py`
- Modify: `linux/backend/app/repositories/asr_fragments.py`
- Modify: `linux/backend/app/repositories/question_rounds.py`
- Create: `linux/backend/tests/test_interrogation_projection_service.py`

**Interfaces:**
- Consumes: existing persisted `ASRFragment`
- Consumes: `match_question()` from Task 1
- Produces: `InterrogationProjectionService.process_fragment(case_id: str, fragment_id: str) -> dict`
- Produces: `add_pending_as_question(pending_id, *, after_question_id=None) -> dict`
- Produces: `link_pending(pending_id, case_question_id, *, round_mode: str) -> dict`
- Produces: `ignore_pending(pending_id) -> dict`
- Produces: `reassociate_round(round_id, *, case_question_id: str | None, new_question_text: str | None = None) -> dict`
- `round_mode` is exactly `APPEND_EXISTING | NEW_ROUND` when a formal question already has history.

- [ ] **Step 1: Write failing state-machine tests**

Cover these exact scenarios:

```python
def test_suspect_fragment_appends_to_active_round_once(...):
    first = service.process_fragment(case_id, suspect_fragment.id)
    second = service.process_fragment(case_id, suspect_fragment.id)
    round_row = repo.get_round(...)
    assert round_row.answer_text == "我八点到的。"
    assert first == second


def test_operational_police_instruction_does_not_close_active_round(...):
    service.process_fragment(case_id, fragment("OFFICER_FALLBACK", "继续说。"))
    assert repo.active_round(db, case_id, session_id).id == existing_round.id


def test_unmatched_question_buffers_following_suspect_answer(...):
    result = service.process_fragment(case_id, fragment("INTERROGATOR", "你为什么又回去了？"))
    assert result["status"] == "UNMATCHED"
    service.process_fragment(case_id, fragment("SUSPECT", "我去拿钥匙。"))
    pending = repo.active_pending(db, case_id, session_id)
    assert pending.buffered_answer_text == "我去拿钥匙。"


def test_ambiguous_question_never_auto_links(...):
    result = service.process_fragment(case_id, ambiguous_officer_fragment.id)
    assert result["status"] == "AMBIGUOUS"
    assert len(result["candidateQuestionIds"]) == 2
    assert repo.active_round(db, case_id, session_id) is None
```

Also cover same-question `APPEND_EXISTING` vs `NEW_ROUND`, pending `ADD`, `LINK`, `IGNORE`, and reassociation preserving the original raw fragments.

- [ ] **Step 2: Run focused tests and verify they fail because orchestration does not exist**

Run: `PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_interrogation_projection_service.py -q`

Expected: FAIL.

- [ ] **Step 3: Implement fragment-id idempotency first**

At the start of `process_fragment`:

```python
processed = processed_repo.get(db, fragment_id)
if processed is not None:
    return self._processed_result(processed)
```

Write `ProcessedSpeechFragment` in the same transaction as the projection mutation. Never mark a fragment processed before the formal mutation succeeds.

- [ ] **Step 4: Implement suspect-fragment handling**

Rules:

```python
pending = rounds_repo.active_pending(...)
if pending:
    append fragment text/id to pending buffer
elif round_ := rounds_repo.active_round(...):
    append fragment text/id to round answer
else:
    record action="RAW_ONLY"
```

Append text using a single-space separator only when both existing/new values are non-empty. De-duplicate fragment IDs before changing text.

- [ ] **Step 5: Implement police-fragment handling**

Rules:

```python
if not is_question_utterance(text):
    return RAW_ONLY without closing current round

close current ACTIVE round before opening a new question context
result = match_question(text, active_case_questions)
if MATCHED and question has no previous rounds:
    create round 1 ACTIVE
elif MATCHED and question has previous rounds:
    create pending state requiring APPEND_EXISTING vs NEW_ROUND choice
elif UNMATCHED or AMBIGUOUS:
    create PendingQuestion and make it the new answer buffer context
```

For a repeated matched question, represent the human-choice state as `PendingQuestion(match_status="MATCHED_EXISTING")` and include that value in API/frontend types even though the original spec listed only `UNMATCHED | AMBIGUOUS`; this is a necessary persistence representation of the already-approved "追加原回答 / 新增一轮" decision. Do not silently choose either mode.

- [ ] **Step 6: Implement pending actions and reassociation**

`add_pending_as_question` creates a `LIVE` question after the requested/current question and moves the complete buffered answer into round 1. `link_pending` either reopens/appends the latest round or creates `round_no=max+1`. `ignore_pending` marks it `IGNORED` without changing ASR fragments. `reassociate_round` updates `case_question_id` (or creates a LIVE question first), recalculates destination `round_no`, and never edits `ASRFragment` rows.

- [ ] **Step 7: Run focused + full backend tests**

Run:

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_interrogation_projection_service.py -q
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add linux/backend/app/services/interrogation_projection_service.py linux/backend/app/repositories/asr_fragments.py linux/backend/app/repositories/question_rounds.py linux/backend/tests/test_interrogation_projection_service.py
git commit -m "feat: project ASR dialogue into formal question rounds"
```

---

### Task 5: Expose the template workspace API and wire fragment processing

**Files:**
- Create: `linux/backend/app/api/template_workspace.py`
- Modify: `linux/backend/app/api/schemas.py`
- Modify: `linux/backend/app/main.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Create: `linux/backend/tests/test_template_workspace_api.py`
- Modify: `linux/backend/tests/test_asr_capture_service.py`

**Interfaces:**
- Produces endpoints from spec section 13.
- Existing `GET /cases/{case_id}/asr/fragments?include_confirmed=true` remains the source for full dialogue history.

- [ ] **Step 1: Write failing API contract tests**

Test at minimum:

```python
def test_get_template_workspace(client, case_id):
    response = client.get(f"/api/v1/cases/{case_id}/template-workspace")
    assert response.status_code == 200
    assert set(response.json()["data"]) >= {"questions", "rounds", "pendingQuestions"}


def test_create_case_question(client, case_id):
    response = client.post(
        f"/api/v1/cases/{case_id}/questions",
        json={"text": "你什么时候到现场？", "source": "CASE", "regexPatterns": ["什么时候.*现场"]},
    )
    assert response.status_code == 200
```

Also cover update, reorder, pending add/link/ignore, reassociate, save-to-library, and invalid IDs.

- [ ] **Step 2: Run API tests and verify 404/import failures**

Run: `PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_template_workspace_api.py -q`

Expected: FAIL.

- [ ] **Step 3: Add exact Pydantic request types**

```python
class CaseQuestionCreateRequest(BaseModel):
    text: str
    source: Literal["STANDARD", "CASE", "LIVE"] = "CASE"
    standard_question_id: str | None = Field(None, alias="standardQuestionId")
    regex_patterns: list[str] = Field(default_factory=list, alias="regexPatterns")
    after_question_id: str | None = Field(None, alias="afterQuestionId")

class CaseQuestionUpdateRequest(BaseModel):
    text: str | None = None
    regex_patterns: list[str] | None = Field(None, alias="regexPatterns")

class QuestionReorderRequest(BaseModel):
    question_ids: list[str] = Field(alias="questionIds")

class PendingLinkRequest(BaseModel):
    case_question_id: str = Field(alias="caseQuestionId")
    round_mode: Literal["APPEND_EXISTING", "NEW_ROUND"] = Field(alias="roundMode")

class RoundReassociateRequest(BaseModel):
    case_question_id: str | None = Field(None, alias="caseQuestionId")
    new_question_text: str | None = Field(None, alias="newQuestionText")
```

Use the existing Pydantic alias/config pattern from `schemas.py` if it already centralizes camelCase handling.

- [ ] **Step 4: Implement `template_workspace.py` router and include it from `main.py`**

Use `Depends(get_db)`, `envelope(...)`, and existing `DomainError` handling. Keep business transactions inside services, not route handlers.

- [ ] **Step 5: Wire processing to persisted final fragments**

In `ASRCaptureService`, immediately after a final `ASRFragment` is committed/published, call the projection service with that persisted `fragment.id`. Fail-safe rule: projection failure must emit/log a workflow error but must never lose or roll back the raw ASR fragment. The raw fragment commit happens first; projection runs in a new DB transaction/session.

Pseudo-flow:

```python
fragment = persist_final_fragment(...)
db.commit()
publish_asr_fragment(fragment)
try:
    with session_factory() as projection_db:
        InterrogationProjectionService(projection_db).process_fragment(case_id, fragment.id)
except Exception:
    logger.exception("formal interrogation projection failed for fragment %s", fragment.id)
```

- [ ] **Step 6: Add a capture-service regression proving raw ASR survives projection failure**

Mock `InterrogationProjectionService.process_fragment` to raise, then assert the fragment is still persisted and the capture loop remains alive.

- [ ] **Step 7: Run backend tests**

Run:

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests/test_template_workspace_api.py linux/backend/tests/test_asr_capture_service.py -q
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add linux/backend/app/api/template_workspace.py linux/backend/app/api/schemas.py linux/backend/app/main.py linux/backend/app/services/asr_capture_service.py linux/backend/tests/test_template_workspace_api.py linux/backend/tests/test_asr_capture_service.py
git commit -m "feat: expose template interrogation API"
```

---

### Task 6: Add frontend types, API client, store state, and pure view-model tests

**Files:**
- Create: `webapp/src/types/templateInterrogation.ts`
- Create: `webapp/src/api/templateInterrogation.ts`
- Create: `webapp/src/utils/templateInterrogation.ts`
- Create: `webapp/src/utils/templateInterrogation.test.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/types/interrogation.ts`

**Interfaces:**
- Produces `TemplateWorkspace`, `FormalQuestion`, `QuestionRound`, `PendingQuestion`, `LiveDialogueItem` TypeScript types.
- Store exposes `templateWorkspace`, `dialogueHistory`, `loadTemplateWorkspace()`, `createCaseQuestion()`, `updateCaseQuestion()`, `reorderCaseQuestions()`, `resolvePendingQuestion()`, `reassociateRound()`.

- [ ] **Step 1: Write failing pure-function tests before Vue components**

```ts
import { describe, expect, it } from 'vitest'
import { dialoguePresentation, roundGroups } from './templateInterrogation'

describe('dialoguePresentation', () => {
  it('places suspect on the left and officers on the right', () => {
    expect(dialoguePresentation({ speaker: 'SUSPECT' } as any).side).toBe('left')
    expect(dialoguePresentation({ speaker: 'INTERROGATOR' } as any).side).toBe('right')
    expect(dialoguePresentation({ speaker: 'RECORDER' } as any).badge).toBe('记录员')
  })

  it('keeps unknown attribution neutral', () => {
    expect(dialoguePresentation({ speaker: 'UNKNOWN' } as any).side).toBe('neutral')
  })
})
```

Also test grouping multiple rounds under one formal question and ordering exported/view-model rounds by `startedAt` rather than UI fold state.

- [ ] **Step 2: Run Vitest and verify missing-module failure**

Run: `cd webapp && npm test -- --run src/utils/templateInterrogation.test.ts`

Expected: FAIL.

- [ ] **Step 3: Define exact frontend domain types**

```ts
export type FormalQuestionSource = 'STANDARD' | 'CASE' | 'LIVE'
export type PendingMatchStatus = 'UNMATCHED' | 'AMBIGUOUS' | 'MATCHED_EXISTING'
export type PendingStatus = 'PENDING' | 'ADDED' | 'LINKED' | 'IGNORED'
export type RoundStatus = 'ACTIVE' | 'CLOSED' | 'DETACHED'

export interface FormalQuestion {
  id: string
  caseId: string
  source: FormalQuestionSource
  standardQuestionId?: string | null
  text: string
  regexPatterns: string[]
  aliases: string[]
  sortOrder: number
  active: boolean
}
```

Add `FormalQuestionRound`, `PendingFormalQuestion`, `TemplateWorkspace`, and API payload types with field names matching backend camelCase output.

- [ ] **Step 4: Implement API client calls in a dedicated module**

Use the shared Axios instance from `webapp/src/api/http.ts`; do not expand the already-large `api/interrogation.ts` further. Implement functions corresponding one-to-one with Task 5 endpoints.

- [ ] **Step 5: Implement pure presentation helpers**

`dialoguePresentation(fragment)` mapping:

```ts
SUSPECT -> { side: 'left', badge: '嫌疑人' }
INTERROGATOR -> { side: 'right', badge: '主审' }
RECORDER -> { side: 'right', badge: '记录员' }
OFFICER_FALLBACK -> { side: 'right', badge: '民警' }
UNKNOWN -> { side: 'neutral', badge: '待识别' }
```

Low confidence alone must not add a yellow/red business-state label.

- [ ] **Step 6: Extend Pinia store initialization**

On case initialization and ASR fragment events:

- fetch full dialogue with `include_confirmed=true`;
- fetch template workspace;
- on new `ASR_FRAGMENT`, upsert dialogue immediately and then refresh only the template workspace after backend projection is expected to settle;
- never remove confirmed fragments from `dialogueHistory`;
- keep existing capture fragments for compatibility during transition, but the new page reads `dialogueHistory`.

- [ ] **Step 7: Run frontend tests/typecheck**

Run:

```bash
cd webapp
npm test -- --run src/utils/templateInterrogation.test.ts
npm run typecheck
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add webapp/src/types/templateInterrogation.ts webapp/src/api/templateInterrogation.ts webapp/src/utils/templateInterrogation.ts webapp/src/utils/templateInterrogation.test.ts webapp/src/stores/interrogation.ts webapp/src/types/interrogation.ts
git commit -m "feat: add template interrogation frontend state"
```

---

### Task 7: Build the two-column C-page and pre-interrogation question preparation UI

**Files:**
- Create: `webapp/src/components/TemplateDrivenInterrogationPage.vue`
- Create: `webapp/src/components/FormalTemplatePanel.vue`
- Create: `webapp/src/components/LiveDialoguePanel.vue`
- Create: `webapp/src/components/QuestionPreparationPanel.vue`
- Create: `webapp/src/components/templateInterrogation.css`
- Modify: `webapp/src/views/InterrogationWorkspace.vue`
- Retain for compatibility until final cleanup: `webapp/src/components/InterrogationPage.vue`

**Interfaces:**
- `TemplateDrivenInterrogationPage` receives current summary/session/capture plus `templateWorkspace` and `dialogueHistory`, and emits store-level commands.
- `FormalTemplatePanel` edits/reorders formal questions and rounds.
- `LiveDialoguePanel` displays immutable dialogue and pending resolution actions.
- `QuestionPreparationPanel` is shown before session RUNNING and supports library/manual/voice-to-input preparation.

- [ ] **Step 1: Add component-level static contract tests using existing Vitest strategy**

If the repo does not include `@vue/test-utils`, do not add it only for this task. Add a static-source regression similar to existing component audit tests that asserts:

```ts
expect(source).toContain('formal-template-panel')
expect(source).toContain('live-dialogue-panel')
expect(source).not.toContain('矛盾标记')
expect(source).not.toContain('低置信度')
```

Also keep pure behavior in Task 6 tests.

- [ ] **Step 2: Implement `LiveDialoguePanel.vue`**

Required behavior:

- scrollable feed with bubble alignment from `dialoguePresentation`;
- final fragments persist through refresh;
- `partialText` renders one bottom `正在识别…` bubble only;
- pending `UNMATCHED`: show `加入本案笔录` / `忽略`;
- pending `AMBIGUOUS`: list candidate formal questions + `新建本案问题` / `忽略`;
- pending `MATCHED_EXISTING`: show `追加到原回答` / `新增一轮问答`;
- auto-scroll only while user is within 80px of bottom; otherwise show `↓ 最新消息`.

Use `nextTick` + a feed ref; do not poll the DOM.

- [ ] **Step 3: Implement `FormalTemplatePanel.vue`**

Required behavior:

- fixed header fields from case/session summary;
- ordered formal questions;
- editable question text;
- each question shows round count and latest answer;
- old rounds collapse by default but can expand;
- edit answer text through the Task 5 round PATCH endpoint;
- `重新关联` opens a compact selector for existing question or `新建本案问题`;
- reorder via explicit up/down controls in v1.0 (avoid adding a drag-and-drop dependency).

No conflict/pending/highlight/low-confidence mark buttons appear in this component.

- [ ] **Step 4: Implement `QuestionPreparationPanel.vue`**

Before session start, expose three tabs/areas:

1. 问题库：category filter + check/add from verified `StandardQuestion` rows.
2. 手动输入：text field + optional regex field + `加入本案问题`.
3. 语音输入：reuse existing ASR capture start/stop primitives; the final recognized text populates the input field but does not create the question until `加入本案问题` is clicked.

Do not start a second WebSocket or second microphone runtime.

- [ ] **Step 5: Implement `TemplateDrivenInterrogationPage.vue` layout and preserve signing controls**

CSS baseline:

```css
.template-interrogation-grid {
  height: 100%;
  min-height: 0;
  display: grid;
  grid-template-columns: minmax(680px, 2.05fr) minmax(360px, 0.95fr);
  gap: 1px;
  background: #b8c7d2;
}

.formal-template-panel { background: #f7fafc; min-width: 0; overflow: auto; }
.live-dialogue-panel { background: #eef3f6; min-width: 0; overflow: hidden; }
```

Keep the visual language restrained/police-business-like: light gray workspace, white formal cards, blue-gray officer bubbles, white suspect bubbles, compact role/name/time metadata. Do not imitate playful consumer chat UI.

Move existing `案件 AI 梳理`, finish/freeze, and electronic-signature controls into the formal panel toolbar/footer; preserve their existing API calls and disable rules.

- [ ] **Step 6: Switch `InterrogationWorkspace.vue` from old `InterrogationPage` to the new page**

Keep `VoiceprintPreparationPanel` and `SessionControls` unchanged around it. Pass store state/actions explicitly; do not put API logic inside `InterrogationWorkspace.vue`.

- [ ] **Step 7: Run frontend gates**

Run:

```bash
cd webapp
npm test
npm run typecheck
npm run build
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add webapp/src/components/TemplateDrivenInterrogationPage.vue webapp/src/components/FormalTemplatePanel.vue webapp/src/components/LiveDialoguePanel.vue webapp/src/components/QuestionPreparationPanel.vue webapp/src/components/templateInterrogation.css webapp/src/views/InterrogationWorkspace.vue
git commit -m "feat: replace interrogation C-page with two-column workspace"
```

---

### Task 8: Adapt freeze/sign/export to formal rounds and retire old C-page business marks

**Files:**
- Modify: `linux/backend/app/services/document_service.py`
- Modify: `linux/backend/app/services/serializers.py`
- Modify reporting/export files under `linux/backend/app/reporting/` that currently consume legacy messages
- Modify: `linux/backend/tests/test_document_signing.py` or the existing document-service test file
- Modify: `webapp/src/components/TemplateDrivenInterrogationPage.vue`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Delete after all references are removed: `webapp/src/components/InterrogationPage.vue`

**Interfaces:**
- Document snapshots for new cases consume `CaseQuestion + QuestionRound`.
- Legacy cases with no `CaseQuestion` rows fall back to current `Message` serialization so historical cases stay usable.

- [ ] **Step 1: Write failing document snapshot/export tests**

Test that:

```python
def test_new_template_snapshot_expands_all_rounds_in_real_time_order(...):
    snapshot = service.freeze(case_id)
    qa = snapshot["content"]["formalQa"]
    assert [item["roundNo"] for item in qa] == [1, 2]
    assert [item["startedAt"] for item in qa] == sorted(item["startedAt"] for item in qa)


def test_detached_round_is_excluded_from_formal_export(...):
    assert detached_round.actual_question_text not in rendered_output
```

Also test legacy-message fallback.

- [ ] **Step 2: Run document tests and verify they fail on missing formal-round snapshot data**

Run the repository's existing document/signing test module plus the new cases.

- [ ] **Step 3: Implement formal snapshot serialization**

For cases with active `CaseQuestion` rows, serialize every non-DETACHED round as:

```python
{
    "questionId": question.id,
    "questionText": question.text,
    "roundId": round.id,
    "roundNo": round.round_no,
    "actualQuestionText": round.actual_question_text,
    "answerText": round.answer_text,
    "startedAt": round.started_at.isoformat(),
    "endedAt": round.ended_at.isoformat() if round.ended_at else None,
}
```

Sort the flattened export list by `round.started_at`, never by UI fold state or question `sort_order` alone.

- [ ] **Step 4: Preserve legacy fallback**

If a case has zero `CaseQuestion` rows, call the existing message-based serializer exactly as before. Do not backfill old data automatically in this release.

- [ ] **Step 5: Remove obsolete C-page formal-mark calls from frontend**

Once no new component imports `markTranscriptMessage`, remove only the unused C-page call paths. Do not delete the backend mark endpoint in v1.0 because historical clients/cases may still use it.

Delete the old `InterrogationPage.vue` only after `grep`/TypeScript confirms no imports remain.

- [ ] **Step 6: Run backend/frontend regression gates**

Run:

```bash
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
cd webapp
npm test
npm run typecheck
npm run build
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add linux/backend/app/services/document_service.py linux/backend/app/services/serializers.py linux/backend/app/reporting webapp/src/components/TemplateDrivenInterrogationPage.vue webapp/src/api/interrogation.ts webapp/src/stores/interrogation.ts
git rm webapp/src/components/InterrogationPage.vue
git commit -m "feat: freeze and export template question rounds"
```

---

### Task 9: Verify API compatibility, browser layout, CI, and RK3588 deployment readiness

**Files:**
- Modify only if a regression is found: `.github/workflows/linux-ci.yml`
- Modify only if required for the new routes: release/E2E tests under `tests/`
- Create: `docs/template-interrogation-operator-guide.md`

**Interfaces:**
- No new production interfaces; this task is acceptance and documentation.

- [ ] **Step 1: Add a release-level E2E scenario**

Use the existing FastAPI TestClient/release harness to execute:

1. create/open case;
2. satisfy suspect voiceprint prerequisite;
3. prepare one CASE question;
4. start session;
5. persist/process an officer question matching that formal question;
6. persist/process two suspect answer fragments;
7. process `继续说。` and prove it does not switch context;
8. process an unmatched officer question;
9. buffer suspect answer;
10. add pending question to case;
11. ask same formal question again and choose `NEW_ROUND`;
12. reassociate one round;
13. finish/freeze/sign;
14. verify formal snapshot contains all non-detached rounds in chronological order and raw ASR fragments still exist.

- [ ] **Step 2: Run the complete hosted gate locally where possible**

Run the same commands encoded by `.github/workflows/linux-ci.yml`:

```bash
python -m compileall -q linux/backend
PYTHONPATH=linux/backend python -m pytest linux/backend/tests -q
cd webapp && npm ci && npm test && npm run typecheck && npm run build
```

Expected: PASS.

- [ ] **Step 3: Push/observe GitHub Actions hosted Linux gate**

Require every existing Linux hosted step to pass: repository Linux-only audit, Python tests, DB migration test, API/security contracts, hardware/AI mocks, Vue tests, typecheck, build, browser screenshot QA, release integration/E2E.

- [ ] **Step 4: Review browser screenshot artifact**

Acceptance at the target kiosk viewport:

- exactly two main C-page columns;
- formal template ~65–70%, live dialogue ~30–35%;
- no legacy subject third column;
- no contradiction/low-confidence/pending-mark control clutter;
- bubbles wrap without horizontal overflow;
- signature/freeze actions remain reachable without covering question content;
- pre-interrogation preparation is usable before RUNNING.

- [ ] **Step 5: Require RK3588 smoke to pass**

Observe the existing RK3588 workflow after the final commit. Required stages: backend tests, Vue gates, release smoke. If hardware-only failures occur, diagnose them separately; do not weaken hosted tests to make the device job green.

- [ ] **Step 6: Write operator guide**

`docs/template-interrogation-operator-guide.md` must explain the actual UI flow:

- prepare questions from library/manual/voice;
- start session;
- interpret right-side roles;
- resolve unmatched/multiple/repeated matches;
- edit/reorder/reassociate formal rounds;
- finish, freeze, sign;
- distinction between raw dialogue and formal note.

- [ ] **Step 7: Final verification commit**

```bash
git add tests docs/template-interrogation-operator-guide.md
git commit -m "test: verify template-driven interrogation workflow"
```

---

## Self-Review Against the Spec

- Sections 1–3 (two-column architecture + raw/formal separation): Tasks 6–7.
- Section 4 (pre-interrogation library/manual/voice): Tasks 3, 5, 7.
- Sections 5–6 (question classification + regex): Task 1.
- Sections 7–8 (unmatched/multiple-match buffers): Tasks 4–7.
- Section 9 (multi-round answers): Tasks 2–4, 7–8.
- Section 10 (automatic suspect-answer append): Task 4.
- Section 11 (reassociation): Tasks 4–7.
- Section 12 (data model/idempotency): Tasks 2–4.
- Section 13 (API): Task 5.
- Section 14 (real-time state machine): Tasks 4–5.
- Section 15 (frontend split): Tasks 6–7.
- Section 16 (freeze/sign/export): Task 8.
- Section 17 (old logic migration/compatibility): Task 8.
- Section 18 (traceable template sources): Task 3 global constraints; no invented mandatory seed data.
- Sections 19–21 (tests/order/acceptance): Tasks 1–9.

No destructive legacy migration is included. No runtime LLM question matching is included. No automatic compound-utterance splitting is included.
