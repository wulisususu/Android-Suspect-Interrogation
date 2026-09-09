// MOSS 面板共用常量与纯函数：状态→UI 映射、音频时钟格式化、段落排序。
// 只依赖类型，方便单元测试与组件复用。
import type { MossSpeakerMapping, MossTranscriptSegment, MossTranscriptionState } from '../types/mossTranscription'

/** 与后端 ACTIVE_POLL_STATES 一致（moss_transcription_coordinator.py）。 */
export const MOSS_ACTIVE_POLL_STATES: readonly MossTranscriptionState[] = [
  'QUEUED',
  'PREPARING',
  'ENCODING',
  'BUILDING_EMBEDS',
  'DECODING',
  'PARSING',
  'REMAPPING',
  'MERGING',
]

/** 失败/需恢复态：显示「重新提交」按钮。 */
export const MOSS_RESUBMITTABLE_STATES: readonly MossTranscriptionState[] = ['FAILED', 'CANCELLED', 'RECOVERY_REQUIRED']

export type MossStateTone = 'queued' | 'active' | 'done' | 'failed' | 'recover'

export interface MossStateUi {
  icon: string
  label: string
  tone: MossStateTone
}

/** 任务状态 → chip 文案（用户钦定映射；未知态兜底展示原始值）。 */
export const MOSS_STATE_UI: Record<string, MossStateUi> = {
  QUEUED: { icon: '🕒', label: '排队', tone: 'queued' },
  PREPARING: { icon: '⏳', label: '处理中', tone: 'active' },
  ENCODING: { icon: '⏳', label: '处理中', tone: 'active' },
  BUILDING_EMBEDS: { icon: '⏳', label: '处理中', tone: 'active' },
  DECODING: { icon: '⏳', label: '处理中', tone: 'active' },
  PARSING: { icon: '⏳', label: '处理中', tone: 'active' },
  REMAPPING: { icon: '⏳', label: '处理中', tone: 'active' },
  MERGING: { icon: '⏳', label: '处理中', tone: 'active' },
  COMPLETED: { icon: '✅', label: '完成', tone: 'done' },
  FAILED: { icon: '❌', label: '失败', tone: 'failed' },
  CANCELLED: { icon: '❌', label: '失败', tone: 'failed' },
  RECOVERY_REQUIRED: { icon: '⚠️', label: '需恢复', tone: 'recover' },
}

export function mossStateUi(state: string | null | undefined): MossStateUi {
  if (state && MOSS_STATE_UI[state]) return MOSS_STATE_UI[state]
  return { icon: '•', label: state || '未知', tone: 'active' }
}

export function isActiveMossState(state: string | null | undefined): boolean {
  return !!state && (MOSS_ACTIVE_POLL_STATES as readonly string[]).includes(state)
}

/** 窗口状态（moss_worker WindowState）→ 行内图标。 */
export const MOSS_WINDOW_STATE_UI: Record<string, MossStateUi> = {
  PENDING: { icon: '🕒', label: '排队', tone: 'queued' },
  RUNNING: { icon: '⏳', label: '处理中', tone: 'active' },
  DONE: { icon: '✅', label: '已完成', tone: 'done' },
  FAILED: { icon: '❌', label: '失败', tone: 'failed' },
}

export function mossWindowStateUi(state: string | null | undefined): MossStateUi {
  if (state && MOSS_WINDOW_STATE_UI[state]) return MOSS_WINDOW_STATE_UI[state]
  return { icon: '•', label: state || '未知', tone: 'active' }
}

/** startMs/endMs → 音频内时钟 HH:MM:SS（非 wall-clock）。 */
export function formatAudioClockMs(value: number | null | undefined): string {
  if (typeof value !== 'number' || !Number.isFinite(value) || value < 0) return '--:--:--'
  const totalSeconds = Math.floor(value / 1000)
  const pad = (n: number) => String(n).padStart(2, '0')
  return `${pad(Math.floor(totalSeconds / 3600))}:${pad(Math.floor((totalSeconds % 3600) / 60))}:${pad(totalSeconds % 60)}`
}

/** 转写流按 startMs 升序（同起点按 endMs、segmentId 稳定排序）。 */
export function sortMossSegments(segments: MossTranscriptSegment[]): MossTranscriptSegment[] {
  return [...segments].sort((a, b) => {
    if (a.startMs !== b.startMs) return a.startMs - b.startMs
    if (a.endMs !== b.endMs) return a.endMs - b.endMs
    return String(a.segmentId ?? '').localeCompare(String(b.segmentId ?? ''))
  })
}

/** 段落标题：role 为 null 时只显示 GSxx（gs 也缺失时给出兜底文案）。 */
export function mossSegmentHeading(segment: MossTranscriptSegment): string {
  const gs = segment.gs || ''
  if (segment.role) return `${segment.role}（${gs || '未知'}）`
  return gs || '未知说话人'
}

/** 与后端 _GLOBAL_SPEAKER 一致：^GS\d{2,}$（后端保存前会去空格并转大写）。 */
export const MOSS_GLOBAL_SPEAKER_PATTERN = /^GS\d{2,}$/

export function isValidMossGlobalSpeaker(value: string): boolean {
  return MOSS_GLOBAL_SPEAKER_PATTERN.test(value)
}

/** 镜像后端 put_mapping 的规范化：去空格、标签大写、丢弃整行为空的行。 */
export function normalizeMappingRows(rows: MossSpeakerMapping[]): MossSpeakerMapping[] {
  return rows
    .map((row) => ({ globalSpeaker: String(row.globalSpeaker ?? '').trim().toUpperCase(), role: String(row.role ?? '').trim() }))
    .filter((row) => row.globalSpeaker !== '' || row.role !== '')
}
