import { describe, expect, it } from 'vitest'
import { resolveRuntimeKind } from '../index'

describe('resolveRuntimeKind', () => {
  it('prefers Android NativeBridge when the bridge is available', () => {
    expect(resolveRuntimeKind({ nativeAvailable: true, requestedMode: 'linux' })).toBe('android-native')
  })

  it('selects browser-dev only when explicitly requested', () => {
    expect(resolveRuntimeKind({ nativeAvailable: false, requestedMode: 'browser-dev' })).toBe('browser-dev')
  })

  it('uses Linux HTTP/WebSocket as the default browser runtime', () => {
    expect(resolveRuntimeKind({ nativeAvailable: false, requestedMode: undefined })).toBe('linux-http-ws')
  })
})
