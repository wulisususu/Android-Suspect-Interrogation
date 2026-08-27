# FunASR Voiceprint Speech Pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Integrate the RK3588-local Paraformer + FSMN-VAD + XVector model set into the Linux interrogation system with mandatory suspect enrollment, optional reusable police voiceprints, session role binding, auditable speaker attribution, and a production-safe offline deployment path.

**Architecture:** Keep FastAPI as the business/API process and run one isolated Speech Pipeline Worker under the existing `ai-worker.service`. The worker owns FunASR/PyTorch and all streaming VAD/ASR/XVector state; FastAPI communicates with it only through a local Unix-domain socket. ALSA capture remains owned by the existing Linux hardware layer. Model weights are exposed read-only at `/opt/suspect-interrogation/models/funasr`, outside immutable releases. Suspect voiceprints are case-scoped; police officer voiceprints are persisted in one reusable library while interrogator/recorder roles are assigned per session.

**Tech Stack:** Python 3, FastAPI, SQLAlchemy/Alembic, SQLite, Unix domain sockets, FunASR `AutoModel`, PyTorch CPU inference, ALSA audio gateway, Vue 3 + TypeScript + Pinia + Vitest, systemd, GitHub Actions self-hosted RK3588 runner.

**Spec:** `docs/superpowers/specs/2026-08-27-funasr-voiceprint-speech-pipeline-design.md`

## Global Constraints

- Never commit Paraformer/FSMN-VAD/XVector weights or enrollment embeddings to Git.
- Never copy model weights into each `/opt/suspect-interrogation/releases/<release>` directory.
- Preserve the unrelated service already occupying TCP/8000; this feature must not stop, reconfigure, proxy through, or take ownership of it.
- Production inference is fully offline. FunASR must be created with local model paths and `disable_update=True`; the worker must not download models at runtime.
- Do not claim NPU/RKNN acceleration in this phase. The current `.pt`/`.pth` artifacts are treated as CPU/PyTorch until a separately approved conversion phase.
- Suspect voiceprint readiness is a hard gate for starting a voice interrogation. Police officer voiceprints remain optional.
- A non-suspect segment classified as `OFFICER_FALLBACK` is not a biometrically verified police identity.
- Raw machine ASR text and original speaker decision provenance are immutable audit inputs; manual edits create revisions/audit records.
- Production speaker thresholds have no silent hard-coded default. Real-mode speaker recognition stays `NOT_CONFIGURED` until RK3588 calibration values are present in `/etc/suspect-interrogation/ai-worker.env`.
- Tests use deterministic mock thresholds and embeddings only; those values must never become production defaults.
- Each task starts with a failing test or failing verification, implements only enough to pass, reruns focused tests, then runs the relevant broader suite before commit.

---

## Task 1: Add an RK3588 FunASR discovery probe and make the AI workflow target `linux-adaptation`

**Files:**
- Create: `scripts/ci/probe-funasr-runtime.py`
- Create: `tests/release/test_funasr_probe_script.py`
- Modify: `.github/workflows/linux-ai-runtime-rk3588.yml`
- Modify: `docs/release/RK3588-EVIDENCE.md`

### Steps

- [ ] **1.1 Write a failing contract test for the probe script.**

Create `tests/release/test_funasr_probe_script.py` and assert that the probe:

```python
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts" / "ci" / "probe-funasr-runtime.py"


def test_probe_exists_and_is_offline_and_non_destructive():
    text = SCRIPT.read_text(encoding="utf-8")
    assert "disable_update=True" in text
    assert "MODEL_ROOT" in text
    assert "paraformer" in text
    assert "fsmn-vad" in text
    assert "xvector" in text
    assert "AutoModel" in text
    assert "unlink(" not in text
    assert "rmtree(" not in text
```

Run:

```bash
python3 -m pytest tests/release/test_funasr_probe_script.py -q
```

Expected: FAIL because the script does not exist.

- [ ] **1.2 Implement a read-only probe.**

`probe-funasr-runtime.py` must:

1. Read `MODEL_ROOT` (default only for this RK3588 probe: `/home/youyeetoo/funasr-models`).
2. Validate these three directories exist: `paraformer`, `fsmn-vad`, `xvector`.
3. Recursively report filenames, byte sizes, and SHA-256 only for small config/metadata files; do not hash multi-hundred-MB weight files during every CI run.
4. Report Python executable, `platform.machine()`, FunASR version, torch version, and available CPU thread count.
5. Import `from funasr import AutoModel` and instantiate each model with its local directory, `device="cpu"`, `disable_update=True`, `disable_pbar=True`.
6. Record load duration and success/failure per model as JSON.
7. For XVector, include an optional `--speaker-wav` argument. If supplied, call `generate(input=<wav>)` and record the returned keys and embedding shape, requiring `spk_embedding` before later implementation tasks proceed.
8. For VAD and Paraformer, include optional `--speech-wav`; when supplied, record VAD result keys/segments and ASR result keys/text without persisting the audio.
9. Write a JSON report only to a caller-provided `--output` path under the runner workspace or `$RUNNER_TEMP`.
10. Exit non-zero if a model fails to load or a requested inference probe fails.

The probe must never modify anything under `MODEL_ROOT`.

- [ ] **1.3 Update the RK3588 AI workflow.**

Change `.github/workflows/linux-ai-runtime-rk3588.yml` so that:

- push branch is `linux-adaptation`, not `linux-ai-runtime`;
- path filters include `scripts/ci/probe-funasr-runtime.py`, `systemd/ai-worker.service`, and the speech runtime files added later;
- the existing mock compile/test steps remain;
- a real-model discovery step runs only when `/home/youyeetoo/funasr-models` exists and a FunASR-capable Python interpreter is found;
- discovery first checks the known RK3588 environment at `/home/youyeetoo/rkllm_model_zoo/funasr_env/bin/python`, then falls back to `python3` only if `import funasr` succeeds;
- it runs the probe with `MODEL_ROOT=/home/youyeetoo/funasr-models` and writes `$RUNNER_TEMP/funasr-probe.json`;
- the job prints the report but does not download dependencies or models.

Do not call, kill, or restart the existing process on TCP/8000.

- [ ] **1.4 Run focused and workflow contract tests.**

```bash
python3 -m pytest tests/release/test_funasr_probe_script.py tests/release/test_rk3588_bootstrap_workflow.py -q
```

Expected: PASS.

- [ ] **1.5 Commit.**

```bash
git add scripts/ci/probe-funasr-runtime.py tests/release/test_funasr_probe_script.py .github/workflows/linux-ai-runtime-rk3588.yml docs/release/RK3588-EVIDENCE.md
git commit -m "test: add offline FunASR RK3588 discovery probe"
```

---

## Task 2: Establish the stable production model/runtime layout without touching port 8000

