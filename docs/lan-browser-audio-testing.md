# 局域网 Windows 浏览器麦克风测试

## 目标

开发阶段：Windows 浏览器麦克风 -> 16 kHz PCM16 -> 局域网 WebSocket -> Linux FastAPI -> 离线 FunASR。

生产阶段：Linux 一体机 ALSA 麦克风 -> FastAPI -> 离线 FunASR。

这两条链路共用同一套审讯、声纹、ASR、说话人识别和笔录业务逻辑。**局域网浏览器测试不需要 FRP、公网 IP、公网域名或公网 HTTPS。**

## 1. Linux 测试端

在测试机 `/etc/suspect-interrogation/runtime.env` 中显式启用浏览器音源，并让 API 监听局域网接口：

```bash
SUSPECT_AUDIO_INPUT_MODE=BROWSER
SUSPECT_API_HOST=0.0.0.0
```

保留原有 `SUSPECT_API_PORT`。修改后：

```bash
sudo systemctl restart interrogation-api
sudo systemctl status interrogation-api --no-pager
```

建议用主机防火墙只允许当前测试 LAN 网段访问 API 端口，不要做公网端口映射。

## 2. Windows 浏览器

Chromium 浏览器通常不会把 `http://192.168.x.x` 视为可调用麦克风的安全上下文。开发阶段不要为此建立公网 HTTPS；使用仓库提供的专用测试启动脚本：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\launch-lan-browser-mic.ps1 `
  -Origin http://192.168.1.50:18080
```

把地址替换成 Linux 测试机真实局域网地址和端口。脚本只接受 localhost、RFC1918 私网 IP、`.local` 或 `.lan` 地址，并使用独立浏览器 profile；它不会自动同意麦克风权限。浏览器打开后仍需人工点击“允许麦克风”。

脚本自动增加 `?audioInput=browser`，前端因此固定使用 Windows 浏览器麦克风；权限失败会直接报错，不会偷偷回退到 RK3588/Linux 麦克风。

## 3. 数据路径

```text
Windows microphone
  -> Web Audio API
  -> resample 16 kHz mono PCM16
  -> ws://<linux-lan-ip>:<port>/ws/asr/...
  -> BrowserAudioInput (memory only)
  -> AsrCaptureService
  -> local speech worker
  -> FSMN-VAD / Paraformer / XVector
  -> ASR fragment / speaker attribution
```

浏览器 PCM 输入缓冲只存在内存中，不由 `BrowserAudioInput` 落盘。

## 4. 恢复生产一体机模式

正式部署到 Linux 一体机时：

```bash
SUSPECT_AUDIO_INPUT_MODE=ALSA
```

前端不再带 `?audioInput=browser`，并保持：

```env
VITE_AUDIO_INPUT_MODE=ALSA
```

生产默认值本身就是 `ALSA`，因此即使忘记配置，也不会主动请求浏览器麦克风。

## 5. 验收

测试模式必须满足：

1. Windows 浏览器出现麦克风权限请求；
2. Linux 本机没有调用 ALSA 录音设备作为正式 ASR 输入；
3. `/ws/asr/...` 只在局域网地址建立；
4. Paraformer 能产生 ASR final；
5. 关闭浏览器权限或拒绝权限时前端明确失败，不回退 Linux 麦克风；
6. 无 FRP / 公网域名 / 公网 HTTPS 依赖。

生产模式则继续使用现有 RK3588 real microphone acceptance 工作流验证 ALSA + FunASR。
