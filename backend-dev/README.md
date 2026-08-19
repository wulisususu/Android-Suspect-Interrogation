# backend-dev：浏览器业务联调工具

这个目录不是正式 Android 产品后端。

用途是：在电脑浏览器运行 `webapp/` 时，提供与 NativeBridge 对齐的案件、会话、笔录、事实、时间线和设备联调 HTTP 接口。

正式一体机主链：

```text
webapp -> window.NativeBridge -> android/Kotlin -> Room/SQLCipher
```

默认监听 `127.0.0.1:8080`，仅用于研发联调。设备模拟默认关闭，未接真实设备时返回 `DEVICE_NOT_CONNECTED`。

## AI 说明

`backend-dev` 不再提供任何云端 AI 配置、API Key 保存、云端模型地址或 AI 代理接口。

案件 AI 梳理与 AI 询问仅在 Android APK 内运行，并直接使用设备上已导入、已选择且 Runtime 可用的本地 LLM。

浏览器联调环境不会回退到云端 AI。
