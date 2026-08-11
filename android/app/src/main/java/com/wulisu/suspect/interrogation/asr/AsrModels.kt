package com.wulisu.suspect.interrogation.asr

enum class AsrModelId(val wireValue: String, val catalogId: String) {
    ZIPFORMER_RK3576(
        wireValue = "zipformer_rk3576",
        catalogId = "ASR:asset/models/zipformer_rk3576",
    ),
    PARAFORMER_INT8(
        wireValue = "paraformer_int8",
        catalogId = "ASR:asset/models/paraformer_int8",
    );

    companion object {
        fun fromWire(value: String?): AsrModelId? = entries.firstOrNull {
            it.wireValue == value?.lowercase() || it.name == value?.uppercase() || it.catalogId == value
        }
    }
}

data class AsrModelSpec(
    val id: AsrModelId,
    val displayName: String,
    val assetRoot: String,
    val encoder: String,
    val decoder: String,
    val joiner: String?,
    val tokens: String,
    val provider: String,
    val modelType: String,
    val numThreads: Int,
) {
    val requiredAssets: List<String> = listOfNotNull(encoder, decoder, joiner, tokens)
}

object AsrModelSpecs {
    val ZIPFORMER_RK3576 = AsrModelSpec(
        id = AsrModelId.ZIPFORMER_RK3576,
        displayName = "Zipformer RKNN (RK3576)",
        assetRoot = "models/zipformer_rk3576",
        encoder = "models/zipformer_rk3576/encoder.rknn",
        decoder = "models/zipformer_rk3576/decoder.rknn",
        joiner = "models/zipformer_rk3576/joiner.rknn",
        tokens = "models/zipformer_rk3576/tokens.txt",
        provider = "rknn",
        modelType = "zipformer",
        numThreads = 1,
    )

    val PARAFORMER_INT8 = AsrModelSpec(
        id = AsrModelId.PARAFORMER_INT8,
        displayName = "Paraformer INT8",
        assetRoot = "models/paraformer_int8",
        encoder = "models/paraformer_int8/encoder.int8.onnx",
        decoder = "models/paraformer_int8/decoder.int8.onnx",
        joiner = null,
        tokens = "models/paraformer_int8/tokens.txt",
        provider = "cpu",
        modelType = "paraformer",
        numThreads = 4,
    )

    val all = listOf(ZIPFORMER_RK3576, PARAFORMER_INT8)
    val default = ZIPFORMER_RK3576

    fun fromId(id: AsrModelId): AsrModelSpec = all.first { it.id == id }
    fun fromCatalogId(catalogId: String?): AsrModelSpec? = all.firstOrNull { it.id.catalogId == catalogId }
}

