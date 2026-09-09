import { beforeEach, describe, expect, it, vi } from 'vitest'

const httpMock = vi.hoisted(() => ({
  get: vi.fn(),
  post: vi.fn(),
  put: vi.fn(),
}))

vi.mock('./http', () => ({ http: httpMock }))

import {
  MossApiError,
  fetchMossSpeakerMapping,
  fetchMossTranscript,
  fetchMossTranscriptionStatus,
  isMossDisabledError,
  isMossTranscriptionNotFoundError,
  putMossSpeakerMapping,
  resubmitMossTranscription,
  submitMossTranscription,
} from './mossTranscription'

function axiosReject(status: number, payload: unknown) {
  const error = new Error('Request failed')
  ;(error as { response?: unknown }).response = { status, data: payload }
  return error
}

beforeEach(() => {
  httpMock.get.mockReset()
  httpMock.post.mockReset()
  httpMock.put.mockReset()
})

describe('moss transcription api', () => {
  it('unwraps the repository envelope and normalizes the status payload', async () => {
    httpMock.get.mockResolvedValue({
      data: {
        ok: true,
        code: 'OK',
        message: 'OK',
        data: {
          caseId: 'CASE-1',
          transcriptionId: 'T1',
          jobId: 'job-1',
          state: 'queued',
          error: null,
          audioPath: '/data/a.wav',
          audioSha256: 'sha',
          modelManifestSha256: null,
          windows: [{ windowId: 'w0001', startMs: 0, endMs: 600000, state: 'DONE', segmentCount: 3 }],
          createdAt: '2026-01-01T00:00:00',
          updatedAt: null,
        },
      },
    })

    const status = await fetchMossTranscriptionStatus('CASE-1')
    expect(httpMock.get).toHaveBeenCalledWith('/api/v1/cases/CASE-1/moss-transcription')
    expect(status.state).toBe('QUEUED')
    expect(status.windows).toEqual([{ windowId: 'w0001', startMs: 0, endMs: 600000, state: 'DONE', segmentCount: 3 }])
    expect(status.updatedAt).toBeNull()
  })

  it('posts audioPath (and audioSha256 only when provided) to submit/resubmit', async () => {
    httpMock.post.mockResolvedValue({ data: { ok: true, data: { caseId: 'C', jobId: 'j', state: 'QUEUED' } } })
    await submitMossTranscription('CASE-1', '/data/a.wav')
    expect(httpMock.post).toHaveBeenCalledWith('/api/v1/cases/CASE-1/moss-transcription', { audioPath: '/data/a.wav' })

    await submitMossTranscription('CASE-1', '/data/a.wav', 'sha-256')
    expect(httpMock.post).toHaveBeenLastCalledWith('/api/v1/cases/CASE-1/moss-transcription', { audioPath: '/data/a.wav', audioSha256: 'sha-256' })

    await resubmitMossTranscription('CASE-1', '/data/a.wav')
    expect(httpMock.post).toHaveBeenLastCalledWith('/api/v1/cases/CASE-1/moss-transcription/resubmit', { audioPath: '/data/a.wav' })
  })

  it('surfaces 503 MOSS_DISABLED as a typed MossApiError', async () => {
    httpMock.get.mockRejectedValue(axiosReject(503, { ok: false, code: 'MOSS_DISABLED', message: 'MOSS 长音频转写未启用 (MOSS_ENABLED=0)' }))

    const error = await fetchMossTranscriptionStatus('CASE-1').catch((err: unknown) => err)
    expect(error).toBeInstanceOf(MossApiError)
    expect((error as MossApiError).code).toBe('MOSS_DISABLED')
    expect((error as MossApiError).status).toBe(503)
    expect((error as MossApiError).message).toContain('MOSS_ENABLED=0')
    expect(isMossDisabledError(error)).toBe(true)
    expect(isMossTranscriptionNotFoundError(error)).toBe(false)
  })

  it('recognizes the 404 no-submission state', async () => {
    httpMock.get.mockRejectedValue(axiosReject(404, { ok: false, code: 'MOSS_TRANSCRIPTION_NOT_FOUND', message: '该案件还没有 MOSS 转写提交' }))
    const error = await fetchMossTranscript('CASE-1').catch((err: unknown) => err)
    expect(isMossTranscriptionNotFoundError(error)).toBe(true)
  })

  it('keeps non-envelope errors untouched (network failures stay raw)', async () => {
    const networkError = new TypeError('Failed to fetch')
    httpMock.get.mockRejectedValue(networkError)
    await expect(fetchMossTranscriptionStatus('CASE-1')).rejects.toBe(networkError)
    expect(isMossDisabledError(networkError)).toBe(false)
  })

  it('normalizes the transcript revision payload', async () => {
    httpMock.get.mockResolvedValue({
      data: {
        ok: true,
        data: {
          caseId: 'CASE-1',
          transcriptionId: 'T1',
          jobId: 'job-1',
          state: 'COMPLETED',
          revisionNo: 2,
          segments: [{ segmentId: 's1', windowId: 'w0001', startMs: 0, endMs: 12000, localSpeaker: 'S01', gs: 'GS01', role: '民警', text: '你好', parseStatus: 'VALID', mergeStatus: 'PRIMARY', modelManifestSha256: 'm' }],
        },
      },
    })
    const transcript = await fetchMossTranscript('CASE-1')
    expect(httpMock.get).toHaveBeenCalledWith('/api/v1/cases/CASE-1/moss-transcription/transcript')
    expect(transcript.revisionNo).toBe(2)
    expect(transcript.segments[0]?.gs).toBe('GS01')
  })

  it('sends {mappings} on PUT and returns the plain-array mapping list', async () => {
    httpMock.put.mockResolvedValue({ data: { ok: true, data: [{ globalSpeaker: 'GS01', role: '民警' }] } })
    const mappings = await putMossSpeakerMapping('CASE-1', [{ globalSpeaker: 'GS01', role: '民警' }])
    expect(httpMock.put).toHaveBeenCalledWith('/api/v1/cases/CASE-1/moss-speaker-mapping', { mappings: [{ globalSpeaker: 'GS01', role: '民警' }] })
    expect(mappings).toEqual([{ globalSpeaker: 'GS01', role: '民警' }])

    httpMock.get.mockResolvedValue({ data: { ok: true, data: [{ globalSpeaker: 'GS02', role: '嫌疑人' }] } })
    expect(await fetchMossSpeakerMapping('CASE-1')).toEqual([{ globalSpeaker: 'GS02', role: '嫌疑人' }])
  })
})
