import { describe, expect, it } from 'vitest'
import type { AsrInsertionTarget, TemporaryAsrFragment, TranscriptMessage } from '../types/interrogation'
import { buildAsrInsertion, isAsrTargetUsable } from './asrInsertion'

const message: TranscriptMessage = {
  id: 'record-1',
  seq: 1,
  speaker: '民警',
  text: '请说明经过。',
  mark: '',
  confirmed: true,
}

function target(overrides: Partial<AsrInsertionTarget> = {}): AsrInsertionTarget {
  return {
    caseId: 'case-a',
    recordId: message.id,
    selectionStart: 2,
    selectionEnd: 2,
    sourceText: message.text,
    ...overrides,
  }
}

function fragment(overrides: Partial<TemporaryAsrFragment> = {}): TemporaryAsrFragment {
  return {
    id: 'fragment-1',
    captureSessionId: 'capture-a',
    caseId: 'case-a',
    ordinal: 1,
    startedAtMs: 1,
    endedAtMs: 2,
    rawText: '本次识别',
    editedText: '本次识别',
    speaker: 'UNKNOWN',
    speakerSource: 'UNASSIGNED',
    confidence: 0.8,
    confidenceSource: 'SHERPA_TOKEN_LOG_PROBS',
    lowConfidence: false,
    state: 'PENDING',
    confirmedQaId: null,
    audio: { captureSessionId: 'capture-a', startOffsetMs: 0, endOffsetMs: 1, available: true },
    createdAt: 1,
    updatedAt: 1,
    ...overrides,
  }
}

describe('targeted ASR insertion', () => {
  it('accepts only a target from the current case and current formal records', () => {
    expect(isAsrTargetUsable(target(), 'case-a', [message])).toBe(true)
    expect(isAsrTargetUsable(null, 'case-a', [message])).toBe(false)
    expect(isAsrTargetUsable(target({ caseId: 'case-b' }), 'case-a', [message])).toBe(false)
    expect(isAsrTargetUsable(target({ recordId: 'missing' }), 'case-a', [message])).toBe(false)
  })

  it('inserts current-session fragments at the caret in ordinal order', () => {
    const result = buildAsrInsertion(target(), 'capture-a', [
      fragment({ id: 'fragment-2', ordinal: 2, editedText: '文字' }),
      fragment({ id: 'foreign', captureSessionId: 'capture-b', editedText: '不能写入' }),
      fragment({ id: 'fragment-1', ordinal: 1, editedText: '识别' }),
    ])

    expect(result).toEqual({
      text: '请说识别文字明经过。',
      recognizedText: '识别文字',
      caretPosition: 6,
      fragmentIds: ['fragment-1', 'fragment-2'],
    })
  })

  it('replaces a selected range and normalizes reversed bounds', () => {
    const result = buildAsrInsertion(
      target({ sourceText: '甲乙丙丁', selectionStart: 3, selectionEnd: 1 }),
      'capture-a',
      [fragment({ editedText: '替换' })],
    )

    expect(result?.text).toBe('甲替换丁')
    expect(result?.caretPosition).toBe(3)
  })

  it('clamps out-of-range positions and appends at the end', () => {
    const result = buildAsrInsertion(
      target({ sourceText: '原文', selectionStart: 99, selectionEnd: 99 }),
      'capture-a',
      [fragment({ editedText: '追加' })],
    )

    expect(result?.text).toBe('原文追加')
    expect(result?.caretPosition).toBe(4)
  })

  it('returns null when this capture produced no non-blank final text', () => {
    expect(buildAsrInsertion(target(), 'capture-a', [fragment({ editedText: '  ', rawText: '  ' })])).toBeNull()
    expect(buildAsrInsertion(target(), 'capture-a', [fragment({ captureSessionId: 'capture-b' })])).toBeNull()
  })
})
