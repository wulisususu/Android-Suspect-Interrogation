package com.wulisu.suspect.interrogation.asr

import com.wulisu.suspect.interrogation.service.ModelDirectories

enum class AsrModelId(val wireValue: String, val catalogId: String) {
    ZIPFORMER_RK3576(
        wireValue = "zipformer_rk3576",
        catalogId = "ASR:asr/zipformer_rk3576",
    ),
    PARAFORMER_INT8(
        wireValue = "paraformer_int8",
        catalogId = "ASR:asr/paraformer_int8",
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
    val modelRoot: String,
    val encoder: String,
    val decoder: String,
    val joiner: String?,
    val tokens: String,
    val provider: String,
    val modelType: String,
    val numThreads: Int,
) {
    val requiredFiles: List<String> = listOfNotNull(encoder, decoder, joiner, tokens)
}

object AsrModelSpecs {
    private const val ASR_ROOT = "${ModelDirectories.ROOT_PATH}/asr"

    val ZIPFORMER_RK3576 = AsrModelSpec(
        id = AsrModelId.ZIPFORMER_RK3576,
        displayName = "Zipformer RKNN (RK3576)",
        modelRoot = "$ASR_ROOT/zipformer_rk3576",
        encoder = "$ASR_ROOT/zipformer_rk3576/encoder.rknn",
        decoder = "$ASR_ROOT/zipformer_rk3576/decoder.rknn",
        joiner = "$ASR_ROOT/zipformer_rk3576/joiner.rknn",
        tokens = "$ASR_ROOT/zipformer_rk3576/tokens.txt",
        provider = "rknn",
        modelType = "zipformer",
        numThreads = 1,
    )

    val PARAFORMER_INT8 = AsrModelSpec(
        id = AsrModelId.PARAFORMER_INT8,
        displayName = "Paraformer INT8",
        modelRoot = "$ASR_ROOT/paraformer_int8",
        encoder = "$ASR_ROOT/paraformer_int8/encoder.int8.onnx",
        decoder = "$ASR_ROOT/paraformer_int8/decoder.int8.onnx",
        joiner = null,
        tokens = "$ASR_ROOT/paraformer_int8/tokens.txt",
        provider = "cpu",
        modelType = "paraformer",
        numThreads = 4,
    )

    val all = listOf(ZIPFORMER_RK3576, PARAFORMER_INT8)
    val default = ZIPFORMER_RK3576

    fun fromId(id: AsrModelId): AsrModelSpec = all.first { it.id == id }
    fun fromCatalogId(catalogId: String?): AsrModelSpec? = all.firstOrNull { it.id.catalogId == catalogId }
}
