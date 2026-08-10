<script setup lang="ts">
import DeviceStatusBar from '../components/DeviceStatusBar.vue'
import FactMatrix from '../components/FactMatrix.vue'
import TimelinePanel from '../components/TimelinePanel.vue'
import TranscriptPanel from '../components/TranscriptPanel.vue'
import { useInterrogationStore } from '../stores/interrogation'

const store = useInterrogationStore()
</script>

<template>
  <main class="workspace">
    <header class="topbar">
      <div class="case-meta">
        <div>
          <h1>案件审讯工作台</h1>
          <p>
            案件：{{ store.caseSummary.id }}　｜　对象：{{ store.caseSummary.suspectName }}
            {{ store.caseSummary.gender }} {{ store.caseSummary.age }}岁
          </p>
        </div>
        <span class="state-chip">{{ store.caseSummary.state }}</span>
      </div>
      <div class="operator-meta">
        <DeviceStatusBar />
        <span>主审：{{ store.caseSummary.officerName }}</span>
        <span class="recording">● 录音</span>
      </div>
    </header>

    <div v-if="!store.caseId" class="demo-banner">
      当前是新 Vue 源码演示模式。要直连现有 SSE：在地址后追加 <code>?caseId=真实案件ID</code>，并提供现有登录 token。
    </div>

    <section class="workspace-grid">
      <TimelinePanel :items="store.timeline" />
      <TranscriptPanel
        :messages="store.transcript"
        :streaming="store.streaming"
        :error="store.error"
        @send="store.ask"
      />
      <FactMatrix :items="store.facts" :completion="store.completion" />
    </section>
  </main>
</template>
