import pytest
from fastapi.testclient import TestClient

from app.api.dev_bot import parse_verdict
from app.domain.errors import DomainError
from app.main import create_app


class FakeCaptureService:
    def __init__(self, error=None):
        self.calls = []
        self.error = error

    def inject_officer_text(self, case_id, text):
        self.calls.append((case_id, text))
        if self.error is not None:
            raise self.error
        return {"fragmentId": "f-1", "speaker": "INTERROGATOR", "rawText": text}


@pytest.fixture(name="client")
def client_fixture(monkeypatch):
    monkeypatch.setenv("DEV_LLM_API_KEY", "test-key")
    app = create_app()
    return TestClient(app)


def test_parse_verdict_accepts_plain_fenced_and_garbage_json():
    assert parse_verdict('{"is_answer": true, "reason": "回答了"}') == {"isAnswer": True, "comment": "回答了"}
    assert parse_verdict('```json\n{"is_answer": false, "reason": "寒暄"}\n```') == {"isAnswer": False, "comment": "寒暄"}
    assert parse_verdict("模型胡言乱语") == {"isAnswer": False, "comment": ""}


def test_judge_requires_configured_key(monkeypatch):
    monkeypatch.delenv("DEV_LLM_API_KEY", raising=False)
    app = create_app()
    client = TestClient(app)
    resp = client.post("/api/v1/dev/bot/judge", json={"question": "你叫什么", "reply": "阿福"})
    assert resp.status_code == 503
    assert resp.json()["code"] == "DEV_LLM_UNCONFIGURED"


def test_judge_returns_parsed_verdict(client, monkeypatch):
    async def fake_post_chat(question, reply):
        assert question == "你叫什么名字"
        assert reply == "我叫阿福"
        return '{"is_answer": true, "reason": "回答了姓名"}'

    monkeypatch.setattr("app.api.dev_bot._post_chat", fake_post_chat)
    resp = client.post("/api/v1/dev/bot/judge", json={"question": "你叫什么名字", "reply": "我叫阿福"})
    assert resp.status_code == 200
    body = resp.json()
    assert body["ok"] is True
    assert body["data"] == {"isAnswer": True, "comment": "回答了姓名"}


def test_bot_ask_injects_real_officer_fragment():
    fake = FakeCaptureService()
    app = create_app()
    app.state.asr_capture_service = fake
    client = TestClient(app)
    resp = client.post("/api/v1/dev/bot/ask", json={"case_id": "C-1", "text": "你因何事来公安机关？"})
    assert resp.status_code == 200
    assert resp.json()["data"]["speaker"] == "INTERROGATOR"
    assert fake.calls == [("C-1", "你因何事来公安机关？")]


def test_bot_ask_surfaces_capture_not_active():
    app = create_app()
    app.state.asr_capture_service = FakeCaptureService(
        error=DomainError("ASR_CAPTURE_NOT_ACTIVE", "当前没有进行中的正式录音", 409)
    )
    client = TestClient(app)
    resp = client.post("/api/v1/dev/bot/ask", json={"case_id": "C-1", "text": "你因何事来公安机关？"})
    assert resp.status_code == 409
    assert resp.json()["code"] == "ASR_CAPTURE_NOT_ACTIVE"
