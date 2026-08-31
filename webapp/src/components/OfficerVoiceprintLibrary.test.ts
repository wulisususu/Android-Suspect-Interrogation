import { readFileSync } from 'node:fs'
import { describe, expect, it } from 'vitest'
import { filterOfficerProfiles, formatAudioInputDescription, formatVoiceprintDuration } from './OfficerVoiceprintLibrary.vue'

const profiles = [
  {
    profileId: 'profile-1', officerId: 'P-001', officerName: '张警官', active: true,
    sampleCount: 2, aggregateVersion: 2, usableDurationMs: 43000, embeddingDim: 3,
    modelId: 'xvector', modelVersion: 'v1', quality: 'AGGREGATED',
  },
  {
    profileId: 'profile-2', officerId: 'P-002', officerName: '李警官', active: false,
    sampleCount: 1, aggregateVersion: 1, usableDurationMs: 21000, embeddingDim: 3,
    modelId: 'xvector', modelVersion: 'v1', quality: 'GOOD',
  },
]

describe('OfficerVoiceprintLibrary', () => {
  it('filters global profiles by officer name or id', () => {
    expect(filterOfficerProfiles(profiles, '张')).toHaveLength(1)
    expect(filterOfficerProfiles(profiles, 'p-002')[0]?.officerName).toBe('李警官')
    expect(filterOfficerProfiles(profiles, '')).toHaveLength(2)
  })

  it('formats retained sample duration without exposing raw audio', () => {
    expect(formatVoiceprintDuration(24000)).toBe('24.0 秒')
    const source = readFileSync(new URL('./OfficerVoiceprintLibrary.vue', import.meta.url), 'utf8')
    expect(source).toContain('添加新样本')
    expect(source).toContain('聚合版本')
    expect(source).toContain('采样设备')
    expect(source).toContain('有效语音')
    expect(source).not.toContain('caseId')
    expect(source).not.toContain('保存原始录音')
  })

  it('shows the detected client platform instead of a hard-coded Windows label', () => {
    expect(formatAudioInputDescription('BROWSER', 'WINDOWS')).toContain('Windows 浏览器麦克风')
    expect(formatAudioInputDescription('BROWSER', 'MACOS')).toContain('macOS 浏览器麦克风')
    expect(formatAudioInputDescription('BROWSER', 'LINUX')).toContain('Linux 浏览器麦克风')
    expect(formatAudioInputDescription('ALSA', 'LINUX')).toContain('Linux 一体机 ALSA 麦克风')
    expect(formatAudioInputDescription('BROWSER', 'WINDOWS')).toContain('当前音源')
    expect(formatAudioInputDescription('BROWSER', 'WINDOWS')).not.toContain('测试音源')
  })
})
