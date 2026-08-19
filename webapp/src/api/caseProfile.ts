import { callNative, isNativeBusinessRuntime } from '../native/rpcBridge'
import type { BackendEnvelope, CaseSummary, FactItem } from '../types/interrogation'
import { http } from './http'

function unwrap<T>(payload: BackendEnvelope<T> | T): T {
  if (payload && typeof payload === 'object' && 'ok' in payload && 'data' in payload) {
    const envelope = payload as BackendEnvelope<T>
    if (!envelope.ok) throw new Error(envelope.message || envelope.code)
    return envelope.data
  }
  return payload as T
}

export async function updateCaseProfile(caseId: string, patch: Partial<CaseSummary>): Promise<CaseSummary> {
  if (isNativeBusinessRuntime()) {
    return callNative<CaseSummary>('case.update', { caseId, ...patch } as Record<string, unknown>)
  }
  const { data } = await http.put(`/api/cases/${encodeURIComponent(caseId)}`, patch)
  return unwrap<CaseSummary>(data)
}

export async function updateCaseFact(
  caseId: string,
  factKey: string,
  patch: Partial<Pick<FactItem, 'value' | 'status' | 'suggestion'>>,
): Promise<FactItem> {
  if (isNativeBusinessRuntime()) {
    return callNative<FactItem>('fact.update', { caseId, factKey, ...patch } as Record<string, unknown>)
  }
  const { data } = await http.put(`/api/cases/${encodeURIComponent(caseId)}/facts/${encodeURIComponent(factKey)}`, patch)
  return unwrap<FactItem>(data)
}
