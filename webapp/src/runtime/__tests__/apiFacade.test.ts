import { afterEach, describe, expect, it } from 'vitest'
import {
  fetchOfficerVoiceprints,
  fetchVoiceprintEnrollmentStatus,
  fetchVoiceprintReadiness,
  generateCaseAiAnalysis,
  generateLlm,
  normalizeTemporaryAsrFragment,
  recognizeOcrImage,
  revokeOfficerVoiceprint,
  startAsrCapture,
  startOfficerVoiceprintEnrollment,
  startSuspectVoiceprintEnrollment,
  stopOfficerVoiceprintEnrollment,
  stopSuspectVoiceprintEnrollment,
  updateVoiceprintAssignments,
} from '../../api/interrogation'
import { freezeDocument, signDocument } from '../../api/documentSigning'
import { resetRuntimeAdapterForTests } from '../index'
import type { RuntimeAdapter, RuntimeCapabilities, RuntimeEventListener, RuntimeOperation } from '../types'

function fakeAdapter() {
  const calls: Array<{ operation: string; payload?: Record<string, unknown> }> = []
  const adapter: RuntimeAdapter = {
    kind: 'linux-http-ws',
    async invoke<T>(operation: RuntimeOperation, payload?: Record<string, unknown>): Promise<T> {
      calls.push({ operation, payload })
      if (operation === 'case.ai.generate') return { id: 'analysis-1', caseId: 'case-1', text: 'ok', provider: 'LOCAL', model: 'local', createdAt: 1 } as T
      if (operation === 'llm.generate') return { outputText: 'ok', finished: true, fragments: ['ok'], tokenIds: [], modelName: 'local', provider: 'linux', maxNewTokens: 32, maxContextLen: 256, initializationMs: 1, totalInferenceMs: 2 } as T
      if (operation === 'asr.capture.start') return { caseId: 'case-1', running: true, sampleRate: 16000, partialText: '', fragments: [] } as T
      if (operation === 'ocr.recognize') return { text: '张三', blocks: [], imageWidth: 1, imageHeight: 1, modelName: 'ocr', provider: 'linux', recognitionMs: 1 } as T
      if (operation === 'document.freeze') return { caseId: 'case-1', version: 1, documentId: 'doc-1', documentHash: 'hash', status: 'FROZEN', createdAt: 1, integrityValid: true, signatures: [] } as T
      if (operation === 'document.sign') return { caseId: 'case-1', version: 1, documentId: 'doc-1', documentHash: 'hash', status: 'LOCKED', createdAt: 1, integrityValid: true, signatures: [] } as T
      if (operation === 'voiceprint.readiness') return { suspectReady: true, interrogatorReady: false, recorderReady: false, recognitionMode: 'SUSPECT_ONLY', canStart: true } as T
      if (operation === 'officerVoiceprint.list') return [] as T
      if (operation.includes('enrollment')) return { simulated: false, state: 'OK' } as T
      if (operation === 'officerVoiceprint.revoke') return { officerId: 'POL-1', active: false } as T
      if (operation === 'voiceprint.assignments.update') return { suspectReady: true, interrogatorReady: true, recorderReady: false, recognitionMode: 'SUSPECT_PLUS_INTERROGATOR', canStart: true } as T
      throw new Error(`unexpected ${operation}`)
    },
    async getCapabilities(): Promise<RuntimeCapabilities> { throw new Error('not needed') },
    connectSession(_sessionId: string, _listener: RuntimeEventListener) { return { close() {}, send() { return true } } },
  }
  return { adapter, calls }
}

afterEach(() => resetRuntimeAdapterForTests())

