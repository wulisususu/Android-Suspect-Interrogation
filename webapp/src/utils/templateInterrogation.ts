import type { TemporaryAsrFragment, TemporaryAsrSpeaker } from '../types/interrogation'
import type { FormalQAUnit, FormalQuestion, FormalQuestionRound, LiveDialogueTurn } from '../types/templateInterrogation'

export type DialogueSide = 'left' | 'right' | 'neutral'

export interface DialoguePresentation {
  side: DialogueSide
  badge: string
}

const presentationBySpeaker: Record<TemporaryAsrSpeaker, DialoguePresentation> = {
  SUSPECT: { side: 'left', badge: '嫌疑人' },
  INTERROGATOR: { side: 'right', badge: '主审' },
  RECORDER: { side: 'right', badge: '记录员' },
  OFFICER_FALLBACK: { side: 'right', badge: '民警' },
  UNKNOWN: { side: 'neutral', badge: '待识别' },
}

export function dialoguePresentation(item: Pick<TemporaryAsrFragment, 'speaker'>): DialoguePresentation {
  return presentationBySpeaker[item.speaker] ?? presentationBySpeaker.UNKNOWN
}

function textOf(fragment: TemporaryAsrFragment): string {
  return (fragment.editedText || fragment.rawText || '').trim()
}

function timestamp(value: string | number | null | undefined): number {
  if (typeof value === 'number') return value
  const parsed = value ? Date.parse(value) : Number.NaN
  return Number.isFinite(parsed) ? parsed : Number.MAX_SAFE_INTEGER
}

export function liveDialogueTurns(units: FormalQAUnit[], fragments: TemporaryAsrFragment[]): LiveDialogueTurn[] {
  const linkedFragmentIds = new Set<string>()
  const orderedUnits = [...units].sort((left, right) => (
    timestamp(left.startedAt) - timestamp(right.startedAt)
    || timestamp(left.createdAt) - timestamp(right.createdAt)
    || left.id.localeCompare(right.id)
  ))
  const turns: Array<LiveDialogueTurn & { order: number; sequence: number }> = []

  orderedUnits.forEach((unit, index) => {
    unit.questionFragmentIds.forEach((id) => linkedFragmentIds.add(id))
    unit.answerFragmentIds.forEach((id) => linkedFragmentIds.add(id))
    const ordinal = index + 1
    const order = timestamp(unit.startedAt || unit.createdAt)
    const question = unit.rawQuestionText.trim()
    const answer = unit.rawAnswerText.trim()
    if (question) turns.push({ kind: 'QUESTION', key: `question:${unit.id}`, unitId: unit.id, ordinal, text: question, startedAt: unit.startedAt, order, sequence: 0 })
    if (answer) turns.push({ kind: 'ANSWER', key: `answer:${unit.id}`, unitId: unit.id, ordinal, text: answer, startedAt: unit.startedAt, order, sequence: 1 })
  })

  fragments.forEach((fragment) => {
    const text = textOf(fragment)
    if (linkedFragmentIds.has(fragment.id) || fragment.speaker !== 'UNKNOWN' || !text) return
    turns.push({ kind: 'UNCONFIRMED', key: `fragment:${fragment.id}`, fragment, text, startedAt: null, order: timestamp(fragment.createdAt), sequence: fragment.ordinal })
  })

  return turns
    .sort((left, right) => left.order - right.order || left.sequence - right.sequence || left.key.localeCompare(right.key))
    .map(({ order: _order, sequence: _sequence, ...turn }) => turn)
}

export interface FormalQuestionRoundGroup {
  question: FormalQuestion
  rounds: FormalQuestionRound[]
}

function startedAtValue(round: FormalQuestionRound): number {
  const parsed = round.startedAt ? Date.parse(round.startedAt) : Number.NaN
  return Number.isFinite(parsed) ? parsed : Number.MAX_SAFE_INTEGER
}

export function roundGroups(questions: FormalQuestion[], rounds: FormalQuestionRound[]): FormalQuestionRoundGroup[] {
  const orderedQuestions = [...questions].sort((left, right) => left.sortOrder - right.sortOrder)
  return orderedQuestions.map((question) => ({
    question,
    rounds: rounds
      .filter((round) => round.caseQuestionId === question.id && round.status !== 'DETACHED')
      .sort((left, right) => startedAtValue(left) - startedAtValue(right) || left.roundNo - right.roundNo),
  }))
}
