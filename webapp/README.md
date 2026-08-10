# Vue 原生源码重构（审讯主链路优先）

这个目录是对仓库现有 `frontend/` Apktool 展开产物的**可维护源码替代层**。当前阶段不删除旧 APK 资源，也不提前迁移远端后端。

## 当前目标

1. 审讯工作台作为主页面：时间线 + 实时问答 + 案件事实核对。
2. 保持现有远端 API 和 SSE 调用方式，先验证稳定输出。
3. “拟诊建议 / 案情结论”不作为主链路阻塞项，后续可降级成总结抽屉或侧栏。
4. 预留 Android 原生设备桥：身份证、指纹、签名。
5. 后续逐页替换 `frontend/assets/public/index.js` 中的反编译 bundle，而不是一次性推翻旧包。

## 启动

```bash
npm install
cp .env.example .env
npm run dev
```

默认不带 `caseId` 时显示演示数据，不请求后端。要测试现有 SSE：

```text
http://localhost:5173/?caseId=<真实案件ID>
```

并保证 `.env` 或 `localStorage.user_token` 中存在当前后端认可的登录 token。

## SSE

当前保持旧接口：

```text
GET /work/case/:caseId/session/message/inquiry?message=...
```

实现位于：

- `src/api/sse.ts`：基于 Fetch ReadableStream 的 SSE 解析器，可携带 Authorization。
- `src/api/interrogation.ts`：现有案件/消息/SSE API 适配层。

后续换专属后端时，优先只改 `src/api/*`，不要让页面直接依赖后端字段。

## Android 原生设备

`src/native/deviceBridge.ts` 仅定义稳定的前端调用契约：

- `IdentityDevice.readIdentity()`
- `FingerprintDevice.capture()`
- `SignaturePad.capture()`

注意：Android 系统原生能直接提供的是**生物识别认证框架**；身份证读卡器、原始指纹模板/图像采集、外接签字板通常仍需要具体硬件厂商 SDK。前端不绑定厂商，厂商差异放在 Kotlin/Java Capacitor Plugin 内。

## 推荐迁移顺序

1. 审讯工作台 + SSE
2. 现有登录/token 接入
3. 案件/审讯记录读取
4. 双屏 MultiScreen 桥迁移
5. ASR/录音桥
6. 身份证/指纹/签名插件
7. 证据和附件
8. 轻量“总结/结论”模块
9. 专属后端切换
10. 删除旧反编译 bundle
