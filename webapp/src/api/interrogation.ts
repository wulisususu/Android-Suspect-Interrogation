import type { AxiosError } from 'axios'
import { callNative, isNativeBusinessRuntime } from '../native/rpcBridge'
import type {
  AsrCaptureStatus,
  AsrRuntimeStatus,
  BackendEnvelope,
  BatchFragmentConfirmation,
  CaseAiAnalysis,
  CaseSummary,
  DeviceActionResult,
  FactItem,
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
  RecordMark,
  RecordRevision,
  SessionState,
  TemporaryAsrFragment,
  TemporaryAsrSpeaker,
  TimelineEvent,
  TranscriptMessage,
} from '../types/interrogation'
import { http } from './http'

function unwrap<T>(payload: BackendEnvelope<T> | T): T {
  if (payload && typeof payload === 'object' && 'ok' in payload && 'data' in payload) {
    const envelope = payload as BackendEnvelope<T>
    if (!envelope.ok) throw new Error(envelope.message || envelope.code)
    return envelope.data
  }
  return payload as T
}

export function backendErrorMessage(error: unknown): string {
  const axiosError = error as AxiosError<{ message?: string; code?: string }>
  const responseMessage = axiosError?.response?.data?.message
  if (responseMessage) return responseMessage
  if (axiosError?.code === 'ERR_NETWORK' || (error instanceof TypeError && /fetch/i.test(error.message))) {
    return '无法连接本机联调后端，请确认 backend-dev 已启动'
  }
  if (error instanceof Error) return error.message
  return String(error)
}

export async function createCase(payload: Partial<CaseSummary> = {}) {
  if (isNativeBusinessRuntime()) return callNative<CaseSummary>('case.create', payload as Record<string, unknown>)
  const { data } = await http.post('/api/cases/create', payload)
  return unwrap<CaseSummary>(data)
}

export async function fetchCases(limit = 50) {
  if (isNativeBusinessRuntime()) return callNative<CaseSummary[]>('case.list', { limit })
  const { data } = await http.get('/api/cases', { params: { limit } })
  return unwrap<CaseSummary[]>(data)
}

export async function fetchCase(caseId: string) {
  if (isNativeBusinessRuntime()) return callNative<CaseSummary>('case.get', { caseId })
  const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}`)
  return unwrap<CaseSummary>(data)
}

export async function fetchMessages(caseId: string) {
  if (isNativeBusinessRuntime()) return callNative<TranscriptMessage[]>('record.list', { caseId })
  const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}/messages`, { params: { limit: 1000 } })
  return unwrap<TranscriptMessage[]>(data)
}

export async function fetchFacts(caseId: string) {
  if (isNativeBusinessRuntime()) return callNative<FactItem[]>('fact.list', { caseId })
  const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}/facts`)
  return unwrap<FactItem[]>(data)
}

export async function fetchTimeline(caseId: string) {
  if (isNativeBusinessRuntime()) return callNative<TimelineEvent[]>('timeline.list', { caseId })
  const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}/timeline`)
  return unwrap<TimelineEvent[]>(data)
}

export async function fetchSessionState(caseId: string) {
  if (isNativeBusinessRuntime()) return callNative<SessionState>('session.get', { caseId })
  const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}/session`)
  return unwrap<SessionState>(data)
}

export async function fetchCaseAiAnalyses(caseId: string): Promise<CaseAiAnalysis[]> {
  if (isNativeBusinessRuntime()) return callNative<CaseAiAnalysis[]>('case.ai.list', { caseId })
  return []
}

export async function generateCaseAiAnalysis(caseId: string): Promise<CaseAiAnalysis> {
  if (isNativeBusinessRuntime()) return callNative<CaseAiAnalysis>('case.ai.generate', { caseId }, 15 * 60_000)
  throw new Error('案件 AI 梳理仅在 Android APK 中使用本地 LLM 运行')
}

export async function persistQuestionOrAnswer(caseId: string, text: string, from: '民警' | '嫌疑人') {
  if (isNativeBusinessRuntime()) return callNative<TranscriptMessage>('record.add', { caseId, text, from })
  const { data } = await http.post(`/work/case/${encodeURIComponent(caseId)}/message`, { profile: { text, from } })
  return unwrap<TranscriptMessage>(data)
}

export async function updateTranscriptMessage(caseId: string, messageId: string, text: string) {
  if (isNativeBusinessRuntime()) {
    return callNative<TranscriptMessage>('record.update', { caseId, messageId, text, reason: '警官在审讯工作台修订' })
  }
  const { data } = await http.put(`/api/cases/${encodeURIComponent(caseId)}/messages/${encodeURIComponent(messageId)}`, {
    text,
    reason: '警官在审讯工作台修订',
  })
  return unwrap<TranscriptMessage>(data)
}

export async function markTranscriptMessage(caseId: string, messageId: string, mark: RecordMark) {
  if (isNativeBusinessRuntime()) return callNative<TranscriptMessage>('record.mark', { caseId, messageId, mark })
  const { data } = await http.post(`/api/cases/${encodeURIComponent(caseId)}/messages/${encodeURIComponent(messageId)}/mark`, { mark })
  return unwrap<TranscriptMessage>(data)
}

export async function fetchRevisions(caseId: string, messageId?: string) {
  if (isNativeBusinessRuntime()) return callNative<RecordRevision[]>('record.revisions', { caseId, messageId })
  const suffix = messageId ? `/messages/${encodeURIComponent(messageId)}/revisions` : '/revisions'
  const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}${suffix}`)
  return unwrap<RecordRevision[]>(data)
}

