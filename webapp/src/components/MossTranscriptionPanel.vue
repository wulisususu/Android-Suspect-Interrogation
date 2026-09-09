<script setup lang="ts">
// MOSS 智能分人转写面板（Task 16）。
// 数据来自本组件自治的轮询（面板挂载即查状态；ACTIVE 态每 5s 轮询；
// COMPLETED 或 revisionNo 变化时拉取转写流；卸载时清理定时器）。
import { computed, onUnmounted, ref, watch } from 'vue'

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
} from '../api/mossTranscription'
import { backendErrorMessage } from '../api/interrogation'
import type {
  MossSpeakerMapping,
  MossTranscript,
  MossTranscriptionStatus,
} from '../types/mossTranscription'
import {
  MOSS_RESUBMITTABLE_STATES,
  formatAudioClockMs,
  isActiveMossState,
  isValidMossGlobalSpeaker,
  mossSegmentHeading,
  mossStateUi,
  mossWindowStateUi,
  normalizeMappingRows,
  sortMossSegments,
} from '../utils/mossTranscription'
import './mossTranscription.css'

const props = defineProps<{ caseId: string }>()

const MOSS_POLL_INTERVAL_MS = 5_000

const status = ref<MossTranscriptionStatus | null>(null)
const transcript = ref<MossTranscript | null>(null)
const audioPathInput = ref('')
const mossDisabled = ref(false)
const loading = ref(false)
const busy = ref<'' | 'submit' | 'resubmit' | 'transcript' | 'mapping'>('')
const actionError = ref('')
const notice = ref('')
const mappingError = ref('')
const mappingDraft = ref<MossSpeakerMapping[]>([])
// 已加载转写流的 revisionNo；后端支持增量 revision 后，轮询发现变化即重拉，
// 字段缺失（null）时退化为纯状态驱动刷新。
const loadedRevisionNo = ref<number | null>(null)

let pollTimer: number | null = null

const stateUi = computed(() => mossStateUi(status.value?.state))
const sortedSegments = computed(() => sortMossSegments(transcript.value?.segments ?? []))
const canResubmit = computed(() => !!status.value && (MOSS_RESUBMITTABLE_STATES as readonly string[]).includes(status.value.state))
const resubmitAudioPath = computed(() => (status.value?.audioPath || audioPathInput.value).trim())

function stopPolling() {
  if (pollTimer !== null) {
    window.clearInterval(pollTimer)
    pollTimer = null
  }
}

function schedulePolling() {
  stopPolling()
  if (!mossDisabled.value && isActiveMossState(status.value?.state)) {
    pollTimer = window.setInterval(() => { void pollTick() }, MOSS_POLL_INTERVAL_MS)
  }
}

async function syncTranscript(caseId: string, force: boolean) {
  let next: MossTranscript
  try {
    next = await fetchMossTranscript(caseId)
  } catch (error) {
    if (error instanceof MossApiError && isMossTranscriptionNotFoundError(error)) {
      if (props.caseId === caseId) { transcript.value = null; loadedRevisionNo.value = null }
      return
    }
    throw error
  }
  if (props.caseId !== caseId) return
  const nextRevision = next.revisionNo ?? null
  if (!force && transcript.value !== null) {
    if (nextRevision === null) return // revisionNo 字段缺失 → 状态驱动，不覆盖
    if (nextRevision === loadedRevisionNo.value) return // revision 未变化
  }
  transcript.value = next
  loadedRevisionNo.value = nextRevision
}

