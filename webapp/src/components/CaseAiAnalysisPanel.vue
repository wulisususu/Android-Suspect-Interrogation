<script setup lang="ts">
import type { CaseAiAnalysis } from '../types/interrogation'

defineProps<{
  caseId: string
  analyses: CaseAiAnalysis[]
  busy: boolean
  error: string
}>()
defineEmits<{ generate: [] }>()

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
    <article v-if="analyses[0]" class="case-ai-result">
      <div><strong>{{ analyses[0].model }}</strong><span>{{ analyses[0].provider }} · {{ time(analyses[0].createdAt) }}</span></div>
      <p>{{ analyses[0].text }}</p>
    </article>
    <p v-else class="case-ai-empty">尚未生成本案推理。没有正式嫌疑人回答时，系统会直接提示数据不足，不会调用模型补写内容。</p>
  </section>
</template>
