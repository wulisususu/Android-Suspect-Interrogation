import type { AxiosError } from 'axios'
import {
  getRuntimeAdapter,
  RuntimeAdapterError,
  type RuntimeCapabilities,
  type RuntimeEventListener,
  type RuntimeSessionConnection,
} from '../runtime'
import type {
  AsrCaptureStatus,
  AsrRuntimeStatus,
  BatchFragmentConfirmation,
  CaseAiAnalysis,
  CaseSummary,
  DeviceActionResult,
  FactItem,
  FragmentApplication,
  FragmentConfirmation,
  InquirySsePayload,
  InterrogationStage,
  LlmGenerateRequest,
  LlmResult,
  LlmRuntimeStatus,
  LocalModelCatalog,
  ModelCategory,
  ModelImportSource,
  OcrResult,
  OcrRuntimeStatus,
  OfficerVoiceprint,
  RecordMark,
  RecordRevision,
  SessionState,
  SessionStatus,
  TemporaryAsrFragment,
  TemporaryAsrSpeaker,
  TimelineEvent,
  TranscriptMessage,
  VoiceprintEnrollmentResult,
  VoiceprintReadiness,
  VoiceRecognitionMode,
} from '../types/interrogation'

const runtime = () => getRuntimeAdapter()

function asRecord(value: unknown): Record<string, unknown> {
  return value && typeof value === 'object' && !Array.isArray(value) ? value as Record<string, unknown> : {}
}

function toTimestamp(value: unknown): number | undefined {
  if (typeof value === 'number' && Number.isFinite(value)) return value
  if (typeof value === 'string') {
    const parsed = Date.parse(value)
    if (Number.isFinite(parsed)) return parsed
  }
  return undefined
}

function normalizeCaseSummary(value: unknown, fallback: Partial<CaseSummary> = {}): CaseSummary {
  const raw = asRecord(value)
  const id = String(raw.id ?? raw.case_id ?? fallback.id ?? '')
  return {
    ...fallback,
    id,
    suspectName: String(raw.suspectName ?? raw.suspect_name ?? fallback.suspectName ?? ''),
    gender: raw.gender === undefined ? fallback.gender : String(raw.gender),
    age: raw.age === undefined ? fallback.age : String(raw.age),
    idNumber: raw.idNumber === undefined && raw.id_number === undefined ? fallback.idNumber : String(raw.idNumber ?? raw.id_number ?? ''),
    nation: raw.nation === undefined ? fallback.nation : String(raw.nation),
    birthDate: raw.birthDate === undefined && raw.birth_date === undefined ? fallback.birthDate : String(raw.birthDate ?? raw.birth_date ?? ''),
    address: raw.address === undefined ? fallback.address : String(raw.address),
    identitySource: raw.identitySource === undefined && raw.identity_source === undefined ? fallback.identitySource : String(raw.identitySource ?? raw.identity_source),
    identityCapturedAt: toTimestamp(raw.identityCapturedAt ?? raw.identity_captured_at) ?? fallback.identityCapturedAt,
    officerName: String(raw.officerName ?? raw.operator_id ?? raw.officer_name ?? fallback.officerName ?? '当前警官'),
    state: String(raw.state ?? fallback.state ?? 'DRAFT'),
    stage: (raw.stage ?? fallback.stage ?? 'IDENTITY') as InterrogationStage,
    createdAt: toTimestamp(raw.createdAt ?? raw.created_at) ?? fallback.createdAt,
    updatedAt: toTimestamp(raw.updatedAt ?? raw.updated_at) ?? fallback.updatedAt,
  }
}

