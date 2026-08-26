<script setup lang="ts">
import { computed, onMounted, reactive, ref } from 'vue'
import {
  backendErrorMessage,
  captureOcrImage,
  createCase,
  fetchLocalModels,
  fetchOcrStatus,
  fetchRuntimeCapabilities,
  pickOcrImage,
  recognizeOcrImage,
  selectLocalModel,
} from '../api/interrogation'
import { updateCaseFact } from '../api/caseProfile'
import type { RuntimeCapabilities } from '../runtime'
import type { CaseSummary, LocalModelDescriptor, OcrResult } from '../types/interrogation'
import { calculateAge, parseIdentityCardOcr } from '../utils/identityOcr'

const emit = defineEmits<{ close: []; created: [item: CaseSummary] }>()

const method = ref<'manual' | 'ocr'>('ocr')
const busy = ref('')
const error = ref('')
const previewError = ref('')
const capabilities = ref<RuntimeCapabilities | null>(null)
const ocrModels = ref<LocalModelDescriptor[]>([])
const selectedOcrModelId = ref('')
const previewUri = ref('')
const rawOcrText = ref('')
const lastOcr = ref<OcrResult | null>(null)
const ocrApplied = ref(false)

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
  officerName: '当前警官',
})

const usableOcrModels = computed(() => ocrModels.value.filter((item) => item.runtimeReady && item.complete !== false))
const ocrCapability = computed(() => capabilities.value?.ocr)
const ocrAvailable = computed(() => ocrCapability.value?.state === 'AVAILABLE')
const ocrReason = computed(() => {
  const item = ocrCapability.value
  if (!item || item.state === 'AVAILABLE') return ''
  return item.reason || ({
    NOT_CONNECTED: 'Linux 本地后端未连接',
    NOT_CONFIGURED: 'OCR Runtime 尚未配置',
    MODEL_NOT_INSTALLED: 'OCR 模型尚未安装',
    BUSY: 'OCR Runtime 正忙',
    ERROR: 'OCR Runtime 当前异常',
  }[item.state] || item.state)
})

function modelLabel(item: LocalModelDescriptor) {
  const format = item.modelFormat ? ` · ${item.modelFormat}` : ''
  const provider = item.provider ? ` · ${item.provider}` : ''
  const state = item.runtimeReady && item.complete !== false ? '' : '（Runtime 未就绪）'
  return `${item.name}${format}${provider}${state}`
}

function syncAge() {
  form.age = calculateAge(form.birthDate)
}

async function loadOcrModels() {
  if (!ocrAvailable.value) return
  error.value = ''
  try {
    const [catalog, status] = await Promise.all([fetchLocalModels(false), fetchOcrStatus()])
    ocrModels.value = catalog.models.filter((item) => item.category === 'OCR')
    selectedOcrModelId.value = status.selectedModelId || ''
    if (!selectedOcrModelId.value) {
      const firstUsable = usableOcrModels.value[0]
      if (firstUsable) {
        await selectLocalModel('OCR', firstUsable.id)
        selectedOcrModelId.value = firstUsable.id
      }
    }
  } catch (e) {
    error.value = backendErrorMessage(e)
  }
}

async function loadCapabilities() {
  capabilities.value = await fetchRuntimeCapabilities()
  if (ocrAvailable.value) await loadOcrModels()
}

async function changeOcrModel() {
  if (!selectedOcrModelId.value || !ocrAvailable.value) return
  busy.value = 'model'
  error.value = ''
  try {
    await selectLocalModel('OCR', selectedOcrModelId.value)
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    busy.value = ''
  }
}

function applyOcr(result: OcrResult) {
  const parsed = parseIdentityCardOcr(result.text)
  rawOcrText.value = result.text
  previewUri.value = result.previewUri || previewUri.value
  lastOcr.value = result
  if (parsed.suspectName) form.suspectName = parsed.suspectName
  if (parsed.gender) form.gender = parsed.gender
  if (parsed.nation) form.nation = parsed.nation
  if (parsed.birthDate) form.birthDate = parsed.birthDate
  if (parsed.age) form.age = parsed.age
  if (parsed.idNumber) form.idNumber = parsed.idNumber
  if (parsed.address) form.idCardAddress = parsed.address
  ocrApplied.value = true
  if (!parsed.suspectName && !parsed.idNumber) {
    error.value = 'OCR 已完成，但未能可靠定位身份证关键字段。请检查图片方向/清晰度，或直接手动修正。'
  }
}

