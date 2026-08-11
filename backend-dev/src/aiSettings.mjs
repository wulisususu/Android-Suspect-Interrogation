import { db } from './db.mjs'

const MODES = new Set(['CLOUD', 'LOCAL', 'AUTO', 'OFFLINE_ONLY'])

db.exec(`
  CREATE TABLE IF NOT EXISTS ai_runtime_settings (
    id TEXT PRIMARY KEY,
    mode TEXT NOT NULL,
    cloud_base_url TEXT NOT NULL,
    cloud_model TEXT NOT NULL,
    stream INTEGER NOT NULL,
    thinking_enabled INTEGER NOT NULL,
    max_tokens INTEGER NOT NULL,
    temperature REAL NOT NULL,
    api_key TEXT NOT NULL
  );
`)

db.prepare(`
  INSERT OR IGNORE INTO ai_runtime_settings(
    id, mode, cloud_base_url, cloud_model, stream, thinking_enabled, max_tokens, temperature, api_key
  ) VALUES ('default', ?, ?, ?, ?, ?, ?, ?, ?)
`).run(
  'CLOUD',
  process.env.AI_BIGMODEL_BASE_URL || 'https://open.bigmodel.cn/api/paas/v4/chat/completions',
  process.env.AI_MODEL || 'glm-4.7',
  1,
  1,
  Number(process.env.AI_MAX_TOKENS || 65_536),
  Number(process.env.AI_TEMPERATURE || 1),
  process.env.AI_BIGMODEL_API_KEY || '',
)

function readRow() {
  return db.prepare("SELECT * FROM ai_runtime_settings WHERE id = 'default'").get()
}

function publicSettings(row) {
  return {
    mode: row.mode,
    cloudBaseUrl: row.cloud_base_url,
    cloudModel: row.cloud_model,
    stream: Boolean(row.stream),
    thinkingEnabled: Boolean(row.thinking_enabled),
    maxTokens: row.max_tokens,
    temperature: row.temperature,
    apiKeyConfigured: Boolean(row.api_key),
  }
}

function statusFromRow(row) {
  const settings = publicSettings(row)
  const cloudAvailable = settings.apiKeyConfigured
  const activeProvider = settings.mode === 'CLOUD' || settings.mode === 'AUTO'
    ? (cloudAvailable ? 'CLOUD_ZHIPU' : 'UNAVAILABLE')
    : 'UNAVAILABLE'
  return {
    settings,
    activeProvider,
    cloudConfigured: cloudAvailable,
    localAvailable: false,
    localModel: null,
  }
}

export function getAiSettingsStatus() {
  return statusFromRow(readRow())
}

export function getAiRuntimeConfig() {
  const row = readRow()
  return { ...statusFromRow(row), apiKey: row.api_key }
}

export function updateAiSettings(patch = {}) {
  const current = readRow()
  const mode = patch.mode === undefined ? current.mode : String(patch.mode).toUpperCase()
  if (!MODES.has(mode)) throw settingsError('INVALID_AI_MODE', '无效的 AI 推理模式')

  const cloudBaseUrl = cleanText(patch.cloudBaseUrl, current.cloud_base_url)
  try { new URL(cloudBaseUrl) } catch { throw settingsError('INVALID_AI_BASE_URL', 'API 地址不是有效 URL') }

  const cloudModel = cleanText(patch.cloudModel, current.cloud_model)
  const maxTokens = clampNumber(patch.maxTokens, current.max_tokens, 1, 65_536)
  const temperature = clampNumber(patch.temperature, current.temperature, 0, 2)
  const apiKey = patch.clearApiKey
    ? ''
    : patch.apiKey === undefined ? current.api_key : String(patch.apiKey).trim()

  db.prepare(`
    UPDATE ai_runtime_settings
    SET mode=?, cloud_base_url=?, cloud_model=?, stream=?, thinking_enabled=?, max_tokens=?, temperature=?, api_key=?
    WHERE id='default'
  `).run(
    mode,
    cloudBaseUrl,
    cloudModel,
    patch.stream === undefined ? current.stream : Number(Boolean(patch.stream)),
    patch.thinkingEnabled === undefined ? current.thinking_enabled : Number(Boolean(patch.thinkingEnabled)),
    maxTokens,
    temperature,
    apiKey,
  )
  return getAiSettingsStatus()
}

function cleanText(value, fallback) {
  if (value === undefined) return fallback
  return String(value).trim() || fallback
}

function clampNumber(value, fallback, min, max) {
  if (value === undefined) return fallback
  const parsed = Number(value)
  if (!Number.isFinite(parsed)) throw settingsError('INVALID_AI_NUMBER', 'AI 数值参数格式无效')
  return Math.min(max, Math.max(min, parsed))
}

function settingsError(code, message) {
  const error = new Error(message)
  error.code = code
  error.status = 400
  return error
}
