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

## 2026-09-11 Task 15 长音频实机验收

### 执行方式

- 板上常驻 runner：`/home/youyeetoo/task15/run_matrix.py`（nohup setsid，独立于会话），9 档串行；素材 manifest `task15/materials.json`（全档 sha256）；逐档结果 `task15/results/*.json` + `matrix.jsonl`；本地副本 `D:\police Android\task15\`。
- 素材：双人格 = asr_example × sv_example_different（真实两把声音）交替拼接；静音/噪声/重叠为同基料合成变体。每档独立案件 `T15-<档>-勿用`。

### 逐档终态（API 实拉）

| 档 | 终态 | 窗口 | RTF | 段数/要点 |
|---|---|---|---|---|
| 5m-single | COMPLETED | 1/1 DONE | 2.03 | 54 段全 VALID，GS01 870ms→299280ms 稳定 |
| 10m-dual | COMPLETED | 1/1 DONE | 7.37 | 189 VALID+1 REPAIRED；GS01×64+GS02×126 全程二分无漂移 |
| 30m-dual | COMPLETED | 4/4 DONE | 7.83 | 572 段全 VALID；rev1→4 单调；>5s 缺口=0；重复=0 |
| 60m-multi | FAILED | 6 DONE+w0007 FAILED | — | MOSS_INVALID_GENERATION |
| 70m-crosshour | FAILED | 6 DONE+w0007 FAILED | — | MOSS_INVALID_GENERATION |
| 120m-extreme | FAILED | 6 DONE+w0007 FAILED | — | MOSS_INVALID_GENERATION |
| silence-10m | FAILED | 10m→8m 降档后仍 FAILED | — | 静音退化输入；降档梯子按设计执行 |
| noise-10m | COMPLETED | 1/1 DONE | 11.60 | 108 段 |
| overlap-10m | COMPLETED | 1/1 DONE | 4.85 | 108 段 |

### 核心发现：长档第 7 窗 MOSS_INVALID_GENERATION

60/70/120m 三档**同一模式**：前 6 窗全部 DONE（每窗 generation 顶到 ~4570 token 上限后修复成功，token_count 4557~4574，spool `logs/events.jsonl` 原始 generation 证据完整保留），**第 7 窗修复耗尽 → MOSS_INVALID_GENERATION → 整 job 干净 FAILED**。RSS 峰值 4.46GB 恒定、无 OOM、无崩溃、状态机/证据链完整。模式高度一致指向跨窗状态累积类缺陷（子进程内第 7 次修复），V2 修复第一优先级（候选方向：生成上限/修复策略参数、跨窗子进程状态隔离）。

### 12 门槛判定

①5~120min 均 COMPLETED：**部分 FAIL**（5/9 过；60/70/120m 第 7 窗同因失败；silence 退化输入失败）②时间轴无缺口：PASS（COMPLETED 档 >5s 缺口=0）③时间戳单调在界：PASS ④overlap 无重复正文：PASS（near_duplicates=0）⑤GSxx 跨窗一致：PASS（30m 4 窗实测稳定）⑥跨小时不无故换人：部分（6 窗≈6 小时跨度素材内稳定；完整跨小时随①未达成）⑦REPAIRED 完整证据：PASS（10m 1 处，spool 在案）⑧INVALID 按 10→8 降档：PASS（silence 档降档梯子按设计执行，最终干净 FAILED）⑨增量 revision 不覆盖丢失：PASS（1→2→4→6 单调，append-only）⑩120min 不 OOM 不崩溃：PASS（RSS 4.46G 平稳，worker 全程存活）⑪FunASR 零扰动：PASS（TCP8000 pid 全程恒定）⑫provenance 全链可追溯：PASS（job/audio-sha/manifest/窗口/spool 全链在案）。

**RTF 全程只记录不设门槛**（实测 2.03~11.60，随窗数/人格数变化）。

### 附带实测：双路并发（声纹/实时链 + MOSS 重载同时跑）

- 业务链在 MOSS 解码重载下全链走通：建案件→身份确认→**嫌疑人声纹注册真实成功**（eres2net_large，suspectReady=true）→session/start→capture/start。
- FunASR 引擎压测（HTTP /asr/recognize，6×60s 真实音频）：延迟 9.7~20.1s/60s（RTF 0.16~0.33），零错误；asr/speaker/moss 全程 AVAILABLE。
- 结论：审讯实时链与 MOSS 长档转写并发，RK3588 可承受。证据：`task15/concurrent_result.json`、`task15/recognize_load.json`。

### 遗留与清理

- 首轮 harness 启动失败曾产生 9 个空 T15 案件行（无转写记录），与正式档同名，无功能影响，留待一并清理。
- runner 轮询上限 6h 对 7+ 窗档偏短（60m 实际 ~7h），终态以 API/spool 为准（本节已按真实终态修正）。
- 60/70/120m 三档 spool 原始 generation 与窗口证据完整保留于 `/var/lib/suspect-interrogation/moss/jobs/`，供 V2 修复复现。

## 2026-09-11 Task 17 修复与回归（进行中）

### 17A 声纹注册生命周期（已完成并上线）

**两个缺陷（均真机复现）**
1. 注册成功后 UI 误报失败：后端在 HTTP stop 期间关闭浏览器 WSS，前端 `browserVoiceprintCapture` 只有 `stopped/paused` 两布尔、`pause()` 不置 `stopped`，`onclose` 一律 `onError` → `abortCurrent()` 异步把 `phase` 从 `COMPLETE` 改写成 `ERROR`。真机现象：库中已是 `quality=GOOD / usable_duration_ms=20030`，UI 却显示"浏览器麦克风音频通道已断开，请重新开始声纹录制"。
2. 已注册嫌疑人失去重录入口：`TemplateDrivenInterrogationPage.vue` 用 `v-if="!readiness.suspectReady"` 卸载整个 Gate，使 `VoiceprintEnrollmentGate` 内早已写好的"重新录制"成为死代码，且 `TemplateDrivenInterrogationPage.test.ts:60-61` 把该错误结构固化为测试契约。后端 `VoiceprintService._upsert_suspect_reference()` 本就支持 REENROLL（先 VAD/质量校验后 `replace_suspect`，失败不动旧声纹），无需删库。

**修复**
- `browserVoiceprintCapture.ts`：显式生命周期 `CONNECTING/STREAMING/FINALIZING/STOPPED/FAILED` + `beginFinalize()`（停发 PCM、**不关通道**，因为先关会让后端 finally 走 cancel 而丢掉注册）+ attempt token + 终态单向。
- `useAutoVoiceprintEnrollment.ts`：顺序改为 `beginFinalize() → HTTP stop → refreshVoiceprintState() → capture.stop() → COMPLETE`，并加 `settling`/`cancellingFor` 守卫。
- 父页面：Gate 常驻 + `:compact="readiness.suspectReady"`，仅 `LiveDialoguePanel` 条件渲染；已注册态紧凑卡显示 `✓ 已注册 / 质量 / 有效语音 / [重新录制]`，重录失败显示"✓ 当前已有声纹仍然有效 + [再次重新录制]"。

**产线验证（DoD）**：三个提交 `5fc2a856` / `553fc57f` / `26ea94da` 推送 → CI 生产重部署 → 板上 SHA `3c3efd62`（祖先含三者）→ `/health/live` HTTP 200 且 `ssl_verify_result=0`（用 `/etc/suspect-interrogation/tls/ca.crt` 校验，未用 `-k`）、`/health/ready` ready（asr/speaker/moss 均 AVAILABLE、`margin_configured=true`）、TCP/8000 pid 1073/3374 未变、dist 含 `beginFinalize` 与（重新录制）文案。

**真 Chrome 回归（部署版，6/6 PASS）**：`regression-17a.mjs` 走真 UI 建案 → 断言语义：未注册显示"开始录制"；注册后**不再出现失败文案**且 readiness `suspectReady=true`；Gate 常驻并出现"重新录制"；点击后**不删库即可重新注册**。报告 `regression-17a.json`。

**独立评审判定"需返工"**：评审提出 Blocker B1（`refreshVoiceprintState()` 抛错时 `closeBrowserCapture()` 永不被调用 → 麦克风常亮 / `getUserMedia` 泄漏）与 I2（`beginFinalize()` 在 `try` 之外）、I3（`OfficerVoiceprintLibrary` 无 settling 守卫）、以及模式 chip 仍显示声明模式。评审员用"预修复文件 + 新测试"反向验证：13 例失败（生命周期套件 8/8 全红），证明新测试确实打在生产代码上。

**评审争议裁决（2026-09-11，以源码为证）**：实现者反驳 B1 的机制描述；我导出 `26ea94da` 原文逐行核对后确认**实现者正确、评审员该条有误**——两个 `catch` 里**本来就有** `await closeBrowserCapture(capture)`，故"refresh 失败 → 麦克风常亮"的可达回归**并不存在**。真实情况：同一函数内有两类**早退分支**（`if (!isCurrentAttempt(attempt)) return`，位于 HTTP stop 之后与 refresh 之后）会跳过 close；返工把 close 移入 `finally` 使释放变为**无条件**（这才是该改动的真实价值），并锁定 `beginFinalize → http:stop → close` 顺序。**真正可复现的活跃缺陷**由实现者指出并给出 red 证据（`expected true to be false`）：`beginFinalize()` 位于 `try` 之外，抛错则 `voiceprintBusy` 永久 `true`、录制按钮永久禁用。返工提交 `4b750a5b`，我复核：`npx vitest run` 35 文件 / 165 例全绿、`vue-tsc` exit 0、`finally` 位于 253/302/354 行并覆盖 249/283/285/298/350 的早退分支。

**方法论要点**：对抗性验证必须**双向**——独立评审也会给出错误结论，实现者有权反驳，最终以源码证据裁决；双方都留下可复核的原始输出，才谈得上"证据"。

### 17B-1 effective speaker mode（已提交，待产线部署）

- 新增 `app/services/speaker_mode.py`：唯一权威规则 `resolve_effective_recognition_mode` + 运行时谓词 `narrow_decision_roles` + `SpeakerModeConfig`（`from_sources` 按 活动 capture runtime → AI supervisor → 进程设置 取第一个携带操作点的源；`MODEL_BASELINE` 视为**非设备校准**）。
- `asr_capture_service.py` 两处重复 `if persisted_margin is None` 删除，改为复用共享规则（判定行为不变，另加日志与审计字段）；`readiness()` 纯增量补 `enrollmentQuality/usableDurationMs/modelKey/modelId/modelVersion` 与 `speakerMargin/speakerThreshold/thresholdSource/marginConfigured/thresholdConfigured/declaredRecognitionMode/effectiveRecognitionMode/recognitionModeDegraded/recognitionModeDegradedReason`；运行时配置由 API 路由注入（service 不读 `app.state`）。
- 前端：根因是 `normalizeVoiceprintReadiness` **一直在丢弃 readiness 新字段**（这才是紧凑卡"质量：未知"的原因，不是后端没给）；已透传并新增退化显式提示（`role="status"` + `aria-live="polite"`）。
- 我独立核验：一致性契约测试**直连生产决策路径**（`AsrCaptureService._decide_with_operating_point`），断言 margin 存在→两侧都放行民警、margin 缺失→两侧都只认嫌疑人；21 例通过。板上实测 margin=0.08 已配置 → 今天两侧一致，本条的目的在于把一致性做成**可证明**、不一致必须显式可见。

### 17B-2 SpeakerTurnSplitter（设计已验证，实现进行中）

**根因**：`speech_worker/session.py:207 _finish_utterance()` 对**整段 utterance 只做一次 ASR（:242）与一次 speaker embedding（:248-276）**；`funasr_runtime.py:14` 的 5s 只是延迟上限（`max_single_segment_time`），回答的是"有没有人说话"而非"换人了吗"。

**板上实测（真 ERes2Net + 真声纹参考，512 维）**
- 整段 vs 参考：民警段 0.067–0.268、嫌疑段 0.725–0.902；**混说 5s 段 = 0.4732**（滑窗均值仅 0.228 → 会被误判成"确定另一人"，故门控必须用整段单一 embedding）
- 门控带 `(0.29, 0.70)` 由实测极值导出，**比角色接受阈值 0.372+margin 更严**（后者答"是不是嫌疑人"，前者答"是否只有一人"）
- 相邻窗余弦：边界处 0.005–0.552、同人段 0.349–0.874（分布重叠 → 单阈值不足，需迟滞与双重确认）
- 阶段二规则 B（单谷 + 两侧角色相反）为短 utterance 必需：混说段 11 窗仅 1 个低于阈值的窗对（103000ms, cosPrev 0.243）；据此切分误差 **−310ms**（真值 103310ms），左 cosRef 0.105（民警）/ 右 0.722（嫌疑人）
- 成本：单窗 embedding 中位 **690ms** → 朴素滑窗 RTF≈1.38，故必须两阶段门控（实测 45/45 干净段由阶段一拦下）

**语料与必过回归点**：`linux/backend/tests/fixtures/speaker_turn_corpus/`（manifest 按档 pin sha256，音频按哈希物化不入库；标注为"MOSS 簇 + 文本启发式"的**辅助**标注，45 段，1 段待人工裁听）。必过点 `mixed-turn-src-99.8-105.2`（源文件时钟，含民警问句 99840-103010 + 嫌疑人答句 103610-105240）要求切成两个对立角色 turn 或交界 UNKNOWN，**绝不允许整段单一 SUSPECT**；实时观测条目 `realtime-observation-70.9-75.9` 单列并注明会话时钟比源文件慢 ≈29s。

**验收器**：`run_splitter_corpus_check.py`（真模型，按"一个 VAD utterance"回放必过点，另查 45 段是否被过切；`--no-reference` 复刻生产 worker 的无参考路径）。已用一次性原型自证可行（并借此修掉两个验收器自身缺陷：必过点必须作为单一 utterance 回放、file-loaded 模块须先注册 `sys.modules`）。

**实现结果（`6346ea61` 分割器 + `d5a25f31` 接入）**：真语料上**两种模式给出同一结果**，且是**真切分**而非保守 UNKNOWN：
```
mixed-turn-src-99.8-105.2 : satisfied
  [99840-102840]  INTERROGATOR  cosRef 0.107
  [102840-105240] SUSPECT      cosRef 0.752        （切点误差 −470ms，容差 ±1s）
