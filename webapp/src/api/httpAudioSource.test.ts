import { describe, expect, it, vi } from 'vitest'

vi.mock('../config/audioInput', () => ({ audioInputMode: 'BROWSER' }))

import { AUDIO_INPUT_REQUEST_HEADER, currentAudioInputRequestHeaders } from './http'


describe('shared HTTP audio source header', () => {
  it('propagates the resolved page audio source to every backend start route', () => {
    expect(AUDIO_INPUT_REQUEST_HEADER).toBe('X-Suspect-Audio-Input')
    expect(currentAudioInputRequestHeaders()).toEqual({
      'X-Suspect-Audio-Input': 'BROWSER',
    })
  })
})
