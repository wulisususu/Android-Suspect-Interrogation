<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue'
import { backendErrorMessage, createCase, fetchRuntimeCapabilities } from '../api/interrogation'
import { getRuntimeAdapter, type RuntimeCapabilities } from '../runtime'
import type { CaseSummary } from '../types/interrogation'
import { calculateAge } from '../utils/identityOcr'

const emit = defineEmits<{ close: []; created: [item: CaseSummary] }>()
interface IdentityReadResponse { identity?: { name?: string; id_number?: string; sex?: string; nation?: string; birth_date?: string; address?: string } }
const capabilities = ref<RuntimeCapabilities | null>(null)
const busy = ref('')
const error = ref('')
const cardApplied = ref(false)
const identityAvailable = computed(() => capabilities.value?.identity.state === 'AVAILABLE')
const form = reactive({ suspectName: '', gender: '', nation: '', birthDate: '', age: '', idNumber: '', idCardAddress: '', officerName: '当前警官' })
function syncAge() { form.age = calculateAge(form.birthDate) }

async function readCard() {
  if (!identityAvailable.value) { error.value = capabilities.value?.identity.reason || '身份证读卡器尚未配置，请手动录入。'; return }
  busy.value = 'card'; error.value = ''
  try {
    const result = await getRuntimeAdapter().invoke<IdentityReadResponse>('identity.read', { actorId: form.officerName || '当前警官' }, { timeoutMs: 30_000 })
    const identity = result.identity
    if (!identity?.name && !identity?.id_number) throw new Error('读卡器未返回可核对的身份字段')
    form.suspectName = identity.name || form.suspectName
    form.idNumber = (identity.id_number || form.idNumber).toUpperCase()
    form.gender = identity.sex || form.gender; form.nation = identity.nation || form.nation; form.birthDate = identity.birth_date || form.birthDate; form.idCardAddress = identity.address || form.idCardAddress
    syncAge(); cardApplied.value = true
  } catch (cause) { error.value = backendErrorMessage(cause) } finally { busy.value = '' }
}

async function submit() {
  const suspectName = form.suspectName.trim(); const idNumber = form.idNumber.trim().toUpperCase()
  if (!suspectName) { error.value = '请先录入被询问人姓名。'; return }
  if (idNumber && !/^\d{15}$|^\d{17}[\dX]$/.test(idNumber)) { error.value = '身份证号码格式不正确。'; return }
  busy.value = 'submit'; error.value = ''
  try {
    const item = await createCase({ suspectName, gender: form.gender.trim(), nation: form.nation.trim(), birthDate: form.birthDate.trim(), age: form.age.trim() || calculateAge(form.birthDate), idNumber, address: form.idCardAddress.trim(), officerName: form.officerName.trim() || '当前警官', identitySource: cardApplied.value ? 'ID_CARD_READER' : 'MANUAL', identityCapturedAt: Date.now() })
    emit('created', item)
  } catch (cause) { error.value = backendErrorMessage(cause) } finally { busy.value = '' }
}
onMounted(async () => { try { capabilities.value = await fetchRuntimeCapabilities() } catch (cause) { error.value = backendErrorMessage(cause) } })
</script>

<template>
  <div class="identity-mask" @click.self="emit('close')"><section class="identity-modal">
    <header><div><span>新建案件</span><h2>身份信息录入</h2><p>使用身份证读卡器或人工录入；浏览器内 OCR 导入已取消。</p></div><button @click="emit('close')">关闭</button></header>
    <div class="identity-card"><strong>身份证读卡器</strong><span :class="{ available: identityAvailable }">{{ identityAvailable ? '设备可用' : capabilities?.identity.reason || '未配置' }}</span><button :disabled="!!busy || !identityAvailable" @click="readCard">{{ busy === 'card' ? '读取中…' : '读取身份证' }}</button></div>
    <form @submit.prevent="submit"><label>姓名 *<input v-model="form.suspectName" /></label><label>身份证号码<input v-model="form.idNumber" maxlength="18" /></label><label>性别<select v-model="form.gender"><option value="">未填写</option><option>男</option><option>女</option></select></label><label>民族<input v-model="form.nation" /></label><label>出生日期<input v-model="form.birthDate" type="date" @change="syncAge" /></label><label>年龄<input v-model="form.age" /></label><label class="wide">身份证住址<textarea v-model="form.idCardAddress" rows="2" /></label><label>主审民警<input v-model="form.officerName" /></label><p v-if="error" class="error">{{ error }}</p><footer><span>创建后可在身份信息页补充案件与笔录字段。</span><button class="primary" :disabled="!!busy">{{ busy === 'submit' ? '创建中…' : '创建案件' }}</button></footer></form>
  </section></div>
</template>

<style scoped>
.identity-mask { position:fixed; inset:0; z-index:1400; display:grid; place-items:center; padding:22px; background:rgba(10,24,38,.58); }.identity-modal { width:min(760px,96vw); max-height:92vh; overflow:auto; border-radius:14px; background:#f8fafc; box-shadow:0 26px 76px rgba(6,20,33,.28); }.identity-modal header,.identity-card,form,footer { padding:18px 22px; }.identity-modal header,.identity-card,footer { display:flex; align-items:center; justify-content:space-between; gap:14px; background:#fff; border-bottom:1px solid #dce5eb; }.identity-modal h2 { margin:4px 0; color:#21384b; }.identity-modal p { margin:4px 0; color:#687e90; }.identity-card span { color:#9a6021; }.identity-card span.available { color:#17734b; }form { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:13px; }label { display:grid; gap:6px; color:#4a6273; font-size:13px; font-weight:700; }.wide,.error,footer { grid-column:1/-1; }input,select,textarea { min-height:40px; box-sizing:border-box; border:1px solid #aebfcb; border-radius:5px; padding:8px; font:inherit; }textarea { min-height:auto; }.error { color:#a32626; }button { border:1px solid #adc0cf; border-radius:6px; background:#fff; color:#31506a; padding:8px 12px; font-weight:700; }.primary { background:#1f6597; color:#fff; border-color:#1f6597; }footer { margin:0 -22px -18px; color:#687e90; font-size:13px; }@media(max-width:600px){form{grid-template-columns:1fr;}.wide,.error,footer{grid-column:auto;}}
</style>
