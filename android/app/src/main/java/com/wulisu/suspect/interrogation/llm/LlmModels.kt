package com.wulisu.suspect.interrogation.llm

import org.json.JSONArray
import org.json.JSONObject

const val RKLLM_RUNTIME_VERSION = "1.3.0"
const val RKLLM_PROVIDER = "RKLLM"

fun rkllmProvider(platform: LlmTargetPlatform): String = when (platform) {
    LlmTargetPlatform.RK3576 -> "RKLLM / RK3576 NPU"
    LlmTargetPlatform.RK3588 -> "RKLLM / RK3588 NPU"
    LlmTargetPlatform.UNKNOWN -> "$RKLLM_PROVIDER / UNKNOWN NPU"
}

enum class LlmTargetPlatform {
    RK3576,
    RK3588,
    UNKNOWN,
}

enum class LlmCompatibility {
    READY,
    INCOMPLETE,
    UNREADABLE,
    PLATFORM_MISMATCH,
    RUNTIME_MISMATCH,
    METADATA_INVALID,
    UNSUPPORTED,
}

data class LlmProbeResult(
    val displayName: String,
    val targetPlatform: LlmTargetPlatform,
    val devicePlatform: LlmTargetPlatform,
    val provider: String,
    val modelFormat: String,
    val runtimeVersion: String,
    val quantization: String?,
    val sha256: String?,
    val complete: Boolean,
    val runtimeReady: Boolean,
    val compatibility: LlmCompatibility,
)

data class LlmModelSpec(
    val id: String,
    val name: String,
    val absolutePath: String,
    val sizeBytes: Long,
    val targetPlatform: LlmTargetPlatform,
    val devicePlatform: LlmTargetPlatform = LlmTargetPlatform.UNKNOWN,
    val complete: Boolean = true,
    val compatibility: LlmCompatibility = LlmCompatibility.READY,
    val provider: String = RKLLM_PROVIDER,
    val modelFormat: String = "RKLLM",
    val runtimeVersion: String = RKLLM_RUNTIME_VERSION,
    val quantization: String? = null,
    val sha256: String? = null,
)

data class LlmGenerationConfig(
    val maxNewTokens: Int = 64,
    val maxContextLen: Int = 1024,
)

data class LlmFragment(
    val generationId: String,
    val text: String,
    val accumulatedText: String,
    val tokenId: Int?,
    val elapsedMs: Long,
)

data class LlmInput(
    val generationId: String,
    val prompt: String,
    val config: LlmGenerationConfig,
    val role: String = "user",
    val fragmentListener: ((LlmFragment) -> Unit)? = null,
)

data class LlmInitializationMetrics(
    val initializationMs: Long,
)

data class LlmResult(
    val outputText: String,
    val finished: Boolean,
    val fragments: List<String>,
    val tokenIds: List<Int>?,
    val modelName: String,
    val provider: String,
    val maxNewTokens: Int,
    val maxContextLen: Int,
    val initializationMs: Long,
    val firstTokenLatencyMs: Long?,
    val totalInferenceMs: Long,
    val error: String?,
) {
    companion object {
        fun success(
            input: LlmInput,
            modelSpec: LlmModelSpec,
            initializationMs: Long,
            firstTokenLatencyMs: Long?,
            totalInferenceMs: Long,
            fragments: List<String>,
            tokenIds: List<Int>? = null,
        ) = LlmResult(
            outputText = fragments.joinToString(""),
            finished = true,
            fragments = fragments,
            tokenIds = tokenIds,
            modelName = modelSpec.name,
            provider = modelSpec.provider,
            maxNewTokens = input.config.maxNewTokens,
            maxContextLen = input.config.maxContextLen,
            initializationMs = initializationMs,
            firstTokenLatencyMs = firstTokenLatencyMs,
            totalInferenceMs = totalInferenceMs,
            error = null,
        )

        fun cancelled(
            input: LlmInput,
            modelSpec: LlmModelSpec,
            initializationMs: Long,
            totalInferenceMs: Long,
            fragments: List<String> = emptyList(),
        ) = LlmResult(
            outputText = fragments.joinToString(""),
            finished = false,
            fragments = fragments,
            tokenIds = null,
            modelName = modelSpec.name,
            provider = modelSpec.provider,
            maxNewTokens = input.config.maxNewTokens,
            maxContextLen = input.config.maxContextLen,
            initializationMs = initializationMs,
            firstTokenLatencyMs = null,
            totalInferenceMs = totalInferenceMs,
            error = "LLM_CANCELLED",
        )
    }
}

data class LlmRuntimeStatus(
    val selectedModelId: String?,
    val selectedModelName: String?,
    val activeModelId: String?,
    val provider: String = RKLLM_PROVIDER,
    val storagePermissionGranted: Boolean,
    val initialized: Boolean,
    val busy: Boolean,
    val generationId: String?,
    val config: LlmGenerationConfig,
    val initializationMs: Long?,
    val firstTokenLatencyMs: Long?,
    val totalInferenceMs: Long?,
    val error: String?,
)

fun LlmResult.toJson() = JSONObject()
    .put("outputText", outputText)
    .put("finished", finished)
    .put("fragments", JSONArray(fragments))
    .put("tokenIds", tokenIds?.let(::JSONArray) ?: JSONObject.NULL)
    .put("modelName", modelName)
    .put("provider", provider)
    .put("maxNewTokens", maxNewTokens)
    .put("maxContextLen", maxContextLen)
    .put("initializationMs", initializationMs)
    .put("firstTokenLatencyMs", firstTokenLatencyMs ?: JSONObject.NULL)
    .put("totalInferenceMs", totalInferenceMs)
    .put("error", error ?: JSONObject.NULL)

fun LlmFragment.toJson() = JSONObject()
    .put("generationId", generationId)
    .put("text", text)
    .put("accumulatedText", accumulatedText)
    .put("tokenId", tokenId ?: JSONObject.NULL)
    .put("elapsedMs", elapsedMs)

fun LlmRuntimeStatus.toJson() = JSONObject()
    .put("selectedModelId", selectedModelId ?: JSONObject.NULL)
    .put("selectedModelName", selectedModelName ?: JSONObject.NULL)
    .put("activeModelId", activeModelId ?: JSONObject.NULL)
    .put("provider", provider)
    .put("storagePermissionGranted", storagePermissionGranted)
    .put("initialized", initialized)
    .put("busy", busy)
    .put("generationId", generationId ?: JSONObject.NULL)
    .put(
        "config",
        JSONObject()
            .put("maxNewTokens", config.maxNewTokens)
            .put("maxContextLen", config.maxContextLen),
    )
    .put("initializationMs", initializationMs ?: JSONObject.NULL)
    .put("firstTokenLatencyMs", firstTokenLatencyMs ?: JSONObject.NULL)
    .put("totalInferenceMs", totalInferenceMs ?: JSONObject.NULL)
    .put("error", error ?: JSONObject.NULL)
