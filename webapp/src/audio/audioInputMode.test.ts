import { describe, expect, it } from 'vitest'
import { selectVoiceprintSource } from './voiceprintSourceSelection'


describe('explicit microphone source modes', () => {
  it('production ALSA mode never requests the browser microphone', async () => {
    let requested = false
    const selected = await selectVoiceprintSource('ALSA', async () => {
      requested = true
      throw new Error('should not be called')
    })

    expect(requested).toBe(false)
    expect(selected.source).toBe('ALSA')
    expect(selected.browserCapture).toBeNull()
  })

  it('LAN browser mode never silently falls back to the RK3588 microphone', async () => {
    await expect(selectVoiceprintSource('BROWSER', async () => {
      throw new Error('浏览器麦克风权限被拒绝')
    })).rejects.toThrow('浏览器麦克风权限被拒绝')
  })
})
