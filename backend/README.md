# 嫌疑人审核专属后端（业务联调版）

这一层只服务 `webapp/` 当前 Vue 前端，目标是先把真实业务状态、点击反馈和本地持久化跑通。

## 当前完成

- 案件创建 / 查询 / 修改
- 审讯状态机：开始、暂停、恢复、结束
- 四阶段：身份核验 → 案情陈述 → 重点追问 → 确认签名
- 问答真实落库、稳定序号
- 笔录编辑自动生成 Revision
- 矛盾 / 已确认 / 待补充标记
- 事实核对与时间线持久化接口
- Audit Log 追加式审计
- 设备状态 / 点击反馈：未接硬件时明确返回 `DEVICE_NOT_CONNECTED`，不会伪造成功
- 现有 AI/DeepSeek 链路保持不变：本后端只代理旧 SSE 上游

## 技术说明

当前阶段为了让 Vue 页面马上可联调，使用 Node 22+ 自带 `node:sqlite` 实现本地 HTTP 业务后端，接口默认运行在 `127.0.0.1:8080`。

这不是对 Android 正式 Kotlin/Room 架构的替代。正式一体机仍按技术设计迁移为 Kotlin Domain / Service / Repository + Room/SQLCipher，并保持本文档定义的业务规则和前端 API 契约。

## 启动

```bash
cd backend
cp .env.example .env  # 可选，当前代码读取系统环境变量
npm run check
npm run start
```

无需第三方 npm 依赖。要求 Node >= 22.5。

## AI 上游

默认继续代理当前旧链路：

```text
https://uat.pediatrician-ai.fb.jnpinno.com/
```

可通过环境变量修改：

```bash
AI_UPSTREAM_BASE_URL=https://...
```

前端仍调用：

```text
GET /work/case/:caseId/session/message/inquiry?message=...
```

本后端只做转发和结果留痕，不替换现有 DeepSeek API。

## 设备策略

默认：

```text
DEVICE_SIMULATOR=0
```

真实硬件未接 Android 厂商 SDK 时，点击身份证 / 指纹 / 签名会得到真实失败反馈：后端在线，但设备未连接。

仅 UI 联调时可显式设置：

```text
DEVICE_SIMULATOR=1
```

此时返回值会包含 `simulated: true`，避免和真实硬件结果混淆。
