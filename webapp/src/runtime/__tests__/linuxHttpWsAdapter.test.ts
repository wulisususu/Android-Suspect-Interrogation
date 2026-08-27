import { describe, expect, it } from 'vitest'
import { LinuxHttpWsAdapter, buildRuntimeWebSocketUrl } from '../linuxHttpWsAdapter'
import { RuntimeAdapterError } from '../errors'

describe('LinuxHttpWsAdapter', () => {
  it('routes Linux operations through /api/v1 and preserves identity case binding', async () => {
    const calls: Array<{ method: string; url: string; data?: unknown }> = []
    const adapter = new LinuxHttpWsAdapter({
      request: async (config) => {
        calls.push({ method: String(config.method), url: String(config.url), data: config.data })
        return { data: { status: 'pending' } }
      },
      origin: 'http://127.0.0.1:8080',
    })

    await adapter.invoke('identity.read', { caseId: 'CASE-001', actorId: 'officer-01' })
    expect(calls[0]).toMatchObject({
      method: 'POST',
      url: '/api/v1/identity/read',
      data: { case_id: 'CASE-001', actor_id: 'officer-01' },
    })
  })

  it('normalizes network failures to NOT_CONNECTED', async () => {
    const adapter = new LinuxHttpWsAdapter({
      request: async () => { throw Object.assign(new Error('offline'), { code: 'ERR_NETWORK' }) },
      origin: 'http://127.0.0.1:8080',
    })

    await expect(adapter.invoke('identity.read')).rejects.toMatchObject<Partial<RuntimeAdapterError>>({
      code: 'BACKEND_OFFLINE',
      state: 'NOT_CONNECTED',
    })
  })

  it('returns explicit not-ready capability states when the capability endpoint is absent', async () => {
    const adapter = new LinuxHttpWsAdapter({
      request: async () => {
        throw { response: { status: 404, data: { code: 'NOT_FOUND' } } }
      },
      origin: 'http://127.0.0.1:8080',
    })

    const capabilities = await adapter.getCapabilities()
    expect(capabilities.ocr.state).toBe('MODEL_NOT_INSTALLED')
    expect(capabilities.llm.state).toBe('MODEL_NOT_INSTALLED')
    expect(capabilities.identity.state).toBe('NOT_CONFIGURED')
  })

  it('derives ws/wss URLs from the local browser origin', () => {
    expect(buildRuntimeWebSocketUrl('http://127.0.0.1:8080', 'abc def')).toBe('ws://127.0.0.1:8080/ws/interrogation/abc%20def')
    expect(buildRuntimeWebSocketUrl('https://kiosk.local/', 'session-1')).toBe('wss://kiosk.local/ws/interrogation/session-1')
  })
})
