from __future__ import annotations

import base64
import ctypes
import os
from pathlib import Path
from typing import Dict, Iterable, List, Optional

from hardware.base import DeviceInfo, DeviceState, HardwareError, HealthReport
from hardware.idcard.interface import IdentityReader
from hardware.idcard.models import IdentityResult


_COMMON_LIBRARY_NAMES = (
    "libsdtapi.so",
    "libidcard.so",
    "libidcardsdk.so",
    "libreader.so",
)


class SDKLibraryDiscovery:
    def __init__(self, candidates: Optional[Iterable[str]] = None):
        if candidates is None:
            self.candidates = self._default_candidates()
        else:
            self.candidates = [str(item) for item in candidates]

    @staticmethod
    def _default_candidates() -> List[str]:
        result: List[str] = []
        explicit = os.getenv("IDCARD_SDK_LIB")
        if explicit:
            result.append(explicit)
        roots = ["/usr/lib", "/usr/local/lib", "/opt/idcard/lib", "/opt/vendor/lib"]
        roots.extend(p for p in os.getenv("LD_LIBRARY_PATH", "").split(":") if p)
        for root in roots:
            for name in _COMMON_LIBRARY_NAMES:
                result.append(str(Path(root) / name))
        return result

    def discover(self) -> Optional[Path]:
        seen = set()
        for candidate in self.candidates:
            path = Path(candidate).expanduser()
            if path in seen:
                continue
            seen.add(path)
            if path.is_file():
                return path
        return None

    def report(self) -> Dict[str, object]:
        found = self.discover()
        return {"found": str(found) if found else None, "candidates": list(self.candidates)}


class CtypesVendorAdapter:
    """ctypes boundary for vendor .so libraries.

    The adapter supports the common SDT_* API when those symbols exist. A vendor
    with a different ABI should subclass this class and override ``read_raw``;
    the business layer remains unchanged.
    """

    def __init__(self, discovery: Optional[SDKLibraryDiscovery] = None, port: Optional[int] = None, loader=ctypes.CDLL):
        self.discovery = discovery or SDKLibraryDiscovery()
        self.port = int(port if port is not None else os.getenv("IDCARD_SDK_PORT", "1001"))
        self._loader = loader
        self.library_path: Optional[Path] = None
        self.library = None
        self.opened = False

    def open(self) -> None:
        path = self.discovery.discover()
        if path is None:
            raise HardwareError("SDK_NOT_FOUND", "identity reader SDK library was not found", details=self.discovery.report())
        try:
            self.library = self._loader(str(path))
        except OSError as exc:
            raise HardwareError("SDK_LOAD_FAILED", f"failed to load identity SDK: {exc}", details={"path": str(path)}) from exc
        self.library_path = path
        if hasattr(self.library, "SDT_OpenPort"):
            rc = int(self.library.SDT_OpenPort(self.port))
            if rc != 0x90:
                self.library = None
                raise HardwareError("DEVICE_NOT_CONNECTED", "identity reader SDK loaded but reader could not be opened", details={"port": self.port, "return_code": rc})
        self.opened = True

    def close(self) -> None:
        if self.library is not None and self.opened and hasattr(self.library, "SDT_ClosePort"):
            try:
                self.library.SDT_ClosePort(self.port)
            except Exception:
                pass
        self.opened = False
        self.library = None

    def read_raw(self) -> Dict[str, object]:
        if not self.opened or self.library is None:
            raise HardwareError("DEVICE_NOT_CONNECTED", "identity reader is not open")
        required = ("SDT_StartFindIDCard", "SDT_SelectIDCard", "SDT_ReadBaseMsg")
        missing = [name for name in required if not hasattr(self.library, name)]
        if missing:
            raise HardwareError("SDK_PROTOCOL_UNSUPPORTED", "loaded SDK does not expose the supported SDT identity API", details={"missing_symbols": missing, "path": str(self.library_path)})

        iin = (ctypes.c_ubyte * 4)()
        find_rc = int(self.library.SDT_StartFindIDCard(self.port, iin, 0))
        if find_rc != 0x9F:
            raise HardwareError("DEVICE_NOT_CONNECTED", "no identity card detected", details={"return_code": find_rc})
        select_rc = int(self.library.SDT_SelectIDCard(self.port, iin, 0))
        if select_rc != 0x90:
            raise HardwareError("DEVICE_ERROR", "identity card selection failed", details={"return_code": select_rc})

        text_buffer = (ctypes.c_ubyte * 256)()
        portrait_buffer = (ctypes.c_ubyte * 2048)()
        text_length = ctypes.c_int(len(text_buffer))
        portrait_length = ctypes.c_int(len(portrait_buffer))
        rc = int(self.library.SDT_ReadBaseMsg(
            self.port,
            text_buffer,
            ctypes.byref(text_length),
            portrait_buffer,
            ctypes.byref(portrait_length),
            0,
        ))
        if rc != 0x90:
            raise HardwareError("DEVICE_ERROR", "identity SDK read failed", details={"return_code": rc})
        raw_text = bytes(text_buffer[: max(0, min(text_length.value, len(text_buffer)))])
        raw_portrait = bytes(portrait_buffer[: max(0, min(portrait_length.value, len(portrait_buffer)))])
        parsed = _parse_sdt_text(raw_text)
        parsed["portrait"] = base64.b64encode(raw_portrait).decode("ascii") if raw_portrait else None
        return parsed

    @property
    def device_id(self) -> str:
        path = self.library_path.name if self.library_path else "sdk-unresolved"
        return f"{path}:port-{self.port}"


