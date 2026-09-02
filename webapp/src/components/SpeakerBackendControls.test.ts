import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import {
  speakerBackendLabel,
  validateSpeakerRuntimeSelection,
  type SpeakerBackendKey,
  type SpeakerRuntimeMode,
} from '../api/speakerCalibration'


describe('speaker backend controls', () => {
  it('labels all runtime modes and requires an authority only for compare', () => {
    expect(speakerBackendLabel('xvector')).toBe('XVector')
    expect(speakerBackendLabel('eres2net_large')).toBe('ERes2Net-large')

    expect(validateSpeakerRuntimeSelection('xvector', null)).toEqual({ valid: true, reason: '' })
    expect(validateSpeakerRuntimeSelection('eres2net_large', null)).toEqual({ valid: true, reason: '' })
    expect(validateSpeakerRuntimeSelection('compare', null)).toEqual({
      valid: false,
      reason: 'Compare 模式必须指定业务 authoritative backend',
    })
    expect(validateSpeakerRuntimeSelection('compare', 'xvector')).toEqual({ valid: true, reason: '' })
  })

  it('keeps the public mode/backend unions exact', () => {
    const backends: SpeakerBackendKey[] = ['xvector', 'eres2net_large']
    const modes: SpeakerRuntimeMode[] = ['xvector', 'eres2net_large', 'compare']
    expect(backends).toHaveLength(2)
    expect(modes).toHaveLength(3)
  })

  it('system settings exposes ERes2Net-large management without a backend selector', () => {
    const source = readFileSync(new URL('../views/SystemSettingsView.vue', import.meta.url), 'utf8')
    const calibration = readFileSync(new URL('./SpeakerCalibrationCenter.vue', import.meta.url), 'utf8')

    expect(source).toContain('ERes2Net-large')
    expect(source).not.toContain('XVector')
    expect(source).not.toContain('Compare')
    expect(source).not.toContain('authoritative')

    expect(calibration).toContain('模型状态')
    expect(calibration).toContain('校准状态')
    expect(calibration).toContain('UNKNOWN')
    expect(calibration).toContain('Latency')
    expect(calibration).toContain('正确角色率')
    expect(calibration).toContain('受控真值')
    expect(calibration).not.toContain('推荐模型')
    expect(calibration).not.toContain('自动选择胜者')
  })

})
