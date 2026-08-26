import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'


describe('MaintenanceGate source contract', () => {
  const source = readFileSync(new URL('./MaintenanceGate.vue', import.meta.url), 'utf8')

  it('renders a non-blank maintenance state and retries readiness', () => {
    expect(source).toContain('系统维护中')
    expect(source).toContain('系统正在启动')
    expect(source).toContain('立即重试')
    expect(source).toContain("setInterval")
    expect(source).toContain("fetchReadiness")
  })
})
