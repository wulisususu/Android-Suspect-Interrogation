import { afterEach, describe, expect, it, vi } from 'vitest'
import {
  Pcm16Resampler,
  browserVoiceprintCapability,
  buildBrowserVoiceprintWebSocketUrl,
  createBrowserVoiceprintCapture,
  float32ToPcm16,
} from './browserVoiceprintCapture'


describe('browser voiceprint PCM conversion', () => {
  it('clips Float32 audio and converts it to little-endian PCM16 sample values', () => {
    const converted = float32ToPcm16(new Float32Array([-2, -1, -0.5, 0, 0.5, 1, 2]))

    expect(Array.from(converted)).toEqual([-32768, -32768, -16384, 0, 16384, 32767, 32767])
  })

  it('preserves duration when resampling 48 kHz browser audio to 16 kHz across chunk boundaries', () => {
    const input = new Float32Array(4800)
    for (let index = 0; index < input.length; index += 1) input[index] = Math.sin(index / 20) * 0.5

    const resampler = new Pcm16Resampler(48000, 16000)
    const first = resampler.process(input.subarray(0, 997))
    const second = resampler.process(input.subarray(997, 3101))
    const third = resampler.process(input.subarray(3101))
    const outputSamples = first.length + second.length + third.length

    expect(outputSamples).toBeGreaterThanOrEqual(1599)
    expect(outputSamples).toBeLessThanOrEqual(1601)
  })
})


describe('browser voiceprint capability guard', () => {
  it('requires a secure context before attempting browser microphone capture', () => {
    expect(browserVoiceprintCapability({
      isSecureContext: false,
      mediaDevices: { getUserMedia: async () => ({}) },
    })).toEqual({
      available: false,
      reason: '当前页面不是 HTTPS 安全环境，浏览器禁止远程麦克风访问',
    })
  })

  it('requires navigator.mediaDevices.getUserMedia', () => {
    expect(browserVoiceprintCapability({ isSecureContext: true, mediaDevices: undefined })).toEqual({
      available: false,
      reason: '当前浏览器不支持麦克风采集',
    })
  })

  it('reports browser microphone capture as available only when both guards pass', () => {
    expect(browserVoiceprintCapability({
      isSecureContext: true,
      mediaDevices: { getUserMedia: async () => ({}) },
    })).toEqual({ available: true, reason: '' })
  })
})


describe('browser voiceprint websocket URL', () => {
  it('uses WSS for enrollment on the production HTTPS origin', () => {
    expect(buildBrowserVoiceprintWebSocketUrl(
      'capture/1',
      'https://192.168.0.9:18080',
    )).toBe('wss://192.168.0.9:18080/ws/voiceprints/enrollment/capture%2F1')
  })
})


/**
 * Transport doubles. Every test drives the real capture implementation, so the
 * lifecycle race is exercised through the public API instead of re-implemented
 * in the test.
 */
class FakeWebSocket {
  static readonly instances: FakeWebSocket[] = []
  static readonly CONNECTING = 0
  static readonly OPEN = 1
  static readonly CLOSING = 2
  static readonly CLOSED = 3

  readonly url: string
  readyState: number = FakeWebSocket.CONNECTING
  binaryType = ''
  frames: ArrayBuffer[] = []
  closeCalls: Array<{ code?: number; reason?: string }> = []
  onopen: ((event: unknown) => void) | null = null
  onerror: ((event: unknown) => void) | null = null
  onclose: ((event: { code: number; reason: string }) => void) | null = null

  constructor(url: string | URL) {
    this.url = String(url)
    FakeWebSocket.instances.push(this)
  }

  send(data: ArrayBuffer) {
    this.frames.push(data)
  }

  /** Transport-level open, exactly what a browser does after the WSS handshake. */
  open() {
    this.readyState = FakeWebSocket.OPEN
    this.onopen?.({})
  }

  /** Backend closed the channel on its own (for example after capture.stop()). */
  remoteClose(code = 1006, reason = 'backend closed the audio channel') {
    this.readyState = FakeWebSocket.CLOSED
    this.onclose?.({ code, reason })
  }

  emitError() {
    this.onerror?.({})
  }

  close(code?: number, reason?: string) {
    this.closeCalls.push({ code, reason })
    this.readyState = FakeWebSocket.CLOSED
    this.onclose?.({ code: code ?? 1000, reason: reason ?? '' })
  }
}

class FakeAudioNode {
  disconnected = false
  connectCalls = 0
  disconnectCalls = 0
  readonly gain = { value: 1 }

  connect() {
    this.connectCalls += 1
  }

  disconnect() {
    this.disconnected = true
    this.disconnectCalls += 1
  }
}

