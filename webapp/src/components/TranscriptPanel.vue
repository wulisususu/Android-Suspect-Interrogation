<script setup lang="ts">
import { nextTick, ref, watch } from 'vue'
import type { TranscriptMessage } from '../types/interrogation'

const props = defineProps<{
  messages: TranscriptMessage[]
  streaming: boolean
  canRecord: boolean
  error?: string
}>()
const emit = defineEmits<{
  send: [text: string]
  edit: [messageId: string, text: string]
  mark: [messageId: string]
  versions: [messageId?: string]
  markLatest: []
}>()

const draft = ref('')
const scroller = ref<HTMLElement | null>(null)
const editingId = ref('')
const editingText = ref('')

watch(
  () => props.messages.map((item) => item.text).join('|'),
  async () => {
    await nextTick()
    scroller.value?.scrollTo({ top: scroller.value.scrollHeight, behavior: 'smooth' })
  },
)

function submit() {
  const text = draft.value.trim()
  if (!text || props.streaming || !props.canRecord) return
  emit('send', text)
  draft.value = ''
}

function startEdit(message: TranscriptMessage) {
  editingId.value = message.id
  editingText.value = message.text
}

function saveEdit() {
  const text = editingText.value.trim()
  if (!editingId.value || !text) return
  emit('edit', editingId.value, text)
  editingId.value = ''
  editingText.value = ''
}
</script>

<template>
  <section class="panel transcript-panel">
    <header class="panel-header">
      <strong>实时问答 / 审讯记录</strong>
      <div class="panel-actions">
        <button class="ghost-button" @click="$emit('markLatest')">标记最新矛盾</button>
        <button class="ghost-button" @click="$emit('versions')">查看版本</button>
      </div>
    </header>

    <div ref="scroller" class="transcript-list">
      <article
        v-for="message in messages"
        :key="message.id"
        class="qa-row"
        :data-speaker="message.speaker"
        :data-mark="message.mark || ''"
      >
        <div class="qa-index">
          {{ message.speaker === '民警' ? `Q${message.seq || ''}` : message.speaker === '嫌疑人' ? `A${message.seq || ''}` : 'AI' }}
        </div>
        <div class="qa-content">
          <div class="qa-toolbar">
            <strong>{{ message.speaker }}：</strong>
            <span v-if="message.mark === 'conflict'" class="record-mark conflict">存在矛盾</span>
            <div v-if="message.speaker !== 'AI'" class="message-actions">
              <button @click="startEdit(message)">编辑</button>
              <button @click="$emit('mark', message.id)">标记</button>
              <button @click="$emit('versions', message.id)">版本</button>
            </div>
          </div>

          <div v-if="editingId === message.id" class="inline-editor">
            <textarea v-model="editingText" />
            <div>
              <button class="primary-small" @click="saveEdit">保存修订</button>
              <button @click="editingId = ''">取消</button>
            </div>
          </div>
          <template v-else>
            <span>{{ message.text || (message.streaming ? '正在接收 SSE…' : '') }}</span>
            <span v-if="message.streaming" class="typing-dot">●</span>
          </template>
        </div>
      </article>
      <div v-if="error" class="error-box">{{ error }}</div>
      <div v-if="!messages.length" class="empty-box">暂无正式问答。开始审讯后发送第一条问题。</div>
    </div>

    <footer class="composer">
      <textarea
        v-model="draft"
        :placeholder="canRecord ? '输入审讯问题；Ctrl/⌘ + Enter 发送' : '请先开始审讯；暂停状态下不能新增正式问答'"
        :disabled="!canRecord"
        @keydown.ctrl.enter.prevent="submit"
        @keydown.meta.enter.prevent="submit"
      />
      <button class="primary-button" :disabled="!draft.trim() || streaming || !canRecord" @click="submit">
        {{ streaming ? 'SSE 输出中…' : '发送并落库' }}
      </button>
    </footer>
  </section>
</template>
