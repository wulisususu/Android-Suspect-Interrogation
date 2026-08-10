# Vue 审讯工作台 + 专属业务后端

`webapp/` 是当前可维护的 Vue 3 + TypeScript 前端。现在默认不再直接把页面业务绑到旧 UAT，而是连接本仓库 `backend/` 的本地业务 API：

```text
Vue 工作台 -> http://127.0.0.1:8080 -> 专属业务后端
                                      -> 现有 DeepSeek / SSE 上游（保持不替换）
```

## 已做成真实业务的点击

- 自动创建/加载案件，并将 `caseId` 写回 URL。
- “开始审讯 / 暂停 / 恢复 / 结束审讯”走真实状态机。
- “下一阶段”按 身份核验 -> 案情陈述 -> 重点追问 -> 确认签名 推进。
- 发送问题先写入 SQLite，再调用原有 AI SSE 链路。
- 编辑问答会写 `qa_revisions`，旧内容可从“查看版本”抽屉回看。
- “标记矛盾”会真实更新记录并写审计日志。
- “采用追问”会把事实核对建议直接送入正式问答链路。
- 身份证/指纹/签名：Android 原生环境仍走 Capacitor Plugin；浏览器联调走本地后端。未接厂商 SDK 时明确返回“设备未连接”，不会伪造成功。

## 本地启动

先启动后端：

```bash
cd backend
npm start
```

再启动前端：

```bash
cd webapp
npm install
cp .env.example .env
npm run dev
```

默认 API：

```text
http://127.0.0.1:8080/
```

首次打开无需手工提供 `caseId`，前端会调用专属后端创建本地案件；也可以访问：

```text
http://localhost:5173/?caseId=<案件ID>
```

## AI / DeepSeek

前端只请求本地后端：

```text
GET /work/case/:caseId/session/message/inquiry?message=...
```

本地后端再将 SSE 转发到现有 AI 上游，所以这次改造没有替换 DeepSeek，也没有把 AI 逻辑重新实现一套。上游地址由 `backend/.env.example` 中 `AI_UPSTREAM_BASE_URL` 控制。

## Android 原生设备

前端仍保持稳定契约：

- `IdentityDevice.readIdentity()`
- `FingerprintDevice.capture()`
- `SignaturePad.capture()`

后续拿到一体机和具体硬件 SDK 后，只需要在 Kotlin/Java 插件层实现这些能力；页面不绑定厂商品牌。