function normalizeSessionState(value: unknown, caseId: string): SessionState {
  const raw = asRecord(value)
  const backendState = String(raw.status ?? raw.state ?? 'READY').toUpperCase()
  const statusMap: Record<string, SessionStatus> = {
    READY: 'READY', QUESTIONING: 'RUNNING', RUNNING: 'RUNNING', PAUSED: 'PAUSED', SUMMARY: 'COMPLETED', COMPLETED: 'COMPLETED',
  }
  return {
    id: raw.id === null ? null : String(raw.id ?? raw.session_id ?? '') || null,
    caseId: String(raw.caseId ?? raw.case_id ?? caseId),
    status: statusMap[backendState] || 'READY',
    stage: (raw.stage ?? (backendState === 'SUMMARY' ? 'SIGNING' : 'IDENTITY')) as InterrogationStage,
    startedAt: toTimestamp(raw.startedAt ?? raw.started_at) ?? null,
    pausedAt: toTimestamp(raw.pausedAt ?? raw.paused_at) ?? null,
    endedAt: toTimestamp(raw.endedAt ?? raw.ended_at) ?? null,
    updatedAt: toTimestamp(raw.updatedAt ?? raw.updated_at) ?? Date.now(),
  }
}

function normalizeVoiceprintReadiness(value: unknown): VoiceprintReadiness {
  const raw = asRecord(value)
  const mode = String(raw.recognitionMode ?? 'SUSPECT_ONLY') as VoiceRecognitionMode
  return {
    suspectReady: Boolean(raw.suspectReady),
    interrogatorReady: Boolean(raw.interrogatorReady),
    recorderReady: Boolean(raw.recorderReady),
    recognitionMode: mode,
    canStart: Boolean(raw.canStart),
    ...(raw.simulated === undefined ? {} : { simulated: Boolean(raw.simulated) }),
  }
}

function normalizeOfficerVoiceprint(value: unknown): OfficerVoiceprint {
  const raw = asRecord(value)
  return {
    voiceprintId: raw.voiceprintId == null ? undefined : String(raw.voiceprintId),
    officerId: String(raw.officerId ?? ''),
    officerName: String(raw.officerName ?? ''),
    active: Boolean(raw.active),
    modelId: String(raw.modelId ?? ''),
    modelVersion: raw.modelVersion == null ? null : String(raw.modelVersion),
    enrollmentQuality: String(raw.enrollmentQuality ?? raw.quality ?? ''),
    usableDurationMs: Number(raw.usableDurationMs ?? 0),
    revokedAt: raw.revokedAt == null ? null : String(raw.revokedAt),
    ...(raw.simulated === undefined ? {} : { simulated: Boolean(raw.simulated) }),
  }
}

export function backendErrorMessage(error: unknown): string {
  if (error instanceof RuntimeAdapterError) return error.message
  const axiosError = error as AxiosError<{ message?: string; code?: string }>
  const responseMessage = axiosError?.response?.data?.message
  if (responseMessage) return responseMessage
  if (axiosError?.code === 'ERR_NETWORK' || (error instanceof TypeError && /fetch/i.test(error.message))) {
    return '无法连接 Linux 本地后端，请确认本机 FastAPI 服务已启动'
  }
  if (error instanceof Error) return error.message
  return String(error)
}

export function fetchRuntimeCapabilities(force = false): Promise<RuntimeCapabilities> {
  return runtime().getCapabilities(force)
}

export function connectRuntimeSession(sessionId: string, listener: RuntimeEventListener): RuntimeSessionConnection {
  return runtime().connectSession(sessionId, listener)
}

export async function createCase(payload: Partial<CaseSummary> = {}): Promise<CaseSummary> {
  const request = {
    ...payload,
    operator_id: payload.officerName || '当前警官',
    case_type: 'suspect_interrogation',
  } as unknown as Record<string, unknown>
  const result = await runtime().invoke<unknown>('case.create', request)
  return normalizeCaseSummary(result, payload)
}

export async function fetchCases(limit = 50): Promise<CaseSummary[]> {
  const result = await runtime().invoke<unknown[]>('case.list', { limit })
  return Array.isArray(result) ? result.map((item) => normalizeCaseSummary(item)) : []
}

export async function fetchCase(caseId: string): Promise<CaseSummary> {
  const result = await runtime().invoke<unknown>('case.get', { caseId })
  return normalizeCaseSummary(result, { id: caseId })
}

