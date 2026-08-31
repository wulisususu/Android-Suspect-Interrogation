import { describe, expect, it } from 'vitest'
import source from './InterrogationWorkspace.vue?raw'

describe('interrogation workspace top bar', () => {
  it('does not render the device capability and fingerprint action module', () => {
    expect(source).not.toContain("import DeviceStatusBar from '../components/DeviceStatusBar.vue'")
    expect(source).not.toContain('<DeviceStatusBar />')
  })

  it('places session actions beside the page tabs instead of above the interrogation content', () => {
    const navigation = source.indexOf('<nav class="workspace-page-tabs"')
    const controls = source.indexOf('<SessionControls')
    const content = source.indexOf('<section class="workspace-page-body"')

    expect(navigation).toBeGreaterThanOrEqual(0)
    expect(controls).toBeGreaterThan(navigation)
    expect(controls).toBeLessThan(content)
    expect(source).not.toContain(':stage-text="store.stageText"')
  })

})