**Files:**
- Modify: `.github/workflows/rk3588-service-bootstrap.yml`
- Modify: `deploy/control.sh`
- Modify: `deploy/suspect-interrogation.env.example`
- Modify: `systemd/ai-worker.service`
- Modify: `systemd/interrogation-api.service`
- Modify: `tests/release/test_systemd_units.py`
- Modify: `tests/release/test_rk3588_bootstrap_workflow.py`

### Steps

- [ ] **2.1 Extend release tests first.**

Add assertions requiring these stable paths/configuration:

```text
/opt/suspect-interrogation/models/funasr
/opt/suspect-interrogation/runtime/funasr-env
/run/suspect-interrogation/speech.sock
```

`test_systemd_units.py` must require:

- `RuntimeDirectory=suspect-interrogation` on the AI worker;
- `ReadWritePaths=/run/suspect-interrogation` where needed;
- `ReadOnlyPaths=/opt/suspect-interrogation/models/funasr` on the worker;
- `ProtectHome=true` remains enabled;
- no service contains `/home/youyeetoo/backend`, `:8000`, or a command that stops the unrelated FunASR process.

`test_rk3588_bootstrap_workflow.py` must require the bootstrap to explicitly preserve TCP/8000 and prepare the stable FunASR model/runtime directories.

Run:

```bash
python3 -m pytest tests/release/test_systemd_units.py tests/release/test_rk3588_bootstrap_workflow.py -q
```

Expected: FAIL.

- [ ] **2.2 Add idempotent model exposure to the bootstrap workflow.**

The bootstrap step must:

1. Verify `/home/youyeetoo/funasr-models` exists.
2. Create `/opt/suspect-interrogation/models/funasr` root-owned.
3. If the target is not already a mountpoint, bind-mount `/home/youyeetoo/funasr-models` onto it.
4. Remount the bind as read-only.
5. Verify `findmnt -no OPTIONS /opt/suspect-interrogation/models/funasr` contains `ro`.
6. Verify the three child directories are visible from `/opt/...`.
7. Add one duplicate-safe `/etc/fstab` entry so the read-only bind survives reboot:

```text
/home/youyeetoo/funasr-models /opt/suspect-interrogation/models/funasr none bind,ro,nofail,x-systemd.before=ai-worker.service 0 0
```

The script must check for an exact existing destination field before appending, so repeated workflow runs do not duplicate the line.

- [ ] **2.3 Create a stable offline FunASR runtime copy outside releases.**

If `/opt/suspect-interrogation/runtime/funasr-env/bin/python` does not exist:

1. Require `/home/youyeetoo/rkllm_model_zoo/funasr_env/bin/python`.
2. Copy that environment once to `/opt/suspect-interrogation/runtime/funasr-env` with ownership `root:root` and non-world-writable permissions.
3. Run:

```bash
/opt/suspect-interrogation/runtime/funasr-env/bin/python -c 'import funasr, torch; print(funasr.__version__)'
```

4. Abort deployment if relocation/import validation fails.

Subsequent normal deploys must reuse the stable copy; they must not recopy it into every release. A future runtime refresh is a separate explicit maintenance action, not automatic deployment behavior.

- [ ] **2.4 Add runtime environment keys.**

`deploy/suspect-interrogation.env.example` documents:

```text
SUSPECT_SPEECH_SOCKET=/run/suspect-interrogation/speech.sock
SUSPECT_FUNASR_MODEL_ROOT=/opt/suspect-interrogation/models/funasr
SUSPECT_FUNASR_PYTHON=/opt/suspect-interrogation/runtime/funasr-env/bin/python
```

`ai-worker.env` will later hold the speaker threshold/margin; do not set production defaults here.

- [ ] **2.5 Harden and wire systemd units.**

`ai-worker.service` should use the project launcher and retain `ProtectHome=true`, with:

```ini
RuntimeDirectory=suspect-interrogation
RuntimeDirectoryMode=0750
ReadWritePaths=/run/suspect-interrogation /var/lib/suspect-interrogation /var/log/suspect-interrogation
ReadOnlyPaths=/opt/suspect-interrogation/models/funasr /opt/suspect-interrogation/runtime/funasr-env
```

`interrogation-api.service` gains read/write access only to `/run/suspect-interrogation` in addition to its existing state/log paths. It must not gain access to `/home`.

- [ ] **2.6 Run release tests.**

```bash
python3 -m pytest tests/release/test_systemd_units.py tests/release/test_rk3588_bootstrap_workflow.py -q
bash tests/release/test_control_shell.sh
```

Expected: PASS.

- [ ] **2.7 Commit.**

```bash
git add .github/workflows/rk3588-service-bootstrap.yml deploy/control.sh deploy/suspect-interrogation.env.example systemd tests/release
git commit -m "deploy: add stable offline FunASR runtime layout"
```

---

## Task 3: Define the speech-worker protocol and a deterministic mock implementation

**Files:**
- Create: `linux/backend/app/ai/speech/__init__.py`
- Create: `linux/backend/app/ai/speech/types.py`
- Create: `linux/backend/app/ai/speech/protocol.py`
- Create: `linux/backend/app/ai/speech/client.py`
- Create: `linux/backend/app/ai/speech/mock_worker.py`
- Create: `linux/backend/tests/test_speech_protocol.py`
- Modify: `linux/backend/app/ai/settings.py`

### Steps

- [ ] **3.1 Write protocol tests first.**

Cover:

- length-prefixed UTF-8 JSON messages over AF_UNIX;
- binary PCM encoded once per request using base64 in the JSON payload;
- maximum message size rejection;
- request IDs and typed error responses;
- `open_session`, `push_pcm`, `finalize_session`, `close_session`, `extract_embedding`, and `health` operations;
- disconnect/reconnect behavior without leaking session state.

Use a temp Unix socket and `mock_worker.py`; no FunASR dependency in unit tests.

Run:

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_speech_protocol.py -q
```

Expected: FAIL.

- [ ] **3.2 Define stable speech types.**

`app/ai/speech/types.py` should include:

```python
from dataclasses import dataclass, field
from enum import Enum

class SpeechEventType(str, Enum):
    VAD_START = "VAD_START"
    VAD_END = "VAD_END"
    ASR_PARTIAL = "ASR_PARTIAL"
    ASR_FINAL = "ASR_FINAL"
    SPEAKER_RESULT = "SPEAKER_RESULT"
    ERROR = "ERROR"

@dataclass(frozen=True)
class SpeechEvent:
    type: SpeechEventType
    session_id: str
    start_ms: int | None = None
    end_ms: int | None = None
    text: str | None = None
    confidence: float | None = None
    embedding: list[float] | None = None
    model_id: str | None = None
    details: dict = field(default_factory=dict)
