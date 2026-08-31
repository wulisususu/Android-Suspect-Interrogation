import { http } from './http'

export type SpeakerCalibrationStatus =
  | 'NOT_CALIBRATED'
  | 'VALID'
  | 'STALE_MODEL'
  | 'STALE_MIC'
  | 'RECOMPUTE_RECOMMENDED'
  | 'INSUFFICIENT_DATA'

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
  currentModel: { modelId: string; modelVersion?: string | null; fingerprint: string }
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
    if (!envelope.ok) throw new Error(envelope.message || envelope.code || '设备校准接口返回错误')
    return envelope.data
  }
  return payload as T
}

export async function fetchSpeakerCalibrationStatus(): Promise<SpeakerCalibrationState> {
  const response = await http.get('/api/v1/speaker-calibration/status')
  return unwrap<SpeakerCalibrationState>(response.data)
}

export async function fetchSpeakerCalibrationHistory(limit = 50): Promise<SpeakerCalibrationRecord[]> {
  const response = await http.get('/api/v1/speaker-calibration/history', { params: { limit } })
  return unwrap<SpeakerCalibrationRecord[]>(response.data)
}

export async function recomputeSpeakerCalibration(actorId?: string): Promise<SpeakerCalibrationState> {
  const response = await http.post('/api/v1/speaker-calibration/recompute', actorId ? { actor_id: actorId } : {})
  return unwrap<SpeakerCalibrationState>(response.data)
}
