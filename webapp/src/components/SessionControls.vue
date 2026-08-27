<script setup lang="ts">
import type { SessionState } from '../types/interrogation'

defineProps<{
  session: SessionState
  stageText: string
  startDisabled?: boolean
  startDisabledReason?: string
}>()
defineEmits<{
  start: []
  togglePause: []
  finish: []
  nextStage: []
}>()
</script>

<template>
  <section class="session-controls">
    <div class="session-state">
      <span>当前阶段：<strong>{{ stageText }}</strong></span>
      <span>会话状态：<strong>{{ session.status }}</strong></span>
      <span v-if="session.status === 'READY' && startDisabled" class="session-start-guard">{{ startDisabledReason }}</span>
    </div>
    <div class="session-buttons">
      <button
        v-if="session.status === 'READY'"
        class="session-primary"
        :disabled="startDisabled"
        :title="startDisabled ? startDisabledReason : '开始正式审讯'"
        @click="$emit('start')"
      >● 开始审讯</button>
      <button v-else-if="session.status === 'RUNNING'" @click="$emit('togglePause')">⏸ 暂停</button>
      <button v-else-if="session.status === 'PAUSED'" class="session-primary" @click="$emit('togglePause')">▶ 恢复</button>
      <button :disabled="!['RUNNING', 'PAUSED'].includes(session.status) || session.stage === 'SIGNING'" @click="$emit('nextStage')">下一阶段</button>
      <button class="danger-button" :disabled="!['RUNNING', 'PAUSED'].includes(session.status)" @click="$emit('finish')">结束审讯</button>
      <span v-if="session.status === 'COMPLETED'" class="completed-chip">本次审讯已结束</span>
    </div>
  </section>
</template>
