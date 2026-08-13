# Android Suspect Interrogation

嫌疑人审核 / 审讯 AI 一体机项目。

## 目录职责

- `android/`：**正式 Android APK 宿主和 Kotlin 业务后端**。业务数据库、Bridge、设备/AI 调度最终都在这里。
- `webapp/`：Vue 3 + TypeScript 正式前端。APK 内通过 `window.NativeBridge` 调 Kotlin；浏览器开发时可回退到 HTTP。
- `backend-dev/`：Node 22 + SQLite **开发联调工具**，只服务电脑浏览器调试和临时云端 AI 验证，不进入正式 APK 架构。
- `frontend/`：旧 APK 的 Apktool 展开产物，仅保留作历史 UI、壳层和兼容行为参考。

## 正式产品主链

```text
Android APK
  ├─ Vue WebView
  │    ↓ NativeBridge RPC
  ├─ Kotlin Domain / Service
  │    ↓
  ├─ Room + SQLCipher
  │    ↓
  ├─ Android Keystore
  │
  ├─ Device SDK / USB / Camera / Audio
  └─ AI / Local Runtime
       ├─ Cloud Provider：智谱 GLM
       ├─ Local LLM：LocalAiProvider → LlmController → RkllmEngine
       │    └─ RkllmNative → JNI / C++ → RKLLM 1.3.0 / librkllmrt
       ├─ ASR：sherpa-onnx → RKNN / ONNX Runtime
       └─ OCR：ONNX Runtime CPU（当前可运行链路）/ Paddle PIR（仅模型定义）
```

**正式 APK 不依赖 `localhost:8080`、Node、Termux 或外部 Linux 主机完成审讯主流程。**

## 当前阶段：Android M0/M1 + AI Provider Router

已完成的代码链路包括：

- Case
- Session：开始 / 暂停 / 恢复 / 结束
- 四阶段：身份核验 / 案情陈述 / 重点追问 / 确认签名
- Q/A
- Revision
- Fact 读取
- Timeline 读取
- 追加式 Audit
- Room
- SQLCipher
- Android Keystore
- NativeBridge RPC
- AI Provider / Router
- APP 内运行时切换 AI 模式，无需重新构建 APK
- RKLLM 1.3.0 Android Runtime 接入
- `RkllmEngine` / `RkllmNative` / JNI / C++ / `librkllmrt.so` 正式链路
- `LocalAiProvider` 通过 `ControllerLocalLlmRuntime` 接入 `LlmController`

### AI 模式

```text
CLOUD        -> 只使用智谱 API；未配置 API Key 时直接失败，不尝试本地模型
LOCAL        -> 只使用已选择且 runtimeReady 的本地 LLM；不可用时直接失败，不回退云端
AUTO         -> 本地可用时优先本地；本地运行失败且云端可用时允许回退智谱
OFFLINE_ONLY -> 只使用本地 LLM；本地不可用时明确失败，绝不访问或回退云端
```

`LOCAL` / `OFFLINE_ONLY` 是否可用，不只取决于“目录里存在 `.rkllm` 文件”：当前还要求模型已被识别为完整且与设备平台兼容、已经选择，并且 App 具备模型目录访问权限。

### 当前智谱 Provider 默认参数

```text
POST https://open.bigmodel.cn/api/paas/v4/chat/completions
model = glm-4.7
thinking.type = enabled
stream = true
max_tokens = 65536
temperature = 1.0
```

这些参数都可以在构建好的 Android APP 内通过“AI 设置”修改并立即生效。

智谱 API Key 不写死在源码或 APK 配置中：用户在 APP 内录入后，使用 Android Keystore + AES-GCM 加密保存；设置页面只返回“已配置 / 未配置”，不会回显 Key 明文。

## 本地 LLM / RKLLM

当前 Android 正式链路使用 **RKLLM Runtime 1.3.0**：

```text
LocalAiProvider
  ↓ ControllerLocalLlmRuntime
LlmController
  ↓ LlmEngineSwitcher
RkllmEngine
  ↓
RkllmNative
  ↓
librkllm_jni.so
  ↓
librkllmrt.so + libomp.so
```

`arm64-v8a` 的 RKLLM native libraries 已进入 Android 工程，JNI 由 `android/app/src/main/cpp/rkllm_jni.cpp` 和 CMake 构建。

### LLM 模型路径与识别

当前 LLM 的主要扫描 / 导入目录是：

```text
/sdcard/models
```

- App 导入 LLM 时只接受单个 `.rkllm` 文件，并写入 `/sdcard/models`。
- Android 11+ 当前通过 `MANAGE_EXTERNAL_STORAGE` 对应的外部存储管理权限判断该目录是否可用。
- `context.filesDir/models` 仍是应用通用模型根目录，但当前 `ModelCatalogScanner` 的 **LLM 分支只扫描配置的外部 LLM 根目录**，不要把它当成 LLM 的主要扫描路径。
- RKLLM 模型不会作为数 GB 资源直接内置进 APK。