async function sessionAction(caseId: string, action: 'start' | 'pause' | 'resume' | 'finish') {
  if (isNativeBusinessRuntime()) return callNative<SessionState>(`session.${action}`, { caseId })
  const { data } = await http.post(`/api/cases/${encodeURIComponent(caseId)}/session/${action}`, {})
  return unwrap<SessionState>(data)
}

export const startSession = (caseId: string) => sessionAction(caseId, 'start')
export const pauseSession = (caseId: string) => sessionAction(caseId, 'pause')
export const resumeSession = (caseId: string) => sessionAction(caseId, 'resume')
export const finishSession = (caseId: string) => sessionAction(caseId, 'finish')

export async function changeSessionStage(caseId: string, stage: InterrogationStage) {
  if (isNativeBusinessRuntime()) return callNative<SessionState>('session.stage', { caseId, stage })
  const { data } = await http.post(`/api/cases/${encodeURIComponent(caseId)}/session/stage`, { stage })
  return unwrap<SessionState>(data)
}

export async function invokeDeviceAction(type: 'identity' | 'fingerprint' | 'signature') {
  if (isNativeBusinessRuntime()) return callNative<DeviceActionResult>('device.action', { type })
  const { data } = await http.post('/api/device/action', { type })
  return unwrap<DeviceActionResult>(data)
}

const browserModelCatalog: LocalModelCatalog = {
  rootPath: 'Android APK 私有模型目录',
  models: [],
}

export async function fetchLocalModels(rescan = false): Promise<LocalModelCatalog> {
  if (!isNativeBusinessRuntime()) return browserModelCatalog
  return callNative<LocalModelCatalog>(rescan ? 'model.scan' : 'model.list')
}

export async function selectLocalModel(category: ModelCategory, modelId?: string): Promise<LocalModelCatalog> {
  if (!isNativeBusinessRuntime()) throw new Error('本地模型只能在 Android APK 中选择')
  return callNative<LocalModelCatalog>('model.select', { category, modelId })
}

export async function importLocalModel(category: ModelCategory, source: ModelImportSource): Promise<LocalModelCatalog> {
  if (!isNativeBusinessRuntime()) throw new Error('请在 Android APK 中使用系统文件管理器导入模型')
  return callNative<LocalModelCatalog>('model.import.request', { category, source }, 15 * 60_000)
}

function requireNativeLlm() {
  if (!isNativeBusinessRuntime()) throw new Error('本地 LLM 仅在 Android APK 中运行')
}

export function fetchLlmStatus(): Promise<LlmRuntimeStatus> {
  requireNativeLlm()
  return callNative<LlmRuntimeStatus>('llm.status')
}

export function requestLlmStoragePermission(): Promise<LlmRuntimeStatus> {
  requireNativeLlm()
  return callNative<LlmRuntimeStatus>('llm.storage.permission.request', {}, 5 * 60_000)
}

export function generateLlm(request: LlmGenerateRequest): Promise<LlmResult> {
  requireNativeLlm()
  return callNative<LlmResult>('llm.generate', request as unknown as Record<string, unknown>, 15 * 60_000)
}

export function cancelLlm(): Promise<LlmRuntimeStatus> {
  requireNativeLlm()
  return callNative<LlmRuntimeStatus>('llm.cancel', {}, 30_000)
}

export function releaseLlm(): Promise<LlmRuntimeStatus> {
  requireNativeLlm()
  return callNative<LlmRuntimeStatus>('llm.release', {}, 30_000)
}

