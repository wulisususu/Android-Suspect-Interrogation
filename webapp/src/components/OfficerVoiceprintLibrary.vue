<script lang="ts">
import type { OfficerVoiceProfile as FilterableOfficerVoiceProfile } from '../api/officerVoiceprints'

export function filterOfficerProfiles(profiles: FilterableOfficerVoiceProfile[], query: string): FilterableOfficerVoiceProfile[] {
  const needle = String(query || '').trim().toLowerCase()
  if (!needle) return profiles
  return profiles.filter((item) =>
    item.officerId.toLowerCase().includes(needle) || item.officerName.toLowerCase().includes(needle),
  )
}

export function formatVoiceprintDuration(durationMs: number): string {
  const seconds = Math.max(0, Number(durationMs || 0)) / 1000
  return `${seconds.toFixed(1)} 秒`
}
</script>

<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref } from 'vue'
import {
  disableOfficerVoiceSample,
  fetchOfficerVoiceProfile,
  fetchOfficerVoiceProfiles,
  revokeOfficerVoiceProfile,
  type OfficerVoiceProfile,
} from '../api/officerVoiceprints'
import {
  fetchBrowserAwareVoiceprintStatus,
  startBrowserAwareOfficerEnrollment,
  stopBrowserAwareOfficerEnrollment,
} from '../api/browserVoiceprint'
import type { BrowserVoiceprintCapture } from '../audio/browserVoiceprintCapture'
import { selectVoiceprintSource } from '../audio/voiceprintSourceSelection'
import { audioInputMode } from '../config/audioInput'

const profiles = ref<OfficerVoiceProfile[]>([])
const selectedOfficerId = ref('')
const search = ref('')
const officerIdInput = ref('')
const officerNameInput = ref('')
const loading = ref(false)
const busy = ref(false)
const error = ref('')
const message = ref('')
const recording = ref(false)
const captureSubjectId = ref('')
const captureId = ref('')
const capturedDurationMs = ref(0)
const usableSpeechMs = ref(0)
const requiredUsableSpeechMs = ref(20_000)
const captureSource = ref<'ALSA' | 'BROWSER'>('ALSA')
let browserCapture: BrowserVoiceprintCapture | null = null
let progressTimer: ReturnType<typeof setInterval> | null = null
let finalizing = false

const filteredProfiles = computed(() => filterOfficerProfiles(profiles.value, search.value))
const selectedProfile = computed(() => profiles.value.find((item) => item.officerId === selectedOfficerId.value) || null)
const inputModeText = computed(() => audioInputMode === 'BROWSER'
  ? '当前测试音源：Windows 浏览器麦克风，经局域网送入 Linux。'
  : '当前生产音源：Linux 一体机 ALSA 麦克风。')
const progressPercent = computed(() => {
  const target = Math.max(1, requiredUsableSpeechMs.value)
  return Math.min(100, Math.round(usableSpeechMs.value / target * 100))
})

function clearNotice() {
  error.value = ''
  message.value = ''
}

function stopPolling() {
  if (progressTimer) clearInterval(progressTimer)
  progressTimer = null
}

async function refresh(preferredOfficerId?: string) {
  loading.value = true
  try {
    profiles.value = await fetchOfficerVoiceProfiles(false)
    const preferred = preferredOfficerId || selectedOfficerId.value
    if (preferred && profiles.value.some((item) => item.officerId === preferred)) {
      selectedOfficerId.value = preferred
    } else if (!selectedOfficerId.value && profiles.value.length) {
      selectedOfficerId.value = profiles.value[0]!.officerId
    } else if (selectedOfficerId.value && !profiles.value.some((item) => item.officerId === selectedOfficerId.value)) {
      selectedOfficerId.value = profiles.value[0]?.officerId || ''
    }
    if (selectedOfficerId.value) await refreshDetail(selectedOfficerId.value, false)
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : String(cause)
  } finally {
    loading.value = false
  }
}

