import { afterEach, describe, expect, it, vi } from 'vitest'

const browserAudio = vi.hoisted(() => ({
  BrowserFormalCaptureLeaseError: class extends Error {
    constructor(message: string, readonly reason: 'CONFLICT' | 'UNSUPPORTED' = 'CONFLICT') {
      super(message)
    }
  },
  startBrowserAsrCapture: vi.fn(async () => undefined),
  stopBrowserAsrCapture: vi.fn(async () => undefined),
  confirmBrowserAsrCaptureFinalized: vi.fn(async () => undefined),
}))

vi.mock('../../config/audioInput', () => ({
  audioInputMode: 'BROWSER',
}))

vi.mock('../../audio/browserAsrCapture', () => ({
  BrowserFormalCaptureLeaseError: browserAudio.BrowserFormalCaptureLeaseError,
  startBrowserAsrCapture: browserAudio.startBrowserAsrCapture,
  stopBrowserAsrCapture: browserAudio.stopBrowserAsrCapture,
  confirmBrowserAsrCaptureFinalized: browserAudio.confirmBrowserAsrCaptureFinalized,
}))

import { LinuxHttpWsAdapter } from '../linuxHttpWsAdapter'

afterEach(() => vi.unstubAllGlobals())

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

  it('closes the browser microphone stream before finalizing the formal record', async () => {
    const order: string[] = []
    browserAudio.stopBrowserAsrCapture.mockImplementationOnce(async () => {
      order.push('browser')
    })
    const adapter = new LinuxHttpWsAdapter({
      request: async () => {
        order.push('backend')
        return { data: { ok: true, data: {} } }
      },
      origin: 'https://192.168.0.9:18080',
    })

    await adapter.invoke('document.finalize', { caseId: 'CASE-001' })

    expect(order).toEqual(['browser', 'backend'])
  })

  it('stops the browser stream before asking the backend to abort a failed browser start', async () => {
    vi.stubGlobal('window', {})
    const order: string[] = []
    browserAudio.startBrowserAsrCapture.mockRejectedValueOnce(new Error('microphone permission denied'))
    browserAudio.stopBrowserAsrCapture.mockImplementationOnce(async () => {
      order.push('browser stop')
    })
    let requestCount = 0
    const adapter = new LinuxHttpWsAdapter({
      request: async () => {
        requestCount += 1
        order.push(requestCount === 1 ? 'backend start' : 'backend stop')
        return {
          data: {
            caseId: 'CASE-001',
            active: true,
            captureSessionId: 'CAPTURE-001',
            sampleRate: 16_000,
          },
        }
      },
      origin: 'https://192.168.0.9:18080',
    })

    await expect(adapter.invoke('asr.capture.start', { caseId: 'CASE-001' })).rejects.toThrow('microphone permission denied')

    expect(order).toEqual(['backend start', 'browser stop', 'backend stop'])
  })

  it('does not stop the backend or local stream when another tab owns the formal capture lease', async () => {
    vi.stubGlobal('window', {})
    const order: string[] = []
    browserAudio.stopBrowserAsrCapture.mockClear()
    browserAudio.startBrowserAsrCapture.mockRejectedValueOnce(
      new browserAudio.BrowserFormalCaptureLeaseError('capture already owned'),
    )
    const adapter = new LinuxHttpWsAdapter({
      request: async () => {
        order.push('backend start')
        return {
          data: {
            caseId: 'CASE-001',
            active: true,
            captureSessionId: 'CAPTURE-001',
            sampleRate: 16_000,
          },
        }
      },
      origin: 'https://192.168.0.9:18080',
    })

    await expect(adapter.invoke('asr.capture.start', { caseId: 'CASE-001' })).rejects.toThrow('capture already owned')

    expect(order).toEqual(['backend start'])
    expect(browserAudio.stopBrowserAsrCapture).not.toHaveBeenCalled()
  })

  it('releases the browser capture lease after a failed-start cleanup stop succeeds', async () => {
    vi.stubGlobal('window', {})
    const order: string[] = []
    browserAudio.startBrowserAsrCapture.mockClear().mockRejectedValueOnce(new Error('microphone failed'))
    browserAudio.stopBrowserAsrCapture.mockClear().mockImplementationOnce(async () => {
      order.push('browser stop')
    })
    browserAudio.confirmBrowserAsrCaptureFinalized.mockClear().mockImplementationOnce(async () => {
      order.push('lease release')
    })
    let requestCount = 0
    const adapter = new LinuxHttpWsAdapter({
      request: async () => {
        requestCount += 1
        order.push(requestCount === 1 ? 'backend start' : 'backend stop')
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

    await expect(adapter.invoke('asr.capture.start', { caseId: 'CASE-001' })).rejects.toThrow('microphone failed')

    expect(order).toEqual(['backend start', 'browser stop', 'backend stop', 'lease release'])
    expect(browserAudio.confirmBrowserAsrCaptureFinalized).toHaveBeenCalledOnce()
  })

  it('retains the browser capture lease when failed-start backend cleanup fails', async () => {
    vi.stubGlobal('window', {})
    const order: string[] = []
    browserAudio.startBrowserAsrCapture.mockClear().mockRejectedValueOnce(new Error('microphone failed'))
    browserAudio.stopBrowserAsrCapture.mockClear().mockImplementationOnce(async () => {
      order.push('browser stop')
    })
    browserAudio.confirmBrowserAsrCaptureFinalized.mockClear()
    let requestCount = 0
    const adapter = new LinuxHttpWsAdapter({
      request: async () => {
        requestCount += 1
        order.push(requestCount === 1 ? 'backend start' : 'backend stop')
        if (requestCount === 2) throw new Error('backend stop failed')
        return { data: { captureSessionId: 'CAPTURE-001' } }
      },
      origin: 'https://192.168.0.9:18080',
    })

    await expect(adapter.invoke('asr.capture.start', { caseId: 'CASE-001' })).rejects.toThrow('microphone failed')

    expect(order).toEqual(['backend start', 'browser stop', 'backend stop'])
    expect(browserAudio.confirmBrowserAsrCaptureFinalized).not.toHaveBeenCalled()
  })

  it('finalizes the backend capture when browser locks are unsupported', async () => {
    vi.stubGlobal('window', {})
    const order: string[] = []
    browserAudio.startBrowserAsrCapture.mockClear().mockRejectedValueOnce(
      new browserAudio.BrowserFormalCaptureLeaseError('browser locks unavailable', 'UNSUPPORTED'),
    )
    browserAudio.stopBrowserAsrCapture.mockClear().mockImplementationOnce(async () => {
      order.push('browser stop')
    })
    browserAudio.confirmBrowserAsrCaptureFinalized.mockClear().mockImplementationOnce(async () => {
      order.push('lease release')
    })
    let requestCount = 0
    const adapter = new LinuxHttpWsAdapter({
      request: async () => {
        requestCount += 1
        order.push(requestCount === 1 ? 'backend start' : 'backend stop')
        return { data: { captureSessionId: 'CAPTURE-001' } }
      },
      origin: 'https://192.168.0.9:18080',
    })

    await expect(adapter.invoke('asr.capture.start', { caseId: 'CASE-001' })).rejects.toThrow('browser locks unavailable')

    expect(order).toEqual(['backend start', 'browser stop', 'backend stop', 'lease release'])
    expect(browserAudio.stopBrowserAsrCapture).toHaveBeenCalledOnce()
    expect(browserAudio.confirmBrowserAsrCaptureFinalized).toHaveBeenCalledOnce()
  })

  it('resumes the same pending capture after a failed stop and releases its lease only after retry succeeds', async () => {
    vi.stubGlobal('window', {})
    const order: string[] = []
    const lease = { release: vi.fn() }
    let activeLease: typeof lease | null = lease
    let pendingLease: { captureId: string; lease: typeof lease } | null = null
    let active = true
    let stopRequests = 0
    browserAudio.stopBrowserAsrCapture.mockClear().mockImplementation(async () => {
      if (!active) return
      order.push('browser stop')
      active = false
      pendingLease = { captureId: 'CAPTURE-001', lease: activeLease! }
      activeLease = null
    })
    browserAudio.startBrowserAsrCapture.mockClear().mockImplementationOnce(async () => {
      order.push('browser resume')
      expect(pendingLease?.captureId).toBe('CAPTURE-001')
      activeLease = pendingLease?.lease ?? null
      pendingLease = null
      active = true
    })
    browserAudio.confirmBrowserAsrCaptureFinalized.mockClear().mockImplementation(async () => {
      order.push('confirm finalization')
      pendingLease?.lease.release()
      pendingLease = null
    })
    const adapter = new LinuxHttpWsAdapter({
      request: async (config) => {
        if (config.url.endsWith('/asr/capture/stop')) {
          stopRequests += 1
          order.push(`backend stop ${stopRequests}`)
          expect(lease.release).not.toHaveBeenCalled()
          if (stopRequests === 1) throw new Error('temporary backend disconnect')
          return { data: { active: false } }
        }
        order.push('backend start')
        return { data: { captureSessionId: 'CAPTURE-001', active: true } }
      },
      origin: 'https://192.168.0.9:18080',
    })

    await expect(adapter.invoke('asr.capture.stop', { caseId: 'CASE-001' })).rejects.toThrow('temporary backend disconnect')
    expect(lease.release).not.toHaveBeenCalled()

    await adapter.invoke('asr.capture.start', { caseId: 'CASE-001' })
    expect(browserAudio.startBrowserAsrCapture).toHaveBeenCalledWith(
      'CASE-001',
      'CAPTURE-001',
      expect.any(String),
    )
    expect(activeLease).toBe(lease)
    expect(lease.release).not.toHaveBeenCalled()

    await adapter.invoke('asr.capture.stop', { caseId: 'CASE-001' })

    expect(order).toEqual([
      'browser stop',
      'backend stop 1',
      'backend start',
      'browser resume',
      'browser stop',
      'backend stop 2',
      'confirm finalization',
    ])
    expect(stopRequests).toBe(2)
    expect(lease.release).toHaveBeenCalledOnce()
  })
})