export function fetchAsrStatus(): Promise<AsrRuntimeStatus> {
  if (!isNativeBusinessRuntime()) return Promise.reject(new Error('离线实时识别仅在 Android APK 中运行'))
  return callNative<AsrRuntimeStatus>('asr.status')
}

export function startAsr(): Promise<AsrRuntimeStatus> {
  if (!isNativeBusinessRuntime()) return Promise.reject(new Error('离线实时识别仅在 Android APK 中运行'))
  return callNative<AsrRuntimeStatus>('asr.start', {}, 120_000)
}

export function stopAsr(): Promise<AsrRuntimeStatus> {
  if (!isNativeBusinessRuntime()) return Promise.reject(new Error('离线实时识别仅在 Android APK 中运行'))
  return callNative<AsrRuntimeStatus>('asr.stop', {}, 30_000)
}

function requireNativeOcr() {
  if (!isNativeBusinessRuntime()) throw new Error('离线 OCR 仅在 Android APK 中运行')
}

export function fetchOcrStatus(): Promise<OcrRuntimeStatus> {
  requireNativeOcr()
  return callNative<OcrRuntimeStatus>('ocr.status')
}

export function pickOcrImage(): Promise<OcrRuntimeStatus> {
  requireNativeOcr()
  return callNative<OcrRuntimeStatus>('ocr.image.pick', {}, 5 * 60_000)
}

export function captureOcrImage(): Promise<OcrRuntimeStatus> {
  requireNativeOcr()
  return callNative<OcrRuntimeStatus>('ocr.camera.capture', {}, 5 * 60_000)
}

export function recognizeOcrImage(): Promise<OcrResult> {
  requireNativeOcr()
  return callNative<OcrResult>('ocr.recognize', {}, 5 * 60_000)
}

export function releaseOcr(): Promise<OcrRuntimeStatus> {
  requireNativeOcr()
  return callNative<OcrRuntimeStatus>('ocr.release', {}, 30_000)
}

function requireNativeCapture() {
  if (!isNativeBusinessRuntime()) throw new Error('连续离线录音仅在 Android APK 中运行')
}

export function fetchAsrCaptureStatus(caseId: string): Promise<AsrCaptureStatus> {
  requireNativeCapture()
  return callNative<AsrCaptureStatus>('asr.capture.status', { caseId })
}

export function startAsrCapture(caseId: string): Promise<AsrCaptureStatus> {
  requireNativeCapture()
  return callNative<AsrCaptureStatus>('asr.capture.start', { caseId }, 120_000)
}

export function stopAsrCapture(caseId: string): Promise<AsrCaptureStatus> {
  requireNativeCapture()
  return callNative<AsrCaptureStatus>('asr.capture.stop', { caseId }, 30_000)
}

export function listAsrFragments(caseId: string, includeConfirmed = false): Promise<TemporaryAsrFragment[]> {
  requireNativeCapture()
  return callNative<TemporaryAsrFragment[]>('asr.fragment.list', { caseId, includeConfirmed })
}

export function updateAsrFragment(
  caseId: string,
  fragmentId: string,
  editedText: string,
  speaker: TemporaryAsrSpeaker,
): Promise<TemporaryAsrFragment> {
  requireNativeCapture()
  return callNative<TemporaryAsrFragment>('asr.fragment.update', { caseId, fragmentId, editedText, speaker })
}

export function confirmAsrFragment(caseId: string, fragmentId: string): Promise<FragmentConfirmation> {
  requireNativeCapture()
  return callNative<FragmentConfirmation>('asr.fragment.confirm', { caseId, fragmentId })
}

export function confirmAsrFragmentBatch(caseId: string, fragmentIds: string[]): Promise<BatchFragmentConfirmation> {
  requireNativeCapture()
  return callNative<BatchFragmentConfirmation>('asr.fragment.confirmBatch', { caseId, fragmentIds })
}

export function discardAsrFragment(caseId: string, fragmentId: string): Promise<TemporaryAsrFragment> {
  requireNativeCapture()
  return callNative<TemporaryAsrFragment>('asr.fragment.discard', { caseId, fragmentId })
}

export async function streamInquiry(
  caseId: string,
  message: string,
  onPayload: (payload: InquirySsePayload) => void,
  signal?: AbortSignal,
) {
  if (!isNativeBusinessRuntime()) {
    throw new Error('AI 询问仅在 Android APK 中使用本地 LLM 运行；浏览器联调不提供云端 AI')
  }
  if (signal?.aborted) return
  const result = await callNative<{ text?: string; provider?: string; model?: string }>('ai.inquiry', { caseId, message }, 15 * 60_000)
  if (signal?.aborted) return
  if (result?.text) onPayload({ text_chunk: result.text })
}
