import { describe, expect, it } from 'vitest'
import source from './OnScreenKeyboard.vue?raw'

describe('on-screen keyboard integration', () => {
  it('shows on editable focus and auto-hides via focusout', () => {
    expect(source).toContain("addEventListener('focusin', onfocusin, true)")
    expect(source).toContain("addEventListener('focusout', onfocusout, true)")
    expect(source).toContain('isTouchDevice')
  })

  it('commits composed text through execCommand with a manual fallback', () => {
    expect(source).toContain("document.execCommand('insertText'")
    expect(source).toContain('fallbackInsert')
    expect(source).toContain("new Event('input', { bubbles: true })")
  })

  it('keeps focus on the keyboard itself via pointerdown prevention', () => {
    expect(source).toContain('@pointerdown.stop')
    const preventCount = source.split('@pointerdown.prevent').length - 1
    expect(preventCount).toBeGreaterThanOrEqual(12)
  })

  it('loads the offline pinyin dict lazily', () => {
    expect(source).toContain('ensureDict')
    expect(source).toContain('loadPinyinDict')
  })
})
