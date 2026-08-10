import { saveAiSuggestion } from './store.mjs'

function baseUrl() {
  const value = process.env.AI_UPSTREAM_BASE_URL || 'https://uat.pediatrician-ai.fb.jnpinno.com/'
  return value.endsWith('/') ? value : `${value}/`
}

export async function proxyInquiry({ req, res, caseId, message }) {
  const target = new URL(`/work/case/${encodeURIComponent(caseId)}/session/message/inquiry`, baseUrl())
  target.searchParams.set('message', message)

  const controller = new AbortController()
  const timeout = setTimeout(() => controller.abort(), Number(process.env.AI_UPSTREAM_TIMEOUT_MS || 120000))
  const headers = { Accept: 'text/event-stream' }
  if (req.headers.authorization) headers.Authorization = req.headers.authorization
  if (req.headers.cookie) headers.Cookie = req.headers.cookie

  let upstream
  try {
    upstream = await fetch(target, { method: 'GET', headers, signal: controller.signal })
  } catch (error) {
    clearTimeout(timeout)
    res.writeHead(502, sseHeaders(req))
    res.end(`data: ${JSON.stringify({ code: 50201, message: `AI 上游连接失败：${error.message}` })}\n\ndata: [DONE]\n\n`)
    return
  }

  res.writeHead(upstream.status, {
    ...sseHeaders(req),
    'x-ai-upstream-status': String(upstream.status),
  })

  if (!upstream.body) {
    clearTimeout(timeout)
    res.end(`data: ${JSON.stringify({ code: 50202, message: 'AI 上游未返回流式响应' })}\n\ndata: [DONE]\n\n`)
    return
  }

  let buffer = ''
  let output = ''
  try {
    for await (const chunk of upstream.body) {
      const text = Buffer.from(chunk).toString('utf8')
      res.write(text)
      buffer += text
      const blocks = buffer.split(/\r?\n\r?\n/)
      buffer = blocks.pop() || ''
      for (const block of blocks) {
        for (const line of block.split(/\r?\n/)) {
          if (!line.startsWith('data:')) continue
          const data = line.slice(5).trim()
          if (!data || data === '[DONE]') continue
          try {
            const payload = JSON.parse(data)
            if (payload.text_chunk) output += payload.text_chunk
          } catch {
            output += data
          }
        }
      }
    }
  } finally {
    clearTimeout(timeout)
    if (output.trim()) saveAiSuggestion(caseId, message, output)
    res.end()
  }
}

function sseHeaders(req) {
  const origin = req.headers.origin || '*'
  return {
    'Content-Type': 'text/event-stream; charset=utf-8',
    'Cache-Control': 'no-cache, no-transform',
    Connection: 'keep-alive',
    'Access-Control-Allow-Origin': origin,
    'Access-Control-Allow-Credentials': 'true',
    Vary: 'Origin',
  }
}
