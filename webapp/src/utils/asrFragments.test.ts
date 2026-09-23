import { describe, expect, it } from 'vitest'
import type { TemporaryAsrFragment } from '../types/interrogation'
import {
  removeReplacedAsrFragmentSelection,
  replaceAsrFragmentGroup,
  upsertAsrFragmentByCaptureTime,
} from './asrFragments'

function fragment(id: string, startedAtMs: number, ordinal: number): TemporaryAsrFragment {
  return {
    id,
    captureSessionId: 'capture-1',
    caseId: 'case-1',
    ordinal,
    startedAtMs,
    endedAtMs: startedAtMs + 500,
    rawText: id,
    editedText: id,
    speaker: 'UNKNOWN',
    speakerSource: 'UNASSIGNED',
    voiceprintVerified: false,
    confidenceSource: 'UNAVAILABLE',
    lowConfidence: true,
    state: 'PENDING',
    recognitionRevisions: [],
  }
}

describe('live ASR fragment timeline', () => {
  it('inserts delayed fragments by captured audio time instead of result ordinal', () => {
    const later = fragment('later', 2000, 2)
    const delayed = fragment('delayed', 1000, 20)

    expect(upsertAsrFragmentByCaptureTime([later], delayed).map((item) => item.id))
      .toEqual(['delayed', 'later'])
  })

  it('replaces a superseded parent with children in capture order', () => {
    const parent = fragment('parent', 1000, 1)
    const later = fragment('later', 2000, 2)
    const firstChild = fragment('child-1', 1000, 20)
    const secondChild = fragment('child-2', 1500, 21)

    expect(replaceAsrFragmentGroup(
      [parent, later],
      'parent',
      [secondChild, firstChild],
    ).map((item) => item.id)).toEqual(['child-1', 'child-2', 'later'])
  })

  it('clears selection for a superseded parent while preserving other selections', () => {
    expect(removeReplacedAsrFragmentSelection(['parent', 'later'], 'parent'))
      .toEqual(['later'])
  })
})
