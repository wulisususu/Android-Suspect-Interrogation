from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
path = ROOT / "webapp/src/components/VoiceprintPreparationPanel.vue"
text = path.read_text(encoding="utf-8")

def replace(old: str, new: str) -> None:
    global text
    if old not in text:
        raise SystemExit(f"Task10 preparation apply anchor missing: {old[:80]!r}")
    text = text.replace(old, new, 1)

replace(
    "import type { TemporaryAsrSpeaker, VoiceprintReadiness as VoiceprintReadinessModel, VoiceRecognitionMode } from '../types/interrogation'",
    "import type { SpeakerBackendKey, TemporaryAsrSpeaker, VoiceprintReadiness as VoiceprintReadinessModel, VoiceRecognitionMode } from '../types/interrogation'",
)
replace(
    "return { disabled: true, reason: '必须先完成嫌疑人声纹注册，才能开始正式语音审讯' }",
    "return { disabled: true, reason: '必须先完成 authoritative backend 的嫌疑人声纹注册，才能开始正式语音审讯' }",
)
replace(
    "export function temporarySpeakerPresentation(speaker: TemporaryAsrSpeaker, speakerName?: string | null) {",
    """export function speakerBackendLabel(backend: SpeakerBackendKey): string {\n  return backend === 'xvector' ? 'XVector' : 'ERes2Net-large'\n}\n\nexport function temporarySpeakerPresentation(speaker: TemporaryAsrSpeaker, speakerName?: string | null) {""",
)
text = text.replace("detail: 'XVector 声纹匹配'", "detail: 'authoritative 声纹匹配'")
replace(
    "const showSuspectProgress = computed(() => props.enrollmentState.phase !== 'IDLE' && props.enrollmentState.kind !== 'OFFICER')",
    """const showSuspectProgress = computed(() => props.enrollmentState.phase !== 'IDLE' && props.enrollmentState.kind !== 'OFFICER')\nconst authoritativeBackend = computed<SpeakerBackendKey>(() => props.readiness.authoritativeSpeakerBackend\n  || (props.readiness.selectedSpeakerBackend === 'eres2net_large' ? 'eres2net_large' : 'xvector'))""",
)
replace(
    "    <div v-if=\"readiness.simulated\" class=\"voiceprint-warning\">当前为浏览器开发模拟；模拟结果不能解锁正式声纹审讯。</div>\n\n    <div class=\"voiceprint-preparation-grid\">",
    """    <div v-if=\"readiness.simulated\" class=\"voiceprint-warning\">当前为浏览器开发模拟；模拟结果不能解锁正式声纹审讯。</div>\n\n    <div v-if=\"readiness.backends\" class=\"dual-backend-readiness\">\n      <div>\n        <strong>一次录制 · 双后端 reference</strong>\n        <span>业务 authoritative：{{ speakerBackendLabel(authoritativeBackend) }}；secondary 仅用于 Compare 诊断。</span>\n      </div>\n      <article v-for=\"backend in (['xvector', 'eres2net_large'] as const)\" :key=\"backend\">\n        <strong>{{ speakerBackendLabel(backend) }}</strong>\n        <span :class=\"{ ok: readiness.backends[backend].suspectReady }\">{{ readiness.backends[backend].suspectReady ? '嫌疑人 reference READY' : '嫌疑人 reference NOT READY' }}</span>\n        <small>{{ readiness.backends[backend].recognitionMode }}</small>\n      </article>\n    </div>\n    <p v-else class=\"dual-backend-hint\">嫌疑人声纹采用一次录制，同时尝试生成 XVector 与 ERes2Net-large 两套独立 reference；当前业务 authoritative={{ speakerBackendLabel(authoritativeBackend) }}。</p>\n\n    <div class=\"voiceprint-preparation-grid\">""",
)
replace(
    "{{ readiness.suspectReady ? '已注册' : '未注册' }}",
    "{{ readiness.suspectReady ? 'authoritative 已注册' : 'authoritative 未注册' }}",
)
replace(
    "有效语音已达标，正在进行最终 VAD 复核与 XVector 声纹聚合…",
    "有效语音已达标，正在进行最终 VAD 复核与双后端声纹 reference 聚合…",
)
replace(
    "嫌疑人声纹已就绪；民警声纹为可选项，绑定后冻结本次审讯使用的 reference 版本",
    "authoritative 嫌疑人声纹已就绪；secondary 不会改变业务角色，角色绑定后冻结本次审讯使用的 reference 版本",
)
replace(
    ".voiceprint-preparation-grid { display:grid; gap:8px; margin-top:12px; }",
    """.dual-backend-readiness { display:grid; grid-template-columns:minmax(240px,1.3fr) repeat(2,minmax(180px,1fr)); gap:8px; margin-top:10px; }\n.dual-backend-readiness > div,.dual-backend-readiness article { display:grid; gap:4px; padding:10px 12px; border:1px solid #c6d6e2; border-radius:8px; background:#fff; }\n.dual-backend-readiness span,.dual-backend-readiness small,.dual-backend-hint { color:#607588; font-size:12px; }\n.dual-backend-readiness span.ok { color:#267647; font-weight:700; }\n.dual-backend-hint { margin:10px 0 0; padding:9px 12px; border:1px solid #d2dee8; border-radius:7px; background:#fff; }\n.voiceprint-preparation-grid { display:grid; gap:8px; margin-top:12px; }""",
)
replace(
    "@media (max-width:980px) { .voiceprint-person-row { grid-template-columns:1fr; }",
    "@media (max-width:980px) { .voiceprint-person-row,.dual-backend-readiness { grid-template-columns:1fr; }",
)
path.write_text(text, encoding="utf-8")
print("Task10 preparation UI apply complete")
