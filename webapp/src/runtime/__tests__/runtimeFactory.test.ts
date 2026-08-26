import { describe, expect, it } from 'vitest'
import { resolveRuntimeKind } from '../index'

describe('resolveRuntimeKind', () => {
  it('selects browser-dev only when explicitly requested', () => {
    expect(resolveRuntimeKind({ requestedMode: 'browser-dev' })).toBe('browser-dev')
  })

  it('uses Linux HTTP/WebSocket as the default runtime', () => {
    expect(resolveRuntimeKind({ requestedMode: undefined })).toBe('linux-http-ws')
  })
})
