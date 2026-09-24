from __future__ import annotations

import os
import re
import shutil
from pathlib import Path


def script_command(script: Path, *args: str) -> list[str]:
    if os.name != "nt":
        return [str(script), *args]
    git = shutil.which("git")
    bash = None if git is None else Path(git).with_name("bash.exe")
    if bash is None or not bash.is_file():
        raise RuntimeError("Git Bash is required to run release shell scripts on Windows")
    return [str(bash), _msys_path(str(script)), *(_msys_path(arg) for arg in args)]


def _msys_path(value: str) -> str:
    match = re.match(r"^([A-Za-z]):[\\/](.*)$", value)
    if not match:
        return value
    path_tail = match.group(2).replace("\\", "/")
    return f"/{match.group(1).lower()}/{path_tail}"


def script_environment(values: dict[str, str]) -> dict[str, str]:
    if os.name != "nt":
        return values
    converted = dict(values)
    converted["PYTHON"] = "python"
    for key, value in values.items():
        match = re.match(r"^([A-Za-z]):[\\/](.*)$", value)
        if key.startswith("SUSPECT_") and match:
            converted[key] = _msys_path(value)
    return converted


def native_script_path(value: str) -> Path:
    if os.name == "nt":
        match = re.match(r"^/([A-Za-z])/(.*)$", value)
        if match:
            return Path(f"{match.group(1).upper()}:/{match.group(2)}")
    return Path(value)
