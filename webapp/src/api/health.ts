export type HealthState = 'READY' | 'ERROR' | 'LOW_SPACE' | 'UNAVAILABLE' | 'NOT_INSTALLED'

export interface HealthItem {
  state: HealthState | string
  required: boolean
  detail: string
}

export interface ReadinessResponse {
  status: 'ready' | 'degraded'
  checks: Record<string, HealthItem>
  capabilities: Record<string, HealthItem>
}

export interface LiveResponse {
  status: 'alive'
}

export async function fetchLive(signal?: AbortSignal): Promise<LiveResponse> {
  const response = await fetch('/health/live', {
    method: 'GET',
    headers: { Accept: 'application/json' },
    cache: 'no-store',
    signal,
  })
  if (!response.ok) {
    throw new Error(`liveness request failed: HTTP ${response.status}`)
  }
  return (await response.json()) as LiveResponse
}

export async function fetchReadiness(signal?: AbortSignal): Promise<ReadinessResponse> {
  const response = await fetch('/health/ready', {
    method: 'GET',
    headers: { Accept: 'application/json' },
    cache: 'no-store',
    signal,
  })
  if (!response.ok) {
    throw new Error(`readiness request failed: HTTP ${response.status}`)
  }
  return (await response.json()) as ReadinessResponse
}
