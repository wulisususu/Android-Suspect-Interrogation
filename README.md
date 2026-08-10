# Android Suspect Interrogation

嫌疑人审核 / 审讯 AI 一体机项目。

## 目录职责

- `android/`：**正式 Android APK 宿主和 Kotlin 业务后端**。业务数据库、Bridge、设备/AI 调度最终都在这里。
- `webapp/`：Vue 3 + TypeScript 正式前端。APK 内通过 `window.NativeBridge` 调 Kotlin；浏览器开发时可回退到 HTTP。
- `backend-dev/`：Node 22 + SQLite **开发联调工具**，只服务电脑浏览器调试和临时云端 AI 验证，不进入正式 APK 架构。
- `frontend/`：旧 APK 的 Apktool 展开产物，仅保留作历史 UI、壳层和兼容行为参考。

## 正式产品主链

```text
Android APK
  ├─ Vue WebView
  │    ↓ NativeBridge RPC
  ├─ Kotlin Domain / Service
  │    ↓
  ├─ Room + SQLCipher
  │    ↓
  ├─ Android Keystore
  │
  ├─ Device SDK / USB / Camera / Audio
  └─ JNI / C++ / RKNN / Local AI Runtime
```

**正式 APK 不依赖 `localhost:8080`、Node、Termux 或外部 Linux 主机完成审讯主流程。**

## 当前阶段：M0/M1 Android 化

已经开始把前一阶段 Node 中验证过的业务规则迁入 Kotlin：

- Case
- Session：开始 / 暂停 / 恢复 / 结束
- 四阶段：身份核验 / 案情陈述 / 重点追问 / 确认签名
- Q/A
- Revision
- Fact 读取
- Timeline 读取
- 追加式 Audit
- Room
- SQLCipher
- Android Keystore
- NativeBridge RPC

设备和本地 AI 还未接入时返回明确错误，不制造模拟成功。

## 浏览器联调

电脑上仍可使用：

```bash
cd backend-dev
npm start
```

另开终端：

```bash
cd webapp
npm install
cp .env.example .env
npm run dev
```

这里的 HTTP/云端 AI 只是开发辅助路径。

## APK 构建

```bash
cd webapp
npm install
npm run build
```

然后用 Android Studio 打开 `android/` 构建 APK。Android 构建会自动把 `webapp/dist` 打进 APK assets。
