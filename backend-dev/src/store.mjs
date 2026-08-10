import crypto from 'node:crypto'
import { db, transaction } from './db.mjs'

const STAGES = ['IDENTITY', 'STATEMENT', 'FOLLOW_UP', 'SIGNING']
const now = () => Date.now()
const id = () => crypto.randomUUID()

const defaultFacts = [
  ['time', '时间', '待根据问答核实', 'pending', '固定到达、离开和关键行为的具体时间。'],
  ['place', '地点', '待根据问答核实', 'pending', '确认具体地点、入口和移动路线。'],
  ['motive', '动机 / 目的', '待核实', 'pending', '追问事前联系、约定和准备行为。'],
  ['method', '手段 / 工具', '尚未固定', 'missing', '确认工具来源、携带方式和最终去向。'],
  ['process', '行为经过', '尚未形成完整顺序', 'missing', '把关键动作拆成连续问题逐项固定。'],
  ['evidence', '证据对应', '待绑定', 'pending', '将回答与监控、照片、物证等证据编号关联。'],
  ['after', '事后处置 / 后果', '尚未固定', 'missing', '确认离开路线、物品处置以及是否联系他人。'],
]

function audit(caseId, action, targetType, targetId, detail = {}) {
  db.prepare(`
    INSERT INTO audit_logs(id, case_id, action, target_type, target_id, detail_json, created_at)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `).run(id(), caseId || null, action, targetType || null, targetId || null, JSON.stringify(detail), now())
}

function mapCase(row) {
  if (!row) return null
  return {
    id: row.id,
    suspectName: row.suspect_name,
    gender: row.gender || '',
    age: row.age || '',
    officerName: row.officer_name,
    state: row.state,
    stage: row.stage,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  }
}

function seedCaseDetails(caseId) {
  const ts = now()
  const insertFact = db.prepare(`
    INSERT OR IGNORE INTO facts(case_id, fact_key, label, value, status, suggestion, updated_at)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `)
  for (const [factKey, label, value, status, suggestion] of defaultFacts) {
    insertFact.run(caseId, factKey, label, value, status, suggestion, ts)
  }
}

export function createCase(input = {}) {
  const ts = now()
  const caseId = String(input.id || `CASE-${new Date(ts).toISOString().slice(0, 10).replaceAll('-', '')}-${Math.random().toString(36).slice(2, 7).toUpperCase()}`)
  return transaction(() => {
    db.prepare(`
      INSERT INTO cases(id, suspect_name, gender, age, officer_name, state, stage, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, 'DRAFT', 'IDENTITY', ?, ?)
    `).run(
      caseId,
      String(input.suspectName || '待录入'),
      input.gender ? String(input.gender) : null,
      input.age ? String(input.age) : null,
      String(input.officerName || '当前警官'),
      ts,
      ts,
    )
    seedCaseDetails(caseId)
    audit(caseId, 'CASE_CREATE', 'CASE', caseId, input)
    return getCase(caseId)
  })
}

export function ensureCase(caseId) {
  return getCase(caseId) || createCase({ id: caseId })
}

export function listCases(limit = 100) {
  return db.prepare('SELECT * FROM cases ORDER BY updated_at DESC LIMIT ?').all(Number(limit)).map(mapCase)
}

export function getCase(caseId) {
  return mapCase(db.prepare('SELECT * FROM cases WHERE id = ?').get(caseId))
}

export function updateCase(caseId, patch = {}) {
  const current = ensureCase(caseId)
  const next = {
    suspectName: patch.suspectName ?? current.suspectName,
    gender: patch.gender ?? current.gender,
    age: patch.age ?? current.age,
    officerName: patch.officerName ?? current.officerName,
    state: patch.state ?? current.state,
    stage: patch.stage ?? current.stage,
  }
  if (!STAGES.includes(next.stage)) throw businessError('INVALID_STAGE', '无效审讯阶段', 400)
  db.prepare(`
    UPDATE cases
    SET suspect_name=?, gender=?, age=?, officer_name=?, state=?, stage=?, updated_at=?
    WHERE id=?
  `).run(next.suspectName, next.gender || null, next.age || null, next.officerName, next.state, next.stage, now(), caseId)
  audit(caseId, 'CASE_UPDATE', 'CASE', caseId, patch)
  return getCase(caseId)
}

function activeSessionRow(caseId) {
  return db.prepare(`
    SELECT * FROM interrogation_sessions
    WHERE case_id = ? AND status IN ('RUNNING', 'PAUSED')
    ORDER BY updated_at DESC LIMIT 1
  `).get(caseId)
}

