# Android Suspect Interrogation

嫌疑人审讯 / 案件细节核对项目。

## 当前目录

- `frontend/`：原 APK 的 Apktool 展开产物，继续保留用于 Android 壳、MultiScreen 和历史兼容。
- `webapp/`：Vue 3 + TypeScript + Vite 可维护前端，当前正式业务交互入口。
- `backend/`：根据 `webapp` 实际页面和点击行为反推出来的专属本地业务后端（Node 22 + SQLite，业务联调版）。

## 当前主链路

```text
警官点击
  -> Vue API adapter
  -> localhost:8080
  -> 案件 / 审讯状态 / 问答 / Revision / Audit / 设备反馈
  -> 需要 AI 时再代理到现有 DeepSeek / SSE 上游
```

当前优先完成“业务逻辑 + 真实点击反馈”，不替换已有 DeepSeek API。

## 为什么仓库里先有 Node 后端

这是前端驱动的业务联调层：不依赖厂商 Android SDK 即可先把页面每个关键点击、状态约束、SQLite 持久化、版本和审计链路验收掉。

正式一体机仍按技术设计迁移/落地为 Kotlin Domain/Service/Repository + Room/SQLCipher + Keystore + Native Device/AI Runtime。当前 HTTP API 和业务状态规则应保持稳定，从而降低前端二次改造成本。

## 启动

```bash
cd backend
npm start
```

另开终端：

```bash
cd webapp
npm install
cp .env.example .env
npm run dev
```

后端自测：

```bash
cd backend
npm run check
npm run smoke
```
