import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import { persistQuestionOrAnswer, streamInquiry } from '../api/interrogation'
import type { CaseSummary, FactItem, TimelineEvent, TranscriptMessage } from '../types/interrogation'

const uid = () => `${Date.now()}-${Math.random().toString(16).slice(2)}`

export const useInterrogationStore = defineStore('interrogation', () => {
  const params = new URLSearchParams(location.search)
  const caseId = ref(params.get('caseId') || '')
  const streaming = ref(false)
  const error = ref('')

  const caseSummary = ref<CaseSummary>({
    id: caseId.value || 'DEMO-2026-0810-017',
    suspectName: '张某',
    gender: '男',
    age: '32',
    officerName: '王警官',
    state: '审讯中',
  })

  const transcript = ref<TranscriptMessage[]>([
    { id: 'q17', speaker: '民警', text: '你为什么在当晚去找李某？', confirmed: true },
    { id: 'a17', speaker: '嫌疑人', text: '我想找他谈之前欠款的事，本来只是想把事情说清楚。', confirmed: true },
  ])

  const timeline = ref<TimelineEvent[]>([
    { id: 't1', time: '19:35', title: '事前接触', detail: '称在饭店与李某见面，待核对监控。' },
    { id: 't2', time: '20:12', title: '到达现场', detail: '称步行进入某小区东门。', evidence: ['E-014'] },
    { id: 't3', time: '20:18–20:27', title: '核心行为经过', detail: '争执及具体动作顺序需要继续细化。' },
    { id: 't4', time: '20:31 后', title: '离开及事后处置', detail: '离开路线及物品去向尚未完整。' },
  ])

  const facts = ref<FactItem[]>([
    { key: 'time', label: '时间', value: '20:12 到达；20:31 后离开', status: 'confirmed' },
    { key: 'place', label: '地点', value: '某小区 3 栋 2 单元', status: 'confirmed' },
    { key: 'motive', label: '动机 / 目的', value: '本人称处理欠款纠纷', status: 'pending', suggestion: '追问出门前联系、约定和准备行为。' },
    { key: 'method', label: '手段 / 工具', value: '工具来源、携带方式和去向未完整', status: 'missing' },
    { key: 'process', label: '行为经过', value: '行为先后顺序需要逐项固定', status: 'conflict', suggestion: '把关键动作拆成连续问题，关联原始问答。' },
    { key: 'evidence', label: '证据对应', value: '监控 E-014，其他证据待绑定', status: 'pending' },
    { key: 'after', label: '事后处置 / 后果', value: '离开路线、物品处置、是否联系他人', status: 'missing' },
  ])

  const completion = computed(() => {
    const done = facts.value.filter((item) => item.status === 'confirmed').length
    return Math.round((done / facts.value.length) * 100)
  })

  async function ask(text: string) {
    const clean = text.trim()
    if (!clean || streaming.value) return

    error.value = ''
    transcript.value.push({ id: uid(), speaker: '民警', text: clean, confirmed: true })
    const aiMessage: TranscriptMessage = {
      id: uid(),
      speaker: 'AI',
      text: '',
      streaming: true,
    }
    transcript.value.push(aiMessage)

    if (!caseId.value) {
      aiMessage.text = '当前为源码演示模式。URL 增加 ?caseId=真实案件ID 后将调用现有远端 SSE 接口。'
      aiMessage.streaming = false
      return
    }

    streaming.value = true
    try {
      // 兼容旧后端：消息落库失败也不阻断 SSE 主链路。
      try {
        await persistQuestionOrAnswer(caseId.value, clean, '民警')
      } catch (persistError) {
        console.warn('消息落库失败，继续尝试 SSE', persistError)
      }
      await streamInquiry(caseId.value, clean, (payload) => {
        if (payload.code) {
          error.value = payload.message || `后端返回错误 ${payload.code}`
          return
        }
        if (payload.text_chunk) aiMessage.text += payload.text_chunk
      })
    } catch (err) {
      error.value = err instanceof Error ? err.message : String(err)
    } finally {
      aiMessage.streaming = false
      streaming.value = false
    }
  }

  return {
    caseId,
    caseSummary,
    transcript,
    timeline,
    facts,
    completion,
    streaming,
    error,
    ask,
  }
})
