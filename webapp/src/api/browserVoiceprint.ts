import { http } from './http'

export type VoiceprintAudioSource = 'ALSA' | 'BROWSER'

export interface BrowserAwareVoiceprintCaptureStatus {
  active: boolean
  kind?: string | null
  subjectId?: string | null
  captureId?: string | null
  source?: VoiceprintAudioSource | null
  capturedDurationMs: number
  recordedDurationMs?: number
  usableSpeechMs?: number
  requiredUsableSpeechMs?: number
  targetDurationMs?: number
  complete: boolean
}

export interface BrowserAwareVoiceprintEnrollmentResult {
  ready?: boolean
  captureId?: string
  source?: VoiceprintAudioSource
  usableDurationMs?: number
  officerName?: string
  simulated?: boolean
  [key: string]: unknown
}

function unwrap<T>(payload: unknown): T {
  if (payload && typeof payload === 'object' && 'ok' in payload && 'data' in payload) {
    const envelope = payload as { ok: boolean; data: T; code?: string; message?: string }
    if (!envelope.ok) throw new Error(envelope.message || envelope.code || '声纹接口返回错误')
    return envelope.data
  }
  return payload as T
}

export async function fetchBrowserAwareVoiceprintStatus(): Promise<BrowserAwareVoiceprintCaptureStatus> {
  const response = await http.get('/api/v1/voiceprints/enrollment/status')
  return unwrap<BrowserAwareVoiceprintCaptureStatus>(response.data)
}

export async function startBrowserAwareSuspectEnrollment(
  caseId: string,
  source: VoiceprintAudioSource,
  actorId?: string,
): Promise<BrowserAwareVoiceprintEnrollmentResult> {
  const response = await http.post(`/api/v1/cases/${encodeURIComponent(caseId)}/voiceprints/suspect/enrollment/start`, {
    actor_id: actorId,
    source,
  })
  return unwrap<BrowserAwareVoiceprintEnrollmentResult>(response.data)
}

export async function stopBrowserAwareSuspectEnrollment(
  caseId: string,
  actorId?: string,
): Promise<BrowserAwareVoiceprintEnrollmentResult> {
  const response = await http.post(`/api/v1/cases/${encodeURIComponent(caseId)}/voiceprints/suspect/enrollment/stop`, {
    actor_id: actorId,
  }, { timeout: 120_000 })
  return unwrap<BrowserAwareVoiceprintEnrollmentResult>(response.data)
}

export async function startBrowserAwareOfficerEnrollment(
  officerId: string,
  officerName: string,
  source: VoiceprintAudioSource,
  actorId?: string,
): Promise<BrowserAwareVoiceprintEnrollmentResult> {
  const response = await http.post(`/api/v1/officer-voiceprints/${encodeURIComponent(officerId)}/enrollment/start`, {
    officer_name: officerName,
    actor_id: actorId,
    source,
  })
  return unwrap<BrowserAwareVoiceprintEnrollmentResult>(response.data)
}

export async function stopBrowserAwareOfficerEnrollment(
  officerId: string,
  actorId?: string,
): Promise<BrowserAwareVoiceprintEnrollmentResult> {
  const response = await http.post(`/api/v1/officer-voiceprints/${encodeURIComponent(officerId)}/enrollment/stop`, {
    actor_id: actorId,
  }, { timeout: 120_000 })
  return unwrap<BrowserAwareVoiceprintEnrollmentResult>(response.data)
}

export async function cancelBrowserAwareVoiceprintEnrollment(captureId: string): Promise<void> {
  await http.post('/api/v1/voiceprints/enrollment/cancel', { capture_id: captureId })
}
