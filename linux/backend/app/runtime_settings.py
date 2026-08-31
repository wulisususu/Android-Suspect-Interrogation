from __future__ import annotations

from pathlib import Path

from pydantic import field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class RuntimeSettings(BaseSettings):
    """Production-safe Linux runtime defaults.

    LAN exposure, browser microphone test mode, debug mode and CORS are opt-in.
    Mutable/model/web paths are configurable so tests and deployments do not
    need to run as root.
    """

    model_config = SettingsConfigDict(
        env_prefix="SUSPECT_",
        case_sensitive=False,
        # Pydantic 2.x reserves the ``model_`` prefix by default. ``model_path``
        # is an intentional runtime setting, not a BaseModel method, so narrow
        # the protected namespace to one this settings class does not use.
        protected_namespaces=("settings_",),
    )

    api_host: str = "127.0.0.1"
    api_port: int = 8000
    debug: bool = False
    cors_origins: str = ""
    audio_input_mode: str = "ALSA"

    data_dir: Path = Path("/var/lib/suspect-interrogation")
    log_dir: Path = Path("/var/log/suspect-interrogation")
    db_path: Path = Path("/var/lib/suspect-interrogation/interrogation.db")
    model_path: Path | None = None
    web_dist_dir: Path = Path("/opt/suspect-interrogation/current/webapp/dist")
    min_free_mb: int = 256

    @field_validator("audio_input_mode")
    @classmethod
    def validate_audio_input_mode(cls, value: str) -> str:
        normalized = str(value or "ALSA").strip().upper()
        if normalized not in {"ALSA", "BROWSER"}:
            raise ValueError("audio_input_mode must be ALSA or BROWSER")
        return normalized

    @property
    def cors_origins_list(self) -> list[str]:
        origins = [item.strip() for item in self.cors_origins.split(",") if item.strip()]
        if "*" in origins:
            raise ValueError("Wildcard CORS is not allowed; configure explicit origins")
        return origins
