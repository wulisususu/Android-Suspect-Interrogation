package com.wulisu.suspect.interrogation.service

import org.json.JSONArray
import org.json.JSONObject

enum class ModelCategory(val directoryName: String, val displayName: String) {
    ASR("asr", "ASR"),
    OCR("ocr", "OCR"),
    VAD("vad", "VAD"),
    SPEAKER("speaker", "Speaker"),
    LLM("llm", "LLM");

    companion object {
        fun fromWire(value: String?): ModelCategory? = entries.firstOrNull { it.name == value?.uppercase() }
    }
}

enum class ModelSourceKind {
    FILE,
    DIRECTORY,
    ASSET,
}

data class LocalModelDescriptor(
    val id: String,
    val category: ModelCategory,
    val name: String,
    val storageName: String,
    val absolutePath: String,
    val relativePath: String,
    val sizeBytes: Long,
    val modifiedAt: Long,
    val sourceKind: ModelSourceKind,
    val archive: Boolean,
    val selected: Boolean,
    val runtimeReady: Boolean = false,
    val version: String? = null,
    val modelFormat: String? = null,
    val provider: String? = null,
    val complete: Boolean = true,
    val targetPlatform: String? = null,
    val compatibility: String? = null,
)

data class LocalModelCatalog(
    val rootPath: String,
    val models: List<LocalModelDescriptor>,
) {
    fun selected(category: ModelCategory): LocalModelDescriptor? =
        models.firstOrNull { it.category == category && it.selected }
}

enum class ModelImportSource {
    FILE,
    DIRECTORY;

    companion object {
        fun fromWire(value: String?): ModelImportSource? = entries.firstOrNull { it.name == value?.uppercase() }
    }
}

fun LocalModelCatalog.llmOnly() = copy(models = models.filter { it.category == ModelCategory.LLM })

fun LocalModelCatalog.toWireJson() = JSONObject()
    .put("rootPath", "Android 设备模型目录")
    .put("models", JSONArray().also { array -> models.forEach { array.put(it.toWireJson()) } })

private fun LocalModelDescriptor.toWireJson() = JSONObject()
    .put("id", id)
    .put("category", category.name)
    .put("name", name)
    .put("storageName", storageName)
    .put("relativePath", relativePath)
    .put("sizeBytes", sizeBytes)
    .put("modifiedAt", modifiedAt)
    .put("sourceKind", sourceKind.name)
    .put("archive", archive)
    .put("selected", selected)
    .put("runtimeReady", runtimeReady)
    .put("version", version ?: JSONObject.NULL)
    .put("modelFormat", modelFormat ?: JSONObject.NULL)
    .put("provider", provider ?: JSONObject.NULL)
    .put("complete", complete)
    .put("targetPlatform", targetPlatform ?: JSONObject.NULL)
    .put("compatibility", compatibility ?: JSONObject.NULL)
