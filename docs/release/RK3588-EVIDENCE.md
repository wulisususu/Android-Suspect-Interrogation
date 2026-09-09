# RK3588 MOSS 部署证据（Task 14 阶段二）

- 执行日期：2026-09-09（+08:00），目标板 RK3588-32G（Ubuntu 22.04.5，kernel 6.1.75，hostname `RK3588-32G`）
- 仓库 HEAD：`f831d9c3d8c3444c3690bfa8ca1829afa52497be`（linux-adaptation），板端工作树 `git reset --hard` 后与 HEAD 一致、0 dirty
- 执行通道：`ssh -p 600 youyeetoo@124.223.176.99`；全程只读触碰现网服务（仅 `systemctl is-active`/`show`/`ss`/`journalctl`）
- 红线遵守：未启用 `MOSS_ENABLED`；未触碰 FunASR/TCP:8000/mqw-backend/interrogation-api/ai-worker；未删除或修改 bundle-v2；无 push、无 commit

## 结果总览

| 项 | 旧（bundle-v2，在役） | 新（bundle-v3，本次部署） |
| --- | --- | --- |
| manifest SHA-256 | `a50ce60b04e3715a4ce9d05381336fd95072f359c7883115e946d55321657e69` | `b735dc2daa1d6313c4524fd04e1fa4597a3f08074e7b8bd097be890973b57fb1` |
| 窗口策略 | 12/10/8（未批准） | **10/8/8（已批准）** |
| `validate_bundle` | fail（"Unapproved context/window policy; compiled context must be 16384"） | **pass**（`{"valid": true, "errors": []}`） |

等值校验（v3 vs v2）：`checkpoint_fingerprint` 相等、`provenance` 相等、`artifacts` 全部相等、`checkpoint_config_sha256` 相等；差异仅为批准策略与派生字段。upstream source commit `61bc29cd4120be7b5d3b761b64cd5dff57263642`，`dirty: false`。

## 生产门 1：模型包合法性（旧包必须失败、新包必须通过）

```
$ python3 -m tools.moss_rk3588.validate_bundle /home/youyeetoo/moss-build/bundle-v2
{"valid": false, "errors": ["Unapproved context/window policy; compiled context must be 16384"]}
$ python3 -m tools.moss_rk3588.validate_bundle /opt/suspect-interrogation/models/moss-rk3588
{"valid": true, "errors": []}          # 即 bundle-v3 安装位
```

重建命令（离线可复现）：

```
python3 -m tools.moss_rk3588.build_manifest \
  --assets /home/youyeetoo/moss-build/assets-v2-raw \
  --source /home/youyeetoo/moss-build/source/MOSS-Transcribe-Diarize-upstream \
  --checkpoint /home/youyeetoo/moss-build/source/MOSS-Transcribe-Diarize \
  --provenance /home/youyeetoo/moss-build/provenance.json \
  --output /home/youyeetoo/moss-build/bundle-v3
rebuilt bundle is valid; manifest sha256: b735dc2d…57fb1
```

说明（偏差 D1）：README §1 建议 `--assets bundle-v2`，但 bundle 内 `tokenizer_config.json` 是预处理产物（含 chat_template，sha `33622992…`），构建器要求 assets 中为 checkpoint 原始文件（sha `61d04c96…`，与 `token_embedding.json.tokenizer_source_files` 一致）。故以 bundle-v2 硬链接 + 原始 `tokenizer_config.json` 组装 `assets-v2-raw` staging（bundle-v2 未改动，构建器只读）。

## 生产门 2：NPU 运行时与库指纹

- 子环境 venv：`/opt/suspect-interrogation/runtime/moss-env`（python 3.10.12；numpy 1.26.4、jinja2 3.1.6、tokenizers 0.23.2、rknn-toolkit-lite2 2.3.2 全部离线 wheel 安装；目录已 `go-w` 加固）
- 原生库（root:root 0644，SHA 与 `moss_worker/runtime.py` 批准值逐字节一致）：
  - `librknnrt.so` = `d31fc19c85b85f6091b2bd0f6af9d962d5264a4e410bfb536402ec92bac738e8`
  - `librkllmrt.so` = `6a9e4fc5324c68921c3a900340361e107af7599fe34dc8fa7759b2c5ae22a6e6`
- 板端实测：RKNNLite init rc=0，`librknnrt version: 2.3.2 (429f97ae6b@2025-04-09)`, `RKNN Driver Information, version: 0.9.8`，模型 `target platform: rk3588, static_shape`
- 12 分钟真机作业证据：RKNN 编码 → RKLLM 双窗口解码全部成功（预填充 7926 tokens/119.5s，生成 3633 tokens/3174s，峰值内存 4331 MB）

