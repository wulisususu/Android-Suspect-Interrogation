<script setup lang="ts">
import type { FactItem } from '../types/interrogation'

defineProps<{ items: FactItem[]; completion: number }>()
defineEmits<{ useSuggestion: [text: string] }>()

const statusText: Record<FactItem['status'], string> = {
  confirmed: '已核对',
  pending: '待核实',
  conflict: '存在矛盾',
  missing: '缺失',
}
</script>

<template>
  <section class="panel fact-panel">
    <header class="panel-header">
      <strong>事实核对</strong>
      <span class="completion">{{ completion }}%</span>
    </header>
    <div class="fact-list">
      <article v-for="item in items" :key="item.key" class="fact-item">
        <div class="fact-head">
          <strong>{{ item.label }}</strong>
          <span class="fact-status" :data-status="item.status">{{ statusText[item.status] }}</span>
        </div>
        <p>{{ item.value }}</p>
        <button v-if="item.suggestion" class="suggestion" @click="$emit('useSuggestion', item.suggestion)">
          采用追问：{{ item.suggestion }}
        </button>
      </article>
    </div>
  </section>
</template>
