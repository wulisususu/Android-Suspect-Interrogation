import type { TemporaryAsrFragment } from '../types/interrogation'

function sortCaptureGroup(fragments: TemporaryAsrFragment[]): TemporaryAsrFragment[] {
  return [...fragments].sort((left, right) =>
    left.startedAtMs - right.startedAtMs
    || left.endedAtMs - right.endedAtMs
    || left.ordinal - right.ordinal
    || left.id.localeCompare(right.id))
}

function sortByCaptureTime(fragments: TemporaryAsrFragment[]): TemporaryAsrFragment[] {
  const groups = new Map<string, TemporaryAsrFragment[]>()
  for (const fragment of fragments) {
    const group = groups.get(fragment.captureSessionId) ?? []
    group.push(fragment)
    groups.set(fragment.captureSessionId, group)
  }
  return [...groups.values()].flatMap(sortCaptureGroup)
}

export function upsertAsrFragmentByCaptureTime(
  fragments: TemporaryAsrFragment[],
  fragment: TemporaryAsrFragment,
): TemporaryAsrFragment[] {
  return sortByCaptureTime([
    ...fragments.filter((item) => item.id !== fragment.id),
    fragment,
  ])
}

export function replaceAsrFragmentGroup(
  fragments: TemporaryAsrFragment[],
  parentFragmentId: string,
  children: TemporaryAsrFragment[],
): TemporaryAsrFragment[] {
  const replacedIds = new Set(children.map((item) => item.id))
  return sortByCaptureTime([
    ...fragments.filter((item) => item.id !== parentFragmentId && !replacedIds.has(item.id)),
    ...children,
  ])
}

export function removeReplacedAsrFragmentSelection(
  selectedFragmentIds: string[],
  parentFragmentId: string,
): string[] {
  return selectedFragmentIds.filter((id) => id !== parentFragmentId)
}
