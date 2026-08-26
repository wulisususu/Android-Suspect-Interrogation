import { getRuntimeAdapter } from '../runtime'
import type { CaseSummary, FactItem } from '../types/interrogation'

export async function updateCaseProfile(caseId: string, patch: Partial<CaseSummary>): Promise<CaseSummary> {
  return getRuntimeAdapter().invoke<CaseSummary>('case.update', { caseId, patch: patch as Record<string, unknown> })
}

export async function updateCaseFact(
  caseId: string,
  factKey: string,
  patch: Partial<Pick<FactItem, 'value' | 'status' | 'suggestion'>>,
): Promise<FactItem> {
  return getRuntimeAdapter().invoke<FactItem>('fact.update', { caseId, factKey, patch: patch as Record<string, unknown> })
}