async function refreshDetail(officerId: string, setBusy = true) {
  if (!officerId) return
  if (setBusy) busy.value = true
  try {
    const detail = await fetchOfficerVoiceProfile(officerId)
    const index = profiles.value.findIndex((item) => item.officerId === officerId)
    if (index >= 0) profiles.value.splice(index, 1, detail)
    else profiles.value.push(detail)
    selectedOfficerId.value = officerId
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : String(cause)
  } finally {
    if (setBusy) busy.value = false
  }
}

function selectProfile(profile: OfficerVoiceProfile) {
  clearNotice()
  selectedOfficerId.value = profile.officerId
  officerIdInput.value = profile.officerId
  officerNameInput.value = profile.officerName
  void refreshDetail(profile.officerId)
}

async function pollCapture() {
  if (!recording.value || finalizing) return
  try {
    const status = await fetchBrowserAwareVoiceprintStatus()
    capturedDurationMs.value = Number(status.capturedDurationMs ?? status.recordedDurationMs ?? 0)
    usableSpeechMs.value = Number(status.usableSpeechMs ?? 0)
    requiredUsableSpeechMs.value = Number(status.requiredUsableSpeechMs ?? status.targetDurationMs ?? 20_000)
    if (status.complete) await finalizeSample(true)
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : String(cause)
  }
}

async function beginSample() {
  const officerId = officerIdInput.value.trim()
  const officerName = officerNameInput.value.trim()
  if (!officerId || !officerName || busy.value || recording.value) return
  clearNotice()
  busy.value = true
  try {
    const selection = await selectVoiceprintSource(audioInputMode)
    captureSource.value = selection.source
    browserCapture = selection.browserCapture
    const started = await startBrowserAwareOfficerEnrollment(officerId, officerName, selection.source)
    if (!started.captureId) throw new Error('后端未返回声纹采集会话编号')
    captureSubjectId.value = officerId
    captureId.value = started.captureId
    capturedDurationMs.value = 0
    usableSpeechMs.value = 0
    requiredUsableSpeechMs.value = 20_000
    if (browserCapture) {
      await browserCapture.start(started.captureId, {
        onError: (text) => { error.value = text },
        onTrackEnded: () => { error.value = '浏览器麦克风已停止，请重新开始采样' },
      })
    }
    recording.value = true
    stopPolling()
    progressTimer = setInterval(() => { void pollCapture() }, 500)
    await pollCapture()
  } catch (cause) {
    try { await browserCapture?.stop() } catch { /* cleanup only */ }
    browserCapture = null
    captureId.value = ''
    captureSubjectId.value = ''
    error.value = cause instanceof Error ? cause.message : String(cause)
  } finally {
    busy.value = false
  }
}

async function finalizeSample(automatic = false) {
  if (!recording.value || finalizing || !captureSubjectId.value) return
  finalizing = true
  busy.value = true
  stopPolling()
  const officerId = captureSubjectId.value
  try {
    browserCapture?.pause()
    const result = await stopBrowserAwareOfficerEnrollment(officerId)
    await browserCapture?.stop()
    browserCapture = null
    recording.value = false
    captureId.value = ''
    captureSubjectId.value = ''
    message.value = automatic ? '有效语音已达标，新样本已自动添加并重新聚合。' : '新样本已添加并重新聚合。'
    await refresh(officerId)
    officerIdInput.value = result.officerId ? String(result.officerId) : officerId
    officerNameInput.value = result.officerName ? String(result.officerName) : officerNameInput.value
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : String(cause)
    try { await browserCapture?.stop() } catch { /* cleanup only */ }
    browserCapture = null
    recording.value = false
    captureId.value = ''
    captureSubjectId.value = ''
  } finally {
    finalizing = false
    busy.value = false
  }
}

