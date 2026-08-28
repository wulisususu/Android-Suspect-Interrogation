# 模板驱动审讯工作台 v1.0 设计规格

日期：2026-08-28  
目标分支：`linux-adaptation`

## 1. 目标

将 C 页“审讯记录”重构为两列、模板驱动的实时审讯工作台：

- 左列：可编辑的正式询问笔录模板，只承载最终正式问答结构。
- 右列：真实实时对话流，保留民警与嫌疑人的实际发言顺序和原始语义。
- FunASR/VAD 负责形成最终语音片段；xvector 负责以嫌疑人为锚点区分说话人。
- 民警完整发言结束后，如果属于实际问题，则用保守的正则规则匹配左侧正式问题。
- 匹配成功后，后续嫌疑人的最终 ASR 片段自动持续写入该问题当前回答轮次，直到出现下一条有效民警问题。

该设计以“右侧原始事实流不可被左侧结构化操作破坏”为核心原则。

## 2. 非目标

v1.0 明确不做：

- 不自动把一段复合民警发言拆成多个问题。
- 不使用 LLM 在实时路径中决定某句话应该匹配哪个正式问题。
- 不自动生成并塞入正式模板的“候选变量问题”。
- 不保留旧 C 页的矛盾标记、低置信度标记、存疑旗标、黄色/红色状态等正式笔录交互。
- 不因民警未注册声纹而阻塞审讯。

ASR/声纹内部仍可保留置信度用于诊断，但它不再成为左侧正式笔录的业务状态。

## 3. 两列信息架构

### 3.1 左列：正式模板

左列约占 65%–70%，包含：

1. 正式笔录头部固定字段：询问笔录、时间、地点、询问人、记录人、被询问人身份等。
2. 一套通用基础问题。
3. 民警在审讯开始前加入的本案问题。
4. 审讯过程中由真实新问题动态加入的本案问题。
5. 每个问题下的一个或多个问答轮次。

问题文本在审讯开始前和开始后都允许直接编辑。

每个正式问题的数据来源必须明确：

- `STANDARD`：来自标准问题库。
- `CASE`：审讯前为当前案件手工/语音加入。
- `LIVE`：审讯中遇到未匹配真实问题后，由民警确认加入。

现场新增问题默认插入“当前问题”之后；民警可以调整左栏问题顺序。

### 3.2 右列：实时对话

右列约占 30%–35%，以气泡形式显示真实语音片段：

- `SUSPECT`：左侧气泡。
- `INTERROGATOR`：右侧气泡，显示“主审”及已知姓名。
- `RECORDER`：右侧气泡，显示“记录员”及已知姓名。
- `OFFICER_FALLBACK`：右侧气泡，统一显示“民警”。
- 尚无法稳定归属的片段只在右侧保持中性显示，不得错误写入正式问题。

右侧使用持久化 ASR fragment 历史，而不是只依赖当前未确认 fragment，因此刷新页面后仍应恢复本次对话。

`partialText` 只显示“正在识别”状态，只有 final fragment 才驱动问题检测、匹配和正式回答写入。

## 4. 审讯开始前的模板准备

系统不会根据案件类型自动把大量变量问题写入左栏。

民警可以主动准备本案正式问题，支持三种入口：

1. 从按案件类型分类的常用问题库勾选。
2. 手动打字。
3. 录音输入：录音 → FunASR 最终转写 → 写入问题输入框 → 民警可修改 → 点击“加入本案问题”。

录音识别结果不得未经确认直接创建正式问题。

全局问题库采用“一套通用基础模板 + 分类常用问题库”，案件分类仅用于人工筛选，不自动注入本案模板。

## 5. 问句判定

民警的一条 final ASR fragment 首先经过“是否为实际问题”的低风险规则判定。

以下类型不触发模板匹配，也不结束当前嫌疑人回答轮次：

- “继续说。”
- “声音大一点。”
- “你继续讲。”
- 简单确认、过渡语、设备操作指令。

