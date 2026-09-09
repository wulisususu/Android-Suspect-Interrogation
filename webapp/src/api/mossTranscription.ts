// MOSS 智能分人转写业务 API（Task 16）。
// 完全复用 webapp 现有 axios http 实例与 {ok, data, message} 信封惯例
// （同 api/speakerCalibration.ts），错误额外保留后端 code（如 MOSS_DISABLED）。
import { http } from './http'
import type {
  MossSpeakerMapping,
  MossTranscript,
  MossTranscriptionStatus,
} from '../types/mossTranscription'

export const MOSS_DISABLED_CODE = 'MOSS_DISABLED'
export const MOSS_TRANSCRIPTION_NOT_FOUND_CODE = 'MOSS_TRANSCRIPTION_NOT_FOUND'

/** 携带后端信封 code 的 API 错误，供面板识别 MOSS_DISABLED / 404 等语义。 */
export class MossApiError extends Error {
  readonly code: string
  readonly status: number

  constructor(code: string, message: string, status = 0) {
    super(message)
    this.name = 'MossApiError'
    this.code = code
    this.status = status
  }
}

interface ApiEnvelope<T> {
  ok?: boolean
  code?: string
  message?: string
  data?: T
}

function envelopeMessage(envelope: ApiEnvelope<unknown>): string {
  return envelope.message || envelope.code || 'MOSS 转写接口返回错误'
}

function unwrap<T>(payload: unknown): T {
  if (payload && typeof payload === 'object' && 'ok' in payload) {
    const envelope = payload as ApiEnvelope<T>
    if (envelope.ok === false) throw new MossApiError(envelope.code || 'MOSS_UNKNOWN_ERROR', envelopeMessage(envelope))
    return envelope.data as T
  }
  return payload as T
}

/** axios 拒绝时从 response.data 信封恢复 code/message，其余错误原样抛出。 */
function rethrowEnvelopeError(error: unknown): never {
  if (error instanceof MossApiError) throw error
  const response = (error as { response?: { status?: number; data?: unknown } } | null)?.response
  const data = response?.data
  if (data && typeof data === 'object' && 'ok' in data && (data as ApiEnvelope<unknown>).ok === false) {
    const envelope = data as ApiEnvelope<unknown>
    throw new MossApiError(envelope.code || 'MOSS_UNKNOWN_ERROR', envelopeMessage(envelope), response?.status ?? 0)
  }
  throw error
}

async function request<T>(run: () => Promise<{ data: unknown }>): Promise<T> {
  try {
    return unwrap<T>((await run()).data)
  } catch (error) {
    rethrowEnvelopeError(error)
  }
}

function asRecord(value: unknown): Record<string, unknown> {
  return value && typeof value === 'object' && !Array.isArray(value) ? (value as Record<string, unknown>) : {}
}

function nullableString(value: unknown): string | null {
  return value === null || value === undefined ? null : String(value)
}

function nullableNumber(value: unknown): number | null {
  if (value === null || value === undefined || value === '') return null
  const parsed = Number(value)
  return Number.isFinite(parsed) ? parsed : null
}

function normalizeState(value: unknown): MossTranscriptionStatus['state'] {
  return String(value ?? 'QUEUED').toUpperCase() as MossTranscriptionStatus['state']
}

function normalizeWindows(value: unknown): MossTranscriptionStatus['windows'] {
  if (!Array.isArray(value)) return []
  return value.map((item) => {
    const raw = asRecord(item)
    return {
      windowId: String(raw.windowId ?? ''),
      startMs: Number(raw.startMs ?? 0),
      endMs: Number(raw.endMs ?? 0),
      state: String(raw.state ?? ''),
      segmentCount: Number(raw.segmentCount ?? 0),
    }
  })
}

