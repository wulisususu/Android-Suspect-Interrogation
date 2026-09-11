// Task 17A regression: drives the REAL browser flow against the deployed board and asserts
//   1) suspect voiceprint enrollment ends in success (no false "channel disconnected" failure)
//   2) the enrollment gate stays mounted after registration and offers 重新录制
//   3) clicking 重新录制 re-enrolls successfully (no DB surgery needed)
// Usage: node regression-17a.mjs [baseUrl] [--mic=<wav>] [--keepalive]
// Requires: Chrome already running with --remote-debugging-port=9222 and fake audio capture.
import { readFileSync, writeFileSync, mkdirSync, appendFileSync } from "node:fs";
import { setTimeout as sleep } from "node:timers/promises";

const OUT = "D:\\police Android\\task15\\browser";
const BASE = process.argv.find((a) => a.startsWith("http")) || "https://124.223.176.99:18080";
const PORT = 9222;
mkdirSync(OUT, { recursive: true });
const LOGFILE = OUT + "\\regression-17a.log";
writeFileSync(LOGFILE, `regression-17a start ${new Date().toISOString()}\n`);

function trace(msg) {
  appendFileSync(LOGFILE, `${new Date().toISOString()} ${msg}\n`);
}
process.on("uncaughtException", (e) => { trace("UNCAUGHT: " + e.stack); process.exit(1); });
process.on("unhandledRejection", (e) => { trace("UNHANDLED: " + (e && e.stack)); process.exit(1); });

let msgId = 0;
const pending = new Map();
let ws = null;
const report = { started: new Date().toISOString(), base: BASE, steps: [], passed: false };

function rec(name, ok, detail) {
  report.steps.push({ name, ok, detail: detail ?? null, at: new Date().toISOString() });
  trace(`${ok ? "PASS" : "FAIL"} ${name}${detail ? " | " + JSON.stringify(detail).slice(0, 220) : ""}`);
  console.log(`${ok ? "PASS" : "FAIL"}  ${name}${detail ? "  | " + JSON.stringify(detail).slice(0, 220) : ""}`);
}

async function connect() {
  for (let i = 0; i < 40; i++) {
    try {
      const list = await (await fetch(`http://127.0.0.1:${PORT}/json/list`)).json();
      const page = list.find((t) => t.type === "page" && t.webSocketDebuggerUrl);
      if (page) {
        ws = new WebSocket(page.webSocketDebuggerUrl);
        ws.addEventListener("message", (ev) => {
          const m = JSON.parse(ev.data);
          if (m.id && pending.has(m.id)) {
            const { res, rej } = pending.get(m.id);
            pending.delete(m.id);
            m.error ? rej(new Error(JSON.stringify(m.error))) : res(m.result);
          }
        });
        await new Promise((res, rej) => {
          ws.addEventListener("open", res, { once: true });
          ws.addEventListener("error", rej, { once: true });
        });
        await send("Runtime.enable");
        await send("Page.enable");
        return;
      }
    } catch {}
    await sleep(500);
  }
  throw new Error("no chrome devtools page target (start chrome with --remote-debugging-port=9222)");
}

function send(method, params = {}) {
  const id = ++msgId;
  return new Promise((res, rej) => {
    pending.set(id, { res, rej });
    ws.send(JSON.stringify({ id, method, params }));
    setTimeout(() => {
      if (pending.has(id)) { pending.delete(id); rej(new Error("timeout " + method)); }
    }, 60000);
  });
}


async function evalJS(expr) {
  const r = await send("Runtime.evaluate", { expression: expr, returnByValue: true, awaitPromise: true });
  if (r.exceptionDetails) throw new Error(r.exceptionDetails.exception?.description || "eval error");
  return r.result?.value;
}

async function shot(name) {
  const r = await send("Page.captureScreenshot", { format: "png", captureBeyondViewport: true });
  writeFileSync(`${OUT}\\${name}.png`, Buffer.from(r.data, "base64"));
}

