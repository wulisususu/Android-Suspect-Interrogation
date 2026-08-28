import type { AxiosResponse } from 'axios'

import { http } from './http'
import type { BackendEnvelope } from '../types/interrogation'
import type {
  CaseQuestionCreateInput,
  CaseQuestionUpdateInput,
  FormalQuestion,
  FormalQuestionRound,
  PendingFormalQuestion,
  RoundReassociateInput,
  StandardQuestion,
  TemplateWorkspace,
} from '../types/templateInterrogation'

function unwrap<T>(response: AxiosResponse<BackendEnvelope<T>>): T {
  const body = response.data
  if (!body.ok) throw new Error(body.message || body.code || '模板笔录接口调用失败')
  return body.data
}

export async function fetchTemplateWorkspace(caseId: string): Promise<TemplateWorkspace> {
  return unwrap(await http.get<BackendEnvelope<TemplateWorkspace>>(`/api/v1/cases/${encodeURIComponent(caseId)}/template-workspace`))
}

export async function fetchQuestionLibrary(category?: string): Promise<StandardQuestion[]> {
  return unwrap(await http.get<BackendEnvelope<StandardQuestion[]>>('/api/v1/question-library', {
    params: category ? { category } : undefined,
  }))
}

export async function createCaseQuestion(caseId: string, input: CaseQuestionCreateInput): Promise<FormalQuestion> {
  return unwrap(await http.post<BackendEnvelope<FormalQuestion>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/questions`,
    {
      text: input.text,
      source: input.source ?? 'CASE',
      standardQuestionId: input.standardQuestionId ?? null,
      regexPatterns: input.regexPatterns ?? [],
      afterQuestionId: input.afterQuestionId ?? null,
    },
  ))
}

export async function updateCaseQuestion(caseId: string, questionId: string, input: CaseQuestionUpdateInput): Promise<FormalQuestion> {
  return unwrap(await http.patch<BackendEnvelope<FormalQuestion>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/questions/${encodeURIComponent(questionId)}`,
    input,
  ))
}

export async function reorderCaseQuestions(caseId: string, questionIds: string[]): Promise<FormalQuestion[]> {
  return unwrap(await http.post<BackendEnvelope<FormalQuestion[]>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/questions/reorder`,
    { questionIds },
  ))
}

export async function addPendingQuestion(caseId: string, pendingId: string, afterQuestionId?: string | null): Promise<FormalQuestionRound> {
  return unwrap(await http.post<BackendEnvelope<FormalQuestionRound>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/pending-questions/${encodeURIComponent(pendingId)}/add`,
    { afterQuestionId: afterQuestionId ?? null },
  ))
}

export async function linkPendingQuestion(
  caseId: string,
  pendingId: string,
  caseQuestionId: string,
  roundMode: 'APPEND_EXISTING' | 'NEW_ROUND',
): Promise<FormalQuestionRound> {
  return unwrap(await http.post<BackendEnvelope<FormalQuestionRound>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/pending-questions/${encodeURIComponent(pendingId)}/link`,
    { caseQuestionId, roundMode },
  ))
}

export async function ignorePendingQuestion(caseId: string, pendingId: string): Promise<PendingFormalQuestion> {
  return unwrap(await http.post<BackendEnvelope<PendingFormalQuestion>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/pending-questions/${encodeURIComponent(pendingId)}/ignore`,
  ))
}

export async function reassociateRound(caseId: string, roundId: string, input: RoundReassociateInput): Promise<FormalQuestionRound> {
  return unwrap(await http.post<BackendEnvelope<FormalQuestionRound>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/rounds/${encodeURIComponent(roundId)}/reassociate`,
    input,
  ))
}

export async function updateRoundAnswer(caseId: string, roundId: string, answerText: string): Promise<FormalQuestionRound> {
  return unwrap(await http.patch<BackendEnvelope<FormalQuestionRound>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/rounds/${encodeURIComponent(roundId)}`,
    { answerText },
  ))
}

export async function saveQuestionToLibrary(caseId: string, questionId: string, category = '通用'): Promise<StandardQuestion> {
  return unwrap(await http.post<BackendEnvelope<StandardQuestion>>(
    `/api/v1/cases/${encodeURIComponent(caseId)}/questions/${encodeURIComponent(questionId)}/save-to-library`,
    { category },
  ))
}
