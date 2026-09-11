// Minimal CDP driver: no deps (Node >=22 global WebSocket + fetch).
// Usage:
//   node cdp.mjs launch <url>            -> start chrome (if needed), navigate, dump
//   node cdp.mjs nav <url>
//   node cdp.mjs shot <name>
//   node cdp.mjs eval "<js>"
//   node cdp.mjs click "<visible text>"
//   node cdp.mjs dump                    -> interactive elements summary
//   node cdp.mjs logs                    -> console + network failures
//   node cdp.mjs key <type> <text>       -> focus active element & insert text
import { spawn } from "node:child_process";
import { writeFileSync, mkdirSync, existsSync } from "node:fs";
import { setTimeout as sleep } from "node:timers/promises";

const OUT = "D:\\police Android\\task15\\browser";
const PORT = 9222;
const CHROME = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe";
const PROFILE = OUT + "\\profile";
const MIC = OUT + "\\suspect-zhangming-long.wav";

let msgId = 0;
const pending = new Map();
let ws = null;
const events = [];

async function targetUrl() {
  for (let i = 0; i < 40; i++) {
    try {
      const r = await fetch(`http://127.0.0.1:${PORT}/json/list`);
      const list = await r.json();
      const page = list.find((t) => t.type === "page" && t.webSocketDebuggerUrl);
      if (page) return page.webSocketDebuggerUrl;
    } catch {}
    await sleep(500);
  }
  throw new Error("chrome devtools endpoint not reachable");
}

async function connect() {
  const url = await targetUrl();
  ws = new WebSocket(url);
  await new Promise((res, rej) => {
    ws.addEventListener("open", res, { once: true });
    ws.addEventListener("error", rej, { once: true });
  });
  ws.addEventListener("message", (ev) => {
    const m = JSON.parse(ev.data);
    if (m.id && pending.has(m.id)) {
      const { res, rej } = pending.get(m.id);
      pending.delete(m.id);
      m.error ? rej(new Error(JSON.stringify(m.error))) : res(m.result);
    } else if (m.method) {
      if (m.method === "Runtime.consoleAPICalled") {
        events.push({ t: "console", level: m.params.type, text: (m.params.args || []).map((a) => a.value ?? a.description ?? "").join(" ").slice(0, 300) });
      } else if (m.method === "Runtime.exceptionThrown") {
        events.push({ t: "exception", text: (m.params.exceptionDetails?.exception?.description || m.params.exceptionDetails?.text || "").slice(0, 300) });
      } else if (m.method === "Network.loadingFailed") {
        events.push({ t: "netfail", text: `${m.params.errorText} ${m.params.type}`.slice(0, 200) });
      } else if (m.method === "Network.responseReceived") {
        const s = m.params.response.status;
        if (s >= 400) events.push({ t: "http", text: `${s} ${m.params.response.url.slice(0, 160)}` });
      } else if (m.method === "Page.frameNavigated" && m.params.frame.parentId === undefined) {
        events.push({ t: "nav", text: m.params.frame.url.slice(0, 200) });
      }
    }
  });
  await send("Runtime.enable");
  await send("Page.enable");
  await send("Network.enable");
}

function send(method, params = {}) {
  const id = ++msgId;
  return new Promise((res, rej) => {
    pending.set(id, { res, rej });
    ws.send(JSON.stringify({ id, method, params }));
    setTimeout(() => {
      if (pending.has(id)) {
        pending.delete(id);
        rej(new Error(`timeout: ${method}`));
      }
    }, 60000);
  });
}

async function evaluate(expr) {
  const r = await send("Runtime.evaluate", { expression: expr, returnByValue: true, awaitPromise: true });
  if (r.exceptionDetails) throw new Error(r.exceptionDetails.exception?.description || "eval error");
  return r.result?.value;
}

