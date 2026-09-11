export interface BrowserVoiceprintCapabilityEnvironment {
  isSecureContext?: boolean
  mediaDevices?: {
    getUserMedia?: (constraints: MediaStreamConstraints) => Promise<unknown>
  }
}

export interface BrowserVoiceprintCallbacks {
  onError?: (message: string) => void
  onTrackEnded?: () => void
}

/**
 * Explicit capture lifecycle.
 *
 * `CONNECTING`  – start() handshake in flight, nothing may be sent yet.
 * `STREAMING`   – handshake done, PCM frames are being pushed to the backend.
 * `FINALIZING`  – the caller handed the capture to the backend's HTTP
 *                 stop/enroll path: no new PCM frames, but the WebSocket is
 *                 deliberately kept open so the backend finishes enrollment
 *                 instead of taking its cancel branch.
 * `STOPPED`     – stop() completed; the socket and the audio graph are gone.
 * `FAILED`      – the transport died (or never came up) before finalizing.
 *
 * The transport callbacks are only authoritative while the capture is
 * `STREAMING`; a close during `FINALIZING`/`STOPPED`/`FAILED` is a normal
 * consequence of the backend tearing its capture down, not a user-visible
 * failure. Trying to express this with two booleans is what caused the
 * "registered voiceprint reported as failed" race.
 */
export type CaptureLifecycle = 'CONNECTING' | 'STREAMING' | 'FINALIZING' | 'STOPPED' | 'FAILED'

export interface BrowserVoiceprintCapture {
  readonly inputSampleRate: number | null
  readonly lifecycle: CaptureLifecycle
  start(captureId: string, callbacks?: BrowserVoiceprintCallbacks): Promise<void>
  /**
   * Switch to `FINALIZING`: stop the ScriptProcessor and stop sending PCM
   * frames, without closing the WebSocket. Call this BEFORE the HTTP
   * stop/enroll request.
   */
  beginFinalize(): void
  /**
   * Legacy: silences the audio graph. Since the fix it delegates to
   * `beginFinalize()` so the state machine stays consistent; `stop()` is the
   * only method that closes the channel.
   */
  pause(): void
  stop(): Promise<void>
}

const TARGET_SAMPLE_RATE = 16_000
const PROCESSOR_FRAMES = 4096

export function float32ToPcm16(input: Float32Array): Int16Array {
  const output = new Int16Array(input.length)
  for (let index = 0; index < input.length; index += 1) {
    const sample = Math.max(-1, Math.min(1, input[index] ?? 0))
    output[index] = sample < 0
      ? Math.round(sample * 32768)
      : Math.round(sample * 32767)
  }
  return output
}

export class Pcm16Resampler {
  private readonly step: number
  private inputOffset = 0
  private nextOutputPosition = 0
  private previousSample: number | null = null

  constructor(
    readonly inputSampleRate: number,
    readonly outputSampleRate: number = TARGET_SAMPLE_RATE,
  ) {
    if (!Number.isFinite(inputSampleRate) || inputSampleRate <= 0) throw new Error('输入采样率无效')
    if (!Number.isFinite(outputSampleRate) || outputSampleRate <= 0) throw new Error('输出采样率无效')
    this.step = inputSampleRate / outputSampleRate
  }

  process(input: Float32Array): Int16Array {
    if (!input.length) return new Int16Array(0)

    const chunkStart = this.inputOffset
    const chunkEnd = chunkStart + input.length
    const resampled: number[] = []

    while (this.nextOutputPosition < chunkEnd) {
      const lowerIndex = Math.floor(this.nextOutputPosition)
      const fraction = this.nextOutputPosition - lowerIndex
      const upperIndex = lowerIndex + 1

      if (fraction > 0 && upperIndex >= chunkEnd) break

      let lower: number
      if (lowerIndex < chunkStart) {
        if (lowerIndex !== chunkStart - 1 || this.previousSample == null) break
        lower = this.previousSample
      } else {
        lower = input[lowerIndex - chunkStart] ?? 0
      }

      let sample = lower
      if (fraction > 0) {
        const upper = input[upperIndex - chunkStart] ?? lower
        sample = lower + (upper - lower) * fraction
      }
      resampled.push(sample)
      this.nextOutputPosition += this.step
    }

    this.inputOffset = chunkEnd
    this.previousSample = input[input.length - 1] ?? this.previousSample
    return float32ToPcm16(Float32Array.from(resampled))
  }
}

function defaultEnvironment(): BrowserVoiceprintCapabilityEnvironment {
  return {
    isSecureContext: typeof window !== 'undefined' ? window.isSecureContext : false,
    mediaDevices: typeof navigator !== 'undefined' ? navigator.mediaDevices : undefined,
  }
}

