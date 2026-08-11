<script setup lang="ts">
import { onMounted } from 'vue'
import AiSettingsPanel from '../components/AiSettingsPanel.vue'
import DeviceStatusBar from '../components/DeviceStatusBar.vue'
import FactMatrix from '../components/FactMatrix.vue'
import RevisionDrawer from '../components/RevisionDrawer.vue'
import SessionControls from '../components/SessionControls.vue'
import TimelinePanel from '../components/TimelinePanel.vue'
import TranscriptPanel from '../components/TranscriptPanel.vue'
import { useInterrogationStore } from '../stores/interrogation'

const store = useInterrogationStore()
onMounted(() => store.initialize())
</script>

<template>
  <main class="workspace">
    <header class="topbar">
      <div class="case-meta">
        <button class="back-btn" @click="$emit('back')">‹ 返回</button>
        <div>
          <h1>案件审讯工作台</h1>
          <p>
            案件：{{ store.caseSummary.id || '加载中' }}　｜　对象：{{ store.caseSummary.suspectName }}
            <template v-if="store.caseSummary.gender || store.caseSummary.age">
              {{ store.caseSummary.gender }} {{ store.caseSummary.age ? `${store.caseSummary.age}岁` : '' }}
            </template>
          </p>
        </div>
        <span class="state-chip">{{ store.stateText }}</span>
      </div>
      <div class="operator-meta">
        <AiSettingsPanel />
        <DeviceStatusBar />
        <span>主审：{{ store.caseSummary.officerName }}</span>
        <span class="recording" :class="{ muted: store.session.status !== 'RUNNING' }">● {{ store.session.status === 'RUNNING' ? '审讯中' : '未录入' }}</span>
      </div>
    </header>

    <div v-if="store.loading" class="demo-banner">正在连接专属后端并加载案件状态…</div>
    <div v-else-if="store.actionError" class="feedback-banner error">{{ store.actionError }}</div>
    <div v-else-if="store.actionMessage" class="feedback-banner success">{{ store.actionMessage }}</div>

    <SessionControls
      :session="store.session"
      :stage-text="store.stageText"
      @start="store.startSession"
      @toggle-pause="store.togglePause"
      @finish="store.finishSession"
      @next-stage="store.nextStage"
    />

    <section class="workspace-grid">
      <TimelinePanel :items="store.timeline" />
      <TranscriptPanel
        :messages="store.transcript"
        :streaming="store.streaming"
        :can-record="store.canRecord"
        :error="store.error"
        @send="store.ask"
        @edit="store.editMessage"
        @mark="store.markMessage"
        @mark-latest="store.markLatestConflict"
        @versions="store.openRevisions"
      />
      <FactMatrix :items="store.facts" :completion="store.completion" @use-suggestion="store.useSuggestion" />
    </section>

    <RevisionDrawer v-if="store.revisionsOpen" :revisions="store.revisions" @close="store.closeRevisions" />
  </main>
</template>
