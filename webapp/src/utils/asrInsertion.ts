import type {
  AsrInsertionTarget,
  TemporaryAsrFragment,
  TranscriptMessage,
} from '../types/interrogation'

export interface BuiltAsrInsertion {
  text: string
  recognizedText: string
  caretPosition: number
  fragmentIds: string[]
}

export function isAsrTargetUsable(
  target: AsrInsertionTarget | null,
  caseId: string,
  messages: TranscriptMessage[],
): target is AsrInsertionTarget {
  return !!target
    && target.caseId === caseId
    && messages.some((item) => item.id === target.recordId && item.speaker !== 'AI')
}

export function buildAsrInsertion(
  target: AsrInsertionTarget,
  captureSessionId: string,
  fragments: TemporaryAsrFragment[],
): BuiltAsrInsertion | null {
  const current = fragments
    .filter((item) => item.caseId === target.caseId
      && item.captureSessionId === captureSessionId
      && item.state === 'PENDING')
    .sort((left, right) => left.ordinal - right.ordinal)
  const recognizedText = current
    .map((item) => (item.editedText || item.rawText).trim())
    .join('')
    .trim()
  if (!recognizedText || !current.length) return null

  const length = target.sourceText.length
  const first = Math.max(0, Math.min(length, target.selectionStart))
  const second = Math.max(0, Math.min(length, target.selectionEnd))
  const start = Math.min(first, second)
  const end = Math.max(first, second)
  return {
    text: target.sourceText.slice(0, start) + recognizedText + target.sourceText.slice(end),
    recognizedText,
    caretPosition: start + recognizedText.length,
    fragmentIds: current.map((item) => item.id),
  }
}
