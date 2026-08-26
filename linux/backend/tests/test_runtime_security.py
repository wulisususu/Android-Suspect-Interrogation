from app.runtime_settings import RuntimeSettings


def test_runtime_defaults_are_loopback_and_non_debug(monkeypatch):
    for name in (
        "SUSPECT_API_HOST",
        "SUSPECT_API_PORT",
        "SUSPECT_DEBUG",
        "SUSPECT_CORS_ORIGINS",
    ):
        monkeypatch.delenv(name, raising=False)

    settings = RuntimeSettings()
    assert settings.api_host == "127.0.0.1"
    assert settings.api_port == 8000
    assert settings.debug is False
    assert settings.cors_origins_list == []


def test_cors_requires_explicit_origins(monkeypatch):
    monkeypatch.setenv("SUSPECT_CORS_ORIGINS", "http://127.0.0.1:5173,http://localhost:5173")
    settings = RuntimeSettings()
    assert settings.cors_origins_list == [
        "http://127.0.0.1:5173",
        "http://localhost:5173",
    ]
    assert "*" not in settings.cors_origins_list