async function disableSample(sampleId: string) {
  const profile = selectedProfile.value
  if (!profile || busy.value || recording.value) return
  clearNotice()
  busy.value = true
  try {
    await disableOfficerVoiceSample(profile.officerId, sampleId, '系统设置中人工停用')
    message.value = '样本已保留在历史记录中并停用，聚合 reference 已重建。'
    await refresh(profile.officerId)
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : String(cause)
  } finally {
    busy.value = false
  }
}

async function revokeProfile() {
  const profile = selectedProfile.value
  if (!profile || busy.value || recording.value) return
  clearNotice()
  busy.value = true
  try {
    await revokeOfficerVoiceProfile(profile.officerId)
    message.value = '该民警声纹档案已停用；已冻结的历史审讯 reference 不受影响。'
    await refresh(profile.officerId)
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : String(cause)
  } finally {
    busy.value = false
  }
}

onMounted(() => { void refresh() })
onUnmounted(() => {
  stopPolling()
  void browserCapture?.stop()
  browserCapture = null
})
</script>

<template>
  <section class="officer-library" aria-label="民警声纹库">
    <header class="library-header">
      <div>
        <span class="library-kicker">系统级生物特征资产</span>
        <h2>民警声纹库</h2>
        <p>民警档案跨案件复用；每次补录都会新增样本，不覆盖历史样本。案件绑定后冻结当时聚合版本。</p>
      </div>
      <span class="input-mode">{{ inputModeText }}</span>
    </header>

    <div v-if="error" class="notice error" role="alert">{{ error }}</div>
    <div v-else-if="message" class="notice success" aria-live="polite">{{ message }}</div>

    <section class="sample-enrollment-card">
      <div class="card-heading">
        <div><strong>添加新样本</strong><span>同一民警可持续补录；每条样本独立保留元数据。</span></div>
        <span v-if="recording" class="recording-chip">● 正在采样</span>
      </div>
      <div class="enrollment-grid">
        <label>民警编号<input v-model="officerIdInput" :disabled="busy || recording" placeholder="例如 P-001" /></label>
        <label>民警姓名<input v-model="officerNameInput" :disabled="busy || recording" placeholder="请输入姓名" /></label>
        <button v-if="!recording" class="primary" :disabled="busy || !officerIdInput.trim() || !officerNameInput.trim()" @click="beginSample">开始添加新样本</button>
        <button v-else class="danger" :disabled="busy" @click="finalizeSample(false)">提前停止并保存样本</button>
      </div>
      <div v-if="recording" class="capture-progress">
        <div><span>有效语音 {{ formatVoiceprintDuration(usableSpeechMs) }} / {{ formatVoiceprintDuration(requiredUsableSpeechMs) }}</span><small>总采集 {{ formatVoiceprintDuration(capturedDurationMs) }} · {{ captureSource }}</small></div>
        <div class="progress-track"><i :style="{ width: `${progressPercent}%` }"></i></div>
      </div>
    </section>

    <div class="library-layout">
      <aside class="profile-list-panel">
        <div class="list-toolbar">
          <strong>全局民警档案</strong>
          <input v-model="search" placeholder="按姓名或编号搜索" aria-label="搜索民警声纹档案" />
        </div>
        <div v-if="loading" class="empty-state">正在加载…</div>
        <div v-else-if="!filteredProfiles.length" class="empty-state">暂无匹配的民警声纹档案</div>
        <button
          v-for="profile in filteredProfiles"
          :key="profile.profileId"
          class="profile-row"
          :class="{ selected: selectedOfficerId === profile.officerId, inactive: !profile.active }"
          @click="selectProfile(profile)"
        >
          <span><b>{{ profile.officerName }}</b><small>{{ profile.officerId }}</small></span>
          <span class="profile-meta"><em>{{ profile.active ? '启用' : '停用' }}</em><small>{{ profile.sampleCount }} 样本 · v{{ profile.aggregateVersion }}</small></span>
        </button>
      </aside>

      <article class="profile-detail-panel">
        <div v-if="!selectedProfile" class="empty-state detail-empty">选择一名民警查看样本和聚合 reference。</div>
        <template v-else>
          <header class="profile-detail-header">
            <div>
              <span class="library-kicker">{{ selectedProfile.officerId }}</span>
              <h3>{{ selectedProfile.officerName }}</h3>
            </div>
            <button class="danger ghost" :disabled="busy || recording || !selectedProfile.active" @click="revokeProfile">停用该民警</button>
          </header>

          <div class="aggregate-grid">
            <div><span>聚合版本</span><strong>v{{ selectedProfile.aggregateVersion }}</strong></div>
            <div><span>有效样本</span><strong>{{ selectedProfile.sampleCount }}</strong></div>
            <div><span>有效语音</span><strong>{{ formatVoiceprintDuration(selectedProfile.usableDurationMs) }}</strong></div>
            <div><span>模型</span><strong>{{ selectedProfile.modelId }} {{ selectedProfile.modelVersion || '' }}</strong></div>
          </div>

          <section class="samples-section">
            <header><strong>保留样本</strong><span>停用只排除聚合，不物理删除历史记录。</span></header>
            <div v-if="!selectedProfile.samples?.length" class="empty-state">暂无样本明细</div>
            <div v-else class="sample-list">
              <article v-for="sample in selectedProfile.samples" :key="sample.sampleId" class="sample-row" :class="{ inactive: !sample.active }">
                <div class="sample-summary">
                  <strong>{{ sample.quality }} · {{ formatVoiceprintDuration(sample.usableDurationMs) }}</strong>
                  <span>{{ sample.active ? '参与当前聚合' : '已停用，不参与聚合' }}</span>
                </div>
                <dl>
                  <div><dt>采样时间</dt><dd>{{ sample.capturedAt ? new Date(sample.capturedAt).toLocaleString() : '未知' }}</dd></div>
                  <div><dt>采样设备</dt><dd>{{ sample.deviceName || sample.deviceId || '未知设备' }}</dd></div>
                  <div><dt>音源</dt><dd>{{ sample.audioSource }}</dd></div>
                  <div><dt>模型</dt><dd>{{ sample.modelId }} {{ sample.modelVersion || '' }}</dd></div>
                </dl>
                <button v-if="sample.active" class="danger ghost" :disabled="busy || recording" @click="disableSample(sample.sampleId)">停用样本</button>
                <small v-else class="disabled-reason">{{ sample.disabledReason || '已停用' }}</small>
              </article>
            </div>
          </section>
        </template>
      </article>
    </div>
  </section>
