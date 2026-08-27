import type { AxiosRequestConfig } from 'axios'
import { http } from '../api/http'
import { runtimeConfig } from '../config/runtime'
import { normalizeRuntimeError, RuntimeAdapterError } from './errors'
import {
  capability,
  capabilitySet,
  type RuntimeAdapter,
  type RuntimeCapabilities,
  type RuntimeCapabilityName,
  type RuntimeCapabilityState,
  type RuntimeEventListener,
  type RuntimeInvokeOptions,
  type RuntimeOperation,
  type RuntimeSessionConnection,
} from './types'
import { RuntimeWebSocketClient, type RuntimeWebSocketConstructor } from './wsClient'

export interface RuntimeHttpRequestConfig {
  method: 'GET' | 'POST' | 'PUT' | 'DELETE'
  url: string
  data?: unknown
  params?: Record<string, unknown>
  timeout?: number
}

export type RuntimeHttpRequest = <T = unknown>(config: RuntimeHttpRequestConfig) => Promise<{ data: T }>

interface LinuxAdapterOptions {
  request?: RuntimeHttpRequest
  origin?: string
  WebSocketCtor?: RuntimeWebSocketConstructor
}

function encode(value: unknown) {
  return encodeURIComponent(String(value ?? ''))
}

function unwrap<T>(payload: unknown): T {
  if (payload && typeof payload === 'object' && 'ok' in payload && 'data' in payload) {
    const envelope = payload as { ok: boolean; data: T; code?: string; message?: string }
    if (!envelope.ok) throw new RuntimeAdapterError(envelope.code || 'BACKEND_ERROR', envelope.message || 'Linux 后端返回错误')
    return envelope.data
  }
  return payload as T
}

