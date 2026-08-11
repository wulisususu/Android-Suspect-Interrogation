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
  └─ AI Router
       ├─ Cloud Provider：智谱 GLM
       └─ Local Provider：JNI / C++ / RKNN / llama.cpp
```

**正式 APK 不依赖 `localhost:8080`、Node、Termux 或外部 Linux 主机完成审讯主流程。**

## 当前阶段：Android M0/M1 + AI Provider Router

已完成：

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
- AI Provider / Router
- APP 内运行时切换 AI 模式，无需重新构建 APK

### AI 模式

```text
CLOUD        -> 强制智谱 API
LOCAL        -> 强制本地模型
AUTO         -> 本地优先；本地不可用或运行失败时允许回退智谱
OFFLINE_ONLY -> 强制本地；绝不回退云端
```

### 当前智谱 Provider 默认参数

```text
POST https://open.bigmodel.cn/api/paas/v4/chat/completions
model = glm-4.7
thinking.type = enabled
stream = true
max_tokens = 65536
temperature = 1.0
```

这些参数都可以在构建好的 Android APP 内通过“AI 设置”修改并立即生效。

智谱 API Key 不写死在源码或 APK 配置中：用户在 APP 内录入后，使用 Android Keystore + AES-GCM 加密保存；设置页面只返回“已配置 / 未配置”，不会回显 Key 明文。

目前本地模型 Provider 接口已经存在，但 JNI / RKNN / llama.cpp Runtime 尚未接入，所以：

- `LOCAL` 当前会明确返回本地模型未配置；
- `OFFLINE_ONLY` 当前会明确失败且不会访问云端；
- `AUTO` 当前在本地不可用时会走已配置的智谱 Provider。

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

浏览器中的“AI 设置”通过 `backend-dev` 保存到本机开发数据库，并可直接联调智谱 API；API Key 不会回显到页面。Vite 将同源的 `/api` 和 `/work` 请求转发到仅本机监听的后端，因此从局域网设备打开 `5173` 时不需要直接访问 `8080`。Windows 未接本地模型 Runtime 时，`LOCAL` / `OFFLINE_ONLY` 会明确提示不可用。APK 内仍通过 NativeBridge/Kotlin 使用独立的 AI 路由设置。

## APK 构建

```bash
cd webapp
npm install
npm run build
```

然后用 Android Studio 打开 `android/` 构建 APK。Android 构建会自动把 `webapp/dist` 打进 APK assets。