export function fetchMessages(caseId: string): Promise<TranscriptMessage[]> {
  return runtime().invoke<TranscriptMessage[]>('message.list', { caseId, limit: 1000 })
}

export function fetchFacts(caseId: string): Promise<FactItem[]> {
  return runtime().invoke<FactItem[]>('fact.list', { caseId })
}

export function fetchTimeline(caseId: string): Promise<TimelineEvent[]> {
  return runtime().invoke<TimelineEvent[]>('timeline.list', { caseId })
}

export async function fetchSessionState(caseId: string): Promise<SessionState> {
  const result = await runtime().invoke<unknown>('session.get', { caseId })
  return normalizeSessionState(result, caseId)
}

export async function fetchCaseAiAnalyses(caseId: string): Promise<CaseAiAnalysis[]> {
  try {
    return await runtime().invoke<CaseAiAnalysis[]>('case.ai.list', { caseId })
  } catch (error) {
    if (error instanceof RuntimeAdapterError && ['MODEL_NOT_INSTALLED', 'NOT_CONFIGURED'].includes(error.state)) return []
    throw error
  }
}

export function generateCaseAiAnalysis(caseId: string): Promise<CaseAiAnalysis> {
  return runtime().invoke<CaseAiAnalysis>('case.ai.generate', { caseId }, { timeoutMs: 15 * 60_000 })
}

export function persistQuestionOrAnswer(caseId: string, text: string, from: '民警' | '嫌疑人'): Promise<TranscriptMessage> {
  return runtime().invoke<TranscriptMessage>('message.add', { caseId, text, from })
}

export function updateTranscriptMessage(caseId: string, messageId: string, text: string): Promise<TranscriptMessage> {
  return runtime().invoke<TranscriptMessage>('message.update', {
    caseId,
    messageId,
    text,
    reason: '警官在审讯工作台修订',
  })
}

export function markTranscriptMessage(caseId: string, messageId: string, mark: RecordMark): Promise<TranscriptMessage> {
  return runtime().invoke<TranscriptMessage>('message.mark', { caseId, messageId, mark })
}

export function fetchRevisions(caseId: string, messageId?: string): Promise<RecordRevision[]> {
  return runtime().invoke<RecordRevision[]>('message.revisions', { caseId, ...(messageId ? { messageId } : {}) })
}

async function sessionAction(caseId: string, action: 'start' | 'pause' | 'resume' | 'finish'): Promise<SessionState> {
  const result = await runtime().invoke<unknown>(`session.${action}`, { caseId })
  return normalizeSessionState(result, caseId)
}

export const startSession = (caseId: string) => sessionAction(caseId, 'start')
export const pauseSession = (caseId: string) => sessionAction(caseId, 'pause')
export const resumeSession = (caseId: string) => sessionAction(caseId, 'resume')
export const finishSession = (caseId: string) => sessionAction(caseId, 'finish')

export async function changeSessionStage(caseId: string, stage: InterrogationStage): Promise<SessionState> {
  const result = await runtime().invoke<unknown>('session.stage', { caseId, stage })
  return normalizeSessionState(result, caseId)
}

export function invokeDeviceAction(type: 'identity' | 'fingerprint' | 'signature'): Promise<DeviceActionResult> {
  return runtime().invoke<DeviceActionResult>('device.action', { type })
}

const emptyModelCatalog: LocalModelCatalog = {
  rootPath: 'Linux 本地模型目录（未就绪）',
  models: [],
}

export async function fetchLocalModels(rescan = false): Promise<LocalModelCatalog> {
  try {
    return await runtime().invoke<LocalModelCatalog>(rescan ? 'model.scan' : 'model.list')
  } catch (error) {
    if (error instanceof RuntimeAdapterError && ['MODEL_NOT_INSTALLED', 'NOT_CONFIGURED'].includes(error.state)) return emptyModelCatalog
    throw error
  }
}

export function selectLocalModel(category: ModelCategory, modelId?: string): Promise<LocalModelCatalog> {
  return runtime().invoke<LocalModelCatalog>('model.select', { category, ...(modelId ? { modelId } : {}) })
}

