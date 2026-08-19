<script setup lang="ts">
import { computed } from 'vue'
import type { FactItem, TimelineEvent } from '../types/interrogation'

const props = defineProps<{ timeline: TimelineEvent[]; facts: FactItem[] }>()

const hiddenKeys = new Set([
  'current_address',
  'case_type',
  'interrogation_round',
  'interrogation_place',
  'officer_unit',
  'recorder_name',
  'recorder_unit',
  'id_document_type',
  'peoples_representative',
  'contact',
  'household_registration',
])
const preferredOrder = ['time', 'place', 'motive', 'people', 'method', 'process', 'evidence', 'after']
const visibleFacts = computed(() => props.facts
  .filter((item) => !hiddenKeys.has(item.key))
  .sort((a, b) => {
    const ai = preferredOrder.indexOf(a.key)
    const bi = preferredOrder.indexOf(b.key)
    return (ai < 0 ? 99 : ai) - (bi < 0 ? 99 : bi)
  }))
const completion = computed(() => {
  if (!visibleFacts.value.length) return 0
  return Math.round(visibleFacts.value.filter((item) => item.status === 'confirmed').length / visibleFacts.value.length * 100)
})

const statusText: Record<FactItem['status'], string> = {
  confirmed: '已核实',
  pending: '待核实',
  conflict: '有冲突',
  missing: '待补充',
}
</script>

<template>
  <section class="overview-grid">
    <article class="overview-panel timeline-overview">
      <header><h2>案件时间线</h2></header>
      <div class="overview-scroll timeline-overview-body">
        <div v-if="timeline.length" class="overview-timeline-list">
          <article v-for="item in timeline" :key="item.id" class="overview-timeline-item">
            <div class="overview-time">{{ item.time || '时间待核实' }}</div>
            <strong>{{ item.title }}</strong>
            <p>{{ item.detail }}</p>
            <div v-if="item.evidence?.length" class="overview-evidence">
              <span v-for="tag in item.evidence" :key="tag">{{ tag }}</span>
            </div>
          </article>
        </div>
      </div>
    </article>

    <article class="overview-panel fact-overview">
      <header>
        <h2>事实核对</h2>
        <span class="overview-completion">{{ completion }}%</span>
      </header>
      <div class="overview-scroll fact-overview-list">
        <article v-for="item in visibleFacts" :key="item.key" class="overview-fact-item">
          <div class="overview-fact-head">
            <strong>{{ item.label }}</strong>
            <span class="overview-fact-status" :data-status="item.status">{{ statusText[item.status] }}</span>
          </div>
          <p>{{ item.value }}</p>
          <div v-if="item.suggestion" class="overview-suggestion">采用追问：{{ item.suggestion }}</div>
        </article>
      </div>
    </article>
  </section>
</template>