function endpoint(operation: RuntimeOperation, payload: Record<string, unknown>): RuntimeHttpRequestConfig {
  const caseId = encode(payload.caseId)
  const messageId = encode(payload.messageId)
  const fragmentId = encode(payload.fragmentId)

  switch (operation) {
    case 'case.create': return { method: 'POST', url: '/api/v1/cases', data: payload }
    case 'case.list': return { method: 'GET', url: '/api/v1/cases', params: { limit: payload.limit } }
    case 'case.get': return { method: 'GET', url: `/api/v1/cases/${caseId}` }
    case 'case.update': return { method: 'PUT', url: `/api/v1/cases/${caseId}`, data: payload.patch ?? payload }
    case 'case.ai.list': return { method: 'GET', url: `/api/v1/cases/${caseId}/ai-analyses` }
    case 'case.ai.generate': return { method: 'POST', url: `/api/v1/cases/${caseId}/ai-analyses`, data: {} }
    case 'message.list': return { method: 'GET', url: `/api/v1/cases/${caseId}/messages`, params: { limit: payload.limit ?? 1000 } }
    case 'message.add': return { method: 'POST', url: `/api/v1/cases/${caseId}/messages`, data: { text: payload.text, from: payload.from } }
    case 'message.update': return { method: 'PUT', url: `/api/v1/cases/${caseId}/messages/${messageId}`, data: { text: payload.text, reason: payload.reason } }
    case 'message.mark': return { method: 'POST', url: `/api/v1/cases/${caseId}/messages/${messageId}/mark`, data: { mark: payload.mark } }
    case 'message.revisions': {
      const suffix = payload.messageId ? `/messages/${messageId}/revisions` : '/revisions'
      return { method: 'GET', url: `/api/v1/cases/${caseId}${suffix}` }
    }
    case 'fact.list': return { method: 'GET', url: `/api/v1/cases/${caseId}/facts` }
    case 'fact.update': return { method: 'PUT', url: `/api/v1/cases/${caseId}/facts/${encode(payload.factKey)}`, data: payload.patch ?? payload }
    case 'timeline.list': return { method: 'GET', url: `/api/v1/cases/${caseId}/timeline` }
    case 'audit.list': return { method: 'GET', url: `/api/v1/cases/${caseId}/audit` }
    case 'session.get': return { method: 'GET', url: `/api/v1/cases/${caseId}/session` }
    case 'session.start': return { method: 'POST', url: '/api/v1/interrogation/start', data: { case_id: payload.caseId } }
    case 'session.pause': return { method: 'POST', url: `/api/v1/interrogation/${caseId}/pause`, data: {} }
    case 'session.resume': return { method: 'POST', url: `/api/v1/interrogation/${caseId}/resume`, data: {} }
    case 'session.finish': return { method: 'POST', url: `/api/v1/interrogation/${caseId}/finish`, data: {} }
    case 'session.stage': return { method: 'POST', url: `/api/v1/interrogation/${caseId}/stage`, data: { stage: payload.stage } }
    case 'identity.read': return {
      method: 'POST',
      url: '/api/v1/identity/read',
      data: { case_id: payload.caseId, actor_id: payload.actorId },
    }
    case 'device.action': return { method: 'POST', url: '/api/v1/device/action', data: { type: payload.type } }
    case 'model.list': return { method: 'GET', url: '/api/v1/models' }
    case 'model.scan': return { method: 'GET', url: '/api/v1/models', params: { rescan: true } }
    case 'model.select': return { method: 'POST', url: '/api/v1/models/select', data: { category: payload.category, model_id: payload.modelId } }
    case 'model.import': return { method: 'POST', url: '/api/v1/models/import', data: { category: payload.category, source: payload.source } }
    case 'llm.status': return { method: 'GET', url: '/api/v1/llm/status' }
    case 'llm.storage.permission.request': return { method: 'POST', url: '/api/v1/llm/storage/permission', data: {} }
    case 'llm.generate': return { method: 'POST', url: '/api/v1/llm/generate', data: payload }
    case 'llm.cancel': return { method: 'POST', url: '/api/v1/llm/cancel', data: {} }
    case 'llm.release': return { method: 'POST', url: '/api/v1/llm/release', data: {} }
    case 'asr.status': return { method: 'GET', url: '/api/v1/asr/status' }
    case 'asr.start': return { method: 'POST', url: '/api/v1/asr/start', data: {} }
    case 'asr.stop': return { method: 'POST', url: '/api/v1/asr/stop', data: {} }
    case 'asr.capture.status': return { method: 'GET', url: `/api/v1/cases/${caseId}/asr/capture` }
    case 'asr.capture.start': return { method: 'POST', url: `/api/v1/cases/${caseId}/asr/capture/start`, data: {} }
    case 'asr.capture.stop': return { method: 'POST', url: `/api/v1/cases/${caseId}/asr/capture/stop`, data: {} }
    case 'asr.fragment.list': return { method: 'GET', url: `/api/v1/cases/${caseId}/asr/fragments`, params: { include_confirmed: payload.includeConfirmed } }
    case 'asr.fragment.update': return { method: 'PUT', url: `/api/v1/cases/${caseId}/asr/fragments/${fragmentId}`, data: { edited_text: payload.editedText, speaker: payload.speaker } }
    case 'asr.fragment.confirm': return { method: 'POST', url: `/api/v1/cases/${caseId}/asr/fragments/${fragmentId}/confirm`, data: {} }
    case 'asr.fragment.confirmBatch': return { method: 'POST', url: `/api/v1/cases/${caseId}/asr/fragments/confirm`, data: { fragment_ids: payload.fragmentIds } }
    case 'asr.fragment.applyToRecord': return { method: 'POST', url: `/api/v1/cases/${caseId}/asr/fragments/apply`, data: payload }
    case 'asr.fragment.discard': return { method: 'POST', url: `/api/v1/cases/${caseId}/asr/fragments/${fragmentId}/discard`, data: {} }
    case 'ocr.status': return { method: 'GET', url: '/api/v1/ocr/status' }
    case 'ocr.image.pick': return { method: 'POST', url: '/api/v1/ocr/image/pick', data: {} }
    case 'ocr.camera.capture': return { method: 'POST', url: '/api/v1/ocr/camera/capture', data: {} }
    case 'ocr.recognize': return { method: 'POST', url: '/api/v1/ocr/recognize', data: {} }
    case 'ocr.release': return { method: 'POST', url: '/api/v1/ocr/release', data: {} }
    case 'ai.inquiry': return { method: 'POST', url: '/api/v1/ai/inquiry', data: { case_id: payload.caseId, message: payload.message } }
    case 'document.signing.get': return { method: 'GET', url: `/api/v1/cases/${caseId}/document` }
    case 'document.freeze': return { method: 'POST', url: `/api/v1/cases/${caseId}/document/freeze`, data: {} }
    case 'document.sign': return { method: 'POST', url: `/api/v1/cases/${caseId}/document/sign`, data: payload }
    case 'report.get': return { method: 'GET', url: `/api/v1/cases/${caseId}/report` }
    default: throw new RuntimeAdapterError('UNSUPPORTED_OPERATION', `Linux Runtime 不支持操作：${operation}`, 'NOT_CONFIGURED')
  }
}

export function buildRuntimeWebSocketUrl(origin: string, sessionId: string) {
  const url = new URL(origin)
  url.protocol = url.protocol === 'https:' ? 'wss:' : 'ws:'
  url.pathname = `/ws/interrogation/${encodeURIComponent(sessionId)}`
  url.search = ''
  url.hash = ''
  return url.toString().replace(/\/$/, '')
}

