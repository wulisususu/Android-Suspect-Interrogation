<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref } from 'vue'
import { fetchReadiness, type ReadinessResponse } from '../api/health'

const phase = ref<'checking' | 'ready' | 'maintenance'>('checking')
const snapshot = ref<ReadinessResponse | null>(null)
const error = ref('')
let timer: number | undefined

const problemDetails = computed(() => {
  if (!snapshot.value) return []
  return Object.entries(snapshot.value.checks)
    .filter(([, item]) => item.required && item.state !== 'READY')
    .map(([name, item]) => `${name}: ${item.detail}`)
})

async function refresh() {
  const controller = new AbortController()
  const timeout = window.setTimeout(() => controller.abort(), 3000)
  try {
    const next = await fetchReadiness(controller.signal)
    snapshot.value = next
    error.value = ''
    phase.value = next.status === 'ready' ? 'ready' : 'maintenance'
  } catch (cause) {
    phase.value = 'maintenance'
    error.value = cause instanceof Error ? cause.message : '后端服务暂不可用'
  } finally {
    window.clearTimeout(timeout)
  }
}

onMounted(() => {
  void refresh()
  timer = window.setInterval(() => void refresh(), 5000)
})

onUnmounted(() => {
  if (timer !== undefined) window.clearInterval(timer)
})
</script>

<template>
  <slot v-if="phase === 'ready'" />
  <main v-else class="maintenance-shell" role="status" aria-live="polite">
    <section class="maintenance-card">
      <p class="maintenance-kicker">Linux Kiosk</p>
      <h1>{{ phase === 'checking' ? '系统正在启动' : '系统维护中' }}</h1>
      <p v-if="phase === 'checking'">正在检查本地后端、数据库与存储状态，请稍候。</p>
      <template v-else>
        <p>页面本身工作正常，但本地后端尚未达到可用状态。系统会自动重试。</p>
        <ul v-if="problemDetails.length" class="maintenance-details">
          <li v-for="item in problemDetails" :key="item">{{ item }}</li>
        </ul>
        <p v-else-if="error" class="maintenance-details">{{ error }}</p>
        <button type="button" @click="refresh">立即重试</button>
      </template>
    </section>
  </main>
</template>

<style scoped>
.maintenance-shell {
  min-height: 100vh;
  display: grid;
  place-items: center;
  padding: 32px;
  background: #f4f6f8;
  color: #1f2937;
}
.maintenance-card {
  width: min(620px, 100%);
  padding: 40px;
  border-radius: 18px;
  background: #fff;
  box-shadow: 0 18px 50px rgba(15, 23, 42, 0.08);
}
.maintenance-kicker {
  margin: 0 0 8px;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: #64748b;
}
h1 { margin: 0 0 16px; font-size: 30px; }
p { line-height: 1.7; }
.maintenance-details { color: #b45309; line-height: 1.6; }
button {
  margin-top: 12px;
  border: 0;
  border-radius: 10px;
  padding: 11px 18px;
  background: #111827;
  color: #fff;
  cursor: pointer;
}
</style>
