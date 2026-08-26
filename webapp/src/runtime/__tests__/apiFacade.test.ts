import { afterEach, describe, expect, it } from 'vitest'
import {
  generateCaseAiAnalysis,
  generateLlm,
  recognizeOcrImage,
  startAsrCapture,
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

  it('delegates freeze and signing through the selected runtime', async () => {
    const { adapter, calls } = fakeAdapter()
    resetRuntimeAdapterForTests(adapter)

    await freezeDocument('case-1')
    await signDocument('case-1', 'SUSPECT', '张三', 'data:image/png;base64,abc', '[]')

    expect(calls.map((item) => item.operation)).toEqual(['document.freeze', 'document.sign'])
  })
})
