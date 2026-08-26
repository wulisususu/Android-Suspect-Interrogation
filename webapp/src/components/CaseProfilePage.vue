<script setup lang="ts">
import { computed, onMounted, reactive, ref, watch } from 'vue'
import {
  backendErrorMessage,
  captureOcrImage,
  fetchLocalModels,
  fetchOcrStatus,
  recognizeOcrImage,
  selectLocalModel,
} from '../api/interrogation'
import { updateCaseFact, updateCaseProfile } from '../api/caseProfile'
import type { CaseSummary, FactItem } from '../types/interrogation'
import { calculateAge, parseIdentityCardOcr } from '../utils/identityOcr'

const props = defineProps<{ summary: CaseSummary; facts: FactItem[] }>()
const emit = defineEmits<{ saved: [] }>()

const busy = ref('')
const error = ref('')
const message = ref('')
const rawOcrText = ref('')

const form = reactive({
  suspectName: '',
  gender: '',
  nation: '',
  birthDate: '',
  age: '',
  idDocumentType: '身份证',
  idNumber: '',
  idCardAddress: '',
  contact: '',
  currentAddress: '',
  householdRegistration: '',
  peoplesRepresentative: '否',
  caseType: '',
  interrogationRound: '1',
  interrogationPlace: '',
  officerName: '',
  officerUnit: '',
  recorderName: '',
  recorderUnit: '',
})

const profileFact = (key: string) => props.facts.find((item) => item.key === key)
const identitySourceText = computed(() => props.summary.identitySource === 'OCR' ? '高拍仪 / OCR' : props.summary.identitySource === 'MANUAL' ? '人工录入' : '未标记')

function factText(key: string, fallback = '') {
  const value = profileFact(key)?.value?.trim()
  if (!value || value === '未录入') return fallback
  return value
}

function syncFromProps() {
  form.suspectName = props.summary.suspectName === '待录入' ? '' : props.summary.suspectName || ''
  form.gender = props.summary.gender || ''
  form.nation = props.summary.nation || ''
  form.birthDate = props.summary.birthDate || ''
  form.age = props.summary.age || calculateAge(form.birthDate)
  form.idDocumentType = factText('id_document_type', '身份证')
  form.idNumber = props.summary.idNumber || ''
  form.idCardAddress = props.summary.address || ''
  form.contact = factText('contact')
  form.currentAddress = factText('current_address')
  form.householdRegistration = factText('household_registration')
  form.peoplesRepresentative = factText('peoples_representative', '否')
  form.caseType = factText('case_type')
  form.interrogationRound = factText('interrogation_round', '1')
  form.interrogationPlace = factText('interrogation_place')
  form.officerName = props.summary.officerName || '当前警官'
  form.officerUnit = factText('officer_unit')
  form.recorderName = factText('recorder_name')
  form.recorderUnit = factText('recorder_unit', form.officerUnit)
}

watch(() => [props.summary, props.facts], syncFromProps, { deep: true, immediate: true })

function syncAge() {
  form.age = calculateAge(form.birthDate)
}

async function ensureOcrModel() {
  const status = await fetchOcrStatus()
  if (status.selectedModelId) return
  const catalog = await fetchLocalModels(false)
  const candidate = catalog.models.find((item) => item.category === 'OCR' && item.runtimeReady && item.complete !== false)
  if (!candidate) throw new Error('当前没有可运行的 OCR 模型，请先在 AI 设置中导入并选择 OCR 模型')
  await selectLocalModel('OCR', candidate.id)
}

async function recaptureIdentity() {
  busy.value = 'ocr'
  error.value = ''
  message.value = ''
  rawOcrText.value = ''
  try {
    await ensureOcrModel()
    await captureOcrImage()
    const result = await recognizeOcrImage()
    rawOcrText.value = result.text
    const parsed = parseIdentityCardOcr(result.text)
    if (parsed.suspectName) form.suspectName = parsed.suspectName
    if (parsed.gender) form.gender = parsed.gender
    if (parsed.nation) form.nation = parsed.nation
    if (parsed.birthDate) form.birthDate = parsed.birthDate
    if (parsed.age) form.age = parsed.age
    if (parsed.idNumber) form.idNumber = parsed.idNumber
    if (parsed.address) form.idCardAddress = parsed.address
    message.value = '身份证已重新读取并回填。请核对后点击“保存修改”。'
  } catch (err) {
    error.value = backendErrorMessage(err)
  } finally {
    busy.value = ''
  }
}

