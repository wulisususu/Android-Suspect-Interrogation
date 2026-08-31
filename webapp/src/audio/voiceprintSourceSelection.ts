import { audioInputMode, type AudioInputMode } from '../config/audioInput'
import {
  acquireBrowserVoiceprintMic,
  type BrowserVoiceprintCapture,
} from './browserVoiceprintCapture'

export type AutoVoiceprintSourceSelection = {
  source: 'BROWSER' | 'ALSA'
  browserCapture: BrowserVoiceprintCapture | null
  reason: string
}

export async function selectVoiceprintSource(
  mode: AudioInputMode,
  acquire: () => Promise<BrowserVoiceprintCapture> = acquireBrowserVoiceprintMic,
): Promise<AutoVoiceprintSourceSelection> {
  if (mode === 'ALSA') {
    return {
      source: 'ALSA',
      browserCapture: null,
      reason: '生产音源：Linux 一体机 ALSA 麦克风。浏览器不会请求麦克风权限。',
    }
  }

  const browserCapture = await acquire()
  return {
    source: 'BROWSER',
    browserCapture,
    reason: '测试音源：当前 Windows 浏览器麦克风，经局域网发送到 Linux 后端。',
  }
}

// Compatibility name retained for the existing composable. Selection is no
// longer AUTO: the configured test/production mode is authoritative.
export function selectAutoVoiceprintSource(
  acquire: () => Promise<BrowserVoiceprintCapture> = acquireBrowserVoiceprintMic,
) {
  return selectVoiceprintSource(audioInputMode, acquire)
}
