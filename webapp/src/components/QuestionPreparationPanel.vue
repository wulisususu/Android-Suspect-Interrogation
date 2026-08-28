<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue'

import type { CaseQuestionCreateInput, StandardQuestion } from '../types/templateInterrogation'

const props = defineProps<{
  library: StandardQuestion[]
  busy: boolean
  voiceAvailable: boolean
  voiceBusy: boolean
  voiceDraft?: string
  voiceError?: string
}>()

const emit = defineEmits<{
  loadLibrary: [category?: string]
  addQuestion: [input: CaseQuestionCreateInput]
  voiceStart: []
  voiceStop: []
}>()

type PreparationMode = 'library' | 'manual' | 'voice'

const mode = ref<PreparationMode>('library')
const category = ref('')
const manualText = ref('')
const regexText = ref('')
const voiceText = ref(props.voiceDraft || '')

watch(() => props.voiceDraft, (value) => {
  if (typeof value === 'string') voiceText.value = value
})

const categories = computed(() => [...new Set(props.library.map((item) => item.category).filter(Boolean))].sort())
const visibleLibrary = computed(() => category.value
  ? props.library.filter((item) => item.category === category.value)
  : props.library)

function parsePatterns(value: string) {
  return value.split(/\n|；|;/).map((item) => item.trim()).filter(Boolean)
}

function addLibraryQuestion(question: StandardQuestion) {
  emit('addQuestion', {
    text: question.text,
    source: 'STANDARD',
    standardQuestionId: question.id,
    regexPatterns: question.regexPatterns,
  })
}

function addManualQuestion() {
  const text = manualText.value.trim()
  if (!text) return
  emit('addQuestion', { text, source: 'CASE', regexPatterns: parsePatterns(regexText.value) })
  manualText.value = ''
  regexText.value = ''
}

function addVoiceQuestion() {
  const text = voiceText.value.trim()
  if (!text) return
  emit('addQuestion', { text, source: 'CASE' })
  voiceText.value = ''
}

function changeCategory() {
  emit('loadLibrary', category.value || undefined)
}

onMounted(() => emit('loadLibrary', undefined))
</script>

<template>
  <section class="question-preparation-panel">
    <header class="question-preparation-header">
      <div>
        <span class="panel-kicker">审讯准备</span>
        <h2>本案问题配置</h2>
      </div>
      <span>开始审讯前可调整</span>
    </header>

    <nav class="preparation-tabs" aria-label="问题准备方式">
      <button :class="{ active: mode === 'library' }" @click="mode = 'library'">问题库</button>
      <button :class="{ active: mode === 'manual' }" @click="mode = 'manual'">手动输入</button>
      <button :class="{ active: mode === 'voice' }" @click="mode = 'voice'">语音输入</button>
    </nav>

    <div v-if="mode === 'library'" class="preparation-body">
      <div class="library-filter">
        <label>分类</label>
        <select v-model="category" :disabled="busy" @change="changeCategory">
          <option value="">全部问题</option>
          <option v-for="item in categories" :key="item" :value="item">{{ item }}</option>
        </select>
      </div>
      <div v-if="visibleLibrary.length" class="question-library-list">
        <article v-for="question in visibleLibrary" :key="question.id">
          <div>
            <strong>{{ question.text }}</strong>
            <span>{{ question.category || '通用' }}</span>
          </div>
          <button :disabled="busy" @click="addLibraryQuestion(question)">加入本案问题</button>
        </article>
      </div>
      <p v-else class="preparation-empty">当前分类暂无可用问题。</p>
    </div>

    <div v-else-if="mode === 'manual'" class="preparation-body manual-preparation">
      <label>
        <span>问题文本</span>
        <textarea v-model="manualText" rows="2" placeholder="例如：你第一次到达案发现场是什么时间？"></textarea>
      </label>
      <label>
        <span>匹配规则（可选，每行一条）</span>
        <textarea v-model="regexText" rows="2" placeholder="什么时候.*到.*现场"></textarea>
      </label>
      <button class="primary" :disabled="busy || !manualText.trim()" @click="addManualQuestion">加入本案问题</button>
    </div>

    <div v-else class="preparation-body voice-preparation">
      <div class="voice-preparation-status">
        <strong>离线语音输入</strong>
        <p v-if="voiceAvailable">录音识别结束后，文本只进入下方编辑框；确认后再加入正式问题。</p>
        <p v-else>准备阶段离线听写 Runtime 尚未启用。当前不会调用正式审讯录音链路，避免在会话开始前产生无效采集。</p>
      </div>
      <div class="voice-buttons">
        <button :disabled="!voiceAvailable || voiceBusy" @click="emit('voiceStart')">开始语音输入</button>
        <button :disabled="!voiceAvailable || !voiceBusy" @click="emit('voiceStop')">停止并识别</button>
      </div>
      <p v-if="voiceError" class="inline-error">{{ voiceError }}</p>
      <label>
        <span>识别后可人工修订</span>
        <textarea v-model="voiceText" rows="3" placeholder="语音识别文本会出现在这里，也可以直接手动输入"></textarea>
      </label>
      <button class="primary" :disabled="busy || !voiceText.trim()" @click="addVoiceQuestion">加入本案问题</button>
    </div>
  </section>
</template>