async function pollTick() {
  const caseId = props.caseId
  if (!caseId || mossDisabled.value) return
  try {
    const next = await fetchMossTranscriptionStatus(caseId)
    if (props.caseId !== caseId) return
    status.value = next
    // COMPLETED → 状态驱动拉取；ACTIVE 态也每次核对 revisionNo（为后端增量
    // revision 预留：完成一个窗口即追加显示），revisionNo 缺失时
    // syncTranscript 内部退化为纯状态驱动，不会产生无效覆盖。
    await syncTranscript(caseId, false)
  } catch (error) {
    if (isMossDisabledError(error)) {
      // 运行中后端转为 MOSS_ENABLED=0：与动作路径同款兜底，置横幅并停轮询。
      mossDisabled.value = true
    }
    // 其余轮询失败不打断展示：保留上一次状态，等待下一个周期重试。
  } finally {
    if (props.caseId === caseId) schedulePolling() // 仍为 ACTIVE 态则续期；已落定则自然停止
  }
}

async function load() {
  const caseId = props.caseId
  stopPolling()
  mossDisabled.value = false
  actionError.value = ''
  notice.value = ''
  mappingError.value = ''
  status.value = null
  transcript.value = null
  loadedRevisionNo.value = null
  mappingDraft.value = []
  if (!caseId) return
  loading.value = true
  try {
    const next = await fetchMossTranscriptionStatus(caseId)
    if (props.caseId !== caseId) return
    status.value = next
    if (next.state === 'COMPLETED') await syncTranscript(caseId, false)
  } catch (error) {
    if (props.caseId !== caseId) return
    if (isMossDisabledError(error)) mossDisabled.value = true
    else if (!isMossTranscriptionNotFoundError(error)) actionError.value = backendErrorMessage(error)
  } finally {
    if (props.caseId === caseId) {
      loading.value = false
      schedulePolling()
    }
  }
  try {
    const list = await fetchMossSpeakerMapping(caseId)
    if (props.caseId !== caseId) return
    mappingDraft.value = list.map((item) => ({ ...item }))
  } catch {
    // 映射读取失败不阻塞面板（编辑保存时仍会完整校验）。
  }
}

watch(() => props.caseId, () => { void load() }, { immediate: true })
onUnmounted(stopPolling)

async function submit() {
  const caseId = props.caseId
  const audioPath = audioPathInput.value.trim()
  if (!caseId || mossDisabled.value || busy.value === 'submit' || !audioPath) return
  busy.value = 'submit'
  actionError.value = ''
  notice.value = ''
  try {
    const next = await submitMossTranscription(caseId, audioPath)
    if (props.caseId !== caseId) return
    status.value = next
    transcript.value = null
    loadedRevisionNo.value = null
    notice.value = 'MOSS 转写任务已提交'
    schedulePolling()
  } catch (error) {
    if (props.caseId !== caseId) return
    if (isMossDisabledError(error)) mossDisabled.value = true
    actionError.value = backendErrorMessage(error)
  } finally {
    if (props.caseId === caseId) busy.value = ''
  }
}

async function resubmit() {
  const caseId = props.caseId
  const audioPath = resubmitAudioPath.value
  if (!caseId || mossDisabled.value || busy.value === 'resubmit' || !audioPath) return
  busy.value = 'resubmit'
  actionError.value = ''
  notice.value = ''
  try {
    const next = await resubmitMossTranscription(caseId, audioPath)
    if (props.caseId !== caseId) return
    status.value = next
    transcript.value = null
    loadedRevisionNo.value = null
    notice.value = 'MOSS 转写任务已重新提交'
    schedulePolling()
  } catch (error) {
    if (props.caseId !== caseId) return
    if (isMossDisabledError(error)) mossDisabled.value = true
    actionError.value = backendErrorMessage(error) // 409 冲突时展示后端 message
  } finally {
    if (props.caseId === caseId) busy.value = ''
  }
}

async function refreshTranscript() {
  const caseId = props.caseId
  if (!caseId || mossDisabled.value || busy.value === 'transcript') return
  busy.value = 'transcript'
  actionError.value = ''
  notice.value = ''
  try {
    await syncTranscript(caseId, true)
  } catch (error) {
    if (props.caseId === caseId) actionError.value = backendErrorMessage(error)
  } finally {
    if (props.caseId === caseId) busy.value = ''
  }
}

function addMappingRow() {
  mappingDraft.value.push({ globalSpeaker: '', role: '' })
}

