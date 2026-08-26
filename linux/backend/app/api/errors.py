from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from starlette.exceptions import HTTPException as StarletteHTTPException

from app.domain.errors import DomainError


def error_body(code: str, message: str, data=None) -> dict:
    return {"ok": False, "code": code, "message": message, "data": data}


def install_error_handlers(app: FastAPI) -> None:
    @app.exception_handler(DomainError)
    async def _domain_error(_request: Request, exc: DomainError):
        return JSONResponse(status_code=exc.status_code, content=error_body(exc.code, exc.message, exc.data))

    @app.exception_handler(RequestValidationError)
    async def _validation_error(_request: Request, exc: RequestValidationError):
        details = []
        for item in exc.errors():
            safe = {k: v for k, v in item.items() if k not in {"input", "ctx"}}
            details.append(safe)
        return JSONResponse(status_code=422, content=error_body("VALIDATION_ERROR", "请求参数校验失败", {"errors": details}))

    @app.exception_handler(StarletteHTTPException)
    async def _http_error(_request: Request, exc: StarletteHTTPException):
        if exc.status_code == 404:
            return JSONResponse(status_code=404, content=error_body("NOT_FOUND", "接口不存在"))
        return JSONResponse(status_code=exc.status_code, content=error_body(f"HTTP_{exc.status_code}", str(exc.detail)))
