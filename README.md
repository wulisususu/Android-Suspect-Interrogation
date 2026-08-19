# Android Suspect Interrogation

嫌疑人审核 / 审讯 AI 一体机项目。

## 目录职责

- `android/`：**正式 Android APK 宿主和 Kotlin 业务后端**。业务数据库、Bridge、设备与本地 AI 调度都在这里。
- `webapp/`：Vue 3 + TypeScript 正式前端。APK 内通过 `window.NativeBridge` 调 Kotlin；浏览器开发时可回退到 HTTP 业务接口。
- `backend-dev/`：Node 22 + SQLite **开发联调工具**，只服务电脑浏览器调试案件/会话/笔录等业务，不提供 AI 云代理。
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
  ├─ Device SDK / USB / Camera / Audio
  │
  └─ Local AI Runtime
       └─ 已选择的设备本地 LLM / RKLLM
```

**正式 APK 不依赖 `localhost:8080`、Node、Termux、外部 Linux 主机或任何云端 AI API 完成审讯主流程。**

## AI 原则：仅本地模型

项目已移除云端 API Provider、API Key、云模型地址、CLOUD/AUTO 路由与云端失败回退。

AI 入口只使用设备本地模型：

- 顶部“AI”配置页只提供本地模型管理；
- 案件 AI 梳理只调用当前已选择且 Runtime 可用的本地 LLM；
- 浏览器联调环境不提供云端 AI 兜底；
- 审讯内容不会因为 AI 功能自动发送到第三方云端模型。

本地模型统一放在设备模型目录：

- ASR：`/sdcard/models/asr/` 下的 Zipformer RKNN（RK3576 NPU）和 Paraformer INT8（ONNX Runtime CPU），可在运行时切换；
- OCR：`/sdcard/models/ocr/` 下的 OCR 模型；
- LLM：优先扫描 `/sdcard/models/llm/` 下的 RK3576 `.rkllm` 模型，并兼容原先直接放在 `/sdcard/models/` 下的文件；
- VAD：`/sdcard/models/vad/`；
- Speaker：`/sdcard/models/speaker/`。

模型权重不随 APK 分发。首次使用前需授权设备模型目录，并按类似以下结构部署、扫描和选择兼容模型：

```text
/sdcard/models/
├── asr/zipformer_rk3576/{encoder.rknn,decoder.rknn,joiner.rknn,tokens.txt}
├── asr/paraformer_int8/{encoder.int8.onnx,decoder.int8.onnx,tokens.txt}
├── ocr/
├── llm/*.rkllm
├── vad/
└── speaker/
```

## 当前案件工作流

```text
首页新建询问
  ↓
高拍仪 / OCR 身份建档 + 现住址 + 案件类型
  ↓
A 身份信息：查看 / 修正 / 必要时重新读取身份证
  ↓
C 审讯记录：手工输入 / 本地 ASR 录音识别
  ↓
本地 LLM 生成案件梳理
  ↓
B 案件梳理：案件时间线 + 事实核对
```

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

浏览器模式只用于案件、会话、笔录、事实、时间线等业务 UI 联调。**本地模型与 AI 推理仅在 Android APK 内启用。**

## APK 构建

```bash
cd webapp
npm install
npm run build
```

然后用 Android Studio 打开 `android/` 构建 APK。Android 构建会自动把 `webapp/dist` 打进 APK assets。
