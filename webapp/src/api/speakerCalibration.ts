import { http } from './http'

export type SpeakerBackendKey = 'xvector' | 'eres2net_large'
export type SpeakerRuntimeMode = SpeakerBackendKey | 'compare'

export function speakerBackendLabel(backend: SpeakerBackendKey): string {
  return backend === 'xvector' ? 'XVector' : 'ERes2Net-large'
}

export function validateSpeakerRuntimeSelection(
  mode: SpeakerRuntimeMode,
  authoritativeBackend: SpeakerBackendKey | null,
): { valid: boolean; reason: string } {
  if (mode === 'compare' && authoritativeBackend === null) {
    return { valid: false, reason: 'Compare 模式必须指定业务 authoritative backend' }
  }
  if (mode !== 'compare' && authoritativeBackend !== null && authoritativeBackend !== mode) {
    return { valid: false, reason: '单后端模式的 authoritative backend 必须与当前模式一致' }
  }
  return { valid: true, reason: '' }
}

export type SpeakerCalibrationStatus =
  | 'NOT_CALIBRATED'
  | 'VALID'
  | 'STALE_MODEL'
  | 'STALE_MIC'
  | 'RECOMPUTE_RECOMMENDED'
  | 'INSUFFICIENT_DATA'

export interface SpeakerBackendHealth {
  ready: boolean
  installed: boolean
  modelId?: string | null
  modelVersion?: string | null
  modelFingerprint?: string | null
  errorCode?: string | null
  errorType?: string | null
}

export interface SpeakerRuntimeState {
  selection: { mode: SpeakerRuntimeMode; authoritativeBackend: SpeakerBackendKey }
  backends: Record<SpeakerBackendKey, SpeakerBackendHealth>
  degraded: boolean
  comparisonMetrics: {
    correctRoleRate: number | null
    errorRate: number | null
    unknownRate: number | null
    latencyMs: Record<SpeakerBackendKey, number | null>
    status: string
  }
}

export interface SpeakerCalibrationRecord {
  calibrationId: string
  statusAtCreation: string
  threshold: number
  margin: number | null
  far: number
  frr: number
  eer: number
  eerThreshold: number
  eerFar: number
  eerFrr: number
  genuineTrialCount: number
  impostorTrialCount: number
  officerCount: number
  sampleCount: number
  corpusDigest: string
  algorithmVersion: string
  speakerBackendKey: SpeakerBackendKey
  speakerModelId: string
  speakerModelVersion?: string | null
  speakerModelFingerprint: string
  audioSource: string
  microphoneId: string
  microphoneName: string
  microphoneFingerprint: string
  microphoneFingerprintCertainty: string
  createdBy?: string | null
  createdAt?: string | null
  metricScope: 'LOCAL_FINITE_CORPUS_ESTIMATE'
}

export interface SpeakerCalibrationState {
  status: SpeakerCalibrationStatus
  calibrationUsable: boolean
  reason: string
  minimumOfficers: number
  minimumSamplesPerOfficer: number
  currentCorpus: { officerCount: number; sampleCount: number; digest: string; ready: boolean }
  currentModel: {
    backendKey: SpeakerBackendKey
    modelId: string
    modelVersion?: string | null
    fingerprint: string
  }
  currentMicrophone: {
    audioSource: string
    deviceId: string
    deviceName: string
    fingerprint: string
    fingerprintCertainty: string
  }
  calibration: SpeakerCalibrationRecord | null
}

function unwrap<T>(payload: unknown): T {
  if (payload && typeof payload === 'object' && 'ok' in payload && 'data' in payload) {
    const envelope = payload as { ok: boolean; data: T; code?: string; message?: string }
    if (!envelope.ok) throw new Error(envelope.message || envelope.code || '声纹系统接口返回错误')
    return envelope.data
  }
  return payload as T
}

export async function fetchSpeakerRuntimeStatus(): Promise<SpeakerRuntimeState> {
  const response = await http.get('/api/v1/speaker-runtime')
  return unwrap<SpeakerRuntimeState>(response.data)
}

export async function updateSpeakerRuntimeSelection(
  mode: SpeakerRuntimeMode,
  authoritativeBackend: SpeakerBackendKey | null,
): Promise<SpeakerRuntimeState> {
  const validation = validateSpeakerRuntimeSelection(mode, authoritativeBackend)
  if (!validation.valid) throw new Error(validation.reason)
  const response = await http.put('/api/v1/speaker-runtime/selection', {
    mode,
    ...(mode === 'compare' ? { authoritative_backend: authoritativeBackend } : {}),
  })
  return unwrap<SpeakerRuntimeState>(response.data)
}

export async function fetchSpeakerCalibrationStatus(
  backend: SpeakerBackendKey = 'xvector',
): Promise<SpeakerCalibrationState> {
  const response = await http.get('/api/v1/speaker-calibration/status', { params: { backend } })
  return unwrap<SpeakerCalibrationState>(response.data)
}

export async function fetchSpeakerCalibrationHistory(
  limit = 50,
  backend: SpeakerBackendKey = 'xvector',
): Promise<SpeakerCalibrationRecord[]> {
  const response = await http.get('/api/v1/speaker-calibration/history', { params: { limit, backend } })
  return unwrap<SpeakerCalibrationRecord[]>(response.data)
}

export async function recomputeSpeakerCalibration(
  actorId?: string,
  backend: SpeakerBackendKey = 'xvector',
): Promise<SpeakerCalibrationState> {
  const response = await http.post(
    '/api/v1/speaker-calibration/recompute',
    actorId ? { actor_id: actorId } : {},
    { params: { backend } },
  )
  return unwrap<SpeakerCalibrationState>(response.data)
}