async function screenshot(name) {
  mkdirSync(OUT, { recursive: true });
  const r = await send("Page.captureScreenshot", { format: "png", captureBeyondViewport: true });
  const p = `${OUT}\\${name}.png`;
  writeFileSync(p, Buffer.from(r.data, "base64"));
  return p;
}

async function launch(url) {
  const args = [
    `--remote-debugging-port=${PORT}`,
    `--user-data-dir=${PROFILE}`,
    "--no-first-run", "--no-default-browser-check",
    "--ignore-certificate-errors", "--allow-insecure-localhost",
    "--use-fake-ui-for-media-stream", "--use-fake-device-for-media-stream",
    `--use-file-for-fake-audio-capture=${MIC}`,
    "--autoplay-policy=no-user-gesture-required",
    "--window-size=1600,1000",
    "--headless=new",
  ];
  if (existsSync(PROFILE + "\\Default")) {
    // reuse profile
  }
  const child = spawn(CHROME, [...args, url || "about:blank"], { detached: true, stdio: "ignore" });
  child.unref();
  await sleep(2500);
}

function dumpScript() {
  return `(() => {
    const vis = (el) => { const r = el.getBoundingClientRect(); const s = getComputedStyle(el); return r.width > 0 && r.height > 0 && s.visibility !== 'hidden' && s.display !== 'none'; };
    const items = [];
    document.querySelectorAll('button, a, input, [role=button], .tab, [class*=tab]').forEach((el) => {
      if (!vis(el)) return;
      const label = (el.innerText || el.value || el.getAttribute('placeholder') || el.getAttribute('aria-label') || '').trim().replace(/\\s+/g, ' ').slice(0, 40);
      if (!label) return;
      items.push({ tag: el.tagName.toLowerCase(), label, cls: (el.className || '').toString().slice(0, 40) });
    });
    const uniq = [];
    const seen = new Set();
    for (const it of items) { const k = it.tag + '|' + it.label; if (!seen.has(k)) { seen.add(k); uniq.push(it); } }
    return { url: location.href, title: document.title, text: document.body.innerText.replace(/\\s+/g, ' ').slice(0, 1200), controls: uniq.slice(0, 60) };
  })()`;
}

const cmd = process.argv[2];
const arg = process.argv.slice(3).join(" ");
let launched = false;
try {
  await connect();
} catch {
  await launch(cmd === "nav" ? arg : "about:blank");
  launched = true;
  await connect();
}

