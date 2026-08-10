export interface NativeRpcResponse<T> {
  id: string
  ok: boolean
  code: string
  message: string
  data: T
}

interface NativeBridgeObject {
  call(requestJson: string): void
}

declare global {
  interface Window {
    NativeBridge?: NativeBridgeObject
    __nativeBridgeResolve?: (responseJson: string) => void
  }
}

interface PendingRequest {
  resolve: (value: unknown) => void
  reject: (reason?: unknown) => void
  timer: ReturnType<typeof setTimeout>
}

const pending = new Map<string, PendingRequest>()

function requestId() {
  if (typeof crypto !== 'undefined' && 'randomUUID' in crypto) return crypto.randomUUID()
  return `rpc-${Date.now()}-${Math.random().toString(36).slice(2)}`
}

function installResolver() {
  if (typeof window === 'undefined' || window.__nativeBridgeResolve) return
  window.__nativeBridgeResolve = (responseJson: string) => {
    let response: NativeRpcResponse<unknown>
    try { response = JSON.parse(responseJson) as NativeRpcResponse<unknown> }
    catch (error) { console.error('NativeBridge 返回了无法解析的数据', error, responseJson); return }
    const item = pending.get(response.id)
    if (!item) return
    pending.delete(response.id); clearTimeout(item.timer)
    if (response.ok) item.resolve(response.data)
    else item.reject(new NativeRpcError(response.code, response.message || response.code))
  }
}

export class NativeRpcError extends Error {
  constructor(public readonly code: string, message: string) { super(message); this.name = 'NativeRpcError' }
}

export function isNativeBusinessRuntime() {
  return typeof window !== 'undefined' && typeof window.NativeBridge?.call === 'function'
}

export function callNative<T>(action: string, payload: Record<string, unknown> = {}): Promise<T> {
  installResolver()
  if (!isNativeBusinessRuntime()) return Promise.reject(new NativeRpcError('NATIVE_BRIDGE_UNAVAILABLE', '当前不是 Android APK NativeBridge 运行环境'))
  const id = requestId()
  return new Promise<T>((resolve, reject) => {
    const timer = setTimeout(() => { pending.delete(id); reject(new NativeRpcError('NATIVE_BRIDGE_TIMEOUT', `Android 后端调用超时: ${action}`)) }, 20_000)
    pending.set(id, { resolve: resolve as (value: unknown) => void, reject, timer })
    try { window.NativeBridge!.call(JSON.stringify({ id, action, payload })) }
    catch (error) { clearTimeout(timer); pending.delete(id); reject(error) }
  })
}
