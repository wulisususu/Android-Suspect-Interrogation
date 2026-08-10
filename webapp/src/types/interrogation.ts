export type Speaker = '民警' | '嫌疑人' | 'AI'
export type RecordMark = '' | 'conflict' | 'confirmed' | 'pending'
export type SessionStatus = 'READY' | 'RUNNING' | 'PAUSED' | 'COMPLETED'
export type InterrogationStage = 'IDENTITY' | 'STATEMENT' | 'FOLLOW_UP' | 'SIGNING'

export interface TranscriptMessage {
  id: string
  seq?: number
  speaker: Speaker
  text: string
  mark?: RecordMark
  createdAt?: number | string
  updatedAt?: number | string
  streaming?: boolean
  confirmed?: boolean
}

export type FactStatus = 'confirmed' | 'pending' | 'conflict' | 'missing'

export interface FactItem {
  key: string
  label: string
  value: string
  status: FactStatus
  suggestion?: string
}

export interface TimelineEvent {
  id: string
  time: string
  title: string
  detail: string
  evidence?: string[]
}

export interface CaseSummary {
  id: string
  suspectName: string
  gender?: string
  age?: string
  officerName: string
  state: string
  stage: InterrogationStage
  createdAt?: number
  updatedAt?: number
}

export interface SessionState {
  id: string | null
  caseId: string
  status: SessionStatus
  stage: InterrogationStage
  startedAt: number | null
  pausedAt: number | null
  endedAt: number | null
  updatedAt: number
}

export interface RecordRevision {
  id: string
  qaId: string
  version: number
  oldText: string
  newText: string
  reason: string
  createdAt: number
}

export interface DeviceActionResult {
  success: boolean
  simulated?: boolean
  message?: string
  name?: string
  gender?: string
  idNumber?: string
}

export interface InquirySsePayload {
  text_chunk?: string
  audio_url?: string
  target?: number
  infos?: Record<string, unknown>
  code?: number
  message?: string
}

export interface BackendEnvelope<T> {
  ok: boolean
  code: string
  message: string
  data: T
}