```

The worker protocol returns neutral speaker embeddings/events. Business role attribution stays in FastAPI so biometric templates do not need to be loaded into the model worker.

- [ ] **3.3 Implement a single-client abstraction.**

`SpeechWorkerClient` exposes:

```python
health() -> dict
open_session(session_id: str, sample_rate: int = 16000) -> dict
push_pcm(session_id: str, pcm: bytes) -> list[SpeechEvent]
finalize_session(session_id: str) -> list[SpeechEvent]
close_session(session_id: str) -> None
extract_embedding(pcm: bytes, sample_rate: int = 16000) -> dict
```

It must translate missing socket, timeout, malformed response, and worker errors into existing typed AI errors rather than leaking raw `OSError` into FastAPI.

- [ ] **3.4 Add settings.**

`AISettings` gains:

```text
speech_socket
speaker_accept_threshold
speaker_margin
```

In `AI_MODE=real`, missing threshold/margin means speaker role verification is `NOT_CONFIGURED`; in `AI_MODE=mock`, tests may inject explicit values.

- [ ] **3.5 Make mock protocol tests pass.**

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_speech_protocol.py tests/test_ai_mock.py -q
```

Expected: PASS.

- [ ] **3.6 Commit.**

```bash
git add linux/backend/app/ai/speech linux/backend/app/ai/settings.py linux/backend/tests/test_speech_protocol.py
git commit -m "feat: add local speech worker protocol"
```

---

## Task 4: Implement the real FunASR Speech Pipeline Worker

**Files:**
- Create: `linux/backend/speech_worker/__init__.py`
- Create: `linux/backend/speech_worker/main.py`
- Create: `linux/backend/speech_worker/funasr_runtime.py`
- Create: `linux/backend/speech_worker/session.py`
- Create: `linux/backend/tests/test_funasr_runtime_adapter.py`
- Modify: `scripts/ai-worker-start.sh`
- Modify: `systemd/ai-worker.service`
- Modify: `linux/backend/config/model-registry.yaml`
- Modify: `linux/backend/tests/test_registry.py`

### Steps

- [ ] **4.1 Write adapter tests around a fake `AutoModel`.**

Do not import real FunASR in CI unit tests. Inject a fake model factory and assert:

- paths are `/opt/suspect-interrogation/models/funasr/paraformer`, `fsmn-vad`, `xvector`;
- all models are constructed with `device="cpu"`, `disable_update=True`, `disable_pbar=True`;
- XVector extraction rejects results without `spk_embedding`;
- embeddings are converted to normalized `float32` lists;
- VAD output is normalized to millisecond `[start, end]` segments;
- Paraformer output is normalized to text/confidence without inventing partial tokens;
- model-load errors become typed `BACKEND_UNAVAILABLE` / `MODEL_NOT_INSTALLED` errors.

Run:

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_funasr_runtime_adapter.py tests/test_registry.py -q
```

Expected: FAIL.

- [ ] **4.2 Update the model registry.**

Replace the production ASR entry that assumes `sherpa-onnx/model.onnx` and add VAD/speaker entries. The checked-in registry describes logical paths under `SUSPECT_FUNASR_MODEL_ROOT`:

```yaml
asr.default:
  kind: asr
  backend: funasr
  path: paraformer
  architecture: paraformer
  device: cpu

vad.default:
  kind: vad
  backend: funasr
  path: fsmn-vad
  architecture: fsmn-vad
  device: cpu

speaker.default:
  kind: speaker
  backend: funasr
  path: xvector
  architecture: xvector
  device: cpu
```

Do not guess `required_files` beyond what Task 1 actually observed. After the RK3588 probe identifies the installed package, encode the observed config/weight filenames in the registry test fixture. At minimum, Paraformer must validate its discovered configuration artifacts in addition to `model.pt`, and XVector must validate the files proven necessary for `AutoModel` load rather than only assuming `sv.pth` is sufficient.

- [ ] **4.3 Implement `FunASRSpeechRuntime`.**

Use local paths only:

```python
from funasr import AutoModel

self.asr = AutoModel(model=str(asr_dir), device="cpu", disable_update=True, disable_pbar=True)
self.vad = AutoModel(model=str(vad_dir), device="cpu", disable_update=True, disable_pbar=True)
self.speaker = AutoModel(model=str(spk_dir), device="cpu", disable_update=True, disable_pbar=True)
```

The runtime owns all three models and exposes:

- `load()` / `health()`;
- `vad(pcm, sample_rate)`;
- `transcribe(utterance_pcm, sample_rate)`;
- `speaker_embedding(utterance_pcm, sample_rate)`.

Use the real probe result to match the installed XVector output contract. Current FunASR conventions use `spk_embedding`; the implementation must fail clearly if the installed XVector package differs rather than silently returning a zero vector.

- [ ] **4.4 Implement session-scoped VAD state.**

`SpeechSession` stores only current-session streaming state:

```text
session_id
sample_rate
pre_roll_pcm
current_utterance_pcm
vad_cache
utterance_start_ms
stream_offset_ms
last_activity_monotonic
```

For every `push_pcm`, feed only the new audio chunk into FSMN-VAD's supported streaming path discovered in Task 1. When VAD closes an utterance, send that utterance once to Paraformer and XVector, then emit one `ASR_FINAL` plus one `SPEAKER_RESULT` event with identical time bounds.

If the installed Paraformer is offline-only, emit no fabricated `ASR_PARTIAL`; final text is authoritative. If Task 1 proves a supported streaming Paraformer API, partial events may be added behind a capability flag while final recognition remains VAD-bounded.

- [ ] **4.5 Implement the worker server.**

`speech_worker/main.py` binds only the Unix socket from `SUSPECT_SPEECH_SOCKET`, removes a stale socket only after proving no active listener exists, sets mode `0660`, and serves one process with per-session state protected by locks. No TCP listener is created.

On SIGTERM/SIGINT:

- stop accepting requests;
- close sessions;
- unlink the socket;
- release models;
- exit cleanly.

- [ ] **4.6 Make the launcher execute the stable FunASR interpreter.**

`scripts/ai-worker-start.sh` should no longer be a generic no-op when models exist. It validates:

```text
$SUSPECT_FUNASR_PYTHON
$SUSPECT_FUNASR_MODEL_ROOT
$SUSPECT_SPEECH_SOCKET
```

then executes:

```bash
exec "$SUSPECT_FUNASR_PYTHON" -m speech_worker.main
```

with `PYTHONPATH=/opt/suspect-interrogation/current/linux/backend`.

- [ ] **4.7 Run focused tests and compile.**

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_funasr_runtime_adapter.py tests/test_registry.py tests/test_speech_protocol.py -q
PYTHONPATH=. python3 -m compileall -q app speech_worker
```

Expected: PASS.