实际问句可通过问号、疑问词和常见问句句式识别，例如：什么时候、何时、几点、谁、哪里、为什么、怎么、是否、有没有、多少等。

问句判定必须完全离线、确定性、可测试。

## 6. 正则匹配

每个可匹配正式问题维护：

- 当前正式显示文本。
- 历史别名。
- 一组明确的 regex pattern。

用户修改正式问题文字后，旧文本进入历史别名；已有匹配规则继续保留，必要时允许人工维护规则。

匹配流程：

1. 对民警完整 final utterance 做低风险归一化（空白、中文/英文问号等），不改变事实内容。
2. 不拆分 utterance。
3. 对当前案件所有有效正式问题运行 regex。
4. 结果为：
   - 0 个：`UNMATCHED`。
   - 1 个：`MATCHED`，可以自动建立关联。
   - 2 个及以上：`AMBIGUOUS`，严禁自动选择。

系统采取“宁可不匹配，也不激进错配”的策略。

## 7. 未匹配问题与回答缓冲

当民警说出一个真实问题，但没有匹配任何正式问题时：

- 右侧该民警气泡显示：`未匹配正式笔录问题`。
- 提供：`加入本案笔录`、`忽略`。
- 后续嫌疑人回答不会丢失，而是进入该未匹配问题的临时回答缓冲。

选择“加入本案笔录”：

1. 创建 `LIVE` 本案问题。
2. 默认插入当前问题后。
3. 创建该问题第 1 个问答轮次。
4. 把已缓存嫌疑人回答整体挂入该轮。
5. 后续嫌疑人 final fragment 继续自动追加。

选择“忽略”：

- 问答仍完整保留在右侧原始对话。
- 不进入正式笔录。

默认动态新增只影响当前案件。

另提供独立动作“保存为标准模板问题”，只有民警主动操作时才写入全局问题库，避免单案临时追问污染标准模板。

## 8. 多重匹配

如果一条真实民警问题同时命中两个或更多已有正式问题：

- 不自动关联。
- 右侧显示“匹配到多个正式问题”。
- 民警可以：
  - 选择其中一个已有问题；
  - 新建本案问题；
  - 忽略正式笔录关联。

在人工决定前，后续嫌疑人回答进入临时缓冲。

## 9. 同一问题的多轮问答

模板问题与实际问话实例必须分开建模。

例如同一个“何时到达现场”的正式问题，可以存在：

- 第 1 轮：第一次到现场。
- 第 2 轮：第二次返回现场。
- 第 3 轮：第二天再次到现场。

系统绝不能自动把这些答案揉成一个事实。

当同一正式问题再次被问到时，民警选择：

1. `追加到原回答`；或
2. `新增一轮问答`。

左栏同一问题下将多个轮次折叠显示，默认突出最新轮次。

折叠仅是 UI 行为；正式 PDF/Word 导出时，所有轮次全部展开，并按真实发生时间排序。

## 10. 回答自动写入

一旦某条民警问句建立了明确关联：

1. 创建/激活对应 `QuestionRound`。
2. 之后每个嫌疑人 final ASR fragment 自动追加到该轮 `answer_text`。
3. 普通民警指令不会结束该轮。
4. 出现下一条有效民警问题时，当前回答轮次结束或进入待选择状态。

不再要求每条嫌疑人发言点击“确认写入正式笔录”。

左栏回答始终允许民警直接编辑修正。

## 11. 重新关联兜底

任何自动匹配都必须提供轻量的“重新关联”能力。

对某个问答轮次，民警可以：

- 移动到另一个已有正式问题；
- 创建一个新的本案问题并移动过去；
- 取消该轮进入正式笔录。

整轮的实际问话文本和回答一起迁移，不丢失、不复制。

右侧原始 ASR 对话永远不因重新关联而修改。

## 12. 数据模型

### 12.1 StandardQuestion

全局可复用问题库：

- `id`
- `text`
- `category`
- `regex_patterns_json`
- `aliases_json`
- `sort_order`
- `active`
- timestamps

### 12.2 CaseQuestion

