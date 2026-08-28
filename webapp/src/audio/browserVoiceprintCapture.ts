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

export interface BrowserVoiceprintCapture {
  readonly inputSampleRate: number | null
  start(captureId: string, callbacks?: BrowserVoiceprintCallbacks): Promise<void>
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
  private stopped = false
  private paused = false
  private resampler: Pcm16Resampler | null = null

  constructor(private readonly stream: MediaStream) {}

  get inputSampleRate(): number | null {
    return this.context?.sampleRate ?? null
  }

  async start(captureId: string, callbacks: BrowserVoiceprintCallbacks = {}): Promise<void> {
    if (!captureId.trim()) throw new Error('浏览器声纹 captureId 不能为空')
    if (this.socket || this.context) throw new Error('浏览器声纹采集已经启动')
    this.callbacks = callbacks
    this.stopped = false
    this.paused = false

    const socket = new WebSocket(buildBrowserVoiceprintWebSocketUrl(captureId))
    socket.binaryType = 'arraybuffer'
    this.socket = socket

    await new Promise<void>((resolve, reject) => {
      let settled = false
      socket.onopen = () => {
        settled = true
        resolve()
      }
      socket.onerror = () => {
        if (!settled) {
          settled = true
          reject(new Error('无法建立浏览器麦克风音频通道'))
        }
      }
      socket.onclose = () => {
        if (!settled) {
          settled = true
          reject(new Error('浏览器麦克风音频通道在启动前已断开'))
          return
        }
        if (!this.stopped) this.callbacks.onError?.('浏览器麦克风音频通道已断开，请重新开始声纹录制')
      }
    })

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
      if (this.stopped || this.paused || socket.readyState !== WebSocket.OPEN || !this.resampler) return
      const channel = event.inputBuffer.getChannelData(0)
      const pcm = this.resampler.process(channel)
      if (!pcm.length) return
      socket.send(pcm.buffer.slice(pcm.byteOffset, pcm.byteOffset + pcm.byteLength))
    }

    source.connect(processor)
    processor.connect(mute)
    mute.connect(context.destination)

    for (const track of this.stream.getAudioTracks()) {
      track.onended = () => {
        if (!this.stopped) this.callbacks.onTrackEnded?.()
      }
    }
  }

  pause(): void {
    if (this.stopped || this.paused) return
    this.paused = true
    if (this.processor) this.processor.onaudioprocess = null
    try { this.source?.disconnect() } catch { /* already disconnected */ }
    try { this.processor?.disconnect() } catch { /* already disconnected */ }
    try { this.mute?.disconnect() } catch { /* already disconnected */ }
  }

  async stop(): Promise<void> {
    if (this.stopped) return
    this.pause()
    this.stopped = true
    for (const track of this.stream.getTracks()) {
      track.onended = null
      track.stop()
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
