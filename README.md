# Android Suspect Interrogation

嫌疑人审讯 / 案件细节核对项目。

## 目录说明

- `frontend/`：当前可运行 APK 的 Apktool 展开产物，暂时保留，用于兼容现有 Android 壳、MultiScreen 和已验证的远端接口链路。
- `webapp/`：新增的 **Vue 3 + TypeScript + Vite** 原生源码工程，作为后续正式前端的维护入口。

## 当前重构原则

1. **审讯是主链路**：实时问答、SSE 输出、时间线、案件事实核对优先。
2. **不提前切后端**：`webapp` 默认仍指向当前 UAT API，先保证 SSE 能稳定接收。
3. **结论模块轻量化**：原“拟诊建议 / 案情结论”不作为当前重构阻塞项。
4. **渐进迁移**：不删除 `frontend/`，新 Vue 页面验证通过后逐页替换反编译 bundle。
5. **原生设备解耦**：身份证、指纹、签名通过 Capacitor Plugin 契约调用，具体硬件 SDK 留在 Android Kotlin/Java 层。

## 新源码启动

```bash
cd webapp
npm install
cp .env.example .env
npm run dev
```

不传 `caseId` 时为 UI 演示模式；测试当前远端 SSE：

```text
http://localhost:5173/?caseId=<真实案件ID>
```

详细说明见 `webapp/README.md`。
