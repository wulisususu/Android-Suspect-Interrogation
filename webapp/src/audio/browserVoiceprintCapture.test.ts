import { describe, expect, it } from 'vitest'
import {
  Pcm16Resampler,
  browserVoiceprintCapability,
  buildBrowserVoiceprintWebSocketUrl,
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
