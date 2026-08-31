import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import { calibrationStatusLabel, calibrationTone, formatMetric } from './SpeakerCalibrationCenter.vue'

describe('SpeakerCalibrationCenter', () => {
  it('distinguishes hard-expiry and advisory states', () => {
    expect(calibrationTone('STALE_MODEL')).toBe('danger')
    expect(calibrationTone('STALE_MIC')).toBe('danger')
    expect(calibrationTone('RECOMPUTE_RECOMMENDED')).toBe('warn')
    expect(calibrationTone('VALID')).toBe('ok')
    expect(calibrationStatusLabel('INSUFFICIENT_DATA')).toContain('样本不足')
  })

  it('labels local finite-corpus metrics instead of biometric certification', () => {
    expect(formatMetric(0.0123)).toBe('1.23%')
    const source = readFileSync(new URL('./SpeakerCalibrationCenter.vue', import.meta.url), 'utf8')
    expect(source).toContain('Observed FAR')
    expect(source).toContain('Observed FRR')
    expect(source).toContain('Observed EER')
    expect(source).toContain('本机当前民警有限样本')
    expect(source).toContain('XVector 已更换')
    expect(source).toContain('麦克风已更换')
    expect(source).not.toContain('caseId')
  })
})
