import { getAuthorizationValue, runtimeConfig } from '../config/runtime'
import type { InquirySsePayload } from '../types/interrogation'
import { http } from './http'
import { streamSse } from './sse'

export async function fetchCase(caseId: string) {
  const { data } = await http.get(`/work/case/${caseId}`)
  return data
}

export async function fetchMessages(caseId: string) {
  const { data } = await http.get(`/work/case/${caseId}/message`, {
    params: { limit: 1000 },
  })
  return data
}

export async function persistQuestionOrAnswer(
  caseId: string,
  text: string,
  from: '民警' | '嫌疑人',
) {
  const { data } = await http.post(`/work/case/${caseId}/message`, {
    profile: {
      text,
      from,
    },
  })
  return data
}

export async function streamInquiry(
  caseId: string,
  message: string,
  onPayload: (payload: InquirySsePayload) => void,
  signal?: AbortSignal,
) {
  const endpoint = new URL(
    `/work/case/${caseId}/session/message/inquiry`,
    runtimeConfig.apiBaseUrl,
  )
  endpoint.searchParams.set('message', message)

  const authorization = getAuthorizationValue()

  await streamSse(
    endpoint.toString(),
    {
      method: 'GET',
      credentials: 'include',
      signal,
      headers: authorization ? { Authorization: authorization } : {},
    },
    ({ data }) => {
      if (data === '[DONE]') return
      try {
        onPayload(JSON.parse(data) as InquirySsePayload)
      } catch {
        onPayload({ text_chunk: data })
      }
    },
  )
}
