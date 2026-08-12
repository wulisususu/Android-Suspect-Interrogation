# Android 完全离线 RKLLM 模型管理与推理设计

## 1. 目标与边界

在现有 Android APK 和内嵌 WebView 中增加完全离线的 LLM 模型管理、模型切换、流式生成和取消能力。推理直接发生在 App 进程内，由 Kotlin 调用 JNI，再由 JNI 调用 RKLLM runtime 1.3.0；不得调用 HTTP Server、云端 LLM、Python 或 Termux。

本次只修改 LLM 和必要的通用 ModelManager、NativeBridge、WebView 接口。现有 ASR、OCR、录音、临时片段和正式入库链路保持不变。已有云端 AI 能力不删除，但 LLM RPC 以及 `LOCAL`、`OFFLINE_ONLY` 路径绝不访问网络。

成功标准：

- App 没有 LLM 模型或没有模型目录权限时仍可正常启动和使用非 LLM 功能。
- `/sdcard/models/` 中的 RK3576 与 RK3588 `.rkllm` 文件均可显示。
- RK3576 设备只能选择和运行完整的 RK3576 模型。
- 任意时刻最多一个 native LLM handle、一次初始化或一次生成。
- 模型切换、WebView/Activity 销毁和显式释放会完整销毁旧 handle。
- WebView 能收到生成分片、取消生成，并在取消后再次生成。
- WebView 和 RPC JSON 不含真实绝对文件路径。
- Android JVM 测试、Vue TypeScript 检查、Web 生产构建和 Android 构建通过。
- APK 安装至 `192.168.2.81:5555`，对 3 个中文 prompt 完成真机推理，并用 RKLLM/RKNPU 日志或系统负载证据确认 NPU 参与。

## 2. 已核验基线

目标设备：

- ABI：`arm64-v8a`
- `ro.board.platform`：`rk3576`
- `ro.hardware`：`rk30board`
- `ro.product.device`：`rk3576_u`
- 模型目录：`/sdcard/models/`

模型实物：

| 模型 | 字节数 | SHA-256 | 目标平台 |
| --- | ---: | --- | --- |
| `LegalOne-4B_W8A8_RK3576.rkllm` | 4,862,583,588 | `5ae25909ed3cca698a9adbbc6d243c9a4790dd4b599a45f3901f601b9b7ad0ec` | RK3576 |
| `LegalOne-4B_W8A8_RK3588.rkllm` | 4,849,163,100 | `61d082a4694b9cb1002f812baf4f3c9686d1fabe751da13ac7c08af7fb9dd14b` | RK3588 |

真机 RK3576 文件与服务器文件的大小和 SHA-256 一致。

runtime 实物来自服务器 `/home/mm/yy3588/rknn-llm-release-v1.3.0`：

| 文件 | 字节数 | SHA-256 |
| --- | ---: | --- |
| `librkllmrt.so` | 8,767,960 | `84b247f2efe16096551698f2d21ab4340a4663a2c7ef03773a8ef0b441668e55` |
| `libomp.so` | 954,680 | `1c4db1866bef4228365dc2a44264f7452b9f7af35e100bcbecf05c24b02bfe6f` |

JNI 只使用同一 release 中的 `rkllm.h` 和 `llm_demo.cpp` 作为 API 与调用时序参考。

当前安装包的 App UID 对 `/sdcard/models/` 读写测试均失败，错误为 `Permission denied`。因此不能把 ADB shell 可访问误判为 App 可访问。

## 3. 总体架构

采用 App 进程内同步 `rkllm_run` 方案：

```text
AiSettingsPanel / LlmConsole
        │ RPC + native events
        ▼
NativeBridge ── RpcRouter
        │           │
        │      LlmController ── LlmSettingsStore
        │           │
        │      LlmEngineSwitcher
        │           │
        │       RkllmEngine
        │           │ JNI
        └──── llm.fragment/status ◄── rkllm_jni.cpp
                                      │
                             librkllmrt.so 1.3.0
                                      │
                   /sdcard/models/*.rkllm → RK3576 NPU
```

`LlmController` 是生命周期和并发的唯一入口。ModelManager 负责文件发现和选择持久化，但 LLM 选择必须委托给 `LlmController.selectModel()`，以保证旧引擎在选择切换前释放。其他代码不得直接创建 `RkllmEngine`。

## 4. 模型目录、权限与导入

### 4.1 唯一 LLM 目录

所有 LLM 模型统一存放于 `/sdcard/models/`。不扫描 App 私有目录中的 LLM，不把 `.rkllm` 打入 APK，也不在私有目录保留第二份副本。ASR/OCR 继续使用现有规则。

