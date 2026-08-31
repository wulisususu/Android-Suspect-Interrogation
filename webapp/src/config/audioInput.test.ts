import { describe, expect, it } from 'vitest'
import * as audioInput from './audioInput'

function resolve(input: Record<string, unknown>) {
  const fn = (audioInput as unknown as { resolveAudioInputMode?: (value: Record<string, unknown>) => string }).resolveAudioInputMode
  expect(fn).toBeTypeOf('function')
  if (!fn) return 'MISSING'
  return fn(input)
}

describe('automatic audio input selection', () => {
  it('uses the Windows browser microphone automatically for LAN access', () => {
    expect(resolve({
      query: '?view=settings',
      platform: 'Windows',
      userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
      hostname: '192.168.0.9',
    })).toBe('BROWSER')
  })

  it('uses ALSA for the Linux all-in-one local kiosk', () => {
    expect(resolve({
      query: '',
      platform: 'Linux',
      userAgent: 'Mozilla/5.0 (X11; Linux aarch64)',
      hostname: '127.0.0.1',
    })).toBe('ALSA')
  })

  it('uses the browser microphone for a remote Linux browser on the LAN', () => {
    expect(resolve({
      query: '',
      platform: 'Linux',
      userAgent: 'Mozilla/5.0 (X11; Linux x86_64)',
      hostname: '192.168.0.9',
    })).toBe('BROWSER')
  })

  it('keeps explicit URL selection as the highest-priority override', () => {
    expect(resolve({
      query: '?audioInput=alsa',
      platform: 'Windows',
      userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
      hostname: '192.168.0.9',
    })).toBe('ALSA')
  })
})
