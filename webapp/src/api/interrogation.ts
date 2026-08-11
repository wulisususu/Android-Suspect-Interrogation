import type { AxiosError } from 'axios'
import { getAuthorizationValue, runtimeConfig } from '../config/runtime'
import { callNative, isNativeBusinessRuntime } from '../native/rpcBridge'
import type { AiRuntimeStatus, AiSettingsPatch, AsrCaptureStatus, AsrRuntimeStatus, BackendEnvelope, BatchFragmentConfirmation, CaseSummary, DeviceActionResult, FactItem, FragmentConfirmation, InquirySsePayload, InterrogationStage, LocalModelCatalog, ModelCategory, ModelImportSource, OcrResult, OcrRuntimeStatus, RecordMark, RecordRevision, SessionState, TemporaryAsrFragment, TemporaryAsrSpeaker, TimelineEvent, TranscriptMessage } from '../types/interrogation'
import { http } from './http'
import { streamSse } from './sse'

function unwrap<T>(payload: BackendEnvelope<T> | T): T { if (payload && typeof payload === 'object' && 'ok' in payload && 'data' in payload) { const envelope = payload as BackendEnvelope<T>; if (!envelope.ok) throw new Error(envelope.message || envelope.code); return envelope.data } return payload as T }
export function backendErrorMessage(error: unknown): string { const axiosError = error as AxiosError<{ message?: string; code?: string }>; const responseMessage = axiosError?.response?.data?.message; if (responseMessage) return responseMessage; if (axiosError?.code === 'ERR_NETWORK' || (error instanceof TypeError && /fetch/i.test(error.message))) return '无法连接本机联调后端，请确认 backend-dev 已启动'; if (error instanceof Error) return error.message; return String(error) }

