package com.wulisu.suspect.interrogation.llm

object LlmDevicePlatform {
    fun fromProperties(socModel: String, device: String, board: String): String {
        val combined = listOf(socModel, device, board).joinToString(" ").lowercase()
        return when {
            "rk3576" in combined -> "rk3576"
            "rk3588" in combined -> "rk3588"
            else -> "unknown"
        }
    }
}

object LlmModelProbe {
    private data class KnownModel(
        val fileName: String,
        val sizeBytes: Long,
        val platform: LlmTargetPlatform,
    )

    private val knownModels = listOf(
        KnownModel("LegalOne-4B_W8A8_RK3576.rkllm", 4_862_583_588L, LlmTargetPlatform.RK3576),
        KnownModel("LegalOne-4B_W8A8_RK3588.rkllm", 4_849_163_100L, LlmTargetPlatform.RK3588),
    )

    fun evaluate(
        fileName: String,
        sizeBytes: Long,
        readable: Boolean,
        devicePlatform: String,
    ): LlmProbeResult {
        val known = knownModels.firstOrNull { it.fileName.equals(fileName, ignoreCase = true) }
        val targetPlatform = known?.platform ?: platformFromFileName(fileName)
        val complete = known != null && sizeBytes == known.sizeBytes
        val compatibility = when {
            !readable -> LlmCompatibility.UNREADABLE
            known == null || targetPlatform == LlmTargetPlatform.UNKNOWN -> LlmCompatibility.UNSUPPORTED
            !complete -> LlmCompatibility.INCOMPLETE
            !targetPlatform.name.equals(devicePlatform, ignoreCase = true) -> LlmCompatibility.PLATFORM_MISMATCH
            else -> LlmCompatibility.READY
        }
        return LlmProbeResult(
            displayName = fileName.removeSuffixIgnoreCase(".rkllm"),
            targetPlatform = targetPlatform,
            provider = RKLLM_PROVIDER,
            modelFormat = "RKLLM",
            complete = complete,
            runtimeReady = compatibility == LlmCompatibility.READY,
            compatibility = compatibility,
        )
    }

    private fun platformFromFileName(fileName: String): LlmTargetPlatform = when {
        fileName.contains("RK3576", ignoreCase = true) -> LlmTargetPlatform.RK3576
        fileName.contains("RK3588", ignoreCase = true) -> LlmTargetPlatform.RK3588
        else -> LlmTargetPlatform.UNKNOWN
    }

    private fun String.removeSuffixIgnoreCase(suffix: String): String =
        if (endsWith(suffix, ignoreCase = true)) dropLast(suffix.length) else this
}