class FakeScriptProcessorNode extends FakeAudioNode {
  onaudioprocess: ((event: { inputBuffer: { getChannelData: (channel: number) => Float32Array } }) => void) | null = null
}

class FakeAudioContext {
  static readonly instances: FakeAudioContext[] = []

  readonly destination = new FakeAudioNode()
  readonly processor = new FakeScriptProcessorNode()
  readonly source = new FakeAudioNode()
  state = 'running'
  closeCalls = 0

  constructor(
    readonly options?: unknown,
    readonly sampleRate = 48_000,
  ) {
    FakeAudioContext.instances.push(this)
  }

  createMediaStreamSource() {
    return this.source
  }

  createScriptProcessor() {
    return this.processor
  }

  createGain() {
    return new FakeAudioNode()
  }

  async resume() {
    this.state = 'running'
  }

  async close() {
    this.closeCalls += 1
    this.state = 'closed'
  }

  /** Push one audio callback with the given mono channel data. */
  emitAudio(samples: number[] = [0.25, -0.25, 0.5, -0.5, 0.75, -0.75, 0.1, -0.1]) {
    const channel = Float32Array.from(samples)
    this.processor.onaudioprocess?.({
      inputBuffer: { getChannelData: () => channel },
    })
  }
}

class FakeMediaStreamTrack {
  stopped = false
  onended: ((event: unknown) => void) | null = null

  stop() {
    this.stopped = true
  }
}

class FakeMediaStream {
  constructor(readonly tracks: FakeMediaStreamTrack[]) {}

  getAudioTracks() {
    return this.tracks
  }

  getTracks() {
    return this.tracks
  }
}

type BrowserGlobals = {
  window?: unknown
  WebSocket?: unknown
  AudioContext?: unknown
}

function stubBrowserGlobals(): { restore: () => void } {
  const scope = globalThis as unknown as BrowserGlobals
  const original = { window: scope.window, WebSocket: scope.WebSocket, AudioContext: scope.AudioContext }
  // The capture reads `window.AudioContext` and derives the WSS URL from
  // `window.location.origin`; the vitest node environment has no `window`.
  scope.window = Object.assign(scope, {
    location: { origin: 'https://192.168.0.9:18080', search: '', hostname: '192.168.0.9' },
    isSecureContext: true,
  })
  scope.WebSocket = FakeWebSocket
  scope.AudioContext = FakeAudioContext
  return {
    restore: () => {
      scope.window = original.window
      scope.WebSocket = original.WebSocket
      scope.AudioContext = original.AudioContext
    },
  }
}

function createTrack() {
  return new FakeMediaStreamTrack()
}

function createTransport() {
  const track = createTrack()
  const stream = new FakeMediaStream([track])
  return {
    track,
    stream,
    capture: createBrowserVoiceprintCapture(stream as unknown as MediaStream),
  }
}

function latestSocket(): FakeWebSocket {
  const socket = FakeWebSocket.instances.at(-1)
  if (!socket) throw new Error('没有创建 WebSocket 替身')
  return socket
}

function latestContext(): FakeAudioContext {
  const context = FakeAudioContext.instances.at(-1)
  if (!context) throw new Error('没有创建 AudioContext 替身')
  return context
}

/** Start a capture and drive it to the STREAMING state with a live transport. */
async function startStreaming(
  capture: ReturnType<typeof createBrowserVoiceprintCapture>,
  captureId: string,
  callbacks: Parameters<ReturnType<typeof createBrowserVoiceprintCapture>['start']>[1],
  sampleRate = 48_000,
) {
  const started = capture.start(captureId, callbacks)
  const socket = latestSocket()
  socket.open()
  await started
  const context = latestContext()
  if (context.sampleRate !== sampleRate) {
    Object.defineProperty(context, 'sampleRate', { value: sampleRate, configurable: true })
  }
  return { socket, context }
}