当前案件左栏正式问题：

- `id`
- `case_id`
- `source`: `STANDARD | CASE | LIVE`
- `standard_question_id` nullable
- `text`
- `regex_patterns_json`
- `aliases_json`
- `sort_order`
- `active`
- timestamps

### 12.3 QuestionRound

正式问题下的实际问答轮次：

- `id`
- `case_id`
- `session_id`
- `case_question_id`
- `round_no`
- `actual_question_text`
- `officer_fragment_id` nullable
- `answer_text`
- `status`: `ACTIVE | CLOSED | DETACHED`
- `started_at`
- `ended_at`
- timestamps

### 12.4 PendingQuestion

未匹配或多重匹配时的临时状态：

- `id`
- `case_id`
- `session_id`
- `officer_fragment_id`
- `question_text`
- `match_status`: `UNMATCHED | AMBIGUOUS`
- `candidate_question_ids_json`
- `buffered_answer_text`
- `buffered_fragment_ids_json`
- `status`: `PENDING | ADDED | LINKED | IGNORED`
- timestamps

所有由 ASR fragment 驱动的处理接口必须以 fragment id 做幂等保护，页面刷新/WebSocket 重连不能重复创建问题或重复追加回答。

## 13. API 边界

建议新增模板工作台 API：

- `GET /api/v1/cases/{case_id}/template-workspace`
- `GET /api/v1/question-library`
- `POST /api/v1/cases/{case_id}/questions`
- `PATCH /api/v1/cases/{case_id}/questions/{question_id}`
- `POST /api/v1/cases/{case_id}/questions/reorder`
- `POST /api/v1/cases/{case_id}/speech-fragments/{fragment_id}/process`
- `POST /api/v1/cases/{case_id}/pending-questions/{pending_id}/add`
- `POST /api/v1/cases/{case_id}/pending-questions/{pending_id}/link`
- `POST /api/v1/cases/{case_id}/pending-questions/{pending_id}/ignore`
- `POST /api/v1/cases/{case_id}/rounds/{round_id}/reassociate`
- `PATCH /api/v1/cases/{case_id}/rounds/{round_id}`
- `POST /api/v1/cases/{case_id}/questions/{question_id}/save-to-library`

右侧对话历史复用现有 ASR fragment 持久化接口，并读取 `include_confirmed=true`。

## 14. 实时状态机

一条新 final ASR fragment 的处理：

### 14.1 嫌疑人 fragment

- 有活动 `QuestionRound` → 幂等追加到 `answer_text`。
- 有活动 `PendingQuestion` → 幂等追加到其 buffer。
- 都没有 → 只保留右侧原始对话，不擅自写入左栏。

### 14.2 民警 fragment

- 不是实际问题 → 只保留右侧，当前回答上下文保持不变。
- 是实际问题 → 运行模板匹配：
  - 单匹配 → 进入该问题；如果已有历史轮次，由 UI 决定“追加旧回答/新建轮次”。
  - 无匹配 → 创建 `PendingQuestion(UNMATCHED)`。
  - 多匹配 → 创建 `PendingQuestion(AMBIGUOUS)`。

如果上一轮已经明确结束，先关闭上一 `ACTIVE` round；如果当前新问题需要人工选择，则后续嫌疑人回答进入新 pending buffer，而不是继续写入上一轮。

## 15. 前端组件结构

避免继续扩张现有约 38KB 的 `InterrogationPage.vue`，新架构应拆分：

- `TemplateDrivenInterrogationPage.vue`：两列容器和工作流编排。
- `FormalTemplatePanel.vue`：固定字段、问题列表、折叠轮次、编辑/排序。
- `LiveDialoguePanel.vue`：实时气泡、pending 操作、自动滚动。
- `QuestionPreparationPanel.vue`：审讯前问题库/打字/录音输入。
- `utils/templateInterrogation.ts`：纯展示映射和状态辅助，便于 Vitest。

原 `InterrogationWorkspace.vue` 只负责把 store/session/capture 接入新页面，不承担匹配业务。