function latestSessionRow(caseId) {
  return db.prepare(`SELECT * FROM interrogation_sessions WHERE case_id=? ORDER BY updated_at DESC LIMIT 1`).get(caseId)
}

function mapSession(row, fallbackCase) {
  if (!row) {
    return {
      id: null,
      caseId: fallbackCase.id,
      status: 'READY',
      stage: fallbackCase.stage,
      startedAt: null,
      pausedAt: null,
      endedAt: null,
      updatedAt: fallbackCase.updatedAt,
    }
  }
  return {
    id: row.id,
    caseId: row.case_id,
    status: row.status,
    stage: row.stage,
    startedAt: row.started_at,
    pausedAt: row.paused_at,
    endedAt: row.ended_at,
    updatedAt: row.updated_at,
  }
}

export function getSessionState(caseId) {
  const c = ensureCase(caseId)
  return mapSession(activeSessionRow(caseId) || latestSessionRow(caseId), c)
}

export function startSession(caseId) {
  ensureCase(caseId)
  const active = activeSessionRow(caseId)
  if (active) return mapSession(active, getCase(caseId))

  const ts = now()
  const sessionId = id()
  transaction(() => {
    db.prepare(`
      INSERT INTO interrogation_sessions(id, case_id, status, stage, started_at, updated_at)
      VALUES (?, ?, 'RUNNING', 'IDENTITY', ?, ?)
    `).run(sessionId, caseId, ts, ts)
    db.prepare(`UPDATE cases SET state='INTERROGATING', stage='IDENTITY', updated_at=? WHERE id=?`).run(ts, caseId)
    audit(caseId, 'SESSION_START', 'SESSION', sessionId)
  })
  return getSessionState(caseId)
}

export function pauseSession(caseId) {
  const row = activeSessionRow(caseId)
  if (!row || row.status !== 'RUNNING') throw businessError('SESSION_NOT_RUNNING', '当前没有正在进行的审讯', 409)
  const ts = now()
  db.prepare(`UPDATE interrogation_sessions SET status='PAUSED', paused_at=?, updated_at=? WHERE id=?`).run(ts, ts, row.id)
  audit(caseId, 'SESSION_PAUSE', 'SESSION', row.id)
  return getSessionState(caseId)
}

export function resumeSession(caseId) {
  const row = activeSessionRow(caseId)
  if (!row || row.status !== 'PAUSED') throw businessError('SESSION_NOT_PAUSED', '当前审讯不是暂停状态', 409)
  const ts = now()
  db.prepare(`UPDATE interrogation_sessions SET status='RUNNING', paused_at=NULL, updated_at=? WHERE id=?`).run(ts, row.id)
  audit(caseId, 'SESSION_RESUME', 'SESSION', row.id)
  return getSessionState(caseId)
}

export function finishSession(caseId) {
  const row = activeSessionRow(caseId)
  if (!row) throw businessError('SESSION_NOT_ACTIVE', '当前没有可结束的审讯', 409)
  const ts = now()
  transaction(() => {
    db.prepare(`UPDATE interrogation_sessions SET status='COMPLETED', ended_at=?, updated_at=? WHERE id=?`).run(ts, ts, row.id)
    db.prepare(`UPDATE cases SET state='REVIEWING', updated_at=? WHERE id=?`).run(ts, caseId)
    audit(caseId, 'SESSION_FINISH', 'SESSION', row.id)
  })
  return getSessionState(caseId)
}

export function changeStage(caseId, stage) {
  if (!STAGES.includes(stage)) throw businessError('INVALID_STAGE', '无效审讯阶段', 400)
  const row = activeSessionRow(caseId)
  if (!row) throw businessError('SESSION_NOT_ACTIVE', '请先开始审讯再切换阶段', 409)
  const ts = now()
  transaction(() => {
    db.prepare(`UPDATE interrogation_sessions SET stage=?, updated_at=? WHERE id=?`).run(stage, ts, row.id)
    db.prepare(`UPDATE cases SET stage=?, updated_at=? WHERE id=?`).run(stage, ts, caseId)
    audit(caseId, 'SESSION_CHANGE_STAGE', 'SESSION', row.id, { stage })
  })
  return getSessionState(caseId)
}

function mapMessage(row) {
  return {
    id: row.id,
    seq: row.seq,
    speaker: row.speaker,
    text: row.text,
    mark: row.mark || '',
    confirmed: Boolean(row.confirmed),
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  }
}

