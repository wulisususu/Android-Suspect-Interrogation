package com.wulisu.suspect.interrogation.ocr

enum class OcrModelFormat(val wireValue: String) {
    ONNX("onnx"),
    PADDLE_PIR("paddle-pir"),
}

data class OcrModelSpec(
    val id: String,
    val displayName: String,
    val version: String,
    val format: OcrModelFormat,
    val provider: String,
    val requiredFiles: List<String>,
    val runtimeAvailable: Boolean,
    val detInputWidth: Int,
    val detInputHeight: Int,
    val recInputWidth: Int,
    val recInputHeight: Int,
)

object OcrKnownModels {
    val PPOCR_V4_ONNX = OcrModelSpec(
        id = "ppocrv4_onnx",
        displayName = "PP-OCRv4 ONNX",
        version = "v4",
        format = OcrModelFormat.ONNX,
        provider = "onnxruntime-cpu",
        requiredFiles = listOf("ppocrv4_det.onnx", "ppocrv4_rec.onnx"),
        runtimeAvailable = true,
        detInputWidth = 480,
        detInputHeight = 480,
        recInputWidth = 320,
        recInputHeight = 48,
    )

    val PPOCR_V6_SMALL_PADDLE = OcrModelSpec(
        id = "ppocrv6_small_paddle",
        displayName = "PP-OCRv6 Small Paddle PIR",
        version = "v6-small",
        format = OcrModelFormat.PADDLE_PIR,
        provider = "paddle-inference",
        requiredFiles = listOf("PP-OCRv6_small_det_infer.tar", "PP-OCRv6_small_rec_infer.tar"),
        runtimeAvailable = false,
        detInputWidth = 736,
        detInputHeight = 736,
        recInputWidth = 320,
        recInputHeight = 48,
    )

    val all = listOf(PPOCR_V4_ONNX, PPOCR_V6_SMALL_PADDLE)
    fun fromId(id: String?): OcrModelSpec? = all.firstOrNull { it.id == id }
}
