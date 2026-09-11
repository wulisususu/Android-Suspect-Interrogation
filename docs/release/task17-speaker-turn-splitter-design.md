# Task 17B — SpeakerTurnSplitter 设计说明（基于实测数据）

状态：设计定稿待实现（Task 17B-2）。数据来源：RK3588 实机 ERes2Net sweep + 生产声纹库参考向量 + 真浏览器实时运行证据。

## 1. 问题（真机证据）

2026-09-11 真浏览器实时运行：一个 5 秒 VAD utterance 被整体判为 `SUSPECT`，文本把民警问句与嫌疑人答句拼在一起：

```
[70.9-75.9] SUSPECT 呃除了李伟以外当时还有其他人吗 一开始没有后来来了一个他认识的人我不
```

同一内容在 MOSS 全局聚类下被正确切成两段（源文件 99.84–105.24s：GS01 民警问 → GS02 嫌疑人答）。

## 2. 根因（代码定位）

`linux/backend/speech_worker/session.py:207 _finish_utterance()`：

- 224–226 行取整个 utterance PCM
- **242 行：对整段只调用一次 `transcribe()`**
- **248–276 行：对整段只提取一次 speaker embedding**

因此 `60s 连续语音被 FSMN-VAD 切到 5s` 只是**延迟上限**（`funasr_runtime.py:14 _FORMAL_MAX_SINGLE_SEGMENT_MS = 5000`），它回答的是"这里有没有人说话"，**不是"这里换人了吗"**。两人在 5 秒内完成一次问答且中间停顿未达 VAD 断句条件时，就产生"一段音频 → 一个判定"。

## 3. 实测数据（本设计的阈值依据）

### 3.1 相邻窗余弦（change point 用）

板上 1.5s 窗 / 0.5s 步，362 窗，单窗 embedding 中位 **690ms**：

| 类别 | n | min | p25/p10 | median | p75/p90 | max |
|---|---|---|---|---|---|---|
| 换人点（标注边界 ±1s 内最小值） | 28 | 0.005 | 0.096 | 0.243 | 0.317 | **0.552** |
| 同人段内（远离边界） | 32 | **0.349** | 0.476 | 0.769 | — | 0.874 |

两分布**重叠**（−0.203）→ 单一阈值不足。实测操作点：

| 阈值 | 检出换人点 | 同人段误触发 |
|---|---|---|
| 0.30 | 20/28 | 0/32 |
| 0.40 | 25/28 | 2/32 |
| 0.50 | 27/28 | 5/32 |

### 3.2 整段 vs 参考声纹余弦（门控用）

生产库参考向量（512 维，`eres2net_large`，quality=GOOD，20030ms）：

```
民警整段  n=17   min 0.067   median 0.156   max 0.268
嫌疑整段  n=28   min 0.725   median 0.826   max 0.902
混说 5s 窗 整段 = 0.4732
  滑窗：0.11 0.07 0.10 0.08 0.036 0.028 | 0.67 0.73
```

**结论**：干净单人 turn 与混说 utterance 在"整段 vs 参考"空间里天然可分——`0.268 ~ 0.725` 是空档，混说恰好落在正中间 0.473。生产阈值 0.372 + margin 0.08 让 0.473 被判成"确定 SUSPECT"，这才是 bug 的数值本质。

## 4. 设计：两阶段（参数已在真数据上验证）

> 验证脚本：`docs/release/task17-evidence/validate_splitter_design.py`
> 输入：`task17-gate-evidence.json`（整段 vs 参考）+ `task17-dual-sweep.json`（逐窗 cosPrev/cosRef）
> 结果：阶段一 45/45 干净段正确判定、0 误判；混说段判 AMBIGUOUS；阶段二切点误差 −310ms（真值 103310ms）

### 阶段一（门控）：**必须用整段单一 embedding**，不能用滑窗均值

理由（实测反例）：混说 5s 段的整段 cosRef = **0.4732**（落可疑带），但其滑窗均值仅 **0.228** → 会被误判成"确定另一人"。整段 embedding 是生产链路**本来就在算**的那一个，零额外成本。

门控带（由实测极值导出，与角色接受阈值**不同**）：

| 判定 | 条件 | 依据 |
|---|---|---|
| 确定嫌疑人单人 | `cosRef >= 0.70` | 嫌疑段实测 min 0.725 |
| 确定另一人单人 | `cosRef <= 0.29` | 民警段实测 max 0.268 |
| **可疑 → 进阶段二** | `0.29 < cosRef < 0.70` | 混说实测 0.4732 |