export function listMessages(caseId, limit = 1000) {
  ensureCase(caseId)
  return db.prepare(`
    SELECT * FROM qa_records WHERE case_id=? AND deleted_at IS NULL ORDER BY seq ASC LIMIT ?
  `).all(caseId, Number(limit)).map(mapMessage)
}

export function addMessage(caseId, { text, from }) {
  ensureCase(caseId)
  const clean = String(text || '').trim()
  const speaker = String(from || '').trim()
  if (!clean) throw businessError('EMPTY_MESSAGE', '问答内容不能为空', 400)
  if (!['民警', '嫌疑人'].includes(speaker)) throw businessError('INVALID_SPEAKER', '仅允许民警或嫌疑人写入正式问答', 400)

  const session = activeSessionRow(caseId)
  if (!session) throw businessError('SESSION_NOT_ACTIVE', '请先开始审讯再记录问答', 409)
  if (session.status === 'PAUSED') throw businessError('SESSION_PAUSED', '审讯已暂停，恢复后才能继续记录', 409)

  const seq = Number(db.prepare(`SELECT COALESCE(MAX(seq), 0) + 1 AS next_seq FROM qa_records WHERE case_id=? AND deleted_at IS NULL`).get(caseId).next_seq)
  const ts = now()
  const messageId = id()
  db.prepare(`
    INSERT INTO qa_records(id, case_id, session_id, seq, speaker, text, confirmed, created_at, updated_at)
    VALUES (?, ?, ?, ?, ?, ?, 1, ?, ?)
  `).run(messageId, caseId, session.id, seq, speaker, clean, ts, ts)
  audit(caseId, 'QA_CREATE', 'QA', messageId, { seq, speaker })
  return mapMessage(db.prepare('SELECT * FROM qa_records WHERE id=?').get(messageId))
}

export function updateMessage(caseId, messageId, { text, reason = '警官修订' }) {
  const row = db.prepare(`SELECT * FROM qa_records WHERE id=? AND case_id=? AND deleted_at IS NULL`).get(messageId, caseId)
  if (!row) throw businessError('QA_NOT_FOUND', '问答记录不存在', 404)
  const clean = String(text || '').trim()
  if (!clean) throw businessError('EMPTY_MESSAGE', '修订内容不能为空', 400)
  if (clean === row.text) return mapMessage(row)

  const version = Number(db.prepare(`SELECT COALESCE(MAX(version), 0) + 1 AS next_version FROM qa_revisions WHERE qa_id=?`).get(messageId).next_version)
  const ts = now()
  transaction(() => {
    db.prepare(`
      INSERT INTO qa_revisions(id, qa_id, case_id, version, old_text, new_text, reason, created_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `).run(id(), messageId, caseId, version, row.text, clean, reason, ts)
    db.prepare(`UPDATE qa_records SET text=?, updated_at=? WHERE id=?`).run(clean, ts, messageId)
    audit(caseId, 'QA_UPDATE', 'QA', messageId, { version, reason })
  })
  return mapMessage(db.prepare('SELECT * FROM qa_records WHERE id=?').get(messageId))
}

export function markMessage(caseId, messageId, mark = 'conflict') {
  const allowed = ['', 'conflict', 'confirmed', 'pending']
  if (!allowed.includes(mark)) throw businessError('INVALID_MARK', '无效标记类型', 400)
  const result = db.prepare(`UPDATE qa_records SET mark=?, updated_at=? WHERE id=? AND case_id=? AND deleted_at IS NULL`).run(mark, now(), messageId, caseId)
  if (!result.changes) throw businessError('QA_NOT_FOUND', '问答记录不存在', 404)
  audit(caseId, 'QA_MARK', 'QA', messageId, { mark })
  return mapMessage(db.prepare('SELECT * FROM qa_records WHERE id=?').get(messageId))
}

export function listRevisions(caseId, messageId = null) {
  ensureCase(caseId)
  const rows = messageId
    ? db.prepare(`SELECT * FROM qa_revisions WHERE case_id=? AND qa_id=? ORDER BY version DESC`).all(caseId, messageId)
    : db.prepare(`SELECT * FROM qa_revisions WHERE case_id=? ORDER BY created_at DESC LIMIT 200`).all(caseId)
  return rows.map((row) => ({
    id: row.id,
    qaId: row.qa_id,
    version: row.version,
    oldText: row.old_text,
    newText: row.new_text,
    reason: row.reason || '',
    createdAt: row.created_at,
  }))
}

