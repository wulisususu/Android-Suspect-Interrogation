from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

cli = ROOT / "scripts/ci/rebuild-speaker-reference.py"
if cli.exists():
    raise SystemExit("Task11 rebuild CLI unexpectedly already exists")
cli.write_text(r'''#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BACKEND = ROOT / "linux" / "backend"
if str(BACKEND) not in sys.path:
    sys.path.insert(0, str(BACKEND))

from app.ai.settings import AISettings
from app.ai.speech.client import SpeechWorkerClient
from app.database.session import make_engine, make_session_factory
from app.domain.errors import DomainError
from app.services.speaker_reference_rebuild import SpeakerReferenceRebuildService


TARGET_BACKEND = "eres2net_large"
NEEDS_REENROLL = "NEEDS_REENROLL"


def parser() -> argparse.ArgumentParser:
    value = argparse.ArgumentParser(
        description="Rebuild an ERes2Net-large voiceprint reference from explicit retained enrollment audio.",
    )
    value.add_argument("--identity-type", required=True, choices=("suspect", "officer"))
    value.add_argument("--identity-id", required=True)
    value.add_argument("--audio", required=True, type=Path)
    value.add_argument("--audio-format", choices=("wav", "pcm16"), default=None)
    value.add_argument("--target-backend", choices=(TARGET_BACKEND,), default=TARGET_BACKEND)
    value.add_argument("--replace", action="store_true")
    value.add_argument("--actor-id", default=None)
    value.add_argument("--db-url", default=None)
    value.add_argument("--speech-socket", type=Path, default=None)
    value.add_argument("--timeout", type=float, default=None)
    return value


def database_url(explicit: str | None) -> str | None:
    if explicit:
        return explicit
    configured = os.getenv("SUSPECT_DB_PATH")
    if configured:
        return f"sqlite:///{Path(configured).expanduser()}"
    return None


def main(argv: list[str] | None = None) -> int:
    args = parser().parse_args(argv)
    settings = AISettings.from_env()
    client = SpeechWorkerClient(
        args.speech_socket or settings.speech_socket,
        timeout=args.timeout if args.timeout is not None else settings.request_timeout,
    )
    engine = make_engine(database_url(args.db_url))
    factory = make_session_factory(engine)

    try:
        with factory() as db:
            result = SpeakerReferenceRebuildService(db, speech_client=client).rebuild(
                identity_type=args.identity_type,
                identity_id=args.identity_id,
                audio_path=args.audio,
                audio_format=args.audio_format,
                target_backend=args.target_backend,
                replace=bool(args.replace),
                actor_id=args.actor_id,
            )
    except DomainError as exc:
        print(json.dumps({
            "ok": False,
            "code": exc.code,
            "message": exc.message,
            "data": exc.data,
        }, ensure_ascii=False, sort_keys=True))
        return 2

    print(json.dumps({"ok": True, "data": result}, ensure_ascii=False, sort_keys=True))
    return 3 if result.get("status") == NEEDS_REENROLL else 0


if __name__ == "__main__":
    raise SystemExit(main())
''', encoding="utf-8")


def insert_before(path: Path, anchor: str, section: str) -> None:
    text = path.read_text(encoding="utf-8")
    if section.splitlines()[0] in text:
        raise SystemExit(f"Task11 docs section already present: {path}")
    if anchor not in text:
        raise SystemExit(f"Task11 docs anchor missing: {path}: {anchor!r}")
    path.write_text(text.replace(anchor, section + "\n\n" + anchor, 1), encoding="utf-8")


audit = ROOT / "docs/security/AUDIT-EVENTS.md"
audit_section = '''### Model-specific reference rebuild\n\n| Action | Meaning | Allowed audit metadata |\n| --- | --- | --- |\n| `SPEAKER_REFERENCE_REBUILD` | Operator explicitly rebuilt a model-specific suspect/officer reference from retained source WAV/PCM | identity type/ID, target voiceprint record ID, target backend/model/version/fingerprint, target dimension, usable duration/segment count, replace flag, source **PCM SHA-256 digest**, and coarse source class (`EXPLICIT_WAV_FILE` or `EXPLICIT_PCM16_FILE`) |\n\n`SPEAKER_REFERENCE_REBUILD` is a maintenance provenance event, not evidence that one embedding space can be converted into another. The rebuild path reruns VAD/chunking and the requested embedding backend from explicit source audio. It must never place the source path, raw WAV/PCM bytes, or any source/target embedding vector in `AuditLog`. A missing retained source file produces `NEEDS_REENROLL`; it does not synthesize an ERes2Net-large reference from the historical XVector vector.\n'''
insert_before(audit, "## Operational speech failures", audit_section)

deploy = ROOT / "docs/release/DEPLOYMENT.md"
deploy_section = '''## Rebuilding an ERes2Net-large reference from retained enrollment audio\n\nHistorical XVector rows are not automatically backfilled into ERes2Net-large. If the original enrollment WAV/PCM has been retained outside the application database, an operator may explicitly rebuild the target reference from that audio:\n\n```bash\ncd /opt/suspect-interrogation/current\nexport SUSPECT_DB_PATH=/var/lib/suspect-interrogation/interrogation.db\npython3 scripts/ci/rebuild-speaker-reference.py \\\n  --identity-type suspect \\\n  --identity-id CASE-ID \\\n  --audio /approved/operator/input/enrollment.wav \\\n  --target-backend eres2net_large\n```\n\nFor raw 16 kHz mono PCM16, add `--audio-format pcm16`. Officer identities use `--identity-type officer` and the officer ID. The first release accepts `eres2net_large` only. If the target reference already exists, the command fails closed; use `--replace` only after explicitly deciding to replace that model-specific reference.\n\nThe input file is read for this operation only and is **not copied into application storage**. The audit event records a SHA-256 digest of normalized source PCM plus a coarse path class, target model metadata and result record ID; it does not record the full source path, raw audio, or embeddings. If the explicit source path is unavailable, the command returns `NEEDS_REENROLL`; the operator must perform a new enrollment capture rather than deriving an ERes2Net-large vector from an XVector vector.\n\nRun this maintenance tool only while the configured local speech worker is available. It does not change `SUSPECT_SPEAKER_BACKEND`, does not switch the production authoritative backend, and does not restart unrelated services.\n'''
insert_before(deploy, "## Kiosk boot", deploy_section)

print("Task11 rebuild CLI/docs apply complete")
