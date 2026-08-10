<script setup lang="ts">
import type { RecordRevision } from '../types/interrogation'

defineProps<{ revisions: RecordRevision[] }>()
defineEmits<{ close: [] }>()

function timeText(value: number) {
  return new Date(value).toLocaleString('zh-CN', { hour12: false })
}
</script>

<template>
  <div class="drawer-mask" @click.self="$emit('close')">
    <aside class="revision-drawer">
      <header>
        <div>
          <strong>笔录版本历史</strong>
          <p>每次警官修订都会保留旧版本，不直接覆盖。</p>
        </div>
        <button @click="$emit('close')">关闭</button>
      </header>
      <div class="revision-list">
        <article v-for="item in revisions" :key="item.id" class="revision-item">
          <div class="revision-meta">Q/A {{ item.qaId.slice(0, 8) }} · V{{ item.version }} · {{ timeText(item.createdAt) }}</div>
          <div class="revision-old">旧：{{ item.oldText }}</div>
          <div class="revision-new">新：{{ item.newText }}</div>
          <div v-if="item.reason" class="revision-reason">原因：{{ item.reason }}</div>
        </article>
        <div v-if="!revisions.length" class="empty-box">当前案件还没有修订版本。</div>
      </div>
    </aside>
  </div>
</template>
