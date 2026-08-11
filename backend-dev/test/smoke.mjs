import { spawn } from 'node:child_process'
import fs from 'node:fs'
import http from 'node:http'
import os from 'node:os'
import path from 'node:path'

const port = 18080 + Math.floor(Math.random() * 1000)
const aiPort = 20080 + Math.floor(Math.random() * 1000)
const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'suspect-backend-'))
let aiRequest = null
const aiServer = http.createServer(async (req, res) => {
  const chunks = []
  for await (const chunk of req) chunks.push(chunk)
  aiRequest = {
    authorization: req.headers.authorization,
    body: JSON.parse(Buffer.concat(chunks).toString('utf8')),
  }
  res.writeHead(200, { 'Content-Type': 'text/event-stream; charset=utf-8' })
  res.write(`data: ${JSON.stringify({ choices: [{ delta: { content: '测试' } }] })}\n\n`)
  res.end(`data: ${JSON.stringify({ choices: [{ delta: { content: '通过' } }] })}\n\ndata: [DONE]\n\n`)
})
await new Promise((resolve) => aiServer.listen(aiPort, '127.0.0.1', resolve))

const child = spawn(process.execPath, ['src/server.mjs'], {
  cwd: path.resolve(import.meta.dirname, '..'),
  env: {
    ...process.env,
    HOST: '127.0.0.1',
    PORT: String(port),
    DB_PATH: path.join(tmp, 'test.db'),
    DEVICE_SIMULATOR: '0',
    AI_BIGMODEL_API_KEY: '',
    AI_BIGMODEL_BASE_URL: `http://127.0.0.1:${aiPort}/chat/completions`,
    AI_MODEL: 'test-model',
  },
  stdio: ['ignore', 'pipe', 'pipe'],
})

const base = `http://127.0.0.1:${port}`
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms))

async function request(pathname, options = {}) {
  const response = await fetch(`${base}${pathname}`, {
    ...options,
    headers: { 'Content-Type': 'application/json', ...(options.headers || {}) },
  })
  const payload = await response.json()
  return { response, payload }
}

async function waitReady() {
  for (let i = 0; i < 40; i += 1) {
    try {
      const { response } = await request('/api/health')
      if (response.ok) return
    } catch {}
    await sleep(100)
  }
  throw new Error('server did not become ready')
}

try {
  await waitReady()
  let result = await request('/api/ai/settings')
  if (result.payload.data.cloudConfigured !== false) throw new Error('browser AI must start without a key in smoke test')

  result = await request('/api/ai/settings', {
    method: 'PATCH',
    body: JSON.stringify({
      mode: 'CLOUD',
      cloudBaseUrl: `http://127.0.0.1:${aiPort}/chat/completions`,
      cloudModel: 'test-model',
      apiKey: 'test-api-key',
    }),
  })
  if (!result.payload.data.cloudConfigured) throw new Error('browser AI key was not configured')
  if ('apiKey' in result.payload.data.settings) throw new Error('browser AI key must not be returned')

  result = await request('/api/cases/create', {
    method: 'POST',
    body: JSON.stringify({ suspectName: '测试对象', officerName: '测试警官' }),
  })
  if (!result.response.ok) throw new Error(JSON.stringify(result.payload))
  const caseId = result.payload.data.id

  result = await request(`/api/cases/${caseId}/session/start`, { method: 'POST', body: '{}' })
  if (result.payload.data.status !== 'RUNNING') throw new Error('session did not start')

  result = await request(`/work/case/${caseId}/message`, {
    method: 'POST',
    body: JSON.stringify({ profile: { text: '你叫什么名字？', from: '民警' } }),
  })
  const messageId = result.payload.data.id
  if (!messageId) throw new Error('message was not persisted')

  const inquiry = await fetch(`${base}/work/case/${caseId}/session/message/inquiry?message=${encodeURIComponent('请回答测试')}`)
  const inquiryText = await inquiry.text()
  if (!inquiryText.includes('"text_chunk":"测试"') || !inquiryText.includes('"text_chunk":"通过"')) {
    throw new Error(`AI stream was not translated: ${inquiryText}`)
  }
  if (aiRequest?.authorization !== 'Bearer test-api-key') throw new Error('AI authorization was not forwarded from settings')
  if (aiRequest?.body?.model !== 'test-model') throw new Error('configured AI model was not used')
  if (aiRequest?.body?.messages?.[0]?.content !== '请回答测试') throw new Error('AI message was not forwarded')

  result = await request(`/api/cases/${caseId}/messages/${messageId}`, {
    method: 'PUT',
    body: JSON.stringify({ text: '请说明你的姓名。', reason: '联调修订' }),
  })
  if (result.payload.data.text !== '请说明你的姓名。') throw new Error('message update failed')

  result = await request(`/api/cases/${caseId}/messages/${messageId}/revisions`)
  if (result.payload.data.length !== 1) throw new Error('revision not created')

  result = await request(`/api/cases/${caseId}/messages/${messageId}/mark`, {
    method: 'POST',
    body: JSON.stringify({ mark: 'conflict' }),
  })
  if (result.payload.data.mark !== 'conflict') throw new Error('mark failed')

  await request(`/api/cases/${caseId}/session/pause`, { method: 'POST', body: '{}' })
  await request(`/api/cases/${caseId}/session/resume`, { method: 'POST', body: '{}' })
  result = await request(`/api/cases/${caseId}/session/stage`, { method: 'POST', body: JSON.stringify({ stage: 'STATEMENT' }) })
  if (result.payload.data.stage !== 'STATEMENT') throw new Error('stage change failed')

  result = await request('/api/device/action', { method: 'POST', body: JSON.stringify({ type: 'identity' }) })
  if (result.response.status !== 409 || result.payload.code !== 'DEVICE_NOT_CONNECTED') throw new Error('device must not fake success')

  result = await request(`/api/cases/${caseId}/session/finish`, { method: 'POST', body: '{}' })
  if (result.payload.data.status !== 'COMPLETED') throw new Error('session did not finish')

  result = await request(`/api/cases/${caseId}/audit`)
  if (result.payload.data.length < 6) throw new Error('audit log missing')

  result = await request('/api/ai/settings', {
    method: 'PATCH',
    body: JSON.stringify({ clearApiKey: true }),
  })
  if (result.payload.data.cloudConfigured !== false) throw new Error('browser AI key was not cleared')

  console.log(`smoke ok: ${caseId}`)
} finally {
  child.kill('SIGTERM')
  await new Promise((resolve) => aiServer.close(resolve))
}
