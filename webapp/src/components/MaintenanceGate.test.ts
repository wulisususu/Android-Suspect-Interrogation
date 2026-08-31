import { describe, expect, it } from 'vitest'
import source from './MaintenanceGate.vue?raw'


describe('MaintenanceGate source contract', () => {
  it('uses the lightweight liveness probe for the global application gate', () => {
    expect(source).toContain('fetchLive')
    expect(source).not.toContain('fetchReadiness')
  })

  it('keeps transient backend stalls from immediately unmounting the business workspace', () => {
    expect(source).toContain('MAX_CONSECUTIVE_FAILURES')
    expect(source).toContain('consecutiveFailures')
    expect(source).toContain('系统维护中')
    expect(source).toContain('系统正在启动')
    expect(source).toContain('立即重试')
    expect(source).toContain('setInterval')
  })
})
