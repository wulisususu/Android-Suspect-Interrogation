import { describe, expect, it } from 'vitest'
import fs from 'node:fs'
import path from 'node:path'

const root = path.resolve(__dirname)
const formal = fs.readFileSync(path.join(root, 'FormalTemplatePanel.vue'), 'utf8')
const live = fs.readFileSync(path.join(root, 'LiveDialoguePanel.vue'), 'utf8')
const interrogationStore = fs.readFileSync(path.join(root, '../stores/interrogation.ts'), 'utf8')
const templateStore = fs.readFileSync(path.join(root, '../stores/templateInterrogation.ts'), 'utf8')

describe('formal record editor source contract', () => {
  it('renders paper-style fixed/body/closing sections and top-right signing controls', () => {
    expect(formal).toContain('正式询问笔录编辑器')
    expect(formal).toContain('openingQuestions')
    expect(formal).toContain('bodyQuestions')
    expect(formal).toContain('closingQuestions')
    expect(formal).toContain('被询问人签名')
    expect(formal).toContain('结束并冻结笔录')
  })

  it('shares one stable drag MIME between live dialogue and the formal BODY', () => {
    const mime = 'application/x-formal-pending-question'
    expect(live).toContain(mime)
    expect(formal).toContain(mime)
    expect(formal).toContain("emit('insertPending'")
  })

  it('renders the canonical case-question answer while retaining round provenance', () => {
    expect(formal).toContain('formalAnswerText')
    expect(formal).toContain('canonicalAnswerDrafts')
    expect(formal).toContain("emit('updateAnswer', question.id, answer)")
    expect(formal).toContain('latestRound(q.id)?.actualQuestionText')
    expect(formal).not.toContain('answerDrafts[latestRound(q.id)!.id]')
    expect(formal).not.toContain('manualAnswerDrafts')
  })

  it('uses committed routing events as the formal-workspace correctness signal', () => {
    expect(interrogationStore).toContain('formalRecordRevision')
    expect(interrogationStore).toContain("event.event === 'QA_UNIT_UPDATED'")
    expect(interrogationStore).toContain("event.event === 'FORMAL_RECORD_UPDATED'")
    expect(interrogationStore).toContain('formalRecordRevision.value += 1')
    expect(templateStore).toContain('interrogation.formalRecordRevision')
    expect(templateStore).toContain('watch(')
  })

  it('retains raw-fragment workspace refresh as legacy-mode compatibility only', () => {
    expect(templateStore).toContain('upsertDialogue(fragment, scope)\n    scheduleWorkspaceRefresh(scope)')
  })
})
