from __future__ import annotations

import os
import traceback
from dataclasses import asdict
from multiprocessing.connection import Connection
from pathlib import Path
from typing import Any

from .engines.mock import MockASR, MockLLM, MockOCR
from .engines.real import RealASREngine, RealLLMEngine, RealOCREngine
from .errors import AIError
from .registry import ModelSpec
from .types import EngineState


def _make_engine(kind: str, mode: str, spec: ModelSpec, model_root: str):
    if mode == "mock":
        return {"llm": MockLLM, "asr": MockASR, "ocr": MockOCR}[kind](model_id=spec.model_id)
    model_dir = str((Path(model_root) / spec.path).resolve())
    return {"llm": RealLLMEngine, "asr": RealASREngine, "ocr": RealOCREngine}[kind](spec, model_dir)


def worker_main(conn: Connection, *, kind: str, mode: str, spec: ModelSpec, model_root: str) -> None:
    engine = None
    startup_complete = False
    try:
        conn.send({"type": "startup", "state": EngineState.LOADING.value, "pid": os.getpid()})
        engine = _make_engine(kind, mode, spec, model_root)
        engine.load()
        conn.send({"type": "startup", "state": EngineState.READY.value, "pid": os.getpid()})
        startup_complete = True

        while True:
            message = conn.recv()
            op = message.get("op")
            payload = message.get("payload", {})
            if op == "shutdown":
                engine.unload()
                conn.send({"type": "result", "data": None})
                return
            if op == "health":
                conn.send({"type": "result", "data": engine.health().value})
                continue
            try:
                if op == "generate":
                    result = engine.generate(
                        payload["prompt"],
                        session_id=payload["session_id"],
                        options=payload.get("options"),
                    )
                    conn.send({"type": "result", "data": result})
                elif op == "stream_llm":
                    for chunk in engine.stream(
                        payload["prompt"],
                        session_id=payload["session_id"],
                        options=payload.get("options"),
                    ):
                        conn.send({"type": "chunk", "data": chunk})
                    conn.send({"type": "done"})
                elif op == "transcribe":
                    result = engine.transcribe(
                        payload["audio"],
                        session_id=payload["session_id"],
                        options=payload.get("options"),
                    )
                    conn.send({"type": "result", "data": result})
                elif op == "stream_asr":
                    for chunk in engine.stream(
                        payload["audio"],
                        session_id=payload["session_id"],
                        options=payload.get("options"),
                    ):
                        conn.send({"type": "chunk", "data": chunk})
                    conn.send({"type": "done"})
                elif op == "ocr":
                    result = engine.recognize(
                        payload["image"],
                        capability=payload.get("capability", "text"),
                        session_id=payload["session_id"],
                        options=payload.get("options"),
                    )
                    conn.send({"type": "result", "data": result})
                else:
                    conn.send({"type": "error", "code": "UNKNOWN_OPERATION", "message": str(op), "details": {}})
            except AIError as exc:
                conn.send({"type": "error", "code": exc.code, "message": exc.message, "details": exc.details})
            except Exception as exc:
                conn.send({
                    "type": "error",
                    "code": "WORKER_ERROR",
                    "message": str(exc),
                    "details": {"traceback": traceback.format_exc(limit=8)},
                })
    except (EOFError, BrokenPipeError, KeyboardInterrupt):
        return
    except Exception as exc:
        try:
            conn.send({
                "type": "error" if startup_complete else "startup_error",
                "code": exc.code if isinstance(exc, AIError) else "WORKER_STARTUP_ERROR",
                "message": str(exc),
                "details": getattr(exc, "details", {}),
            })
        except Exception:
            pass
    finally:
        try:
            conn.close()
        except Exception:
            pass
