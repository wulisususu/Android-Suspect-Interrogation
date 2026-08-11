<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue'
import {
  backendErrorMessage,
  fetchAiSettings,
  fetchLocalModels,
  importLocalModel,
  selectLocalModel,
  updateAiSettings,
} from '../api/interrogation'
import { isNativeBusinessRuntime, NativeRpcError } from '../native/rpcBridge'
import AsrConsole from './AsrConsole.vue'
import OcrConsole from './OcrConsole.vue'
import type {
  AiMode,
  AiRuntimeStatus,
  LocalModelCatalog,
  ModelCategory,
  ModelImportSource,
} from '../types/interrogation'

type SettingsTab = 'runtime' | 'models'

const categories: Array<{ id: ModelCategory; label: string }> = [
  { id: 'ASR', label: 'ASR 语音识别' },
  { id: 'OCR', label: 'OCR 图文识别' },
  { id: 'SPEAKER', label: 'Speaker 声纹识别' },
  { id: 'VAD', label: 'VAD 语音活动检测' },
  { id: 'LLM', label: 'LLM 语言模型' },
]

const open = ref(false)
const activeTab = ref<SettingsTab>('runtime')
const loading = ref(false)
const saving = ref(false)
const error = ref('')
const status = ref<AiRuntimeStatus | null>(null)
const apiKey = ref('')
const modelLoading = ref(false)
const modelAction = ref('')
const modelError = ref('')
const catalog = ref<LocalModelCatalog>({ rootPath: '', models: [] })

const form = reactive({
  mode: 'CLOUD' as AiMode,
  cloudBaseUrl: 'https://open.bigmodel.cn/api/paas/v4/chat/completions',
  cloudModel: 'glm-4.7',
  stream: true,
  thinkingEnabled: true,
  maxTokens: 65536,
  temperature: 1.0,
})

const native = computed(() => isNativeBusinessRuntime())
const providerText = computed(() => {
  if (!status.value) return 'AI未加载'
  if (status.value.activeProvider === 'CLOUD_ZHIPU') return '智谱 API'
  if (status.value.activeProvider === 'LOCAL') return '本地模型'
  return 'AI不可用'
})
const localStatusText = computed(() => {
  if (!status.value) return '未读取'
  if (status.value.localAvailable) return status.value.localModel || '可用'
  if (status.value.localModel) return `${status.value.localModel}（运行时待接入）`
  return '未选择 LLM'
})

function modelsFor(category: ModelCategory) {
  return catalog.value.models.filter((model) => model.category === category)
}

