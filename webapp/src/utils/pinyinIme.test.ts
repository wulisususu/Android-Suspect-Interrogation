import { describe, expect, it } from 'vitest'
import {
  createSyllableSet,
  lookupCandidates,
  segmentPinyin,
  type PinyinDict,
} from './pinyinIme'

const dict: PinyinDict = {
  v: 1,
  syllables: ['ni', 'hao', 'xian', 'shi', 'an'],
  chars: {
    ni: [['你', 9000], ['尼', 100]],
    hao: [['好', 9500], ['号', 800]],
    xian: [['先', 6000], ['县', 500]],
    shi: [['是', 9900]],
    an: [['安', 7000]],
  },
  words: {
    nihao: [['你好', 8000]],
    xian: [['西安', 700], ['先', 6000]],
    shian: [['方案', 1]],
  },
}

const syllables = createSyllableSet(dict)

describe('segmentPinyin', () => {
  it('splits whole syllables greedily from the left', () => {
    expect(segmentPinyin('nihao', syllables)).toEqual({ complete: ['ni', 'hao'], partial: '' })
    expect(segmentPinyin('xian', syllables)).toEqual({ complete: ['xian'], partial: '' })
  })

  it('keeps a trailing partial syllable', () => {
    expect(segmentPinyin('nih', syllables)).toEqual({ complete: ['ni'], partial: 'h' })
    expect(segmentPinyin('zh', syllables)).toEqual({ complete: [], partial: 'zh' })
  })

  it('ignores non letter characters', () => {
    expect(segmentPinyin('Ni3 Hao!', syllables)).toEqual({ complete: ['ni', 'hao'], partial: '' })
  })
})

describe('lookupCandidates', () => {
  it('prefers exact word hits and appends chars of the last syllable', () => {
    const result = lookupCandidates(dict, 'nihao')
    expect(result.words).toContain('你好')
    expect(result.chars).toEqual(['好', '号'])
    expect(result.all[0]).toBe('你好')
  })

  it('matches joined-key ambiguity (xian = 西安 and 先)', () => {
    const result = lookupCandidates(dict, 'xian')
    expect(result.words).toEqual(['西安', '先'])
    expect(result.chars).toEqual(['先', '县'])
  })

  it('falls back to chars for a partial trailing syllable', () => {
    const result = lookupCandidates(dict, 'nih')
    expect(result.words).toEqual([])
    expect(result.chars.length).toBeGreaterThan(0)
    expect(result.chars).toContain('好')
  })

  it('returns empty candidates for empty input', () => {
    expect(lookupCandidates(dict, '')).toEqual({ words: [], chars: [], all: [] })
  })
})