### 4.2 Android 存储权限

Manifest 增加 `android.permission.MANAGE_EXTERNAL_STORAGE`。MainActivity 负责检查 `Environment.isExternalStorageManager()`，并通过 `Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION` 引导用户授权。

权限行为：

- App 启动不强制弹窗，也不因未授权而退出。
- 用户进入 LLM 管理、扫描或导入时，若无权限，UI 显示明确状态并提供“授权模型目录”按钮。
- 授权结果回到 App 后重新扫描。
- 未授权时 `llm.generate` 返回 `LLM_STORAGE_PERMISSION_REQUIRED`，绝不退回云端或私有模型副本。
- 真机部署时可由 UI 完成授权；ADB 仅用于自动化部署后的授权确认，不把 shell 权限当作 App 权限。

### 4.3 扫描与识别

`LlmModelProbe` 只接受 `/sdcard/models/` 顶层的普通 `.rkllm` 文件，忽略隐藏文件、目录、`.part` 和 `.importing-*`。识别字段包括格式、provider、目标平台、完整性和平台匹配状态。

规则：

- `.rkllm` 的 `modelFormat` 为 `RKLLM`，provider 为 `RKLLM / RK3576 NPU`。
- 文件名含 `RK3576` 时目标平台为 RK3576；含 `RK3588` 时目标平台为 RK3588。
- 两个已知 LegalOne 文件必须与上表的精确字节数一致才标记完整。
- 未知 `.rkllm` 可以显示，但目标平台为 `UNKNOWN`，本次不允许选择或初始化，避免把未知模型交给错误 runtime。
- 可运行条件为：文件可读、完整、目标平台 RK3576、设备平台 RK3576、runtime 版本 1.3.0 已随 APK 安装。
- RK3588 模型在 RK3576 上显示为 `PLATFORM_MISMATCH`，`runtimeReady=false`。

### 4.4 导入

LLM 仍从现有 Android 系统文件选择器进入，但目标目录改为 `/sdcard/models/`：

1. 在目标目录创建 `.importing-<uuid>.part`。
2. 使用 ContentResolver 流式复制，避免把 4.6 GB 文件读入内存。
3. 复制后校验实际字节数及已知模型预期大小。
4. 在同一文件系统内重命名为最终 `.rkllm` 文件名。
5. 重新扫描，不自动选择、不自动初始化。

若同名文件大小相同，直接复用已有文件并重新扫描；若同名但大小不同，返回 `MODEL_IMPORT_NAME_CONFLICT`，不覆盖现有模型。失败或取消时只删除本次 `.part` 文件。

## 5. Kotlin 领域模型与生命周期

新增或明确以下类型：

- `LlmModelSpec`：内部模型 ID、显示名称、内部绝对路径、格式、provider、目标平台、完整性。
- `LlmGenerationConfig`：`maxNewTokens`、`maxContextLen`；默认值分别为 64 和 1024，与已验证 demo 命令一致。
- `LlmInput`：prompt、role，当前 role 固定为 `user`，单次生成不保留 KV 历史。
- `LlmInitializationMetrics`：初始化耗时。
- `LlmResult`：输出、结束状态、分片、可用时的 token ID、模型、provider、配置和耗时、错误。
- `LlmRuntimeStatus`：选择模型、活动模型、权限、初始化、繁忙、当前生成 ID、指标和错误状态。

接口保持简洁：

```kotlin
interface LlmEngine {
    val modelSpec: LlmModelSpec
    suspend fun initialize(): LlmInitializationMetrics
    suspend fun generate(input: LlmInput): LlmResult
    suspend fun cancel()
    fun release()
}
```

`LlmEngineSwitcher` 永远只持有一个 engine：

- 选择同一模型且 `maxContextLen` 未变化时复用当前 engine。
- 模型或 `maxContextLen` 变化时，先取消生成并完整 `release()` 旧 engine，再创建新 engine。
- 新模型初始化失败后不恢复旧 engine，状态明确为未初始化，避免两个大模型短暂共存。
- `release()` 幂等，完成后清空引用。

`LlmController` 使用互斥锁保护状态转换，并使用原子 busy 状态快速拒绝重复生成。初始化和同步 `rkllm_run` 在专用单线程 native dispatcher 执行，WebView 主线程不被阻塞。`cancel()` 可从独立 IO 协程调用 native abort，不等待持有生成互斥锁。

