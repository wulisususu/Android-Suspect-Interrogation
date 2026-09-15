import { describe, expect, it } from 'vitest'
import source from './SessionControls.vue?raw'

describe('session controls', () => {
  it('renders only actions and no separate stage or session status row', () => {
    expect(source).not.toContain('class="session-state"')
    expect(source).not.toContain('当前阶段：')
    expect(source).not.toContain('会话状态：')
  })

  it('places compact audio status above the session action buttons', () => {
    expect(source).toContain('VoiceprintAudioSourceBanner')
    expect(source).toContain('compact')
    expect(source.indexOf('VoiceprintAudioSourceBanner')).toBeLessThan(source.indexOf('session-buttons'))
  })
})
