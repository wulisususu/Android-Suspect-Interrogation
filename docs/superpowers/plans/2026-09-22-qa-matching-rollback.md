# 案件问答匹配增强与本次匹配回退 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 让固定模板口语问法和跨片段回答稳定进入案件正式笔录，并提供只撤销当前回答、不影响后续匹配的回退按钮。

**Architecture:** 后端在模型路由前后复用一套确定性模板匹配规则；QA 构建器在创建孤立回答前尝试关联最近未回答问题。回退复用现有 `DETACHED` 轮次语义，重算问题规范回答并将 QA 单元标记为 `ROLLED_BACK`。前端只通过案件级 API 操作并刷新工作区。

**Tech Stack:** FastAPI、SQLAlchemy、Alembic、pytest、Vue 3、TypeScript、Pinia。

---

### Task 1: 固定模板规则匹配

**Files:**
- Modify: `linux/backend/app/services/formal_record_router.py`
- Modify: `linux/backend/app/services/template_workspace_service.py`
- Test: `linux/backend/tests/test_formal_record_router_normalization.py`
- Test: `linux/backend/tests/test_formal_record_router.py`

- [ ] **Step 1: Write the failing tests**

添加测试：模板问题“你因何事来公安机关？”对“你应何时来公安机关”返回唯一 `MATCH_FIXED`；模型输出无法解析时仍返回同一固定目标；普通陈述不触发固定问题匹配。

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `cd linux/backend; pytest -q tests/test_formal_record_router_normalization.py tests/test_formal_record_router.py -k "opening_reason or fallback or spoken_variant"`

Expected: 新增用例在当前实现中失败，因为现有逻辑只做去标点精确匹配且模型异常直接返回 `NEEDS_REVIEW`。

- [ ] **Step 3: Implement the minimal deterministic matcher**

在 `formal_record_router.py` 增加模板项级文本归一化：移除空白、标点和句首口头语，统一“应何时/何时/什么事/何事/为什么”到“因何事”语义组，并要求文本包含“来/到公安机关”语义。增加唯一目标解析函数，在模型调用前和 `_invalid` 返回前调用。只返回锁定模板问题，正式回答使用 `unit.raw_answer_text`。

在 `template_workspace_service.py` 的 `opening-reason` 模板项中补充持久化 aliases，保证旧版和新版确定性路径共用同一候选数据。

- [ ] **Step 4: Run focused tests and the router suite**

Run: `cd linux/backend; pytest -q tests/test_formal_record_router_normalization.py tests/test_formal_record_router.py`

Expected: PASS。

- [ ] **Step 5: Commit**

```bash
git add linux/backend/app/services/formal_record_router.py linux/backend/app/services/template_workspace_service.py linux/backend/tests/test_formal_record_router_normalization.py linux/backend/tests/test_formal_record_router.py
git commit -m "fix: add deterministic spoken question fallback"
```

### Task 2: 跨片段问答关联

**Files:**
- Modify: `linux/backend/app/services/qa_unit_builder.py`
- Modify: `linux/backend/app/repositories/qa_units.py`
- Test: `linux/backend/tests/test_qa_unit_builder.py`

- [ ] **Step 1: Write the failing tests**

添加两个行为测试：一个只有问题的单元后，下一条同会话嫌疑人回答会追加到该单元并不创建 `ORPHAN_ANSWER`；超出时间窗口或没有未回答问题时，仍创建 `ORPHAN_ANSWER`。

- [ ] **Step 2: Run the builder tests and verify failure**

Run: `cd linux/backend; pytest -q tests/test_qa_unit_builder.py -k "late_answer or orphan"`

Expected: 关联测试失败，当前实现只查看 OPEN 单元，没有查找最近无回答单元。

- [ ] **Step 3: Implement recent unanswered lookup and re-open**

在 `qa_units.py` 增加同案件/会话的最近无回答问题查询；在 `QAUnitBuilder` 中设置明确的短时间窗口，找到候选后追加回答片段、刷新文本、恢复为可路由的 `CLOSED` 状态并清理上一次待审核决策字段。没有候选才走现有孤立回答分支。

- [ ] **Step 4: Run builder and routing regression tests**

Run: `cd linux/backend; pytest -q tests/test_qa_unit_builder.py tests/test_qa_routing_coordinator.py tests/test_qa_unit_manual_resolution.py`

Expected: PASS。

- [ ] **Step 5: Commit**

```bash
git add linux/backend/app/services/qa_unit_builder.py linux/backend/app/repositories/qa_units.py linux/backend/tests/test_qa_unit_builder.py
git commit -m "fix: associate late answers with recent questions"
```

### Task 3: 后端正式轮次回退

**Files:**
- Modify: `linux/backend/app/repositories/question_rounds.py`
- Modify: `linux/backend/app/repositories/template_questions.py`
- Modify: `linux/backend/app/services/formal_record_routing_service.py`
- Modify: `linux/backend/app/api/template_workspace.py`
- Modify: `linux/backend/app/services/serializers.py`
- Modify: `linux/backend/app/database/models.py` only if the existing status/metadata cannot identify the applied round
- Test: `linux/backend/tests/test_qa_unit_manual_resolution.py`
- Test: `linux/backend/tests/test_template_workspace_api.py`