模型选择保存在现有 `local_model_settings` SharedPreferences。生成配置保存在新的 LLM SharedPreferences，不升级 Room 数据库，因此现有 Room schema 与数据不变。重启 App 后恢复选择和配置，但 engine 仍按需初始化，不在启动时加载 4.6 GB 模型。

## 6. JNI/native 设计

Android 工程增加 CMake 构建的 `rkllm_jni` wrapper，并把下列真实文件放入 `jniLibs/arm64-v8a/`：

- release-v1.3.0 `librkllmrt.so`
- release-v1.3.0 `libomp.so`
- App 自行编译的 `librkllm_jni.so`

仅保留 `arm64-v8a` ABI。C++ wrapper 直接包含同版本 `rkllm.h`，按官方 demo 顺序调用：

1. `rkllm_createDefaultParam`
2. 设置模型路径、`max_context_len`、`max_new_tokens`、采样参数和 `embed_flash=1`
3. `rkllm_init`
4. `rkllm_run`
5. 取消时 `rkllm_abort`
6. 释放时 `rkllm_destroy`

每个 native wrapper 包含 handle、JavaVM、callback 全局引用、运行状态、取消状态及生命周期同步对象。callback 需要时附着 JVM 线程，把 UTF-8 text fragment、可用 token ID、call state 和 perf 数据复制到 Kotlin；不得在 callback 返回后持有 RKLLM 提供的临时指针。

销毁流程为：标记 releasing → 若运行则 abort → 等待同步 `rkllm_run` 返回 → 清空 handle → 调用一次 `rkllm_destroy` → 删除 JNI global ref。重复 destroy 只返回已释放状态，不再次调用 runtime。

首分片耗时由 Kotlin 从调用 `rkllm_run` 到第一个非空 callback 计算。总推理耗时从调用前到 `rkllm_run` 返回计算。token ID 仅在 runtime 回传有效值时收集，否则最终 JSON 为 null；文本分片始终保留。

## 7. RPC、事件与路径隔离

增加：

- `llm.status`
- `llm.storage.permission.request`
- `llm.model.list`
- `llm.model.select`
- `llm.chat`
- `llm.generate`
- `llm.cancel`
- `llm.release`

统一模型接口继续有效：

- `model.scan`
- `model.list`
- `model.select`
- `model.import.request` / 内部 `model.import`

`model.select(category=LLM)` 与 `llm.model.select` 调用同一 `LlmController.selectModel()`；不得绕过引擎释放逻辑。`llm.chat` 接收单个用户消息并委托 `llm.generate`，不在 native 层维护跨请求会话历史。现有 `LocalAiProvider` 改为委托同一个 LlmController。

`llm.storage.permission.request` 由 NativeBridge 在主线程启动 Android 设置页；它只负责发起授权，返回 App 后由 MainActivity 触发重新扫描。`llm.model.list` 只返回统一目录中的 LLM 条目，结构与 `model.list` 中的 LLM 子集一致。

`llm.generate` 请求为 `{ generationId, prompt, maxNewTokens, maxContextLen }`；`llm.chat` 请求为 `{ generationId, message, maxNewTokens, maxContextLen }`。generationId 由前端创建，prompt/message 必须为非空文本。两个整数经校验后持久化为下次默认配置；缺省时使用已保存配置。

`llm.generate` RPC 在 IO 协程等待最终结果，同时 NativeBridge 发送事件：

```json
{
  "name": "llm.fragment",
  "payload": {
    "generationId": "客户端生成的唯一 ID",
    "text": "本次分片",
    "accumulatedText": "当前累计输出",
    "tokenId": null,
    "elapsedMs": 1234
  }
}
```

状态变化发送 `llm.status`。前端在发起 RPC 前注册事件监听；由于控制器只允许一个生成任务，generationId 同时用于忽略迟到事件。`llm.cancel` 由另一个 RPC 协程并发执行。

最终 `LlmResult` JSON 至少包含：

- `outputText`
- `finished`
- `fragments`
- `tokenIds`（不可用时 null）
- `modelName`
- `provider`
- `maxNewTokens`
- `maxContextLen`
- `initializationMs`
- `firstTokenLatencyMs`（无分片时 null）
- `totalInferenceMs`
- `error`（成功时 null）

内部 `LocalModelDescriptor.absolutePath` 可保留给 Kotlin 使用，但所有模型 JSON 序列化统一省略 `absolutePath`。`rootPath` 对 WebView 返回固定显示文案“Android 设备模型目录”，不返回 `/sdcard/models/` 或 App 私有路径。前端类型删除绝对路径字段。

