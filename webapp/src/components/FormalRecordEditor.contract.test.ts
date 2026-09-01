import { describe, expect, it } from 'vitest'
import fs from 'node:fs'
import path from 'node:path'

const root = path.resolve(__dirname)
const formal = fs.readFileSync(path.join(root, 'FormalTemplatePanel.vue'), 'utf8')
const live = fs.readFileSync(path.join(root, 'LiveDialoguePanel.vue'), 'utf8')

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
})