function selectedFor(category: ModelCategory) {
  return catalog.value.models.find((model) => model.category === category && model.selected)
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

async function load() {
  loading.value = true
  error.value = ''
  try {
    status.value = await fetchAiSettings()
    Object.assign(form, status.value.settings)
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    loading.value = false
  }
}

async function loadModels(rescan = false) {
  modelLoading.value = true
  modelError.value = ''
  try {
    catalog.value = await fetchLocalModels(rescan)
  } catch (e) {
    modelError.value = backendErrorMessage(e)
  } finally {
    modelLoading.value = false
  }
}

async function show() {
  open.value = true
  await Promise.all([load(), loadModels()])
}

async function save() {
  saving.value = true
  error.value = ''
  try {
    status.value = await updateAiSettings({
      mode: form.mode,
      cloudBaseUrl: form.cloudBaseUrl,
      cloudModel: form.cloudModel,
      stream: form.stream,
      thinkingEnabled: form.thinkingEnabled,
      maxTokens: Number(form.maxTokens),
      temperature: Number(form.temperature),
      apiKey: apiKey.value.trim() || undefined,
    })
    apiKey.value = ''
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    saving.value = false
  }
}

async function clearKey() {
  saving.value = true
  error.value = ''
  try {
    status.value = await updateAiSettings({ clearApiKey: true })
    apiKey.value = ''
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    saving.value = false
  }
}

async function chooseModel(category: ModelCategory, modelId?: string) {
  modelAction.value = `select-${category}`
  modelError.value = ''
  try {
    catalog.value = await selectLocalModel(category, modelId)
    status.value = await fetchAiSettings()
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
  } catch (e) {
    if (!(e instanceof NativeRpcError && e.code === 'MODEL_IMPORT_CANCELLED')) {
      modelError.value = backendErrorMessage(e)
    }
  } finally {
    modelAction.value = ''
  }
}

onMounted(() => Promise.all([load(), loadModels()]))
</script>

<template>
  <button class="ai-settings-trigger" title="AI 设置与本地模型管理" @click="show">
    AI：{{ providerText }}
  </button>

  <div v-if="open" class="ai-settings-mask" @click.self="open = false">
    <section class="ai-settings-panel">
      <header>
        <div>
          <h2>AI 设置与模型管理</h2>
          <p>云端 API 与设备本地模型统一配置。</p>
        </div>
        <button @click="open = false">关闭</button>
      </header>

      <nav class="ai-settings-tabs" aria-label="AI 设置视图">
        <button :class="{ active: activeTab === 'runtime' }" @click="activeTab = 'runtime'">推理设置</button>
        <button :class="{ active: activeTab === 'models' }" @click="activeTab = 'models'">本地模型</button>
      </nav>

      <template v-if="activeTab === 'runtime'">
        <div v-if="!native" class="ai-settings-note warning">
          Windows 联调使用本机 backend-dev；本地模型管理仅在 Android APK 中启用。
        </div>
        <div v-if="loading" class="ai-settings-note">正在读取 AI 配置…</div>
        <div v-if="error" class="ai-settings-note error">{{ error }}</div>

        <div v-if="status" class="ai-status-grid">
          <div><span>当前模式</span><strong>{{ status.settings.mode }}</strong></div>
          <div><span>实际路由</span><strong>{{ status.activeProvider }}</strong></div>
          <div><span>智谱 API</span><strong>{{ status.cloudConfigured ? '已配置' : '未配置 Key' }}</strong></div>
          <div><span>本地模型</span><strong>{{ localStatusText }}</strong></div>
        </div>

        <form v-if="status" class="ai-settings-form" @submit.prevent="save">
          <label>
            <span>推理模式</span>
            <select v-model="form.mode">
              <option value="CLOUD">云端 API（智谱）</option>
              <option value="LOCAL">本地模型</option>
              <option value="AUTO">自动：本地优先，失败后走云端</option>
              <option value="OFFLINE_ONLY">强制离线：绝不走云端</option>
            </select>
          </label>

          <div class="ai-two-columns">
            <label>
              <span>API 地址</span>
              <input v-model.trim="form.cloudBaseUrl" type="url" autocomplete="off" />
            </label>
            <label>
              <span>模型</span>
              <input v-model.trim="form.cloudModel" type="text" autocomplete="off" />
            </label>
          </div>

          <label>
            <span>智谱 API Key</span>
            <input
              v-model="apiKey"
              type="password"
              autocomplete="new-password"
              :placeholder="status.settings.apiKeyConfigured ? '已安全保存；留空则保持原 Key' : '请输入 API Key'"
            />
            <small v-if="native">Key 使用 Android Keystore 加密保存，读取设置时不会回显明文。</small>
            <small v-else>Key 仅保存在本机 backend-dev 开发数据库中，页面不会回显明文。</small>
          </label>

          <div class="ai-two-columns">
            <label>
              <span>max_tokens</span>
              <input v-model.number="form.maxTokens" type="number" min="1" max="65536" />
            </label>
            <label>
              <span>temperature</span>
              <input v-model.number="form.temperature" type="number" min="0" max="2" step="0.1" />
            </label>
          </div>

          <div class="ai-checks">
            <label><input v-model="form.thinkingEnabled" type="checkbox" /> thinking.enabled</label>
            <label><input v-model="form.stream" type="checkbox" /> stream</label>
          </div>

          <div v-if="form.mode === 'OFFLINE_ONLY'" class="ai-settings-note warning">
            强制离线模式不会把审讯内容发送到智谱 API。
          </div>
          <div v-if="(form.mode === 'LOCAL' || form.mode === 'OFFLINE_ONLY') && !status.localAvailable" class="ai-settings-note warning">
            {{ status.localModel ? `已选择 ${status.localModel}，推理 Runtime 尚未接入。` : '请先在“本地模型”中导入并选择 LLM。' }}
          </div>

          <footer>
            <button type="button" class="danger-light" :disabled="saving || !status.settings.apiKeyConfigured" @click="clearKey">清除 API Key</button>
            <button type="submit" class="session-primary" :disabled="saving">{{ saving ? '保存中…' : '保存并立即切换' }}</button>
          </footer>
        </form>
      </template>

      <div v-else class="model-manager">
        <div class="model-manager-toolbar">
          <div>
            <span>模型目录</span>
            <code>{{ catalog.rootPath || '正在读取…' }}</code>
          </div>
          <button :disabled="modelLoading || !!modelAction" @click="loadModels(true)">
            {{ modelLoading ? '扫描中…' : '重新扫描' }}
          </button>
        </div>

        <div v-if="!native" class="ai-settings-note warning">
          请在 Android APK 中从系统文件管理器导入和选择模型。
        </div>
        <div v-if="modelAction.startsWith('import-')" class="ai-settings-note">
          正在导入模型，大文件复制需要一些时间，请保持当前页面开启。
        </div>
        <div v-if="modelError" class="ai-settings-note error">{{ modelError }}</div>

        <section v-for="category in categories" :key="category.id" class="model-category">
          <header>
            <div>
              <h3>{{ category.label }}</h3>
              <span>{{ modelsFor(category.id).length ? `${modelsFor(category.id).length} 个模型` : '未导入' }}</span>
            </div>
            <div class="model-category-actions">
              <button
                v-if="category.id !== 'ASR' && selectedFor(category.id)"
                :disabled="!native || !!modelAction"
                @click="chooseModel(category.id)"
              >取消选择</button>
              <button :disabled="!native || !!modelAction" @click="importModel(category.id, 'FILE')">导入文件</button>
              <button :disabled="!native || !!modelAction" @click="importModel(category.id, 'DIRECTORY')">导入目录</button>
            </div>
          </header>

          <div v-if="!modelsFor(category.id).length" class="model-empty">
            暂无 {{ category.label }} 模型
          </div>
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
              :disabled="!native || !!modelAction || ((category.id === 'ASR' || category.id === 'OCR') && !model.runtimeReady)"
              @change="chooseModel(category.id, model.id)"
            />
            <span class="model-row-main">
              <strong>{{ model.name }}</strong>
              <span>
                {{ model.sourceKind === 'ASSET' ? '内置' : model.sourceKind === 'DIRECTORY' ? '目录' : '文件' }} · {{ formatBytes(model.sizeBytes) }} · {{ formatDate(model.modifiedAt) }}
                <template v-if="model.archive"> · 压缩包未解压</template>
                <template v-if="model.modelFormat"> · {{ model.modelFormat }}</template>
                <template v-if="model.provider"> · {{ model.provider }}</template>
                <template v-if="model.version"> · {{ model.version }}</template>
              </span>
              <code>{{ model.relativePath }}</code>
            </span>
            <span class="model-state" :class="{ ready: model.runtimeReady }">
              {{ model.runtimeReady ? '可运行' : model.complete === false ? '文件不完整' : model.selected ? '已选择 · Runtime 待接入' : 'Runtime 未接入' }}
            </span>
          </label>
          <AsrConsole v-if="category.id === 'ASR'" />
          <OcrConsole v-if="category.id === 'OCR'" />
        </section>
      </div>
    </section>
  </div>
</template>