export function browserVoiceprintCapability(
  environment: BrowserVoiceprintCapabilityEnvironment = defaultEnvironment(),
): { available: boolean; reason: string } {
  if (!environment.isSecureContext) {
    return { available: false, reason: '当前页面不是 HTTPS 安全环境，浏览器禁止远程麦克风访问' }
  }
  if (!environment.mediaDevices || typeof environment.mediaDevices.getUserMedia !== 'function') {
    return { available: false, reason: '当前浏览器不支持麦克风采集' }
  }
  return { available: true, reason: '' }
}

export function buildBrowserVoiceprintWebSocketUrl(captureId: string, origin?: string): string {
  const base = new URL(origin || (typeof window !== 'undefined' ? window.location.origin : 'http://localhost'))
  base.protocol = base.protocol === 'https:' ? 'wss:' : 'ws:'
  base.pathname = `/ws/voiceprints/enrollment/${encodeURIComponent(captureId)}`
  base.search = ''
  base.hash = ''
  return base.toString()
}

class BrowserVoiceprintCaptureImpl implements BrowserVoiceprintCapture {
  private context: AudioContext | null = null
  private source: MediaStreamAudioSourceNode | null = null
  private processor: ScriptProcessorNode | null = null
  private mute: GainNode | null = null
  private socket: WebSocket | null = null
  private callbacks: BrowserVoiceprintCallbacks = {}
  private resampler: Pcm16Resampler | null = null
  private state: CaptureLifecycle = 'STOPPED'
  private paused = false
  private attemptId = 0
  private trackHandlers: Array<{ track: MediaStreamTrack; handler: () => void }> = []

  constructor(private readonly stream: MediaStream) {}

  get inputSampleRate(): number | null {
    return this.context?.sampleRate ?? null
  }

  get lifecycle(): CaptureLifecycle {
    return this.state
  }

  async start(captureId: string, callbacks: BrowserVoiceprintCallbacks = {}): Promise<void> {
    if (!captureId.trim()) throw new Error('浏览器声纹 captureId 不能为空')
    if (this.socket || this.context) throw new Error('浏览器声纹采集已经启动')
    const attempt = this.nextAttempt()

    this.callbacks = callbacks
    this.paused = false
    this.state = 'CONNECTING'

    const socket = new WebSocket(buildBrowserVoiceprintWebSocketUrl(captureId))
    socket.binaryType = 'arraybuffer'
    this.socket = socket

    await new Promise<void>((resolve, reject) => {
      let settled = false
      socket.onopen = () => {
        if (!this.isCurrentAttempt(attempt)) return
        settled = true
        resolve()
      }
      socket.onerror = () => {
        if (!this.isCurrentAttempt(attempt)) return
        if (!settled) {
          settled = true
          this.state = 'FAILED'
          this.detachTrackHandlers(attempt)
          reject(new Error('无法建立浏览器麦克风音频通道'))
          return
        }
        if (this.state === 'STREAMING') {
          this.state = 'FAILED'
          this.callbacks.onError?.('浏览器麦克风音频通道已断开，请重新开始声纹录制')
        }
      }
      socket.onclose = () => {
        if (!this.isCurrentAttempt(attempt)) return
        if (!settled) {
          settled = true
          this.state = 'FAILED'
          this.detachTrackHandlers(attempt)
          reject(new Error('浏览器麦克风音频通道在启动前已断开'))
          return
        }
        // Only a close that interrupts an active stream is a real failure. A
        // close while FINALIZING/STOPPED/FAILED is the backend finishing or
        // tearing down its capture (AudioCaptureService.stop() closes the
        // channel) and must stay silent.
        // Only a close that interrupts an active stream is a real failure. A
        // close while FINALIZING/STOPPED/FAILED is the backend finishing or
        // tearing down its capture (AudioCaptureService.stop() closes the
        // channel) and must stay silent.
        if (this.state === 'STREAMING') {
          this.state = 'FAILED'
          this.callbacks.onError?.('浏览器麦克风音频通道已断开，请重新开始声纹录制')
        }
        this.detachTrackHandlers(attempt)
      }
    })

    if (!this.isCurrentAttempt(attempt)) {
      throw new Error('浏览器声纹采集已被新的采集替换')
    }
    if (socket.readyState !== WebSocket.OPEN) {
      this.socket = null
      throw new Error('浏览器麦克风音频通道在启动前已断开')
    }

    const AudioContextCtor = window.AudioContext
    if (!AudioContextCtor) throw new Error('当前浏览器不支持 Web Audio')
    const context = new AudioContextCtor({ latencyHint: 'interactive' })
    this.context = context
    if (context.state === 'suspended') await context.resume()
    this.resampler = new Pcm16Resampler(context.sampleRate, TARGET_SAMPLE_RATE)

    const source = context.createMediaStreamSource(this.stream)
    const processor = context.createScriptProcessor(PROCESSOR_FRAMES, 1, 1)
    const mute = context.createGain()
    mute.gain.value = 0
    this.source = source
    this.processor = processor
    this.mute = mute

    processor.onaudioprocess = (event: AudioProcessingEvent) => {
      // Frames are only valid for the attempt that installed this handler, and
      // only while that attempt is actually STREAMING.
      if (attempt !== this.attemptId || this.state !== 'STREAMING' || this.paused) return
      if (socket.readyState !== WebSocket.OPEN || !this.resampler) return
      const channel = event.inputBuffer.getChannelData(0)
      const pcm = this.resampler.process(channel)
      if (!pcm.length) return
      socket.send(pcm.buffer.slice(pcm.byteOffset, pcm.byteOffset + pcm.byteLength))
    }

    source.connect(processor)
    processor.connect(mute)
    mute.connect(context.destination)

    this.detachTrackHandlers(attempt)
    for (const track of this.stream.getAudioTracks()) {
      const handler = () => {
        if (attempt !== this.attemptId || this.state !== 'STREAMING') return
        this.callbacks.onTrackEnded?.()
      }
      try {
        track.onended = handler
      } catch {
        // Detached or unsupported track: the PCM path still works.
      }
      this.trackHandlers.push({ track, handler })
    }

    this.state = 'STREAMING'
  }

