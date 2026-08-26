from pathlib import Path


def replace_once(path: Path, old: str, new: str):
    text = path.read_text()
    count = text.count(old)
    if count != 1:
        raise SystemExit(f"{path}: expected exactly one match, got {count}: {old[:100]!r}")
    path.write_text(text.replace(old, new, 1))


store = Path("webapp/src/stores/interrogation.ts")
replace_once(store, "  changeSessionStage,\n", "  changeSessionStage,\n  connectRuntimeSession,\n")
replace_once(store, "  fetchAsrCaptureStatus,\n", "  fetchAsrCaptureStatus,\n  fetchRuntimeCapabilities,\n")
replace_once(store, "import { isNativeBusinessRuntime, onNativeEvent } from '../native/rpcBridge'\n", "import type { RuntimeSessionConnection } from '../runtime'\n")
replace_once(store, "  const nativeCaptureAvailable = isNativeBusinessRuntime()\n", "  const captureAvailable = ref(false)\n")
replace_once(store, "  let removeCaptureListener: (() => void) | undefined\n", "  let sessionConnection: RuntimeSessionConnection | undefined\n")
replace_once(store, "    removeCaptureListener?.()\n    removeCaptureListener = undefined\n", "    sessionConnection?.close()\n    sessionConnection = undefined\n")
replace_once(store, "    revisionsOpen.value = false\n    captureBusy.value = false\n", "    revisionsOpen.value = false\n    captureAvailable.value = false\n    captureBusy.value = false\n")
replace_once(
    store,
    """  function initializeCaptureEvents(scope: CaseScope) {
    if (!nativeCaptureAvailable || removeCaptureListener || !scope.caseId) return
    removeCaptureListener = onNativeEvent<AsrCaptureStatus>('asr.capture.status', (status) => {
      applyCaptureStatus(status, scope)
    })
  }
""",
    """  function initializeRuntimeEvents(scope: CaseScope) {
    if (sessionConnection || !scope.caseId || !session.value.id) return
    sessionConnection = connectRuntimeSession(session.value.id, (event) => {
      if (!isCurrentScope(scope)) return
      if (event.event === 'ASR_PARTIAL') {
        const payload = event.payload as { text?: string; partialText?: string }
        capture.value.partialText = payload.partialText ?? payload.text ?? capture.value.partialText
        return
      }
      if (event.event === 'ASR_FINAL') {
        const payload = event.payload as { text?: string }
        if (payload.text) capture.value.partialText = payload.text
        return
      }
      if (event.event === 'RECORDING_STATE' || event.event === 'asr.capture.status') {
        const status = event.payload as Partial<AsrCaptureStatus>
        if (status.caseId === scope.caseId && typeof status.running === 'boolean' && Array.isArray(status.fragments)) {
          applyCaptureStatus(status as AsrCaptureStatus, scope)
        }
        return
      }
      if (event.event === 'SESSION_STATE') {
        const next = event.payload as Partial<SessionState>
        if (next.caseId && next.caseId !== scope.caseId) return
        session.value = {
          ...session.value,
          ...next,
          caseId: scope.caseId,
          updatedAt: next.updatedAt ?? Date.now(),
        }
      }
    })
  }
""",
)
replace_once(
    store,
    """      initializeCaptureEvents(scope)
      const [messages, factItems, timelineItems, sessionState, captureStatus, analyses] = await Promise.all([
""",
    """      const runtimeCapabilities = await fetchRuntimeCapabilities()
      captureAvailable.value = runtimeCapabilities.recording.state === 'AVAILABLE' || runtimeCapabilities.asr.state === 'AVAILABLE'
      const [messages, factItems, timelineItems, sessionState, captureStatus, analyses] = await Promise.all([
""",
)
replace_once(store, "        nativeCaptureAvailable ? fetchAsrCaptureStatus(requestedCaseId) : Promise.resolve(null),\n", "        captureAvailable.value ? fetchAsrCaptureStatus(requestedCaseId) : Promise.resolve(null),\n")
replace_once(store, "      session.value = sessionState\n      if (captureStatus) applyCaptureStatus(captureStatus, scope)\n", "      session.value = sessionState\n      initializeRuntimeEvents(scope)\n      if (captureStatus) applyCaptureStatus(captureStatus, scope)\n")
replace_once(store, "    if (!nativeCaptureAvailable) return feedback('连续离线录音仅在 Android APK 中可用', true)\n", "    if (!captureAvailable.value) return feedback('连续离线录音 Runtime 当前不可用，请检查 ASR/麦克风能力状态', true)\n")
replace_once(store, "    if (!nativeCaptureAvailable || captureBusy.value || !capture.value.running) return\n", "    if (!captureAvailable.value || captureBusy.value || !capture.value.running) return\n")
replace_once(
    store,
    """      session.value = nextSession
      await refreshCase(scope)
      feedbackIfCurrent(scope, '审讯已开始：录入问答和 AI SSE 主链路已解锁')
""",
    """      session.value = nextSession
      disposeCaptureEvents()
      initializeRuntimeEvents(scope)
      await refreshCase(scope)
      feedbackIfCurrent(scope, '审讯已开始：录入问答和本地 AI 主链路已解锁')
""",
)
replace_once(store, "    nativeCaptureAvailable,\n", "    nativeCaptureAvailable: captureAvailable,\n")

page = Path("webapp/src/components/InterrogationPage.vue")
replace_once(page, "import { isNativeBusinessRuntime } from '../native/rpcBridge'\n", "")
replace_once(page, "const native = isNativeBusinessRuntime()\n", "")
replace_once(
    page,
    """async function loadSigningState() {
  if (!native || !props.caseId) {
""",
    """async function loadSigningState() {
  if (!props.caseId) {
""",
)
replace_once(page, ":title=\"nativeCaptureAvailable ? '开始 / 停止离线录音' : '录音仅在 Android APK 中可用'\"", ":title=\"nativeCaptureAvailable ? '开始 / 停止离线录音' : '连续离线录音 Runtime 当前不可用'\"")

print("Patch applied successfully")
