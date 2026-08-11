package com.wulisu.suspect.interrogation.ocr

import org.json.JSONArray
import org.json.JSONObject
import java.io.File

data class OcrInitializationMetrics(val initializationMs: Long)

data class OcrInput(
    val imageFile: File,
)

data class OcrImageSize(val width: Int, val height: Int)
data class OcrPoint(val x: Float, val y: Float)
data class OcrRect(val left: Float, val top: Float, val right: Float, val bottom: Float)

data class OcrTextBlock(
    val text: String,
    val confidence: Float?,
    val rect: OcrRect?,
    val points: List<OcrPoint>?,
)

data class OcrResult(
    val text: String,
    val blocks: List<OcrTextBlock>,
    val imageWidth: Int,
    val imageHeight: Int,
    val modelName: String,
    val provider: String,
    val initializationMs: Long?,
    val recognitionMs: Long,
    val previewUri: String?,
) {
    companion object {
        fun empty(
            spec: OcrModelSpec,
            imageWidth: Int,
            imageHeight: Int,
            initializationMs: Long?,
            previewUri: String?,
        ) = OcrResult(
            text = "",
            blocks = emptyList(),
            imageWidth = imageWidth,
            imageHeight = imageHeight,
            modelName = spec.displayName,
            provider = spec.provider,
            initializationMs = initializationMs,
            recognitionMs = 0,
            previewUri = previewUri,
        )
    }
}

interface OcrEngine {
    val modelSpec: OcrModelSpec
    fun initialize(): OcrInitializationMetrics
    fun recognize(input: OcrInput): OcrResult
    fun release()
}

class OcrEngineSwitcher(
    private val factory: (OcrModelSpec) -> OcrEngine,
) {
    var currentEngine: OcrEngine? = null
        private set

    @Synchronized
    fun switchTo(spec: OcrModelSpec): OcrEngine {
        currentEngine?.takeIf { it.modelSpec.id == spec.id }?.let { return it }
        currentEngine?.release()
        return factory(spec).also { currentEngine = it }
    }

    @Synchronized
    fun release() {
        currentEngine?.release()
        currentEngine = null
    }
}

fun OcrResult.toJson() = JSONObject()
    .put("text", text)
    .put("blocks", JSONArray().also { array -> blocks.forEach { array.put(it.toJson()) } })
    .put("imageWidth", imageWidth)
    .put("imageHeight", imageHeight)
    .put("modelName", modelName)
    .put("provider", provider)
    .put("initializationMs", initializationMs ?: JSONObject.NULL)
    .put("recognitionMs", recognitionMs)
    .put("previewUri", previewUri ?: JSONObject.NULL)

private fun OcrTextBlock.toJson() = JSONObject()
    .put("text", text)
    .put("confidence", confidence ?: JSONObject.NULL)
    .put("rect", rect?.toJson() ?: JSONObject.NULL)
    .put("points", points?.let { JSONArray().also { array -> it.forEach { point -> array.put(point.toJson()) } } } ?: JSONObject.NULL)

private fun OcrRect.toJson() = JSONObject()
    .put("left", left)
    .put("top", top)
    .put("right", right)
    .put("bottom", bottom)

private fun OcrPoint.toJson() = JSONObject()
    .put("x", x)
    .put("y", y)
