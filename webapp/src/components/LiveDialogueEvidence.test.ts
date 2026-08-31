import { describe, expect, it } from 'vitest'
import dialogueSource from './LiveDialoguePanel.vue?raw'
import pageSource from './TemplateDrivenInterrogationPage.vue?raw'
import workspaceSource from '../views/InterrogationWorkspace.vue?raw'


describe('recognition evidence workbench contract', () => {
  it('shows independent AI recognition evidence on every dialogue turn', () => {
    expect(dialogueSource).toContain('识别证据')
    expect(dialogueSource).toContain('recognitionEvidence')
    expect(dialogueSource).toContain('thresholdSource')
    expect(dialogueSource).toContain('speakerModelVersion')
    expect(dialogueSource).toContain('AI 原判')
  })

  it('allows a human correction without hiding the original AI decision', () => {
    expect(dialogueSource).toContain('人工修正')
    expect(dialogueSource).toContain('correctionReason')
    expect(dialogueSource).toContain("emit('correctFragment'")
    expect(pageSource).toContain('correctFragment')
    expect(workspaceSource).toContain('correctRecognitionFragment')
  })
})
