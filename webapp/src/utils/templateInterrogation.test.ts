import { describe, expect, it } from 'vitest'

import { dialoguePresentation, groupLiveDialogueFragments, liveDialogueTurns, roundGroups } from './templateInterrogation'


describe('dialoguePresentation', () => {
  it('places suspect on the left and police roles on the right', () => {
    expect(dialoguePresentation({ speaker: 'SUSPECT' } as any)).toMatchObject({ side: 'left', badge: '嫌疑人' })
    expect(dialoguePresentation({ speaker: 'INTERROGATOR' } as any)).toMatchObject({ side: 'right', badge: '主审' })
    expect(dialoguePresentation({ speaker: 'RECORDER' } as any)).toMatchObject({ side: 'right', badge: '记录员' })
    expect(dialoguePresentation({ speaker: 'OFFICER_FALLBACK' } as any)).toMatchObject({ side: 'right', badge: '民警' })
  })

  it('keeps unknown attribution in the chronological raw transcript without surfacing confidence as a business marker', () => {
    expect(dialoguePresentation({ speaker: 'UNKNOWN', lowConfidence: true } as any)).toEqual({
      side: 'left',
      badge: '待识别',
    })
  })
})

describe('groupLiveDialogueFragments', () => {
  it('renders adjacent suspect VAD chunks as one readable turn without merging other speakers', () => {
    const groups = groupLiveDialogueFragments([
      { id: 'a1', rawText: '我先翻了后墙，', speaker: 'SUSPECT', speakerId: 'suspect:1', startedAtMs: 0, endedAtMs: 2200, ordinal: 1, createdAt: 1 } as any,
      { id: 'a2', rawText: '然后从厨房进去。', speaker: 'SUSPECT', speakerId: 'suspect:1', startedAtMs: 2300, endedAtMs: 4300, ordinal: 2, createdAt: 2 } as any,
      { id: 'q1', rawText: '你确定吗？', speaker: 'INTERROGATOR', startedAtMs: 4400, endedAtMs: 5100, ordinal: 3, createdAt: 3 } as any,
    ])

    expect(groups).toHaveLength(2)
    expect(groups[0].text).toBe('我先翻了后墙，然后从厨房进去。')
    expect(groups[0].fragments.map((item) => item.id)).toEqual(['a1', 'a2'])
    expect(groups[1].primary.id).toBe('q1')
  })
})


describe('liveDialogueTurns', () => {
  it('merges attributed VAD chunks into question and answer turns while leaving unknown speech unassigned', () => {
    const units = [{
      id: 'unit-1',
      startedAt: '2026-09-03T08:00:00Z',
      createdAt: '2026-09-03T08:00:00Z',
      rawQuestionText: '你叫什么名字？ 把基本情况说一下。',
      rawAnswerText: '我叫张伟。 目前在物流公司上班。',
      questionFragmentIds: ['q1', 'q2'],
      answerFragmentIds: ['a1', 'a2'],
    }] as any
    const fragments = [
      { id: 'q1', rawText: '你叫什么名字？', speaker: 'INTERROGATOR', startedAtMs: 0, ordinal: 1 },
      { id: 'q2', rawText: '把基本情况说一下。', speaker: 'INTERROGATOR', startedAtMs: 700, ordinal: 2 },
      { id: 'a1', rawText: '我叫张伟。', speaker: 'SUSPECT', startedAtMs: 1500, ordinal: 3 },
      { id: 'a2', rawText: '目前在物流公司上班。', speaker: 'SUSPECT', startedAtMs: 2500, ordinal: 4 },
      { id: 'u1', rawText: '听不清的话', speaker: 'UNKNOWN', startedAtMs: 3000, ordinal: 5 },
    ] as any

    const turns = liveDialogueTurns(units, fragments)

    expect(turns.map((turn) => turn.text)).toEqual([
      '你叫什么名字？ 把基本情况说一下。',
      '我叫张伟。 目前在物流公司上班。',
      '听不清的话',
    ])
    expect(turns[2]).toMatchObject({ kind: 'UNCONFIRMED', key: 'fragment:u1' })
    expect(turns.map((turn) => turn.text)).not.toContain('你叫什么名字？')
    expect(turns.map((turn) => turn.text)).not.toContain('目前在物流公司上班。')
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
