import { getAiRuntimeConfig } from './aiSettings.mjs'
import { saveAiSuggestion } from './store.mjs'

export async function proxyInquiry({ req, res, caseId, message }) {
  const runtime = getAiRuntimeConfig()
  if (runtime.settings.mode === 'LOCAL' || runtime.settings.mode === 'OFFLINE_ONLY') {
    return sendError(res, req, 40001, 'Windows 联调环境未接入本地模型，请切换到云端 API')
  }
  if (!runtime.apiKey) {
    return sendError(res, req, 40101, '智谱 API Key 尚未配置，请先打开 AI 设置')
  }

  const controller = new AbortController()
  const timeout = setTimeout(() => controller.abort(), Number(process.env.AI_UPSTREAM_TIMEOUT_MS || 120_000))
  let upstream
  try {
    upstream = await fetch(runtime.settings.cloudBaseUrl, {
      method: 'POST',
      headers: {
        Accept: runtime.settings.stream ? 'text/event-stream' : 'application/json',
        Authorization: `Bearer ${runtime.apiKey}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: runtime.settings.cloudModel,
        messages: [{ role: 'user', content: message }],
        thinking: { type: runtime.settings.thinkingEnabled ? 'enabled' : 'disabled' },
        stream: runtime.settings.stream,
        max_tokens: runtime.settings.maxTokens,
        temperature: runtime.settings.temperature,
      }),
      signal: controller.signal,
    })
  } catch (error) {
    clearTimeout(timeout)
    const reason = error.name === 'AbortError' ? '请求超时' : error.message
    return sendError(res, req, 50201, `AI API 连接失败：${reason}`)
  }

  if (!upstream.ok) {
    clearTimeout(timeout)
    const raw = await upstream.text()
    return sendError(res, req, upstream.status, cloudErrorMessage(raw, upstream.status))
  }

  res.writeHead(200, sseHeaders(req))
  let output = ''
  try {
    if (runtime.settings.stream) {
      output = await pipeStream(upstream, res)
    } else {
      const payload = await upstream.json()
      output = extractContent(payload)
      if (output) writeChunk(res, output)
    }
    if (!output) writeError(res, 50202, 'AI API 返回成功，但回答内容为空')
    res.write('data: [DONE]\n\n')
  } catch (error) {
    writeError(res, 50203, `AI 响应读取失败：${error.message}`)
    res.write('data: [DONE]\n\n')
  } finally {
    clearTimeout(timeout)
    if (output.trim()) saveAiSuggestion(caseId, message, output)
    res.end()
  }
}

async function pipeStream(upstream, res) {
  if (!upstream.body) return ''
  const decoder = new TextDecoder()
  let buffer = ''
  let output = ''
  for await (const chunk of upstream.body) {
    buffer += decoder.decode(chunk, { stream: true })
    const lines = buffer.split(/\r?\n/)
    buffer = lines.pop() || ''
    for (const line of lines) output += processDataLine(line, res)
  }
  buffer += decoder.decode()
  if (buffer) output += processDataLine(buffer, res)
  return output
}

function processDataLine(line, res) {
  if (!line.startsWith('data:')) return ''
  const data = line.slice(5).trim()
  if (!data || data === '[DONE]') return ''
  try {
    const content = extractContent(JSON.parse(data))
    if (content) writeChunk(res, content)
    return content
  } catch {
    return ''
  }
}

function extractContent(payload) {
  const choice = payload?.choices?.[0]
  return String(choice?.delta?.content || choice?.message?.content || '')
}

function writeChunk(res, text) {
  res.write(`data: ${JSON.stringify({ text_chunk: text })}\n\n`)
}

function writeError(res, code, message) {
  res.write(`data: ${JSON.stringify({ code, message })}\n\n`)
}

function sendError(res, req, code, message) {
  res.writeHead(200, sseHeaders(req))
  writeError(res, code, message)
  res.end('data: [DONE]\n\n')
}

function cloudErrorMessage(raw, status) {
  try {
    const payload = JSON.parse(raw)
    return payload?.error?.message || payload?.message || `AI API 请求失败（HTTP ${status}）`
  } catch {
    return `AI API 请求失败（HTTP ${status}）`
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
