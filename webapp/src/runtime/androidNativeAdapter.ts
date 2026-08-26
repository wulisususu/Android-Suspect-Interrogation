import { callNative, onNativeEvent } from '../native/rpcBridge'
import { capabilitySet, type RuntimeAdapter, type RuntimeCapabilities, type RuntimeEventListener, type RuntimeInvokeOptions, type RuntimeOperation, type RuntimeSessionConnection } from './types'

const EVENT_NAMES = [
  'IDENTITY_REQUIRED', 'IDENTITY_SUCCESS', 'IDENTITY_ERROR',
  'DEVICE_STATE', 'DEVICE_CONNECTED', 'DEVICE_DISCONNECTED',
  'RECORDING_START', 'RECORDING_STOP', 'RECORDING_STATE',
  'ASR_PARTIAL', 'ASR_FINAL', 'AI_RESPONSE', 'SESSION_STATE',
  'SIGNATURE_REQUIRED', 'SIGNATURE_COMPLETE', 'SIGNATURE_ERROR',
  'REPORT_GENERATED', 'REPORT_ERROR', 'asr.capture.status',
]

const OPERATION_MAP: Record<string, string> = {
  'message.list': 'record.list',
  'message.add': 'record.add',
  'message.update': 'record.update',
  'message.mark': 'record.mark',
  'message.revisions': 'record.revisions',
  'model.import': 'model.import.request',
}

export class AndroidNativeAdapter implements RuntimeAdapter {
  readonly kind = 'android-native' as const

  invoke<T>(operation: RuntimeOperation, payload: Record<string, unknown> = {}, options: RuntimeInvokeOptions = {}): Promise<T> {
    return callNative<T>(OPERATION_MAP[operation] || operation, payload, options.timeoutMs ?? 30_000)
  }

  async getCapabilities(): Promise<RuntimeCapabilities> {
    try {
      return await callNative<RuntimeCapabilities>('runtime.capabilities', {}, 10_000)
    } catch {
      return capabilitySet('AVAILABLE', 'Android NativeBridge compatibility runtime')
    }
  }

  connectSession(_sessionId: string, listener: RuntimeEventListener): RuntimeSessionConnection {
    const disposers = EVENT_NAMES.map((name) => onNativeEvent<unknown>(name, (payload) => {
      listener({ event: name, payload, receivedAt: Date.now() })
    }))
    return {
      close() { disposers.forEach((dispose) => dispose()) },
      send() { return false },
    }
  }
}
