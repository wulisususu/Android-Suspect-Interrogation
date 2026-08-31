import { describe, expect, it } from 'vitest'
import {
  buildBrowserAsrCaptureWebSocketUrl,
  buildBrowserQuestionPreparationWebSocketUrl,
} from './browserAsrCapture'


describe('LAN browser ASR websocket URLs', () => {
  it('keeps formal interrogation audio on the same LAN origin', () => {
    expect(buildBrowserAsrCaptureWebSocketUrl(
      'CASE 1',
      'capture/1',
      'http://192.168.1.50:18080',
    )).toBe('ws://192.168.1.50:18080/ws/asr/cases/CASE%201/capture/capture%2F1')
  })

  it('uses WSS only when the current local origin itself is HTTPS', () => {
    expect(buildBrowserQuestionPreparationWebSocketUrl(
      'CASE 1',
      'prep/1',
      'https://interrogation.lan',
    )).toBe('wss://interrogation.lan/ws/asr/cases/CASE%201/question-preparation/prep%2F1')
  })
})
