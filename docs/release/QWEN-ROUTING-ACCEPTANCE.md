# Qwen Formal Record Routing Acceptance

Status: completed for semantic/routing acceptance; production mode remains `legacy`.

## Scope

- Branch: `feat/qwen-formal-record-routing`
- Runtime: RK3588 + LlamaPi + `qwen3:4b@rkllm-rk3588`
- RK3588 host: `RK3588-32G`, `aarch64`, kernel `6.1.75`, Python `3.10.12`
- LlamaPi endpoint: `http://127.0.0.1:9265/v1`
- Production routing mode remains `legacy`; this acceptance does not enable Qwen routing in production.
- Existing unrelated TCP/8000 service was observed only and was not stopped, restarted, or repurposed.

## Semantic safety baseline

The backend remains authoritative over the model decision.

- A / fixed question: automatic existing fixed-question routing.
- B / existing case or live question: automatic existing-question routing, with explicit fact preservation. If model normalization loses an explicit time or quantity fact, the backend falls back to the raw answer with `FACT_LOSS_RAW_FALLBACK`.
- C / new onsite question: the model cannot invent a question. When an existing-target intent mismatch is detected, the backend creates a LIVE item from the real spoken question and answer with `TARGET_INTENT_MISMATCH_CREATE_LIVE`.
- D / ambiguous placement: deterministic precheck returns `NEEDS_REVIEW` without model inference.
- E / operational chatter: deterministic precheck returns `IGNORE` without model inference.

## Output-budget experiment

The structured JSON generation budget was reduced from 512 to 192 tokens in both the production router and RK3588 probe.

The real-device comparison did not show a latency improvement:

- 512-token baseline: p50 `42046.382 ms`, p95 `45224.106 ms`, max `45577.186 ms`.
- 192-token probe: p50 `42391.190 ms`, p95 `45488.655 ms`, max `45832.153 ms`.

Therefore the configured maximum output budget was not the observed latency bottleneck. The final 20-decision run kept the 192-token cap.

## Hosted regression

Final hosted full regression on branch revision `43545f63df2e5e1294f7b260623cedb80dab965a`:

- Backend: `324 passed`, `2 warnings`, `0 failures`.
- Frontend tests: passed.
- Frontend typecheck: passed.
- Frontend build: passed.

## Final RK3588 gate

Workflow: `RK3588 Qwen Formal Routing Acceptance`

- Run ID: `33537681916`
- Accepted source revision: `54362703da2f09759d017da709bcb4e19ff10ab2`
- Artifact: `rk3588-qwen-formal-routing-33537681916` (artifact ID `9812647668`)
- Artifact SHA-256: `9c5ff501ef880b596e72694ef73f30fa5fc1d66fdd44db0bc045e75e01916582`
- Effective decisions: `20`
- Model inferences: `12`
- Passed samples: `20/20`
- Effective class counts: A/MATCH_FIXED `4`, B/MATCH_EXISTING `4`, C/CREATE_LIVE_FROM_SPEECH `4`, D/NEEDS_REVIEW `4`, E/IGNORE `4`.
- D/E remained zero-model prechecks in all four repetitions.
- B fact-loss repair and C intent-mismatch repair remained effective across the final repetitions.

### Latency

Across the 12 real Qwen3-4B model requests:

- p50: `42615.915 ms`
- p95: `46663.072 ms`
- max: `47031.912 ms`

This is still a material runtime limitation. It is not a semantic acceptance failure and no latency SLA was asserted by this gate.

### Model telemetry

All 12 model calls returned usage telemetry:

- Prompt characters: `1209–1333`
- Response characters: `240–282`
- Prompt tokens: `473–504`
- Completion tokens: `75–97`
- Total tokens: `552–589`

The maximum-token cap is not being reached. In this controlled sample, longer completion outputs tracked the slower calls more closely than prompt size did; this points toward RKLLM/model decode throughput as a stronger optimization target than merely lowering `max_tokens`. This is an engineering inference from the acceptance samples, not a separate throughput benchmark.

### Memory

Reliable `/proc/<pid>/status` plus systemd cgroup sampling replaced the prior empty `ps` RSS probe.

- Memory samples: `517`
- Valid process VmRSS samples: `517`
- Valid cgroup memory samples: `517`
- Peak LlamaPi process VmRSS: `6826076 KiB` (`6666.09 MiB`, about `6.51 GiB`)
- Peak service cgroup memory: `7387036 KiB` (`7213.90 MiB`, about `7.04 GiB`)

### Runtime invariants

- `llamapi-server.service` remained active after the gate.
- Model remained `qwen3:4b@rkllm-rk3588`.
- Existing TCP/8000 remained listening and was not mutated by the acceptance workflow.
- The final gate is read-only with respect to the LlamaPi service and model files.

## Acceptance conclusion

The unfinished semantic/routing acceptance work is closed:

- A–E deterministic/model hybrid behavior is verified on the real RK3588 runtime.
- Explicit fact preservation is verified.
- New spoken onsite-question protection is verified.
- Ambiguous and operational utterance short-circuit behavior is verified.
- Reliable runtime memory evidence is captured.
- The required 20 effective decisions / 12 model inferences gate passed.
- Hosted backend/frontend regression passed.

Qwen production activation is intentionally **not** part of this acceptance. `RuntimeSettings.formal_routing_mode` continues to default to `legacy`. The remaining 40–47 second model-call latency should be treated as a separate performance-optimization workstream if a production latency target is defined.
