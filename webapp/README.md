# 嫌疑人审核工作台 WebApp

`webapp/` 是正式 Vue 3 + TypeScript 前端源码。

正式 Android APK 检测到 `window.NativeBridge` 后，案件、审讯、问答、修订、事实、时间线和设备调用直接走 `Vue → NativeBridge → Kotlin → Room/SQLCipher`，不会请求 `127.0.0.1:8080`。

电脑浏览器没有 NativeBridge 时，默认通过 Vite 同源代理连接 `backend-dev/`；也可以用 `VITE_API_BASE_URL` 显式覆盖地址。

AI 设置组件会按运行环境自动选择后端：浏览器通过 `backend-dev` 配置并联调智谱 API，Android APK 通过 NativeBridge 使用 Kotlin `AiRouter`。两个环境都不会向页面回显 API Key；未接本地 Runtime 时会明确显示本地模型不可用。

构建给 Android：

```bash
npm install
npm run build
```

Vite 已改用相对资源路径，Android `preBuild` 会把 `dist/` 同步进 APK assets。
