package com.wulisu.suspect.interrogation.service

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