export async function createCase(payload: Partial<CaseSummary> = {}) { if (isNativeBusinessRuntime()) return callNative<CaseSummary>('case.create', payload as Record<string, unknown>); const { data } = await http.post('/api/cases/create', payload); return unwrap<CaseSummary>(data) }
export async function fetchCases(limit = 50) { if (isNativeBusinessRuntime()) return callNative<CaseSummary[]>('case.list', { limit }); const { data } = await http.get('/api/cases', { params: { limit } }); return unwrap<CaseSummary[]>(data) }
export async function fetchCase(caseId: string) { if (isNativeBusinessRuntime()) return callNative<CaseSummary>('case.get', { caseId }); const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}`); return unwrap<CaseSummary>(data) }
export async function fetchMessages(caseId: string) { if (isNativeBusinessRuntime()) return callNative<TranscriptMessage[]>('record.list', { caseId }); const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}/messages`, { params: { limit: 1000 } }); return unwrap<TranscriptMessage[]>(data) }
export async function fetchFacts(caseId: string) { if (isNativeBusinessRuntime()) return callNative<FactItem[]>('fact.list', { caseId }); const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}/facts`); return unwrap<FactItem[]>(data) }
export async function fetchTimeline(caseId: string) { if (isNativeBusinessRuntime()) return callNative<TimelineEvent[]>('timeline.list', { caseId }); const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}/timeline`); return unwrap<TimelineEvent[]>(data) }
export async function fetchSessionState(caseId: string) { if (isNativeBusinessRuntime()) return callNative<SessionState>('session.get', { caseId }); const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}/session`); return unwrap<SessionState>(data) }
export async function persistQuestionOrAnswer(caseId: string, text: string, from: '民警' | '嫌疑人') { if (isNativeBusinessRuntime()) return callNative<TranscriptMessage>('record.add', { caseId, text, from }); const { data } = await http.post(`/work/case/${encodeURIComponent(caseId)}/message`, { profile: { text, from } }); return unwrap<TranscriptMessage>(data) }
export async function updateTranscriptMessage(caseId: string, messageId: string, text: string) { if (isNativeBusinessRuntime()) return callNative<TranscriptMessage>('record.update', { caseId, messageId, text, reason: '警官在审讯工作台修订' }); const { data } = await http.put(`/api/cases/${encodeURIComponent(caseId)}/messages/${encodeURIComponent(messageId)}`, { text, reason: '警官在审讯工作台修订' }); return unwrap<TranscriptMessage>(data) }
export async function markTranscriptMessage(caseId: string, messageId: string, mark: RecordMark) { if (isNativeBusinessRuntime()) return callNative<TranscriptMessage>('record.mark', { caseId, messageId, mark }); const { data } = await http.post(`/api/cases/${encodeURIComponent(caseId)}/messages/${encodeURIComponent(messageId)}/mark`, { mark }); return unwrap<TranscriptMessage>(data) }
export async function fetchRevisions(caseId: string, messageId?: string) { if (isNativeBusinessRuntime()) return callNative<RecordRevision[]>('record.revisions', { caseId, messageId }); const suffix = messageId ? `/messages/${encodeURIComponent(messageId)}/revisions` : '/revisions'; const { data } = await http.get(`/api/cases/${encodeURIComponent(caseId)}${suffix}`); return unwrap<RecordRevision[]>(data) }
async function sessionAction(caseId: string, action: 'start' | 'pause' | 'resume' | 'finish') { if (isNativeBusinessRuntime()) return callNative<SessionState>(`session.${action}`, { caseId }); const { data } = await http.post(`/api/cases/${encodeURIComponent(caseId)}/session/${action}`, {}); return unwrap<SessionState>(data) }
export const startSession = (caseId: string) => sessionAction(caseId, 'start')
export const pauseSession = (caseId: string) => sessionAction(caseId, 'pause')
export const resumeSession = (caseId: string) => sessionAction(caseId, 'resume')
export const finishSession = (caseId: string) => sessionAction(caseId, 'finish')
export async function changeSessionStage(caseId: string, stage: InterrogationStage) { if (isNativeBusinessRuntime()) return callNative<SessionState>('session.stage', { caseId, stage }); const { data } = await http.post(`/api/cases/${encodeURIComponent(caseId)}/session/stage`, { stage }); return unwrap<SessionState>(data) }
export async function invokeDeviceAction(type: 'identity' | 'fingerprint' | 'signature') { if (isNativeBusinessRuntime()) return callNative<DeviceActionResult>('device.action', { type }); const { data } = await http.post('/api/device/action', { type }); return unwrap<DeviceActionResult>(data) }

export async function fetchAiSettings(): Promise<AiRuntimeStatus> {
  if (isNativeBusinessRuntime()) return callNative<AiRuntimeStatus>('ai.settings.get')
  const { data } = await http.get('/api/ai/settings')
  return unwrap<AiRuntimeStatus>(data)
}

export async function updateAiSettings(patch: AiSettingsPatch): Promise<AiRuntimeStatus> {
  if (isNativeBusinessRuntime()) return callNative<AiRuntimeStatus>('ai.settings.update', patch as Record<string, unknown>)
  const { data } = await http.patch('/api/ai/settings', patch)
  return unwrap<AiRuntimeStatus>(data)
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

export function updateAsrFragment(fragmentId: string, editedText: string, speaker: TemporaryAsrSpeaker): Promise<TemporaryAsrFragment> {
  requireNativeCapture()
  return callNative<TemporaryAsrFragment>('asr.fragment.update', { fragmentId, editedText, speaker })
}

export function confirmAsrFragment(fragmentId: string): Promise<FragmentConfirmation> {
  requireNativeCapture()
  return callNative<FragmentConfirmation>('asr.fragment.confirm', { fragmentId })
}

export function confirmAsrFragmentBatch(fragmentIds: string[]): Promise<BatchFragmentConfirmation> {
  requireNativeCapture()
  return callNative<BatchFragmentConfirmation>('asr.fragment.confirmBatch', { fragmentIds })
}

export function discardAsrFragment(fragmentId: string): Promise<TemporaryAsrFragment> {
  requireNativeCapture()
  return callNative<TemporaryAsrFragment>('asr.fragment.discard', { fragmentId })
}

export async function streamInquiry(caseId: string, message: string, onPayload: (payload: InquirySsePayload) => void, signal?: AbortSignal) {
  if (isNativeBusinessRuntime()) {
    const result = await callNative<{ text?: string; provider?: string; model?: string }>('ai.inquiry', { caseId, message })
    if (result?.text) onPayload({ text_chunk: result.text })
    return
  }
  const endpoint = new URL(`/work/case/${encodeURIComponent(caseId)}/session/message/inquiry`, runtimeConfig.apiBaseUrl); endpoint.searchParams.set('message', message)
  const authorization = getAuthorizationValue()
  await streamSse(endpoint.toString(), { method: 'GET', credentials: 'include', signal, headers: authorization ? { Authorization: authorization } : {} }, ({ data }) => { if (data === '[DONE]') return; try { onPayload(JSON.parse(data) as InquirySsePayload) } catch { onPayload({ text_chunk: data }) } })
}