export function importLocalModel(category: ModelCategory, source: ModelImportSource): Promise<LocalModelCatalog> {
  return runtime().invoke<LocalModelCatalog>('model.import', { category, source }, { timeoutMs: 15 * 60_000 })
}

export function fetchLlmStatus(): Promise<LlmRuntimeStatus> {
  return runtime().invoke<LlmRuntimeStatus>('llm.status')
}

export function requestLlmStoragePermission(): Promise<LlmRuntimeStatus> {
  return runtime().invoke<LlmRuntimeStatus>('llm.storage.permission.request', {}, { timeoutMs: 5 * 60_000 })
}

export function generateLlm(request: LlmGenerateRequest): Promise<LlmResult> {
  return runtime().invoke<LlmResult>('llm.generate', request as unknown as Record<string, unknown>, { timeoutMs: 15 * 60_000 })
}

export function cancelLlm(): Promise<LlmRuntimeStatus> {
  return runtime().invoke<LlmRuntimeStatus>('llm.cancel', {}, { timeoutMs: 30_000 })
}

export function releaseLlm(): Promise<LlmRuntimeStatus> {
  return runtime().invoke<LlmRuntimeStatus>('llm.release', {}, { timeoutMs: 30_000 })
}

export function fetchAsrStatus(): Promise<AsrRuntimeStatus> {
  return runtime().invoke<AsrRuntimeStatus>('asr.status')
}

export function startAsr(): Promise<AsrRuntimeStatus> {
  return runtime().invoke<AsrRuntimeStatus>('asr.start', {}, { timeoutMs: 120_000 })
}

export function stopAsr(): Promise<AsrRuntimeStatus> {
  return runtime().invoke<AsrRuntimeStatus>('asr.stop', {}, { timeoutMs: 30_000 })
}

export async function fetchVoiceprintReadiness(caseId: string): Promise<VoiceprintReadiness> {
  return normalizeVoiceprintReadiness(await runtime().invoke<unknown>('voiceprint.readiness', { caseId }))
}

export function startSuspectVoiceprintEnrollment(caseId: string, actorId?: string): Promise<VoiceprintEnrollmentResult> {
  return runtime().invoke<VoiceprintEnrollmentResult>('voiceprint.suspect.enrollment.start', { caseId, actorId })
}

export function stopSuspectVoiceprintEnrollment(caseId: string, actorId?: string): Promise<VoiceprintEnrollmentResult> {
  return runtime().invoke<VoiceprintEnrollmentResult>('voiceprint.suspect.enrollment.stop', { caseId, actorId }, { timeoutMs: 120_000 })
}

export async function fetchOfficerVoiceprints(activeOnly = true): Promise<OfficerVoiceprint[]> {
  const result = await runtime().invoke<unknown[]>('officerVoiceprint.list', { activeOnly })
  return Array.isArray(result) ? result.map(normalizeOfficerVoiceprint) : []
}

export function startOfficerVoiceprintEnrollment(officerId: string, officerName: string, actorId?: string): Promise<VoiceprintEnrollmentResult> {
  return runtime().invoke<VoiceprintEnrollmentResult>('officerVoiceprint.enrollment.start', { officerId, officerName, actorId })
}

export function stopOfficerVoiceprintEnrollment(officerId: string, actorId?: string): Promise<VoiceprintEnrollmentResult> {
  return runtime().invoke<VoiceprintEnrollmentResult>('officerVoiceprint.enrollment.stop', { officerId, actorId }, { timeoutMs: 120_000 })
}

export async function revokeOfficerVoiceprint(officerId: string, actorId?: string): Promise<OfficerVoiceprint> {
  return normalizeOfficerVoiceprint(await runtime().invoke<unknown>('officerVoiceprint.revoke', { officerId, actorId }))
}

