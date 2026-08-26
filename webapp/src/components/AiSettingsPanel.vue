<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import {
  backendErrorMessage,
  fetchLocalModels,
  fetchRuntimeCapabilities,
  importLocalModel,
  selectLocalModel,
} from '../api/interrogation'
import { RuntimeAdapterError, type RuntimeCapabilities, type RuntimeCapabilityName } from '../runtime'
import AsrConsole from './AsrConsole.vue'
import OcrConsole from './OcrConsole.vue'
import LlmConsole from './LlmConsole.vue'
import type {
  LocalModelCatalog,
  LocalModelDescriptor,
  ModelCategory,
  ModelImportSource,
} from '../types/interrogation'

const categories: Array<{ id: ModelCategory; label: string }> = [
  { id: 'ASR', label: 'ASR 语音识别' },
  { id: 'OCR', label: 'OCR 图文识别' },
  { id: 'SPEAKER', label: 'Speaker 声纹识别' },
  { id: 'VAD', label: 'VAD 语音活动检测' },
  { id: 'LLM', label: 'LLM 语言模型' },
]

const open = ref(false)
const modelLoading = ref(false)
const modelAction = ref('')
const modelError = ref('')
const capabilities = ref<RuntimeCapabilities | null>(null)
const catalog = ref<LocalModelCatalog>({ rootPath: '', models: [] })

const selectedLlm = computed(() => catalog.value.models.find((model) => model.category === 'LLM' && model.selected))
const triggerText = computed(() => selectedLlm.value ? `AI：${selectedLlm.value.name}` : 'AI：本地模型')
const capabilitySummary = computed(() => {
  if (!capabilities.value) return '正在查询 Linux 本地 Runtime…'
  const relevant: RuntimeCapabilityName[] = ['asr', 'ocr', 'llm']
  const unavailable = relevant
    .map((name) => capabilities.value?.[name])
    .filter((item) => item && item.state !== 'AVAILABLE')
  if (!unavailable.length) return '本地 ASR / OCR / LLM Runtime 可用'
  return unavailable.map((item) => `${item?.name.toUpperCase()}：${item?.reason || item?.state}`).join('；')
})

function modelsFor(category: ModelCategory) {
  return catalog.value.models.filter((model) => model.category === category)
}

function selectedFor(category: ModelCategory) {
  return catalog.value.models.find((model) => model.category === category && model.selected)
}

function modelState(model: LocalModelDescriptor) {
  if (model.runtimeReady) return '可运行'
  if (model.complete === false || model.compatibility === 'INCOMPLETE') return '文件不完整'
  if (model.compatibility === 'PLATFORM_MISMATCH') return '平台不匹配'
  if (model.compatibility === 'UNREADABLE') return '文件不可读'
  if (model.compatibility === 'UNSUPPORTED') return '平台未知'
  return model.selected ? '已选择 · Runtime 不可用' : 'Runtime 不可用'
}

function formatBytes(value: number) {
  if (!Number.isFinite(value) || value <= 0) return '0 B'
  const units = ['B', 'KB', 'MB', 'GB', 'TB']
  const index = Math.min(Math.floor(Math.log(value) / Math.log(1024)), units.length - 1)
  const amount = value / (1024 ** index)
  return `${amount >= 100 || index === 0 ? amount.toFixed(0) : amount.toFixed(1)} ${units[index]}`
}

function formatDate(value: number) {
  if (!value) return '时间未知'
  return new Intl.DateTimeFormat('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit' }).format(new Date(value))
}

async function loadModels(rescan = false) {
  modelLoading.value = true
  modelError.value = ''
  try {
    capabilities.value = await fetchRuntimeCapabilities(rescan)
    catalog.value = await fetchLocalModels(rescan)
  } catch (e) {
    modelError.value = backendErrorMessage(e)
  } finally {
    modelLoading.value = false
  }
}

async function show() {
  open.value = true
  await loadModels()
}

async function chooseModel(category: ModelCategory, modelId?: string) {
  modelAction.value = `select-${category}`
  modelError.value = ''
  try {
    catalog.value = await selectLocalModel(category, modelId)
    capabilities.value = await fetchRuntimeCapabilities(true)
  } catch (e) {
    modelError.value = backendErrorMessage(e)
  } finally {
    modelAction.value = ''
  }
}

