import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'

const source = readFileSync(new URL('./CaseListView.vue', import.meta.url), 'utf8')

describe('CaseListView search contract', () => {
  it('requires an explicit full-name query and starts identity search at seven digits', () => {
    expect(source).toContain('@submit.prevent="submitSearch"')
    expect(source).toContain('return /^\\d{7,}$/.test(value)')
    expect(source).toContain('fetchCases(query ? 100 : 50, query)')
  })

  it('labels the two accepted search modes for the operator', () => {
    expect(source).toContain('输入完整姓名，或身份证前 7 位')
    expect(source).toContain('aria-label="按姓名或身份证搜索"')
  })
})
