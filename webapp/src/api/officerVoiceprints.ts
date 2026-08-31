import { http } from './http'

export interface OfficerVoiceSample {
  sampleId: string
  active: boolean
  quality: string
  usableDurationMs: number
  segmentCount: number
  audioSource: string
  deviceId?: string | null
  deviceName?: string | null
  modelId: string
  modelVersion?: string | null
  capturedAt?: string | null
  disabledAt?: string | null
  disabledReason?: string | null
  createdBy?: string | null
}

export interface OfficerVoiceProfile {
  voiceprintId?: string
  profileId: string
  bridgeVoiceprintId?: string | null
  officerId: string
  officerName: string
  active: boolean
  revokedAt?: string | null
  sampleCount: number
  aggregateVersion: number
  usableDurationMs: number
  embeddingDim: number
  modelId: string
  modelVersion?: string | null
  quality: string
  updatedAt?: string | null
  samples?: OfficerVoiceSample[]
}

function unwrap<T>(payload: unknown): T {
  if (payload && typeof payload === 'object' && 'ok' in payload && 'data' in payload) {
    const envelope = payload as { ok: boolean; data: T; code?: string; message?: string }
    if (!envelope.ok) throw new Error(envelope.message || envelope.code || '民警声纹库接口返回错误')
    return envelope.data
  }
  return payload as T
}

export async function fetchOfficerVoiceProfiles(activeOnly = false): Promise<OfficerVoiceProfile[]> {
  const response = await http.get('/api/v1/officer-voiceprints', { params: { active_only: activeOnly } })
  return unwrap<OfficerVoiceProfile[]>(response.data)
}

export async function fetchOfficerVoiceProfile(officerId: string): Promise<OfficerVoiceProfile> {
  const response = await http.get(`/api/v1/officer-voiceprints/${encodeURIComponent(officerId)}`)
  return unwrap<OfficerVoiceProfile>(response.data)
}

export async function disableOfficerVoiceSample(
  officerId: string,
  sampleId: string,
  reason = '管理员停用',
  actorId?: string,
): Promise<OfficerVoiceProfile> {
  const response = await http.delete(
    `/api/v1/officer-voiceprints/${encodeURIComponent(officerId)}/samples/${encodeURIComponent(sampleId)}`,
    { data: { reason, actor_id: actorId } },
  )
  return unwrap<OfficerVoiceProfile>(response.data)
}

export async function revokeOfficerVoiceProfile(officerId: string, actorId?: string): Promise<OfficerVoiceProfile> {
  const response = await http.delete(`/api/v1/officer-voiceprints/${encodeURIComponent(officerId)}`, {
    params: actorId ? { actor_id: actorId } : undefined,
  })
  return unwrap<OfficerVoiceProfile>(response.data)
}
