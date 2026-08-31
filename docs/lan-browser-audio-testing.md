# 局域网浏览器麦克风与 HTTPS

## 目标

Windows 浏览器麦克风 -> 16 kHz PCM16 -> 局域网 WSS -> Linux FastAPI -> 离线 FunASR。

Linux 一体机本机浏览器 -> ALSA 麦克风 -> FastAPI -> 离线 FunASR。

两条链路共用同一套审讯、声纹、ASR、说话人识别和笔录业务逻辑。音源由客户端上下文和请求级音源路由自动选择，不再依赖一个进程级 `SUSPECT_AUDIO_INPUT_MODE`。

## 1. 生产 LAN 地址

RK3588 API 监听：

```text
0.0.0.0:18080
```

局域网 Windows/其他电脑访问：

```text
https://192.168.0.9:18080
```

RK3588 本机 Kiosk 访问：

```text
https://127.0.0.1:18080
```

TCP/8000 属于既有 FunASR 服务，不参与本项目 HTTPS 切换。

## 2. 第一次在 Windows 信任局域网 CA

以**管理员身份**打开 PowerShell，在项目目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\install-lan-ca.ps1 `
  -Origin https://192.168.0.9:18080
```

脚本的第一步会使用一次 `curl.exe -k` 下载**公开 CA 证书**。这是唯一的临时跳过校验操作。随后脚本会：

1. 显示 CA SHA-256 指纹；
2. 将 CA 导入 Windows `LocalMachine\Root`；
3. 确认 CA 已进入受信任根；
4. 不使用 `-k` 再访问 `/health/live`，确认正常 TLS 校验成功。

CA 私钥和服务器私钥只保存在 RK3588 `/etc/suspect-interrogation/tls/`，不会下载到 Windows，也不会提交 GitHub。

## 3. 正常浏览器使用

完成 CA 导入后，关闭之前使用特殊命令行参数启动的浏览器窗口，直接使用普通 Edge/Chrome 打开：

```text
https://192.168.0.9:18080
```

不再需要：

```text
--unsafely-treat-insecure-origin-as-secure
```

也不需要手工添加 `?audioInput=browser`。远程 Windows/macOS/Linux 浏览器自动选择 `BROWSER`；RK3588 本机 loopback Kiosk 自动选择 `ALSA`。URL 中显式 `audioInput` 参数仍保留为诊断/人工覆盖能力。

浏览器第一次调用麦克风时仍需要用户点击“允许”。

## 4. 音频数据路径

```text
Windows microphone
  -> Web Audio API
  -> resample 16 kHz mono PCM16
  -> wss://192.168.0.9:18080/ws/asr/...
  -> BrowserAudioInput (memory only)
  -> source-aware ASR coordinator
  -> local speech worker
  -> FSMN-VAD / Paraformer / XVector
  -> ASR fragment / speaker attribution
```

声纹录入同样使用：

```text
wss://192.168.0.9:18080/ws/voiceprints/enrollment/...
```

浏览器 PCM 缓冲只存在内存中，不由 `BrowserAudioInput` 落盘。

## 5. TLS 证书生命周期

服务器维护项目私有 LAN CA：

```text
/etc/suspect-interrogation/tls/ca.crt
/etc/suspect-interrogation/tls/ca.key
/etc/suspect-interrogation/tls/server.crt
/etc/suspect-interrogation/tls/server.key
```

CA 默认有效 365 天；服务器证书默认有效 90 天，并在剩余 30 天以内自动续签。普通续签复用同一 CA，因此 Windows 不需要重新导入根证书。

服务器证书 SAN 包含：

```text
IP:192.168.0.9
IP:127.0.0.1
DNS:localhost
```

如果未来主动更换 CA，Windows 客户端才需要重新安装新的 CA。

## 6. 验收

Windows 浏览器链路必须满足：

1. `https://192.168.0.9:18080` 无证书错误；
2. `window.isSecureContext === true`；
3. 浏览器能够正常请求麦克风权限；
4. 正式审讯和问题准备使用 `wss://` 音频通道；
5. 嫌疑人/民警声纹录入使用 `wss://`；
6. 远程浏览器失败时不偷偷回退到 RK3588 ALSA；
7. Paraformer 能产生 ASR final；
8. TCP/8000 原 FunASR 服务保持不变。

RK3588 本机模式继续使用 ALSA + FunASR，并通过同一 `https://127.0.0.1:18080` Kiosk 入口运行。

## 7. 旧 HTTP 调试方式

仓库中的 `scripts/windows/launch-lan-browser-mic.ps1` 只保留为旧环境诊断工具。生产/日常 LAN 使用以受信任的 HTTPS 方案为准，不应继续依赖 Chromium 的 unsafe-origin 参数。