if (cmd === "launch" || cmd === "nav") {
  await send("Page.navigate", { url: arg });
  await sleep(3000);
  console.log(JSON.stringify(await evaluate(dumpScript()), null, 1));
  console.log("shot:", await screenshot("step-" + Date.now()));
} else if (cmd === "eval") {
  console.log(JSON.stringify(await evaluate(arg), null, 1));
} else if (cmd === "dump") {
  console.log(JSON.stringify(await evaluate(dumpScript()), null, 1));
} else if (cmd === "click") {
  const r = await evaluate(`(() => {
    const vis = (el) => { const r = el.getBoundingClientRect(); const s = getComputedStyle(el); return r.width > 0 && r.height > 0 && s.visibility !== 'hidden'; };
    const target = ${JSON.stringify(arg)};
    const cands = [...document.querySelectorAll('button, a, [role=button], .tab, [class*=tab], li, div[class*=item]')].filter(vis);
    const hit = cands.find((el) => ((el.innerText || el.value || '').trim().replace(/\\s+/g, ' ')) === target)
      || cands.find((el) => ((el.innerText || el.value || '').trim().replace(/\\s+/g, ' ')).includes(target));
    if (!hit) return { ok: false, available: cands.slice(0, 25).map((el) => (el.innerText || '').trim().replace(/\\s+/g, ' ').slice(0, 30)) };
    hit.scrollIntoView({ block: 'center' });
    hit.click();
    return { ok: true, clicked: (hit.innerText || '').trim().replace(/\\s+/g, ' ').slice(0, 40) };
  })()`);
  console.log(JSON.stringify(r));
  await sleep(2000);
  console.log(JSON.stringify(await evaluate(dumpScript()), null, 1));
  console.log("shot:", await screenshot("click-" + Date.now()));
} else if (cmd === "type") {
  const r = await evaluate(`(() => {
    const target = ${JSON.stringify(arg)};
    const vis = (el) => { const r = el.getBoundingClientRect(); return r.width > 0 && r.height > 0; };
    const inputs = [...document.querySelectorAll('input, textarea')].filter(vis);
    const hit = inputs.find((el) => (el.getAttribute('placeholder') || '').includes(target)) || inputs[0];
    if (!hit) return { ok: false, count: inputs.length };
    hit.focus(); hit.value = target;
    hit.dispatchEvent(new Event('input', { bubbles: true }));
    hit.dispatchEvent(new Event('change', { bubbles: true }));
    return { ok: true, placeholder: hit.getAttribute('placeholder'), value: hit.value };
  })()`);
  console.log(JSON.stringify(r));
} else if (cmd === "logs") {
  console.log(JSON.stringify(events.slice(-60), null, 1));
} else if (cmd === "fill") {
  const spec = JSON.parse(arg);
  const r = await evaluate(`(() => {
    const spec = ${JSON.stringify(JSON.stringify(spec))};
    const map = JSON.parse(spec);
    const setNative = (el, val) => {
      const proto = el.tagName === 'SELECT' ? HTMLSelectElement.prototype : el.tagName === 'TEXTAREA' ? HTMLTextAreaElement.prototype : HTMLInputElement.prototype;
      const setter = Object.getOwnPropertyDescriptor(proto, 'value').set;
      setter.call(el, val);
      el.dispatchEvent(new Event('input', { bubbles: true }));
      el.dispatchEvent(new Event('change', { bubbles: true }));
    };
    const done = [], missing = [];
    for (const [key, val] of Object.entries(map)) {
      const inputs = [...document.querySelectorAll('input, textarea')].filter((el) => el.getBoundingClientRect().width > 0);
      let hit = inputs.find((el) => (el.placeholder || '').includes(key));
      if (!hit) {
        const labels = [...document.querySelectorAll('label, div, span')].filter((el) => (el.innerText || '').trim().startsWith(key));
        if (labels.length) {
          const box = labels[labels.length - 1].parentElement;
          hit = box ? box.querySelector('input, textarea, select') : null;
        }
      }
      if (hit) { setNative(hit, val); done.push(key + '=' + val); continue; }
      const sels = [...document.querySelectorAll('select')].filter((el) => el.getBoundingClientRect().width > 0);
      const sel = sels.find((el) => [...el.options].some((o) => (o.text || '').includes(val)));
      if (sel) { setNative(sel, [...sel.options].find((o) => (o.text || '').includes(val)).value); done.push(key + '=' + val); continue; }
      missing.push(key);
    }
    return { done, missing };
  })()`);
  console.log(JSON.stringify(r));
} else if (cmd === "tab") {
  const r = await evaluate(`(() => {
    const t = ${JSON.stringify(arg)};
    const els = [...document.querySelectorAll('button, [role=tab], .tab, div, span')].filter((el) => el.getBoundingClientRect().width > 0 && ((el.innerText || '').trim()) === t);
    if (!els.length) return { ok: false };
    els[els.length - 1].click();
    return { ok: true, clicked: t };
  })()`);
  console.log(JSON.stringify(r));
  await sleep(1500);
  console.log(JSON.stringify(await evaluate(dumpScript()), null, 1));
  console.log("shot:", await screenshot("tab-" + Date.now()));
} else if (cmd === "shot") {
  console.log("shot:", await screenshot(arg || "manual-" + Date.now()));
} else {
  console.log("commands: launch|nav|eval|dump|click|type|logs|shot");
}
ws.close();
process.exit(0);