async function importModel(category: ModelCategory, source: ModelImportSource) {
  modelAction.value = `import-${category}-${source}`
  modelError.value = ''
  try {
    catalog.value = await importLocalModel(category, source)
    capabilities.value = await fetchRuntimeCapabilities(true)
  } catch (e) {
    if (!(e instanceof RuntimeAdapterError && e.code === 'MODEL_IMPORT_CANCELLED')) {
      modelError.value = backendErrorMessage(e)
    }
  } finally {
    modelAction.value = ''
  }
}

onMounted(() => { void loadModels() })
</script>

<template>
  <button class="ai-settings-trigger" title="本地模型管理" @click="show">
    {{ triggerText }}
  </button>

  <div v-if="open" class="local-model-mask" @click.self="open = false">
    <section class="local-model-panel">
      <header class="local-model-header">
        <div>
          <h2>本地模型</h2>
          <p>AI 仅使用设备本地模型，不提供云端 API、API Key 或自动回退配置。</p>
        </div>
        <button class="close-button" @click="open = false">关闭</button>
      </header>

      <div class="model-manager-toolbar">
        <div>
          <span>模型目录</span>
          <code>{{ catalog.rootPath || '正在读取…' }}</code>
        </div>
        <button :disabled="modelLoading || !!modelAction" @click="loadModels(true)">
          {{ modelLoading ? '扫描中…' : '重新扫描' }}
        </button>
      </div>

      <div class="local-model-note" :class="{ warning: capabilities && capabilitySummary !== '本地 ASR / OCR / LLM Runtime 可用' }">
        {{ capabilitySummary }}
      </div>
      <div v-if="modelAction.startsWith('import-')" class="local-model-note">
        正在导入模型，大文件复制可能需要一些时间。
      </div>
      <div v-if="modelError" class="local-model-note error">{{ modelError }}</div>

      <div class="local-model-scroll">
        <section v-for="category in categories" :key="category.id" class="model-category">
          <header>
            <div>
              <h3>{{ category.label }}</h3>
              <span>{{ modelsFor(category.id).length ? `${modelsFor(category.id).length} 个模型` : '未导入' }}</span>
            </div>
            <div class="model-category-actions">
              <button
                v-if="category.id !== 'ASR' && selectedFor(category.id)"
                :disabled="!!modelAction"
                @click="chooseModel(category.id)"
              >取消选择</button>
              <button :disabled="!!modelAction" @click="importModel(category.id, 'FILE')">导入文件</button>
              <button v-if="category.id !== 'LLM'" :disabled="!!modelAction" @click="importModel(category.id, 'DIRECTORY')">导入目录</button>
            </div>
          </header>

          <div v-if="!modelsFor(category.id).length" class="model-empty">暂无 {{ category.label }} 模型</div>
          <label
            v-for="model in modelsFor(category.id)"
            :key="model.id"
            class="model-row"
            :class="{ selected: model.selected }"
          >
            <input
              type="radio"
              :name="`model-${category.id}`"
              :checked="model.selected"
              :disabled="!!modelAction || ((category.id === 'ASR' || category.id === 'OCR' || category.id === 'LLM') && !model.runtimeReady)"
              @change="chooseModel(category.id, model.id)"
            />
            <span class="model-row-main">
              <strong>{{ model.name }}</strong>
              <span>
                {{ model.sourceKind === 'ASSET' ? '内置' : model.sourceKind === 'DIRECTORY' ? '目录' : '文件' }} ·
                {{ formatBytes(model.sizeBytes) }} · {{ formatDate(model.modifiedAt) }}
                <template v-if="model.archive"> · 压缩包未解压</template>
                <template v-if="model.modelFormat"> · {{ model.modelFormat }}</template>
                <template v-if="model.provider"> · {{ model.provider }}</template>
                <template v-if="model.version"> · {{ model.version }}</template>
                <template v-if="model.targetPlatform"> · {{ model.targetPlatform }}</template>
              </span>
              <code>{{ model.relativePath }}</code>
            </span>
            <span class="model-state" :class="{ ready: model.runtimeReady }">{{ modelState(model) }}</span>
          </label>

          <AsrConsole v-if="category.id === 'ASR'" />
          <OcrConsole v-if="category.id === 'OCR'" />
          <LlmConsole v-if="category.id === 'LLM'" @rescan="loadModels(true)" />
        </section>
      </div>
    </section>
  </div>