describe('browser voiceprint capture lifecycle race', () => {
  afterEach(() => {
    vi.restoreAllMocks()
    FakeWebSocket.instances.length = 0
    FakeAudioContext.instances.length = 0
  })

  it('ignores a websocket close that arrives while finalizing, because the backend closes it during HTTP finalize', async () => {
    const globals = stubBrowserGlobals()
    try {
      const onError = vi.fn()
      const { capture } = createTransport()
      const { socket } = await startStreaming(capture, 'capture-finalizing', { onError })

      capture.beginFinalize()
      socket.remoteClose(1006, 'backend closed after AudioCaptureService.stop()')

      expect(onError).not.toHaveBeenCalled()
      await capture.stop()
    } finally {
      globals.restore()
    }
  })

  it('reports a websocket close that arrives while streaming, so a real audio-channel failure is never swallowed', async () => {
    const globals = stubBrowserGlobals()
    try {
      const onError = vi.fn()
      const { capture } = createTransport()
      const { socket } = await startStreaming(capture, 'capture-streaming', { onError })

      socket.remoteClose(1006, 'unexpected transport failure')

      expect(onError).toHaveBeenCalledTimes(1)
      expect(onError).toHaveBeenCalledWith('浏览器麦克风音频通道已断开，请重新开始声纹录制')
      await capture.stop()
    } finally {
      globals.restore()
    }
  })

  it('keeps a stream that only paused after finalizing silent, so pause() cannot regress into a false failure', async () => {
    const globals = stubBrowserGlobals()
    try {
      const onError = vi.fn()
      const { capture } = createTransport()
      const { socket } = await startStreaming(capture, 'capture-pause-after-finalize', { onError })

      capture.beginFinalize()
      capture.pause()
      socket.remoteClose(1006, 'late close')

      expect(onError).not.toHaveBeenCalled()
      await capture.stop()
    } finally {
      globals.restore()
    }
  })

  it('stops sending PCM frames as soon as finalization begins', async () => {
    const globals = stubBrowserGlobals()
    try {
      const { capture } = createTransport()
      const { socket, context } = await startStreaming(capture, 'capture-frames', {})

      context.emitAudio([0.5, -0.5])
      const framesWhileStreaming = socket.frames.length
      expect(framesWhileStreaming).toBeGreaterThan(0)

      capture.beginFinalize()
      context.emitAudio([0.5, -0.5])
      context.emitAudio([0.25, -0.25])

      expect(socket.frames).toHaveLength(framesWhileStreaming)
      await capture.stop()
    } finally {
      globals.restore()
    }
  })

  it('drops socket callbacks from a previous attempt so they cannot poison the next recording', async () => {
    const globals = stubBrowserGlobals()
    try {
      const firstError = vi.fn()
      const secondError = vi.fn()
      const { capture: first } = createTransport()
      const firstStreaming = await startStreaming(first, 'capture-round-1', { onError: firstError })
      await first.stop()
      const staleClose = firstStreaming.socket.onclose
      const staleError = firstStreaming.socket.onerror

      const { capture: second } = createTransport()
      const secondStreaming = await startStreaming(second, 'capture-round-2', { onError: secondError })

      staleClose?.({ code: 1006, reason: 'stale close from the previous attempt' })
      staleError?.({})

      expect(firstError).not.toHaveBeenCalled()
      expect(secondError).not.toHaveBeenCalled()
      expect(secondStreaming.socket.frames).toEqual([])
      await second.stop()
    } finally {
      globals.restore()
    }
  })

  it('drops a track-ended callback captured from a previous attempt', async () => {
    const globals = stubBrowserGlobals()
    try {
      const firstStreaming = createTransport()
      const firstTrack = firstStreaming.track
      const firstError = vi.fn()
      const firstTrackEnded = vi.fn()
      await startStreaming(firstStreaming.capture, 'capture-track-1', {
        onError: firstError,
        onTrackEnded: firstTrackEnded,
      })
      const staleTrackEnded = firstTrack.onended
      expect(staleTrackEnded).toBeTypeOf('function')
      await firstStreaming.capture.stop()

      const secondStreaming = createTransport()
      const secondTrackEnded = vi.fn()
      await startStreaming(secondStreaming.capture, 'capture-track-2', {
        onTrackEnded: secondTrackEnded,
      })

      staleTrackEnded?.({ type: 'ended' })

      expect(firstTrackEnded).not.toHaveBeenCalled()
      expect(secondTrackEnded).not.toHaveBeenCalled()
      await secondStreaming.capture.stop()
    } finally {
      globals.restore()
    }
  })

  it('keeps stop() idempotent and keeps the socket open until stop(), so finalization is not cancelled by an early close', async () => {
    const globals = stubBrowserGlobals()
    try {
      const { capture } = createTransport()
      const { socket, context } = await startStreaming(capture, 'capture-idempotent', {})

      capture.beginFinalize()
      expect(socket.closeCalls).toHaveLength(0)

      await capture.stop()
      expect(socket.closeCalls).toHaveLength(1)
      expect(context.state).toBe('closed')

      await capture.stop()
      expect(socket.closeCalls).toHaveLength(1)
      expect(context.closeCalls).toBe(1)
    } finally {
      globals.restore()
    }
  })

  it('fails the start handshake when the socket is already closed', async () => {
    const globals = stubBrowserGlobals()
    try {
      const { capture } = createTransport()
      const started = capture.start('capture-early-close', {})
      const socket = latestSocket()
      socket.remoteClose(1006, 'closed during handshake')

      await expect(started).rejects.toThrow('浏览器麦克风音频通道在启动前已断开')
    } finally {
      globals.restore()
    }
  })
})