function factPatch(value: string, fallback = '未录入') {
  const clean = value.trim()
  return { value: clean || fallback, status: clean ? 'confirmed' as const : 'missing' as const }
}

async function save() {
  const name = form.suspectName.trim()
  if (!name) {
    error.value = '姓名不能为空。'
    return
  }
  const idNumber = form.idNumber.trim().toUpperCase()
  if (idNumber && !/^\d{15}$|^\d{17}[\dX]$/.test(idNumber)) {
    error.value = '身份证号码格式不正确。'
    return
  }
  if (!/^\d+$/.test(form.interrogationRound.trim() || '1')) {
    error.value = '询问次数应填写数字。'
    return
  }

  busy.value = 'save'
  error.value = ''
  message.value = ''
  try {
    await updateCaseProfile(props.summary.id, {
      suspectName: name,
      gender: form.gender.trim(),
      nation: form.nation.trim(),
      birthDate: form.birthDate.trim(),
      age: form.age.trim() || calculateAge(form.birthDate),
      idNumber,
      address: form.idCardAddress.trim(),
      officerName: form.officerName.trim() || '当前警官',
      identitySource: rawOcrText.value ? 'OCR' : (props.summary.identitySource || 'MANUAL'),
      identityCapturedAt: rawOcrText.value ? Date.now() : (props.summary.identityCapturedAt || Date.now()),
    })

    await Promise.all([
      updateCaseFact(props.summary.id, 'current_address', factPatch(form.currentAddress)),
      updateCaseFact(props.summary.id, 'case_type', factPatch(form.caseType)),
      updateCaseFact(props.summary.id, 'interrogation_round', {
        value: form.interrogationRound.trim() || '1',
        status: 'confirmed',
      }),
      updateCaseFact(props.summary.id, 'interrogation_place', factPatch(form.interrogationPlace)),
      updateCaseFact(props.summary.id, 'officer_unit', factPatch(form.officerUnit)),
      updateCaseFact(props.summary.id, 'recorder_name', factPatch(form.recorderName)),
      updateCaseFact(props.summary.id, 'recorder_unit', factPatch(form.recorderUnit)),
      updateCaseFact(props.summary.id, 'id_document_type', {
        value: form.idDocumentType.trim() || '身份证',
        status: 'confirmed',
      }),
      updateCaseFact(props.summary.id, 'peoples_representative', {
        value: form.peoplesRepresentative.trim() || '否',
        status: 'confirmed',
      }),
      updateCaseFact(props.summary.id, 'contact', factPatch(form.contact)),
      updateCaseFact(props.summary.id, 'household_registration', factPatch(form.householdRegistration)),
    ])

    message.value = '身份、案件信息及询问笔录固定头部已保存。'
    emit('saved')
  } catch (err) {
    error.value = backendErrorMessage(err)
  } finally {
    busy.value = ''
  }
}

onMounted(syncFromProps)
</script>