function normalizeMossStatus(value: unknown): MossTranscriptionStatus {
  const raw = asRecord(value)
  return {
    caseId: String(raw.caseId ?? ''),
    transcriptionId: String(raw.transcriptionId ?? ''),
    jobId: String(raw.jobId ?? ''),
    state: normalizeState(raw.state),
    revisionNo: nullableNumber(raw.revisionNo),
    error: nullableString(raw.error),
    audioPath: nullableString(raw.audioPath),
    audioSha256: nullableString(raw.audioSha256),
    modelManifestSha256: nullableString(raw.modelManifestSha256),
    windows: normalizeWindows(raw.windows),
    createdAt: nullableString(raw.createdAt),
    updatedAt: nullableString(raw.updatedAt),
  }
}

function normalizeMossTranscript(value: unknown): MossTranscript {
  const raw = asRecord(value)
  const segments = Array.isArray(raw.segments) ? raw.segments : []
  return {
    caseId: String(raw.caseId ?? ''),
    transcriptionId: String(raw.transcriptionId ?? ''),
    jobId: String(raw.jobId ?? ''),
    state: normalizeState(raw.state),
    revisionNo: nullableNumber(raw.revisionNo),
    segments: segments.map((item) => {
      const seg = asRecord(item)
      return {
        segmentId: nullableString(seg.segmentId),
        windowId: nullableString(seg.windowId),
        startMs: Number(seg.startMs ?? 0),
        endMs: Number(seg.endMs ?? 0),
        localSpeaker: nullableString(seg.localSpeaker),
        gs: nullableString(seg.gs),
        role: nullableString(seg.role),
        text: String(seg.text ?? ''),
        parseStatus: nullableString(seg.parseStatus),
        mergeStatus: nullableString(seg.mergeStatus),
        modelManifestSha256: nullableString(seg.modelManifestSha256),
      }
    }),
  }
}

function normalizeMappings(value: unknown): MossSpeakerMapping[] {
  if (!Array.isArray(value)) return []
  return value.map((item) => {
    const raw = asRecord(item)
    return { globalSpeaker: String(raw.globalSpeaker ?? ''), role: String(raw.role ?? '') }
  })
}

const transcriptionRoute = (caseId: string, suffix = '') => `/api/v1/cases/${encodeURIComponent(caseId)}/moss-transcription${suffix}`
const mappingRoute = (caseId: string) => `/api/v1/cases/${encodeURIComponent(caseId)}/moss-speaker-mapping`

export async function fetchMossTranscriptionStatus(caseId: string): Promise<MossTranscriptionStatus> {
  return normalizeMossStatus(await request<unknown>(() => http.get(transcriptionRoute(caseId))))
}

export async function submitMossTranscription(caseId: string, audioPath: string, audioSha256?: string): Promise<MossTranscriptionStatus> {
  const body: Record<string, string> = { audioPath }
  if (audioSha256) body.audioSha256 = audioSha256
  return normalizeMossStatus(await request<unknown>(() => http.post(transcriptionRoute(caseId), body)))
}

export async function resubmitMossTranscription(caseId: string, audioPath: string): Promise<MossTranscriptionStatus> {
  return normalizeMossStatus(await request<unknown>(() => http.post(transcriptionRoute(caseId, '/resubmit'), { audioPath })))
}

export async function fetchMossTranscript(caseId: string): Promise<MossTranscript> {
  return normalizeMossTranscript(await request<unknown>(() => http.get(transcriptionRoute(caseId, '/transcript'))))
}

export async function fetchMossSpeakerMapping(caseId: string): Promise<MossSpeakerMapping[]> {
  return normalizeMappings(await request<unknown>(() => http.get(mappingRoute(caseId))))
}

export async function putMossSpeakerMapping(caseId: string, mappings: MossSpeakerMapping[]): Promise<MossSpeakerMapping[]> {
  return normalizeMappings(await request<unknown>(() => http.put(mappingRoute(caseId), { mappings })))
}

export function isMossDisabledError(error: unknown): boolean {
  return error instanceof MossApiError && error.code === MOSS_DISABLED_CODE
}

export function isMossTranscriptionNotFoundError(error: unknown): boolean {
  return error instanceof MossApiError && error.code === MOSS_TRANSCRIPTION_NOT_FOUND_CODE
}
