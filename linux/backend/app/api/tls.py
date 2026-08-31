from __future__ import annotations

import os
from pathlib import Path

from fastapi import APIRouter, HTTPException, Response


router = APIRouter(tags=["tls"])


def _configured_ca_path() -> Path:
    return Path(os.environ.get("SUSPECT_TLS_CA_FILE", "/etc/suspect-interrogation/tls/ca.crt"))


@router.get("/api/v1/tls/ca.crt", include_in_schema=False)
def download_public_ca() -> Response:
    ca_path = _configured_ca_path()
    if not ca_path.is_file():
        raise HTTPException(status_code=503, detail="LAN CA certificate is unavailable")
    try:
        content = ca_path.read_bytes()
    except OSError as exc:
        raise HTTPException(status_code=503, detail="LAN CA certificate is unavailable") from exc
    if b"-----BEGIN CERTIFICATE-----" not in content:
        raise HTTPException(status_code=503, detail="LAN CA certificate is invalid")
    return Response(
        content=content,
        media_type="application/x-x509-ca-cert",
        headers={"Content-Disposition": 'attachment; filename="suspect-interrogation-lan-ca.crt"'},
    )