async function runOcr(source: 'camera' | 'pick') {
  if (!ocrAvailable.value) {
    error.value = ocrReason.value || 'OCR Runtime 当前不可用，可继续使用手动录入。'
    return
  }
  if (!selectedOcrModelId.value) {
    error.value = '当前没有可运行的 OCR 模型，请先导入并选择 OCR 模型。'
    return
  }
  busy.value = source
  error.value = ''
  try {
    await selectLocalModel('OCR', selectedOcrModelId.value)
    const status = source === 'camera' ? await captureOcrImage() : await pickOcrImage()
    previewUri.value = status.previewUri || ''
    previewError.value = ''
    busy.value = 'recognize'
    const result = await recognizeOcrImage()
    applyOcr(result)
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    busy.value = ''
  }
}

async function submit() {
  error.value = ''
  const name = form.suspectName.trim()
  if (!name) {
    error.value = '请先录入被询问人的姓名。'
    return
  }
  const idNumber = form.idNumber.trim().toUpperCase()
  if (idNumber && !/^\d{15}$|^\d{17}[\dX]$/.test(idNumber)) {
    error.value = '身份证号码格式不正确，请核对后再创建询问。'
    return
  }

  busy.value = 'submit'
  try {
    const identityCapturedAt = Date.now()
    const payload = {
      suspectName: name,
      gender: form.gender.trim(),
      nation: form.nation.trim(),
      birthDate: form.birthDate.trim(),
      age: form.age.trim() || calculateAge(form.birthDate),
      idNumber,
      address: form.idCardAddress.trim(),
      officerName: form.officerName.trim() || '当前警官',
      identitySource: ocrApplied.value ? 'OCR' : 'MANUAL',
      identityCapturedAt,
    }
    const item = await createCase(payload)

    const factWrites = await Promise.allSettled([
      updateCaseFact(item.id, 'current_address', {
        value: form.currentAddress.trim() || '未录入',
        status: form.currentAddress.trim() ? 'confirmed' : 'missing',
      }),
      updateCaseFact(item.id, 'case_type', {
        value: form.caseType.trim() || '未录入',
        status: form.caseType.trim() ? 'confirmed' : 'missing',
      }),
    ])
    if (factWrites.some((result) => result.status === 'rejected')) {
      localStorage.setItem(`case-profile-pending:${item.id}`, JSON.stringify({
        currentAddress: form.currentAddress.trim(),
        caseType: form.caseType.trim(),
        savedAt: Date.now(),
      }))
    }

    emit('created', { ...item, ...payload })
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    busy.value = ''
  }
}

onMounted(() => {
  void loadCapabilities().catch((e) => { error.value = backendErrorMessage(e) })
})
</script>

