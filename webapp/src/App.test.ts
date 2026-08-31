import { describe, expect, it } from 'vitest'
import source from './App.vue?raw'

describe('root navigation query handling', () => {
  it('preserves unrelated query parameters while switching cases and settings', () => {
    expect(source).toContain('new URL(location.href)')
    expect(source).toContain("next.searchParams.set('caseId', caseId.value)")
    expect(source).toContain("next.searchParams.delete('caseId')")
    expect(source).toContain("next.searchParams.set('view', 'settings')")
    expect(source).toContain("next.searchParams.delete('view')")
    expect(source).not.toContain("new URLSearchParams()")
  })

  it('exposes the global officer voiceprint library outside a case', () => {
    expect(source).toContain('SystemSettingsView')
    expect(source).toContain('系统设置 · 民警声纹库')
  })
})
