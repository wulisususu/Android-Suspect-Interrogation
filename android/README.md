# Android APK 内置业务后端（M0/M1）

这一目录是正式产品 Android 宿主，不是另起 Node/Termux 服务。

```text
一个 APK
├─ WebView：加载 webapp/dist
├─ window.NativeBridge
├─ Kotlin RpcRouter
├─ Case / Session / Record / Revision / Fact / Timeline / Audit Service
├─ Room
├─ SQLCipher
└─ Android Keystore
```

APK 内不监听 `localhost:8080`。`backend-dev/` 仅用于电脑浏览器开发联调。

已实现 `case.*`、`session.*`、`record.*`、`fact.list`、`timeline.list`、`audit.list`、`ai.settings.*` 和 `ai.inquiry`。云端 AI 由 Android 内的 `AiRouter` 调用，`backend-dev/` 不会进入 APK。

## 本地模型前置接口

`ModelManager` 管理以下 App 私有目录：

```text
files/models/asr/
files/models/vad/
files/models/speaker/
files/models/llm/
```

应用启动只做后台扫描，没有模型或扫描失败都不会阻止进入。WebView 通过 `model.scan`、`model.list`、`model.select` 和 `model.import.request` 管理模型；导入使用安卓系统文件管理器，文件或目录会复制到对应私有目录。压缩包只登记，不自动解压。

“已导入 / 已选择”和“Runtime 可运行”是不同状态。`LocalLlmRuntime` 是后续 JNI、RKNN、ONNX Runtime 或 llama.cpp 的接入点；默认实现始终不可用，因此当前不会把存在的模型文件误报为已经可以本地推理。

构建前先执行：

```bash
cd webapp
npm install
npm run build
```

再使用 Android Studio 打开 `android/`。Android `preBuild` 会把 `webapp/dist` 同步进 APK assets；如果 `dist` 不存在会直接失败。