</template>

<style scoped>
.officer-library { display:grid; gap:16px; color:#20384d; }
.library-header { display:flex; align-items:flex-start; justify-content:space-between; gap:24px; padding:20px; border:1px solid #cad8e4; border-radius:10px; background:#f7fbfe; }
.library-header h2,.profile-detail-header h3 { margin:4px 0; }
.library-header p { margin:5px 0 0; max-width:760px; color:#607487; }
.library-kicker { color:#587186; font-size:12px; letter-spacing:.08em; }
.input-mode { max-width:360px; padding:8px 11px; border:1px solid #bfd0de; border-radius:7px; background:#fff; color:#4d687f; font-size:12px; }
.notice { padding:10px 13px; border-radius:7px; font-weight:700; }
.notice.error { border:1px solid #e1a49e; background:#fff0ef; color:#9b3129; }
.notice.success { border:1px solid #9bc9ac; background:#edf8f1; color:#287248; }
.sample-enrollment-card,.profile-list-panel,.profile-detail-panel { border:1px solid #cad8e4; border-radius:10px; background:#fff; }
.sample-enrollment-card { padding:16px; }
.card-heading,.profile-detail-header,.samples-section > header { display:flex; justify-content:space-between; align-items:center; gap:14px; }
.card-heading > div { display:grid; gap:3px; }
.card-heading span,.samples-section > header span { color:#6a7f91; font-size:12px; }
.recording-chip { color:#b13a31 !important; font-weight:800; }
.enrollment-grid { display:grid; grid-template-columns:1fr 1fr auto; gap:10px; margin-top:12px; align-items:end; }
.enrollment-grid label { display:grid; gap:5px; color:#5b7082; font-size:12px; font-weight:700; }
input { min-height:40px; box-sizing:border-box; border:1px solid #b8c9d7; border-radius:6px; padding:0 11px; background:#fff; color:#20384d; }
button { min-height:40px; border:1px solid #9fb3c4; border-radius:6px; padding:0 13px; background:#fff; color:#29465e; font-weight:700; cursor:pointer; }
button.primary { border-color:#2476c9; background:#2476c9; color:#fff; }
button.danger { border-color:#d2574c; color:#a7352d; }
button.ghost { background:#fff; }
button:disabled,input:disabled { opacity:.5; cursor:not-allowed; }
.capture-progress { display:grid; gap:7px; margin-top:12px; padding:10px 12px; border-radius:7px; background:#edf5fb; }
.capture-progress > div:first-child { display:flex; justify-content:space-between; gap:12px; }
.capture-progress small { color:#657b8d; }
.progress-track { height:8px; overflow:hidden; border-radius:999px; background:#d5e2eb; }
.progress-track i { display:block; height:100%; border-radius:inherit; background:#2476c9; transition:width .25s ease; }
.library-layout { display:grid; grid-template-columns:minmax(280px, 34%) 1fr; gap:16px; min-height:460px; }
.profile-list-panel { overflow:hidden; }
.list-toolbar { display:grid; gap:9px; padding:14px; border-bottom:1px solid #d3dfe8; }
.profile-row { width:100%; min-height:66px; display:flex; justify-content:space-between; align-items:center; gap:12px; padding:10px 14px; border:0; border-bottom:1px solid #e1e9ef; border-radius:0; text-align:left; }
.profile-row.selected { background:#eaf4fc; box-shadow:inset 4px 0 #2476c9; }
.profile-row.inactive { opacity:.62; }
.profile-row > span,.profile-meta { display:grid; gap:3px; }
.profile-row small { color:#718596; }
.profile-meta { text-align:right; }
.profile-meta em { font-style:normal; color:#31744e; }
.profile-row.inactive .profile-meta em { color:#8b5b57; }
.profile-detail-panel { padding:18px; }
.profile-detail-header { border-bottom:1px solid #d8e2ea; padding-bottom:12px; }
.aggregate-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:9px; margin:14px 0; }
.aggregate-grid > div { display:grid; gap:5px; padding:11px; border:1px solid #d9e3ea; border-radius:7px; background:#f8fafc; }
.aggregate-grid span { color:#6b8091; font-size:12px; }
.samples-section { display:grid; gap:10px; }
.sample-list { display:grid; gap:8px; }
.sample-row { display:grid; grid-template-columns:minmax(170px,.8fr) minmax(310px,1.7fr) auto; align-items:center; gap:12px; padding:11px; border:1px solid #d6e1e9; border-radius:8px; }
.sample-row.inactive { background:#f5f6f7; opacity:.72; }
.sample-summary { display:grid; gap:4px; }
.sample-summary span,.disabled-reason { color:#6f8292; font-size:12px; }
dl { display:grid; grid-template-columns:1fr 1fr; gap:6px 12px; margin:0; }
dl div { display:flex; gap:6px; min-width:0; font-size:12px; }
dt { color:#758796; flex:none; } dd { margin:0; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
.empty-state { padding:24px; text-align:center; color:#728596; }
.detail-empty { min-height:380px; display:grid; place-items:center; }
@media (max-width:980px) { .library-header { flex-direction:column; } .enrollment-grid,.library-layout,.aggregate-grid,.sample-row { grid-template-columns:1fr; } dl { grid-template-columns:1fr; } }
</style>