## 生产门 3：systemd 单元

```
$ sudo systemctl daemon-reload && sudo systemctl enable --now moss-worker.service
Created symlink /etc/systemd/system/multi-user.target.wants/moss-worker.service → …
$ systemctl is-active moss-worker.service; echo $?
active
0
$ stat -c '%a %U:%G' /run/suspect-interrogation/moss.sock
660 suspect-interrogation:suspect-interrogation
$ systemctl is-enabled moss-worker.service
enabled
```

- 单元含 `ConditionPathExists`（current/linux/backend + models/moss-rk3588/manifest.json），但验收以显式 `systemctl is-active` 断言为准（修复 Review Minor #2，README §3 已同步）
- 偏差 D3：单元新增 `SupplementaryGroups=video`——RK3588 Ubuntu 的 NPU 节点 `/dev/mpp_service` 为 `root:video 0660`，无该补充组时子进程 `init_runtime` 返回 `MOSS_RKNN_INIT_FAILED:-1`（`failed to open rknn device`），属阶段二实测集成缺口

## 生产门 4：MOSS_ENABLED 保持关闭

```
$ curl -sk https://127.0.0.1:18080/health/ready
"capabilities": { "moss": { "state": "DISABLED", "required": false,
  "detail": "MOSS long-audio transcription is disabled (MOSS_ENABLED=0)" } }, "status": "ready"
```

- `/etc/suspect-interrogation/moss-worker.env` 不含 `MOSS_ENABLED`（grep exit 1）；API 运行时配置亦无该键
- 门 4 基线与终态一致：MOSS 在 API 能力面保持 DISABLED，仅 worker 单元先行投产待命

## 生产门 5：health 操作（AF_UNIX）

```
$ MossWorkerClient('/run/suspect-interrogation/moss.sock').health()
{ "status": "ok",
  "manifest_sha256": "b735dc2daa1d6313c4524fd04e1fa4597a3f08074e7b8bd097be890973b57fb1",
  "runtime_versions": {"rknn": "2.3.2", "rkllm": "1.3.0", "python": "3.10"},
  "queue_depth": 0, "active_job": null, "run_failures": {}, "scheduler_error": null }
```

## 生产门 6：崩溃恢复演练（kill -9）

对象：12 分钟 PCM16/mono/16k 音频（sha256 `bd4776d6…3b998`），作业 `6d72b377c9cb46a6a9b41f0e209536f5`，2 窗口（0–600s、480–720s，重叠 120s）。

时间线（journalctl -u moss-worker）：

```
15:53:19  kill -9 MainPID 3132292（w0001 已完成 checkpoint，w0002 飞行中）
15:53:20  Main process exited, code=killed, status=9/KILL
15:53:25  Scheduled restart job, restart counter is at 1
15:53:25  Started Suspect Interrogation MOSS RK3588 NPU Worker   → 5 秒恢复
+8s      systemctl is-active → active（NRestarts=1）
```

断言结果：

| 断言 | 结果 |
| --- | --- |
| systemd ~5s 自动拉起 | ✅ 15:53:20 → 15:53:25 |
| get_job 从 spool 恢复可见 | ✅ state=DECODING，revision（窗口计划/生成参数/runtime_versions）完整 |
| 已完成窗口不丢 | ✅ w0001 checkpoint `9fbbdf1e…` 保留于 spool（3634 tokens，含 perf） |
| 不自动重排（需人工重新提交） | ✅ 重启后 health `queue_depth=0, active_job=null`；作业保持非终态，等待人工 `resume()` |
| 已完成作业不受影响 | ✅ `0ed3ac65…`（COMPLETED，双窗全程 60 分钟）`get_result` 仍返回 119 段 |

spool 结构：`job.json`、`windows.json`、`checkpoints/`、`raw_generations/`、`speaker_state.json`、`logs/events.jsonl`。

## 生产门 7：现网服务零影响

全程 TCP/8000 监听者 pid 恒为 `1073 / 3374 / 3375`（mqw-backend.service，FunASR 独立单元，MainPID=1073）：

```
LISTEN 0 0 0.0.0.0:8000 0.0.0.0:* users:(("python",pid=3375,…),("python",pid=3374,…),("python",pid=1073,…))
mqw-backend=active interrogation-api=active ai-worker=active kiosk=activating(预存自愈循环，仅记录)
/health/live → {"status":"alive"}；/health/ready → status=ready（storage free_mb=15529，sqlite quick_check=ok）
```

## 生产门 8：AF_UNIX 板端回归

