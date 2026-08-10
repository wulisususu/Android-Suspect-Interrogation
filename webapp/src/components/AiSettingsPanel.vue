<script setup lang="ts">
import { computed, reactive, ref } from 'vue'
import { backendErrorMessage, fetchAiSettings, updateAiSettings } from '../api/interrogation'
import { isNativeBusinessRuntime } from '../native/rpcBridge'
import type { AiMode, AiRuntimeStatus } from '../types/interrogation'

const open = ref(false)
const loading = ref(false)
const saving = ref(false)
const error = ref('')
const status = ref<AiRuntimeStatus | null>(null)
const apiKey = ref('')

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
  if (!native.value) return '浏览器联调'
  if (!status.value) return 'AI未加载'
  if (status.value.activeProvider === 'CLOUD_ZHIPU') return '智谱 API'
  if (status.value.activeProvider === 'LOCAL') return '本地模型'
  return 'AI不可用'
})

async function load() {
  if (!native.value) return
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

async function show() {
  open.value = true
  await load()
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
</script>

<template>
  <button class="ai-settings-trigger" :title="native ? '切换 AI 推理路由' : '仅 APK 内可配置'" @click="show">
    AI：{{ providerText }}
  </button>

  <div v-if="open" class="ai-settings-mask" @click.self="open = false">
    <section class="ai-settings-panel">
      <header>
        <div>
          <h2>AI 推理设置</h2>
          <p>构建后的 APK 可在智谱 API 与本地模型之间运行时切换，无需重新打包。</p>
        </div>
        <button @click="open = false">关闭</button>
      </header>

      <div v-if="!native" class="ai-settings-note warning">
        当前是浏览器联调环境。AI 路由设置只保存在 Android APK 内。
      </div>
      <div v-else-if="loading" class="ai-settings-note">正在读取 Android AI 配置…</div>

      <div v-if="native && status" class="ai-status-grid">
        <div><span>当前模式</span><strong>{{ status.settings.mode }}</strong></div>
        <div><span>实际路由</span><strong>{{ status.activeProvider }}</strong></div>
        <div><span>智谱 API</span><strong>{{ status.cloudConfigured ? '已配置' : '未配置 Key' }}</strong></div>
        <div><span>本地模型</span><strong>{{ status.localAvailable ? '可用' : '尚未接入' }}</strong></div>
      </div>

      <form v-if="native" class="ai-settings-form" @submit.prevent="save">
        <label>
          <span>推理模式</span>
          <select v-model="form.mode">
            <option value="CLOUD">云端 API（智谱）</option>
            <option value="LOCAL">本地模型</option>
            <option value="AUTO">自动：本地优先，失败前置检查后走云端</option>
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
            :placeholder="status?.settings.apiKeyConfigured ? '已安全保存；留空则保持原 Key' : '请输入 API Key'"
          />
          <small>Key 使用 Android Keystore 加密保存，读取设置时不会回显明文。</small>
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
          强制离线模式下，本地模型不可用时会直接报错，不会把审讯内容发送到智谱 API。
        </div>
        <div v-if="form.mode === 'LOCAL' && status && !status.localAvailable" class="ai-settings-note warning">
          本地模型 Provider 接口已存在，但 JNI / RKNN / llama.cpp Runtime 尚未接入，因此现在切到 LOCAL 会明确报错。
        </div>
        <div v-if="error" class="ai-settings-note error">{{ error }}</div>

        <footer>
          <button type="button" class="danger-light" :disabled="saving || !status?.settings.apiKeyConfigured" @click="clearKey">清除 API Key</button>
          <button type="submit" class="session-primary" :disabled="saving">{{ saving ? '保存中…' : '保存并立即切换' }}</button>
        </footer>
      </form>
    </section>
  </div>
</template>
