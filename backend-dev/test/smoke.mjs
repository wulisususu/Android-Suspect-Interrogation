import { spawn } from 'node:child_process'
import fs from 'node:fs'
import os from 'node:os'
import path from 'node:path'

const port = 18080 + Math.floor(Math.random() * 1000)
const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'suspect-backend-'))

const child = spawn(process.execPath, ['src/server.mjs'], {
  cwd: path.resolve(import.meta.dirname, '..'),
  env: {
    ...process.env,
    HOST: '127.0.0.1',
    PORT: String(port),
    DB_PATH: path.join(tmp, 'test.db'),
    DEVICE_SIMULATOR: '0',
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

  let result = await request('/api/cases/create', {
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

  result = await request('/api/ai/settings')
  if (result.response.status !== 404) throw new Error('cloud AI settings endpoint must not exist')

  result = await request(`/work/case/${caseId}/session/message/inquiry?message=${encodeURIComponent('测试')}`)
  if (result.response.status !== 404) throw new Error('browser cloud AI inquiry endpoint must not exist')

  console.log(`smoke ok: ${caseId}`)
} finally {
  child.kill('SIGTERM')
}