- [ ] **Step 1: Write the failing tests**

添加回退测试：应用问答后调用案件级回退，目标 `QuestionRound.status` 为 `DETACHED`，工作区仍返回目标问题但 `formalAnswerText` 为空，QA 单元状态为 `ROLLED_BACK`；再次回退返回 409；随后新 QA 单元仍可对同一问题应用。

- [ ] **Step 2: Run the focused tests and verify failure**

Run: `cd linux/backend; pytest -q tests/test_qa_unit_manual_resolution.py tests/test_template_workspace_api.py -k "rollback or detach"`

Expected: FAIL，因为当前没有 QA 单元回退接口和 `ROLLED_BACK` 状态。

- [ ] **Step 3: Implement round lookup, detach, and canonical-answer rebuild**

在 `question_rounds.py` 增加按 QA 单元问题/回答片段定位唯一非 DETACHED 轮次的方法；在 `template_questions.py` 增加按最近非 DETACHED 轮次重建 `formal_answer_text` 的方法。`FormalRecordRoutingService.rollback_qa_unit` 校验案件可编辑、单元状态为 `APPLIED`，标记轮次 `DETACHED`，重建规范回答，保存 `ROLLED_BACK` 状态并写入审计事件。

- [ ] **Step 4: Expose the endpoint and run focused tests**

在 `template_workspace.py` 增加 `POST /cases/{case_id}/qa-units/{qa_unit_id}/rollback`，校验案件归属后调用服务并提交事务。运行：

`cd linux/backend; pytest -q tests/test_qa_unit_manual_resolution.py tests/test_template_workspace_api.py`

Expected: PASS。

- [ ] **Step 5: Commit**

```bash
git add linux/backend/app/repositories/question_rounds.py linux/backend/app/repositories/template_questions.py linux/backend/app/services/formal_record_routing_service.py linux/backend/app/api/template_workspace.py linux/backend/app/services/serializers.py linux/backend/tests/test_qa_unit_manual_resolution.py linux/backend/tests/test_template_workspace_api.py
git commit -m "feat: allow rolling back one applied qa match"
```

### Task 4: 前端回退按钮

**Files:**
- Modify: `webapp/src/types/templateInterrogation.ts`
- Modify: `webapp/src/api/templateInterrogation.ts`
- Modify: `webapp/src/stores/templateInterrogation.ts`
- Modify: `webapp/src/components/LiveDialoguePanel.vue`
- Test: `webapp/src/components/LiveDialogueEvidence.test.ts`

- [ ] **Step 1: Write the failing contract tests**

断言类型包含 `ROLLED_BACK`，API 源码包含案件级 QA 回退请求，归档状态卡片对 `APPLIED` 显示“回退本次匹配”，对 `ROLLED_BACK` 显示“已回退”且没有回退按钮。

- [ ] **Step 2: Run the frontend contract tests and verify failure**

Run: `npm test -- --run webapp/src/components/LiveDialogueEvidence.test.ts`

Expected: FAIL，因为当前类型、API 和状态卡片没有回退行为。

- [ ] **Step 3: Implement API/store/UI behavior**

增加 `rollbackQaUnit(caseId, qaUnitId)` API 和 Pinia action；在 `LiveDialoguePanel.vue` 对已应用单元发出 `rollbackQaUnit` 事件，显示确认后的按钮和已回退状态。保持原始对话列表不变，成功后由 store 重新获取工作区。

- [ ] **Step 4: Run frontend tests and build**

Run: `npm test -- --run webapp/src/components/LiveDialogueEvidence.test.ts`; `npm run build`

Expected: PASS and production bundle succeeds。

- [ ] **Step 5: Commit**

```bash
git add webapp/src/types/templateInterrogation.ts webapp/src/api/templateInterrogation.ts webapp/src/stores/templateInterrogation.ts webapp/src/components/LiveDialoguePanel.vue webapp/src/components/LiveDialogueEvidence.test.ts
git commit -m "feat: add rollback action for applied qa matches"
```

### Task 5: 全量验证与部署

**Files:**
- Modify: `docs/release/VALIDATION-NOTES.md` only if deployment evidence is recorded by project convention.

- [ ] **Step 1: Run backend regression suite**

Run: `cd linux/backend; pytest -q`

Expected: all tests pass.

- [ ] **Step 2: Run frontend regression suite and build**

Run: `npm test -- --run`; `npm run build`

Expected: all tests pass and bundle builds.

- [ ] **Step 3: Review the diff and commit the integrated change**

Run: `git diff HEAD~4..HEAD --stat; git status --short`

Expected: only matching, QA pairing, rollback, UI, tests, and release documentation changed; worktree clean after commit.

- [ ] **Step 4: Push the production branch and monitor deployment**

Run: `git push origin linux-adaptation`; monitor the existing `RK3588 Production Redeploy` workflow until successful.

- [ ] **Step 5: Verify the live case without mutating it**

Run: `curl.exe --noproxy 192.168.0.9 --ssl-no-revoke --fail https://192.168.0.9:18080/health/live` and GET the template workspace for `CASE-20260922-ED27DC`.

Expected: health is alive, the new frontend/backend revision is live, existing rounds remain readable, and no case data is changed by verification.