export async function updateVoiceprintAssignments(
  caseId: string,
  interrogatorOfficerId?: string | null,
  recorderOfficerId?: string | null,
  actorId?: string,
): Promise<VoiceprintReadiness> {
  const result = await runtime().invoke<unknown>('voiceprint.assignments.update', {
    caseId,
    interrogatorOfficerId: interrogatorOfficerId ?? null,
    recorderOfficerId: recorderOfficerId ?? null,
    actorId,
  })
  return normalizeVoiceprintReadiness(result)
}

export function fetchOcrStatus(): Promise<OcrRuntimeStatus> {
  return runtime().invoke<OcrRuntimeStatus>('ocr.status')
}

export function pickOcrImage(): Promise<OcrRuntimeStatus> {
  return runtime().invoke<OcrRuntimeStatus>('ocr.image.pick', {}, { timeoutMs: 5 * 60_000 })
}

export function captureOcrImage(): Promise<OcrRuntimeStatus> {
  return runtime().invoke<OcrRuntimeStatus>('ocr.camera.capture', {}, { timeoutMs: 5 * 60_000 })
}

export function recognizeOcrImage(): Promise<OcrResult> {
  return runtime().invoke<OcrResult>('ocr.recognize', {}, { timeoutMs: 5 * 60_000 })
}

export function releaseOcr(): Promise<OcrRuntimeStatus> {
  return runtime().invoke<OcrRuntimeStatus>('ocr.release', {}, { timeoutMs: 30_000 })
}

export function fetchAsrCaptureStatus(caseId: string): Promise<AsrCaptureStatus> {
  return runtime().invoke<AsrCaptureStatus>('asr.capture.status', { caseId })
}

export function startAsrCapture(caseId: string): Promise<AsrCaptureStatus> {
  return runtime().invoke<AsrCaptureStatus>('asr.capture.start', { caseId }, { timeoutMs: 120_000 })
}

export function stopAsrCapture(caseId: string): Promise<AsrCaptureStatus> {
  return runtime().invoke<AsrCaptureStatus>('asr.capture.stop', { caseId }, { timeoutMs: 30_000 })
}

export function listAsrFragments(caseId: string, includeConfirmed = false): Promise<TemporaryAsrFragment[]> {
  return runtime().invoke<TemporaryAsrFragment[]>('asr.fragment.list', { caseId, includeConfirmed })
}

export function updateAsrFragment(
  caseId: string,
  fragmentId: string,
  editedText: string,
  speaker: TemporaryAsrSpeaker,
): Promise<TemporaryAsrFragment> {
  return runtime().invoke<TemporaryAsrFragment>('asr.fragment.update', { caseId, fragmentId, editedText, speaker })
}

export function confirmAsrFragment(caseId: string, fragmentId: string): Promise<FragmentConfirmation> {
  return runtime().invoke<FragmentConfirmation>('asr.fragment.confirm', { caseId, fragmentId })
}

export function confirmAsrFragmentBatch(caseId: string, fragmentIds: string[]): Promise<BatchFragmentConfirmation> {
  return runtime().invoke<BatchFragmentConfirmation>('asr.fragment.confirmBatch', { caseId, fragmentIds })
}

export function applyAsrFragmentsToRecord(
  caseId: string,
  captureSessionId: string,
  recordId: string,
  fragmentIds: string[],
  text: string,
): Promise<FragmentApplication> {
  return runtime().invoke<FragmentApplication>('asr.fragment.applyToRecord', {
    caseId,
    captureSessionId,
    recordId,
    fragmentIds,
    text,
  })
}

export function discardAsrFragment(caseId: string, fragmentId: string): Promise<TemporaryAsrFragment> {
  return runtime().invoke<TemporaryAsrFragment>('asr.fragment.discard', { caseId, fragmentId })
}

export async function streamInquiry(
  caseId: string,
  message: string,
  onPayload: (payload: InquirySsePayload) => void,
  signal?: AbortSignal,
) {
  if (signal?.aborted) return
  const result = await runtime().invoke<{ text?: string; provider?: string; model?: string }>(
    'ai.inquiry',
    { caseId, message },
    { timeoutMs: 15 * 60_000 },
  )
  if (signal?.aborted) return
  if (result?.text) onPayload({ text_chunk: result.text })
}
