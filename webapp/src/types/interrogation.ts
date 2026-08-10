export type Speaker = '民警' | '嫌疑人' | 'AI'

export interface TranscriptMessage {
  id: string
  speaker: Speaker
  text: string
  createdAt?: string
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
}

export interface InquirySsePayload {
  text_chunk?: string
  audio_url?: string
  target?: number
  infos?: Record<string, unknown>
  code?: number
  message?: string
}
