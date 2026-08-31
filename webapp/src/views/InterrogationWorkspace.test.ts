import { describe, expect, it } from 'vitest'
import source from './InterrogationWorkspace.vue?raw'

describe('interrogation workspace top bar', () => {
  it('does not render the device capability and fingerprint action module', () => {
    expect(source).not.toContain("import DeviceStatusBar from '../components/DeviceStatusBar.vue'")
    expect(source).not.toContain('<DeviceStatusBar />')
  })
})