```
$ python3 -m pytest tests/test_moss_protocol.py tests/test_moss_client_server.py -q
.........................................................                [100%]
57 passed in 2.01s
```

57 = 9（protocol）+ 48（client_server），其中含 HEAD 新增的 queue/active 断言（`-k 'queue or active'` → 4 项）；README 的 53 为基线数，57 与当前 HEAD 一致。

## 探针自测（scripts/ci/probe-moss-rk3588.py，板端以 root 执行）

`--expect-manifest-sha256 b735dc2d…` → **`"success": true`，exit 0**：aarch64、unit active/enabled、socket 0660/属主匹配、bundle 13/13 artifacts 校验通过且策略 [10,8,8]、两原生库 SHA 与批准值一致、health ok/idle/manifest 与 env 钉扎一致、TCP/8000 在监、models 目录仅 `funasr` + `moss-rk3588`。

## 部署偏差与事故记录

- D1（README §1）：`--assets` 需原始源文件而非 bundle 产物，用 `assets-v2-raw` staging 解决（详见门 1）
- D2（requirements.txt）：MOSS 主进程计数路径（`_actual_counter` → numpy/jinja2/tokenizers）依赖未在 `linux/backend/requirements.txt` 声明，部署后 `submit_job` 返回 WORKER_CRASHED；已在工作区补依赖（未提交），板上以预置离线 wheel（同 pinned 版本）装入发布 venv——下次按提交后 requirements 重新部署时自动复现
- D3（systemd/moss-worker.service）：新增 `SupplementaryGroups=video`（详见门 3），板上已同步安装
- 构建器兼容：`capture_input_embeds.sha256_file` 使用 `hashlib.file_digest`（Python≥3.11），板上以 miniforge python 3.13.13 + torch 2.14.0+cpu 专用 venv 执行构建（指纹计算与解释器无关，fingerprint/provenance/artifacts 与 v2 全等已证明）
- 事故：首次 `control.sh deploy` 因本地驱动崩溃重复派发，产生两次 release；已核验终态一致（current → `20260909T043624Z-f831d9c3d8c3`，保留 3 个 release，TCP/8000 pid 未变）
- kiosk.service 在部署前即处于 activating 自愈循环，非本次改动所致，仅记录

## 变更清单（工作区，未提交）

- `scripts/ci/probe-moss-rk3588.py`（新增）
- `deploy/README.md` §3（`systemctl is-active` 显式断言）
- `systemd/moss-worker.service`（SupplementaryGroups=video）
- `linux/backend/requirements.txt`（numpy/tokenizers/jinja2 + 注释）
- `.github/workflows/rk3588-service-bootstrap.yml`（MOSS 布局/单元/探针步骤）
- `.github/workflows/rk3588-production-redeploy.yml`（MOSS 重启/探针/诊断）
- `.github/workflows/linux-ai-runtime-rk3588.yml`（路径触发、compileall、探针步骤）
- `docs/release/RK3588-EVIDENCE.md`（本文件）

板上产物：`/opt/suspect-interrogation/models/moss-rk3588`（root 只读，dr-xr-xr-x）、`/etc/suspect-interrogation/moss-worker.env`（640 root:suspect-interrogation）、`/etc/systemd/system/moss-worker.service`、`/etc/tmpfiles.d/suspect-interrogation-moss.conf`、`/var/lib/suspect-interrogation/moss`（0750）、`/opt/suspect-interrogation/runtime/moss-env`。

---

# 755cc01 redeploy（阶段二收尾）

- 日期：2026-09-09 16:08–16:40（+08:00）；部署源 HEAD=`755cc013b78f1a77aee23e7969863d09bd33bd1e`（含阶段二全部修复：requirements/SupplementaryGroups/EVIDENCE/workflows/probe）
- 同步方式：Windows 端 `git bundle create … f831d9c..linux-adaptation`（35,919 B）→ 板端 `git fetch <bundle> linux-adaptation && git reset --hard FETCH_HEAD` → `git rev-parse HEAD` = `755cc013b78f…`，`git status` 干净，`bash -n deploy/control.sh …` 通过

## 部署与 stamp

```
$ sudo -n env GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=safe.directory \
    GIT_CONFIG_VALUE_0=/home/youyeetoo/moss-build/task14-deploy \
    SUSPECT_HEALTH_BASE_URL=https://127.0.0.1:18080 \
    bash deploy/control.sh deploy /home/youyeetoo/moss-build/task14-deploy
…
/opt/suspect-interrogation/releases/20260909T081038Z-755cc013b78f
__RC__0
```