const clickDeepest = (text, tags = "button,div,span,li") => `(() => {
  const t = ${JSON.stringify(text)};
  const cands = [...document.querySelectorAll(${JSON.stringify(tags)})]
    .filter((e) => e.getBoundingClientRect().width > 0 && (e.innerText || '').trim().includes(t));
  cands.sort((a, b) => a.innerText.length - b.innerText.length);
  if (!cands.length) return { ok: false };
  const el = cands[0];
  el.scrollIntoView({ block: 'center' });
  el.click();
  return { ok: true, tag: el.tagName, txt: el.innerText.trim().replace(/\\s+/g, ' ').slice(0, 40), disabled: el.disabled === true };
})()`;

const bodyText = `document.body.innerText.replace(/\\s+/g, ' ')`;
const readiness = `fetch('/api/v1/cases/' + (new URL(location.href).searchParams.get('caseId') || '') + '/voiceprints/readiness').then(r => r.json()).then(j => j.data)`;

async function waitFor(expr, timeoutMs, label) {
  const t0 = Date.now();
  while (Date.now() - t0 < timeoutMs) {
    const v = await evalJS(expr);
    if (v) return v;
    await sleep(1500);
  }
  throw new Error(`timeout waiting for ${label}`);
}

async function main() {
  await connect();
  trace("connected to CDP");

  // 1. fresh case through the real UI
  await send("Page.navigate", { url: `${BASE}/?audioInput=BROWSER` });
  await sleep(4000);
  const modalReady = `document.querySelector('[class*=modal], [role=dialog]') ? true : false`;
  let opened = false;
  for (let attempt = 0; attempt < 4 && !opened; attempt += 1) {
    await evalJS(clickDeepest("新建询问"));
    for (let wait = 0; wait < 6; wait += 1) {
      if (await evalJS(modalReady)) { opened = true; break; }
      await sleep(1500);
    }
    trace(`new-case modal attempt ${attempt + 1}: ${opened ? "open" : "not yet"}`);
  }
  rec("new-case identity modal opened", opened);
  if (!opened) { finish(); return; }
  await evalJS(clickDeepest("手动录入"));
  await evalJS(`(() => {
    const set = (el, v) => { const s = Object.getOwnPropertyDescriptor(HTMLInputElement.prototype, 'value').set; s.call(el, v);
      el.dispatchEvent(new Event('input', { bubbles: true })); el.dispatchEvent(new Event('change', { bubbles: true })); };
    const modal = document.querySelector('[class*=modal], [role=dialog]') || document;
    const inputs = [...modal.querySelectorAll('input')].filter((i) => i.getBoundingClientRect().width > 0);
    // exact-ish placeholders: the page-level search box also contains the word 姓名
    const byPh = (frag) => inputs.find((i) => (i.placeholder || '').includes(frag));
    const name = inputs.find((i) => (i.placeholder || '').trim() === '请输入姓名') || byPh('请输入姓名');
    if (name) set(name, '回归测试嫌疑人');
    const idn = byPh('18 位身份证号码');
    if (idn) set(idn, '320115199908124318');
    const nation = byPh('如：汉');
    if (nation) set(nation, '汉');
    const caseType = byPh('盗窃');
    if (caseType) set(caseType, '故意伤害');
    const officer = inputs.filter((i) => !(i.placeholder || '').trim()).pop();
    if (officer) set(officer, '李建国');
    const sels = [...modal.querySelectorAll('select')].filter((s) => s.getBoundingClientRect().width > 0);
    const gender = sels.find((s) => [...s.options].some((o) => o.text.includes('男')));
    if (gender) {
      const opt = [...gender.options].find((o) => o.text.includes('男'));
      const setSel = Object.getOwnPropertyDescriptor(HTMLSelectElement.prototype, 'value').set;
      setSel.call(gender, opt.value);
      gender.dispatchEvent(new Event('change', { bubbles: true }));
    }
    return { filled: inputs.map((i) => (i.placeholder || '(none)') + '=' + i.value).slice(0, 10) };
  })()`).then((r) => trace("fill result: " + JSON.stringify(r)));
  await evalJS(clickDeepest("确认身份并创建询问"));
  const caseId = await waitFor(`(location.search.match(/caseId=([^&]+)/) || [])[1] || ''`, 20000, "caseId in URL");
  trace("caseId=" + caseId);
  rec("create case via UI", Boolean(caseId), { caseId });

  // 2. gate visible before enrollment
  await sleep(3000);
  await evalJS(clickDeepest("审讯记录"));
  await sleep(3000);
  let text = await evalJS(bodyText);
  rec("gate shows 开始录制 when unregistered", text.includes("开始录制"), { hasGate: text.includes("正式审讯前置条件") });

  // 3. enroll from browser mic (fake device)
  const before = await evalJS(readiness);
  trace("starting enrollment, readiness before=" + JSON.stringify(before));
  await evalJS(`(() => { const b = [...document.querySelectorAll('button')].find((x) => x.getBoundingClientRect().width > 0 && (x.innerText || '').trim() === '开始录制'); if (!b) return false; b.click(); return true; })()`);
  await sleep(6000);
  // wait for the auto-registration to settle (success or failure text)
  const settled = await (async () => {
    const t0 = Date.now();
    while (Date.now() - t0 < 90000) {
      const t = await evalJS(bodyText);
      if (t.includes("已注册") || t.includes("注册失败") || t.includes("通道已断开")) {
        return { t, after: Math.round((Date.now() - t0) / 1000) };
      }
      await sleep(2000);
    }
    return { t: await evalJS(bodyText), after: -1 };
  })();
  const falseFailure = settled.t.includes("注册失败") || settled.t.includes("通道已断开");
  const ready1 = await evalJS(readiness);
  rec("no false failure message after enrollment", !falseFailure, { settledAfterS: settled.after, snippet: settled.t.slice(-160) });
  rec("readiness suspectReady=true after enrollment", Boolean(ready1?.suspectReady), { before: before?.suspectReady, after: ready1?.suspectReady });
  await shot("regression-17a-after-enroll");

  // 4. gate must remain mounted with 重新录制
  text = await evalJS(bodyText);
  const hasRerecord = text.includes("重新录制");
  trace("hasRerecord=" + hasRerecord);
  rec("gate stays mounted and offers 重新录制", hasRerecord, { hasGate: text.includes("正式审讯前置条件") });

  // 5. re-enroll through the UI (this is what used to be impossible)
  if (hasRerecord) {
    const clicked = await evalJS(`(() => { const b = [...document.querySelectorAll('button')].find((x) => x.getBoundingClientRect().width > 0 && (x.innerText || '').trim() === '重新录制'); if (!b) return false; b.click(); return true; })()`);
    await sleep(6000);
    const t0 = Date.now();
    let ok = false;
    let snippet = "";
    while (Date.now() - t0 < 90000) {
      const t = await evalJS(bodyText);
      snippet = t.slice(-160);
      if (t.includes("注册失败") || t.includes("通道已断开")) break;
      if (t.includes("已注册") && !t.includes("有效语音 0 /")) { ok = true; break; }
      await sleep(2000);
    }
    const ready2 = await evalJS(readiness);
    rec("re-enroll through UI succeeds without DB surgery", clicked && ok && Boolean(ready2?.suspectReady), { clicked, snippet });
    await shot("regression-17a-after-reenroll");
  }

  report.passed = report.steps.every((s) => s.ok);
  report.finished = new Date().toISOString();
  writeFileSync(`${OUT}\\regression-17a.json`, JSON.stringify(report, null, 1));
  console.log(`\nRESULT: ${report.passed ? "PASS" : "FAIL"}  (report: ${OUT}\\regression-17a.json)`);
  process.exit(report.passed ? 0 : 1);
}

await main();
