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
import { getRuntimeAdapter, type RuntimeCapabilities } from '../runtime'
import type { CaseSummary, LocalModelDescriptor, OcrResult } from '../types/interrogation'
import { calculateAge, parseIdentityCardOcr } from '../utils/identityOcr'

const emit = defineEmits<{ close: []; created: [item: CaseSummary] }>()

type IntakeMethod = 'card' | 'ocr' | 'manual'
interface IdentityReadResponse {
  person?: Record<string, unknown>
  identity?: {
    name?: string
    id_number?: string
    sex?: string
    nation?: string
    birth_date?: string
    address?: string
    issuer?: string
    valid_from?: string
    valid_to?: string
    portrait?: string
    source?: string
  }
}

const method = ref<IntakeMethod>('card')
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
const cardApplied = ref(false)
const cardPortrait = ref('')
const cardIssuer = ref('')
const cardValidity = ref('')

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
const identityCapability = computed(() => capabilities.value?.identity)
const identityAvailable = computed(() => identityCapability.value?.state === 'AVAILABLE')
const ocrCapability = computed(() => capabilities.value?.ocr)
const ocrAvailable = computed(() => ocrCapability.value?.state === 'AVAILABLE')
const identityReason = computed(() => capabilityReason(identityCapability.value, '身份证读卡器尚未配置'))
const ocrReason = computed(() => capabilityReason(ocrCapability.value, 'OCR Runtime 尚未配置'))
const portraitSrc = computed(() => {
  const value = cardPortrait.value.trim()
  if (!value) return ''
  if (/^(data:|blob:|https?:)/i.test(value)) return value
  return `data:image/jpeg;base64,${value}`
})

function capabilityReason(item: { state?: string; reason?: string } | undefined, fallback: string) {
  if (!item || item.state === 'AVAILABLE') return ''
  if (item.reason) return item.reason
  return ({
    NOT_CONNECTED: 'Linux 本地后端未连接',
    NOT_CONFIGURED: fallback,
    MODEL_NOT_INSTALLED: '所需本地模型尚未安装',
    BUSY: '设备 / Runtime 正忙',
    ERROR: '设备 / Runtime 当前异常',
  } as Record<string, string>)[item.state || ''] || item.state || fallback
}

function modelLabel(item: LocalModelDescriptor) {
  const format = item.modelFormat ? ` · ${item.modelFormat}` : ''
  const provider = item.provider ? ` · ${item.provider}` : ''
  const state = item.runtimeReady && item.complete !== false ? '' : '（Runtime 未就绪）'
  return `${item.name}${format}${provider}${state}`
}

function syncAge() {
  form.age = calculateAge(form.birthDate)
}

function setIdentityFields(identity: IdentityReadResponse['identity']) {
  if (!identity) return
  if (identity.name) form.suspectName = identity.name
  if (identity.sex) form.gender = identity.sex
  if (identity.nation) form.nation = identity.nation
  if (identity.birth_date) form.birthDate = identity.birth_date
  if (identity.id_number) form.idNumber = identity.id_number.toUpperCase()
  if (identity.address) form.idCardAddress = identity.address
  if (identity.portrait) cardPortrait.value = identity.portrait
  cardIssuer.value = identity.issuer || ''
  cardValidity.value = [identity.valid_from, identity.valid_to].filter(Boolean).join(' 至 ')
  syncAge()
}

