import type { TemporaryAsrFragment } from './interrogation'

export type FormalQuestionSource = 'STANDARD' | 'CASE' | 'LIVE'
export type PendingMatchStatus = 'UNMATCHED' | 'AMBIGUOUS' | 'MATCHED_EXISTING'
export type PendingStatus = 'PENDING' | 'DEFERRED' | 'ADDED' | 'LINKED' | 'IGNORED'
export type RoundStatus = 'ACTIVE' | 'CLOSED' | 'DETACHED'

export interface FormalQuestionRound {
  id: string
  caseId: string
  sessionId: string | null
  caseQuestionId: string
  roundNo: number
  actualQuestionText: string
  officerFragmentId: string | null
  answerText: string
  answerFragmentIds: string[]
  status: RoundStatus
  startedAt: string | null
  endedAt: string | null
  createdAt: string | null
  updatedAt: string | null
}

export interface FormalQuestion {
  id: string
  caseId: string
  source: FormalQuestionSource
  standardQuestionId: string | null
  text: string
  regexPatterns: string[]
  aliases: string[]
  sortOrder: number
  active: boolean
  rounds: FormalQuestionRound[]
  createdAt: string | null
  updatedAt: string | null
}

export interface PendingFormalQuestion {
  id: string
  caseId: string
  sessionId: string | null
  officerFragmentId: string
  questionText: string
  matchStatus: PendingMatchStatus
  candidateQuestionIds: string[]
  bufferedAnswerText: string
  bufferedFragmentIds: string[]
  status: PendingStatus
  createdAt: string | null
  updatedAt: string | null
}

export interface StandardQuestion {
  id: string
  text: string
  category: string
  regexPatterns: string[]
  aliases: string[]
  sortOrder: number
  active: boolean
  createdAt: string | null
  updatedAt: string | null
}

export interface TemplateWorkspace {
  caseId: string
  questions: FormalQuestion[]
  rounds: FormalQuestionRound[]
  pendingQuestions: PendingFormalQuestion[]
}

export type LiveDialogueItem = TemporaryAsrFragment

export interface CaseQuestionCreateInput {
  text: string
  source?: FormalQuestionSource
  standardQuestionId?: string | null
  regexPatterns?: string[]
  afterQuestionId?: string | null
}

export interface CaseQuestionUpdateInput {
  text?: string
  regexPatterns?: string[]
}

export type PendingResolution =
  | { action: 'ADD'; afterQuestionId?: string | null }
  | { action: 'LINK'; caseQuestionId: string; roundMode: 'APPEND_EXISTING' | 'NEW_ROUND' }
  | { action: 'IGNORE' }

export interface RoundReassociateInput {
  caseQuestionId?: string | null
  newQuestionText?: string | null
}