- [ ] **4.8 Commit.**

```bash
git add linux/backend/speech_worker linux/backend/app/ai/speech linux/backend/config/model-registry.yaml linux/backend/tests/test_funasr_runtime_adapter.py linux/backend/tests/test_registry.py scripts/ai-worker-start.sh systemd/ai-worker.service
git commit -m "feat: implement offline FunASR speech worker"
```

---

## Task 5: Add biometric persistence, ASR capture tables, and Alembic migration

**Files:**
- Modify: `linux/backend/app/database/models.py`
- Create: `linux/backend/alembic/versions/0002_voiceprint_speech_pipeline.py`
- Create: `linux/backend/app/repositories/voiceprints.py`
- Create: `linux/backend/app/repositories/asr_fragments.py`
- Create: `linux/backend/tests/test_voiceprint_repositories.py`
- Modify: `linux/backend/tests/test_migrations.py`
- Modify: `linux/backend/app/repositories/__init__.py`

### Steps

- [ ] **5.1 Extend migration expectations first.**

Add these required tables to `REQUIRED_TABLES`:

```text
suspect_voiceprints
officer_voiceprints
session_voice_assignments
asr_capture_sessions
asr_fragments
```

Run:

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_migrations.py -q
```

Expected: FAIL.

- [ ] **5.2 Add SQLAlchemy models.**

Use `LargeBinary` for normalized float32 embeddings; do not store them as JSON strings.

Schema:

```text
suspect_voiceprints
  id PK
  case_id FK cases.id UNIQUE
  embedding LargeBinary
  embedding_dim Integer
  model_id String
  model_version String nullable
  enrollment_quality String
  usable_duration_ms Integer
  active Boolean
  created_at DateTime
  updated_at DateTime

 officer_voiceprints
  id PK
  officer_id String UNIQUE/indexed
  officer_name String
  embedding LargeBinary
  embedding_dim Integer
  model_id String
  model_version String nullable
  enrollment_quality String
  usable_duration_ms Integer
  active Boolean
  revoked_at DateTime nullable
  created_at DateTime
  updated_at DateTime

session_voice_assignments
  id PK
  session_id FK interrogation_sessions.id UNIQUE
  suspect_voiceprint_id FK suspect_voiceprints.id
  interrogator_officer_id String nullable
  interrogator_voiceprint_id FK officer_voiceprints.id nullable
  recorder_officer_id String nullable
  recorder_voiceprint_id FK officer_voiceprints.id nullable
  recognition_mode String
  created_at DateTime
  updated_at DateTime

asr_capture_sessions
  id PK
  case_id FK cases.id
  interrogation_session_id FK interrogation_sessions.id nullable
  status String
  sample_rate Integer
  started_at DateTime
  ended_at DateTime nullable
  created_at DateTime

asr_fragments
  id PK
  capture_session_id FK asr_capture_sessions.id
  case_id FK cases.id
  ordinal Integer
  started_at_ms Integer
  ended_at_ms Integer
  raw_text Text
  edited_text Text
  asr_confidence Float nullable
  speaker String
  speaker_id String nullable
  speaker_name String nullable
  speaker_score Float nullable
  second_best_score Float nullable
  speaker_threshold Float nullable
  speaker_margin Float nullable
  speaker_source String
  voiceprint_verified Boolean
  low_confidence Boolean
  state String
  model_id String
  model_version String nullable
  confirmed_message_id FK messages.id nullable
  created_at DateTime
  updated_at DateTime
```

Add a uniqueness constraint on `(capture_session_id, ordinal)`.

- [ ] **5.3 Add a forward-only Alembic migration.**

`0002_voiceprint_speech_pipeline.py` creates exactly the five tables/indexes above and cleanly downgrades them in reverse dependency order.

- [ ] **5.4 Add repository round-trip tests.**

`test_voiceprint_repositories.py` must prove:

- suspect voiceprint is unique per case and can be replaced only through an explicit repository operation;
- officer profile is keyed by officer ID, can be updated and revoked without deleting history immediately;
- normalized embedding bytes round-trip to the expected dimension;
- session assignments cannot point to inactive/revoked officer profiles at service level;
- ASR fragments preserve `raw_text` when `edited_text` and `speaker` are changed;
- fragment confirmation records the official message ID.

- [ ] **5.5 Run database tests.**

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_migrations.py tests/test_voiceprint_repositories.py tests/test_database.py tests/test_repositories.py -q
```

Expected: PASS.

- [ ] **5.6 Commit.**

```bash
git add linux/backend/app/database/models.py linux/backend/alembic/versions/0002_voiceprint_speech_pipeline.py linux/backend/app/repositories linux/backend/tests/test_migrations.py linux/backend/tests/test_voiceprint_repositories.py
git commit -m "feat: persist voiceprints and ASR fragments"
```

---

## Task 6: Implement enrollment quality control, officer library service, and session readiness

**Files:**
- Create: `linux/backend/app/services/voiceprint_service.py`
- Create: `linux/backend/app/services/audio_capture_service.py`
- Create: `linux/backend/app/api/voiceprints.py`
- Create: `linux/backend/tests/test_voiceprint_service.py`
- Create: `linux/backend/tests/test_voiceprint_api.py`
- Modify: `linux/backend/app/main.py`
- Modify: `linux/backend/app/services/session_service.py`
- Modify: `linux/backend/tests/test_api.py`
- Modify: `linux/backend/tests/test_legacy_compat.py`

### Steps

- [ ] **6.1 Write the hard-gate test first.**

Add a canonical API test proving:

```python
start = client.post(f"/api/v1/cases/{case_id}/session/start", json={"actor_id": "op"})
assert start.status_code == 409
assert start.json()["code"] == "SUSPECT_VOICEPRINT_REQUIRED"
```

This test runs after identity has been confirmed. Existing happy-path tests must explicitly enroll a suspect before starting the session.

