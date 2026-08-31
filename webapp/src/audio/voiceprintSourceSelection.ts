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

  let browserCapture: BrowserVoiceprintCapture
  try {
    browserCapture = await acquire()
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error)
    if (message.includes('不是 HTTPS 安全环境')) {
      throw new Error('局域网浏览器麦克风尚未获得安全上下文。请使用 scripts/windows/launch-lan-browser-mic.ps1 启动测试浏览器并允许麦克风；不需要公网 HTTPS 或 FRP。')
    }
    throw error
  }
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
