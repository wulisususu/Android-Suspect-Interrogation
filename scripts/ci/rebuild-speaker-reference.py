#!/usr/bin/env python3
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
