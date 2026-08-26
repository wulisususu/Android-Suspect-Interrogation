# 嫌疑人审核工作台 WebApp

`webapp/` 是 Linux Kiosk 的正式 Vue 3 + TypeScript 前端。

生产环境默认通过 `LinuxHttpWsAdapter` 调用同机 FastAPI 的 REST `/api/v1` 与 WebSocket `/ws/interrogation/{session_id}`。前端不包含移动端 NativeBridge 或 Kotlin/Room 兼容路径。

开发模式可通过 `VITE_RUNTIME_MODE=browser-dev` 使用 `BrowserDevAdapter`；未显式指定时始终选择 `linux-http-ws`。

## 开发

```bash
npm ci
npm run dev
```

## 验证

```bash
npm test
npm run typecheck
npm run build
```

正式部署由 FastAPI 静态挂载 `webapp/dist`，或由 Kiosk 启动脚本加载同机服务。
