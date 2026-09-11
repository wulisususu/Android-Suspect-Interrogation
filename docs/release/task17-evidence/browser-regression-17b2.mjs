// Task 17B-2 end-to-end acceptance: the mixed-turn utterance must not be attributed wholesale
// to the suspect in the LIVE realtime chain.
//
// Preconditions (the driver sets these up):
//   - Chrome running with --remote-debugging-port=9222 and
//     --use-file-for-fake-audio-capture=<the 182 s dialogue wav>
//   - the board serves the 17B-2 build (splitter wired into the speech worker)
//
// What it does: opens a case that already has a registered suspect voiceprint, starts the
// interrogation recording through the real UI, lets the dialogue play, stops, then reads
// /asr/fragments and asserts the production invariant:
//
//   the officer question "除了李伟以外" and the suspect answer "一开始没有" must NOT appear
//   inside the same fragment labelled SUSPECT
//
// A split into two fragments, or an UNKNOWN/待确认 label on the transition, both count as a
// pass; a single SUSPECT fragment carrying both sentences is the failure this task exists to
// prevent.
//
// Usage: node regression-17b2.mjs [baseUrl] [--seconds=150]
import { writeFileSync, mkdirSync, appendFileSync } from "node:fs";
import { setTimeout as sleep } from "node:timers/promises";

const OUT = "D:\\police Android\\task15\\browser";
const BASE = process.argv.find((a) => a.startsWith("http")) || "https://124.223.176.99:18080";
const SECONDS = Number((process.argv.find((a) => a.startsWith("--seconds=")) || "--seconds=150").split("=")[1]);
const PORT = 9222;
mkdirSync(OUT, { recursive: true });
const LOG = OUT + "\\regression-17b2.log";
writeFileSync(LOG, `regression-17b2 start ${new Date().toISOString()}\n`);
const trace = (m) => appendFileSync(LOG, `${new Date().toISOString()} ${m}\n`);
process.on("uncaughtException", (e) => { trace("UNCAUGHT: " + e.stack); process.exit(1); });
process.on("unhandledRejection", (e) => { trace("UNHANDLED: " + (e && e.stack)); process.exit(1); });

const OFFICER_MARK = "除了李伟以外";
const SUSPECT_MARK = "一开始没有";
const report = { started: new Date().toISOString(), base: BASE, steps: [], passed: false };
function rec(name, ok, detail) {
  report.steps.push({ name, ok, detail: detail ?? null, at: new Date().toISOString() });
  trace(`${ok ? "PASS" : "FAIL"} ${name}${detail ? " | " + JSON.stringify(detail).slice(0, 400) : ""}`);
  console.log(`${ok ? "PASS" : "FAIL"}  ${name}`);
}

let ws = null, msgId = 0;
const pending = new Map();
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
  throw new Error("no chrome devtools page target");
}
function send(method, params = {}) {
  const id = ++msgId;
  return new Promise((res, rej) => {
    pending.set(id, { res, rej });
    ws.send(JSON.stringify({ id, method, params }));
    setTimeout(() => { if (pending.has(id)) { pending.delete(id); rej(new Error("timeout " + method)); } }, 60000);
  });
}
async function evalJS(expr) {
  const r = await send("Runtime.evaluate", { expression: expr, returnByValue: true, awaitPromise: true });
  if (r.exceptionDetails) throw new Error(r.exceptionDetails.exception?.description || "eval error");
  return r.result?.value;
}
const clickDeepest = (text) => `(() => {
  const t = ${JSON.stringify(text)};
  const c = [...document.querySelectorAll('button,div,span,li')]
    .filter((e) => e.getBoundingClientRect().width > 0 && (e.innerText || '').trim().includes(t));
  c.sort((a, b) => a.innerText.length - b.innerText.length);
  if (!c.length) return { ok: false };
  c[0].scrollIntoView({ block: 'center' });
  c[0].click();
  return { ok: true, txt: c[0].innerText.trim().slice(0, 30) };
})()`;

