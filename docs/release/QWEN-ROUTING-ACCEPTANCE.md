# Qwen Formal Record Routing Acceptance

Status: in progress

## Scope

- Branch: `feat/qwen-formal-record-routing`
- Runtime: RK3588 + LlamaPi + `qwen3:4b@rkllm-rk3588`
- Production routing mode remains `legacy` during acceptance.
- Existing unrelated TCP/8000 service must not be stopped, restarted, or repurposed.

## Last verified semantic baseline

- Effective A–E decisions: 5/5 passed.
- Model inferences: 3 (D/E resolved by deterministic precheck).
- Model latency baseline before output-budget tuning: p50 42046.382 ms, p95 45224.106 ms, max 45577.186 ms.
- B explicit-fact protection verified with `FACT_LOSS_RAW_FALLBACK`.
- C target-intent mismatch protection verified with `TARGET_INTENT_MISMATCH_CREATE_LIVE`.
- D verified as `NEEDS_REVIEW` without model inference.
- E verified as `IGNORE` without model inference.

## Current acceptance step

The structured JSON generation budget has been reduced from 512 to 192 tokens in both the production router and the RK3588 acceptance probe. Hosted regression and real-device latency comparison are pending for this revision.

## Final gate

Pending:

- hosted backend/frontend regression
- RK3588 192-token latency comparison
- reliable LlamaPi RSS sampling
- 20 effective decisions / 12 model inferences
- final verification before production-mode consideration
