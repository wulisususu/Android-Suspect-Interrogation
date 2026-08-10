import type { AxiosError } from 'axios'
import { getAuthorizationValue, runtimeConfig } from '../config/runtime'
import { callNative, isNativeBusinessRuntime } from '../native/rpcBridge'
import type { BackendEnvelope, CaseSummary, DeviceActionResult, FactItem, InquirySsePayload, InterrogationStage, RecordMark, RecordRevision, SessionState, TimelineEvent, TranscriptMessage } from '../types/interrogation'
import { http } from './http'
import { streamSse } from './sse'

function unwrap<T>(payload: BackendEnvelope<T> | T): T { if (payload && typeof payload === 'object' && 'ok' in payload && 'data' in payload) { const envelope = payload as BackendEnvelope<T>; if (!envelope.ok) throw new Error(envelope.message || envelope.code); return envelope.data } return payload as T }
export function backendErrorMessage(error: unknown): string { const axiosError = error as AxiosError<{ message?: string; code?: string }>; const responseMessage = axiosError?.response?.data?.message; if (responseMessage) return responseMessage; if (error instanceof Error) return error.message; return String(error) }

export async function createCase(payload: Partial<CaseSummary> = {}) { if (isNativeBusinessRuntime()) return callNative<CaseSummary>('case.create', payload as Record<string, unknown>); const { data } = await http.post('/api/cases/create', payload); return unwrap<CaseSummary>(data) }
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

export async function streamInquiry(caseId: string, message: string, onPayload: (payload: InquirySsePayload) => void, signal?: AbortSignal) {
  if (isNativeBusinessRuntime()) { const result = await callNative<{ text?: string }>('ai.inquiry', { caseId, message }); if (result?.text) onPayload({ text_chunk: result.text }); return }
  const endpoint = new URL(`/work/case/${encodeURIComponent(caseId)}/session/message/inquiry`, runtimeConfig.apiBaseUrl); endpoint.searchParams.set('message', message)
  const authorization = getAuthorizationValue()
  await streamSse(endpoint.toString(), { method: 'GET', credentials: 'include', signal, headers: authorization ? { Authorization: authorization } : {} }, ({ data }) => { if (data === '[DONE]') return; try { onPayload(JSON.parse(data) as InquirySsePayload) } catch { onPayload({ text_chunk: data }) } })
}