def _clean(value: str) -> str:
    return value.replace("\x00", "").strip()


def _date(value: str) -> str:
    value = _clean(value)
    if len(value) == 8 and value.isdigit():
        return f"{value[:4]}-{value[4:6]}-{value[6:]}"
    return value


def _parse_sdt_text(raw: bytes) -> Dict[str, str]:
    text = raw.decode("utf-16le", errors="ignore")
    padded = text.ljust(110, "\x00")
    name = _clean(padded[0:15])
    gender_code = _clean(padded[15:16])
    nation_code = _clean(padded[16:18])
    gender = {"1": "男", "2": "女"}.get(gender_code, gender_code or "未知")
    nation = {"01": "汉"}.get(nation_code, nation_code)
    return {
        "name": name,
        "gender": gender,
        "nation": nation,
        "birth": _date(padded[18:26]),
        "address": _clean(padded[26:61]),
        "id_number": _clean(padded[61:79]),
        "issuer": _clean(padded[79:94]),
        "valid_from": _date(padded[94:102]),
        "valid_to": _date(padded[102:110]),
    }


class VendorIdentityReader(IdentityReader):
    def __init__(self, adapter: Optional[CtypesVendorAdapter] = None):
        self.adapter = adapter or CtypesVendorAdapter()
        self._state = DeviceState.CLOSED
        self._last_error: Optional[HardwareError] = None

    def open(self) -> None:
        try:
            self.adapter.open()
        except HardwareError as exc:
            self._last_error = exc
            self._state = DeviceState.UNAVAILABLE if exc.code in {"SDK_NOT_FOUND", "DEVICE_NOT_CONNECTED"} else DeviceState.ERROR
            raise
        self._last_error = None
        self._state = DeviceState.READY

    def close(self) -> None:
        self.adapter.close()
        self._state = DeviceState.CLOSED

    def status(self) -> DeviceState:
        return self._state

    def health(self) -> HealthReport:
        if self._last_error:
            return HealthReport(False, self._state, self._last_error.message, self._last_error.details)
        return HealthReport(self._state == DeviceState.READY, self._state, "identity reader ready" if self._state == DeviceState.READY else "identity reader closed")

    def device_info(self) -> DeviceInfo:
        return DeviceInfo("identity", self.adapter.device_id, "Vendor Identity Reader", source="real", path=str(self.adapter.library_path) if self.adapter.library_path else None, metadata={"port": self.adapter.port})

    def read(self) -> IdentityResult:
        if self._state == DeviceState.CLOSED:
            self.open()
        if self._state != DeviceState.READY:
            raise HardwareError("DEVICE_NOT_CONNECTED", "identity reader is unavailable")
        raw = self.adapter.read_raw()
        required = ("name", "gender", "nation", "birth", "id_number", "address", "issuer", "valid_from", "valid_to")
        missing = [key for key in required if key not in raw]
        if missing:
            raise HardwareError("SDK_INVALID_RESPONSE", "vendor adapter did not return required normalized fields", details={"missing": missing})
        return IdentityResult.create(
            name=str(raw["name"]),
            gender=str(raw["gender"]),
            nation=str(raw["nation"]),
            birth=str(raw["birth"]),
            id_number=str(raw["id_number"]),
            address=str(raw["address"]),
            issuer=str(raw["issuer"]),
            valid_from=str(raw["valid_from"]),
            valid_to=str(raw["valid_to"]),
            portrait=raw.get("portrait") if isinstance(raw.get("portrait"), str) else None,
            source="real",
            device_id=self.adapter.device_id,
        )
