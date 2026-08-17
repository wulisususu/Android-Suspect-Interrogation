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

`ModelManager` 统一管理设备目录 `/sdcard/models/`：

```text
/sdcard/models/asr/
/sdcard/models/ocr/
/sdcard/models/vad/
/sdcard/models/speaker/
/sdcard/models/llm/
```

应用启动只做后台扫描，没有模型或扫描失败都不会阻止进入。WebView 通过 `model.scan`、`model.list`、`model.select` 和 `model.import.request` 管理模型；导入使用安卓系统文件管理器，文件或目录会复制到对应分类目录。压缩包只登记，不自动解压。LLM 新导入文件写入 `/sdcard/models/llm/`，同时兼容直接位于 `/sdcard/models/` 的旧部署。

“已导入 / 已选择”和“Runtime 可运行”是不同状态。当前 APK 已接入 Zipformer RKNN、Paraformer INT8、PP-OCRv4 ONNX 和 RKLLM 1.3.0；模型扫描仍会按设备平台、文件完整性和 Runtime 支持情况区分 `complete` 与 `runtimeReady`。PP-OCRv4 目录还必须包含 `ppocr_keys_v1.txt`。PP-OCRv6 Paddle PIR 压缩包目前只可检测，尚无可运行 Runtime。

构建前先执行：

```bash
cd webapp
npm install
npm run build
```

再使用 Android Studio 打开 `android/`。Android `preBuild` 会把 `webapp/dist` 同步进 APK assets；如果 `dist` 不存在会直接失败。