function normalizeCapabilityState(value: unknown): RuntimeCapabilityState {
  const normalized = String(value || '').toUpperCase()
  if (['AVAILABLE', 'NOT_CONNECTED', 'NOT_CONFIGURED', 'MODEL_NOT_INSTALLED', 'BUSY', 'ERROR'].includes(normalized)) {
    return normalized as RuntimeCapabilityState
  }
  if (['READY', 'CONNECTED', 'OK', 'IDLE'].includes(normalized)) return 'AVAILABLE'
  if (['MISSING', 'NOT_INSTALLED'].includes(normalized)) return 'MODEL_NOT_INSTALLED'
  return 'NOT_CONFIGURED'
}

function capabilityFallback(reason: string) {
  const result = capabilitySet('NOT_CONFIGURED', reason)
  result.asr = capability('asr', 'MODEL_NOT_INSTALLED', 'ASR 模型/运行时尚未安装')
  result.ocr = capability('ocr', 'MODEL_NOT_INSTALLED', 'OCR 模型/运行时尚未安装')
  result.llm = capability('llm', 'MODEL_NOT_INSTALLED', 'LLM 模型/运行时尚未安装')
  result.recording = capability('recording', 'MODEL_NOT_INSTALLED', '连续 ASR 模型/运行时尚未安装')
  return result
}

export class LinuxHttpWsAdapter implements RuntimeAdapter {
  readonly kind = 'linux-http-ws' as const
  private readonly request: RuntimeHttpRequest
  private readonly origin: string
  private readonly WebSocketCtor?: RuntimeWebSocketConstructor
  private capabilitiesCache?: RuntimeCapabilities

  constructor(options: LinuxAdapterOptions = {}) {
    this.request = options.request || (async <T>(config: RuntimeHttpRequestConfig) => {
      const response = await http.request<T>(config as AxiosRequestConfig)
      return { data: response.data }
    })
    this.origin = options.origin || (typeof window !== 'undefined' ? window.location.origin : runtimeConfig.apiBaseUrl)
    this.WebSocketCtor = options.WebSocketCtor
  }

  async invoke<T>(operation: RuntimeOperation, payload: Record<string, unknown> = {}, options: RuntimeInvokeOptions = {}): Promise<T> {
    try {
      const config = endpoint(operation, payload)
      if (options.timeoutMs) config.timeout = options.timeoutMs
      const response = await this.request<T>(config)
      return unwrap<T>(response.data)
    } catch (error) {
      throw normalizeRuntimeError(error, operation)
    }
  }

  async getCapabilities(force = false): Promise<RuntimeCapabilities> {
    if (this.capabilitiesCache && !force) return this.capabilitiesCache
    try {
      const response = await this.request<unknown>({ method: 'GET', url: '/api/v1/capabilities' })
      const raw = unwrap<unknown>(response.data)
      const source = raw && typeof raw === 'object' && !Array.isArray(raw) ? raw as Record<string, unknown> : {}
      const fallback = capabilityFallback('Linux 后端未声明该能力')
      const names = Object.keys(fallback) as RuntimeCapabilityName[]
      const result = { ...fallback }
      for (const name of names) {
        const value = source[name]
        if (value && typeof value === 'object' && !Array.isArray(value)) {
          const record = value as Record<string, unknown>
          result[name] = capability(
            name,
            normalizeCapabilityState(record.state ?? record.status),
            typeof record.reason === 'string' ? record.reason : typeof record.message === 'string' ? record.message : undefined,
            record,
          )
        } else if (value !== undefined) {
          result[name] = capability(name, normalizeCapabilityState(value))
        }
      }
      this.capabilitiesCache = result
      return result
    } catch (error) {
      const normalized = normalizeRuntimeError(error, 'capabilities.get')
      if (normalized.state === 'NOT_CONNECTED') {
        this.capabilitiesCache = capabilitySet('NOT_CONNECTED', normalized.message)
      } else {
        this.capabilitiesCache = capabilityFallback('Linux 后端尚未实现 capability endpoint')
      }
      return this.capabilitiesCache
    }
  }

  connectSession(sessionId: string, listener: RuntimeEventListener): RuntimeSessionConnection {
    const client = new RuntimeWebSocketClient({
      url: buildRuntimeWebSocketUrl(this.origin, sessionId),
      sessionId,
      onEvent: listener,
      ...(this.WebSocketCtor ? { WebSocketCtor: this.WebSocketCtor } : {}),
    })
    client.connect()
    return client
  }
}
