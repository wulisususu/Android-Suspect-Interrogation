<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { createCase, fetchCases } from '../api/interrogation'
import { backendErrorMessage } from '../api/interrogation'

interface CaseRow {
  id: string
  suspectName: string
  gender?: string
  age?: string
  officerName: string
  state: string
  stage: string
  createdAt?: number
  updatedAt?: number
}

const stateTextMap: Record<string, string> = {
  DRAFT: '草稿',
  INTERROGATING: '审讯中',
  REVIEWING: '复核中',
  SIGNING: '签名中',
  COMPLETED: '已完成',
  ARCHIVED: '已归档',
}
const stageTextMap: Record<string, string> = {
  IDENTITY: '身份核验',
  STATEMENT: '案情陈述',
  FOLLOW_UP: '重点追问',
  SIGNING: '确认签名',
}

const emit = defineEmits<{ open: [caseId: string] }>()

const loading = ref(true)
const error = ref('')
const cases = ref<CaseRow[]>([])
const creating = ref(false)

function fmtTime(ts?: number) {
  if (!ts) return ''
  const d = new Date(ts)
  const pad = (n: number) => String(n).padStart(2, '0')
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
}

async function load() {
  loading.value = true
  error.value = ''
  try {
    cases.value = await fetchCases(50)
  } catch (err) {
    error.value = backendErrorMessage(err)
  } finally {
    loading.value = false
  }
}

async function newCase() {
  creating.value = true
  try {
    const created = await createCase({ officerName: '当前警官' })
    emit('open', created.id)
  } catch (err) {
    error.value = backendErrorMessage(err)
  } finally {
    creating.value = false
  }
}

onMounted(load)
</script>

<template>
  <main class="case-list-page">
    <header class="topbar">
      <div class="case-meta">
        <div>
          <h1>嫌疑人询问系统</h1>
          <p>案件历史记录</p>
        </div>
        <span class="state-chip">共 {{ cases.length }} 起</span>
      </div>
      <div class="operator-meta">
        <button class="btn-primary" :disabled="creating" @click="newCase">
          {{ creating ? '创建中…' : '＋ 新建询问' }}
        </button>
      </div>
    </header>

    <div v-if="loading" class="demo-banner">正在加载案件历史…</div>
    <div v-else-if="error" class="feedback-banner error">{{ error }}</div>
    <div v-else-if="!cases.length" class="demo-banner">暂无案件记录，点击右上角“新建询问”开始。</div>

    <section v-else class="case-list">
      <article v-for="item in cases" :key="item.id" class="case-card" @click="emit('open', item.id)">
        <div class="case-card-main">
          <div class="case-card-title">
            <span class="suspect-name">{{ item.suspectName }}</span>
            <span v-if="item.gender || item.age" class="suspect-meta">
              {{ item.gender || '' }} {{ item.age ? `${item.age}岁` : '' }}
            </span>
          </div>
          <div class="case-card-sub">
            <span>主审：{{ item.officerName }}</span>
            <span>案号：{{ item.id }}</span>
            <span v-if="item.updatedAt">更新：{{ fmtTime(item.updatedAt) }}</span>
          </div>
        </div>
        <div class="case-card-tags">
          <span class="tag">{{ stageTextMap[item.stage] || item.stage }}</span>
          <span class="tag" :class="item.state">{{ stateTextMap[item.state] || item.state }}</span>
          <span class="arrow">›</span>
        </div>
      </article>
    </section>
  </main>
</template>

<style scoped>
.case-list-page {
  max-width: 960px;
  margin: 0 auto;
  padding: 16px;
}
.topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  border-radius: 12px;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
  margin-bottom: 16px;
}
.topbar h1 { margin: 0; font-size: 20px; }
.topbar p { margin: 2px 0 0; color: #888; font-size: 13px; }
.state-chip {
  background: #e8f0fe; color: #1a56db; border-radius: 999px;
  padding: 4px 12px; font-size: 13px; font-weight: 600;
}
.btn-primary {
  background: #1a56db; color: #fff; border: none; border-radius: 8px;
  padding: 8px 16px; font-size: 14px; cursor: pointer;
}
.btn-primary:disabled { opacity: 0.6; cursor: not-allowed; }
.demo-banner, .feedback-banner {
  padding: 16px; border-radius: 10px; text-align: center; font-size: 14px;
  background: #f2f6ff; color: #555; margin-bottom: 12px;
}
.feedback-banner.error { background: #fdecec; color: #c0392b; }
.case-list { display: flex; flex-direction: column; gap: 10px; }
.case-card {
  display: flex; justify-content: space-between; align-items: center;
  background: #fff; border-radius: 12px; padding: 14px 16px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08); cursor: pointer;
  transition: box-shadow 0.15s ease;
}
.case-card:hover { box-shadow: 0 3px 10px rgba(0, 0, 0, 0.14); }
.case-card-title { display: flex; align-items: baseline; gap: 8px; }
.suspect-name { font-size: 17px; font-weight: 700; }
.suspect-meta { color: #888; font-size: 13px; }
.case-card-sub { margin-top: 4px; display: flex; gap: 14px; color: #999; font-size: 12px; }
.case-card-tags { display: flex; align-items: center; gap: 8px; }
.tag {
  background: #f2f6ff; color: #1a56db; border-radius: 999px;
  padding: 3px 10px; font-size: 12px;
}
.tag.INTERROGATING { background: #fff4e5; color: #b45309; }
.tag.REVIEWING { background: #e6f9f0; color: #047857; }
.tag.COMPLETED { background: #e6f9f0; color: #047857; }
.tag.DRAFT { background: #f3f4f6; color: #6b7280; }
.arrow { color: #ccc; font-size: 20px; }
</style>