async function main() {
  await connect();
  trace("connected");

  // pick a case whose suspect voiceprint is registered and whose interrogation can start
  const caseId = await evalJS(`(async () => {
    const j = await (await fetch('/api/v1/cases?limit=30')).json();
    for (const c of (j.data || [])) {
      const r = await (await fetch('/api/v1/cases/' + c.id + '/voiceprints/readiness')).json();
      if (r.data && r.data.suspectReady) return c.id;
    }
    return '';
  })()`);
  rec("found a case with a registered suspect voiceprint", Boolean(caseId), { caseId });
  if (!caseId) { finish(); return; }

  await send("Page.navigate", { url: `${BASE}/?caseId=${caseId}&audioInput=BROWSER` });
  await sleep(5000);
  await evalJS(clickDeepest("审讯记录"));
  await sleep(3000);

  // start the session if the button is still offering to
  const started = await evalJS(`(() => {
    const b = document.querySelector('button.session-primary');
    if (!b) return 'no-button';
    if (b.disabled) return 'disabled';
    if (b.innerText.includes('开始审讯')) { b.click(); return 'session-started'; }
    return 'already-running:' + b.innerText.trim();
  })()`);
  const sessionActive = await evalJS(`(() => {
    const pause = [...document.querySelectorAll('button')].find((b) => b.getBoundingClientRect().width > 0 && /暂停|结束审讯/.test((b.innerText || '').trim()));
    return pause ? true : false;
  })()`);
  rec("interrogation session is available",
      started !== 'disabled' && started !== 'no-button' || sessionActive,
      { started, sessionActive });
  await sleep(4000);

  // starting the session can send the workspace back to tab A, so re-open the record tab and
  // poll for the button instead of assuming it is already rendered
  let recording = 'no-record-button';  for (let attempt = 0; attempt < 3 && recording !== 'recording'; attempt += 1) {
    await evalJS(clickDeepest("审讯记录"));
    await sleep(2000);
    for (let wait = 0; wait < 8; wait += 1) {
      recording = await evalJS(`(() => {
        const b = [...document.querySelectorAll('button')].find((x) => x.getBoundingClientRect().width > 0 && /开始录音/.test((x.innerText || '').trim()));
        if (!b) return 'no-record-button';
        b.click();
        return 'recording';
      })()`);
      if (recording === 'recording') break;
      await sleep(2000);
    }
    trace(`record button attempt ${attempt + 1}: ${recording}`);
  }
  rec("realtime recording started through the UI", recording === 'recording', { recording });
  if (recording !== 'recording') {
    const buttons = await evalJS(`[...document.querySelectorAll('button')].filter((b) => b.getBoundingClientRect().width > 0).map((b) => b.innerText.trim().slice(0, 16))`);
    trace("buttons on failure: " + JSON.stringify(buttons));
    finish();
    return;
  }

  trace(`recording for ${SECONDS}s`);
  await sleep(SECONDS * 1000);

  const stopped = await evalJS(`(() => {
    const b = [...document.querySelectorAll('button')].find((x) => x.getBoundingClientRect().width > 0 && /停止录音/.test((x.innerText || '').trim()));
    if (!b) return 'no-stop-button';
    b.click();
    return 'stopped';
  })()`);
  rec("recording stopped", stopped === 'stopped', { stopped });
  await sleep(6000);

  // production invariant: the officer question and the suspect answer must not sit in one SUSPECT fragment
  const frags = await evalJS(`(async () => {
    const j = await (await fetch('/api/v1/cases/${caseId}/asr/fragments')).json();
    return (Array.isArray(j) ? j : (j.data || [])).map((f) => ({
      start: f.startedAtMs, end: f.endedAtMs, speaker: f.speaker,
      text: (f.editedText || f.rawText || ''),
    }));
  })()`);
  const hits = (frags || []).filter((f) => f.text.includes(OFFICER_MARK) || f.text.includes(SUSPECT_MARK));
  const mixed = (frags || []).filter((f) => f.text.includes(OFFICER_MARK) && f.text.includes(SUSPECT_MARK));
  const mixedAsSuspect = mixed.filter((f) => f.speaker === 'SUSPECT');
  const labels = mixed.map((f) => f.speaker);

  rec("the mixed exchange was recognised at all", hits.length > 0, { fragments: (frags || []).length, hits: hits.length });
  rec("no single fragment carries both the officer question and the suspect answer as SUSPECT",
      mixedAsSuspect.length === 0,
      { mixedFragments: mixed.length, labels, texts: mixed.map((f) => f.text.slice(0, 60)) });
  rec("the mixed window is split or labelled UNKNOWN rather than forced",
      mixed.length === 0 || labels.every((l) => l !== 'SUSPECT'),
      { labels });

  finish();
}

function finish() {
  report.passed = report.steps.length > 0 && report.steps.every((s) => s.ok);
  report.finished = new Date().toISOString();
  writeFileSync(`${OUT}\\regression-17b2.json`, JSON.stringify(report, null, 1));
  trace(`RESULT ${report.passed ? "PASS" : "FAIL"}`);
  console.log(`RESULT: ${report.passed ? "PASS" : "FAIL"}`);
  process.exit(report.passed ? 0 : 1);
}

await main();