不过切 : 45/45 干净段保持单 span，0 误切
```
`session.py` 接入：`_finish_utterance` 先分段再逐 turn 转写+取 embedding，事件用绝对会话毫秒；仅对 ≥3s 的 utterance 分段（VAD 本身把段限制在 5s，故窗滑成本有界）；无参考路径只用规则 A 与深谷；无法定界的事件带 `overlap=True`（`SpeakerPolicy` 已知会判 UNKNOWN）；分段异常只记日志并保留整段，绝不丢 utterance。单测：分割器 20 例 + 会话接入 3 例新增（长句真切分 / 平段保守 overlap / 短句不付出分段代价），speech 相关套件 45 passed，AF_UNIX/POSIX 的 10 个失败经 `git stash` 复跑证实与本改动无关。

**测试套件说明（透明记录）**：继承来的草稿测试（663 行）**从未绿过**，其合成 fixture 数学自相矛盾（断言"与 SUSPECT 余弦 <0.50"而实际构造出 0.90，且注释与参数不一致），三个 agent 在其上往复震荡（失败数 14↔26）。最终由维护者重写：新套件以**几何自检**固化 fixture（`test_fixture_geometry_matches_the_documented_cosines`），并以**真语料必过点**为主判据。

### 收官：生产部署与四项板上验收（全部 PASS）

**部署**：`3c3efd62..323b625a` 推送 → CI 生产重部署 → 板上 `.suspect-source-sha` = **323b625a** = 推送 SHA，新发布 `20260911T095824Z-manual`（前后端同发布）。DoD：`/health/live` `HTTP 200 verify=0`（项目 LAN CA 校验，未用 `-k`）；`/health/ready` ready，asr/speaker/moss AVAILABLE、`margin_configured=true`；TCP/8000 pid 1073/3374 + funasr worker **未被触碰**；`dist` 含 `beginFinalize` / `effectiveRecognitionMode` / `recognitionModeDegraded`。

| 验收 | 结果 |
|---|---|
| 语料必过点（**已部署模块**，参考模式） | PASS `[99840-102840] 民警 0.107` + `[102840-105240] 嫌疑人 0.752`；45/45 不过切 |
| 语料必过点（已部署模块，**worker 无参考路径**） | PASS 同上 |
| `regression-17a`（注册不再假失败 / 重录入口 / 不删库重录） | **6/6 PASS**（顺带可见 `质量：GOOD 有效语音：20.24 秒`，即 17B-1 修的字段丢失已生效） |
| `regression-17b1`（生效模式 + margin/threshold + 注册指标 + 无退化误报） | **6/6 PASS**（readiness 实测 `effectiveRecognitionMode=SUSPECT_ONLY`、`recognitionModeVerified=true`、`source=DEVICE_CALIBRATION`、`marginConfigured=true`、`degraded=false`；`enrollmentQuality=GOOD`、`usableDurationMs=20040`、`modelId/Key/Version` 齐全） |
| `regression-17b2`（真浏览器实时：混说不得整段 SUSPECT） | **PASS** 36 片段 / 21 处命中 / **11 条混说片段全部 UNKNOWN**，无一条 SUSPECT |

**17b2 的机制证据**（新片段实测）：混说片段落库为 `speaker=UNKNOWN, speaker_score=None, low_confidence=1, speaker_source='UNASSIGNED'` —— 即策略在打分前短路为"无归属"（切分器给出的 overlap 信号），而不是"打分后勉强判某人"；同一轮中 1.94s 的纯嫌疑人片段被正确判为 `SUSPECT 0.798`。**对比修复前基线**：同一位置是一条 `SUSPECT` 片段、文本把民警问句与嫌疑人答句拼接（`regression-17b2.mjs` 首次运行即捕获该形态作为 before 证据）。

**如实区分两条结论**：实时链路当前对混说 utterance 产出的是 **overlap → UNKNOWN（安全）**，而"**真正切成两个 turn**"是在**部署模块 + 真语料回放**上证明的（切点误差 −470ms）。两者都满足必过要求（切成两段、或交界 UNKNOWN，绝不允许整段 SUSPECT），但不应把前者说成后者。
