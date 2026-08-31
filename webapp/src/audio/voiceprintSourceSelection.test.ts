import { describe, expect, it } from 'vitest'
import { selectVoiceprintSource } from './voiceprintSourceSelection'


describe('explicit voiceprint audio source selection', () => {
  it('uses the Windows browser microphone in BROWSER test mode', async () => {
    const browserCapture = { start: async () => undefined, pause: () => undefined, stop: async () => undefined, inputSampleRate: null }

    const selected = await selectVoiceprintSource('BROWSER', async () => browserCapture)

    expect(selected).toEqual({
      source: 'BROWSER',
      browserCapture,
      reason: '测试音源：当前 Windows 浏览器麦克风，经局域网发送到 Linux 后端。',
    })
  })

  it('does not silently fall back when browser permission acquisition fails', async () => {
    await expect(selectVoiceprintSource('BROWSER', async () => {
      throw new Error('当前局域网页面未获得麦克风安全上下文')
    })).rejects.toThrow('当前局域网页面未获得麦克风安全上下文')
  })
})
