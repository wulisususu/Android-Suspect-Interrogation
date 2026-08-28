import type { TemporaryAsrSpeaker } from '../types/interrogation'
import type { FormalQuestion, FormalQuestionRound, LiveDialogueItem } from '../types/templateInterrogation'

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

export function dialoguePresentation(item: Pick<LiveDialogueItem, 'speaker'>): DialoguePresentation {
  return presentationBySpeaker[item.speaker] ?? presentationBySpeaker.UNKNOWN
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
