from app.ai.engines.mock import MockASR, MockLLM, MockOCR

def test_mock_llm_is_deterministic_and_stamped():
    engine=MockLLM(model_id="llm.default"); first=engine.generate("请总结",session_id="s1"); second=engine.generate("请总结",session_id="s1"); assert first.text==second.text; assert first.source=="ai"; assert first.model_id=="llm.default"; assert first.session_id=="s1"

def test_mock_llm_stream_reconstructs_generate_text():
    engine=MockLLM(model_id="llm.default"); generated=engine.generate("hello world",session_id="s1").text; chunks=list(engine.stream("hello world",session_id="s1")); assert "".join(c.text for c in chunks)==generated; assert chunks[-1].final is True

def test_mock_asr_and_ocr_are_deterministic():
    asr=MockASR(model_id="asr.default"); ocr=MockOCR(model_id="ocr.default"); assert asr.transcribe(b"hello",session_id="s").text=="hello"; assert ocr.recognize(b"ID:123",capability="id_card",session_id="s").fields["mock_capability"]=="id_card"
