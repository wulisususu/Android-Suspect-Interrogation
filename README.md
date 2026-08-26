# Linux Suspect Interrogation

嫌疑人审核 / 审讯 AI 一体机的 Linux 原生实现，目标平台为 RK3588 等 Linux 设备，正式运行链路完全离线。

## 正式产品架构

```text
Vue 3 Linux Kiosk
        ↓
LinuxHttpWsAdapter
        ↓
FastAPI /api/v1 + WebSocket
        ↓
SQLite + SQLAlchemy + Alembic
        ↓
├── Linux Hardware HAL
│   ├── 身份证读卡器
│   ├── ALSA 音频
│   ├── V4L2/UVC 摄像头
│   └── 电子签名
├── Offline AI Supervisor
│   ├── ASR
│   ├── OCR
│   └── LLM
└── Audit / Snapshot / Backup / Health
```

## 目录职责

- `linux/backend/`：唯一正式 Linux 后端，包含 API、数据库、设备 HAL、AI Runtime 和测试。
- `webapp/`：Vue 3 + TypeScript Linux Kiosk 前端。
- `deploy/`：部署、升级、回滚和维护页。
- `systemd/`：API、AI worker、Kiosk 服务单元。
- `scripts/`：备份恢复、健康检查、RK3588 smoke 等运维脚本。
- `tests/`：Release、E2E 和可靠性测试。
- `backend-dev/`：历史浏览器行为参考/开发工具，不属于正式生产后端。
- `backend-fastapi/`：早期迁移参考，不属于正式生产后端。

## 离线 AI

正式运行不依赖云端 AI API。模型权重不提交到仓库，由部署人员放入 `linux/backend/models/` 对应目录，并通过 `linux/backend/config/model-registry.yaml` 注册。

模型缺失时 Runtime 返回 `MODEL_NOT_INSTALLED` 能力状态，而不是导致整个服务不可用。

## 本地开发

后端：

```bash
cd linux/backend
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
alembic -c alembic.ini upgrade head
uvicorn app.main:app --host 127.0.0.1 --port 18080
```

前端：

```bash
cd webapp
npm ci
npm run dev
```

## 验证

```bash
PYTHONPATH=linux/backend python3 -m pytest linux/backend/tests -q
cd webapp && npm test && npm run typecheck && npm run build
```

GitHub Actions 的 `.github/workflows/linux-ci.yml` 会在 Hosted Linux 和 RK3588 self-hosted Runner 上执行正式门禁。
