package com.wulisu.suspect.interrogation.service

/**
 * CLOUD_ZHIPU is retained only so previously stored analysis metadata can still be read.
 * The application no longer contains a cloud provider or any cloud API request path.
 */
enum class AiProviderKind {
    CLOUD_ZHIPU,
    LOCAL,
    UNAVAILABLE,
}

data class AiMessage(
    val role: String,
    val content: String,
)

data class AiGenerationMetadata(
    val runtimeVersion: String = "unknown",
    val generationConfigJson: String = "{}",
    val modelId: String? = null,
    val modelFileHash: String? = null,
)

data class AiResponse(
    val text: String,
    val provider: AiProviderKind,
    val model: String,
    val generationMetadata: AiGenerationMetadata = AiGenerationMetadata(),
)
