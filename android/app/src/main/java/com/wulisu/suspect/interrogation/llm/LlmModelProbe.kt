package com.wulisu.suspect.interrogation.llm

object LlmDevicePlatform {
    fun fromProperties(
        socModel: String,
        device: String,
        board: String,
        hardware: String = "",
    ): LlmTargetPlatform {
        listOf(socModel, hardware, device, board).forEach { property ->
            val normalized = property.lowercase()
            when {
                "rk3576" in normalized -> return LlmTargetPlatform.RK3576
                "rk3588" in normalized -> return LlmTargetPlatform.RK3588
            }
        }
        return LlmTargetPlatform.UNKNOWN
    }
}

object LlmModelProbe {
    private const val LEGACY_MIN_LEGALONE_BYTES = 4L * 1024L * 1024L * 1024L
    private const val LEGACY_MAX_LEGALONE_BYTES = 6L * 1024L * 1024L * 1024L
    private val legacyLegalOnePattern = Regex(
        "^LegalOne-4B(?:_[A-Za-z0-9]+)*_RK(?:3576|3588)\\.rkllm$",
        RegexOption.IGNORE_CASE,
    )
    private val quantizationPattern = Regex("W\\d+A\\d+", RegexOption.IGNORE_CASE)

    fun evaluate(
        fileName: String,
        sizeBytes: Long,
        readable: Boolean,
        devicePlatform: LlmTargetPlatform,
        metadataState: LlmModelMetadataState = LlmModelMetadataState.Missing,
    ): LlmProbeResult {
        val provider = rkllmProvider(devicePlatform)
        if (!readable) {
            return result(
                fileName = fileName,
                metadataState = metadataState,
                targetPlatform = targetPlatform(fileName, metadataState),
                devicePlatform = devicePlatform,
                provider = provider,
                complete = false,
                compatibility = LlmCompatibility.UNREADABLE,
            )
        }

        return when (metadataState) {
            LlmModelMetadataState.Missing -> evaluateLegacyFallback(
                fileName = fileName,
                sizeBytes = sizeBytes,
                devicePlatform = devicePlatform,
                provider = provider,
            )

            is LlmModelMetadataState.Invalid -> result(
                fileName = fileName,
                metadataState = metadataState,
                targetPlatform = inferTargetPlatform(fileName),
                devicePlatform = devicePlatform,
                provider = provider,
                complete = false,
                compatibility = LlmCompatibility.METADATA_INVALID,
            )

            is LlmModelMetadataState.Valid -> evaluateMetadata(
                fileName = fileName,
                sizeBytes = sizeBytes,
                devicePlatform = devicePlatform,
                provider = provider,
                metadataState = metadataState,
            )
        }
    }

    fun inferTargetPlatform(fileName: String): LlmTargetPlatform = when {
        fileName.contains("RK3576", ignoreCase = true) -> LlmTargetPlatform.RK3576
        fileName.contains("RK3588", ignoreCase = true) -> LlmTargetPlatform.RK3588
        else -> LlmTargetPlatform.UNKNOWN
    }

    fun inferQuantization(fileName: String): String? =
        quantizationPattern.find(fileName)?.value?.uppercase()

    fun inferTrustedImportPlatform(fileName: String): LlmTargetPlatform =
        if (legacyLegalOnePattern.matches(fileName)) inferTargetPlatform(fileName) else LlmTargetPlatform.UNKNOWN

    private fun evaluateMetadata(
        fileName: String,
        sizeBytes: Long,
        devicePlatform: LlmTargetPlatform,
        provider: String,
        metadataState: LlmModelMetadataState.Valid,
    ): LlmProbeResult {
        val metadata = metadataState.metadata
        val complete = sizeBytes > 0L && sizeBytes == metadata.size
        val compatibility = when {
            !complete -> LlmCompatibility.INCOMPLETE
            !metadata.modelFormat.equals("RKLLM", ignoreCase = true) -> LlmCompatibility.UNSUPPORTED
            metadata.runtimeVersion != RKLLM_RUNTIME_VERSION -> LlmCompatibility.RUNTIME_MISMATCH
            metadata.platform == LlmTargetPlatform.UNKNOWN -> LlmCompatibility.UNSUPPORTED
            devicePlatform == LlmTargetPlatform.UNKNOWN -> LlmCompatibility.UNSUPPORTED
            metadata.platform != devicePlatform -> LlmCompatibility.PLATFORM_MISMATCH
            else -> LlmCompatibility.READY
        }
        return result(
            fileName = fileName,
            metadataState = metadataState,
            targetPlatform = metadata.platform,
            devicePlatform = devicePlatform,
            provider = provider,
            complete = complete,
            compatibility = compatibility,
        )
    }

    private fun evaluateLegacyFallback(
        fileName: String,
        sizeBytes: Long,
        devicePlatform: LlmTargetPlatform,
        provider: String,
    ): LlmProbeResult {
        val targetPlatform = inferTargetPlatform(fileName)
        val recognized = legacyLegalOnePattern.matches(fileName) && targetPlatform != LlmTargetPlatform.UNKNOWN
        val complete = recognized && sizeBytes in LEGACY_MIN_LEGALONE_BYTES..LEGACY_MAX_LEGALONE_BYTES
        val compatibility = when {
            !recognized -> LlmCompatibility.UNSUPPORTED
            !complete -> LlmCompatibility.INCOMPLETE
            devicePlatform == LlmTargetPlatform.UNKNOWN -> LlmCompatibility.UNSUPPORTED
            targetPlatform != devicePlatform -> LlmCompatibility.PLATFORM_MISMATCH
            else -> LlmCompatibility.READY
        }
        return result(
            fileName = fileName,
            metadataState = LlmModelMetadataState.Missing,
            targetPlatform = targetPlatform,
            devicePlatform = devicePlatform,
            provider = provider,
            complete = complete,
            compatibility = compatibility,
        )
    }

    private fun result(
        fileName: String,
        metadataState: LlmModelMetadataState,
        targetPlatform: LlmTargetPlatform,
        devicePlatform: LlmTargetPlatform,
        provider: String,
        complete: Boolean,
        compatibility: LlmCompatibility,
    ): LlmProbeResult {
        val metadata = (metadataState as? LlmModelMetadataState.Valid)?.metadata
        return LlmProbeResult(
            displayName = metadata?.name ?: fileName.removeSuffixIgnoreCase(".rkllm"),
            targetPlatform = targetPlatform,
            devicePlatform = devicePlatform,
            provider = provider,
            modelFormat = metadata?.modelFormat ?: "RKLLM",
            runtimeVersion = metadata?.runtimeVersion ?: RKLLM_RUNTIME_VERSION,
            quantization = metadata?.quantization ?: inferQuantization(fileName),
            sha256 = metadata?.sha256,
            complete = complete,
            runtimeReady = compatibility == LlmCompatibility.READY,
            compatibility = compatibility,
        )
    }

    private fun targetPlatform(
        fileName: String,
        metadataState: LlmModelMetadataState,
    ): LlmTargetPlatform =
        (metadataState as? LlmModelMetadataState.Valid)?.metadata?.platform ?: inferTargetPlatform(fileName)

    private fun String.removeSuffixIgnoreCase(suffix: String): String =
        if (endsWith(suffix, ignoreCase = true)) dropLast(suffix.length) else this
}
