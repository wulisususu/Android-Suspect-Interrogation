package com.wulisu.suspect.interrogation.ocr

import com.wulisu.suspect.interrogation.domain.BusinessException

class PaddlePirOcrEngine(
    override val modelSpec: OcrModelSpec,
) : OcrEngine {
    override fun initialize(): OcrInitializationMetrics {
        throw BusinessException(
            "OCR_RUNTIME_UNAVAILABLE",
            "PP-OCRv6 当前文件是 Paddle PIR inference.json/pdiparams 格式，APK 尚未集成匹配的 Paddle Android Runtime",
        )
    }

    override fun recognize(input: OcrInput): OcrResult = initialize().let {
        OcrResult.empty(modelSpec, 0, 0, it.initializationMs, null)
    }

    override fun release() = Unit
}
