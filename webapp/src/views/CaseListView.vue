<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { backendErrorMessage, fetchCase, fetchCases } from '../api/interrogation'
import IdentityIntakeModal from '../components/IdentityIntakeModal.vue'
import { getRuntimeAdapter } from '../runtime'
import type { CaseSummary } from '../types/interrogation'

interface CaseRow extends CaseSummary {}

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
const identityOpen = ref(false)

function fmtTime(ts?: number) {
  if (!ts) return ''
  const d = new Date(ts)
  const pad = (n: number) => String(n).padStart(2, '0')
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
}

function maskedId(idNumber?: string) {
  if (!idNumber) return ''
  if (idNumber.length < 8) return idNumber
  return `${idNumber.slice(0, 3)}***********${idNumber.slice(-4)}`
}

function identitySourceText(source?: string) {
  if (source === 'ID_CARD_READER') return '读卡器身份'
  if (source === 'OCR') return 'OCR 身份'
  if (source === 'MANUAL') return '人工身份'
  return source || ''
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

async function created(item: CaseSummary) {
  identityOpen.value = false
  error.value = ''
  try {
    await getRuntimeAdapter().invoke('identity.confirm', {
      caseId: item.id,
      actorId: item.officerName || '当前警官',
      name: item.suspectName || '',
      idNumber: item.idNumber || '',
      gender: item.gender || '',
      nation: item.nation || '',
      birthDate: item.birthDate || '',
      address: item.address || '',
      source: item.identitySource || 'MANUAL',
    })
    const refreshed = await fetchCase(item.id)
    cases.value = [refreshed, ...cases.value.filter((row) => row.id !== item.id)]
    emit('open', item.id)
  } catch (err) {
    cases.value = [item, ...cases.value.filter((row) => row.id !== item.id)]
    error.value = `案件已创建，但身份绑定未完成：${backendErrorMessage(err)}`
  }
}

onMounted(load)
</script>

<template>
  <main class="case-list-page">
    <header class="case-list-header">
      <div class="system-title">
        <span>公安业务终端</span>
        <h1>嫌疑人询问系统</h1>
        <p>案件历史记录与询问入口</p>
      </div>
      <div class="case-list-actions">
        <div class="case-count"><strong>{{ cases.length }}</strong><span>案件总数</span></div>
        <button class="btn-primary" @click="identityOpen = true">＋ 新建询问</button>
      </div>
    </header>

    <section class="case-list-toolbar">
      <div>
        <strong>案件列表</strong>
        <span>选择案件进入工作台，或新建询问后先完成身份核验</span>
      </div>
      <button class="refresh-button" :disabled="loading" @click="load">{{ loading ? '刷新中…' : '刷新列表' }}</button>
    </section>

    <div v-if="loading" class="status-banner">正在加载案件历史…</div>
    <div v-else-if="error" class="status-banner error">{{ error }}</div>
    <div v-else-if="!cases.length" class="empty-state">
      <strong>暂无案件记录</strong>
      <p>点击右上角“新建询问”，先读取并核对身份证，再进入案件工作台。</p>
      <button class="btn-primary" @click="identityOpen = true">新建第一起询问</button>
    </div>

    <section v-else class="case-list" aria-label="案件列表">
      <button v-for="item in cases" :key="item.id" class="case-row" type="button" @click="emit('open', item.id)">
        <div class="person-cell">
          <div class="person-avatar">{{ (item.suspectName || '待')[0] }}</div>
          <div>
            <div class="case-row-title">
              <strong>{{ item.suspectName || '待录入人员' }}</strong>
              <span v-if="item.gender || item.age">{{ item.gender || '' }} {{ item.age ? `${item.age}岁` : '' }}</span>
            </div>
            <small v-if="item.idNumber">身份证：{{ maskedId(item.idNumber) }}</small>
            <small v-else>身份证：未录入</small>
          </div>
        </div>

        <div class="case-info-cell">
          <span>案件编号</span>
          <strong>{{ item.id }}</strong>
        </div>
        <div class="case-info-cell">
          <span>主审民警</span>
          <strong>{{ item.officerName || '当前警官' }}</strong>
        </div>
        <div class="case-info-cell">
          <span>最后更新</span>
          <strong>{{ fmtTime(item.updatedAt) || '暂无' }}</strong>
        </div>

        <div class="case-status-cell">
          <span v-if="item.identitySource" class="tag identity">{{ identitySourceText(item.identitySource) }}</span>
          <span class="tag stage">{{ stageTextMap[item.stage] || item.stage }}</span>
          <span class="tag state" :data-state="item.state">{{ stateTextMap[item.state] || item.state }}</span>
        </div>
        <span class="enter-arrow">进入 ›</span>
      </button>
    </section>
  </main>

  <IdentityIntakeModal v-if="identityOpen" @close="identityOpen = false" @created="created" />
</template>

<style scoped>
.case-list-page {
  --list-blue: #123f60;
  --list-accent: #1f6597;
  --list-line: #b9cad6;
  width: 100%;
  min-width: 1320px;
  height: 100vh;
  display: grid;
  grid-template-rows: 94px 64px minmax(0, 1fr);
  overflow: hidden;
  background: #dfe9ef;
  color: #21394a;
}
.case-list-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 28px;
  padding: 0 32px;
  background: #102d46;
  color: #fff;
  border-bottom: 4px solid #d79b31;
}
.system-title > span { display: block; color: #a9c0d1; font-size: 12px; letter-spacing: .14em; }
.system-title h1 { margin: 3px 0 2px; font-size: 25px; letter-spacing: .04em; }
.system-title p { margin: 0; color: #b9cbd8; font-size: 13px; }
.case-list-actions { display: flex; align-items: center; gap: 18px; }
.case-count { min-width: 94px; display: flex; align-items: baseline; justify-content: center; gap: 7px; padding: 8px 12px; border: 1px solid #45657e; background: #173b57; }
.case-count strong { font-size: 22px; }
.case-count span { color: #bfd0dc; font-size: 12px; }
.btn-primary, .refresh-button {
  min-height: 50px;
  border: 1px solid #9eb5c5;
  border-radius: 5px;
  padding: 0 20px;
  background: #fff;
  color: #284b62;
  font-size: 15px;
  font-weight: 700;
  touch-action: manipulation;
}
.btn-primary { min-width: 170px; border-color: #2b79ae; background: #2371a6; color: #fff; }
.case-list-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  padding: 0 32px;
  border-bottom: 1px solid var(--list-line);
  background: #f7fafc;
}
.case-list-toolbar > div { display: flex; align-items: baseline; gap: 14px; }
.case-list-toolbar strong { color: #183f5b; font-size: 18px; }
.case-list-toolbar span { color: #718594; font-size: 13px; }
.refresh-button { min-width: 112px; min-height: 44px; }
.status-banner { margin: 18px 32px; padding: 18px; border: 1px solid #b7cad8; background: #f7fbfe; text-align: center; color: #526b7d; }
.status-banner.error { border-color: #dfaaa3; background: #fff3f1; color: #9b3229; }
.empty-state { align-self: center; justify-self: center; width: 520px; padding: 42px; text-align: center; border: 1px solid #b8c9d5; background: #fff; }
.empty-state strong { display: block; color: #244b66; font-size: 20px; }
.empty-state p { margin: 12px 0 22px; color: #718492; line-height: 1.7; }
.case-list { min-height: 0; overflow: auto; padding: 18px 32px 30px; }
.case-row {
  width: 100%;
  min-height: 104px;
  display: grid;
  grid-template-columns: minmax(280px, 1.25fr) minmax(180px, .8fr) minmax(130px, .55fr) minmax(160px, .7fr) minmax(330px, 1.3fr) 76px;
  align-items: center;
  gap: 18px;
  margin: 0 0 10px;
  padding: 12px 18px;
  border: 1px solid #b7c8d4;
  border-left: 5px solid #2d729f;
  border-radius: 4px;
  background: #fff;
  color: #233d50;
  text-align: left;
  font: inherit;
  touch-action: manipulation;
}
.case-row:focus-visible { outline: 3px solid rgba(31,101,151,.25); outline-offset: 2px; }
.person-cell { min-width: 0; display: grid; grid-template-columns: 58px minmax(0,1fr); align-items: center; gap: 12px; }
.person-avatar { width: 58px; height: 66px; display: grid; place-items: center; border: 1px solid #9eb2bf; background: #e7eef2; color: #5e7585; font-size: 22px; font-weight: 700; }
.case-row-title { display: flex; align-items: baseline; gap: 9px; }
.case-row-title strong { color: #193f5a; font-size: 18px; }
.case-row-title span, .person-cell small { color: #758896; font-size: 12px; }
.person-cell small { display: block; margin-top: 6px; }
.case-info-cell { min-width: 0; display: grid; gap: 7px; }
.case-info-cell span { color: #7c8e9a; font-size: 11px; }
.case-info-cell strong { min-width: 0; overflow: hidden; text-overflow: ellipsis; color: #354f62; font-size: 13px; white-space: nowrap; }
.case-status-cell { display: flex; flex-wrap: wrap; align-items: center; gap: 7px; justify-content: flex-end; }
.tag { padding: 6px 9px; border: 1px solid #b8c9d5; border-radius: 3px; background: #f4f8fb; color: #43657b; font-size: 11px; font-weight: 700; white-space: nowrap; }
.tag.identity { border-color: #9fc5ac; background: #f1f9f3; color: #327249; }
.tag.stage { border-color: #9ebed5; background: #f0f7fc; color: #28668f; }
.tag.state[data-state="INTERROGATING"] { border-color: #dab57a; background: #fff8e9; color: #875b16; }
.tag.state[data-state="REVIEWING"], .tag.state[data-state="COMPLETED"] { border-color: #9cc5aa; background: #f1f9f3; color: #2f7047; }
.tag.state[data-state="DRAFT"] { border-color: #c4cdd3; background: #f4f6f7; color: #687984; }
.enter-arrow { justify-self: end; color: #2b6d99; font-size: 14px; font-weight: 700; white-space: nowrap; }
button:disabled { opacity: .48; cursor: not-allowed; }
</style>
