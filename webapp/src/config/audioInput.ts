export type AudioInputMode = 'ALSA' | 'BROWSER'
export type ClientPlatform = 'WINDOWS' | 'LINUX' | 'MACOS' | 'ANDROID' | 'IOS' | 'UNKNOWN'
export type AudioInputDetectionSource = 'URL_OVERRIDE' | 'HTTP_REQUEST_HEADERS' | 'BROWSER_FALLBACK' | 'BUILD_FALLBACK'

export interface AudioInputDetectionContext {
  query?: string
  platform?: string | null
  userAgent?: string | null
  hostname?: string | null
  envMode?: string | null
}

export interface ServerClientContext {
  clientPlatform?: string
  clientAddress?: string
  localClient?: boolean
  accessTopology?: string
  recommendedAudioInputMode?: string
  platformSource?: string
}

type FetchResponse = {
  ok: boolean
  json: () => Promise<unknown>
}

type FetchLike = (input: string, init?: RequestInit) => Promise<FetchResponse>

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
 * Synchronous fallback used before the authoritative server context is loaded.
 * URL override remains highest priority. Remote browsers own their microphone;
 * only a loopback Linux kiosk uses the RK3588 ALSA input.
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

function browserQuery(): string {
  return typeof window === 'undefined' ? '' : window.location.search
}

function browserHostname(): string {
  return typeof window === 'undefined' ? '' : window.location.hostname
}

const initialExplicitMode = queryAudioInputMode(browserQuery())

export let detectedClientPlatform: ClientPlatform = detectClientPlatform(
  browserPlatform(),
  browserUserAgent(),
)

export let audioInputMode: AudioInputMode = resolveAudioInputMode({
  query: browserQuery(),
  hostname: browserHostname(),
  platform: browserPlatform(),
  userAgent: browserUserAgent(),
  envMode: import.meta.env.VITE_AUDIO_INPUT_MODE,
})

export let audioInputDetectionSource: AudioInputDetectionSource = initialExplicitMode
  ? 'URL_OVERRIDE'
  : (browserHostname() ? 'BROWSER_FALLBACK' : 'BUILD_FALLBACK')

export let browserAudioTestMode = audioInputMode === 'BROWSER'
export let serverClientAddress = ''
export let serverAccessTopology = ''
export let serverPlatformSource = ''

/**
 * Ask the Linux backend what it actually saw on the HTTP connection. This is
 * authoritative for normal browser sessions because it combines request
 * headers (Sec-CH-UA-Platform/User-Agent) with request.client.host.
 */
export async function initializeAudioInputMode(fetcher?: FetchLike): Promise<AudioInputMode> {
  const explicit = queryAudioInputMode(browserQuery())
  if (explicit) {
    audioInputMode = explicit
    audioInputDetectionSource = 'URL_OVERRIDE'
    browserAudioTestMode = audioInputMode === 'BROWSER'
    return audioInputMode
  }

  if (typeof window === 'undefined') return audioInputMode

  const request = fetcher ?? (fetch as unknown as FetchLike)
  try {
    const response = await request('/api/v1/client-context', {
      method: 'GET',
      headers: { Accept: 'application/json' },
      cache: 'no-store',
    })
    if (!response.ok) return audioInputMode
    const body = await response.json() as { data?: ServerClientContext } & ServerClientContext
    const context = (body.data ?? body) as ServerClientContext
    const recommended = normalizeAudioInputMode(context.recommendedAudioInputMode)
    if (!recommended) return audioInputMode

    audioInputMode = recommended
    detectedClientPlatform = detectClientPlatform(context.clientPlatform, '')
    serverClientAddress = String(context.clientAddress ?? '')
    serverAccessTopology = String(context.accessTopology ?? '')
    serverPlatformSource = String(context.platformSource ?? '')
    audioInputDetectionSource = 'HTTP_REQUEST_HEADERS'
    browserAudioTestMode = audioInputMode === 'BROWSER'
  } catch {
    // Keep the synchronous browser fallback. Audio must never silently switch
    // to another physical microphone merely because this diagnostic call fails.
  }
  return audioInputMode
}