Run:

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_api.py -q
```

Expected: FAIL until the gate and enrollment path exist.

- [ ] **6.2 Implement server-side enrollment capture.**

Use the existing `DeviceManager.start_record()`, `read_audio_frames()`, and `stop_record()` rather than browser microphone capture.

`AudioCaptureService` owns one enrollment capture at a time and collects 16 kHz mono PCM for a configured maximum of 30 seconds. It must stop on request or maximum duration and always release the recorder in a `finally` block.

Quality checks before embedding extraction:

- require at least 20 seconds of usable VAD-positive speech, with an upper capture target of 30 seconds;
- reject all-zero/silent input;
- reject clearly clipped recordings using PCM16 peak statistics;
- split voiced material into multiple segments before XVector extraction;
- require at least three usable segments;
- L2-normalize each embedding, reject gross cosine outliers relative to the median/centroid, then L2-normalize the averaged reference;
- store only the aggregate embedding + quality metadata by default, not raw enrollment audio.

Do not set a production speaker-match threshold here; enrollment quality and identity-match threshold are separate concerns.

- [ ] **6.3 Implement voiceprint service methods.**

`VoiceprintService` exposes:

```python
readiness(case_id: str) -> dict
enroll_suspect(case_id: str, pcm: bytes, actor_id: str | None) -> dict
enroll_officer(officer_id: str, officer_name: str, pcm: bytes, actor_id: str | None) -> dict
update_officer(officer_id: str, pcm: bytes, actor_id: str | None) -> dict
revoke_officer(officer_id: str, actor_id: str | None) -> dict
list_officers(active_only: bool = True) -> list[dict]
bind_roles(case_id: str, interrogator_officer_id: str | None, recorder_officer_id: str | None, actor_id: str | None) -> dict
```

`readiness()` returns at least:

```json
{
  "suspectReady": true,
  "interrogatorReady": false,
  "recorderReady": false,
  "recognitionMode": "SUSPECT_ONLY",
  "canStart": true
}
```

Recognition modes are `SUSPECT_ONLY`, `SUSPECT_PLUS_INTERROGATOR`, `SUSPECT_PLUS_RECORDER`, `FULL`.

- [ ] **6.4 Audit every biometric mutation.**

Use existing audit infrastructure with these action names:

```text
SUSPECT_VOICEPRINT_ENROLL
SUSPECT_VOICEPRINT_REENROLL
OFFICER_VOICEPRINT_ENROLL
OFFICER_VOICEPRINT_UPDATE
OFFICER_VOICEPRINT_REVOKE
SESSION_VOICE_ROLE_BIND
```

Audit detail may include officer ID/name, embedding dimension, model ID/version, duration, and quality, but must not serialize the embedding itself.

- [ ] **6.5 Add REST API.**

Create `app/api/voiceprints.py` under `/api/v1`:

```text
GET  /cases/{case_id}/voiceprints/readiness
POST /cases/{case_id}/voiceprints/suspect/enrollment/start
POST /cases/{case_id}/voiceprints/suspect/enrollment/stop
GET  /officer-voiceprints
POST /officer-voiceprints/{officer_id}/enrollment/start
POST /officer-voiceprints/{officer_id}/enrollment/stop
DELETE /officer-voiceprints/{officer_id}
PUT  /cases/{case_id}/voiceprints/assignments
```

The officer enrollment start request carries `officer_name`; the stop request finalizes using the active capture context. Reject concurrent enrollment/capture with typed `RESOURCE_BUSY`/409.

- [ ] **6.6 Add the session start gate.**

In `SessionService.start()`, after identity readiness and before transition to `QUESTIONING`, require an active case suspect voiceprint. Raise:

```python
DomainError(
    "SUSPECT_VOICEPRINT_REQUIRED",
    "请先完成嫌疑人声纹注册再开始审讯",
    409,
)
```

Police voiceprints are never required for start.

Do not add a hidden canonical bypass. Any legacy compatibility route that starts a session must now obey the same suspect voiceprint requirement; update compatibility tests to reflect the approved business rule rather than silently bypassing biometrics.

- [ ] **6.7 Run service/API tests.**

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_voiceprint_service.py tests/test_voiceprint_api.py tests/test_api.py tests/test_legacy_compat.py -q
```

Expected: PASS.

- [ ] **6.8 Commit.**

```bash
git add linux/backend/app/services linux/backend/app/api/voiceprints.py linux/backend/app/main.py linux/backend/tests
git commit -m "feat: add mandatory suspect voiceprint enrollment"
```

---

## Task 7: Implement the speaker decision policy for all three approved modes

**Files:**
- Create: `linux/backend/app/ai/speech/speaker_policy.py`
- Create: `linux/backend/tests/test_speaker_policy.py`

### Steps

- [ ] **7.1 Write exhaustive policy tests first.**

Test these cases independently:

1. Suspect-only, suspect above threshold -> `SUSPECT`, `X_VECTOR`, verified.
2. Suspect-only, suspect below threshold -> `OFFICER_FALLBACK`, `SUSPECT_EXCLUSION`, unverified.
3. Suspect + interrogator, interrogator wins above threshold/margin -> `INTERROGATOR`, verified.
4. Suspect + recorder, recorder wins -> `RECORDER`, verified.
5. One police role registered, no template matches, suspect is conclusively rejected -> `OFFICER_FALLBACK`, unverified, because another unregistered police role may be speaking.
6. Full three-template mode, best score below threshold -> `UNKNOWN`.
7. Full mode, best/second difference below margin -> `UNKNOWN`.
8. Full mode, clear suspect/interrogator/recorder winner -> corresponding verified role.
9. Insufficient voiced duration / overlap marker -> `UNKNOWN` regardless of raw similarity.

- [ ] **7.2 Implement pure decision types and function.**

Use:

```python
class SpeakerRole(str, Enum):
    SUSPECT = "SUSPECT"
    INTERROGATOR = "INTERROGATOR"
    RECORDER = "RECORDER"
    OFFICER_FALLBACK = "OFFICER_FALLBACK"
    UNKNOWN = "UNKNOWN"

class SpeakerSource(str, Enum):
    X_VECTOR = "X_VECTOR"
    SUSPECT_EXCLUSION = "SUSPECT_EXCLUSION"
    MANUAL = "MANUAL"
    UNASSIGNED = "UNASSIGNED"
```

The core function is pure and receives explicit calibrated values:

```python
def decide_speaker(
    candidates: list[SpeakerCandidate],
    *,
    enabled_roles: set[SpeakerRole],
    threshold: float,
    margin: float,
    usable_duration_ms: int,
    overlap: bool,
) -> SpeakerDecision:
    ...
```

It must never read environment variables or the database directly.

- [ ] **7.3 Run policy tests.**

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_speaker_policy.py -q
```

Expected: PASS.

- [ ] **7.4 Commit.**

```bash
git add linux/backend/app/ai/speech/speaker_policy.py linux/backend/tests/test_speaker_policy.py
git commit -m "feat: add auditable speaker attribution policy"
```

---

## Task 8: Build case ASR capture orchestration and replace whole-buffer WebSocket inference

**Files:**
- Create: `linux/backend/app/services/asr_capture_service.py`
- Create: `linux/backend/app/api/asr.py`
- Create: `linux/backend/tests/test_asr_capture_service.py`
- Create: `linux/backend/tests/test_asr_api.py`
- Modify: `linux/backend/app/api/ai_runtime.py`
- Modify: `linux/backend/app/ai/supervisor.py`
- Modify: `linux/backend/app/main.py`
- Modify: `linux/backend/tests/test_supervisor.py`

### Steps

- [ ] **8.1 Write a regression test for the current WebSocket bug.**

The test must prove that when chunks `A`, `B`, `C` arrive, the speech client receives exactly `A`, then `B`, then `C` — never `A`, `AB`, `ABC`.

Run:

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_asr_capture_service.py -q
```

