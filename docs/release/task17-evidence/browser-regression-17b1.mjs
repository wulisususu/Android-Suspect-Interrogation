// Task 17B-1 acceptance: the deployed UI/API must expose the EFFECTIVE speaker mode and the
// registration metrics, so "UI shows dual voiceprints while the runtime silently degrades to
// suspect-only" can never go unnoticed again.
//
// Asserts on the deployed build:
//   1. readiness API carries effectiveRecognitionMode / speakerMargin / threshold / margin flags
//   2. readiness API carries enrollmentQuality + usableDurationMs for a registered suspect
//   3. effectiveRecognitionMode equals the declared mode when margin is configured (this board)
//   4. the compact voiceprint card renders the real quality (not 质量：未知)
//   5. no degradation warning is shown while margin is configured
//
// Usage: node regression-17b1.mjs [baseUrl]
import { writeFileSync, mkdirSync, appendFileSync } from "node:fs";
import { setTimeout as sleep } from "node:timers/promises";

const OUT = "D:\\police Android\\task15\\browser";
const BASE = process.argv.find((a) => a.startsWith("http")) || "https://124.223.176.99:18080";
const PORT = 9222;
mkdirSync(OUT, { recursive: true });
const LOGFILE = OUT + "\\regression-17b1.log";
writeFileSync(LOGFILE, `regression-17b1 start ${new Date().toISOString()}\n`);
const trace = (m) => appendFileSync(LOGFILE, `${new Date().toISOString()} ${m}\n`);
process.on("uncaughtException", (e) => { trace("UNCAUGHT: " + e.stack); process.exit(1); });
process.on("unhandledRejection", (e) => { trace("UNHANDLED: " + (e && e.stack)); process.exit(1); });

const report = { started: new Date().toISOString(), base: BASE, steps: [], passed: false };
function rec(name, ok, detail) {
  report.steps.push({ name, ok, detail: detail ?? null, at: new Date().toISOString() });
  trace(`${ok ? "PASS" : "FAIL"} ${name}${detail ? " | " + JSON.stringify(detail).slice(0, 300) : ""}`);
  console.log(`${ok ? "PASS" : "FAIL"}  ${name}`);
}

let msgId = 0;
const pending = new Map();
let ws = null;

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
    setTimeout(() => { if (pending.has(id)) { pending.delete(id); rej(new Error("timeout " + method)); } }, 30000);
  });
}

async function evalJS(expr) {
  const r = await send("Runtime.evaluate", { expression: expr, returnByValue: true, awaitPromise: true });
  if (r.exceptionDetails) throw new Error(r.exceptionDetails.exception?.description || "eval error");
  return r.result?.value;
}

async function main() {
  await connect();
  trace("connected");
  await send("Page.navigate", { url: `${BASE}/?audioInput=BROWSER` });
  await sleep(4000);

  // find a case whose suspect voiceprint is registered: the 17A regression case is the newest
  const caseId = await evalJS(`(async () => {
    const r = await fetch('/api/v1/cases?limit=20');
    const j = await r.json();
    for (const c of (j.data || [])) {
      const rr = await fetch('/api/v1/cases/' + c.id + '/voiceprints/readiness');
      const rj = await rr.json();
      if (rj.data && rj.data.suspectReady) return c.id;
    }
    return '';
  })()`);
  rec("found a case with a registered suspect voiceprint", Boolean(caseId), { caseId });
  if (!caseId) { finish(); return; }

  const readiness = await evalJS(`(async () => {
    const r = await fetch('/api/v1/cases/${caseId}/voiceprints/readiness');
    return (await r.json()).data;
  })()`);
  trace("readiness: " + JSON.stringify(readiness).slice(0, 600));

  const hasModeFields = readiness
    && "effectiveRecognitionMode" in readiness
    && "speakerMargin" in readiness
    && "marginConfigured" in readiness
    && "thresholdConfigured" in readiness;
  rec("readiness exposes effective mode + margin/threshold flags", hasModeFields, {
    effectiveRecognitionMode: readiness?.effectiveRecognitionMode,
    declared: readiness?.recognitionMode,
    speakerMargin: readiness?.speakerMargin,
    speakerThreshold: readiness?.speakerThreshold,
    thresholdSource: readiness?.thresholdSource,
    marginConfigured: readiness?.marginConfigured,
    thresholdConfigured: readiness?.thresholdConfigured,
    degraded: readiness?.recognitionModeDegraded,
    reason: readiness?.recognitionModeDegradedReason,
  });

  const hasMetrics = readiness
    && (readiness.enrollmentQuality !== undefined)
    && (readiness.usableDurationMs !== undefined);
  rec("readiness exposes registration metrics", hasMetrics, {
    enrollmentQuality: readiness?.enrollmentQuality,
    usableDurationMs: readiness?.usableDurationMs,
    modelKey: readiness?.modelKey,
  });

  const marginConfigured = readiness?.marginConfigured === true;
  const consistent = marginConfigured
    ? readiness?.effectiveRecognitionMode === readiness?.recognitionMode && readiness?.recognitionModeDegraded === false
    : readiness?.effectiveRecognitionMode === "SUSPECT_ONLY" && readiness?.recognitionModeDegraded === true;
  rec("effective mode is consistent with the runtime margin state", Boolean(consistent), {
    marginConfigured,
    effective: readiness?.effectiveRecognitionMode,
    declared: readiness?.recognitionMode,
    degraded: readiness?.recognitionModeDegraded,
    reason: readiness?.recognitionModeDegradedReason,
  });

  // open the case in the workspace and read the compact voiceprint card
  await send("Page.navigate", { url: `${BASE}/?caseId=${caseId}&audioInput=BROWSER` });
  await sleep(5000);
  await evalJS(`(() => {
    const t = [...document.querySelectorAll('button,div,span')]
      .filter((e) => e.getBoundingClientRect().width > 0 && (e.innerText || '').trim().includes('审讯记录'));
    t.sort((a, b) => a.innerText.length - b.innerText.length);
    if (t[0]) t[0].click();
    return true;
  })()`);
  await sleep(4000);
  const bodyText = await evalJS(`document.body.innerText.replace(/\\s+/g, ' ')`);
  const qualityShown = /质量：(?!未知)/.test(bodyText);
  rec("compact card shows the real enrollment quality", qualityShown, {
    snippet: (bodyText.match(/嫌疑人[^]{0,120}/) || [""])[0].slice(0, 120),
  });
  const warns = bodyText.includes("退化为仅嫌疑人");
  rec("no degradation warning while margin is configured", marginConfigured ? !warns : warns, { warns });

  finish();
}

function finish() {
  report.passed = report.steps.length > 0 && report.steps.every((s) => s.ok);
  report.finished = new Date().toISOString();
  writeFileSync(`${OUT}\\regression-17b1.json`, JSON.stringify(report, null, 1));
  trace(`RESULT ${report.passed ? "PASS" : "FAIL"}`);
  console.log(`RESULT: ${report.passed ? "PASS" : "FAIL"}`);
  process.exit(report.passed ? 0 : 1);
}

await main();
