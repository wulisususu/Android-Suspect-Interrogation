<script lang="ts">
import type { SpeakerCalibrationStatus } from '../api/speakerCalibration'
type CalibrationBackendKey = 'xvector' | 'eres2net_large'

export function calibrationTone(status: SpeakerCalibrationStatus): 'ok' | 'warn' | 'danger' | 'muted' {
  if (status === 'VALID') return 'ok'
  if (status === 'RECOMPUTE_RECOMMENDED') return 'warn'
  if (status === 'STALE_MODEL' || status === 'STALE_MIC') return 'danger'
  return 'muted'
}

export function calibrationStatusLabel(
  status: SpeakerCalibrationStatus,
  backend: CalibrationBackendKey = 'xvector',
): string {
  if (status === 'STALE_MODEL') {
    return backend === 'xvector' ? 'XVector 已更换' : 'ERes2Net-large 已更换'
  }
  return {
    NOT_CALIBRATED: '尚未校准',
    VALID: '校准有效',
    STALE_MODEL: 'XVector 已更换',
    STALE_MIC: '麦克风已更换',
    RECOMPUTE_RECOMMENDED: '建议重新计算',
    INSUFFICIENT_DATA: '样本不足',
  }[status]
}

export function formatMetric(value: number | null | undefined): string {
  return typeof value === 'number' && Number.isFinite(value) ? `${(value * 100).toFixed(2)}%` : 'UNKNOWN'
}
</script>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import {
  fetchSpeakerCalibrationHistory,
  fetchSpeakerCalibrationStatus,
  fetchSpeakerRuntimeStatus,
  recomputeSpeakerCalibration,
  speakerBackendLabel,
  type SpeakerBackendKey,
  type SpeakerCalibrationRecord,
  type SpeakerCalibrationState,
  type SpeakerRuntimeState,
} from '../api/speakerCalibration'

const selectedBackend = ref<SpeakerBackendKey>('xvector')
const state = ref<SpeakerCalibrationState | null>(null)
const history = ref<SpeakerCalibrationRecord[]>([])
const runtime = ref<SpeakerRuntimeState | null>(null)
const loading = ref(true)
const recomputing = ref(false)
const error = ref('')
const tone = computed(() => state.value ? calibrationTone(state.value.status) : 'muted')

async function refresh(backend: SpeakerBackendKey = selectedBackend.value) {
  loading.value = true
  error.value = ''
  selectedBackend.value = backend
  try {
    const [next, rows, runtimeState] = await Promise.all([
      fetchSpeakerCalibrationStatus(backend),
      fetchSpeakerCalibrationHistory(50, backend),
      fetchSpeakerRuntimeStatus(),
    ])
    state.value = next
    history.value = rows
    runtime.value = runtimeState
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : '无法读取设备校准状态'
  } finally {
    loading.value = false
  }
}

async function recompute() {
  recomputing.value = true
  error.value = ''
  try {
    state.value = await recomputeSpeakerCalibration(undefined, selectedBackend.value)
    history.value = await fetchSpeakerCalibrationHistory(50, selectedBackend.value)
  } catch (cause) {
    error.value = cause instanceof Error ? cause.message : '设备校准失败'
  } finally {
    recomputing.value = false
  }
}

function latency(backend: SpeakerBackendKey): string {
  const value = runtime.value?.comparisonMetrics.latencyMs[backend]
  return typeof value === 'number' ? `${value.toFixed(1)} ms` : 'UNKNOWN'
}

onMounted(() => void refresh())
</script>

