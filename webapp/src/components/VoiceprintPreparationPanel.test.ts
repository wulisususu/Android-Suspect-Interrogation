import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import {
  voiceprintEnrollmentProgress,
  temporarySpeakerPresentation,
  voiceprintModeLabel,
  voiceprintStartGuard,
} from './VoiceprintPreparationPanel.vue'

describe('VoiceprintPreparationPanel helpers', () => {
  it('uses effective speech rather than total recording time for enrollment progress', () => {
    expect(voiceprintEnrollmentProgress({
      capturedDurationMs: 30000,
      usableSpeechMs: 12500,
      requiredUsableSpeechMs: 20000,
    })).toEqual({
      percent: 63,
      usableSeconds: 12,
      targetSeconds: 20,
      recordedSeconds: 30,
      complete: false,
    })
    expect(voiceprintEnrollmentProgress({
      capturedDurationMs: 47000,
      usableSpeechMs: 20000,
      requiredUsableSpeechMs: 20000,
    })).toEqual({
      percent: 100,
      usableSeconds: 20,
      targetSeconds: 20,
      recordedSeconds: 47,
      complete: true,
    })
  })

  it('blocks formal interrogation until the suspect voiceprint is ready', () => {
    expect(voiceprintStartGuard({
      suspectReady: false,
      interrogatorReady: false,
      recorderReady: false,
      recognitionMode: 'SUSPECT_ONLY',
      canStart: false,
    })).toEqual({
      disabled: true,
      reason: '必须先完成嫌疑人声纹注册，才能开始正式语音审讯',
    })
  })

  it('allows suspect-only mode and labels every recognition mode exactly', () => {
    expect(voiceprintStartGuard({
      suspectReady: true,
      interrogatorReady: false,
      recorderReady: false,
      recognitionMode: 'SUSPECT_ONLY',
      canStart: true,
    })).toEqual({ disabled: false, reason: '' })

    expect(voiceprintModeLabel('SUSPECT_ONLY')).toBe('仅嫌疑人声纹识别')
    expect(voiceprintModeLabel('SUSPECT_PLUS_INTERROGATOR')).toBe('嫌疑人 + 主审民警')
    expect(voiceprintModeLabel('SUSPECT_PLUS_RECORDER')).toBe('嫌疑人 + 记录民警')
    expect(voiceprintModeLabel('FULL')).toBe('嫌疑人 + 主审民警 + 记录民警')
  })

  it('renders exact temporary speaker labels without guessing unknown identities', () => {
    expect(temporarySpeakerPresentation('SUSPECT', '张某')).toEqual({
      label: '嫌疑人 · 张某',
      detail: 'ERes2Net-large 声纹匹配',
      needsConfirmation: false,
    })
    expect(temporarySpeakerPresentation('INTERROGATOR', '李警官')).toEqual({
      label: '主审民警 · 李警官',
      detail: 'ERes2Net-large 声纹匹配',
      needsConfirmation: false,
    })
    expect(temporarySpeakerPresentation('RECORDER', '王警官')).toEqual({
      label: '记录民警 · 王警官',
      detail: 'ERes2Net-large 声纹匹配',
      needsConfirmation: false,
    })
    expect(temporarySpeakerPresentation('OFFICER_FALLBACK')).toEqual({
      label: '民警',
      detail: '未启用/未匹配民警声纹，按非嫌疑人规则归类',
      needsConfirmation: false,
    })
    expect(temporarySpeakerPresentation('UNKNOWN')).toEqual({
      label: '待确认',
      detail: '声纹结果不足以可靠归属，请人工确认',
      needsConfirmation: true,
    })
  })

  it('keeps officer administration out of a case and retains binding selectors', () => {
    const source = readFileSync(new URL('./VoiceprintPreparationPanel.vue', import.meta.url), 'utf8')
    expect(source).toContain('选择主审民警声纹')
    expect(source).toContain('选择记录民警声纹')
    expect(source).not.toContain('officer-enrollment-box')
    expect(source).not.toContain('民警编号')
    expect(source).not.toContain('民警姓名')
    expect(source).not.toContain('新注册 / 更新')
    expect(source).not.toContain("officerStart")
    expect(source).not.toContain("revokeOfficer")
  })
})
