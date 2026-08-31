import { acquireBrowserVoiceprintMic, type BrowserVoiceprintCapture } from './browserVoiceprintCapture'

export type AutoVoiceprintSourceSelection = {
  source: 'BROWSER' | 'ALSA'
  browserCapture: BrowserVoiceprintCapture | null
  reason: string
}

export async function selectAutoVoiceprintSource(
  acquire: () => Promise<BrowserVoiceprintCapture> = acquireBrowserVoiceprintMic,
): Promise<AutoVoiceprintSourceSelection> {
  try {
    const browserCapture = await acquire()
    return { source: 'BROWSER', browserCapture, reason: '' }
  } catch (error) {
    const reason = error instanceof Error ? error.message : String(error)
    return {
      source: 'ALSA',
      browserCapture: null,
      reason: `${reason}；已改用 RK3588 开发板麦克风（现场）`,
    }
  }
}
