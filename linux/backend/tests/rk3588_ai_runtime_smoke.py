from __future__ import annotations
import json,sys,tempfile
from pathlib import Path
BACKEND=Path(__file__).resolve().parents[1]; sys.path.insert(0,str(BACKEND))
from app.ai.errors import ModelNotInstalledError, WorkerTimeoutError
from app.ai.registry import ModelRegistry
from app.ai.supervisor import AISupervisor

def make_registry(root):
    config=root/"registry.yaml"; config.write_text(json.dumps({"models":{"asr.default":{"kind":"asr","backend":"sherpa-onnx","path":"asr/default","architecture":"paraformer","required_files":["model.onnx"],"device":"cpu","context":0,"memory_mb":512},"ocr.default":{"kind":"ocr","backend":"paddleocr","path":"ocr/default","architecture":"ocr","required_files":["model.bin"],"device":"cpu","context":0,"memory_mb":512,"capabilities":["text","id_card"]},"llm.default":{"kind":"llm","backend":"rkllm","path":"llm/default","architecture":"qwen","required_files":["model.rkllm"],"device":"npu","context":4096,"memory_mb":4096}}}),encoding="utf-8"); return ModelRegistry.load(config,root/"models")

def main():
    with tempfile.TemporaryDirectory(prefix="ai-runtime-smoke-") as td:
        root=Path(td); registry=make_registry(root); s=AISupervisor(registry,mode="mock",request_timeout=2.0)
        try:
            first=s.generate("hello",session_id="rk3588"); assert first.text=="[mock-llm] hello"; assert "".join(c.text for c in s.stream_llm("hello",session_id="rk3588"))==first.text; assert s.transcribe(b"pcm-text",session_id="rk3588").text=="pcm-text"; assert s.recognize(b"ID:123",capability="id_card",session_id="rk3588").fields["mock_capability"]=="id_card"; old=s.health()["workers"]["llm"]["pid"]; s.debug_terminate_worker("llm"); s.generate("restart",session_id="rk3588"); assert s.health()["workers"]["llm"]["pid"]!=old
        finally:s.shutdown()
        t=AISupervisor(registry,mode="mock",request_timeout=.1)
        try:
            try:t.generate("slow",session_id="rk3588",options={"delay_seconds":.4}); raise AssertionError("timeout was not raised")
            except WorkerTimeoutError:pass
            assert t.generate("recovered",session_id="rk3588").text
        finally:t.shutdown()
        real=AISupervisor(registry,mode="real",request_timeout=1)
        try:
            try:real.generate("no model",session_id="rk3588"); raise AssertionError("missing model was accepted")
            except ModelNotInstalledError:pass
            assert real.health()["workers"]["llm"]["state"]=="NOT_INSTALLED"
        finally:real.shutdown()
    print("RK3588_AI_RUNTIME_SMOKE_OK")
if __name__=="__main__":main()