export function listFacts(caseId) {
  ensureCase(caseId)
  return db.prepare(`SELECT * FROM facts WHERE case_id=? ORDER BY rowid`).all(caseId).map((row) => ({
    key: row.fact_key,
    label: row.label,
    value: row.value,
    status: row.status,
    suggestion: row.suggestion || undefined,
  }))
}

export function updateFact(caseId, factKey, patch = {}) {
  ensureCase(caseId)
  const row = db.prepare(`SELECT * FROM facts WHERE case_id=? AND fact_key=?`).get(caseId, factKey)
  if (!row) throw businessError('FACT_NOT_FOUND', '事实项不存在', 404)
  const status = patch.status ?? row.status
  if (!['confirmed', 'pending', 'conflict', 'missing'].includes(status)) throw businessError('INVALID_FACT_STATUS', '无效事实状态', 400)
  db.prepare(`
    UPDATE facts SET value=?, status=?, suggestion=?, updated_at=? WHERE case_id=? AND fact_key=?
  `).run(patch.value ?? row.value, status, patch.suggestion ?? row.suggestion, now(), caseId, factKey)
  audit(caseId, 'FACT_UPDATE', 'FACT', factKey, patch)
  return listFacts(caseId).find((item) => item.key === factKey)
}

export function listTimeline(caseId) {
  ensureCase(caseId)
  return db.prepare(`SELECT * FROM timeline_events WHERE case_id=? ORDER BY created_at`).all(caseId).map((row) => ({
    id: row.id,
    time: row.time_label,
    title: row.title,
    detail: row.detail,
    evidence: JSON.parse(row.evidence_json || '[]'),
  }))
}

export function addTimelineEvent(caseId, input = {}) {
  ensureCase(caseId)
  const eventId = id()
  const ts = now()
  db.prepare(`
    INSERT INTO timeline_events(id, case_id, time_label, title, detail, evidence_json, created_at)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `).run(eventId, caseId, String(input.time || ''), String(input.title || '时间线事件'), String(input.detail || ''), JSON.stringify(input.evidence || []), ts)
  audit(caseId, 'TIMELINE_CREATE', 'TIMELINE', eventId, input)
  return listTimeline(caseId).find((item) => item.id === eventId)
}

export function saveAiSuggestion(caseId, inputText, outputText, kind = 'inquiry') {
  if (!outputText?.trim()) return
  ensureCase(caseId)
  const suggestionId = id()
  db.prepare(`
    INSERT INTO ai_suggestions(id, case_id, kind, input_text, output_text, created_at)
    VALUES (?, ?, ?, ?, ?, ?)
  `).run(suggestionId, caseId, kind, inputText || null, outputText, now())
  audit(caseId, 'AI_SUGGESTION_SAVE', 'AI_SUGGESTION', suggestionId, { kind })
}

export function listAudit(caseId, limit = 200) {
  ensureCase(caseId)
  return db.prepare(`SELECT * FROM audit_logs WHERE case_id=? ORDER BY created_at DESC LIMIT ?`).all(caseId, Number(limit)).map((row) => ({
    id: row.id,
    action: row.action,
    targetType: row.target_type,
    targetId: row.target_id,
    detail: JSON.parse(row.detail_json || '{}'),
    createdAt: row.created_at,
  }))
}

export function deviceStatus() {
  const simulated = process.env.DEVICE_SIMULATOR === '1'
  const status = simulated ? 'simulated' : 'not_connected'
  return {
    backend: 'ready',
    simulator: simulated,
    devices: {
      identity: { available: simulated, status },
      fingerprint: { available: simulated, status },
      signature: { available: simulated, status },
      face: { available: false, status: 'not_connected' },
      scanner: { available: false, status: 'not_connected' },
    },
  }
}

export function invokeDevice(type) {
  const status = deviceStatus()
  const device = status.devices[type]
  if (!device) throw businessError('UNKNOWN_DEVICE', '未知设备类型', 400)
  if (!device.available) {
    throw businessError('DEVICE_NOT_CONNECTED', `${deviceName(type)}未接入；后端链路正常，等待 Android 厂商 SDK`, 409)
  }
  const base = { success: true, simulated: true, message: `${deviceName(type)}模拟联调完成（非真实硬件数据）` }
  if (type === 'identity') return { ...base, name: '联调测试对象', gender: '', idNumber: '' }
  return base
}

function deviceName(type) {
  return ({ identity: '身份证阅读器', fingerprint: '指纹仪', signature: '签名设备', face: '人脸摄像头', scanner: '高拍仪' })[type] || type
}

export function businessError(code, message, status = 400) {
  const error = new Error(message)
  error.code = code
  error.status = status
  return error
}