当前 `LlmDevicePlatform` 会从 Android 的 SoC / device / board 信息识别 `RK3576` 或 `RK3588`；`LlmModelProbe` 也包含 RK3576 / RK3588 两个平台的模型识别和兼容性判断。目前已登记的 LegalOne-4B RKLLM 模型仍按已知文件名和精确文件大小判断完整性，因此不能把任意 `.rkllm` 文件视为“已支持”。

## ASR 当前状态

ASR 已进入 Android 正式 Controller / Engine 链路，当前内置两套模型定义：

- **Zipformer RKNN (RK3576)**：`models/zipformer_rk3576/`，`encoder.rknn + decoder.rknn + joiner.rknn + tokens.txt`，sherpa-onnx provider 为 `rknn`。
- **Paraformer INT8**：`models/paraformer_int8/`，`encoder.int8.onnx + decoder.int8.onnx + tokens.txt`，sherpa-onnx provider 为 CPU。
- 当前 sherpa-onnx 代码版本标记为 `1.13.4`。
- `AsrController` 已支持模型切换、启动 / 停止、partial / final result 和延迟状态。

这些 `.rknn` / `.onnx` 模型通过 Git LFS 管理，并作为 APK assets 参与构建。**代码链路已接入不等于实机已经全部验收完成**：RK3576 上的 RKNN provider、麦克风连续采集、长时间运行稳定性，以及 Paraformer 的实际延迟 / 准确率仍需要在目标设备上验收。

## OCR 当前状态

OCR 已有正式 `OcrController`，包括模型选择、图片导入 / 相机结果接入、预览资源和识别调用链。

- **PP-OCRv4 ONNX**：当前标记 `runtimeAvailable = true`，走 `onnxruntime-cpu`，对应 `OnnxPpocrV4Engine`。
- **PP-OCRv6 Small Paddle PIR**：模型定义已经存在，但当前标记 `runtimeAvailable = false`，不能写成已完成的 Paddle Inference Runtime。
- OCR 字典资源由 APK assets 提供；OCR 模型本身由模型管理目录扫描 / 选择。

相机拍照回传、不同图片格式、目标设备上的识别效果 / 性能仍需实机验收；README 不把这些项目描述为“已完成验收”。

## 仍需实机验收

当前源码能确认“链路已经接入”，但以下项目仍应以 RK3576 / RK3588 目标设备实测为准：

- RKLLM 1.3.0 native libraries 在目标系统镜像上的加载和 ABI / 驱动兼容性。
- LegalOne-4B RK3576 / RK3588 对应模型的实际初始化、首 Token、连续生成、取消和释放。
- RK3588 的平台识别与匹配模型完整推理链。
- Zipformer RKNN 的 NPU / RKNN Runtime 实际推理、连续录音稳定性。
- Paraformer INT8 的目标机实时性和准确率。
- PP-OCRv4 ONNX 的相机 / 图片输入、预览、识别结果与性能。

## 浏览器联调

电脑上仍可使用：

```bash
cd backend-dev
npm start
```

另开终端：

```bash
cd webapp
npm install
cp .env.example .env
npm run dev
```

浏览器中的“AI 设置”通过 `backend-dev` 保存到本机开发数据库，并可直接联调智谱 API；API Key 不会回显到页面。Vite 将同源的 `/api` 和 `/work` 请求转发到仅本机监听的后端，因此从局域网设备打开 `5173` 时不需要直接访问 `8080`。Windows 没有 Android RKLLM Runtime 和目标设备模型目录时，`LOCAL` / `OFFLINE_ONLY` 不代表能够在 Windows 浏览器环境直接运行 RKLLM。APK 内仍通过 NativeBridge/Kotlin 使用独立的 AI 路由设置。

## APK 构建

Git LFS 必须先把内置 ASR 模型 materialize 成真实二进制文件，不能用 132 / 133 / 134 Bytes 左右的 LFS pointer 参与打包。

```bash
git lfs install
git lfs pull

cd webapp
npm install
npm run build
```

然后用 Android Studio 打开 `android/` 构建 APK，或在已配置 Android SDK / Gradle 的环境中执行：

```bash
gradle -p android testDebugUnitTest
gradle -p android assembleDebug
```

Android 构建会自动把 `webapp/dist` 打进 APK assets。CI 会在构建前检查仓库工作树中的 `.onnx` / `.rknn` 是否仍为 Git LFS pointer，并在 `assembleDebug` 后再次检查 APK 内的必需 ASR assets、模型大小 / pointer 内容以及 `arm64-v8a` native libraries；任一检查失败都会阻止产生“看似成功但模型不可用”的构建结果。
