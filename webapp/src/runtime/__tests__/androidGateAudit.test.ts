import { readFileSync } from 'node:fs'
import { resolve } from 'node:path'
import { describe, expect, it } from 'vitest'

const migratedBusinessFiles = [
  'src/api/interrogation.ts',
  'src/api/caseProfile.ts',
  'src/api/documentSigning.ts',
  'src/components/IdentityIntakeModal.vue',
  'src/components/DeviceStatusBar.vue',
  'src/components/AiSettingsPanel.vue',
  'src/components/InterrogationPage.vue',
  'src/stores/interrogation.ts',
]

const forbidden = [
  'isNativeBusinessRuntime',
  'isNativeDeviceRuntime',
  '仅在 Android APK',
  'Android APK 中可用',
]

describe('Linux business runtime gate audit', () => {
  it.each(migratedBusinessFiles)('%s contains no Android-only business gate', (relativePath) => {
    const source = readFileSync(resolve(process.cwd(), relativePath), 'utf8')
    for (const token of forbidden) {
      expect(source, `${relativePath} still contains forbidden runtime gate: ${token}`).not.toContain(token)
    }
  })
})
