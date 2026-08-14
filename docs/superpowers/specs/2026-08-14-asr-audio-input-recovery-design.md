# ASR 音频输入恢复设计

## 背景与运行时证据

当前审讯 App 的前端、Native Bridge、`AudioRecord`、Sherpa/Paraformer 和识别结果事件链均可启动。Android 因 USB 声卡接入而把 `HK DXMIC V1` 选为默认输入，但 App 保存的 16 kHz 单声道 WAV 与绕过 App 的 USB 原生 48 kHz 双声道 `tinycap` 录音峰值都只有 18/32767。相同设备的板载 `rockchip-es8388` 输入峰值达到 28442，证明板载麦克风可用。

另一套 doctor-assistant 通过厂商 `audio-service` 的 `127.0.0.1:8888` 获取处理后的 PCM；当前设备没有该端口监听，也没有可验证的服务端帧协议。因此本轮不能把 8888 当作可用音频源。

## 目标

- 当板载麦克风存在时，ASR 明确选择它，避免 Android 自动路由到静音的 USB 声卡。
- 将实际请求和实际路由的输入设备、输入峰值及静音状态暴露到 ASR 状态和界面。
- 若指定设备未被采用或连续输入为数字静音，给出可操作错误，不再表现为“正在录音但一直没有文字”。
- 保持现有 16 kHz mono PCM、离线 Sherpa 模型、录音存档及文字回流不变。

## 方案比较

### A. 明确选择板载麦克风并增加静音诊断（本轮采用）

使用 `AudioManager.GET_DEVICES_INPUTS` 枚举输入设备，优先选择 `TYPE_BUILTIN_MIC`，通过 `AudioRecord.setPreferredDevice` 指定输入。在录音线程计算 PCM 峰值；实际路由未采用板载麦克风或持续收到极低电平时，停止本次识别并返回明确错误。

优点是改动小、能在当前设备完整验证、不会改变 ASR 模型输入格式。代价是暂时不能利用 DXMIC 的双通道能力。

### B. 录音中动态重建 `AudioRecord` 并切换设备

先使用默认设备，检测静音后在同一识别会话中重建录音器。它能保留 USB 正常时的使用机会，但并发资源切换复杂，会影响正在写入的 WAV 和识别时间轴；当前 USB 已被原生录音证明静音，没有必要承担这部分风险。

### C. 接入厂商 8888 `audio-service`

这是使用 DXMIC 原厂混合流/双路流的长期方向。但当前服务不存在，帧格式、会话控制、重连和时间戳语义均无法验证。本轮只保持 ASR 引擎的 PCM 消费边界，不实现猜测性的 WebSocket 客户端；获得可运行的厂商服务或工作设备后另立任务接入。

## 组件与数据流

1. `AudioInputSelectionPolicy` 接收纯数据形式的输入设备列表，优先返回板载麦克风，便于 JVM 单元测试。
2. `AndroidAudioInputSelector` 从 `AudioManager` 获取真实设备并将策略结果映射回 `AudioDeviceInfo`。
3. `SherpaOnlineAsrEngine` 创建 `AudioRecord` 后设置首选设备，启动后读取 `routedDevice`，记录请求设备和实际设备。
4. `PcmSignalMonitor` 在录音线程累计峰值和连续低电平时长。有效音频会更新诊断值；达到静音阈值则通过既有 `AsrListener.onError` 终止采集。
5. `AsrRuntimeStatus`、Native JSON 和 Web 类型增加输入设备、路由设备、峰值和信号状态字段；`AsrConsole` 显示这些字段。连续录音界面继续通过既有错误状态展示失败原因。

## 静音判定

- 数字静音阈值以绝对峰值不高于 64 为准；实测故障 USB 峰值为 18。
- 启动后连续 3 秒都没有超过阈值才判定无有效信号，避免模型初始化期间和短暂安静造成误判。
- 只在实际路由为 USB/未知设备或首选板载设备未生效时触发致命错误；板载麦克风处于安静环境时只更新诊断状态，不主动停止。

## 错误处理

- 找到板载麦克风但 `setPreferredDevice` 失败：启动失败，提示无法切换到板载麦克风。
- 设备没有板载麦克风：保留系统默认输入并记录实际路由，不伪造成功。
- 实际路由仍为已知静音 USB 且达到静音窗口：返回 `ASR_AUDIO_NO_SIGNAL`，提示检查 USB audio-service 或使用板载麦克风。
- 8888 不可用不会影响本轮链路，因为它不是本轮运行依赖。

## 测试与验收

- JVM 测试覆盖设备优先级、无板载设备回退、静音窗口和有效采样复位。
- 现有 Android 单元测试全部通过，Debug APK 构建成功。
- 真机日志显示请求和实际路由均为 `rockchip-es8388`/`TYPE_BUILTIN_MIC`。
- 真机点击麦克风后保存 WAV 的峰值明显高于 64；说话时界面出现 partial/final 文字。
- USB 声卡继续连接时，App 不再被系统默认路由劫持。

## 非目标

- 不修改或伪造厂商固件服务。
- 不实现未经验证的 8888 WebSocket PCM 协议。
- 不改变 ASR 模型、录音存档格式、说话人确认流程或案件数据结构。