<template>
  <section class="calibration-center">
    <div class="center-header">
      <div>
        <h2>设备校准中心</h2>
        <p>XVector 与 ERes2Net-large 分开维护阈值、模型指纹和麦克风兼容语料，禁止跨模型空间复用校准。</p>
      </div>
      <button :disabled="loading || recomputing" @click="recompute">
        {{ recomputing ? '正在计算…' : `重新计算 ${speakerBackendLabel(selectedBackend)} 校准` }}
      </button>
    </div>

    <div class="backend-tabs" aria-label="校准后端">
      <button :class="{ active: selectedBackend === 'xvector' }" @click="refresh('xvector')">XVector</button>
      <button :class="{ active: selectedBackend === 'eres2net_large' }" @click="refresh('eres2net_large')">ERes2Net-large</button>
    </div>

    <p v-if="error" class="error">{{ error }}</p>
    <p v-if="loading" class="loading">正在读取设备校准状态…</p>

    <template v-else-if="state">
      <div class="section-heading"><strong>模型状态</strong><span>{{ speakerBackendLabel(state.currentModel.backendKey) }}</span></div>
      <div class="model-status-grid">
        <article v-for="backend in (['xvector', 'eres2net_large'] as SpeakerBackendKey[])" :key="backend">
          <strong>{{ speakerBackendLabel(backend) }}</strong>
          <span>{{ runtime?.backends[backend].ready ? 'READY' : 'UNAVAILABLE' }}</span>
          <small>{{ runtime?.backends[backend].modelId || 'model unknown' }}</small>
          <code>{{ runtime?.backends[backend].modelFingerprint || 'fingerprint unavailable' }}</code>
        </article>
      </div>

      <div class="section-heading"><strong>校准状态</strong><span>当前后端独立参数</span></div>
      <div class="status-card" :class="`tone-${tone}`">
        <strong>{{ calibrationStatusLabel(state.status, selectedBackend) }}</strong>
        <span>{{ state.reason }}</span>
        <small v-if="state.status === 'STALE_MODEL'">旧阈值不会用于新模型指纹；当前后端需要重新校准。</small>
        <small v-if="state.status === 'STALE_MIC'">检测到生产麦克风变化；旧设备阈值已停止用于新审讯。</small>
        <small v-if="state.status === 'RECOMPUTE_RECOMMENDED'">旧校准仍可使用，仅建议利用新增样本重新计算。</small>
        <small v-if="state.status === 'INSUFFICIENT_DATA'">完整校准至少需要 {{ state.minimumOfficers }} 名民警，每人至少 {{ state.minimumSamplesPerOfficer }} 个当前模型/麦克风兼容样本。</small>
      </div>

      <div class="identity-grid">
        <article>
          <span>{{ speakerBackendLabel(state.currentModel.backendKey) }}</span>
          <strong>{{ state.currentModel.modelId }} {{ state.currentModel.modelVersion || '' }}</strong>
          <code>{{ state.currentModel.fingerprint.slice(0, 16) }}…</code>
        </article>
        <article>
          <span>生产麦克风</span>
          <strong>{{ state.currentMicrophone.deviceName }}</strong>
          <small>{{ state.currentMicrophone.deviceId }} · {{ state.currentMicrophone.fingerprintCertainty }}</small>
        </article>
        <article>
          <span>当前兼容语料</span>
          <strong>{{ state.currentCorpus.officerCount }} 人 / {{ state.currentCorpus.sampleCount }} 样本</strong>
          <small>{{ state.currentCorpus.ready ? '满足完整校准最低要求' : '尚未达到最低要求' }}</small>
        </article>
      </div>

      <div v-if="state.calibration" class="metrics">
        <article><span>Threshold</span><strong>{{ state.calibration.threshold.toFixed(4) }}</strong></article>
        <article><span>Margin</span><strong>{{ state.calibration.margin?.toFixed(4) ?? '—' }}</strong></article>
        <article><span>Observed FAR</span><strong>{{ formatMetric(state.calibration.far) }}</strong></article>
        <article><span>Observed FRR</span><strong>{{ formatMetric(state.calibration.frr) }}</strong></article>
        <article><span>Observed EER</span><strong>{{ formatMetric(state.calibration.eer) }}</strong></article>
        <article><span>校准时间</span><strong>{{ state.calibration.createdAt || '—' }}</strong></article>
      </div>

      <section class="comparison-evidence">
        <div class="section-heading"><strong>受控真值对比</strong><span>诊断证据，不自动决定业务后端</span></div>
        <div class="metrics">
          <article><span>正确角色率</span><strong>{{ formatMetric(runtime?.comparisonMetrics.correctRoleRate) }}</strong></article>
          <article><span>Error rate</span><strong>{{ formatMetric(runtime?.comparisonMetrics.errorRate) }}</strong></article>
          <article><span>UNKNOWN rate</span><strong>{{ formatMetric(runtime?.comparisonMetrics.unknownRate) }}</strong></article>
          <article><span>XVector Latency</span><strong>{{ latency('xvector') }}</strong></article>
          <article><span>ERes2Net-large Latency</span><strong>{{ latency('eres2net_large') }}</strong></article>
        </div>
        <p>当前 comparison status：{{ runtime?.comparisonMetrics.status || 'UNKNOWN' }}。Task 13 注入同一受控真值样本前，上述正确角色率、UNKNOWN 与 Latency 不得被解释为模型胜负。</p>
      </section>

      <p class="disclaimer">FAR / FRR / EER 为本机当前民警有限样本上的观测估计，只用于设备参数选择，不代表人口级生物识别认证准确率。</p>

      <section class="history">
        <h3>{{ speakerBackendLabel(selectedBackend) }} 校准历史</h3>
        <p v-if="history.length === 0">暂无校准历史。</p>
        <div v-for="item in history" :key="item.calibrationId" class="history-row">
          <div><strong>{{ item.createdAt || item.calibrationId }}</strong><span>{{ speakerBackendLabel(item.speakerBackendKey) }} · {{ item.speakerModelId }} · {{ item.microphoneName }}</span></div>
          <div><span>T {{ item.threshold.toFixed(4) }}</span><span>M {{ item.margin?.toFixed(4) ?? '—' }}</span><span>EER {{ formatMetric(item.eer) }}</span><span>{{ item.officerCount }} 人 / {{ item.sampleCount }} 样本</span></div>
        </div>
      </section>
    </template>
  </section>