<template>
  <div class="identity-mask" @click.self="emit('close')">
    <section class="identity-modal">
      <header class="identity-header">
        <div>
          <h2>新建询问 · 身份与案件信息</h2>
          <p>首次建档在这里完成：优先用高拍仪读取身份证，再补充现住址、案件类型和主审民警。</p>
        </div>
        <button class="close-btn" type="button" :disabled="!!busy" @click="emit('close')">关闭</button>
      </header>

      <div class="identity-methods">
        <button type="button" :class="{ active: method === 'ocr' }" @click="method = 'ocr'">高拍仪 / OCR</button>
        <button type="button" :class="{ active: method === 'manual' }" @click="method = 'manual'">手动录入</button>
      </div>

      <div v-if="method === 'ocr'" class="ocr-intake-card">
        <div v-if="!ocrAvailable" class="identity-note warning">
          {{ ocrReason || '正在查询 Linux 本地 OCR 能力…' }}。手动录入始终可用。
        </div>
        <template v-else>
          <div class="ocr-toolbar">
            <label>
              <span>OCR 模型</span>
              <select v-model="selectedOcrModelId" :disabled="!!busy" @change="changeOcrModel">
                <option value="">请选择 OCR 模型</option>
                <option v-for="item in ocrModels" :key="item.id" :value="item.id" :disabled="!item.runtimeReady || item.complete === false">
                  {{ modelLabel(item) }}
                </option>
              </select>
            </label>
            <div class="capture-actions">
              <button type="button" :disabled="!!busy || !selectedOcrModelId" @click="runOcr('camera')">
                {{ busy === 'camera' || busy === 'recognize' ? '读取识别中…' : '▣ 高拍仪读取身份证' }}
              </button>
              <button type="button" :disabled="!!busy || !selectedOcrModelId" @click="runOcr('pick')">选择身份证图片</button>
            </div>
          </div>
          <p v-if="!usableOcrModels.length" class="identity-note warning">当前没有可运行的 OCR 模型，请先在 AI 设置中导入并选择 OCR 模型。</p>
          <div v-if="previewUri || rawOcrText" class="ocr-review">
            <div class="id-preview">
              <img
                v-if="previewUri"
                :src="previewUri"
                alt="身份证高拍仪预览"
                @load="previewError = ''"
                @error="previewError = '身份证图片预览加载失败，请重新拍照或选择。'"
              />
              <span v-else>暂无身份证图片</span>
              <span v-if="previewError" class="identity-note error">{{ previewError }}</span>
            </div>
            <div class="ocr-raw">
              <span>OCR 原文</span>
              <pre>{{ rawOcrText || '识别完成后显示原始文本' }}</pre>
              <small v-if="lastOcr">{{ lastOcr.modelName }} · {{ lastOcr.provider }} · {{ lastOcr.recognitionMs }} ms</small>
            </div>
          </div>
        </template>
      </div>

      <form class="identity-form" @submit.prevent="submit">
        <div class="identity-grid">
          <label class="wide">
            <span>姓名 *</span>
            <input v-model.trim="form.suspectName" autocomplete="off" placeholder="请输入姓名" />
          </label>
          <label>
            <span>性别</span>
            <select v-model="form.gender">
              <option value="">请选择</option>
              <option value="男">男</option>
              <option value="女">女</option>
            </select>
          </label>
          <label>
            <span>民族</span>
            <input v-model.trim="form.nation" autocomplete="off" placeholder="如：汉" />
          </label>
          <label>
            <span>出生日期</span>
            <input v-model="form.birthDate" type="date" @change="syncAge" />
          </label>
          <label>
            <span>年龄</span>
            <input v-model.trim="form.age" inputmode="numeric" placeholder="自动计算 / 可修正" />
          </label>
          <label class="wide">
            <span>身份证号码</span>
            <input v-model.trim="form.idNumber" autocomplete="off" maxlength="18" placeholder="18 位身份证号码" />
          </label>
          <label class="full">
            <span>身份证住址</span>
            <textarea v-model.trim="form.idCardAddress" rows="2" placeholder="由身份证 OCR 自动回填，也可人工修正"></textarea>
          </label>
          <label class="full">
            <span>现住址</span>
            <textarea v-model.trim="form.currentAddress" rows="2" placeholder="填写当前实际居住地址；与身份证住址相同也可再次确认"></textarea>
          </label>
          <label class="wide">
            <span>案件类型</span>
            <input v-model.trim="form.caseType" autocomplete="off" placeholder="如：盗窃、诈骗、故意伤害等" />
          </label>
          <label class="wide">
            <span>主审民警</span>
            <input v-model.trim="form.officerName" autocomplete="off" />
          </label>
        </div>

        <div v-if="error" class="identity-note error">{{ error }}</div>
        <div v-else-if="ocrApplied" class="identity-note success">身份证字段已由高拍仪 / OCR 回填，请核对后补充案件信息并创建询问。</div>

        <footer class="identity-footer">
          <span>创建后直接进入案件工作台；A 页用于后续查看和修正身份资料。</span>
          <div>
            <button type="button" :disabled="!!busy" @click="emit('close')">取消</button>
            <button class="primary" type="submit" :disabled="!!busy">{{ busy === 'submit' ? '创建中…' : '确认信息并创建询问' }}</button>
          </div>
        </footer>
      </form>
    </section>
  </div>
</template>

