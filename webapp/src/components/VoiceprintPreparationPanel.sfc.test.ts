import { readFileSync } from 'node:fs'
import { transformSync } from 'esbuild'
import { compileScript, compileTemplate, parse } from '@vue/compiler-sfc'
import * as Vue from 'vue'
import { describe, expect, it } from 'vitest'
import { audioInputMode } from '../config/audioInput'
import type { VoiceprintReadiness } from '../types/interrogation'

/**
 * The mode chip of `VoiceprintPreparationPanel.vue` used the declared mode, so a
 * device that cannot enforce it advertised "嫌疑人 + 主审民警" while the runtime
 * degraded to suspect-only. This suite renders the real SFC and drives it with
 * the same readiness payload `VoiceprintEnrollmentGate.test.ts` uses for its
 * degradation notice, so both surfaces must report the effective mode.
 *
 * The SFC's module-script helpers stay in the rendered component: only Vue
 * helpers and `audioInputMode` are supplied from outside, so nothing about the
 * chip or the notice is stubbed.
 */

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
  const source = readFileSync(new URL(fileName, import.meta.url), 'utf8').replace(/\r\n/g, '\n')
  const { descriptor } = parse(source, { filename: fileName })
  const script = compileScript(descriptor, { id: fileName })
  const template = compileTemplate({
    source: descriptor.template?.content || '',
    filename: fileName,
    id: fileName,
    compilerOptions: { mode: 'function', bindingMetadata: script.bindings },
  })
  if (template.errors.length) throw new Error(String(template.errors[0]))
  // The template render function is exported by the compiled script and is
  // redeclared below as the component's render definition. Imports are supplied
  // from outside, so only their declarations are needed here.
  const prepared = `${script.content
    .replace(/import[\s\S]*?from\s*['"][^'"]+['"];?/g, '')
    .replace(/^export (?=(?:function|const|let|class) )/gm, '')
    .replace(/^export default /m, 'return ')}\nreturn _defineComponent({ render })\n`
  const factorySource = `return function createComponent(Vue, dependencies) {
    const { defineComponent: _defineComponent, computed, ref } = Vue
    const { audioInputMode } = dependencies
    ${prepared}
  }`
  const createComponent = new Function(transformSync(factorySource, { loader: 'ts', target: 'es2022' }).code)()
  const component = createComponent(Vue, dependencies) as { render?: unknown }
  component.render = new Function('Vue', template.code)(Vue)
  return component
}

/**
 * The SFC's module-script helper declarations, lifted out of its compiled script
 * so the assertions below exercise the very same functions the rendered chip
 * calls. `new Function` cannot import, so the declarations are evaluated in the
 * test module instead of restated.
 */
function sfcModuleHelpers(fileName: string, names: string[]) {
  const source = readFileSync(new URL(fileName, import.meta.url), 'utf8').replace(/\r\n/g, '\n')
  const { descriptor } = parse(source, { filename: fileName })
  const compiled = compileScript(descriptor, { id: fileName }).content
  const declarations = names.map((name) => {
    const start = new RegExp(`^(?:export\\s+)?function\\s+${name}\\s*\\(`, 'm').exec(compiled)
    if (!start) throw new Error(`${name} is not declared in ${fileName}`)
    let parenDepth = 0
    let bodyStart = -1
    for (let index = compiled.indexOf('(', start.index); index < compiled.length; index += 1) {
      if (compiled[index] === '(') parenDepth += 1
      else if (compiled[index] === ')' && --parenDepth === 0) {
        bodyStart = compiled.indexOf('{', index)
        break
      }
    }
    if (bodyStart < 0) throw new Error(`${name} has no body`)
    let braceDepth = 0
    for (let index = bodyStart; index < compiled.length; index += 1) {
      if (compiled[index] === '{') braceDepth += 1
      else if (compiled[index] === '}' && --braceDepth === 0) {
        return compiled.slice(start.index, index + 1).replace(/^export\s+/, '')
      }
    }
    throw new Error(`${name} is not terminated`)
  })
  return new Function(
    transformSync(`${declarations.join('\n')}\nreturn { ${names.join(', ')} }`, { loader: 'ts', target: 'es2022' }).code,
  )() as Record<string, (...args: never[]) => unknown>
}