- 新 release stamp：**`20260909T081038Z-755cc013b78f`**（后续因运行时目录 GC 修复又部署一次 → 最终 stamp **`20260909T082843Z-755cc013b78f`**，同一 HEAD）
- **门槛 9 证据（D2 经仓库路径生效）**：新 release venv pip 清单包含 `numpy-2.2.6 / jinja2-3.1.6 / tokenizers-0.23.2`（来自提交后的 `linux/backend/requirements.txt`，非手工离线注入）
- unit 一致性：`sudo diff /etc/systemd/system/moss-worker.service <repo>/systemd/moss-worker.service` → 无差异（含 `SupplementaryGroups=video`）；`is-active`→active；socket `660 suspect-interrogation:suspect-interrogation`
- TCP/8000 全程 pid 恒为 `1073/3374/3375`（mqw-backend 未受影响）

## submit 冒烟（D2 生效证明，全程 <1 分钟）

```
$ MossWorkerClient(socket).submit_job('/var/lib/suspect-interrogation/window12-drill.wav')
SMOKE_SUBMITTED 310ed11855f7411899f905d02d8716ff QUEUED
state QUEUED → state PREPARING          # 原生状态到达 = 主进程计数路径（numpy/tokenizers/jinja2）在新 venv 工作
cancel_job → MOSS_CANCEL_REQUESTED → 终态 CANCELLED
HEALTH_FINAL status=ok queue_depth=0 active_job=null
```

## 事故与修复：共享 RuntimeDirectory GC 使 speech.sock 变孤儿（已修复并复验）

- 现象：755cc01 首次部署后 `/health/ready` 中 asr/vad/speaker 全部 ERROR（基线为 AVAILABLE）；`/run/suspect-interrogation/` 内仅剩 moss.sock
- 根因：`moss-worker.service` 与 `ai-worker.service` **都声明 `RuntimeDirectory=suspect-interrogation`**；任一声明单元 stop 时 systemd 会 GC 共享目录——moss 每次 stop/restart 都会把 ai-worker 已绑定的 speech.sock 变成孤儿路径（客户端 ENOENT → AI supervisor 报 ERROR）。回溯确认首次部署（13:36 moss 单元重装重启）即已触发
- 修复（工作区未提交）：`systemd/moss-worker.service` 移除 `RuntimeDirectory=*` 两行（目录由 tmpfiles fragment 保证，moss 停止不再 GC）；`tests/release/test_moss_systemd_and_deploy.py` 断言反转（`"RuntimeDirectory" not in t` 防回归）。板上安装后 `daemon-reload` + `systemd-tmpfiles --create` + 重启 moss（restart 前 daemon-reload，stop 不再 GC）
- 语音恢复：重跑一次 `control.sh deploy`（同一 HEAD，其链内 `try-restart ai-worker` 重绑 speech.sock）→ 最终 stamp `20260909T082843Z-755cc013b78f`
- 复验：`/run/suspect-interrogation/` 同时存在 `speech.sock`（16:30）与 `moss.sock`（16:35）；`/health/ready`：`asr AVAILABLE/AVAILABLE`、`vad AVAILABLE`、`speaker AVAILABLE`、`moss DISABLED (MOSS_ENABLED=0)`、overall `ready`
- 影响窗口如实记录：业务语音能力（asr/vad/speaker）自 13:36 起至 16:30 恢复期间处于 ERROR

## 收尾复验（最终状态）

```
$ python3 scripts/ci/probe-moss-rk3588.py --expect-manifest-sha256 b735dc2d…57fb1
"success": true   # PROBE_EXIT=0；unit active(3199055)/enabled；socket 0660；
                  # bundle 13/13 artifacts、policy [10,8,8]、SHA 匹配；
                  # 双库 SHA 批准匹配；health ok/idle/manifest 匹配；
                  # release 20260909T082843Z-755cc013b78f；TCP/8000 pid 1073/3374/3375
$ curl /health/live  → {"status":"alive"}
$ curl /health/ready → "status": "ready"；capabilities.moss = DISABLED（MOSS_ENABLED=0）
$ MossWorkerClient health → status=ok, manifest_sha256=b735dc2d…, queue_depth=0, active_job=null
```

## 追加变更清单（收尾，均未提交）

- `systemd/moss-worker.service`：移除 `RuntimeDirectory=*`（防共享目录 GC，注释说明）
- `tests/release/test_moss_systemd_and_deploy.py`：RuntimeDirectory 断言反转为禁止声明
- 本地验证：`pytest tests/release/test_moss_systemd_and_deploy.py tests/release/test_systemd_units.py` → **11 passed**（`test_speech_worker_launcher` 3 项失败经 stash 排除法确认为本机 WSL2 环境问题，与本改动无关）

