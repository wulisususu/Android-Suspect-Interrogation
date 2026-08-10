<script setup lang="ts">
import { nextTick, ref, watch } from 'vue'
import type { TranscriptMessage } from '../types/interrogation'

const props = defineProps<{
  messages: TranscriptMessage[]
  streaming: boolean
  error?: string
}>()
const emit = defineEmits<{ send: [text: string] }>()

const draft = ref('')
const scroller = ref<HTMLElement | null>(null)

watch(
  () => props.messages.map((item) => item.text).join('|'),
  async () => {
    await nextTick()
    scroller.value?.scrollTo({ top: scroller.value.scrollHeight, behavior: 'smooth' })
  },
)

function submit() {
  const text = draft.value.trim()
  if (!text || props.streaming) return
  emit('send', text)
  draft.value = ''
}
</script>

<template>
  <section class="panel transcript-panel">
    <header class="panel-header">
      <strong>实时问答 / 审讯记录</strong>
      <div class="panel-actions">
        <button class="ghost-button">标记矛盾</button>
        <button class="ghost-button">查看版本</button>
      </div>
    </header>

    <div ref="scroller" class="transcript-list">
      <article
        v-for="(message, index) in messages"
        :key="message.id"
        class="qa-row"
        :data-speaker="message.speaker"
      >
        <div class="qa-index">{{ message.speaker === '民警' ? `Q${index + 1}` : message.speaker === '嫌疑人' ? `A${index + 1}` : 'AI' }}</div>
        <div class="qa-content">
          <strong>{{ message.speaker }}：</strong>
          <span>{{ message.text || (message.streaming ? '正在接收 SSE…' : '') }}</span>
          <span v-if="message.streaming" class="typing-dot">●</span>
        </div>
      </article>
      <div v-if="error" class="error-box">{{ error }}</div>
    </div>

    <footer class="composer">
      <textarea
        v-model="draft"
        placeholder="输入审讯问题；Ctrl/⌘ + Enter 发送"
        @keydown.ctrl.enter.prevent="submit"
        @keydown.meta.enter.prevent="submit"
      />
      <button class="primary-button" :disabled="!draft.trim() || streaming" @click="submit">
        {{ streaming ? 'SSE 输出中…' : '发送' }}
      </button>
    </footer>
  </section>
</template>
