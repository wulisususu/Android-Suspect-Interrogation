<script setup lang="ts">
import { computed, ref } from 'vue'
import { backendErrorMessage, fetchRuntimeCapabilities } from '../api/interrogation'
import type { RuntimeCapabilities, RuntimeCapability } from '../runtime'

const open = ref(false)
const loading = ref(false)
const error = ref('')
const capabilities = ref<RuntimeCapabilities | null>(null)
const entries = computed(() => capabilities.value
  ? Object.values(capabilities.value).filter((item) => ['asr', 'ocr', 'llm', 'recording'].includes(item.name))
  : [])
const triggerText = computed(() => capabilities.value?.llm.state === 'AVAILABLE' ? 'AI：本地 Runtime 可用' : 'AI：本地模型')

function stateText(item: RuntimeCapability) { return item.state === 'AVAILABLE' ? '可用' : item.reason || item.state }
async function load(force = false) {
  loading.value = true; error.value = ''
  try { capabilities.value = await fetchRuntimeCapabilities(force) }
  catch (cause) { error.value = backendErrorMessage(cause) }
  finally { loading.value = false }
}
async function show() { open.value = true; await load() }
</script>

<template>
  <button class="ai-settings-trigger" title="本地 AI Runtime 状态" @click="show">{{ triggerText }}</button>
  <div v-if="open" class="runtime-mask" @click.self="open = false">
    <section class="runtime-panel">
      <header><div><h2>本地 AI Runtime</h2><p>仅显示 RK3588 当前已部署的离线能力。</p></div><button @click="open = false">关闭</button></header>
      <div class="runtime-toolbar"><span>不提供浏览器内模型扫描、导入、切换或旧控制台测试。</span><button :disabled="loading" @click="load(true)">{{ loading ? '刷新中…' : '刷新状态' }}</button></div>
      <p v-if="error" class="runtime-error">{{ error }}</p>
      <div v-else-if="loading && !capabilities" class="runtime-empty">正在读取 Runtime 状态…</div>
      <div v-else class="runtime-list"><article v-for="item in entries" :key="item.name" :class="{ available: item.state === 'AVAILABLE' }"><strong>{{ item.name.toUpperCase() }}</strong><span>{{ stateText(item) }}</span></article></div>
    </section>
  </div>
</template>

<style scoped>
.ai-settings-trigger { border: 1px solid #557087; border-radius: 8px; background: #17364f; color: #e7f0f8; padding: 7px 11px; max-width: 260px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.runtime-mask { position: fixed; inset: 0; z-index: 1300; display: grid; place-items: center; padding: 22px; background: rgba(10, 24, 38, .58); }.runtime-panel { width: min(660px, 96vw); border-radius: 16px; overflow: hidden; background: #f8fafc; box-shadow: 0 26px 76px rgba(6, 20, 33, .28); }.runtime-panel header, .runtime-toolbar { display: flex; align-items: center; justify-content: space-between; gap: 18px; padding: 18px 22px; background: #fff; border-bottom: 1px solid #e1e8ee; }.runtime-panel h2 { margin: 0; color: #21384b; font-size: 20px; }.runtime-panel p { margin: 6px 0 0; color: #6b7c89; font-size: 13px; }button { border: 1px solid #cbd8e2; border-radius: 8px; background: #fff; color: #385268; padding: 8px 12px; }.runtime-toolbar { padding: 12px 22px; color: #587082; font-size: 13px; }.runtime-list { display: grid; gap: 10px; padding: 18px 22px 24px; }.runtime-list article { display: flex; justify-content: space-between; gap: 16px; padding: 12px 14px; border: 1px solid #dce5eb; border-radius: 9px; color: #7d5a12; background: #fff8e8; }.runtime-list article.available { color: #17734b; background: #e9f7ef; }.runtime-error, .runtime-empty { margin: 18px 22px 24px; padding: 12px; border-radius: 8px; background: #fff0f0; color: #a32626; }.runtime-empty { background: #eef6fd; color: #365d7c; }
</style>
