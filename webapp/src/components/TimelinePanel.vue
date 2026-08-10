<script setup lang="ts">
import type { TimelineEvent } from '../types/interrogation'

defineProps<{ items: TimelineEvent[] }>()
</script>

<template>
  <section class="panel timeline-panel">
    <header class="panel-header">
      <strong>案件时间线</strong>
      <button class="ghost-button">＋事实节点</button>
    </header>
    <div class="timeline-list">
      <article v-for="item in items" :key="item.id" class="timeline-item">
        <div class="timeline-time">{{ item.time }}</div>
        <strong>{{ item.title }}</strong>
        <p>{{ item.detail }}</p>
        <div v-if="item.evidence?.length" class="evidence-tags">
          <span v-for="e in item.evidence" :key="e">{{ e }}</span>
        </div>
      </article>
    </div>
  </section>
</template>
