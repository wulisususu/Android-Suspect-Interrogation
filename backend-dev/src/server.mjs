import http from 'node:http'
import {
  addMessage,
  addTimelineEvent,
  changeStage,
  createCase,
  deviceStatus,
  finishSession,
  getCase,
  getSessionState,
  invokeDevice,
  listAudit,
  listCases,
  listFacts,
  listMessages,
  listRevisions,
  listTimeline,
  markMessage,
  pauseSession,
  resumeSession,
  startSession,
  updateCase,
  updateFact,
  updateMessage,
} from './store.mjs'
import { proxyInquiry } from './aiProxy.mjs'
import { getAiSettingsStatus, updateAiSettings } from './aiSettings.mjs'

const host = process.env.HOST || '127.0.0.1'
const port = Number(process.env.PORT || 8080)

function corsHeaders(req) {
  const origin = req.headers.origin || '*'
  return {
    'Access-Control-Allow-Origin': origin,
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Requested-With',
    'Access-Control-Allow-Methods': 'GET,POST,PUT,PATCH,OPTIONS',
    Vary: 'Origin',
  }
}

function json(res, req, status, data) {
  res.writeHead(status, {
    ...corsHeaders(req),
    'Content-Type': 'application/json; charset=utf-8',
    'Cache-Control': 'no-store',
  })
  res.end(JSON.stringify(data))
}

function ok(res, req, data, message = 'OK') {
  json(res, req, 200, { ok: true, code: 'OK', message, data })
}

async function body(req) {
  const chunks = []
  for await (const chunk of req) chunks.push(chunk)
  if (!chunks.length) return {}
  const raw = Buffer.concat(chunks).toString('utf8')
  if (!raw.trim()) return {}
  try {
    return JSON.parse(raw)
  } catch {
    const error = new Error('请求体不是有效 JSON')
    error.code = 'INVALID_JSON'
    error.status = 400
    throw error
  }
}

function pathMatch(pathname, pattern) {
  const actual = pathname.split('/').filter(Boolean)
  const expected = pattern.split('/').filter(Boolean)
  if (actual.length !== expected.length) return null
  const params = {}
  for (let i = 0; i < expected.length; i += 1) {
    const segment = expected[i]
    if (segment.startsWith(':')) params[segment.slice(1)] = decodeURIComponent(actual[i])
    else if (segment !== actual[i]) return null
  }
  return params
}

