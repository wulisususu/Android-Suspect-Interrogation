import { beforeEach, describe, expect, it, vi } from 'vitest'

const mocks = vi.hoisted(() => ({ request: vi.fn() }))

vi.mock('../../api/http', () => ({
  http: { request: mocks.request },
}))

import { BrowserDevAdapter } from '../browserDevAdapter'
import { RuntimeAdapterError } from '../errors'

describe('BrowserDevAdapter', () => {
  beforeEach(() => {
    mocks.request.mockReset()
  })

  it('keeps supported browser-dev case operations on the legacy local backend', async () => {
    mocks.request.mockResolvedValue({ data: { id: 'case-1', suspectName: '张三' } })
    const adapter = new BrowserDevAdapter()

    await adapter.invoke('case.get', { caseId: 'case-1' })

    expect(mocks.request).toHaveBeenCalledWith(expect.objectContaining({
      method: 'GET',
      url: '/api/cases/case-1',
    }))
  })

  it('never falls back to cloud AI when a local model runtime is absent', async () => {
    const adapter = new BrowserDevAdapter()

    await expect(adapter.invoke('llm.status')).rejects.toMatchObject<Partial<RuntimeAdapterError>>({
      code: 'MODEL_NOT_INSTALLED',
      state: 'MODEL_NOT_INSTALLED',
    })
    expect(mocks.request).not.toHaveBeenCalled()
  })

  it('simulates voiceprint UI state without ever claiming biometric readiness', async () => {
    const adapter = new BrowserDevAdapter()

    const readiness = await adapter.invoke<{
      suspectReady: boolean
      canStart: boolean
      simulated: boolean
    }>('voiceprint.readiness', { caseId: 'case-1' })

    expect(readiness).toMatchObject({
      suspectReady: false,
      canStart: false,
      simulated: true,
    })
    expect(mocks.request).not.toHaveBeenCalled()
  })
})
