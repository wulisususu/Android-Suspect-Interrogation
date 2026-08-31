export type AudioInputMode = 'ALSA' | 'BROWSER'

function normalizeAudioInputMode(value: unknown): AudioInputMode | null {
  const normalized = String(value ?? '').trim().toUpperCase()
  if (normalized === 'ALSA' || normalized === 'BROWSER') return normalized
  return null
}

function queryAudioInputMode(): AudioInputMode | null {
  if (typeof window === 'undefined') return null
  const value = new URLSearchParams(window.location.search).get('audioInput')
  return normalizeAudioInputMode(value)
}

// Production-safe default: the Linux all-in-one machine owns the microphone.
// LAN browser testing must be explicitly selected with ?audioInput=browser or
// VITE_AUDIO_INPUT_MODE=BROWSER.
export const audioInputMode: AudioInputMode = queryAudioInputMode()
  ?? normalizeAudioInputMode(import.meta.env.VITE_AUDIO_INPUT_MODE)
  ?? 'ALSA'

export const browserAudioTestMode = audioInputMode === 'BROWSER'
