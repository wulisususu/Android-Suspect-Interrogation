import { readFileSync } from 'node:fs'
import { transformSync } from 'esbuild'
import { compileScript, compileTemplate, parse } from '@vue/compiler-sfc'
import * as Vue from 'vue'
import { describe, expect, it } from 'vitest'
import { voiceprintEnrollmentProgress } from './VoiceprintPreparationPanel.vue'
import { audioInputMode } from '../config/audioInput'
import type { OfficerVoiceprint, VoiceprintEnrollmentState, VoiceprintReadiness } from '../types/interrogation'

type TestNode = {
  type: string
  text: string
  props: Record<string, unknown>
  children: TestNode[]
  parent: TestNode | null
}

function node(type: string, text = ''): TestNode {
  return { type, text, props: {}, children: [], parent: null }
}

function compileClientComponent(fileName: string, dependencies: Record<string, unknown>) {
  const source = readFileSync(new URL(fileName, import.meta.url), 'utf8')
  const { descriptor } = parse(source, { filename: fileName })
  const script = compileScript(descriptor, { id: fileName })
  const result = compileTemplate({
    source: descriptor.template?.content || '',
    filename: fileName,
    id: fileName,
    compilerOptions: { mode: 'function', bindingMetadata: script.bindings },
  })
  if (result.errors.length) throw new Error(String(result.errors[0]))
  const scriptWithoutImports = script.content
    .replace(/^import(?: type)? .*?\r?\n/gm, '')
    .replace('export default', 'return')
    .replace(/Object\.defineProperty\(__returned__, '__isScriptSetup', \{ enumerable: false, value: true \}\)\r?\n/, '')
  const factorySource = `return function createComponent(Vue, dependencies) {
    const { defineComponent: _defineComponent, computed, unref } = Vue
    const { voiceprintEnrollmentProgress, VoiceprintAudioSourceBanner, audioInputMode } = dependencies
    ${scriptWithoutImports}
  }`
  const createComponent = new Function(transformSync(factorySource, { loader: 'ts', target: 'es2022' }).code)()
  const component = createComponent(Vue, dependencies) as { render?: unknown }
  component.render = new Function('Vue', result.code)(Vue)
  return component
}

const VoiceprintAudioSourceBanner = compileClientComponent('./VoiceprintAudioSourceBanner.vue', { audioInputMode })
const VoiceprintEnrollmentGate = compileClientComponent('./VoiceprintEnrollmentGate.vue', {
  voiceprintEnrollmentProgress,
  VoiceprintAudioSourceBanner,
})

const renderer = Vue.createRenderer<TestNode, TestNode>({
  patchProp(element, key, _previous, next) { element.props[key] = next },
  insert(child, parent, anchor) {
    child.parent = parent
    if (anchor) parent.children.splice(parent.children.indexOf(anchor), 0, child)
    else parent.children.push(child)
  },
  remove(child) {
    if (child.parent) child.parent.children.splice(child.parent.children.indexOf(child), 1)
  },
  createElement(type) { return node(type) },
  createText(text) { return node('#text', text) },
  createComment(text) { return node('#comment', text) },
  setText(target, text) { target.text = text },
  setElementText(target, text) { target.children = []; target.text = text },
  parentNode(target) { return target.parent },
  nextSibling(target) {
    const siblings = target.parent?.children ?? []
    return siblings[siblings.indexOf(target) + 1] ?? null
  },
})

const readiness: VoiceprintReadiness = {
  suspectReady: false,
  interrogatorReady: false,
  recorderReady: false,
  recognitionMode: 'SUSPECT_ONLY',
  canStart: false,
}

function mount(
  enrollmentState: VoiceprintEnrollmentState,
  handlers: Record<string, (...args: unknown[]) => void> = {},
  roleProps: Partial<{
    officers: OfficerVoiceprint[]
    selectedInterrogatorOfficerId: string | null
    selectedRecorderOfficerId: string | null
  }> = {},
) {
  const root = node('root')
  const app = renderer.createApp(VoiceprintEnrollmentGate, {
    suspectName: '张某',
    readiness,
    enrollmentState,
    busy: false,
    source: 'BROWSER',
    reason: '测试音源',
    secureContext: true,
    officers: [],
    selectedInterrogatorOfficerId: null,
    selectedRecorderOfficerId: null,
    ...roleProps,
    ...handlers,
  })
  app.provide(Vue.ssrContextKey, { modules: new Set<string>() })
  app.mount(root)
  return root
}

