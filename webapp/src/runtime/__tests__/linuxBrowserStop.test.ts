import { describe, expect, it, vi } from 'vitest'

const browserAudio = vi.hoisted(() => ({
  stopBrowserAsrCapture: vi.fn(async () => undefined),
}))

vi.mock('../../config/audioInput', () => ({
  audioInputMode: 'BROWSER',
}))

vi.mock('../../audio/browserAsrCapture', () => ({
  startBrowserAsrCapture: vi.fn(),
  stopBrowserAsrCapture: browserAudio.stopBrowserAsrCapture,
}))

import { LinuxHttpWsAdapter } from '../linuxHttpWsAdapter'

describe('LinuxHttpWsAdapter browser ASR stop', () => {
  it('closes the browser microphone stream before asking the backend to finish the capture', async () => {
    const order: string[] = []
    browserAudio.stopBrowserAsrCapture.mockImplementationOnce(async () => {
      order.push('browser')
    })
    const adapter = new LinuxHttpWsAdapter({
      request: async () => {
        order.push('backend')
        return {
          data: {
            caseId: 'CASE-001',
            active: false,
            captureSessionId: 'CAPTURE-001',
            sampleRate: 16_000,
          },
        }
      },
      origin: 'https://192.168.0.9:18080',
    })

    await adapter.invoke('asr.capture.stop', { caseId: 'CASE-001' })

    expect(order).toEqual(['browser', 'backend'])
  })
})