## 16. 签名、冻结与导出

现有案件 AI 梳理、结束审讯、文档冻结、电子签名能力必须保留，但从旧右侧操作栏迁移到左侧正式笔录工具区/底部确认区。

冻结/签名前使用新的正式模板 + `QuestionRound` 生成 document snapshot。

导出规则：

- UI 折叠状态不影响导出。
- 所有正式轮次展开。
- 按 `started_at` 真实发生时间排序。
- 被 `DETACHED` 或被明确忽略的问答不进入正式输出。
- 右侧原始对话仍保留用于核对和审计。

## 17. 旧逻辑迁移

新 C 页不再呈现：

- `markTranscriptMessage`
- contradiction/conflict 数量和按钮
- low-confidence 正式笔录标签
- suspicion/pending/highlight 类业务标记
- “每个 ASR 片段人工确认后才写正式记录”的旧主流程

旧 Message/Revision 数据暂不做破坏性删除，以保证已有案件兼容；新模板工作台读取新的 CaseQuestion/QuestionRound 结构。后续可独立设计历史数据迁移，不在本次 UI 重构中强制重写旧案件。

## 18. 基础模板来源

基础模板必须基于此前 5 份真实模板中已经确认的共同部分，不允许开发阶段凭空创造法律/业务问题。

当前明确可固化的共同格式包括：询问笔录抬头、时间、地点、询问人、记录人、被询问人身份和正式问答区。

具体标准问题 seed 应从此前提取结果或可追溯的模板资料导入；如果某个问题无法确认来源，则先作为可配置问题库数据，不猜测为“强制固定问题”。

## 19. 测试策略

### Backend

- 问句/非问句判定。
- 单匹配、无匹配、多匹配。
- 完整复合 utterance 不拆分。
- 未匹配回答缓冲与“加入/忽略”。
- 同一问题多轮与人工选择。
- fragment 幂等处理。
- 重新关联整轮迁移。
- 问题编辑保留 alias。
- 问题排序。
- Alembic 0003 upgrade/downgrade。
- API contract。

### Frontend

- speaker → bubble side/role mapping。
- formal question + folded rounds view-model。
- unmatched/ambiguous action state。
- partial text 不驱动正式模板。
- 右侧自动滚动/“最新消息”行为。
- 审讯前文字与录音问题输入。
- Vue typecheck / build。
- Browser screenshot QA。

### Regression

现有身份录入、声纹注册、审讯 session start/pause/resume/finish、ASR capture、AI 梳理、冻结/签名必须继续通过。

## 20. 实施顺序

1. 纯函数问句判定与保守正则匹配（TDD）。
2. 0003 数据模型、repository、service、API（TDD）。
3. ASR fragment 幂等工作流接入。
4. 前端 runtime/API/store 类型和数据读取。
5. 新两列组件与审讯前问题准备。
6. 移除新 C 页旧标记交互并迁移签名/冻结入口。
7. 导出/快照适配新轮次结构。
8. 全量 CI + 浏览器视觉验收 + RK3588 smoke。

## 21. 验收主场景

1. 民警审讯前从常用库勾选问题，手动加入一个问题，再通过录音转文字加入一个问题。
2. 开始审讯；右侧实时显示民警/嫌疑人气泡。
3. 民警问固定问题 → 单一正则匹配 → 左侧创建/激活问答轮次。
4. 嫌疑人连续回答两段 → 自动追加到当前回答。
5. 民警说“继续说” → 只出现在右侧，回答上下文不切换。
6. 民警问模板外问题 → 右侧显示“加入本案笔录/忽略”，嫌疑人先回答也不会丢。
7. 点击加入 → 新问题插在当前问题后，缓存回答自动挂入。
8. 再次问同一模板问题 → 选择“新增一轮”，左侧同一问题出现折叠第 2 轮。
9. 人工发现匹配错误 → 重新关联整轮。
10. 结束审讯 → 导出时全部轮次按真实时间展开 → 冻结 → 签名。
