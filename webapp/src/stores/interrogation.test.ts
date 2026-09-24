import { createPinia, setActivePinia } from 'pinia'
import { beforeEach, describe, expect, it, vi } from 'vitest'

describe('interrogation capture event reducer', () => {
  beforeEach(() => {
    vi.stubGlobal('location', { search: '' })
    setActivePinia(createPinia())
  })

  it('keeps final text visible before speaker resolution and replaces superseded parents once', async () => {
    const { useInterrogationStore } = await import('./interrogation')
    const store = useInterrogationStore()
    store.resetCaseContext('case-1')
    const fragment = (id: string, ordinal: number) => ({
      id,
      fragmentId: id,
      caseId: 'case-1',
      captureSessionId: 'capture-1',
      ordinal,
      startedAtMs: ordinal * 1000,
      endedAtMs: (ordinal + 1) * 1000,
      rawText: '问到哪了？',
      editedText: '问到哪了？',
      speaker: 'UNKNOWN',
      speakerSource: 'UNASSIGNED',
      state: 'PENDING',
      createdAt: Date.now(),
      updatedAt: Date.now(),
    })
    const replacement = {
      event: 'ASR_FRAGMENT_REPLACED',
      payload: {
        parentFragmentId: 'f1',
        jobId: 'job-1',
        fragments: [fragment('f2', 1), fragment('f3', 2)],
      },
    }

    store.applyCaptureEvent({ event: 'ASR_FRAGMENT', payload: fragment('f1', 0) })
    expect(store.activeFragments.map((item) => item.id)).toEqual(['f1'])
    expect(store.activeFragments[0].speaker).toBe('UNKNOWN')

    store.applyCaptureEvent(replacement)
    store.applyCaptureEvent(replacement)

    expect(store.activeFragments.map((item) => item.id)).toEqual(['f2', 'f3'])
    expect(store.fragmentHistory('f1').map((item) => item.id)).toEqual(['f1', 'f2', 'f3'])
  })
})
