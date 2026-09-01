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

  it('highlights D-class qa units and exposes both drag modes without replacing raw dialogue', () => {
    expect(dialogueSource).toContain('qaUnits')
    expect(dialogueSource).toContain('待处理')
    expect(dialogueSource).toContain('qa-review-card')
    expect(dialogueSource).toContain('application/x-formal-qa-unit')
    expect(dialogueSource).toContain("mode: 'QA'")
    expect(dialogueSource).toContain("mode: 'ANSWER'")
    expect(dialogueSource).toContain('拖动整组问答')
    expect(dialogueSource).toContain('仅拖动答案')
    expect(dialogueSource).toContain("action: 'IGNORE'")
  })

  it('shows routing status chips for A/B/C while E stays muted and raw-only', () => {
    expect(dialogueSource).toContain('已归档·固定模板')
    expect(dialogueSource).toContain('已归档·已有问题')
    expect(dialogueSource).toContain('已新增·现场问题')
    expect(dialogueSource).toContain('已忽略·仅原始对话')
    expect(dialogueSource).toContain('qa-status-muted')
  })

  it('wires qa review resolution through the page and workspace stores', () => {
    expect(pageSource).toContain('resolveQaUnit')
    expect(pageSource).toContain('workspace.qaUnits')
    expect(workspaceSource).toContain('resolveQaUnit')
  })
})