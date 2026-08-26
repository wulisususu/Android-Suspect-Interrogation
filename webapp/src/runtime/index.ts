import { BrowserDevAdapter } from './browserDevAdapter'
import { LinuxHttpWsAdapter } from './linuxHttpWsAdapter'
import type { RuntimeAdapter, RuntimeKind } from './types'

export * from './errors'
export * from './types'
export * from './wsClient'
export { BrowserDevAdapter } from './browserDevAdapter'
export { LinuxHttpWsAdapter, buildRuntimeWebSocketUrl } from './linuxHttpWsAdapter'

export interface RuntimeSelectionInput {
  requestedMode?: string
}

export function resolveRuntimeKind(input: RuntimeSelectionInput): RuntimeKind {
  if (input.requestedMode === 'browser-dev') return 'browser-dev'
  return 'linux-http-ws'
}

let adapter: RuntimeAdapter | undefined

export function getRuntimeAdapter(): RuntimeAdapter {
  if (adapter) return adapter
  const kind = resolveRuntimeKind({
    requestedMode: import.meta.env.VITE_RUNTIME_MODE,
  })
  adapter = kind === 'browser-dev'
    ? new BrowserDevAdapter()
    : new LinuxHttpWsAdapter()
  return adapter
}

export function resetRuntimeAdapterForTests(next?: RuntimeAdapter) {
  adapter = next
}
