import { describe, expect, it } from 'vitest'

import { dialoguePresentation, roundGroups } from './templateInterrogation'


describe('dialoguePresentation', () => {
  it('places suspect on the left and police roles on the right', () => {
    expect(dialoguePresentation({ speaker: 'SUSPECT' } as any)).toMatchObject({ side: 'left', badge: '嫌疑人' })
    expect(dialoguePresentation({ speaker: 'INTERROGATOR' } as any)).toMatchObject({ side: 'right', badge: '主审' })
    expect(dialoguePresentation({ speaker: 'RECORDER' } as any)).toMatchObject({ side: 'right', badge: '记录员' })
    expect(dialoguePresentation({ speaker: 'OFFICER_FALLBACK' } as any)).toMatchObject({ side: 'right', badge: '民警' })
  })

  it('keeps unknown attribution neutral without surfacing confidence as a business marker', () => {
    expect(dialoguePresentation({ speaker: 'UNKNOWN', lowConfidence: true } as any)).toEqual({
      side: 'neutral',
      badge: '待识别',
    })
  })
})


describe('roundGroups', () => {
  it('groups multiple rounds under formal questions and orders rounds by startedAt', () => {
    const questions = [
      { id: 'q2', text: '第二问', sortOrder: 20 },
      { id: 'q1', text: '第一问', sortOrder: 10 },
    ] as any
    const rounds = [
      { id: 'r2', caseQuestionId: 'q1', roundNo: 2, startedAt: '2026-08-28T10:05:00+08:00' },
      { id: 'r3', caseQuestionId: 'q2', roundNo: 1, startedAt: '2026-08-28T10:03:00+08:00' },
      { id: 'r1', caseQuestionId: 'q1', roundNo: 1, startedAt: '2026-08-28T10:01:00+08:00' },
    ] as any

    const groups = roundGroups(questions, rounds)

    expect(groups.map((group) => group.question.id)).toEqual(['q1', 'q2'])
    expect(groups[0].rounds.map((round) => round.id)).toEqual(['r1', 'r2'])
    expect(groups[1].rounds.map((round) => round.id)).toEqual(['r3'])
  })

  it('does not derive chronological order from round number or UI fold state', () => {
    const groups = roundGroups(
      [{ id: 'q1', text: '第一问', sortOrder: 10 }] as any,
      [
        { id: 'later-number', caseQuestionId: 'q1', roundNo: 1, startedAt: '2026-08-28T10:10:00+08:00', expanded: true },
        { id: 'earlier-time', caseQuestionId: 'q1', roundNo: 9, startedAt: '2026-08-28T09:00:00+08:00', expanded: false },
      ] as any,
    )

    expect(groups[0].rounds.map((round) => round.id)).toEqual(['earlier-time', 'later-number'])
  })
})