Expected: FAIL against current whole-buffer behavior.

- [ ] **8.2 Make `AISupervisor` own a speech client in real mode.**

Keep LLM/OCR lifecycle behavior intact. Add speech operations that delegate to the local worker:

```python
open_speech_session(...)
push_speech_pcm(...)
finalize_speech_session(...)
close_speech_session(...)
extract_speaker_embedding(...)
```

Mock mode uses deterministic in-process speech behavior so the regular test suite does not require the systemd worker.

Health/capabilities must report VAD, ASR, and speaker separately even though one worker owns them physically.

- [ ] **8.3 Implement `AsrCaptureService`.**

Responsibilities:

1. Start one `asr_capture_sessions` row for a case.
2. Start ALSA recording through `DeviceManager`.
3. Read fixed-size PCM chunks in a background capture loop.
4. Push each chunk exactly once to the speech worker.
5. On VAD-finalized utterance, receive ASR final text + XVector embedding.
6. Load the case/session reference embeddings from repositories.
7. Compute cosine similarities in FastAPI, call `decide_speaker()`, and create one immutable-source `asr_fragments` row.
8. Broadcast a typed WebSocket event through the existing connection manager.
9. On stop/failure, finalize the speech session, stop ALSA in `finally`, and mark the capture row ended.

The speech worker never gets officer names, badge numbers, or database rows; it only produces model outputs.

- [ ] **8.4 Implement business ASR routes expected by the existing frontend adapter.**

Create exactly:

```text
GET  /api/v1/asr/status
POST /api/v1/asr/start
POST /api/v1/asr/stop
GET  /api/v1/cases/{case_id}/asr/capture
POST /api/v1/cases/{case_id}/asr/capture/start
POST /api/v1/cases/{case_id}/asr/capture/stop
GET  /api/v1/cases/{case_id}/asr/fragments
PUT  /api/v1/cases/{case_id}/asr/fragments/{fragment_id}
POST /api/v1/cases/{case_id}/asr/fragments/{fragment_id}/confirm
POST /api/v1/cases/{case_id}/asr/fragments/confirm
POST /api/v1/cases/{case_id}/asr/fragments/apply
POST /api/v1/cases/{case_id}/asr/fragments/{fragment_id}/discard
```

Start capture must reject a case without suspect voiceprint readiness.

- [ ] **8.5 Refactor the low-level `/ai/asr/stream` route.**

Replace `audio = bytearray()` accumulation with:

```text
open session on connect
push only new binary chunk
send returned events
finalize on end/finalize
close on close/disconnect
```

A disconnect must invoke `close_speech_session()` in `finally`.

- [ ] **8.6 Preserve original ASR and audit manual overrides.**

Fragment update may change only `edited_text` and user-selected speaker. It cannot modify `raw_text`, raw model scores, or original `speaker_source`. A manual speaker change records `speaker_source=MANUAL` for the current effective label and adds an audit record containing before/after metadata without embedding bytes.

Confirm/apply creates or updates official `Message` records only from selected confirmed fragments and stores `confirmed_message_id`.

- [ ] **8.7 Run focused and supervisor/API tests.**

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_asr_capture_service.py tests/test_asr_api.py tests/test_supervisor.py tests/test_websocket.py tests/test_websocket_reconnect.py -q
```

Expected: PASS.

- [ ] **8.8 Commit.**

```bash
git add linux/backend/app/services/asr_capture_service.py linux/backend/app/api/asr.py linux/backend/app/api/ai_runtime.py linux/backend/app/ai/supervisor.py linux/backend/app/main.py linux/backend/tests
git commit -m "feat: add streaming ASR capture and speaker attribution"
```

---

## Task 9: Extend frontend types, RuntimeAdapter operations, and Pinia state

**Files:**
- Modify: `webapp/src/types/interrogation.ts`
- Modify: `webapp/src/runtime/types.ts`
- Modify: `webapp/src/runtime/linuxHttpWsAdapter.ts`
- Modify: `webapp/src/runtime/browserDevAdapter.ts`
- Modify: `webapp/src/api/interrogation.ts`
- Modify: `webapp/src/stores/interrogation.ts`
- Modify: `webapp/src/runtime/__tests__/linuxHttpWsAdapter.test.ts`
- Modify: `webapp/src/runtime/__tests__/apiFacade.test.ts`

### Steps

- [ ] **9.1 Add failing adapter tests for voiceprint endpoints.**

Assert exact mappings for:

```text
voiceprint.readiness
voiceprint.suspect.enrollment.start
voiceprint.suspect.enrollment.stop
officerVoiceprint.list
officerVoiceprint.enrollment.start
officerVoiceprint.enrollment.stop
officerVoiceprint.revoke
voiceprint.assignments.update
```

Run:

```bash
cd webapp
npm test -- src/runtime/__tests__/linuxHttpWsAdapter.test.ts src/runtime/__tests__/apiFacade.test.ts
```

Expected: FAIL.

- [ ] **9.2 Extend speaker types without losing provenance.**

Change internal temporary ASR roles to:

```ts
export type TemporaryAsrSpeaker =
  | 'UNKNOWN'
  | 'OFFICER_FALLBACK'
  | 'INTERROGATOR'
  | 'RECORDER'
  | 'SUSPECT'

export type AsrSpeakerSource =
  | 'UNASSIGNED'
  | 'X_VECTOR'
  | 'SUSPECT_EXCLUSION'
  | 'MANUAL'
```

Extend `TemporaryAsrFragment` with `speakerId`, `speakerName`, `speakerScore`, `secondBestScore`, `speakerThreshold`, `speakerMargin`, and `voiceprintVerified`.

Keep the visible official transcript `Speaker` type backward-compatible (`民警 | 嫌疑人 | AI`) because the formal transcript can render both police subroles as police while fragment details retain the exact role.

- [ ] **9.3 Add voiceprint view models.**

Define:

```ts
export type VoiceRecognitionMode =
  | 'SUSPECT_ONLY'
  | 'SUSPECT_PLUS_INTERROGATOR'
  | 'SUSPECT_PLUS_RECORDER'
  | 'FULL'

export interface VoiceprintReadiness {
  suspectReady: boolean
  interrogatorReady: boolean
  recorderReady: boolean
  recognitionMode: VoiceRecognitionMode
  canStart: boolean
}

