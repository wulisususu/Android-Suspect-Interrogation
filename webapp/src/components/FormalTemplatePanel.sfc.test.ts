import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'

const source = readFileSync(new URL('./FormalTemplatePanel.vue', import.meta.url), 'utf8')

describe('FormalTemplatePanel SFC boundary', () => {
  it('keeps scoped styles outside the template block', () => {
    const templateClose = source.indexOf('</template>')
    const scopedStyleOpen = source.indexOf('<style scoped>')

    expect(templateClose).toBeGreaterThan(-1)
    expect(scopedStyleOpen).toBeGreaterThan(-1)
    expect(templateClose).toBeLessThan(scopedStyleOpen)
  })
})