describe('application API runtime delegation', () => {
  it('delegates AI, LLM, continuous ASR and OCR through the selected runtime', async () => {
    const { adapter, calls } = fakeAdapter()
    resetRuntimeAdapterForTests(adapter)

    await generateCaseAiAnalysis('case-1')
    await generateLlm({ generationId: 'g1', prompt: 'hello', maxNewTokens: 32, maxContextLen: 256 })
    await startAsrCapture('case-1')
    await recognizeOcrImage()

    expect(calls.map((item) => item.operation)).toEqual([
      'case.ai.generate',
      'llm.generate',
      'asr.capture.start',
      'ocr.recognize',
    ])
  })

  it('delegates voiceprint readiness, enrollment, library and assignments through the selected runtime', async () => {
    const { adapter, calls } = fakeAdapter()
    resetRuntimeAdapterForTests(adapter)

    await fetchVoiceprintReadiness('case-1')
    await fetchVoiceprintEnrollmentStatus()
    await startSuspectVoiceprintEnrollment('case-1', 'actor-1')
    await stopSuspectVoiceprintEnrollment('case-1', 'actor-1')
    await fetchOfficerVoiceprints(false)
    await startOfficerVoiceprintEnrollment('POL-1', '李警官', 'actor-1')
    await stopOfficerVoiceprintEnrollment('POL-1', 'actor-1')
    await revokeOfficerVoiceprint('POL-1', 'actor-1')
    await updateVoiceprintAssignments('case-1', 'POL-1', 'POL-2', 'actor-1')

    expect(calls).toEqual([
      { operation: 'voiceprint.readiness', payload: { caseId: 'case-1' } },
      { operation: 'voiceprint.enrollment.status', payload: {} },
      { operation: 'voiceprint.suspect.enrollment.start', payload: { caseId: 'case-1', actorId: 'actor-1' } },
      { operation: 'voiceprint.suspect.enrollment.stop', payload: { caseId: 'case-1', actorId: 'actor-1' } },
      { operation: 'officerVoiceprint.list', payload: { activeOnly: false } },
      { operation: 'officerVoiceprint.enrollment.start', payload: { officerId: 'POL-1', officerName: '李警官', actorId: 'actor-1' } },
      { operation: 'officerVoiceprint.enrollment.stop', payload: { officerId: 'POL-1', actorId: 'actor-1' } },
      { operation: 'officerVoiceprint.revoke', payload: { officerId: 'POL-1', actorId: 'actor-1' } },
      {
        operation: 'voiceprint.assignments.update',
        payload: { caseId: 'case-1', interrogatorOfficerId: 'POL-1', recorderOfficerId: 'POL-2', actorId: 'actor-1' },
      },
    ])
  })

  it('keeps the Task 17B-1 speaker-mode fields when normalizing readiness', async () => {
    const { adapter } = fakeAdapter()
    adapter.invoke = (async <T,>(operation: RuntimeOperation) => {
      if (operation !== 'voiceprint.readiness') throw new Error(`unexpected ${operation}`)
      return {
        suspectReady: true,
        interrogatorReady: true,
        recorderReady: false,
        recognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
        canStart: true,
        enrollmentQuality: 'GOOD',
        usableDurationMs: 24000,
        modelKey: 'eres2net_large',
        modelId: 'eres2net_large',
        modelVersion: 'rk3588-local',
        speakerMargin: null,
        speakerThreshold: 0.372,
        thresholdSource: 'DEVICE_CALIBRATED',
        marginConfigured: false,
        thresholdConfigured: true,
        declaredRecognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
        effectiveRecognitionMode: 'SUSPECT_ONLY',
        recognitionModeDegraded: true,
        recognitionModeDegradedReason: 'MARGIN_CALIBRATION_MISSING',
      } as T
    }) as typeof adapter.invoke
    resetRuntimeAdapterForTests(adapter)

    const readiness = await fetchVoiceprintReadiness('case-1')

    expect(readiness.recognitionMode).toBe('SUSPECT_PLUS_INTERROGATOR')
    expect(readiness.declaredRecognitionMode).toBe('SUSPECT_PLUS_INTERROGATOR')
    expect(readiness.effectiveRecognitionMode).toBe('SUSPECT_ONLY')
    expect(readiness.recognitionModeDegraded).toBe(true)
    expect(readiness.recognitionModeDegradedReason).toBe('MARGIN_CALIBRATION_MISSING')
    expect(readiness.enrollmentQuality).toBe('GOOD')
    expect(readiness.usableDurationMs).toBe(24000)
    expect(readiness.modelKey).toBe('eres2net_large')
    expect(readiness.modelVersion).toBe('rk3588-local')
    expect(readiness.speakerMargin).toBeNull()
    expect(readiness.speakerThreshold).toBe(0.372)
    expect(readiness.marginConfigured).toBe(false)
    expect(readiness.thresholdConfigured).toBe(true)
  })

  it('keeps the unverified marker and never turns it into a mode claim', async () => {
    const { adapter } = fakeAdapter()
    adapter.invoke = (async <T,>(operation: RuntimeOperation) => {
      if (operation !== 'voiceprint.readiness') throw new Error(`unexpected ${operation}`)
      return {
        suspectReady: true,
        interrogatorReady: true,
        recorderReady: false,
        recognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
        canStart: true,
        speakerMargin: 0.08,
        marginConfigured: true,
        declaredRecognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
        // The backend could not check the operating point against the runtime.
        effectiveRecognitionMode: null,
        recognitionModeDegraded: null,
        recognitionModeDegradedReason: null,
        recognitionModeVerified: false,
        recognitionModeVerificationSource: 'UNVERIFIED',
      } as T
    }) as typeof adapter.invoke
    resetRuntimeAdapterForTests(adapter)

    const readiness = await fetchVoiceprintReadiness('case-1')

    expect(readiness.recognitionModeVerified).toBe(false)
    expect(readiness.recognitionModeVerificationSource).toBe('UNVERIFIED')
    // "Unverified" must not be normalized into "effective = declaration" or
    // "degraded = false": neither claim was proven.
    expect(readiness.effectiveRecognitionMode).toBeUndefined()
    expect(readiness.recognitionModeDegraded).toBeUndefined()
    expect(readiness.declaredRecognitionMode).toBe('SUSPECT_PLUS_INTERROGATOR')
    expect(readiness.speakerMargin).toBe(0.08)
  })

  it('keeps the mode an ASR fragment was decided in', () => {
    const fragment = normalizeTemporaryAsrFragment({
      fragmentId: 'FRAG-1',
      caseId: 'case-1',
      captureSessionId: 'CAP-1',
      startedAtMs: 0,
      endedAtMs: 1200,
      rawText: '我是嫌疑人',
      speaker: 'SUSPECT',
      declaredRecognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
      effectiveRecognitionMode: 'SUSPECT_ONLY',
      recognitionModeDegraded: true,
      recognitionModeDegradedReason: 'MARGIN_CALIBRATION_MISSING',
    })

    expect(fragment.declaredRecognitionMode).toBe('SUSPECT_PLUS_INTERROGATOR')
    expect(fragment.effectiveRecognitionMode).toBe('SUSPECT_ONLY')
    expect(fragment.recognitionModeDegraded).toBe(true)
    expect(fragment.recognitionModeDegradedReason).toBe('MARGIN_CALIBRATION_MISSING')
  })

  it('delegates freeze and signing through the selected runtime', async () => {
    const { adapter, calls } = fakeAdapter()
    resetRuntimeAdapterForTests(adapter)

    await freezeDocument('case-1')
    await signDocument('case-1', 'SUSPECT', '张三', 'data:image/png;base64,abc', '[]')

    expect(calls.map((item) => item.operation)).toEqual(['document.freeze', 'document.sign'])
  })
})
