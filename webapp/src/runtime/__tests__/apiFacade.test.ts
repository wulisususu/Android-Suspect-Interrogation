import { afterEach, describe, expect, it } from 'vitest'
import {
  fetchOfficerVoiceprints,
  fetchVoiceprintReadiness,
  generateCaseAiAnalysis,
  generateLlm,
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
    await startSuspectVoiceprintEnrollment('case-1', 'actor-1')
    await stopSuspectVoiceprintEnrollment('case-1', 'actor-1')
    await fetchOfficerVoiceprints(false)
    await startOfficerVoiceprintEnrollment('POL-1', '李警官', 'actor-1')
    await stopOfficerVoiceprintEnrollment('POL-1', 'actor-1')
    await revokeOfficerVoiceprint('POL-1', 'actor-1')
    await updateVoiceprintAssignments('case-1', 'POL-1', 'POL-2', 'actor-1')

    expect(calls).toEqual([
      { operation: 'voiceprint.readiness', payload: { caseId: 'case-1' } },
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

  it('delegates freeze and signing through the selected runtime', async () => {
    const { adapter, calls } = fakeAdapter()
    resetRuntimeAdapterForTests(adapter)

    await freezeDocument('case-1')
    await signDocument('case-1', 'SUSPECT', '张三', 'data:image/png;base64,abc', '[]')

    expect(calls.map((item) => item.operation)).toEqual(['document.freeze', 'document.sign'])
  })
})
