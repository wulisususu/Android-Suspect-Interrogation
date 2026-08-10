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

已实现 `case.*`、`session.*`、`record.*`、`fact.list`、`timeline.list`、`audit.list`。`device.action` 和 `ai.inquiry` 当前明确返回未接入，不伪造成功，也不把临时云 API 写死进 APK。

构建前先执行：

```bash
cd webapp
npm install
npm run build
```

再使用 Android Studio 打开 `android/`。Android `preBuild` 会把 `webapp/dist` 同步进 APK assets；如果 `dist` 不存在会直接失败。
