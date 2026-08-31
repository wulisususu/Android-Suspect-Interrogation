import { describe, expect, it } from 'vitest'
import source from './App.vue?raw'

describe('case navigation query handling', () => {
  it('preserves the selected audio input when entering and leaving a case', () => {
    expect(source).toContain('new URL(location.href)')
    expect(source).toContain("searchParams.set('caseId', id)")
    expect(source).toContain("searchParams.delete('caseId')")
  })
})
