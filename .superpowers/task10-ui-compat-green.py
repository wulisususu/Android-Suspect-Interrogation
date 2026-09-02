from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

prep = ROOT / "webapp/src/components/VoiceprintPreparationPanel.vue"
text = prep.read_text(encoding="utf-8")
old = "return { disabled: true, reason: '必须先完成 authoritative backend 的嫌疑人声纹注册，才能开始正式语音审讯' }"
new = "return { disabled: true, reason: '必须先完成嫌疑人声纹注册，才能开始正式语音审讯' }"
if old not in text:
    raise SystemExit("Task10 compatibility anchor missing: voiceprint guard")
text = text.replace(old, new, 1)
if "detail: 'authoritative 声纹匹配'" not in text:
    raise SystemExit("Task10 compatibility anchor missing: speaker presentation")
text = text.replace("detail: 'authoritative 声纹匹配'", "detail: 'XVector 声纹匹配'")
prep.write_text(text, encoding="utf-8")

cal = ROOT / "webapp/src/components/SpeakerCalibrationCenter.vue"
text = cal.read_text(encoding="utf-8")
old = "import type { SpeakerCalibrationStatus } from '../api/speakerCalibration'"
new = "import type { SpeakerBackendKey, SpeakerCalibrationStatus } from '../api/speakerCalibration'"
if old not in text:
    raise SystemExit("Task10 compatibility anchor missing: calibration imports")
text = text.replace(old, new, 1)
old = """export function calibrationStatusLabel(status: SpeakerCalibrationStatus): string {\n  return {\n    NOT_CALIBRATED: '尚未校准',\n    VALID: '校准有效',\n    STALE_MODEL: '模型已更换',\n    STALE_MIC: '麦克风已更换',\n    RECOMPUTE_RECOMMENDED: '建议重新计算',\n    INSUFFICIENT_DATA: '样本不足',\n  }[status]\n}"""
new = """export function calibrationStatusLabel(\n  status: SpeakerCalibrationStatus,\n  backend: SpeakerBackendKey = 'xvector',\n): string {\n  if (status === 'STALE_MODEL') {\n    return backend === 'xvector' ? 'XVector 已更换' : 'ERes2Net-large 已更换'\n  }\n  return {\n    NOT_CALIBRATED: '尚未校准',\n    VALID: '校准有效',\n    STALE_MODEL: 'XVector 已更换',\n    STALE_MIC: '麦克风已更换',\n    RECOMPUTE_RECOMMENDED: '建议重新计算',\n    INSUFFICIENT_DATA: '样本不足',\n  }[status]\n}"""
if old not in text:
    raise SystemExit("Task10 compatibility anchor missing: calibration label")
text = text.replace(old, new, 1)
old = "{{ calibrationStatusLabel(state.status) }}"
new = "{{ calibrationStatusLabel(state.status, selectedBackend) }}"
if old not in text:
    raise SystemExit("Task10 compatibility anchor missing: calibration label call")
text = text.replace(old, new, 1)
cal.write_text(text, encoding="utf-8")

print("Task10 UI compatibility apply complete")
