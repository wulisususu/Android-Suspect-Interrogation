import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import { speakerBackendLabel } from '../api/speakerCalibration'


describe('speaker backend controls', () => {
  it('labels the fixed ERes2Net-large production engine', () => {
    expect(speakerBackendLabel('eres2net_large')).toBe('ERes2Net-large')
  })

  it('system settings exposes ERes2Net-large management without a backend selector', () => {
    const source = readFileSync(new URL('../views/SystemSettingsView.vue', import.meta.url), 'utf8')
    const calibration = readFileSync(new URL('./SpeakerCalibrationCenter.vue', import.meta.url), 'utf8')
    const preparation = readFileSync(new URL('./VoiceprintPreparationPanel.vue', import.meta.url), 'utf8')

    expect(source).toContain('ERes2Net-large')
    expect(source).not.toContain('XVector')
    expect(source).not.toContain('Compare')
    expect(source).not.toContain('authoritative')

    expect(calibration).toContain('模型状态')
    expect(calibration).toContain('校准状态')
    expect(calibration).toContain('ERes2Net-large')
    expect(calibration).not.toContain('XVector')
    expect(calibration).not.toContain('Compare')
    expect(calibration).not.toContain('受控真值')
    expect(calibration).not.toContain('推荐模型')
    expect(calibration).not.toContain('自动选择胜者')

    expect(preparation).toContain('ERes2Net-large 声纹匹配')
    expect(preparation).not.toContain('XVector')
    expect(preparation).not.toContain('双后端')
  })

})
