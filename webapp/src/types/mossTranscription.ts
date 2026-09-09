// MOSS 智能分人转写（长音频）业务契约类型，与 linux/backend/app/api/moss_transcription.py
// 的信封 data 字段一一对应（spec §32.3，后端 test_moss_transcription_api.py 钉住）。

/** 后端 JobState 全部 12 态（moss_worker/types.py）。 */
export type MossTranscriptionState =
  | 'QUEUED'
  | 'PREPARING'
  | 'ENCODING'
  | 'BUILDING_EMBEDS'
  | 'DECODING'
  | 'PARSING'
  | 'REMAPPING'
  | 'MERGING'
  | 'COMPLETED'
  | 'FAILED'
  | 'CANCELLED'
  | 'RECOVERY_REQUIRED'

/** GET .../moss-transcription 的 data（状态对象）。 */
export interface MossTranscriptionStatus {
  caseId: string
  transcriptionId: string
  jobId: string
  state: MossTranscriptionState
  /** 已落库的最新转写 revision 版本号；null=还没有任何文本。递增即有新文本（增量轮询用）。 */
  revisionNo: number | null
  error: string | null
  audioPath: string | null
  audioSha256: string | null
  modelManifestSha256: string | null
  windows: MossWindowStatus[]
  createdAt: string | null
  updatedAt: string | null
}

/** 单个 10 分钟窗口的处理状态（moss_worker WindowState: PENDING/RUNNING/DONE/FAILED）。 */
export interface MossWindowStatus {
  windowId: string
  startMs: number
  endMs: number
  state: string
  segmentCount: number
}

/** GET .../moss-transcription/transcript 的 data；revisionNo 为后端增量版本号（可能为 null）。 */
export interface MossTranscript {
  caseId: string
  transcriptionId: string
  jobId: string
  state: MossTranscriptionState
  revisionNo: number | null
  segments: MossTranscriptSegment[]
}

export interface MossTranscriptSegment {
  segmentId: string | null
  windowId: string | null
  startMs: number
  endMs: number
  localSpeaker: string | null
  /** 匿名全局说话人标签（GSxx，永不是姓名）。 */
  gs: string | null
  /** 展示角色（来自当前映射表，可能为 null）。 */
  role: string | null
  text: string
  parseStatus: string | null
  mergeStatus: string | null
  modelManifestSha256: string | null
}

/** GET/PUT .../moss-speaker-mapping 的 data 元素（GET 返回纯数组）。 */
export interface MossSpeakerMapping {
  globalSpeaker: string
  role: string
}