## 755cc01 之后的部署机制说明（门槛 9 达成路径）

`AGENTS.md` 规定 `linux-adaptation` 为持续部署分支："Every push … must trigger `.github/workflows/rk3588-production-redeploy.yml`"；该 workflow 触发器为 `push: branches:[linux-adaptation]`（+`workflow_dispatch` 手动兜底），runs-on `[self-hosted, rk3588]`。门槛 9（部署 SHA=推送 SHA）由 CI 结构性保证：workflow 将 `$GITHUB_SHA` 写入 `.suspect-source-sha`，部署后断言 `test "$(cat current/.suspect-source-sha)" = "$GITHUB_SHA"`。本次手动重部署与该机制一致（同 HEAD、同 control.sh 链）；push 后应检查 workflow run 的部署摘要 `deployed_source_sha == workflow_target_sha`。

## 2026-09-09 Task 16 审讯业务接入（后端 + 前端 + 逐窗增量 + 激活）

### 提交链（全部经独立评审后推送）

- `671e531` feat(moss-worker): RECOVERY_REQUIRED 重启扫描（评审 PASS 0C/0I）
- `c4777ac` feat(moss): 三表 + alembic 0013
- `0ecb53d` feat(moss): coordinator + 6 业务端点 + app wiring
- `9d6ed6c` docs(moss): Task 16 plan 节 + spec §32
- `122e6ed` chore: sqlite wal/shm sidecar 忽略
- `e8f63ea` feat(moss): 处理中增量 revision（用户要求⑤：DONE 窗 segments → partial revision → status.revisionNo）
- `661c692` feat(webapp): MOSS 智能分人转写面板（第四页签；评审 PASS 附条件，2 处 Important 已修：status.revisionNo 类型 + pollTick MOSS_DISABLED 兜底；COMPLETED 文案对齐钦定「完成」）
- `8070295` ci(rk3588): runner 首次真实执行暴露三缺陷修复（moss.sock 断言 60s 重试环；sudo 剥环境致 probe fail-closed → --allow-any-output；alembic head 钉 0012→0013 + 契约测试同步）

### 板上全链冒烟（2026-09-09，全部亲测）

- 部署：CI Production Redeploy **success (2m37s)**，release `.suspect-source-sha` = `8070295afdb0…` == 推送 SHA；alembic current = `0013_moss_transcription_integration (head)`；probe success=true（bundle 13/13、策略 10/8/8、双库匹配、moss.sock 0660）
- 激活（按用户钦定顺序完成）：runtime.env 增 `MOSS_ENABLED=1`、`MODEL_ROOT=/opt/suspect-interrogation/models`（app registry 由此找到 bundle；此前误报 MODEL_NOT_INSTALLED）→ 重启 API → `moss=AVAILABLE, model=INSTALLED`
- 冒烟案件 `CASE-20260909-81F27B`（MOSS冒烟-勿用）；音频 = 板上 paraformer 示例语音拼接 60s（sha256 `520c39e0…`，落 `/var/lib/suspect-interrogation/moss-smoke.wav` 绕开 PrivateTmp）
- **状态机实录**：QUEUED → PREPARING → ENCODING → DECODING → COMPLETED（约 60s）
- **增量实证**：revisionNo=2（窗口 DONE 出部分文本 → COMPLETED 出最终 revision），transcriptionId `e536403b`，jobId `d2a38e32…`
- 转写 11 段、绝对毫秒时间戳、GS01、真实中文文本；PUT 映射 GS01→民警/GS02→嫌疑人 后 transcript role 即时生效
- 隔离核验：TCP/8000 pid 恒定（1073/3374/3375）；speech.sock 与 moss.sock 共存 0660；asr/vad/speaker=AVAILABLE；整体 ready
- 失败隔离与 byte-identical 语义由测试钉住（`test_moss_failure_leaves_existing_interrogation_text_byte_identical`）

### CI 终态（8070295）

- RK3588 Production Redeploy：**success**（部署 SHA 断言 + 全部 verify 步通过）
- Linux AI Runtime RK3588：**success**（4m1s；修复前 1h37m 失败）
- Linux CI（GitHub hosted）：failure = 既有 kiosk 截图 QA 404 问题，与本链无关（多次复现，独立存在）

### 生产配置现状（/etc/suspect-interrogation/runtime.env）

`MOSS_ENABLED=1`、`MODEL_ROOT=/opt/suspect-interrogation/models` 为板上运维配置（workflow upsert 列表不含这两键，跨部署持久）。
