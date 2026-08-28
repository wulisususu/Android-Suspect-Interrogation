import { describe, expect, it } from 'vitest'
import { selectAutoVoiceprintSource } from './voiceprintSourceSelection'


describe('AUTO voiceprint audio source selection', () => {
  it('prefers the browser microphone when acquisition succeeds', async () => {
    const browserCapture = { start: async () => undefined, pause: () => undefined, stop: async () => undefined, inputSampleRate: null }

    const selected = await selectAutoVoiceprintSource(async () => browserCapture)

    expect(selected).toEqual({ source: 'BROWSER', browserCapture, reason: '' })
  })

  it('falls back to RK3588 ALSA only when browser acquisition fails before enrollment starts', async () => {
    const selected = await selectAutoVoiceprintSource(async () => {
      throw new Error('当前页面不是 HTTPS 安全环境，浏览器禁止远程麦克风访问')
    })

    expect(selected.source).toBe('ALSA')
    expect(selected.browserCapture).toBeNull()
    expect(selected.reason).toContain('不是 HTTPS')
    expect(selected.reason).toContain('RK3588')
  })
})
