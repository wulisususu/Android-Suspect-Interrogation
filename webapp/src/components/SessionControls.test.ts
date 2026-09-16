import { describe, expect, it } from 'vitest'
import source from './SessionControls.vue?raw'

describe('session controls', () => {
  it('renders only actions and no separate stage or session status row', () => {
    expect(source).not.toContain('class="session-state"')
    expect(source).not.toContain('当前阶段：')
    expect(source).not.toContain('会话状态：')
  })

  it('renders only actions; the audio source banner lives in the workspace top bar', () => {
    expect(source).not.toContain('VoiceprintAudioSourceBanner')
    expect(source).not.toContain('audio-source')
  })
})
