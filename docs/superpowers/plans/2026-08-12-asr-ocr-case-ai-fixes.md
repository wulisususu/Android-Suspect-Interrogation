# ASR、OCR 与案件 AI 隔离修复实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 修复 RK3576 真机 ASR 启动、OCR 预览与识别，并让正式 AI 分析严格按显式 `caseId` 读取和保存数据。

**Architecture:** AI 设置中的 LLM 控制台只做无业务数据的模型自检；新增案件分析服务和按案件持久化表，正式分析从当前案件 DAO 构造受约束上下文。ASR 使用同一官方 sherpa-onnx RKNN 发行包内彼此匹配的 native 库。OCR 图片复制到 App 缓存后通过 WebViewAssetLoader 的同源只读路径预览，并修正 PP-OCR RGB 张量预处理。

**Tech Stack:** Kotlin、Room/SQLCipher、JNI/ELF、sherpa-onnx RKNN、ONNX Runtime、Vue 3、Pinia、NativeBridge RPC。

---

### Task 1: 案件 AI 上下文与数据不足保护

**Files:**
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/CaseAiService.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/service/CaseAiServiceTest.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/service/AiProviders.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/RpcRouter.kt`

- [ ] 写失败测试：空记录和仅有民警问题时不得调用模型；A 的 Prompt 不得出现 B 的记录。
- [ ] 运行定向测试，确认因案件分析服务缺失而失败。
- [ ] 实现 `CaseAiContext`、受约束 Prompt 和 `CASE_AI_INSUFFICIENT_DATA` 前置校验。
- [ ] 让 `ai.inquiry` 必须接收 `caseId`，正式分析使用独立 `case.ai.generate`。
- [ ] 运行测试确认通过。

### Task 2: 案件分析持久化与界面职责分离

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/data/Entities.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/data/Daos.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/data/AppDatabase.kt`
- Create: `webapp/src/components/CaseAiAnalysisPanel.vue`
- Modify: `webapp/src/components/LlmConsole.vue`
- Modify: `webapp/src/views/InterrogationWorkspace.vue`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/types/interrogation.ts`

- [ ] 写 Room/服务测试，验证案件 A/B 分析按 `caseId` 隔离。
- [ ] 增加 `ai_case_analyses` 表、DAO 和 3→4 migration。
- [ ] 增加“生成本案 AI 推理”面板并显示当前案件号、结果、错误。
- [ ] 把设置页按钮改成“测试模型”，明确不读取、不保存案件数据。
- [ ] 执行 TypeScript 检查与 Room 测试。

### Task 3: 收紧所有案件相关 ASR 写入

**Files:**
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/data/Daos.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrCaptureSessionManager.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/bridge/RpcRouter.kt`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/stores/interrogation.ts`

- [ ] 写失败测试：使用案件 B 的 `caseId` 不能修改、确认或丢弃案件 A 的片段。
- [ ] 把所有外部片段操作改为 `caseId + fragmentId` 复合查询。
- [ ] 将只读服务中的自动 `ensure/create` 改为严格案件存在校验。
- [ ] 运行案件隔离测试。

### Task 4: 修复 sherpa-onnx / ONNX Runtime native 版本冲突

**Files:**
- Modify: `android/app/src/main/jniLibs/arm64-v8a/libsherpa-onnx-jni.so`
- Modify: `android/app/src/main/jniLibs/arm64-v8a/libsherpa-onnx-c-api.so`
- Modify: `android/app/src/main/jniLibs/arm64-v8a/libsherpa-onnx-cxx-api.so`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/asr/AsrController.kt`

- [ ] 用 `llvm-readelf` 记录当前失败证据：sherpa 需要 `VERS_1.27.1`、APK 只有 `VERS_1.27.0`。
- [ ] 使用官方 sherpa-onnx `v1.13.4-rknn.aar` 中与 ONNX Runtime 1.27.0 匹配的三项 sherpa native 库。
- [ ] 构建 APK 后验证 `OrtGetApiBase@VERS_1.27.0` 需求和提供方一致。
- [ ] 真机启动 Zipformer，确认 initialized/running、麦克风数据持续写入且无 dlopen 错误。

### Task 5: 修复 OCR 预览、RGB 预处理和空结果反馈

**Files:**
- Create: `android/app/src/main/java/com/wulisu/suspect/interrogation/ocr/OcrTensorPreprocessor.kt`
- Create: `android/app/src/test/java/com/wulisu/suspect/interrogation/ocr/OcrTensorPreprocessorTest.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/ocr/OcrController.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/ocr/OnnxPpocrV4Engine.kt`
- Modify: `android/app/src/main/java/com/wulisu/suspect/interrogation/MainActivity.kt`
- Modify: `webapp/src/components/OcrConsole.vue`

- [ ] 写失败测试：红色像素必须位于 RGB 第一个平面；新图片必须产生同源预览 URL。
- [ ] 通过 `/ocr-preview/current` 安全提供缓存图片，禁止把真实文件路径交给 WebView。
- [ ] 把检测和识别输入从 BGR 改成 PP-OCR 所需 RGB；竖向文本块分别尝试 90/270 度并选高置信度结果。
- [ ] 新图片清除旧结果；空识别显示“未检测到文字”；异常显示原始错误。
- [ ] 使用真机已有身份证照片回归预览、耗时、文本和块。

### Task 6: 构建和真机回归

**Files:**
- Modify only files required by failures discovered above.

- [ ] 执行 `npm run typecheck && npm run build`。
- [ ] 执行 Android 单元测试、instrumentation 编译和 APK 构建。
- [ ] 安装到 `192.168.2.81:5555`。
- [ ] 回归 ASR 启停、OCR 图片、空案件分析、A/B 案件隔离和模型测试标签。
- [ ] 核对 APK so、SHA-256、logcat 和工作树，不提交 Git。
