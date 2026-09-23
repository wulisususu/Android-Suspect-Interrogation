// 离线拼音输入引擎:音节切分 + 词/字候选查询(数据来自 public/pinyin-dict.json,懒加载)
export interface PinyinDict {
  v: number
  syllables: string[]
  chars: Record<string, [string, number][]>
  words: Record<string, [string, number][]>
}

export interface PinyinCandidates {
  /** 词组候选(整串或已切分前缀精确命中) */
  words: string[]
  /** 单字候选(最后一个完整音节 / 残缺音节前缀) */
  chars: string[]
  /** words + chars 去重合并,供候选条展示 */
  all: string[]
}

let cache: Promise<PinyinDict> | null = null

export function loadPinyinDict(baseUrl: string = import.meta.env.BASE_URL): Promise<PinyinDict> {
  if (!cache) {
    cache = fetch(`${baseUrl}pinyin-dict.json`).then((response) => {
      if (!response.ok) throw new Error(`pinyin dict http ${response.status}`)
      return response.json() as Promise<PinyinDict>
    })
  }
  return cache
}

export function createSyllableSet(dict: PinyinDict): Set<string> {
  return new Set(dict.syllables)
}

/** 贪心最长匹配切分;除最后一段外必须都是完整音节,残缺部分作为 partial 返回 */
export function segmentPinyin(
  input: string,
  syllables: Set<string>,
): { complete: string[]; partial: string } {
  const clean = input.toLowerCase().replace(/[^a-z]/g, '')
  const complete: string[] = []
  let i = 0
  while (i < clean.length) {
    let matched = ''
    const maxLen = Math.min(6, clean.length - i)
    for (let len = maxLen; len >= 1; len--) {
      const piece = clean.slice(i, i + len)
      if (syllables.has(piece)) {
        matched = piece
        break
      }
    }
    if (!matched) break
    complete.push(matched)
    i += matched.length
  }
  return { complete, partial: clean.slice(i) }
}

function pushUnique(list: string[], value: string) {
  if (!list.includes(value)) list.push(value)
}

export function lookupCandidates(dict: PinyinDict, input: string): PinyinCandidates {
  const trimmed = input.toLowerCase().replace(/[^a-z]/g, '')
  if (!trimmed) return { words: [], chars: [], all: [] }
  const syllables = createSyllableSet(dict)
  const { complete, partial } = segmentPinyin(trimmed, syllables)

  const words: string[] = []
  for (const key of [trimmed, complete.join('')]) {
    if (!key) continue
    for (const [word] of dict.words[key] ?? []) pushUnique(words, word)
  }

  const chars: string[] = []
  if (partial) {
    const hits = dict.syllables.filter((syl) => syl.startsWith(partial)).slice(0, 4)
    for (const hit of hits) {
      for (const [char] of dict.chars[hit] ?? []) pushUnique(chars, char)
    }
  } else if (complete.length) {
    for (const [char] of dict.chars[complete[complete.length - 1]] ?? []) pushUnique(chars, char)
  }

  const all = [...words, ...chars]
  return { words: words.slice(0, 12), chars: chars.slice(0, 12), all: all.slice(0, 30) }
}
