import threading
import time
from pathlib import Path

import pytest

from app.ai.errors import BackendUnavailableError, ModelNotInstalledError, WorkerCancelledError, WorkerTimeoutError
from app.ai.registry import ModelRegistry
from app.ai.supervisor import AISupervisor
from app.ai.types import EngineState


def _registry(tmp_path: Path) -> ModelRegistry:
    config = tmp_path / "model-registry.yaml"
    config.write_text('''{
      "models": {
        "asr.default": {"kind":"asr","backend":"sherpa-onnx","path":"asr/default","architecture":"paraformer","required_files":["model.onnx"],"device":"cpu","context":0,"memory_mb":512},
        "ocr.default": {"kind":"ocr","backend":"paddleocr","path":"ocr/default","architecture":"ocr","required_files":["model.bin"],"device":"cpu","context":0,"memory_mb":512},
        "llm.default": {"kind":"llm","backend":"rkllm","path":"llm/default","architecture":"qwen","required_files":["model.rkllm"],"device":"npu","context":4096,"memory_mb":4096}
      }
    }''', encoding="utf-8")
    return ModelRegistry.load(config, tmp_path / "models")


def test_mock_worker_start_generate_stream_and_health(tmp_path: Path):
    supervisor = AISupervisor(_registry(tmp_path), mode="mock", request_timeout=2.0)
    try:
        result = supervisor.generate("hello", session_id="s1")
        chunks = list(supervisor.stream_llm("hello", session_id="s1"))
        health = supervisor.health()
        assert result.source == "ai"
        assert "".join(c.text for c in chunks) == result.text
        assert health["workers"]["llm"]["state"] in {EngineState.READY.value, EngineState.BUSY.value}
        assert health["workers"]["llm"]["pid"]
    finally:
        supervisor.shutdown()


def test_worker_crash_isolated_and_auto_restarted(tmp_path: Path):
    supervisor = AISupervisor(_registry(tmp_path), mode="mock", request_timeout=2.0)
    try:
        supervisor.generate("first", session_id="s")
        old_pid = supervisor.health()["workers"]["llm"]["pid"]
        supervisor.debug_terminate_worker("llm")
        result = supervisor.generate("second", session_id="s")
        new_pid = supervisor.health()["workers"]["llm"]["pid"]
        assert result.text
        assert new_pid != old_pid
        assert supervisor.health()["workers"]["llm"]["restart_count"] >= 1
    finally:
        supervisor.shutdown()


def test_timeout_restarts_worker_and_business_process_survives(tmp_path: Path):
    supervisor = AISupervisor(_registry(tmp_path), mode="mock", request_timeout=0.1)
    try:
        with pytest.raises(WorkerTimeoutError):
            supervisor.generate("slow", session_id="s", options={"delay_seconds": 0.5})
        result = supervisor.generate("after timeout", session_id="s")
        assert result.text
        assert supervisor.health()["workers"]["llm"]["restart_count"] >= 1
    finally:
        supervisor.shutdown()


def test_cancel_interrupts_inflight_request_and_worker_recovers(tmp_path: Path):
    supervisor = AISupervisor(_registry(tmp_path), mode="mock", request_timeout=3.0)
    errors = []

    def invoke():
        try:
            supervisor.generate("cancel me", session_id="s", options={"delay_seconds": 1.0})
        except Exception as exc:
            errors.append(exc)

    try:
        thread = threading.Thread(target=invoke)
        thread.start()
        deadline = time.time() + 1.0
        while time.time() < deadline:
            if supervisor.health()["workers"]["llm"]["state"] == EngineState.BUSY.value:
                break
            time.sleep(0.01)
        supervisor.cancel("llm")
        thread.join(timeout=2.0)
        assert errors and isinstance(errors[0], WorkerCancelledError)
        assert supervisor.generate("recovered", session_id="s").text
    finally:
        supervisor.shutdown()


def test_real_mode_with_weights_but_missing_backend_returns_typed_startup_error(tmp_path: Path):
    registry = _registry(tmp_path)
    model_dir = tmp_path / "models" / "llm" / "default"
    model_dir.mkdir(parents=True)
    (model_dir / "model.rkllm").write_bytes(b"placeholder")
    supervisor = AISupervisor(registry, mode="real", request_timeout=1.0)
    try:
        with pytest.raises(BackendUnavailableError):
            supervisor.generate("hello", session_id="s")
        assert supervisor.health()["workers"]["llm"]["state"] == EngineState.ERROR.value
    finally:
        supervisor.shutdown()


def test_real_mode_missing_model_returns_typed_error_not_process_crash(tmp_path: Path):
    supervisor = AISupervisor(_registry(tmp_path), mode="real", request_timeout=1.0)
    try:
        with pytest.raises(ModelNotInstalledError):
            supervisor.generate("hello", session_id="s")
        health = supervisor.health()
        assert health["workers"]["llm"]["state"] == EngineState.NOT_INSTALLED.value
    finally:
        supervisor.shutdown()


def test_multiple_requests_are_serialized_without_corrupting_ipc(tmp_path: Path):
    supervisor = AISupervisor(_registry(tmp_path), mode="mock", request_timeout=2.0)
    results = []

    def invoke(i: int):
        results.append(supervisor.generate(f"r{i}", session_id=f"s{i}").session_id)

    try:
        threads = [threading.Thread(target=invoke, args=(i,)) for i in range(4)]
        for t in threads:
            t.start()
        for t in threads:
            t.join(timeout=3.0)
        assert sorted(results) == ["s0", "s1", "s2", "s3"]
    finally:
        supervisor.shutdown()


def test_memory_budget_evicts_idle_worker_before_loading_larger_model(tmp_path: Path):
    supervisor = AISupervisor(
        _registry(tmp_path), mode="mock", request_timeout=2.0, memory_budget_mb=4200
    )
    try:
        supervisor.transcribe(b"hello", session_id="s")
        assert supervisor.health()["workers"]["asr"]["pid"]
        supervisor.generate("load llm", session_id="s")
        health = supervisor.health()["workers"]
        assert health["llm"]["pid"]
        assert health["asr"]["state"] == EngineState.STOPPED.value
    finally:
        supervisor.shutdown()


def test_idle_sweep_unloads_unused_workers(tmp_path: Path):
    supervisor = AISupervisor(
        _registry(tmp_path), mode="mock", request_timeout=2.0, idle_unload_seconds=0.01
    )
    try:
        supervisor.generate("hello", session_id="s")
        time.sleep(0.03)
        unloaded = supervisor.sweep_idle()
        assert "llm" in unloaded
        assert supervisor.health()["workers"]["llm"]["state"] == EngineState.STOPPED.value
    finally:
        supervisor.shutdown()
