export type Speaker = '民警' | '嫌疑人' | 'AI'
export type RecordMark = '' | 'conflict' | 'confirmed' | 'pending'
export type SessionStatus = 'READY' | 'RUNNING' | 'PAUSED' | 'COMPLETED'
export type InterrogationStage = 'IDENTITY' | 'STATEMENT' | 'FOLLOW_UP' | 'SIGNING'
export type AiProviderKind = 'LOCAL' | 'UNAVAILABLE'
export type ModelCategory = 'ASR' | 'OCR' | 'VAD' | 'SPEAKER' | 'LLM'
export type ModelSourceKind = 'FILE' | 'DIRECTORY' | 'ASSET'
export type ModelImportSource = 'FILE' | 'DIRECTORY'
export type DocumentSignerRole = 'SUSPECT' | 'OFFICER'
export type DocumentSigningStatus = 'FROZEN' | 'LOCKED'

export interface TranscriptMessage {
  id: string
  seq?: number
  speaker: Speaker
  text: string
  mark?: RecordMark
  createdAt?: number | string
  updatedAt?: number | string
  streaming?: boolean
  confirmed?: boolean
}

export type FactStatus = 'confirmed' | 'pending' | 'conflict' | 'missing'

export interface FactItem {
  key: string
  label: string
  value: string
  status: FactStatus
  suggestion?: string
}

export interface TimelineEvent {
  id: string
  time: string
  title: string
  detail: string
  evidence?: string[]
}

export interface CaseSummary {
  id: string
  suspectName: string
  gender?: string
  age?: string
  idNumber?: string
  nation?: string
  birthDate?: string
  address?: string
  identitySource?: 'MANUAL' | 'OCR' | string
  identityCapturedAt?: number | null
  officerName: string
  state: string
  stage: InterrogationStage
  createdAt?: number
  updatedAt?: number
}

export interface SessionState {
  id: string | null
  caseId: string
  status: SessionStatus
  stage: InterrogationStage
  startedAt: number | null
  pausedAt: number | null
  endedAt: number | null
  updatedAt: number
}

export interface RecordRevision {
  id: string
  qaId: string
  version: number
  oldText: string
  newText: string
  reason: string
  createdAt: number
}

export interface DeviceActionResult {
  success: boolean
  simulated?: boolean
  message?: string
  name?: string
  gender?: string
  idNumber?: string
}

export interface InquirySsePayload {
  text_chunk?: string
  audio_url?: string
  target?: number
  infos?: Record<string, unknown>
  code?: number
  message?: string
}

export interface LocalModelDescriptor {
  id: string
  category: ModelCategory
  name: string
  storageName: string
  relativePath: string
  sizeBytes: number
  modifiedAt: number
  sourceKind: ModelSourceKind
  archive: boolean
  selected: boolean
  runtimeReady: boolean
  version?: string | null
  modelFormat?: string | null
  provider?: string | null
  complete?: boolean
  targetPlatform?: 'RK3576' | 'RK3588' | 'UNKNOWN' | string | null
  compatibility?: 'READY' | 'INCOMPLETE' | 'UNREADABLE' | 'PLATFORM_MISMATCH' | 'UNSUPPORTED' | string | null
}

export interface CaseAiAnalysis {
  id: string
  caseId: string
  text: string
  provider: AiProviderKind
  model: string
  createdAt: number
}

export interface LocalModelCatalog {
  rootPath: string
  models: LocalModelDescriptor[]
}

export interface AsrFinalResult {
  text: string
  startedAtMs: number
  endedAtMs: number
  latencyMs: number
  confidence?: number | null
}

export interface AsrRuntimeStatus {
  selectedModelId: string
  selectedModelName: string
  activeModelId?: string | null
  provider: 'rknn' | 'cpu'
  running: boolean
  initialized: boolean
  initializationMs?: number | null
  firstTokenLatencyMs?: number | null
  utteranceLatencyMs?: number | null
  partialText: string
  finalText: string
  finalResults: AsrFinalResult[]
  error?: string | null
  sherpaVersion: string
  sampleRate: number
  preferredAudioInput?: string | null
  routedAudioInput?: string | null
  audioPeak?: number | null
  audioSignalState?: 'WAITING' | 'ACTIVE' | 'SILENT'
}

export type TemporaryAsrSpeaker = 'UNKNOWN' | 'OFFICER' | 'SUSPECT'
export type TemporaryAsrFragmentState = 'PENDING' | 'CONFIRMED' | 'DISCARDED'
export type AsrConfidenceSource = 'SHERPA_TOKEN_LOG_PROBS' | 'UNAVAILABLE'

