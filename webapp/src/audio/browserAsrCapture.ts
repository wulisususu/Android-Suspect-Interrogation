import { runtimeConfig } from '../config/runtime'
import {
  Pcm16Resampler,
  browserVoiceprintCapability,
} from './browserVoiceprintCapture'

const TARGET_SAMPLE_RATE = 16_000

type CaptureKind = 'FORMAL' | 'QUESTION_PREP'

function wsOrigin(origin: string) {
  const url = new URL(origin)
  url.protocol = url.protocol === 'https:' ? 'wss:' : 'ws:'
  url.search = ''
  url.hash = ''
  return url
}

export function buildBrowserAsrCaptureWebSocketUrl(
  caseId: string,
  captureId: string,
  origin = runtimeConfig.apiBaseUrl,
) {
  const url = wsOrigin(origin)
  url.pathname = `/ws/asr/cases/${encodeURIComponent(caseId)}/capture/${encodeURIComponent(captureId)}`
  return url.toString().replace(/\/$/, '')
}

export function buildBrowserQuestionPreparationWebSocketUrl(
  caseId: string,
  captureId: string,
  origin = runtimeConfig.apiBaseUrl,
) {
  const url = wsOrigin(origin)
  url.pathname = `/ws/asr/cases/${encodeURIComponent(caseId)}/question-preparation/${encodeURIComponent(captureId)}`
  return url.toString().replace(/\/$/, '')
}

class BrowserPcmStreamer {
  private stream: MediaStream | null = null
  private context: AudioContext | null = null
  private source: MediaStreamAudioSourceNode | null = null
  private processor: ScriptProcessorNode | null = null
  private mute: GainNode | null = null
  private socket: WebSocket | null = null
  private stopped = false

  async start(url: string) {
    const capability = browserVoiceprintCapability()
    if (!capability.available) throw new Error(capability.reason)

    const media = await navigator.mediaDevices.getUserMedia({
      audio: {
        channelCount: 1,
        echoCancellation: false,
        noiseSuppression: false,
        autoGainControl: false,
      },
      video: false,
    })
    this.stream = media

    try {
      const socket = await this.openSocket(url)
      if (this.stopped) {
        socket.close(1000, 'capture stopped')
        throw new Error('浏览器麦克风采集已取消')
      }
      this.socket = socket

      const context = new AudioContext()
      this.context = context
      if (context.state === 'suspended') await context.resume()
      const source = context.createMediaStreamSource(media)
      const processor = context.createScriptProcessor(4096, 1, 1)
      const mute = context.createGain()
      mute.gain.value = 0
      const resampler = new Pcm16Resampler(context.sampleRate, TARGET_SAMPLE_RATE)

      processor.onaudioprocess = (event) => {
        const activeSocket = this.socket
        if (this.stopped || !activeSocket || activeSocket.readyState !== WebSocket.OPEN) return
        const pcm = resampler.process(event.inputBuffer.getChannelData(0))
        if (pcm.length) activeSocket.send(pcm.buffer.slice(pcm.byteOffset, pcm.byteOffset + pcm.byteLength))
      }

      source.connect(processor)
      processor.connect(mute)
      mute.connect(context.destination)
      this.source = source
      this.processor = processor
      this.mute = mute
    } catch (error) {
      await this.stop()
      throw error
    }
  }

  private openSocket(url: string): Promise<WebSocket> {
    return new Promise((resolve, reject) => {
      const socket = new WebSocket(url)
      socket.binaryType = 'arraybuffer'
      const timer = window.setTimeout(() => {
        socket.close()
        reject(new Error('连接 Linux 局域网音频通道超时'))
      }, 10_000)
      socket.onopen = () => {
        window.clearTimeout(timer)
        resolve(socket)
      }
      socket.onerror = () => {
        window.clearTimeout(timer)
        reject(new Error('无法连接 Linux 局域网音频通道；请确认后端已启用 BROWSER 测试音源'))
      }
    })
  }

  async stop() {
    if (this.stopped) return
    this.stopped = true
    if (this.processor) this.processor.onaudioprocess = null
    try { this.source?.disconnect() } catch { /* noop */ }
    try { this.processor?.disconnect() } catch { /* noop */ }
    try { this.mute?.disconnect() } catch { /* noop */ }
    if (this.socket && this.socket.readyState < WebSocket.CLOSING) this.socket.close(1000, 'capture stopped')
    for (const track of this.stream?.getTracks() ?? []) track.stop()
    if (this.context && this.context.state !== 'closed') await this.context.close().catch(() => undefined)
    this.stream = null
    this.context = null
    this.source = null
    this.processor = null
    this.mute = null
    this.socket = null
  }
}

let activeCapture: { kind: CaptureKind; streamer: BrowserPcmStreamer } | null = null

async function startCapture(kind: CaptureKind, url: string) {
  await stopBrowserAudioCapture()
  const streamer = new BrowserPcmStreamer()
  activeCapture = { kind, streamer }
  try {
    await streamer.start(url)
  } catch (error) {
    if (activeCapture?.streamer === streamer) activeCapture = null
    throw error
  }
}

export async function startBrowserAsrCapture(caseId: string, captureId: string, origin = runtimeConfig.apiBaseUrl) {
  return startCapture('FORMAL', buildBrowserAsrCaptureWebSocketUrl(caseId, captureId, origin))
}

export async function startBrowserQuestionPreparationCapture(
  caseId: string,
  captureId = 'question-preparation',
  origin = runtimeConfig.apiBaseUrl,
) {
  return startCapture('QUESTION_PREP', buildBrowserQuestionPreparationWebSocketUrl(caseId, captureId, origin))
}

export async function stopBrowserAudioCapture(kind?: CaptureKind) {
  const current = activeCapture
  if (!current || (kind && current.kind !== kind)) return
  activeCapture = null
  await current.streamer.stop()
}

export const stopBrowserAsrCapture = () => stopBrowserAudioCapture('FORMAL')
export const stopBrowserQuestionPreparationCapture = () => stopBrowserAudioCapture('QUESTION_PREP')
