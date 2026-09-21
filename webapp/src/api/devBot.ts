export interface DevBotJudgement {
  isAnswer: boolean
  comment: string
}

export async function judgeDevBotReply(question: string, reply: string): Promise<DevBotJudgement> {
  const resp = await fetch('/api/v1/dev/bot/judge', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ question, reply }),
  })
  const payload = await resp.json().catch(() => null)
  if (!resp.ok || !payload || payload.ok === false) {
    throw new Error(payload?.message || `云端判定接口失败（HTTP ${resp.status}）`)
  }
  return { isAnswer: Boolean(payload.data?.isAnswer), comment: String(payload.data?.comment || '') }
}

export async function devBotAsk(caseId: string, text: string): Promise<void> {
  const resp = await fetch('/api/v1/dev/bot/ask', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ case_id: caseId, text }),
  })
  const payload = await resp.json().catch(() => null)
  if (!resp.ok || !payload || payload.ok === false) {
    throw new Error(payload?.message || `BOT 提问接口失败（HTTP ${resp.status}）`)
  }
}

export async function devBotNextQuestion(caseId: string, asked: string[], answers: string[]): Promise<string> {
  const resp = await fetch('/api/v1/dev/bot/next-question', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ case_id: caseId, asked, answers }),
  })
  const payload = await resp.json().catch(() => null)
  if (!resp.ok || !payload || payload.ok === false) {
    throw new Error(payload?.message || `BOT 生成追问失败（HTTP ${resp.status}）`)
  }
  const question = String(payload.data?.question || '').trim()
  if (!question) throw new Error('云端未返回有效问题')
  return question
}
