import { describe, expect, it } from 'vitest'

import type { MossTranscriptSegment } from '../types/mossTranscription'
import {
  MOSS_ACTIVE_POLL_STATES,
  formatAudioClockMs,
  isActiveMossState,
  mossSegmentHeading,
  mossStateUi,
  mossWindowStateUi,
  normalizeMappingRows,
  sortMossSegments,
  isValidMossGlobalSpeaker,
} from './mossTranscription'

describe('moss state ui mapping', () => {
  it('mirrors the pinned 12-state enum and the active poll set', () => {
    expect(MOSS_ACTIVE_POLL_STATES).toEqual([
      'QUEUED',
      'PREPARING',
      'ENCODING',
      'BUILDING_EMBEDS',
      'DECODING',
      'PARSING',
      'REMAPPING',
      'MERGING',
    ])
  })

  it('maps queued/processing/completed/failed/recovery per the panel spec', () => {
    expect(mossStateUi('QUEUED')).toEqual({ icon: '🕒', label: '排队', tone: 'queued' })
    expect(mossStateUi('PARSING').label).toBe('处理中')
    expect(mossStateUi('MERGING').icon).toBe('⏳')
    expect(mossStateUi('COMPLETED')).toEqual({ icon: '✅', label: '完成', tone: 'done' })
    expect(mossStateUi('FAILED').tone).toBe('failed')
    expect(mossStateUi('CANCELLED').icon).toBe('❌')
    expect(mossStateUi('RECOVERY_REQUIRED')).toEqual({ icon: '⚠️', label: '需恢复', tone: 'recover' })
  })

  it('falls back to the raw state label for unknown states', () => {
    expect(mossStateUi('SOMETHING_NEW')).toEqual({ icon: '•', label: 'SOMETHING_NEW', tone: 'active' })
    expect(mossStateUi(undefined).label).toBe('未知')
  })

  it('keeps window icons aligned with the worker WindowState enum', () => {
    expect(mossWindowStateUi('PENDING').icon).toBe('🕒')
    expect(mossWindowStateUi('RUNNING').icon).toBe('⏳')
    expect(mossWindowStateUi('DONE').icon).toBe('✅')
    expect(mossWindowStateUi('FAILED').icon).toBe('❌')
  })

  it('classifies active poll states', () => {
    expect(isActiveMossState('QUEUED')).toBe(true)
    expect(isActiveMossState('COMPLETED')).toBe(false)
    expect(isActiveMossState('RECOVERY_REQUIRED')).toBe(false)
  })
})

describe('moss audio clock formatting', () => {
  it('formats startMs as an in-audio HH:MM:SS clock', () => {
    expect(formatAudioClockMs(0)).toBe('00:00:00')
    expect(formatAudioClockMs(12_000)).toBe('00:00:12')
    expect(formatAudioClockMs(3_723_456)).toBe('01:02:03')
    expect(formatAudioClockMs(36_000_000 + 3_661_000)).toBe('11:01:01')
  })

  it('degrades gracefully for missing or invalid values', () => {
    expect(formatAudioClockMs(null)).toBe('--:--:--')
    expect(formatAudioClockMs(undefined)).toBe('--:--:--')
    expect(formatAudioClockMs(-5)).toBe('--:--:--')
    expect(formatAudioClockMs(Number.NaN)).toBe('--:--:--')
  })
})

describe('moss transcript helpers', () => {
  const segment = (overrides: Partial<MossTranscriptSegment>): MossTranscriptSegment => ({
    segmentId: 's1',
    windowId: 'w0001',
    startMs: 0,
    endMs: 1000,
    localSpeaker: 'S01',
    gs: 'GS01',
    role: null,
    text: '',
    parseStatus: 'VALID',
    mergeStatus: 'PRIMARY',
    modelManifestSha256: 'manifest',
    ...overrides,
  })

  it('sorts segments by startMs ascending', () => {
    const sorted = sortMossSegments([
      segment({ segmentId: 'b', startMs: 5_000 }),
      segment({ segmentId: 'c', startMs: 1_000 }),
      segment({ segmentId: 'a', startMs: 1_000, endMs: 500 }),
    ])
    expect(sorted.map((item) => item.segmentId)).toEqual(['a', 'c', 'b'])
  })

  it('renders the heading as 角色（GSxx）and degrades to GSxx when role is null', () => {
    expect(mossSegmentHeading(segment({ role: '民警', gs: 'GS01' }))).toBe('民警（GS01）')
    expect(mossSegmentHeading(segment({ role: null, gs: 'GS02' }))).toBe('GS02')
    expect(mossSegmentHeading(segment({ role: null, gs: null }))).toBe('未知说话人')
  })
})

describe('moss speaker mapping normalization', () => {
  it('trims, uppercases labels and drops blank rows like the backend', () => {
    expect(
      normalizeMappingRows([
        { globalSpeaker: ' gs1 ', role: ' 民警 ' },
        { globalSpeaker: '', role: '' },
        { globalSpeaker: 'gs2', role: '嫌疑人' },
      ]),
    ).toEqual([
      { globalSpeaker: 'GS1', role: '民警' },
      { globalSpeaker: 'GS2', role: '嫌疑人' },
    ])
  })

  it('validates GSxx labels the same way the API does', () => {
    expect(isValidMossGlobalSpeaker('GS01')).toBe(true)
    expect(isValidMossGlobalSpeaker('GS123')).toBe(true)
    expect(isValidMossGlobalSpeaker('gs01')).toBe(false)
    expect(isValidMossGlobalSpeaker('G01')).toBe(false)
    expect(isValidMossGlobalSpeaker('')).toBe(false)
  })
})