## 8. WebView 界面

在现有 `AiSettingsPanel.vue` 的“本地模型”页中增加 LLM 分类和 `LlmConsole`，不创建新项目或新窗口。

界面显示：

- 当前模型、provider、完整性、目标平台和可运行状态
- 授权模型目录、扫描、导入、选择
- `max_new_tokens` 和 `max_context_len`
- Prompt 输入、开始、停止和释放按钮
- 初始化、首分片和总推理耗时
- 独立滚动的流式输出区和错误区

弹窗本身保持固定最大高度；模型列表与 LLM 输出使用内部滚动区域，使开始/停止按钮无需把整个页面滚动到底。浏览器联调只显示不可运行说明，不伪造本地推理结果。

## 9. 并发与错误处理

主要错误码：

- `LLM_STORAGE_PERMISSION_REQUIRED`
- `LLM_MODEL_NOT_SELECTED`
- `LLM_MODEL_NOT_FOUND`
- `LLM_MODEL_INCOMPLETE`
- `LLM_PLATFORM_MISMATCH`
- `LLM_MODEL_UNSUPPORTED`
- `LLM_GENERATION_BUSY`
- `LLM_INITIALIZATION_FAILED`
- `LLM_RUN_FAILED`
- `LLM_CANCELLED`
- `LLM_RELEASED`

重复点击行为：

- 第一个 generate 在初始化前原子占用唯一生成任务槽；无论它处于初始化还是推理阶段，后续 generate 都立即返回 `LLM_GENERATION_BUSY`，不复用任务，也不创建第二个 engine。
- cancel 可重复调用；没有生成时返回当前空闲状态。
- cancel 完成后 busy 清零，可以再次 generate。
- release 可重复调用；生成期间 release 先 abort 再等待并销毁。

日志使用统一 tag，记录模型显示名称、provider、文件大小、runtime 1.3.0、初始化耗时、首分片耗时、总推理耗时、返回码和 generationId。日志不输出 prompt 全文或绝对路径；发生 `rkllm_run` 崩溃时，现场采集报告另行记录模型名、prompt、配置、runtime 版本与 crash log。

## 10. 测试与真机验收

严格按红—绿—重构顺序实现：

### JVM/Android 单元测试

- `.rkllm` 扫描、RKLLM 格式和 provider。
- 两个 LegalOne 文件的目标平台与精确大小完整性。
- RK3576 设备允许 RK3576，拒绝 RK3588 和未知平台模型。
- 缺失、不可读、部分模型文件。
- 选择持久化与无模型启动。
- 切换时先 release 旧 engine；任意时刻最多一个 engine。
- 重复生成保护、cancel 后再次 generate、幂等 release。
- `LlmResult`、fragment、status 和模型目录 JSON 不泄露绝对路径。
- 原有设置与 Room schema 不升级、不破坏。

### 前端与构建

- `npm run typecheck`
- `npm run build`
- Android JVM tests
- Android debug APK 构建
- 检查 APK 只有 arm64-v8a，且含 `librkllmrt.so`、`libomp.so`、`librkllm_jni.so`，不含 `.rkllm`。

### 真机

1. `adb install -r` 安装 APK。
2. 用 App UID 而非 shell 确认 `/sdcard/models/` 可读。
3. 确认扫描结果、平台不匹配显示、选择持久化。
4. 对至少 3 个中文 prompt 生成，记录初始化、首分片、总耗时和输出。
5. 采集 `logcat`、进程 CPU、`dumpsys meminfo`、设备可用的 RKNPU load 节点或 RKLLM performance 日志。
6. 只有观察到 RKLLM/RKNPU 证据时才报告“已确认走 RK3576 NPU”。
7. 生成中取消，再次生成；显式 release、切换和 Activity 销毁后确认旧模型释放且无残留进程。
8. 重启 App，确认模型选择仍保留且不会启动即加载模型。

最终报告 APK 绝对路径、文件大小、SHA-256、runtime 和 native 库清单、模型位置与哈希、provider、NPU 证据、修改文件、自动化与真机测试结果，以及仍需现场验证的限制。

## 11. 不做事项

- 不转换或重新量化模型。
- 不引入 llama.cpp、ONNX、RKNN 作为 `.rkllm` runtime。
- 不使用 1.2.x header 或 shared library。
- 不实现多模型并存、batch、多轮 KV 历史、LoRA、prompt cache 或多模态。
- 不修改已有 ASR/OCR 模型内容和业务数据链路。
- 不提交 Git commit，除非用户另行明确要求。
