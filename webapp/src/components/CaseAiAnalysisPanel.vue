<script setup lang="ts">
import { computed } from 'vue'
import type { CaseAiAnalysis } from '../types/interrogation'

const props = defineProps<{
  caseId: string
  analyses: CaseAiAnalysis[]
  busy: boolean
  error: string
}>()
defineEmits<{ generate: [] }>()

const currentAnalysis = computed(() => props.analyses.find((item) => item.caseId === props.caseId))

function time(value: number) {
  return new Date(value).toLocaleString('zh-CN', { hour12: false })
}
</script>

<template>
  <section class="case-ai-panel">
    <header>
      <div>
        <h2>本案 AI 推理</h2>
        <p>仅使用案件 {{ caseId }} 的正式数据库记录；结果按当前案件保存。</p>
      </div>
      <button class="session-primary" :disabled="busy" @click="$emit('generate')">
        {{ busy ? '正在分析本案…' : '生成本案 AI 推理' }}
      </button>
    </header>
    <p v-if="error" class="case-ai-error">{{ error }}</p>
    <article v-if="currentAnalysis" class="case-ai-result">
      <div><strong>{{ currentAnalysis.model }}</strong><span>{{ currentAnalysis.provider }} · {{ time(currentAnalysis.createdAt) }}</span></div>
      <p>{{ currentAnalysis.text }}</p>
    </article>
    <p v-else class="case-ai-empty">尚未生成本案推理。没有正式嫌疑人回答时，系统会直接提示数据不足，不会调用模型补写内容。</p>
  </section>
</template>