</template>

<style scoped>
.calibration-center { display:grid; gap:16px; }
.center-header { display:flex; justify-content:space-between; gap:16px; align-items:flex-start; padding:18px; border:1px solid #c7d5e0; border-radius:10px; background:#fff; }
.center-header h2 { margin:0 0 6px; }
.center-header p,.status-card span,.status-card small,.identity-grid small,.model-status-grid small,.comparison-evidence p { color:#607588; }
button { min-height:38px; border:1px solid #7f9db5; border-radius:6px; padding:0 14px; background:#f7fbfe; color:#244a67; font-weight:700; }
.backend-tabs { display:flex; gap:8px; }
.backend-tabs button.active { border-color:#2476c9; background:#eaf4fd; color:#1c5e99; }
.section-heading { display:flex; justify-content:space-between; gap:12px; color:#405d74; }
.section-heading span { color:#718496; font-size:12px; }
.model-status-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; }
.model-status-grid article,.identity-grid article,.metrics article { display:grid; gap:5px; padding:14px; border:1px solid #d2dde5; border-radius:8px; background:#fff; }
.model-status-grid code,.identity-grid code { overflow-wrap:anywhere; color:#46657d; font-size:12px; }
.status-card { display:grid; gap:5px; padding:14px 16px; border:1px solid; border-radius:8px; background:#fff; }
.tone-ok { border-color:#8fbca2; }.tone-warn { border-color:#d6b268; background:#fffaf0; }.tone-danger { border-color:#d38a8a; background:#fff4f4; }.tone-muted { border-color:#bdc9d2; }
.identity-grid,.metrics { display:grid; grid-template-columns:repeat(auto-fit,minmax(180px,1fr)); gap:12px; }
.identity-grid span,.metrics span { color:#607588; font-size:12px; }
.comparison-evidence { display:grid; gap:10px; padding:14px; border:1px solid #c7d5e0; border-radius:9px; background:#f8fbfd; }
.comparison-evidence p { margin:0; font-size:13px; }
.disclaimer { margin:0; padding:12px 14px; border-radius:8px; background:#f5f7f9; color:#596d7e; font-size:13px; }
.history { padding:16px; border:1px solid #c7d5e0; border-radius:10px; background:#fff; }.history h3 { margin-top:0; }.history-row { display:flex; justify-content:space-between; gap:16px; padding:10px 0; border-top:1px solid #e1e8ed; }.history-row > div { display:flex; gap:10px; flex-wrap:wrap; }
.error { color:#9e3333; }.loading { color:#607588; }
@media (max-width:800px) { .model-status-grid { grid-template-columns:1fr; } .center-header { flex-direction:column; } }
</style>
