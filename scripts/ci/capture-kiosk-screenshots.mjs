import { mkdir, writeFile } from 'node:fs/promises'
import { spawn } from 'node:child_process'

const baseUrl = process.env.KIOSK_URL || 'http://127.0.0.1:5173'
const caseId = process.env.KIOSK_CASE_ID || ''
const outputDir = process.env.KIOSK_SCREENSHOT_DIR || 'artifacts/kiosk-visual-qa'
const debugPort = Number(process.env.KIOSK_CHROME_DEBUG_PORT || 9222)

if (!caseId) throw new Error('KIOSK_CASE_ID is required')

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms))

function resolveChrome() {
  const candidates = [
    process.env.CHROME_BIN,
    '/usr/bin/google-chrome',
    '/usr/bin/google-chrome-stable',
    '/usr/bin/chromium',
    '/usr/bin/chromium-browser',
  ].filter(Boolean)
  return candidates[0]
}

class CdpClient {
  constructor(url) {
    this.url = url
    this.socket = null
    this.nextId = 1
    this.pending = new Map()
  }

  async connect() {
    this.socket = new WebSocket(this.url)
    this.socket.addEventListener('message', (event) => {
      const payload = JSON.parse(String(event.data))
      if (!payload.id) return
      const item = this.pending.get(payload.id)
      if (!item) return
      this.pending.delete(payload.id)
      if (payload.error) item.reject(new Error(payload.error.message || JSON.stringify(payload.error)))
      else item.resolve(payload.result)
    })
    await new Promise((resolve, reject) => {
      this.socket.addEventListener('open', resolve, { once: true })
      this.socket.addEventListener('error', reject, { once: true })
    })
  }

  send(method, params = {}) {
    const id = this.nextId++
    return new Promise((resolve, reject) => {
      this.pending.set(id, { resolve, reject })
      this.socket.send(JSON.stringify({ id, method, params }))
    })
  }

  close() {
    try { this.socket?.close() } catch {}
  }
}

async function waitFor(fn, description, timeoutMs = 30_000, intervalMs = 200) {
  const deadline = Date.now() + timeoutMs
  let lastError
  while (Date.now() < deadline) {
    try {
      const result = await fn()
      if (result) return result
    } catch (error) {
      lastError = error
    }
    await sleep(intervalMs)
  }
  throw new Error(`Timed out waiting for ${description}${lastError ? `: ${lastError.message}` : ''}`)
}

async function evaluate(client, expression) {
  const result = await client.send('Runtime.evaluate', {
    expression,
    awaitPromise: true,
    returnByValue: true,
  })
  if (result.exceptionDetails) throw new Error(result.exceptionDetails.text || 'Runtime.evaluate failed')
  return result.result?.value
}

async function waitForSelector(client, selector, timeoutMs = 30_000) {
  return waitFor(async () => evaluate(client, `Boolean(document.querySelector(${JSON.stringify(selector)}))`), selector, timeoutMs)
}

async function navigate(client, url, readySelector) {
  await client.send('Page.navigate', { url })
  await waitFor(async () => {
    const state = await evaluate(client, 'document.readyState')
    return state === 'complete' || state === 'interactive'
  }, `document ready for ${url}`)
  await waitForSelector(client, readySelector)
}

async function clickButtonContaining(client, text) {
  const expression = `(() => {
    const target = [...document.querySelectorAll('button')].find((button) => (button.textContent || '').includes(${JSON.stringify(text)}));
    if (!target) return false;
    target.click();
    return true;
  })()`
  await waitFor(async () => evaluate(client, expression), `button containing ${text}`)
}

async function setViewport(client, width, height) {
  await client.send('Emulation.setDeviceMetricsOverride', {
    width,
    height,
    deviceScaleFactor: 1,
    mobile: false,
  })
}

async function screenshot(client, name, width, height) {
  await setViewport(client, width, height)
  const capture = await client.send('Page.captureScreenshot', {
    format: 'png',
    fromSurface: true,
    captureBeyondViewport: false,
  })
  const path = `${outputDir}/${name}-${width}x${height}.png`
  await writeFile(path, Buffer.from(capture.data, 'base64'))
  console.log(`captured ${path}`)
}

await mkdir(outputDir, { recursive: true })
const chrome = resolveChrome()
console.log(`chrome=${chrome}`)

const browser = spawn(chrome, [
  '--headless=new',
  '--disable-gpu',
  '--no-sandbox',
  '--disable-dev-shm-usage',
  '--hide-scrollbars',
  '--force-device-scale-factor=1',
  '--window-size=1920,1080',
  `--remote-debugging-port=${debugPort}`,
  '--remote-debugging-address=127.0.0.1',
  'about:blank',
], { stdio: ['ignore', 'pipe', 'pipe'] })

browser.stderr.on('data', (chunk) => process.stderr.write(chunk))
browser.stdout.on('data', (chunk) => process.stdout.write(chunk))

let client
try {
  const target = await waitFor(async () => {
    const response = await fetch(`http://127.0.0.1:${debugPort}/json/list`)
    if (!response.ok) return null
    const targets = await response.json()
    return targets.find((item) => item.type === 'page' && item.webSocketDebuggerUrl)
  }, 'Chrome DevTools target')

  client = new CdpClient(target.webSocketDebuggerUrl)
  await client.connect()
  await client.send('Page.enable')
  await client.send('Runtime.enable')

  await navigate(client, `${baseUrl}/`, '.case-list-page')
  await screenshot(client, 'case-list', 1920, 1080)

  await clickButtonContaining(client, '新建询问')
  await waitForSelector(client, '.identity-modal')
  await sleep(500)
  await screenshot(client, 'identity-card', 1920, 1080)

  await navigate(client, `${baseUrl}/?caseId=${encodeURIComponent(caseId)}`, '.workspace')
  await clickButtonContaining(client, '审讯记录')
  await waitForSelector(client, '.template-interrogation-grid')
  await waitForSelector(client, '.formal-template-panel')
  await waitForSelector(client, '.live-dialogue-panel')
  await sleep(700)
  await screenshot(client, 'interrogation', 1920, 1080)
  await screenshot(client, 'interrogation', 1920, 900)

  const bodyText = await evaluate(client, 'document.body.innerText')
  if (!String(bodyText).includes('正式笔录') || !String(bodyText).includes('实时语音对话')) {
    throw new Error('Template interrogation two-column smoke assertion failed')
  }
} finally {
  client?.close()
  browser.kill('SIGTERM')
  await sleep(300)
  if (!browser.killed) browser.kill('SIGKILL')
}