<template>
  <section class="profile-page page-card">
    <header class="page-card-header">
      <div>
        <h2>嫌疑人身份与笔录基础信息</h2>
        <p>A 页作为固定信息数据源；C 页生成询问笔录时自动引用，不需要重复录入。</p>
      </div>
      <div class="profile-header-actions">
        <span class="identity-source">身份来源：{{ identitySourceText }}</span>
        <button class="scanner-button secondary-scan" :disabled="!!busy" @click="recaptureIdentity">
          {{ busy === 'ocr' ? '读取中…' : '重新读取身份证' }}
        </button>
      </div>
    </header>

    <div class="profile-content profile-content-single">
      <div class="profile-main">
        <h3 class="profile-section-title">被询问人身份信息</h3>
        <div class="profile-grid">
          <label class="wide"><span>姓名 *</span><input v-model="form.suspectName" autocomplete="off" /></label>
          <label><span>性别</span><select v-model="form.gender"><option value="">请选择</option><option>男</option><option>女</option></select></label>
          <label><span>民族</span><input v-model="form.nation" autocomplete="off" /></label>
          <label><span>出生日期</span><input v-model="form.birthDate" type="date" @change="syncAge" /></label>
          <label><span>年龄</span><input v-model="form.age" inputmode="numeric" /></label>
          <label><span>身份证件种类</span><input v-model="form.idDocumentType" /></label>
          <label class="wide"><span>身份证件号码</span><input v-model="form.idNumber" maxlength="18" autocomplete="off" /></label>
          <label><span>人大代表</span><select v-model="form.peoplesRepresentative"><option>否</option><option>是</option></select></label>
          <label class="wide"><span>联系方式</span><input v-model="form.contact" inputmode="tel" /></label>
          <label class="full"><span>身份证住址</span><textarea v-model="form.idCardAddress" rows="2"></textarea></label>
          <label class="full"><span>现住址</span><textarea v-model="form.currentAddress" rows="2" placeholder="填写当前实际居住地址"></textarea></label>
          <label class="full"><span>户籍所在地</span><textarea v-model="form.householdRegistration" rows="2"></textarea></label>
          <label class="wide"><span>案件类型</span><input v-model="form.caseType" placeholder="如：盗窃、诈骗、故意伤害等" /></label>
        </div>

        <h3 class="profile-section-title second">询问笔录固定头部</h3>
        <div class="profile-grid">
          <label><span>第几次询问</span><input v-model="form.interrogationRound" inputmode="numeric" /></label>
          <label class="wide"><span>询问地点</span><input v-model="form.interrogationPlace" placeholder="如：紫琅湖派出所询问室1" /></label>
          <label><span>询问时间</span><input value="由系统根据本次会话自动记录" disabled /></label>
          <label class="wide"><span>询问人</span><input v-model="form.officerName" /></label>
          <label class="wide"><span>询问人工作单位</span><input v-model="form.officerUnit" /></label>
          <label class="wide"><span>记录人</span><input v-model="form.recorderName" /></label>
          <label class="wide"><span>记录人工作单位</span><input v-model="form.recorderUnit" /></label>
        </div>

        <div v-if="rawOcrText" class="profile-recapture-result">
          <strong>本次重新读取已完成</strong>
          <span>身份证字段已回填到表单，保存前请人工核对。</span>
        </div>
        <div v-if="error" class="page-message error">{{ error }}</div>
        <div v-else-if="message" class="page-message success">{{ message }}</div>

        <footer class="profile-footer">
          <span>结束审讯并冻结笔录后，以上固定信息和正式问答将不允许继续修改。</span>
          <button class="primary-action" :disabled="!!busy" @click="save">{{ busy === 'save' ? '保存中…' : '保存修改' }}</button>
        </footer>
      </div>
    </div>
  </section>
</template>

<style scoped>
.profile-content.profile-content-single {
  display: block;
  overflow: auto;
  padding: 20px;
}
.profile-content-single .profile-main {
  width: min(1180px, 100%);
  margin: 0 auto;
}
.profile-section-title {
  margin: 0 0 14px;
  padding-bottom: 9px;
  border-bottom: 1px solid #e6edf2;
  color: #29445a;
  font-size: 15px;
}
.profile-section-title.second { margin-top: 24px; }
.scanner-button.secondary-scan {
  border-color: #cbd8e2;
  background: #fff;
  color: #4f6474;
  padding: 7px 11px;
  font-weight: 600;
}
.scanner-button.secondary-scan:hover:not(:disabled) {
  border-color: #8eb7d8;
  color: #2369a2;
  background: #f8fbfe;
}
.profile-recapture-result {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-top: 12px;
  padding: 9px 12px;
  border: 1px solid #d8e8f5;
  border-radius: 8px;
  background: #f6fbff;
  color: #557080;
  font-size: 12px;
}
.profile-recapture-result strong { color: #266a9f; }
</style>