export interface AsrAudioReference {
  captureSessionId: string
  startOffsetMs: number
  endOffsetMs: number
  available: boolean
}

export interface TemporaryAsrFragment {
  id: string
  captureSessionId: string
  caseId: string
  ordinal: number
  startedAtMs: number
  endedAtMs: number
  rawText: string
  editedText: string
  speaker: TemporaryAsrSpeaker
  speakerSource: 'UNASSIGNED' | 'MANUAL' | 'DIARIZATION'
  confidence?: number | null
  confidenceSource: AsrConfidenceSource
  lowConfidence: boolean
  state: TemporaryAsrFragmentState
  confirmedQaId?: string | null
  audio: AsrAudioReference
  createdAt: number
  updatedAt: number
}

export interface AsrCaptureStatus {
  caseId: string
  captureSessionId?: string | null
  running: boolean
  startedAt?: number | null
  endedAt?: number | null
  modelId?: string | null
  modelName?: string | null
  provider?: 'rknn' | 'cpu' | null
  sampleRate: number
  partialText: string
  fragments: TemporaryAsrFragment[]
  error?: string | null
}

export interface AsrInsertionTarget {
  caseId: string
  recordId: string
  selectionStart: number
  selectionEnd: number
  sourceText: string
}

export interface AsrInsertionReceipt {
  caseId: string
  recordId: string
  caretPosition: number
  appliedAt: number
}

export interface FragmentApplication {
  fragments: TemporaryAsrFragment[]
  record: TranscriptMessage
}

export interface OcrPoint { x: number; y: number }
export interface OcrRect { left: number; top: number; right: number; bottom: number }
export interface OcrTextBlock { text: string; confidence?: number | null; rect?: OcrRect | null; points?: OcrPoint[] | null }
export interface OcrResult {
  text: string
  blocks: OcrTextBlock[]
  imageWidth: number
  imageHeight: number
  modelName: string
  provider: string
  initializationMs?: number | null
  recognitionMs: number
  previewUri?: string | null
}
export interface OcrRuntimeStatus {
  selectedModelId?: string | null
  selectedModelName?: string | null
  activeModelId?: string | null
  provider?: string | null
  modelFormat?: string | null
  initialized: boolean
  busy: boolean
  imageReady: boolean
  previewUri?: string | null
  initializationMs?: number | null
  recognitionMs?: number | null
  lastResult?: OcrResult | null
  error?: string | null
}

export interface LlmGenerationConfig {
  maxNewTokens: number
  maxContextLen: number
}

export interface LlmGenerateRequest extends LlmGenerationConfig {
  generationId: string
  prompt: string
}

export interface LlmFragment {
  generationId: string
  text: string
  accumulatedText: string
  tokenId?: number | null
  elapsedMs: number
}

export interface LlmResult {
  outputText: string
  finished: boolean
  fragments: string[]
  tokenIds?: number[] | null
  modelName: string
  provider: string
  maxNewTokens: number
  maxContextLen: number
  initializationMs: number
  firstTokenLatencyMs?: number | null
  totalInferenceMs: number
  error?: string | null
}

export interface LlmRuntimeStatus {
  selectedModelId?: string | null
  selectedModelName?: string | null
  activeModelId?: string | null
  provider: string
  storagePermissionGranted: boolean
  initialized: boolean
  busy: boolean
  generationId?: string | null
  config: LlmGenerationConfig
  initializationMs?: number | null
  firstTokenLatencyMs?: number | null
  totalInferenceMs?: number | null
  error?: string | null
}

export interface DocumentSignatureState {
  signerRole: DocumentSignerRole
  signerName: string
  signedAt: number
  signatureHash: string
  imageDataUrl: string
  strokesJson: string
  deviceId: string
}

export interface DocumentSigningState {
  caseId: string
  version: number
  documentId: string
  documentHash: string
  status: DocumentSigningStatus
  createdAt: number
  integrityValid: boolean
  signatures: DocumentSignatureState[]
}

export interface FragmentConfirmation { fragment: TemporaryAsrFragment; record: TranscriptMessage }
export interface BatchFragmentConfirmation {
  confirmed: FragmentConfirmation[]
  failures: Array<{ fragmentId: string; code: string; message: string }>
}

export interface BackendEnvelope<T> {
  ok: boolean
  code: string
  message: string
  data: T
}
