import { describe, expect, it } from 'vitest'
import { BrowserCaptureResumeGate } from './browserCaptureResumeGate'

describe('browser capture resume gate', () => {
  it('retries lease acquisition after a short delay and reports the conflict only once', () => {
    const gate = new BrowserCaptureResumeGate()
    const key = 'CASE-001:CAPTURE-001'

    expect(gate.shouldAttempt(key, 1_000)).toBe(true)
    gate.markAttempted(key)
    expect(gate.shouldAttempt(key, 1_000)).toBe(false)

    expect(gate.leaseConflict(key, 1_000)).toBe(true)
    expect(gate.shouldAttempt(key, 2_499)).toBe(false)
    expect(gate.shouldAttempt(key, 2_500)).toBe(true)
    gate.markAttempted(key)

    expect(gate.leaseConflict(key, 2_500)).toBe(false)
    expect(gate.shouldAttempt(key, 4_000)).toBe(true)
  })

  it('resets the retry and one-time notice state after capture stops', () => {
    const gate = new BrowserCaptureResumeGate()
    const key = 'CASE-001:CAPTURE-001'
    gate.markAttempted(key)
    gate.leaseConflict(key, 1_000)
    gate.reset()

    expect(gate.shouldAttempt(key, 1_001)).toBe(true)
    expect(gate.leaseConflict(key, 1_001)).toBe(true)
  })
})
