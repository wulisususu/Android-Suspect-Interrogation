import { afterEach, describe, expect, it, vi } from 'vitest'
import { fetchReadiness } from './health'


afterEach(() => {
  vi.unstubAllGlobals()
})

describe('fetchReadiness', () => {
  it('returns the readiness document without treating optional capabilities as failure', async () => {
    vi.stubGlobal(
      'fetch',
      vi.fn().mockResolvedValue({
        ok: true,
        status: 200,
        json: async () => ({
          status: 'ready',
          checks: { storage: { state: 'READY', required: true, detail: 'ok' } },
          capabilities: { ai: { state: 'NOT_INSTALLED', required: false, detail: 'optional' } },
        }),
      }),
    )

    const result = await fetchReadiness()
    expect(result.status).toBe('ready')
    expect(result.capabilities.ai.state).toBe('NOT_INSTALLED')
  })

  it('throws on an HTTP failure so the maintenance gate can render fallback UI', async () => {
    vi.stubGlobal('fetch', vi.fn().mockResolvedValue({ ok: false, status: 503 }))
    await expect(fetchReadiness()).rejects.toThrow('HTTP 503')
  })
})