export interface OfficerVoiceprint {
  officerId: string
  officerName: string
  active: boolean
  modelId: string
  modelVersion?: string | null
  enrollmentQuality: string
  usableDurationMs: number
}
```

- [ ] **9.4 Add adapter/API/store methods.**

The store owns:

```text
voiceprintReadiness
officerVoiceprints
selectedInterrogatorOfficerId
selectedRecorderOfficerId
voiceprintEnrollmentState
```

and actions to load readiness/library, start/stop suspect enrollment, start/stop officer enrollment, bind roles, and revoke/update a police voiceprint.

Browser-dev adapter returns deterministic mock data and must not pretend biometric verification is real; mark simulated results explicitly in its mock payload.

- [ ] **9.5 Run frontend tests and typecheck.**

```bash
cd webapp
npm test -- src/runtime/__tests__/linuxHttpWsAdapter.test.ts src/runtime/__tests__/apiFacade.test.ts
npm run typecheck
```

Expected: PASS.

- [ ] **9.6 Commit.**

```bash
git add webapp/src/types/interrogation.ts webapp/src/runtime webapp/src/api/interrogation.ts webapp/src/stores/interrogation.ts
git commit -m "feat: expose voiceprint state to Linux web runtime"
```

---

## Task 10: Add the `声纹准备` workflow and role-aware ASR UI

**Files:**
- Create: `webapp/src/components/VoiceprintPreparationPanel.vue`
- Create: `webapp/src/components/VoiceprintPreparationPanel.test.ts`
- Modify: `webapp/src/components/InterrogationPage.vue`
- Modify: `webapp/src/components/TranscriptPanel.vue`
- Modify: `webapp/src/components/AsrConsole.vue`
- Modify: `webapp/src/styles.css`

### Steps

- [ ] **10.1 Write component tests first.**

Test at least:

- suspect not ready -> `开始审讯` is disabled and explains why;
- suspect ready, no police templates -> start is enabled and mode shows `仅嫌疑人声纹识别`; 
- one selected officer -> corresponding role shown as loaded;
- two selected officers -> mode shows full three-person recognition;
- officer voiceprint absence never blocks start;
- `OFFICER_FALLBACK` renders visibly as `民警` but detail text states `未启用/未匹配民警声纹，按非嫌疑人规则归类`;
- `UNKNOWN`/low-confidence renders `待确认` rather than guessing a person.

If the existing Vitest environment lacks DOM mounting helpers, keep the component logic in exported pure helpers and unit-test those helpers rather than adding an unapproved testing dependency.

- [ ] **10.2 Implement `VoiceprintPreparationPanel.vue`.**

Display three rows:

```text
嫌疑人 <name>       必须 | 已注册 / 未注册 | 开始录制 / 重新录制
主审民警 <name>     可选 | 从民警库选择 / 新注册 / 更新
记录民警 <name>     可选 | 从民警库选择 / 新注册 / 更新
```

Enrollment UI shows capture progress toward 20–30 seconds of usable speech and a clear completion/error state. Do not show or expose raw embeddings.

- [ ] **10.3 Integrate the hard UI gate.**

`InterrogationPage.vue` loads readiness before start and disables the start action unless `voiceprintReadiness.canStart` is true. Backend remains authoritative; UI gating is only an additional guard.

- [ ] **10.4 Render exact role labels in temporary fragments.**

Mapping:

```text
SUSPECT -> 嫌疑人 · <name>
INTERROGATOR -> 主审民警 · <name>
RECORDER -> 记录民警 · <name>
OFFICER_FALLBACK -> 民警
UNKNOWN -> 待确认
```

A fragment details affordance shows score/source/verified state but not biometric vector data.

- [ ] **10.5 Run frontend test/build gate.**

```bash
cd webapp
npm test
npm run typecheck
npm run build
```

Expected: PASS.

- [ ] **10.6 Commit.**

```bash
git add webapp/src/components webapp/src/styles.css
git commit -m "feat: add voiceprint preparation and speaker labels"
```

---

## Task 11: Add calibration enforcement and fail-safe degradation

**Files:**
- Create: `linux/backend/app/ai/speech/calibration.py`
- Create: `linux/backend/tests/test_speech_calibration.py`
- Modify: `linux/backend/app/health.py`
- Modify: `linux/backend/app/ai/supervisor.py`
- Modify: `linux/backend/app/services/asr_capture_service.py`
- Modify: `deploy/suspect-interrogation.env.example`
- Modify: `docs/security/AUDIT-EVENTS.md`
- Modify: `linux/docs/AI_RUNTIME.md`

### Steps

- [ ] **11.1 Write fail-safe tests first.**

Real-mode tests must verify:

- missing `SUSPECT_SPEAKER_ACCEPT_THRESHOLD` -> speaker verification capability `NOT_CONFIGURED`;
- missing `SUSPECT_SPEAKER_MARGIN` -> `NOT_CONFIGURED`;
- invalid values outside `[0.0, 1.0]` fail configuration validation;
- ASR remains available when XVector fails;
- officer library failure degrades to suspect-only when suspect verification remains valid;
- suspect voiceprint unavailable -> capture/start blocked;
- VAD failure preserves capture state/error and stops recorder cleanly;
- ASR failure creates no fabricated transcript text;
- overlap/insufficient voiced duration -> `UNKNOWN`.

- [ ] **11.2 Implement calibration config.**

Production environment keys:

```text
SUSPECT_SPEAKER_ACCEPT_THRESHOLD=<calibrated decimal 0..1>
SUSPECT_SPEAKER_MARGIN=<calibrated decimal 0..1>
```

Do not put numeric example defaults in the production env example. Document that both values are written only after Task 12 calibration.

- [ ] **11.3 Expose health/capability detail.**

Health reports independently:

```text
asr
vad
speaker
voiceprintCalibration
audioCapture
```

A worker being alive is not sufficient for `speaker=AVAILABLE`; XVector load and calibrated threshold/margin must both be valid.

- [ ] **11.4 Document audit/failure events.**

Add events for worker startup failure, VAD error, ASR error, speaker error, fallback classification, low confidence, manual speaker override, enrollment, update, and revoke.

- [ ] **11.5 Run safety regression tests.**

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest tests/test_speech_calibration.py tests/test_capability_health.py tests/test_health_contract.py tests/test_asr_capture_service.py -q
```

Expected: PASS.

- [ ] **11.6 Commit.**

```bash
git add linux/backend/app/ai/speech/calibration.py linux/backend/app/health.py linux/backend/app/ai/supervisor.py linux/backend/app/services/asr_capture_service.py linux/backend/tests/test_speech_calibration.py deploy/suspect-interrogation.env.example docs/security/AUDIT-EVENTS.md linux/docs/AI_RUNTIME.md
git commit -m "feat: enforce calibrated fail-safe voiceprint recognition"
```

---

## Task 12: Add RK3588 real-device calibration and end-to-end acceptance workflow