async function handle(req, res) {
  if (req.method === 'OPTIONS') {
    res.writeHead(204, corsHeaders(req))
    return res.end()
  }

  const url = new URL(req.url, `http://${req.headers.host || `${host}:${port}`}`)
  const p = url.pathname
  let params

  if (req.method === 'GET' && p === '/api/health') {
    return ok(res, req, { service: 'suspect-interrogation-backend', status: 'ready', timestamp: Date.now() })
  }
  if (req.method === 'GET' && p === '/api/ai/settings') return ok(res, req, getAiSettingsStatus())
  if (req.method === 'PATCH' && p === '/api/ai/settings') {
    return ok(res, req, updateAiSettings(await body(req)), 'AI 设置已保存')
  }
  if (req.method === 'GET' && p === '/api/cases') return ok(res, req, listCases(Number(url.searchParams.get('limit') || 100)))
  if (req.method === 'POST' && p === '/api/cases/create') return ok(res, req, createCase(await body(req)), '案件已创建')

  if ((params = pathMatch(p, '/api/cases/:caseId'))) {
    if (req.method === 'GET') {
      const item = getCase(params.caseId)
      if (!item) return json(res, req, 404, { ok: false, code: 'CASE_NOT_FOUND', message: '案件不存在' })
      return ok(res, req, item)
    }
    if (req.method === 'PUT') return ok(res, req, updateCase(params.caseId, await body(req)), '案件信息已保存')
  }

  if ((params = pathMatch(p, '/work/case/:caseId')) && req.method === 'GET') return ok(res, req, getCase(params.caseId))
  if ((params = pathMatch(p, '/work/case/:caseId/message'))) {
    if (req.method === 'GET') return ok(res, req, listMessages(params.caseId, Number(url.searchParams.get('limit') || 1000)))
    if (req.method === 'POST') {
      const payload = await body(req)
      return ok(res, req, addMessage(params.caseId, payload.profile || payload), '问答已保存')
    }
  }

  if ((params = pathMatch(p, '/api/cases/:caseId/messages')) && req.method === 'GET') {
    return ok(res, req, listMessages(params.caseId, Number(url.searchParams.get('limit') || 1000)))
  }
  if ((params = pathMatch(p, '/api/cases/:caseId/messages/:messageId'))) {
    if (req.method === 'PUT') return ok(res, req, updateMessage(params.caseId, params.messageId, await body(req)), '笔录已修订并生成版本')
  }
  if ((params = pathMatch(p, '/api/cases/:caseId/messages/:messageId/mark')) && req.method === 'POST') {
    const payload = await body(req)
    return ok(res, req, markMessage(params.caseId, params.messageId, payload.mark || 'conflict'), '标记已保存')
  }
  if ((params = pathMatch(p, '/api/cases/:caseId/messages/:messageId/revisions')) && req.method === 'GET') {
    return ok(res, req, listRevisions(params.caseId, params.messageId))
  }
  if ((params = pathMatch(p, '/api/cases/:caseId/revisions')) && req.method === 'GET') return ok(res, req, listRevisions(params.caseId))

  if ((params = pathMatch(p, '/api/cases/:caseId/facts')) && req.method === 'GET') return ok(res, req, listFacts(params.caseId))
  if ((params = pathMatch(p, '/api/cases/:caseId/facts/:factKey')) && req.method === 'PUT') {
    return ok(res, req, updateFact(params.caseId, params.factKey, await body(req)), '事实项已更新')
  }
  if ((params = pathMatch(p, '/api/cases/:caseId/timeline'))) {
    if (req.method === 'GET') return ok(res, req, listTimeline(params.caseId))
    if (req.method === 'POST') return ok(res, req, addTimelineEvent(params.caseId, await body(req)), '时间线事件已添加')
  }

  if ((params = pathMatch(p, '/api/cases/:caseId/session'))) {
    if (req.method === 'GET') return ok(res, req, getSessionState(params.caseId))
  }
  if ((params = pathMatch(p, '/api/cases/:caseId/session/start')) && req.method === 'POST') return ok(res, req, startSession(params.caseId), '审讯已开始')
  if ((params = pathMatch(p, '/api/cases/:caseId/session/pause')) && req.method === 'POST') return ok(res, req, pauseSession(params.caseId), '审讯已暂停')
  if ((params = pathMatch(p, '/api/cases/:caseId/session/resume')) && req.method === 'POST') return ok(res, req, resumeSession(params.caseId), '审讯已恢复')
  if ((params = pathMatch(p, '/api/cases/:caseId/session/finish')) && req.method === 'POST') return ok(res, req, finishSession(params.caseId), '审讯已结束，进入复核')
  if ((params = pathMatch(p, '/api/cases/:caseId/session/stage')) && req.method === 'POST') {
    const payload = await body(req)
    return ok(res, req, changeStage(params.caseId, payload.stage), '审讯阶段已切换')
  }

  if ((params = pathMatch(p, '/api/cases/:caseId/audit')) && req.method === 'GET') return ok(res, req, listAudit(params.caseId))

  if (req.method === 'GET' && p === '/api/device/status') return ok(res, req, deviceStatus())
  if (req.method === 'POST' && p === '/api/device/action') {
    const payload = await body(req)
    return ok(res, req, invokeDevice(payload.type), '设备操作完成')
  }

  if ((params = pathMatch(p, '/work/case/:caseId/session/message/inquiry')) && req.method === 'GET') {
    const message = String(url.searchParams.get('message') || '').trim()
    if (!message) return json(res, req, 400, { ok: false, code: 'EMPTY_MESSAGE', message: 'AI 询问内容不能为空' })
    return proxyInquiry({ req, res, caseId: params.caseId, message })
  }

  return json(res, req, 404, { ok: false, code: 'NOT_FOUND', message: `未找到接口：${req.method} ${p}` })
}

export const server = http.createServer((req, res) => {
  handle(req, res).catch((error) => {
    console.error('[backend]', error)
    if (res.headersSent) return res.end()
    json(res, req, Number(error.status || 500), {
      ok: false,
      code: error.code || 'INTERNAL_ERROR',
      message: error.message || '后端内部错误',
    })
  })
})

server.listen(port, host, () => {
  console.log(`[suspect-backend] http://${host}:${port}`)
})
