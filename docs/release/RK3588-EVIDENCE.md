# RK3588 CI Evidence

This file is updated only from actual GitHub Actions evidence; it must not claim a successful hardware run from static review alone.

## Validated workflow

- PR: `#15` (`linux-release-hardening` -> `linux-adaptation`)
- workflow: `Linux CI`
- workflow run ID: `32950118034`
- head commit under test: `7d6b5d1f610ea736bb94693de197ce4771225bf4`
- PR merge SHA checked out by Actions: `e34657d914be8cf8998490704f1e5cff529c534b`
- hosted job ID: `98119415395` — **success**
- RK3588 job ID: `98119624222` — **success**

The hosted gate completed backend import, Python tests, DB/backup compatibility, API contracts, hardware mock, AI mock, Vue tests, Vue typecheck, Vue production build, shell syntax/contract checks, and release/E2E/reliability tests before the RK3588 job was allowed to run.

## Runner identity

Actual runner log values:

- runner name: `rk3588-android-suspect`
- runner group: `Default`
- machine/hostname: `RK3588-32G`
- runner OS: `Linux`
- runner architecture: `ARM64`
- `uname` architecture: `aarch64`
- kernel: `Linux RK3588-32G 6.1.75 ... aarch64 GNU/Linux`
- Git: `2.34.1`
- Python: `3.10.12`
- Node: `v22.22.2`

## Checkout evidence

The RK3588 job used:

- partial clone: `--filter=blob:none`;
- sparse checkout: `.github linux webapp deploy scripts systemd tests docs`;
- maximum five fetch attempts;
- 120 second timeout per fetch attempt;
- `http.version HTTP/1.1`;
- `http.lowSpeedLimit 1024`;
- `http.lowSpeedTime 15`;
- exact `GITHUB_SHA` verification after checkout.

Actual result:

- `fetch attempt 1/5` succeeded;
- fetched SHA: `e34657d914be8cf8998490704f1e5cff529c534b`;
- detached checkout landed on that exact PR merge SHA;
- no retry beyond attempt 1 was required.

## Runtime smoke evidence

The RK3588 smoke reported the API readiness snapshot as `status=ready` with:

- storage: `READY` (`free_mb=39761` at test time);
- database: `READY` (initialization path writable);
- hardware: `UNAVAILABLE`, `required=false` because no physical device was configured for this CI smoke;
- AI: `NOT_INSTALLED`, `required=false` because model assets were intentionally not installed by this workstream.

This demonstrates the release contract that optional device/model capability absence does not make the core API unhealthy.

## Mock E2E evidence

The RK3588 job executed the full release-side mock lifecycle and emitted all expected events:

`boot -> case_created -> identity_read -> session_start -> recording_mock -> asr_mock -> message_added -> ai_mock -> message_edit -> revision_created -> message_marked -> session_pause -> session_resume -> session_finish -> freeze -> signature_mock -> report_created -> service_restart -> data_verified -> backup_created -> restore_verified`

Recorded evidence:

- frozen SHA-256: `9787b349eb22bd2e3a08829f40d7056ea19b18eb1324ba9cd1c56f74a4044673`;
- signature binding: `mock-sha256:9787b349eb22bd2e3a08829f40d7056ea19b18eb1324ba9cd1c56f74a4044673`;
- restored SQLite integrity: `ok`;
- model downloads performed by the test: `0`.

## Frontend evidence

On the RK3588 runner:

- npm dependencies installed successfully;
- audit result: `0 vulnerabilities`;
- `npm run typecheck`: success;
- `npm run build`: success;
- Vite transformed 115 modules and produced the production `dist/` bundle;
- final smoke line: `rk3588 smoke: ok`.

## FunASR discovery probe gate

The approved speech-pipeline work adds `scripts/ci/probe-funasr-runtime.py` as a read-only hardware discovery gate for the existing RK3588-local model root `/home/youyeetoo/funasr-models`.

The probe contract requires:

- local-only `AutoModel` construction with `device="cpu"` and `disable_update=True`;
- separate validation of `paraformer`, `fsmn-vad`, and `xvector` directories;
- no model downloads and no writes under the model root;
- optional Paraformer/VAD speech inference and XVector `spk_embedding` shape inspection when sample WAV files are explicitly supplied;
- JSON evidence written only under the Actions workspace or runner temporary directory.

TDD RED evidence for PR `#21`: hosted Actions run `33037785535`, job `98404277509`, failed exactly at `test_probe_exists_and_is_offline_and_non_destructive` because `scripts/ci/probe-funasr-runtime.py` did not yet exist (`1 failed, 12 passed`). This proves the new contract test detects the missing probe before implementation.

A successful real-model load is **not claimed in this section yet**. The `Linux AI Runtime RK3588` workflow now targets `linux-adaptation`; after the implementation reaches that branch, the self-hosted runner will probe the already-installed local models when a FunASR-capable interpreter is available. The existing TCP/8000 service is not called, stopped, restarted, reconfigured, or used as the probe target.

## Conclusion

The implementation commit above passed both the hosted Linux release gate and the real RK3588 self-hosted smoke chain. Subsequent documentation/configuration-only commits must still pass the PR gate before merge; the final PR status is the authoritative merge criterion.