const { voiceprintDegradationNotice, voiceprintEffectiveMode, voiceprintModeLabel } = sfcModuleHelpers(
  './VoiceprintPreparationPanel.vue',
  ['voiceprintDegradationNotice', 'voiceprintEffectiveMode', 'voiceprintModeLabel'],
) as {
  voiceprintDegradationNotice: (readiness: VoiceprintReadiness) => string
  voiceprintEffectiveMode: (readiness: VoiceprintReadiness) => VoiceprintReadiness['recognitionMode']
  voiceprintModeLabel: (mode: VoiceprintReadiness['recognitionMode']) => string
}

const VoiceprintPreparationPanel = compileClientComponent('./VoiceprintPreparationPanel.vue', { audioInputMode })

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

function allNodes(target: TestNode): TestNode[] {
  return [target, ...target.children.flatMap(allNodes)]
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

function mount(readiness: VoiceprintReadiness) {
  const root = node('root')
  const app = renderer.createApp(VoiceprintPreparationPanel, {
    suspectName: '张某',
    readiness,
    officers: [],
    selectedInterrogatorOfficerId: null,
    selectedRecorderOfficerId: null,
    enrollmentState: { phase: 'IDLE', kind: 'SUSPECT' },
    busy: false,
    sessionStatus: 'READY',
  })
  app.provide(Vue.ssrContextKey, { modules: new Set<string>() })
  app.mount(root)
  return root
}

/** The chip element that states which recognition mode is in force. */
function modeChip(root: TestNode): TestNode {
  return findNode(root, (item) => String(item.props.class ?? '').includes('voiceprint-mode-chip'))
}

/** Field device without a calibrated margin: the declared mode is not enforced. */
const degradedReadiness: VoiceprintReadiness = {
  suspectReady: true,
  interrogatorReady: true,
  recorderReady: false,
  canStart: true,
  recognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
  declaredRecognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
  effectiveRecognitionMode: 'SUSPECT_ONLY',
  recognitionModeDegraded: true,
  recognitionModeDegradedReason: 'MARGIN_CALIBRATION_MISSING',
  marginConfigured: false,
  thresholdConfigured: true,
  speakerThreshold: 0.372,
}

describe('VoiceprintPreparationPanel effective mode presentation', () => {
  it('shows the effective recognition mode in the chip instead of the declared one', () => {
    const chip = modeChip(mount(degradedReadiness))

    // The chip must not promise a mode the runtime will not enforce.
    expect(textContent(chip).trim()).toBe('仅嫌疑人声纹识别')
    expect(textContent(chip)).not.toContain('主审民警')
  })

  it('announces the degradation with the same wording and a11y contract as the enrollment gate', () => {
    const root = mount(degradedReadiness)

    const notice = findNode(
      root,
      (item) => item.props.role === 'status' && textContent(item).includes('设备未完成 margin 校准'),
    )
    expect(textContent(notice)).toContain('已绑定民警声纹，但设备未完成 margin 校准，实时识别将退化为仅嫌疑人')
    expect(notice.props['aria-live']).toBe('polite')
    expect(notice.props['aria-atomic']).toBe('true')
  })

  it('renders no degradation notice when the device honours the declared mode', () => {
    const root = mount({
      ...degradedReadiness,
      effectiveRecognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
      recognitionModeDegraded: false,
      recognitionModeDegradedReason: null,
      marginConfigured: true,
    })

    expect(textContent(modeChip(root))).toContain('嫌疑人 + 主审民警')
    expect(textContent(root)).not.toContain('实时识别将退化为仅嫌疑人')
    expect(allNodes(root).filter((item) => item.props.role === 'status' && textContent(item).includes('退化'))).toEqual([])
  })

  it('falls back to the declared mode when readiness carries no effective mode', () => {
    // Readiness without the injected runtime config: nothing may be invented.
    const noRuntimeConfig: VoiceprintReadiness = {
      suspectReady: true,
      interrogatorReady: true,
      recorderReady: false,
      recognitionMode: 'SUSPECT_PLUS_INTERROGATOR',
      canStart: true,
    }
    expect(voiceprintEffectiveMode(noRuntimeConfig)).toBe('SUSPECT_PLUS_INTERROGATOR')
    expect(voiceprintDegradationNotice(noRuntimeConfig)).toBe('')
    expect(voiceprintModeLabel('FULL')).toBe('嫌疑人 + 主审民警 + 记录民警')

    const root = mount(noRuntimeConfig)
    expect(textContent(modeChip(root))).toContain('嫌疑人 + 主审民警')
    expect(textContent(root)).not.toContain('退化为仅嫌疑人')
  })
})
