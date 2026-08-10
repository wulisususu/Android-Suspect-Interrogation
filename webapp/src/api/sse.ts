export interface SseEvent {
  event?: string
  data: string
  id?: string
}

function parseBlock(block: string): SseEvent | null {
  if (!block.trim()) return null

  let event: string | undefined
  let id: string | undefined
  const data: string[] = []

  for (const line of block.split(/\r?\n/)) {
    if (!line || line.startsWith(':')) continue
    const separator = line.indexOf(':')
    const field = separator === -1 ? line : line.slice(0, separator)
    const value = separator === -1 ? '' : line.slice(separator + 1).replace(/^ /, '')

    if (field === 'event') event = value
    if (field === 'id') id = value
    if (field === 'data') data.push(value)
  }

  return { event, id, data: data.join('\n') }
}

export async function streamSse(
  url: string,
  init: RequestInit,
  onEvent: (event: SseEvent) => void,
): Promise<void> {
  const response = await fetch(url, {
    ...init,
    headers: {
      Accept: 'text/event-stream',
      'Cache-Control': 'no-cache',
      ...(init.headers || {}),
    },
  })

  if (!response.ok) {
    throw new Error(`SSE 请求失败: HTTP ${response.status}`)
  }
  if (!response.body) {
    throw new Error('SSE 响应没有可读取的数据流')
  }

  const reader = response.body.getReader()
  const decoder = new TextDecoder('utf-8')
  let buffer = ''

  while (true) {
    const { done, value } = await reader.read()
    buffer += decoder.decode(value || new Uint8Array(), { stream: !done })

    const blocks = buffer.split(/\r?\n\r?\n/)
    buffer = blocks.pop() || ''
    for (const block of blocks) {
      const parsed = parseBlock(block)
      if (parsed) onEvent(parsed)
    }

    if (done) break
  }

  const tail = parseBlock(buffer)
  if (tail) onEvent(tail)
}
