# backend-dev：浏览器业务联调工具

这个目录不是正式 Android 产品后端。

用途只有两类：

1. 在电脑浏览器运行 `webapp/` 时提供与 NativeBridge 对齐的 HTTP 业务接口；
2. 临时验证智谱/DeepSeek/其他云端 AI 流式接口，不把临时云 API 写进正式 APK。

正式一体机主链已经迁往：

```text
webapp -> window.NativeBridge -> android/Kotlin -> Room/SQLCipher
```

默认监听 `127.0.0.1:8080`，仅用于研发联调。设备模拟默认关闭，未接真实设备时返回 `DEVICE_NOT_CONNECTED`。

浏览器 AI 设置通过 `/api/ai/settings` 读写，并保存在本机开发数据库中。AI 询问使用当前设置直连兼容 OpenAI Chat Completions 的云端接口；Windows 未接本地 Runtime 时，本地模式会返回明确错误。