</template>

<style scoped>
.ai-settings-trigger { border: 1px solid #557087; border-radius: 8px; background: #17364f; color: #e7f0f8; padding: 7px 11px; max-width: 260px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.local-model-mask { position: fixed; inset: 0; z-index: 1300; display: grid; place-items: center; padding: 22px; background: rgba(10, 24, 38, .58); }
.local-model-panel { width: min(1080px, 96vw); max-height: 92vh; display: flex; flex-direction: column; overflow: hidden; border-radius: 16px; background: #f8fafc; box-shadow: 0 26px 76px rgba(6, 20, 33, .28); }
.local-model-header { display: flex; align-items: flex-start; justify-content: space-between; gap: 18px; padding: 19px 22px 15px; background: #fff; border-bottom: 1px solid #e1e8ee; }
.local-model-header h2 { margin: 0; color: #21384b; font-size: 20px; }
.local-model-header p { margin: 6px 0 0; color: #6b7c89; font-size: 13px; }
.close-button, .model-manager-toolbar button, .model-category-actions button { border: 1px solid #cbd8e2; border-radius: 8px; background: #fff; color: #385268; padding: 8px 12px; }
.model-manager-toolbar { display: flex; align-items: center; justify-content: space-between; gap: 18px; padding: 12px 22px; background: #f5f8fa; border-bottom: 1px solid #e3e9ee; }
.model-manager-toolbar > div { min-width: 0; }
.model-manager-toolbar span { display: block; margin-bottom: 4px; color: #71818d; font-size: 11px; }
.model-manager-toolbar code { display: block; overflow: hidden; color: #3d5668; text-overflow: ellipsis; white-space: nowrap; }
.local-model-note { margin: 12px 22px 0; padding: 9px 12px; border-radius: 8px; background: #eef6fd; color: #365d7c; font-size: 13px; }
.local-model-note.warning { background: #fff7e8; color: #895700; }
.local-model-note.error { background: #fff0f0; color: #a32626; }
.local-model-scroll { min-height: 0; overflow: auto; padding: 14px 22px 24px; }
.model-category { margin-bottom: 16px; border: 1px solid #dce5eb; border-radius: 12px; background: #fff; overflow: hidden; }
.model-category > header { display: flex; align-items: center; justify-content: space-between; gap: 14px; padding: 12px 14px; border-bottom: 1px solid #edf1f4; }
.model-category h3 { margin: 0; color: #294154; font-size: 15px; }
.model-category header span { color: #80909b; font-size: 11px; }
.model-category-actions { display: flex; gap: 7px; flex-wrap: wrap; justify-content: flex-end; }
.model-row { display: grid; grid-template-columns: 22px minmax(0, 1fr) auto; gap: 10px; align-items: center; padding: 11px 14px; border-top: 1px solid #f0f3f5; }
.model-row:first-of-type { border-top: 0; }
.model-row.selected { background: #f4f9ff; }
.model-row-main { min-width: 0; }
.model-row-main strong { display: block; color: #263d50; font-size: 13px; }
.model-row-main > span { display: block; margin: 3px 0; color: #72828e; font-size: 11px; }
.model-row-main code { display: block; overflow: hidden; color: #526979; font-size: 11px; text-overflow: ellipsis; white-space: nowrap; }
.model-state { padding: 4px 7px; border-radius: 999px; background: #f1f3f5; color: #6a7883; font-size: 10px; white-space: nowrap; }
.model-state.ready { background: #e9f7ef; color: #17734b; }
.model-empty { padding: 18px; color: #8b99a4; text-align: center; font-size: 12px; }
button:disabled { opacity: .55; cursor: not-allowed; }
</style>