function textContent(target: TestNode): string {
  return `${target.text}${target.children.map(textContent).join('')}`
}

function findNode(target: TestNode, predicate: (item: TestNode) => boolean): TestNode {
  if (predicate(target)) return target
  for (const child of target.children) {
    try {
      return findNode(child, predicate)
    } catch {
      // Search the next sibling subtree.
    }
  }
  throw new Error('Matching node not found')
}

function click(root: TestNode, label: string) {
  const button = findNode(root, (item) => item.type === 'button' && textContent(item).includes(label))
  ;(button.props.onClick as () => void)()
}

describe('VoiceprintEnrollmentGate', () => {
  it('renders the audio banner and start control before suspect enrollment', () => {
    const root = mount({ phase: 'IDLE', kind: 'SUSPECT' })

    expect(textContent(root)).toContain('音源：Windows 浏览器麦克风（局域网测试）')
    expect(textContent(root)).toContain('测试音源')
    expect(textContent(root)).toContain('嫌疑人 · 张某')
    expect(textContent(root)).toContain('尚未注册')
    expect(textContent(root)).toContain('开始录制')
  })

  it('emits suspectStart from the idle control', () => {
    const emitted: string[] = []
    const root = mount({ phase: 'IDLE', kind: 'SUSPECT' }, { onSuspectStart: () => emitted.push('suspectStart') })

    click(root, '开始录制')

    expect(emitted).toEqual(['suspectStart'])
  })

  it('keeps optional officer role binding collapsed and emits the selected roles', () => {
    const emitted: unknown[][] = []
    const root = mount(
      { phase: 'IDLE', kind: 'SUSPECT' },
      {
        onSelectInterrogator: (officerId) => emitted.push(['interrogator', officerId]),
        onSelectRecorder: (officerId) => emitted.push(['recorder', officerId]),
        onBindRoles: () => emitted.push(['bind']),
      },
      {
        officers: [{ officerId: 'officer-1', officerName: '李警官', active: true, modelId: 'eres2net-large', enrollmentQuality: 'GOOD', usableDurationMs: 20_000 }],
      },
    )

    const optionalSection = findNode(root, (item) => item.type === 'details' && textContent(item).includes('可选：绑定民警声纹'))
    expect(optionalSection.props.open).toBeUndefined()
    const interrogator = findNode(root, (item) => item.type === 'select' && item.props['aria-label'] === '选择主审民警声纹')
    const recorder = findNode(root, (item) => item.type === 'select' && item.props['aria-label'] === '选择记录民警声纹')
    expect(interrogator.props.value).toBe('')
    expect(recorder.props.value).toBe('')

    ;(interrogator.props.onChange as (event: Event) => void)({ target: { value: 'officer-1' } } as unknown as Event)
    ;(recorder.props.onChange as (event: Event) => void)({ target: { value: 'officer-1' } } as unknown as Event)
    click(root, '保存本次角色选择')

    expect(emitted).toEqual([['interrogator', 'officer-1'], ['recorder', 'officer-1'], ['bind']])
  })

  it('renders effective-speech progress and emits suspectStop while recording', () => {
    const emitted: string[] = []
    const root = mount({
      phase: 'RECORDING',
      kind: 'SUSPECT',
      capturedDurationMs: 30000,
      usableDurationMs: 12500,
      targetDurationMs: 20000,
    }, { onSuspectStop: () => emitted.push('suspectStop') })

    expect(textContent(root)).toContain('有效语音 12 / 20 秒')
    expect(textContent(root)).toContain('提前停止并尝试注册')
    click(root, '提前停止并尝试注册')

    expect(emitted).toEqual(['suspectStop'])
  })

  it('announces each enrollment phase in a polite live status region', () => {
    const states: Array<[VoiceprintEnrollmentState, string]> = [
      [{ phase: 'RECORDING', kind: 'SUSPECT' }, '正在采集嫌疑人有效语音'],
      [{ phase: 'PROCESSING', kind: 'SUSPECT' }, '正在进行最终声纹注册'],
      [{ phase: 'ERROR', kind: 'SUSPECT', message: '录音中断' }, '声纹注册失败：录音中断'],
      [{ phase: 'COMPLETE', kind: 'SUSPECT' }, '声纹注册完成，已解锁正式审讯与实时对话。'],
    ]

    for (const [state, status] of states) {
      const root = mount(state)
      const liveRegion = findNode(root, (item) => item.props.role === 'status' && item.props['aria-live'] === 'polite')
      expect(textContent(liveRegion)).toContain(status)
    }
  })
})
