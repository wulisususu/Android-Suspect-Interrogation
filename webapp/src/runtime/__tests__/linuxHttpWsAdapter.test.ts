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

  it('maps reviewed identity fields to the canonical confirmation endpoint', async () => {
    const calls: Array<{ method: string; url: string; data?: unknown }> = []
    const adapter = new LinuxHttpWsAdapter({
      request: async (config) => {
        calls.push({ method: String(config.method), url: String(config.url), data: config.data })
        return { data: { name: '赵某', caseId: 'CASE-001' } }
      },
      origin: 'http://127.0.0.1:8080',
    })

    await adapter.invoke('identity.confirm', {
      caseId: 'CASE-001',
      actorId: 'officer-01',
      name: '赵某',
      idNumber: '320101199001010011',
      gender: '男',
      nation: '汉',
      birthDate: '1990-01-01',
      address: '测试地址',
      source: 'MANUAL',
    })

    expect(calls[0]).toMatchObject({
      method: 'POST',
      url: '/api/v1/identity/confirm',
      data: {
        case_id: 'CASE-001',
        actor_id: 'officer-01',
        name: '赵某',
        id_number: '320101199001010011',
        gender: '男',
        nation: '汉',
        birth_date: '1990-01-01',
        address: '测试地址',
        source: 'MANUAL',
      },
    })
  })

  it('uses the canonical case session endpoints exposed by FastAPI', async () => {
    const calls: Array<{ method: string; url: string; data?: unknown }> = []
    const adapter = new LinuxHttpWsAdapter({
      request: async (config) => {
        calls.push({ method: String(config.method), url: String(config.url), data: config.data })
        return { data: { status: 'RUNNING', case_id: 'CASE-001', stage: 'IDENTITY' } }
      },
      origin: 'http://127.0.0.1:8080',
    })

    await adapter.invoke('session.start', { caseId: 'CASE-001' })
    await adapter.invoke('session.pause', { caseId: 'CASE-001' })
    await adapter.invoke('session.resume', { caseId: 'CASE-001' })
    await adapter.invoke('session.stage', { caseId: 'CASE-001', stage: 'STATEMENT' })
    await adapter.invoke('session.finish', { caseId: 'CASE-001' })

    expect(calls).toEqual([
      { method: 'POST', url: '/api/v1/cases/CASE-001/session/start', data: {} },
      { method: 'POST', url: '/api/v1/cases/CASE-001/session/pause', data: {} },
      { method: 'POST', url: '/api/v1/cases/CASE-001/session/resume', data: {} },
      { method: 'POST', url: '/api/v1/cases/CASE-001/session/stage', data: { stage: 'STATEMENT' } },
      { method: 'POST', url: '/api/v1/cases/CASE-001/session/finish', data: {} },
    ])
  })

  it('maps voiceprint operations to canonical Linux endpoints and payloads', async () => {
    const calls: Array<{ method: string; url: string; data?: unknown; params?: Record<string, unknown> }> = []
    const adapter = new LinuxHttpWsAdapter({
      request: async (config) => {
        calls.push({
          method: String(config.method),
          url: String(config.url),
          data: config.data,
          params: config.params,
        })
        return { data: { ok: true, data: {} } }
      },
      origin: 'http://127.0.0.1:8080',
    })

    await adapter.invoke('voiceprint.readiness', { caseId: 'CASE-001' })
    await adapter.invoke('voiceprint.suspect.enrollment.start', { caseId: 'CASE-001', actorId: 'actor-1' })
    await adapter.invoke('voiceprint.suspect.enrollment.stop', { caseId: 'CASE-001', actorId: 'actor-1' })
    await adapter.invoke('officerVoiceprint.list', { activeOnly: false })
    await adapter.invoke('officerVoiceprint.enrollment.start', { officerId: 'POL-1', officerName: '李警官', actorId: 'actor-1' })
    await adapter.invoke('officerVoiceprint.enrollment.stop', { officerId: 'POL-1', actorId: 'actor-1' })
    await adapter.invoke('officerVoiceprint.revoke', { officerId: 'POL-1', actorId: 'actor-1' })
    await adapter.invoke('voiceprint.assignments.update', {
      caseId: 'CASE-001',
      interrogatorOfficerId: 'POL-1',
      recorderOfficerId: 'POL-2',
      actorId: 'actor-1',
    })

    expect(calls).toEqual([
      { method: 'GET', url: '/api/v1/cases/CASE-001/voiceprints/readiness', data: undefined, params: undefined },
      { method: 'POST', url: '/api/v1/cases/CASE-001/voiceprints/suspect/enrollment/start', data: { actor_id: 'actor-1' }, params: undefined },
      { method: 'POST', url: '/api/v1/cases/CASE-001/voiceprints/suspect/enrollment/stop', data: { actor_id: 'actor-1' }, params: undefined },
      { method: 'GET', url: '/api/v1/officer-voiceprints', data: undefined, params: { active_only: false } },
      { method: 'POST', url: '/api/v1/officer-voiceprints/POL-1/enrollment/start', data: { officer_name: '李警官', actor_id: 'actor-1' }, params: undefined },
      { method: 'POST', url: '/api/v1/officer-voiceprints/POL-1/enrollment/stop', data: { actor_id: 'actor-1' }, params: undefined },
      { method: 'DELETE', url: '/api/v1/officer-voiceprints/POL-1', data: undefined, params: { actor_id: 'actor-1' } },
      {
        method: 'PUT',
        url: '/api/v1/cases/CASE-001/voiceprints/assignments',
        data: { interrogator_officer_id: 'POL-1', recorder_officer_id: 'POL-2', actor_id: 'actor-1' },
        params: undefined,
      },
    ])
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
