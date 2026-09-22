import { ref } from 'vue'

/**
 * 触摸屏统一投放载荷（「点选 → 点放」两步式）。
 *
 * 背景：本项目正式笔录的投放功能原先只实现为 HTML5 拖放
 * （`draggable` + `dragstart` / `dragover` / `drop` + `dataTransfer`）。
 * 而浏览器规范决定了**触摸输入不会产生 HTML5 拖放事件**，
 * 因此在触摸屏一体机上长按拖动完全无效（鼠标才可用）。
 *
 * 本模块不改变任何既有业务逻辑：它把与拖拽**完全相同**的 MIME + 序列化载荷
 * 记在 `pendingDrop` 里，等用户点击投放目标时，合成一个最小可用的 DragEvent，
 * 直接交给组件里原有的 `@drop` 处理函数消费。
 */

export type PendingDropEntry = { mime: string; data: string }

export type PendingDropPayload = {
  /** 与拖拽时 setData 完全一致的 (MIME, 序列化 JSON) 集合，可含多个 */
  entries: PendingDropEntry[]
  /** 给操作员看的中文说明，例如「整组问答」 */
  label: string
}

export const pendingDrop = ref<PendingDropPayload | null>(null)

/** 选中一个可投放载荷（等价于「按下了拖动，但还没松手」）。 */
export function armDrop(entries: PendingDropEntry[], label: string): void {
  const usable = entries.filter((entry) => entry.mime && entry.data)
  if (!usable.length) return
  pendingDrop.value = { entries: usable, label }
}

/** 取消选中。 */
export function clearDrop(): void {
  pendingDrop.value = null
}

type DataTransferLike = {
  types: string[]
  getData: (type: string) => string
  setData: () => void
  clearData: () => void
  dropEffect: string
  effectAllowed: string
  files: unknown[]
  items: unknown[]
}

/** 合成最小可用的 DragEvent —— 只实现既有 drop 处理器真正会读到的字段。 */
export function syntheticDropEvent(payload: PendingDropPayload): DragEvent {
  const byMime = new Map(payload.entries.map((entry) => [entry.mime, entry.data]))
  const dataTransfer: DataTransferLike = {
    types: payload.entries.map((entry) => entry.mime),
    getData: (type: string) => byMime.get(type) ?? '',
    setData: () => {},
    clearData: () => {},
    dropEffect: 'copy',
    effectAllowed: 'copy',
    files: [],
    items: [],
  }
  return {
    dataTransfer,
    preventDefault: () => {},
    stopPropagation: () => {},
  } as unknown as DragEvent
}

/**
 * 若当前有选中载荷，则合成事件执行 handler 并清空选中状态，返回 true；
 * 没有选中时什么都不做并返回 false —— 这样普通点击（例如点进 textarea 打字）
 * 完全不受影响。
 */
export function dropArmed(handler: (event: DragEvent) => void): boolean {
  const payload = pendingDrop.value
  if (!payload) return false
  clearDrop()
  handler(syntheticDropEvent(payload))
  return true
}