  /**
   * Begin finalization: stop producing PCM and silence the graph, but DO NOT
   * close the WebSocket. Closing early makes the backend's handler run its
   * cancel path and throw away the enrollment that is being registered.
   */
  beginFinalize(): void {
    if (this.state !== 'STREAMING') return
    this.state = 'FINALIZING'
    this.pause()
  }

  /**
   * `pause()` is kept for callers that silence the microphone without ending
   * the enrollment. It must stay consistent with the new state machine: the
   * audio graph is muted and marked `FINALIZING`, and the channel stays open,
   * so a later backend close is treated as normal instead of a failure.
   */
  pause(): void {
    if (this.state === 'STOPPED' || this.state === 'FAILED' || this.paused) return
    this.paused = true
    if (this.state === 'STREAMING') this.state = 'FINALIZING'
    if (this.processor) this.processor.onaudioprocess = null
    try { this.source?.disconnect() } catch { /* already disconnected */ }
    try { this.processor?.disconnect() } catch { /* already disconnected */ }
    try { this.mute?.disconnect() } catch { /* already disconnected */ }
  }

  async stop(): Promise<void> {
    this.pause()
    if (this.state === 'STOPPED') return
    this.state = 'STOPPED'
    // Invalidate the attempt so any in-flight transport callback from this
    // round is dropped instead of leaking into the next recording.
    this.attemptId += 1
    this.detachTrackHandlers(0)
    for (const track of this.stream.getTracks()) {
      try {
        track.onended = null
      } catch { /* detached track */ }
      try {
        track.stop()
      } catch { /* already stopped */ }
    }
    const socket = this.socket
    this.socket = null
    if (socket && (socket.readyState === WebSocket.CONNECTING || socket.readyState === WebSocket.OPEN)) {
      socket.close(1000, 'voiceprint capture complete')
    }
    const context = this.context
    this.context = null
    this.source = null
    this.processor = null
    this.mute = null
    this.resampler = null
    if (context && context.state !== 'closed') await context.close()
  }

  private nextAttempt(): number {
    this.attemptId += 1
    return this.attemptId
  }

  private isCurrentAttempt(attempt: number): boolean {
    return attempt === this.attemptId
  }

  private detachTrackHandlers(attempt: number) {
    const survivors: Array<{ track: MediaStreamTrack; handler: () => void }> = []
    for (const entry of this.trackHandlers) {
      // A handler that is no longer installed was already replaced by a newer
      // attempt; never clear the newer attempt's handler from an older one.
      if (attempt !== 0 && entry.track.onended !== entry.handler) {
        survivors.push(entry)
        continue
      }
      try {
        entry.track.onended = null
      } catch { /* detached track */ }
    }
    this.trackHandlers = survivors
  }
}

export function createBrowserVoiceprintCapture(stream: MediaStream): BrowserVoiceprintCapture {
  return new BrowserVoiceprintCaptureImpl(stream)
}

export async function acquireBrowserVoiceprintMic(): Promise<BrowserVoiceprintCapture> {
  const capability = browserVoiceprintCapability()
  if (!capability.available) throw new Error(capability.reason)

  let stream: MediaStream
  try {
    stream = await navigator.mediaDevices.getUserMedia({
      audio: {
        channelCount: { ideal: 1 },
        sampleRate: { ideal: TARGET_SAMPLE_RATE },
        echoCancellation: { ideal: false },
        noiseSuppression: { ideal: false },
        autoGainControl: { ideal: false },
      },
      video: false,
    })
  } catch (error) {
    const name = error instanceof DOMException ? error.name : ''
    if (name === 'NotAllowedError' || name === 'SecurityError') {
      throw new Error('浏览器麦克风权限被拒绝')
    }
    if (name === 'NotFoundError' || name === 'DevicesNotFoundError') {
      throw new Error('当前电脑没有可用麦克风')
    }
    throw new Error(error instanceof Error ? `无法打开浏览器麦克风：${error.message}` : '无法打开浏览器麦克风')
  }
  return new BrowserVoiceprintCaptureImpl(stream)
}
