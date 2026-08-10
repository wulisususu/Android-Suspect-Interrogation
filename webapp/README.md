# 嫌疑人审核工作台 WebApp

`webapp/` 是正式 Vue 3 + TypeScript 前端源码。

正式 Android APK 检测到 `window.NativeBridge` 后，案件、审讯、问答、修订、事实、时间线和设备调用直接走 `Vue → NativeBridge → Kotlin → Room/SQLCipher`，不会请求 `127.0.0.1:8080`。

电脑浏览器没有 NativeBridge 时，继续使用 `VITE_API_BASE_URL` 连接 `backend-dev/`。

临时云端 AI 只保留在浏览器联调路径；正式 APK 的 `ai.inquiry` 当前明确返回 `AI_RUNTIME_NOT_CONFIGURED`。后续接本地 LLM Runtime 时只替换 Android `AiService`。

构建给 Android：

```bash
npm install
npm run build
```

Vite 已改用相对资源路径，Android `preBuild` 会把 `dist/` 同步进 APK assets。