**Files:**
- Create: `scripts/ci/rk3588-speech-calibrate.py`
- Create: `scripts/ci/rk3588-speech-smoke.py`
- Create: `tests/release/test_rk3588_speech_scripts.py`
- Modify: `.github/workflows/linux-ai-runtime-rk3588.yml`
- Modify: `.github/workflows/rk3588-service-bootstrap.yml`
- Modify: `docs/release/RK3588-EVIDENCE.md`
- Modify: `docs/release/RELEASE-CHECKLIST.md`

### Steps

- [ ] **12.1 Write script/workflow contract tests first.**

Tests require:

- calibration script accepts three local WAV paths: suspect, interrogator, recorder;
- it never uploads audio or embeddings;
- it outputs score distributions and recommended threshold/margin to a local JSON report;
- it does not directly modify production config unless `--apply` is supplied;
- `--apply` writes only threshold/margin to `/etc/suspect-interrogation/ai-worker.env` via an atomic root-owned update;
- smoke script verifies socket, service, model mount, read-only behavior, health, enrollment, fallback mode, and full mode;
- workflows continue to verify port 8000 remains occupied/preserved rather than taking it over.

- [ ] **12.2 Implement calibration logic.**

`rk3588-speech-calibrate.py`:

1. Requires multiple utterances from each of the three people; a single sample is insufficient.
2. Extracts embeddings through the local speech worker.
3. Computes same-speaker and cross-speaker cosine-score distributions.
4. Searches candidate threshold/margin pairs over observed scores.
5. Reports false-accept/false-reject counts for the supplied calibration set.
6. Chooses the most conservative candidate that separates the provided identities; if no safe separation exists, exit non-zero and require better audio/re-enrollment instead of inventing a threshold.
7. Stores only metrics and chosen numeric settings in the report, not embeddings/audio.

This is device/session-environment calibration, not a scientific claim that one threshold generalizes to every room/microphone.

- [ ] **12.3 Implement real-device smoke.**

`rk3588-speech-smoke.py` verifies:

```text
ai-worker.service active
speech.sock reachable
model path mounted read-only
Paraformer loaded
FSMN-VAD loaded
XVector loaded
speaker calibration configured
16 kHz audio capture reachable
suspect enrollment gate works
suspect-only fallback preserves unverified provenance
one-officer mode works
full three-template mode works with supplied calibration samples
ambiguous sample is not forced to a named identity
worker restart preserves database and officer library
```

- [ ] **12.4 Update workflows.**

`linux-ai-runtime-rk3588.yml` gains `workflow_dispatch` inputs for local server calibration file paths and an explicit `apply_calibration` boolean. Do not store voice WAVs as GitHub artifacts.

`rk3588-service-bootstrap.yml` must:

- start/enable `ai-worker.service` only after stable model/runtime layout exists;
- verify the socket and AI health;
- keep API on 18080;
- preserve TCP/8000 owner exactly as current workflow does;
- abort enabling real voice interrogation if calibration is missing, while still leaving the core API/frontend operational.

- [ ] **12.5 Run all local CI gates before dispatching RK3588.**

```bash
cd linux/backend
PYTHONPATH=. python3 -m pytest -q
cd ../../webapp
npm test
npm run typecheck
npm run build
cd ..
python3 -m pytest tests/release tests/e2e tests/reliability -q
bash tests/release/test_control_shell.sh
```

Expected: all PASS.

- [ ] **12.6 Dispatch the RK3588 AI workflow and capture evidence.**

Run the workflow on `linux-adaptation` with local calibration WAV paths already present on the RK3588 under a protected calibration directory such as `/var/lib/suspect-interrogation/calibration/`. The workflow must not upload those WAV files.

Acceptance evidence to record in `docs/release/RK3588-EVIDENCE.md`:

```text
commit SHA
runner name / aarch64
FunASR version
PyTorch version
model directory manifest
model load success + durations
speech worker PID/socket
model mount read-only verification
calibration score summary + chosen threshold/margin (numbers only)
suspect-only outcome
one-officer outcome
full-mode outcome
ambiguous/overlap outcome
restart outcome
API 18080 health
TCP/8000 preserved owner
```

- [ ] **12.7 Run the production bootstrap workflow and final end-to-end acceptance.**

After calibration is applied, dispatch `RK3588 Service Bootstrap`. Verify:

```bash
systemctl is-active interrogation-api.service
systemctl is-active ai-worker.service
curl -fsS http://127.0.0.1:18080/health/ready
ss -ltnp 'sport = :8000'
ss -ltnp 'sport = :18080'
```

Then perform one real UI flow:

```text
create case
-> identity intake
-> suspect 20–30s enrollment
-> optionally select/enroll interrogator
-> optionally select/enroll recorder
-> start interrogation
-> verify live VAD + Paraformer fragments
-> verify suspect/officer role labels
-> manually correct one fragment
-> confirm/apply to official transcript
-> verify audit history retains original machine decision
-> stop/restart services
-> verify officer library remains reusable
```

- [ ] **12.8 Commit final validation/docs.**

```bash
git add scripts/ci/rk3588-speech-calibrate.py scripts/ci/rk3588-speech-smoke.py tests/release/test_rk3588_speech_scripts.py .github/workflows docs/release
git commit -m "test: add RK3588 voiceprint calibration and acceptance gate"
```

---

## Final Verification Gate

Do not call the integration complete until every item below is evidenced on the target RK3588:

- [ ] `linux/backend` complete pytest suite passes.
- [ ] `webapp` Vitest, typecheck, and production build pass.
- [ ] release/e2e/reliability tests pass.
- [ ] Alembic upgrade from a clean database creates all voiceprint/ASR tables.
- [ ] `/opt/suspect-interrogation/models/funasr` is a read-only mount and survives reboot.
- [ ] no model weights or biometric embeddings appear in Git.
- [ ] `ai-worker.service` runs under `suspect-interrogation` and cannot directly read the rest of `/home`.
- [ ] Paraformer, FSMN-VAD, and XVector all load using local paths with updates/downloads disabled.
- [ ] suspect enrollment is a hard start gate.
- [ ] suspect-only mode marks matching suspect speech and records non-suspect speech as unverified `OFFICER_FALLBACK`.
- [ ] one-police-template modes work for either interrogator or recorder.
- [ ] full mode distinguishes suspect/interrogator/recorder only when threshold + margin pass.
- [ ] short/ambiguous/overlap speech becomes `UNKNOWN`/`待确认`, not a forced identity.
- [ ] raw ASR text and machine speaker provenance survive manual edits.
- [ ] police voiceprint library survives service/release restart and permits different role assignment in a later session.
- [ ] worker failure does not crash the core FastAPI process; degradation behavior matches the design spec.
- [ ] interrogation API remains on TCP/18080.
- [ ] the pre-existing TCP/8000 service is preserved and unchanged.
