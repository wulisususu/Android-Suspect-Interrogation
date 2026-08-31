export type AudioInputMode = 'ALSA' | 'BROWSER'
export type ClientPlatform = 'WINDOWS' | 'LINUX' | 'MACOS' | 'ANDROID' | 'IOS' | 'UNKNOWN'

export interface AudioInputDetectionContext {
  query?: string
  platform?: string | null
  userAgent?: string | null
  hostname?: string | null
  envMode?: string | null
}

function normalizeAudioInputMode(value: unknown): AudioInputMode | null {
  const normalized = String(value ?? '').trim().toUpperCase()
  if (normalized === 'ALSA' || normalized === 'BROWSER') return normalized
  return null
}

function queryAudioInputMode(query: string): AudioInputMode | null {
  const value = new URLSearchParams(query).get('audioInput')
  return normalizeAudioInputMode(value)
}

export function detectClientPlatform(platform: unknown, userAgent: unknown): ClientPlatform {
  const platformText = String(platform ?? '').trim().toLowerCase()
  const ua = String(userAgent ?? '').trim().toLowerCase()
  const combined = `${platformText} ${ua}`

  if (combined.includes('windows') || combined.includes('win32') || combined.includes('win64')) return 'WINDOWS'
  if (combined.includes('android')) return 'ANDROID'
  if (combined.includes('iphone') || combined.includes('ipad') || combined.includes('ios')) return 'IOS'
  if (combined.includes('macintosh') || combined.includes('mac os') || platformText.includes('mac')) return 'MACOS'
  if (combined.includes('linux')) return 'LINUX'
  return 'UNKNOWN'
}

function isLocalHostname(hostname: unknown): boolean {
  const normalized = String(hostname ?? '').trim().toLowerCase().replace(/^\[|\]$/g, '')
  return normalized === 'localhost'
    || normalized === '::1'
    || normalized === '0:0:0:0:0:0:0:1'
    || normalized.startsWith('127.')
}

/**
 * Resolve the microphone owner for this browser session.
 *
 * Priority:
 * 1. Explicit ?audioInput=alsa|browser override.
 * 2. Browser platform + access topology.
 *    - Windows/macOS/mobile clients use their browser microphone.
 *    - Linux local kiosk (localhost/loopback) uses board ALSA.
 *    - A remote Linux browser also uses its browser microphone.
 * 3. Build-time VITE_AUDIO_INPUT_MODE for non-browser/unknown contexts.
 * 4. Production-safe ALSA fallback when no browser context exists.
 */
export function resolveAudioInputMode(context: AudioInputDetectionContext): AudioInputMode {
  const explicit = queryAudioInputMode(String(context.query ?? ''))
  if (explicit) return explicit

  const hostname = String(context.hostname ?? '').trim()
  const platform = detectClientPlatform(context.platform, context.userAgent)

  if (hostname) {
    const local = isLocalHostname(hostname)
    if (platform === 'LINUX' && local) return 'ALSA'
    if (platform !== 'UNKNOWN') return 'BROWSER'
    return local ? 'ALSA' : 'BROWSER'
  }

  return normalizeAudioInputMode(context.envMode) ?? 'ALSA'
}

function browserPlatform(): string {
  if (typeof navigator === 'undefined') return ''
  const nav = navigator as Navigator & { userAgentData?: { platform?: string } }
  return String(nav.userAgentData?.platform || nav.platform || '')
}

function browserUserAgent(): string {
  return typeof navigator === 'undefined' ? '' : String(navigator.userAgent || '')
}

export const detectedClientPlatform: ClientPlatform = detectClientPlatform(
  browserPlatform(),
  browserUserAgent(),
)

export const audioInputMode: AudioInputMode = resolveAudioInputMode({
  query: typeof window === 'undefined' ? '' : window.location.search,
  hostname: typeof window === 'undefined' ? '' : window.location.hostname,
  platform: browserPlatform(),
  userAgent: browserUserAgent(),
  envMode: import.meta.env.VITE_AUDIO_INPUT_MODE,
})

export const browserAudioTestMode = audioInputMode === 'BROWSER'
