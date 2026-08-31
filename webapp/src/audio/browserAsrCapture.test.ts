import { describe, expect, it } from 'vitest'
import {
  buildBrowserAsrCaptureWebSocketUrl,
  buildBrowserQuestionPreparationWebSocketUrl,
} from './browserAsrCapture'


describe('LAN browser ASR websocket URLs', () => {
  it('keeps legacy HTTP formal interrogation audio on the same LAN origin', () => {
    expect(buildBrowserAsrCaptureWebSocketUrl(
      'CASE 1',
      'capture/1',
      'http://192.168.1.50:18080',
    )).toBe('ws://192.168.1.50:18080/ws/asr/cases/CASE%201/capture/capture%2F1')
  })

  it('uses WSS for formal interrogation audio on the production HTTPS origin', () => {
    expect(buildBrowserAsrCaptureWebSocketUrl(
      'CASE 1',
      'capture/1',
      'https://192.168.0.9:18080',
    )).toBe('wss://192.168.0.9:18080/ws/asr/cases/CASE%201/capture/capture%2F1')
  })

  it('uses WSS for question preparation on an HTTPS origin', () => {
    expect(buildBrowserQuestionPreparationWebSocketUrl(
      'CASE 1',
      'prep/1',
      'https://192.168.0.9:18080',
    )).toBe('wss://192.168.0.9:18080/ws/asr/cases/CASE%201/question-preparation/prep%2F1')
  })
})