async function readIdentityCard() {
  if (!identityAvailable.value) {
    error.value = identityReason.value || '身份证读卡器当前不可用，请使用 OCR 或手工录入。'
    return
  }
  busy.value = 'card'
  error.value = ''
  try {
    const result = await getRuntimeAdapter().invoke<IdentityReadResponse>('identity.read', {
      actorId: form.officerName.trim() || '当前警官',
    }, { timeoutMs: 30_000 })
    setIdentityFields(result.identity)
    if (!form.suspectName && result.person) {
      const person = result.person
      form.suspectName = String(person.name ?? person.suspect_name ?? '')
      form.idNumber = String(person.id_number ?? person.idNumber ?? '').toUpperCase()
      form.gender = String(person.sex ?? person.gender ?? '')
      form.nation = String(person.nation ?? '')
      form.birthDate = String(person.birth_date ?? person.birthDate ?? '')
      form.idCardAddress = String(person.address ?? '')
      syncAge()
    }
    if (!form.suspectName && !form.idNumber) throw new Error('读卡器返回成功，但未返回可核对的身份字段')
    cardApplied.value = true
    ocrApplied.value = false
  } catch (e) {
    error.value = backendErrorMessage(e)
  } finally {
    busy.value = ''
  }
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
  cardApplied.value = false
  if (!parsed.suspectName && !parsed.idNumber) {
    error.value = 'OCR 已完成，但未能可靠定位身份证关键字段。请检查图片清晰度，或使用读卡器 / 手工修正。'
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
    error.value = '请先读取或录入被询问人的姓名。'
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
      identitySource: cardApplied.value ? 'ID_CARD_READER' : ocrApplied.value ? 'OCR' : 'MANUAL',
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
    <section class="identity-modal" role="dialog" aria-modal="true" aria-label="身份证读取与身份确认">
      <header class="identity-header">
        <div>
          <span class="step-kicker">新建询问 · 身份核验</span>
          <h2>请放置身份证</h2>
          <p>优先使用 Linux 身份证读卡器。读取后先核对人员信息，再确认创建案件并进入审讯工作台。</p>
        </div>
        <button class="close-btn" type="button" :disabled="!!busy" @click="emit('close')">关闭</button>
      </header>

      <nav class="identity-methods" aria-label="身份录入方式">
        <button type="button" :class="{ active: method === 'card' }" @click="method = 'card'">身份证读卡器</button>
        <button type="button" :class="{ active: method === 'ocr' }" @click="method = 'ocr'">高拍仪 / OCR</button>
        <button type="button" :class="{ active: method === 'manual' }" @click="method = 'manual'">手动录入</button>
      </nav>

      <section v-if="method === 'card'" class="card-reader-panel">
        <div class="reader-illustration" :class="{ ready: identityAvailable, success: cardApplied }">
          <div class="id-card-shape">
            <div class="portrait-placeholder">证件</div>
            <div><i></i><i></i><i></i><i></i></div>
          </div>
          <div class="reader-wave"></div>
        </div>
        <div class="reader-copy">
          <h3>{{ cardApplied ? '身份证读取完成' : '将身份证平放在读卡区域' }}</h3>
          <p v-if="identityAvailable">读卡器已就绪。点击“读取身份证”后保持证件静止，直到人员信息显示。</p>
          <p v-else class="warning-text">{{ identityReason || '正在查询身份证读卡器状态…' }}。可切换到 OCR 或手动录入继续。</p>
          <button class="read-card-button" type="button" :disabled="!!busy || !identityAvailable" @click="readIdentityCard">
            {{ busy === 'card' ? '正在读取，请勿移动证件…' : cardApplied ? '重新读取身份证' : '读取身份证' }}
          </button>
          <div class="reader-state" :class="{ available: identityAvailable }">
            <span></span>{{ identityAvailable ? 'Linux 读卡器：已连接' : 'Linux 读卡器：未就绪' }}
          </div>
        </div>
      </section>

      <section v-else-if="method === 'ocr'" class="ocr-intake-card">
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
                {{ busy === 'camera' || busy === 'recognize' ? '读取识别中…' : '高拍仪读取身份证' }}
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
      </section>

      <form class="identity-form" @submit.prevent="submit">
        <div class="identity-result-title">
          <div><strong>身份信息</strong><span>请人工核对后确认</span></div>
          <span v-if="cardApplied" class="source-chip success">读卡器已读取</span>
          <span v-else-if="ocrApplied" class="source-chip">OCR 已识别</span>
          <span v-else class="source-chip muted">待录入</span>
        </div>

        <div class="identity-details-layout">
          <div class="identity-portrait">
            <img v-if="portraitSrc" :src="portraitSrc" alt="身份证头像" />
            <div v-else>证件照</div>
          </div>
          <div class="identity-grid">
            <label class="wide"><span>姓名 *</span><input v-model.trim="form.suspectName" autocomplete="off" placeholder="请输入姓名" /></label>
            <label><span>性别</span><select v-model="form.gender"><option value="">请选择</option><option value="男">男</option><option value="女">女</option></select></label>
            <label><span>民族</span><input v-model.trim="form.nation" autocomplete="off" placeholder="如：汉" /></label>
            <label><span>出生日期</span><input v-model="form.birthDate" type="date" @change="syncAge" /></label>
            <label><span>年龄</span><input v-model.trim="form.age" inputmode="numeric" placeholder="自动计算 / 可修正" /></label>
            <label class="full"><span>身份证号码</span><input v-model.trim="form.idNumber" autocomplete="off" maxlength="18" placeholder="18 位身份证号码" /></label>
            <label class="full"><span>身份证住址</span><textarea v-model.trim="form.idCardAddress" rows="2" placeholder="身份证登记住址"></textarea></label>
          </div>
        </div>

        <div v-if="cardIssuer || cardValidity" class="card-extra">
          <span v-if="cardIssuer"><b>签发机关</b>{{ cardIssuer }}</span>
          <span v-if="cardValidity"><b>有效期限</b>{{ cardValidity }}</span>
        </div>

        <div class="case-extra-grid">
          <label><span>现住址</span><textarea v-model.trim="form.currentAddress" rows="2" placeholder="当前实际居住地址"></textarea></label>
          <label><span>案件类型</span><input v-model.trim="form.caseType" autocomplete="off" placeholder="如：盗窃、诈骗、故意伤害等" /></label>
          <label><span>主审民警</span><input v-model.trim="form.officerName" autocomplete="off" /></label>
        </div>

        <div v-if="error" class="identity-note error">{{ error }}</div>
        <div v-else-if="cardApplied" class="identity-note success">身份证读取完成。请核对姓名、证件号、住址和照片后确认。</div>
        <div v-else-if="ocrApplied" class="identity-note success">身份证字段已由高拍仪 / OCR 回填，请核对后确认。</div>

        <footer class="identity-footer">
          <span>确认后创建案件并进入工作台；开始审讯仍需操作员在审讯页手动点击。</span>
          <div>
            <button type="button" :disabled="!!busy" @click="emit('close')">取消</button>
            <button class="primary" type="submit" :disabled="!!busy">{{ busy === 'submit' ? '创建中…' : '确认身份并创建询问' }}</button>
          </div>
        </footer>
      </form>
    </section>
  </div>
</template>

<style scoped>
.identity-mask { position: fixed; inset: 0; z-index: 1200; display: grid; place-items: center; padding: 20px; background: rgba(8, 22, 35, .68); }
.identity-modal { width: min(1180px, calc(100vw - 60px)); max-height: calc(100vh - 54px); overflow: auto; border: 1px solid #b9cad8; border-radius: 8px; background: #edf3f7; box-shadow: 0 24px 70px rgba(0,0,0,.32); color: #203447; }
.identity-header { position: sticky; top: 0; z-index: 3; display: flex; justify-content: space-between; gap: 24px; align-items: center; padding: 18px 22px; border-bottom: 1px solid #bccbd6; background: #f9fcfe; }
.step-kicker { display: block; margin-bottom: 4px; color: #47728f; font-size: 13px; font-weight: 700; }
.identity-header h2 { margin: 0; font-size: 25px; color: #173d5b; }
.identity-header p { margin: 5px 0 0; color: #62798a; font-size: 14px; }
.close-btn, .identity-methods button, .capture-actions button, .read-card-button, .identity-footer button { min-height: 48px; border: 1px solid #aabcc9; border-radius: 6px; background: #fff; color: #28495f; font-weight: 700; font-size: 15px; touch-action: manipulation; }
.close-btn { min-width: 86px; }
.identity-methods { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1px; padding: 0 22px; background: #b9c8d3; border-bottom: 1px solid #b9c8d3; }
.identity-methods button { border: 0; border-radius: 0; background: #f8fbfd; }
.identity-methods button.active { background: #1f6597; color: #fff; box-shadow: inset 0 -4px 0 #f4b03b; }
.card-reader-panel { display: grid; grid-template-columns: 360px minmax(0, 1fr); gap: 34px; align-items: center; margin: 22px; padding: 26px 34px; border: 1px solid #b5c8d6; border-radius: 8px; background: #fff; }
.reader-illustration { position: relative; height: 210px; display: grid; place-items: center; border: 2px dashed #91a8b8; border-radius: 10px; background: #f4f8fa; }
.reader-illustration.ready { border-color: #4a8b67; background: #f1faf5; }
.reader-illustration.success { box-shadow: inset 0 0 0 3px rgba(46,126,79,.14); }
.id-card-shape { width: 240px; height: 145px; display: grid; grid-template-columns: 74px 1fr; gap: 15px; padding: 17px; box-sizing: border-box; border: 2px solid #7b93a4; border-radius: 10px; background: linear-gradient(145deg,#fff,#eaf2f7); transform: rotate(-2deg); }
.portrait-placeholder { display: grid; place-items: center; border: 1px solid #aab9c4; background: #dfe8ee; color: #768896; font-size: 13px; }
.id-card-shape i { display: block; height: 7px; margin: 8px 0; border-radius: 8px; background: #b8c5ce; }
.reader-wave { position: absolute; width: 280px; height: 22px; bottom: 19px; border-bottom: 3px solid #4b83a8; border-radius: 50%; opacity: .55; }
.reader-copy h3 { margin: 0 0 8px; color: #173e5c; font-size: 22px; }
.reader-copy p { margin: 0 0 17px; color: #607889; line-height: 1.7; }
.read-card-button { min-width: 210px; border-color: #1f6597; background: #1f6597; color: #fff; font-size: 17px; }
.reader-state { margin-top: 14px; color: #8c4b3a; font-size: 13px; }
.reader-state span { display: inline-block; width: 9px; height: 9px; margin-right: 7px; border-radius: 50%; background: #b75b4f; }
.reader-state.available { color: #30734a; }
.reader-state.available span { background: #3e955e; }
.warning-text { color: #a04d2e !important; }
.ocr-intake-card { margin: 22px; padding: 20px; border: 1px solid #b8c9d5; border-radius: 8px; background: #fff; }
.ocr-toolbar { display: grid; grid-template-columns: minmax(280px,1fr) auto; gap: 18px; align-items: end; }
.ocr-toolbar label, .identity-grid label, .case-extra-grid label { display: grid; gap: 6px; color: #4a6273; font-size: 13px; font-weight: 700; }
.ocr-toolbar select, .identity-grid input, .identity-grid select, .identity-grid textarea, .case-extra-grid input, .case-extra-grid textarea { width: 100%; box-sizing: border-box; min-height: 44px; padding: 9px 11px; border: 1px solid #aebfcb; border-radius: 5px; background: #fff; color: #203447; font: 15px/1.45 "Microsoft YaHei", sans-serif; }
.capture-actions { display: flex; gap: 10px; }
.capture-actions button { padding: 0 16px; }
.ocr-review { display: grid; grid-template-columns: 360px 1fr; gap: 16px; margin-top: 18px; }
.id-preview { min-height: 180px; display: grid; place-items: center; border: 1px solid #c3d0d9; background: #eef3f6; }
.id-preview img { max-width: 100%; max-height: 240px; object-fit: contain; }
.ocr-raw { min-width: 0; }
.ocr-raw > span { color: #526c7e; font-size: 13px; font-weight: 700; }
.ocr-raw pre { min-height: 130px; max-height: 210px; overflow: auto; white-space: pre-wrap; word-break: break-all; padding: 12px; border: 1px solid #c7d2da; background: #f8fafb; }
.identity-form { padding: 0 22px 22px; }
.identity-result-title { display: flex; justify-content: space-between; align-items: center; padding: 16px 2px 10px; }
.identity-result-title > div { display: flex; align-items: baseline; gap: 10px; }
.identity-result-title strong { color: #173f5d; font-size: 20px; }
.identity-result-title span { color: #738696; font-size: 13px; }
.source-chip { padding: 5px 9px; border: 1px solid #8bb2cf; border-radius: 4px; background: #edf7ff; color: #24618e !important; font-weight: 700; }
.source-chip.success { border-color: #8bb99c; background: #eff9f2; color: #31734a !important; }
.source-chip.muted { border-color: #c7d0d7; background: #f4f6f7; color: #75848f !important; }
.identity-details-layout { display: grid; grid-template-columns: 168px minmax(0,1fr); gap: 20px; padding: 20px; border: 1px solid #b9cad6; background: #fff; }
.identity-portrait { height: 210px; display: grid; place-items: center; border: 1px solid #9fb2bf; background: #e7edf1; color: #7c8e9b; }
.identity-portrait img { width: 100%; height: 100%; object-fit: cover; }
.identity-grid { display: grid; grid-template-columns: repeat(4, minmax(0,1fr)); gap: 14px; }
.identity-grid .wide { grid-column: span 2; }
.identity-grid .full { grid-column: 1 / -1; }
.identity-grid textarea, .case-extra-grid textarea { resize: vertical; }
.card-extra { display: flex; gap: 34px; padding: 10px 20px; border: 1px solid #b9cad6; border-top: 0; background: #f8fbfd; color: #526979; font-size: 13px; }
.card-extra b { margin-right: 9px; color: #28485d; }
.case-extra-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 14px; margin-top: 14px; padding: 18px 20px; border: 1px solid #b9cad6; background: #fff; }
.identity-note { margin-top: 14px; padding: 11px 13px; border-radius: 5px; font-size: 14px; }
.identity-note.warning { border: 1px solid #e5c58f; background: #fff8e8; color: #8b5a13; }
.identity-note.error { border: 1px solid #e4aaa2; background: #fff0ee; color: #9a3027; }
.identity-note.success { border: 1px solid #9fc7ad; background: #eff9f2; color: #2f7048; }
.identity-footer { position: sticky; bottom: -22px; display: flex; justify-content: space-between; gap: 18px; align-items: center; margin: 18px -22px -22px; padding: 15px 22px; border-top: 1px solid #b9c8d3; background: #f9fcfe; }
.identity-footer > span { color: #687e8e; font-size: 13px; }
.identity-footer > div { display: flex; gap: 10px; }
.identity-footer button { min-width: 120px; padding: 0 16px; }
.identity-footer button.primary { min-width: 230px; border-color: #1f6597; background: #1f6597; color: #fff; }
button:disabled { opacity: .46; cursor: not-allowed; }
</style>
