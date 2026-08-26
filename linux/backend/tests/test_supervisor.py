import threading,time
from pathlib import Path
import pytest
from app.ai.errors import ModelNotInstalledError, WorkerCancelledError, WorkerTimeoutError
from app.ai.registry import ModelRegistry
from app.ai.supervisor import AISupervisor
from app.ai.types import EngineState

def _registry(tmp_path: Path)->ModelRegistry:
    config=tmp_path/"model-registry.yaml"; config.write_text('{"models":{"asr.default":{"kind":"asr","backend":"sherpa-onnx","path":"asr/default","architecture":"paraformer","required_files":["model.onnx"],"device":"cpu","context":0,"memory_mb":512},"ocr.default":{"kind":"ocr","backend":"paddleocr","path":"ocr/default","architecture":"ocr","required_files":["model.bin"],"device":"cpu","context":0,"memory_mb":512},"llm.default":{"kind":"llm","backend":"rkllm","path":"llm/default","architecture":"qwen","required_files":["model.rkllm"],"device":"npu","context":4096,"memory_mb":4096}}}',encoding="utf-8"); return ModelRegistry.load(config,tmp_path/"models")

def test_mock_worker_start_generate_stream_and_health(tmp_path):
    s=AISupervisor(_registry(tmp_path),mode="mock",request_timeout=2.0)
    try:
        result=s.generate("hello",session_id="s1"); chunks=list(s.stream_llm("hello",session_id="s1")); health=s.health(); assert result.source=="ai"; assert "".join(c.text for c in chunks)==result.text; assert health["workers"]["llm"]["state"] in {EngineState.READY.value,EngineState.BUSY.value}; assert health["workers"]["llm"]["pid"]
    finally:s.shutdown()

def test_worker_crash_isolated_and_auto_restarted(tmp_path):
    s=AISupervisor(_registry(tmp_path),mode="mock",request_timeout=2.0)
    try:
        s.generate("first",session_id="s"); old=s.health()["workers"]["llm"]["pid"]; s.debug_terminate_worker("llm"); assert s.generate("second",session_id="s").text; new=s.health()["workers"]["llm"]["pid"]; assert new!=old; assert s.health()["workers"]["llm"]["restart_count"]>=1
    finally:s.shutdown()

def test_timeout_restarts_worker_and_business_process_survives(tmp_path):
    s=AISupervisor(_registry(tmp_path),mode="mock",request_timeout=0.1)
    try:
        with pytest.raises(WorkerTimeoutError): s.generate("slow",session_id="s",options={"delay_seconds":0.5})
        assert s.generate("after timeout",session_id="s").text; assert s.health()["workers"]["llm"]["restart_count"]>=1
    finally:s.shutdown()

def test_cancel_interrupts_inflight_request_and_worker_recovers(tmp_path):
    s=AISupervisor(_registry(tmp_path),mode="mock",request_timeout=3.0); errors=[]
    def invoke():
        try:s.generate("cancel me",session_id="s",options={"delay_seconds":1.0})
        except Exception as exc: errors.append(exc)
    try:
        t=threading.Thread(target=invoke); t.start(); deadline=time.time()+1
        while time.time()<deadline:
            if s.health()["workers"]["llm"]["state"]==EngineState.BUSY.value:break
            time.sleep(.01)
        s.cancel("llm"); t.join(timeout=2); assert errors and isinstance(errors[0],WorkerCancelledError); assert s.generate("recovered",session_id="s").text
    finally:s.shutdown()

def test_real_mode_missing_model_returns_typed_error_not_process_crash(tmp_path):
    s=AISupervisor(_registry(tmp_path),mode="real",request_timeout=1.0)
    try:
        with pytest.raises(ModelNotInstalledError):s.generate("hello",session_id="s")
        assert s.health()["workers"]["llm"]["state"]==EngineState.NOT_INSTALLED.value
    finally:s.shutdown()

def test_multiple_requests_are_serialized_without_corrupting_ipc(tmp_path):
    s=AISupervisor(_registry(tmp_path),mode="mock",request_timeout=2.0); results=[]
    def invoke(i):results.append(s.generate(f"r{i}",session_id=f"s{i}").session_id)
    try:
        ts=[threading.Thread(target=invoke,args=(i,)) for i in range(4)]
        [t.start() for t in ts]; [t.join(timeout=3) for t in ts]; assert sorted(results)==["s0","s1","s2","s3"]
    finally:s.shutdown()

def test_memory_budget_evicts_idle_worker_before_loading_larger_model(tmp_path):
    s=AISupervisor(_registry(tmp_path),mode="mock",request_timeout=2.0,memory_budget_mb=4200)
    try:
        s.transcribe(b"hello",session_id="s"); assert s.health()["workers"]["asr"]["pid"]; s.generate("load llm",session_id="s"); h=s.health()["workers"]; assert h["llm"]["pid"]; assert h["asr"]["state"]==EngineState.STOPPED.value
    finally:s.shutdown()

def test_idle_sweep_unloads_unused_workers(tmp_path):
    s=AISupervisor(_registry(tmp_path),mode="mock",request_timeout=2.0,idle_unload_seconds=.01)
    try:
        s.generate("hello",session_id="s"); time.sleep(.03); unloaded=s.sweep_idle(); assert "llm" in unloaded; assert s.health()["workers"]["llm"]["state"]==EngineState.STOPPED.value
    finally:s.shutdown()