async function saveMappings() {
  const caseId = props.caseId
  if (!caseId || mossDisabled.value || busy.value === 'mapping') return
  const rows = normalizeMappingRows(mappingDraft.value)
  for (const row of rows) {
    if (!isValidMossGlobalSpeaker(row.globalSpeaker)) {
      mappingError.value = `无效的说话人标签「${row.globalSpeaker || '(空)'}」，需要 GSxx 形式`
      return
    }
    if (!row.role) {
      mappingError.value = `说话人 ${row.globalSpeaker} 的角色不能为空`
      return
    }
  }
  busy.value = 'mapping'
  mappingError.value = ''
  notice.value = ''
  try {
    const saved = await putMossSpeakerMapping(caseId, rows)
    if (props.caseId !== caseId) return
    mappingDraft.value = saved.map((item) => ({ ...item }))
    await syncTranscript(caseId, true) // role 展示值来自当前映射，保存后强制刷新
    if (props.caseId !== caseId) return
    notice.value = '说话人映射已保存'
  } catch (error) {
    if (props.caseId !== caseId) return
    mappingError.value = backendErrorMessage(error)
  } finally {
    if (props.caseId === caseId) busy.value = ''
  }
}
</script>

<template>
  <section class="moss-page">
    <p v-if="mossDisabled" class="moss-disabled-banner" data-testid="moss-disabled-banner">
      MOSS 未启用：后端 MOSS_ENABLED=0，智能分人转写当前不可用。请联系管理员启用后重试。
    </p>

    <div class="moss-grid">
      <article class="moss-panel">
        <header>
          <div>
            <h2>MOSS 智能分人转写</h2>
            <p>提交审讯录音（不可变 WAV），自动按 10 分钟窗口分人转写；GSxx 为匿名说话人标签。</p>
          </div>
          <span v-if="status" class="moss-chip" :data-tone="stateUi.tone" data-testid="moss-state-chip">
            {{ stateUi.icon }} {{ stateUi.label }}
          </span>
        </header>
        <div class="moss-panel-body">
          <div class="moss-submit-row">
            <input
              v-model="audioPathInput"
              type="text"
              placeholder="音频文件路径，例如 /data/moss/interrogation.wav"
              :disabled="mossDisabled"
              aria-label="音频路径"
            />
            <button class="moss-primary-button" :disabled="mossDisabled || busy === 'submit' || !audioPathInput.trim()" @click="submit">
              {{ busy === 'submit' ? '提交中…' : '提交转写' }}
            </button>
          </div>
          <p class="moss-field-hint">提交后本面板每 5 秒自动轮询进度；处理完成后自动加载转写流。</p>

          <p v-if="!mossDisabled && actionError" class="moss-message error">{{ actionError }}</p>
          <p v-if="notice" class="moss-message success">{{ notice }}</p>
          <p v-if="status?.state === 'RECOVERY_REQUIRED'" class="moss-message recover">
            需恢复：请重新提交
          </p>
          <p v-if="status?.error" class="moss-message error">{{ status.error }}</p>

          <button
            v-if="canResubmit"
            class="moss-secondary-button"
            :disabled="mossDisabled || busy === 'resubmit' || !resubmitAudioPath"
            @click="resubmit"
          >
            {{ busy === 'resubmit' ? '重新提交中…' : '用原音频重新提交' }}
          </button>

          <p v-if="loading && !status" class="moss-empty">正在加载 MOSS 转写状态…</p>
          <p v-else-if="mossDisabled" class="moss-empty">MOSS 未启用，无法提交或查看转写任务。</p>
          <p v-else-if="!status" class="moss-empty">该案件还没有 MOSS 转写提交。</p>

          <template v-if="status">
            <dl class="moss-meta">
              <div><dt>任务 ID</dt><dd>{{ status.jobId || '—' }}</dd></div>
              <div><dt>音频哈希 (SHA256)</dt><dd>{{ status.audioSha256 || '—' }}</dd></div>
              <div><dt>模型清单哈希</dt><dd>{{ status.modelManifestSha256 || '—' }}</dd></div>
              <div><dt>更新时间</dt><dd>{{ status.updatedAt || '—' }}</dd></div>
            </dl>

            <h3 class="moss-section-title">窗口列表</h3>
            <div v-if="status.windows.length" class="moss-window-list">
              <div v-for="windowItem in status.windows" :key="windowItem.windowId" class="moss-window-row">
                <span class="moss-window-id">{{ windowItem.windowId }}</span>
                <span class="moss-window-time">{{ formatAudioClockMs(windowItem.startMs) }} – {{ formatAudioClockMs(windowItem.endMs) }}</span>
                <span class="moss-window-state">{{ mossWindowStateUi(windowItem.state).icon }} {{ mossWindowStateUi(windowItem.state).label }}</span>
                <span class="moss-window-count">{{ windowItem.segmentCount }} 段</span>
              </div>
            </div>
            <p v-else class="moss-empty">暂无窗口信息。</p>
          </template>
        </div>
      </article>

      <div class="moss-column">
        <article class="moss-panel moss-transcript-panel">
          <header>
            <div>
              <h2>转写流</h2>
              <p>按时间升序；时间戳为音频内时钟。</p>
            </div>
            <div class="moss-transcript-toolbar">
              <span v-if="transcript?.revisionNo != null" class="moss-revision-badge">rev {{ transcript.revisionNo }}</span>
              <button class="moss-secondary-button" :disabled="mossDisabled || busy === 'transcript'" @click="refreshTranscript">
                {{ busy === 'transcript' ? '刷新中…' : '刷新转写' }}
              </button>
            </div>
          </header>
          <div class="moss-panel-body">
            <div v-if="sortedSegments.length" class="moss-transcript-list">
              <article v-for="segment in sortedSegments" :key="segment.segmentId ?? `${segment.windowId}-${segment.startMs}`" class="moss-segment">
                <div class="moss-segment-head">
                  <span class="moss-segment-time">[{{ formatAudioClockMs(segment.startMs) }}]</span>
                  <strong>{{ mossSegmentHeading(segment) }}</strong>
                </div>
                <p>{{ segment.text }}</p>
              </article>
            </div>
            <p v-else-if="mossDisabled" class="moss-empty">MOSS 未启用，暂无转写内容。</p>
            <p v-else-if="status && !isActiveMossState(status.state)" class="moss-empty">暂无转写段落。</p>
            <p v-else class="moss-empty">转写进行中，完成后自动显示段落…</p>
          </div>
        </article>

        <article class="moss-panel moss-mapping-panel">
          <header>
            <div>
              <h2>说话人映射</h2>
              <p>仅影响展示名称，GSxx 标签保持匿名。</p>
            </div>
          </header>
          <div class="moss-panel-body">
            <div class="moss-mapping-rows">
              <div v-for="(row, index) in mappingDraft" :key="index" class="moss-mapping-row">
                <input v-model="row.globalSpeaker" type="text" placeholder="GS01" :disabled="mossDisabled" aria-label="匿名说话人标签" />
                <input v-model="row.role" type="text" placeholder="角色，例如 民警 / 嫌疑人" :disabled="mossDisabled" aria-label="角色" />
              </div>
            </div>
            <p v-if="!mappingDraft.length && !mossDisabled" class="moss-empty">暂无映射，点击「新增映射」添加。</p>
            <p v-if="mappingError" class="moss-message error">{{ mappingError }}</p>
            <div class="moss-mapping-actions">
              <button class="moss-secondary-button" :disabled="mossDisabled" @click="addMappingRow">新增映射</button>
              <button class="moss-primary-button" :disabled="mossDisabled || busy === 'mapping'" @click="saveMappings">
                {{ busy === 'mapping' ? '保存中…' : '保存映射' }}
              </button>
            </div>
          </div>
        </article>
      </div>
    </div>
  </section>
</template>