<style scoped>
.identity-mask { position: fixed; inset: 0; z-index: 1200; background: rgba(15, 23, 42, .56); display: grid; place-items: center; padding: 22px; }
.identity-modal { width: min(920px, 96vw); max-height: 94vh; overflow: auto; border-radius: 16px; background: #f8fafc; box-shadow: 0 24px 70px rgba(15, 23, 42, .28); }
.identity-header { display: flex; justify-content: space-between; gap: 20px; align-items: flex-start; padding: 20px 22px 14px; background: #fff; border-bottom: 1px solid #e5e7eb; }
.identity-header h2 { margin: 0; color: #172033; font-size: 21px; }
.identity-header p { margin: 6px 0 0; color: #64748b; font-size: 13px; }
.close-btn { border: 0; background: #f1f5f9; border-radius: 8px; padding: 7px 12px; cursor: pointer; }
.identity-methods { display: flex; gap: 8px; padding: 16px 22px 8px; }
.identity-methods button { border: 1px solid #cbd5e1; background: #fff; color: #475569; border-radius: 9px; padding: 8px 15px; cursor: pointer; }
.identity-methods button.active { border-color: #2563eb; background: #eff6ff; color: #1d4ed8; font-weight: 700; }
.ocr-intake-card { margin: 4px 22px 12px; padding: 14px; border: 1px solid #dbeafe; border-radius: 12px; background: #f5f9ff; }
.ocr-toolbar { display: flex; align-items: end; gap: 12px; justify-content: space-between; }
.ocr-toolbar label { flex: 1; }
.ocr-toolbar span, .identity-form label > span, .ocr-raw > span { display: block; margin-bottom: 5px; color: #475569; font-size: 12px; font-weight: 700; }
.ocr-toolbar select, .identity-form input, .identity-form select, .identity-form textarea { width: 100%; box-sizing: border-box; border: 1px solid #cbd5e1; border-radius: 8px; background: #fff; padding: 9px 10px; color: #1e293b; outline: none; }
.ocr-toolbar select:focus, .identity-form input:focus, .identity-form select:focus, .identity-form textarea:focus { border-color: #2563eb; box-shadow: 0 0 0 2px rgba(37, 99, 235, .1); }
.capture-actions { display: flex; gap: 8px; }
.capture-actions button { border: 1px solid #93c5fd; background: #fff; color: #1d4ed8; border-radius: 8px; padding: 9px 12px; white-space: nowrap; cursor: pointer; }
.capture-actions button:first-child { background: #2563eb; color: #fff; border-color: #2563eb; font-weight: 700; }
button:disabled { opacity: .55; cursor: not-allowed; }
.ocr-review { display: grid; grid-template-columns: minmax(230px, 36%) 1fr; gap: 12px; margin-top: 12px; }
.id-preview { min-height: 150px; border: 1px dashed #94a3b8; border-radius: 10px; display: grid; place-items: center; overflow: hidden; background: #fff; color: #94a3b8; }
.id-preview img { width: 100%; max-height: 230px; object-fit: contain; }
.ocr-raw { min-width: 0; }
.ocr-raw pre { min-height: 116px; max-height: 190px; overflow: auto; margin: 0; white-space: pre-wrap; word-break: break-all; border-radius: 9px; background: #0f172a; color: #e2e8f0; padding: 10px; font-size: 12px; }
.ocr-raw small { display: block; margin-top: 5px; color: #64748b; }
.identity-form { padding: 8px 22px 20px; }
.identity-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 12px; }
.identity-grid label.wide { grid-column: span 2; }
.identity-grid label.full { grid-column: 1 / -1; }
.identity-form textarea { resize: vertical; }
.identity-note { margin-top: 10px; border-radius: 8px; padding: 9px 11px; font-size: 13px; }
.identity-note.warning { background: #fff7ed; color: #9a3412; }
.identity-note.error { background: #fef2f2; color: #b91c1c; }
.identity-note.success { background: #ecfdf5; color: #047857; }
.identity-footer { display: flex; justify-content: space-between; align-items: center; gap: 14px; margin-top: 18px; padding-top: 14px; border-top: 1px solid #e2e8f0; }
.identity-footer > span { color: #64748b; font-size: 12px; }
.identity-footer > div { display: flex; gap: 8px; }
.identity-footer button { border: 1px solid #cbd5e1; border-radius: 8px; padding: 9px 15px; background: #fff; cursor: pointer; white-space: nowrap; }
.identity-footer button.primary { border-color: #2563eb; background: #2563eb; color: #fff; font-weight: 700; }
@media (max-width: 760px) { .identity-mask { padding: 8px; } .identity-modal { width: 100%; max-height: 98vh; } .identity-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); } .ocr-toolbar, .identity-footer { align-items: stretch; flex-direction: column; } .capture-actions { display: grid; grid-template-columns: 1fr 1fr; } .ocr-review { grid-template-columns: 1fr; } }
</style>