注意：**门控带 ≠ 生产接受阈值**（0.372 + margin 0.08）。接受阈值回答"这是不是嫌疑人"，门控带回答"这一段是不是只有一个人"——后者必须更严，否则就是本次 bug 的成因（0.473 ≥ 0.372 被当作确定 SUSPECT）。

### 阶段二（仅可疑段）：滑窗切分

```
1.5s 窗 / 0.5s 步，逐窗计算 cosPrev 与 cosRef
规则 A（首选，鲁棒）：相邻窗 cosPrev < T_FIRE(0.50) 且连续 ≥2 窗
规则 B（短 utterance 必需）：单个谷 + 两侧 cosRef 角色证据相反
        （左均 ≤ 0.29 且右均 ≥ 0.70，或反之）
```

规则 B 的必要性（实测）：混说 5s 段仅 11 窗，谷只跨 1 个窗对（103000ms, cosPrev 0.243）→ 规则 A 不触发；规则 B 用"谷 + 两侧角色相反"成功切分。

切分后：每个 turn 独立 ASR + 独立 embedding；
- 两侧角色相反 → 输出两个 turn（实测 turn A cosRef 0.105 民警 / turn B 0.722 嫌疑人）
- 只有谷没有角色支持 → **不切，标 ambiguous/overlap → UNKNOWN**
- 谷位置抖动/多重谷 → UNKNOWN

```
连续 PCM
  ↓
FSMN-VAD（只做 speech / non-speech；5s 仅作延迟上限）
  ↓
speech utterance
  ↓
阶段一（零额外成本）：整段 embedding vs 参考 → 确定单人 / 可疑
  ↓（可疑）
阶段二（仅可疑段付费）：滑窗 change point（规则 A → 规则 B）
  ↓
现有 SpeakerPolicy（AsrCaptureService）：继续负责"换成了谁"
```

### 关键边界（不可越界）

- **speech_worker 只回答"这里换人了"**，不接触数据库声纹参考 → 否则 biometric reference 进入 worker，耦合迅速失控。
- **角色判定仍归 `AsrCaptureService`**（现有 threshold / margin / 审计全部复用）。
- **不确定 → UNKNOWN**：取证系统里 `UNKNOWN > 错误确定`。宁可 `[73.0-73.6] 说话人待确认`，也不能把民警整句话写到嫌疑人名下。
- **5s 语义变更**：从"认为 5s 内是一个 speaker turn"改为"实时处理最大延迟 / safety cap"。
- 不引入重型在线 diarization 模型；复用现有 ERes2Net。

### 成本

朴素每窗滑窗 = 每 5s utterance 10 窗 × 690ms ≈ **6.9s（RTF 1.38）**，实时不可接受。
两阶段后：阶段一复用**已在计算**的整段 embedding（零额外成本），只有可疑段进入阶段二；实测语料中可疑段占比很低（干净 turn 全部被门控拦下）。

## 5. 回归验收（golden corpus）

语料：`linux/backend/tests/fixtures/speaker_turn_corpus/`
- `dual_qa_21_speaker_timeline.json`：45 段辅助标注（MOSS 簇 + 文本启发式，1 段待人工裁决）
- `speaker_corpus_manifest.json`：三档（dual-QA / suspect-only / officer-only）+ sha256
- 音频不入库，按 sha256 物化；缺失时测试 skip

**必过回归点（锚定源文件时间，可复现）**：

```
mixed-turn-src-99.8-105.2
  含 INTERROGATOR[99840-103010] + SUSPECT[103610-105240]
  期望：切成两个 turn；或交界判 UNKNOWN
  绝不允许：整段单一 SUSPECT
```

实时观测条目 `realtime-observation-70.9-75.9` 保留但标 OBSERVATION_ONLY，并记录会话时钟与源文件时钟约 +29s 偏移（假麦克风文件在按下开始录音前已在播放）。

## 6. 未决

- 民警单人录音语料缺失（第三档 MISSING）：当前可用 GS01 片段派生占位，但必须标注 "MOSS-derived"，等真实样本替换。
- `dual_qa_21` 标注中 1 段（137.58–140.08s）待人工裁听。
- 17B-1：readiness 需补 `enrollmentQuality` / `usableDurationMs` / `modelId` / `modelVersion`，并暴露**运行时生效**的 speaker 模式与 margin 状态（当前 UI 的 `recognitionMode` 只看民警声纹是否 ready，与运行时 `persisted_margin is None → SUSPECT_ONLY` 退化无关）。
