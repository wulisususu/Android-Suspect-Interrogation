import pytest
from fastapi.testclient import TestClient

from app.api.dev_bot import parse_verdict
from app.main import create_app


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
