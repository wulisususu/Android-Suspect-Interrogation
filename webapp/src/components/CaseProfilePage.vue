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
import { isNativeBusinessRuntime } from '../native/rpcBridge'
import type { CaseSummary, FactItem } from '../types/interrogation'
import { calculateAge, parseIdentityCardOcr } from '../utils/identityOcr'

const props = defineProps<{ summary: CaseSummary; facts: FactItem[] }>()
const emit = defineEmits<{ saved: [] }>()

const native = isNativeBusinessRuntime()
const busy = ref('')
const error = ref('')
const message = ref('')
const previewUri = ref('')
const rawOcrText = ref('')

const form = reactive({
  suspectName: '',
  gender: '',
  nation: '',
  birthDate: '',
  age: '',
  idNumber: '',
  idCardAddress: '',
  currentAddress: '',
  caseType: '',
  officerName: '',
})

const profileFact = (key: string) => props.facts.find((item) => item.key === key)
const identitySourceText = computed(() => props.summary.identitySource === 'OCR' ? '高拍仪 / OCR' : props.summary.identitySource === 'MANUAL' ? '人工录入' : '未标记')

function browserProfile(): Partial<typeof form> {
  if (native || !props.summary.id) return {}
  try {
    return JSON.parse(localStorage.getItem(`case-profile:${props.summary.id}`) || '{}') as Partial<typeof form>
  } catch {
    return {}
  }
}

function syncFromProps() {
  const fallback = browserProfile()
  form.suspectName = props.summary.suspectName === '待录入' ? '' : props.summary.suspectName || fallback.suspectName || ''
  form.gender = props.summary.gender || fallback.gender || ''
  form.nation = props.summary.nation || fallback.nation || ''
  form.birthDate = props.summary.birthDate || fallback.birthDate || ''
  form.age = props.summary.age || fallback.age || calculateAge(form.birthDate)
  form.idNumber = props.summary.idNumber || fallback.idNumber || ''
  form.idCardAddress = props.summary.address || fallback.idCardAddress || ''
  form.currentAddress = profileFact('current_address')?.value === '未录入'
    ? ''
    : profileFact('current_address')?.value || fallback.currentAddress || ''
  form.caseType = profileFact('case_type')?.value === '未录入'
    ? ''
    : profileFact('case_type')?.value || fallback.caseType || ''
  form.officerName = props.summary.officerName || fallback.officerName || '当前警官'
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

async function captureIdentity() {
  if (!native) {
    error.value = '高拍仪 / OCR 仅在 Android APK 中可用。浏览器联调环境可继续手工录入。'
    return
  }
  busy.value = 'ocr'
  error.value = ''
  message.value = ''
  try {
    await ensureOcrModel()
    const status = await captureOcrImage()
    previewUri.value = status.previewUri || ''
    const result = await recognizeOcrImage()
    previewUri.value = result.previewUri || previewUri.value
    rawOcrText.value = result.text
    const parsed = parseIdentityCardOcr(result.text)
    if (parsed.suspectName) form.suspectName = parsed.suspectName
    if (parsed.gender) form.gender = parsed.gender
    if (parsed.nation) form.nation = parsed.nation
    if (parsed.birthDate) form.birthDate = parsed.birthDate
    if (parsed.age) form.age = parsed.age
    if (parsed.idNumber) form.idNumber = parsed.idNumber
    if (parsed.address) form.idCardAddress = parsed.address
    message.value = '身份证 OCR 已回填，请核对后保存。'
  } catch (err) {
    error.value = backendErrorMessage(err)
  } finally {
    busy.value = ''
  }
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

    if (native) {
      await Promise.all([
        updateCaseFact(props.summary.id, 'current_address', {
          value: form.currentAddress.trim() || '未录入',
          status: form.currentAddress.trim() ? 'confirmed' : 'missing',
        }),
        updateCaseFact(props.summary.id, 'case_type', {
          value: form.caseType.trim() || '未录入',
          status: form.caseType.trim() ? 'confirmed' : 'missing',
        }),
      ])
    } else {
      localStorage.setItem(`case-profile:${props.summary.id}`, JSON.stringify({ ...form, suspectName: name, idNumber }))
    }

    message.value = '身份与案件基础信息已保存。'
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
        <h2>嫌疑人身份信息</h2>
        <p>身份证信息、现住址和案件基础信息统一在这里维护。</p>
      </div>
      <div class="profile-header-actions">
        <span class="identity-source">身份来源：{{ identitySourceText }}</span>
        <button class="scanner-button" :disabled="!!busy" @click="captureIdentity">
          {{ busy === 'ocr' ? '识别中…' : '▣ 高拍仪识别身份证' }}
        </button>
      </div>
    </header>

    <div class="profile-content">
      <div class="profile-main">
        <div class="profile-grid">
          <label class="wide"><span>姓名 *</span><input v-model="form.suspectName" autocomplete="off" /></label>
          <label><span>性别</span><select v-model="form.gender"><option value="">请选择</option><option>男</option><option>女</option></select></label>
          <label><span>民族</span><input v-model="form.nation" autocomplete="off" /></label>
          <label><span>出生日期</span><input v-model="form.birthDate" type="date" @change="syncAge" /></label>
          <label><span>年龄</span><input v-model="form.age" inputmode="numeric" /></label>
          <label class="wide"><span>身份证号码</span><input v-model="form.idNumber" maxlength="18" autocomplete="off" /></label>
          <label class="full"><span>身份证住址</span><textarea v-model="form.idCardAddress" rows="2"></textarea></label>
          <label class="full"><span>现住址</span><textarea v-model="form.currentAddress" rows="2" placeholder="填写当前实际居住地址"></textarea></label>
          <label class="wide"><span>案件类型</span><input v-model="form.caseType" placeholder="如：盗窃、诈骗、故意伤害等" /></label>
          <label class="wide"><span>主审民警</span><input v-model="form.officerName" /></label>
        </div>

        <div v-if="error" class="page-message error">{{ error }}</div>
        <div v-else-if="message" class="page-message success">{{ message }}</div>

        <footer class="profile-footer">
          <span>高拍仪识别只负责自动回填，最终以人工核对并保存的内容为准。</span>
          <button class="primary-action" :disabled="!!busy" @click="save">{{ busy === 'save' ? '保存中…' : '保存身份信息' }}</button>
        </footer>
      </div>

      <aside class="identity-preview">
        <div class="identity-preview-box">
          <img v-if="previewUri" :src="previewUri" alt="身份证高拍仪预览" />
          <div v-else class="preview-placeholder">高拍仪拍摄后<br />在此显示身份证预览</div>
        </div>
        <div class="ocr-raw-box">
          <span>OCR 原始识别文本</span>
          <pre>{{ rawOcrText || '尚未进行本次识别' }}</pre>
        </div>
      </aside>
    </div>
  </section>
</template>
