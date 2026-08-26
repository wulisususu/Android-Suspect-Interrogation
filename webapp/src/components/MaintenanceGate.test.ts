import { describe, expect, it } from 'vitest'
import source from './MaintenanceGate.vue?raw'


describe('MaintenanceGate source contract', () => {
  it('renders a non-blank maintenance state and retries readiness', () => {
    expect(source).toContain('系统维护中')
    expect(source).toContain('系统正在启动')
    expect(source).toContain('立即重试')
    expect(source).toContain('setInterval')
    expect(source).toContain('fetchReadiness')
  })
})
