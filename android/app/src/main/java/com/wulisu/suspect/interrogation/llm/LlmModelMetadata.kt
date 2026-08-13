package com.wulisu.suspect.interrogation.llm

import org.json.JSONObject
import java.io.File

data class LlmModelMetadata(
    val name: String,
    val platform: LlmTargetPlatform,
    val runtimeVersion: String,
    val quantization: String,
    val size: Long,
    val sha256: String?,
    val modelFormat: String,
) {
    fun toJson(): JSONObject = JSONObject()
        .put("schemaVersion", SCHEMA_VERSION)
        .put("name", name)
        .put("platform", platform.name)
        .put("runtimeVersion", runtimeVersion)
        .put("quantization", quantization)
        .put("size", size)
        .put("sha256", sha256 ?: JSONObject.NULL)
        .put("modelFormat", modelFormat)

    companion object {
        private const val SCHEMA_VERSION = 1
        private val SHA256_PATTERN = Regex("^[0-9a-fA-F]{64}$")

        fun fromJson(json: JSONObject): LlmModelMetadata {
            val name = json.optString("name").trim()
            require(name.isNotEmpty()) { "metadata.name is required" }
            val platform = runCatching {
                LlmTargetPlatform.valueOf(json.optString("platform").trim().uppercase())
            }.getOrElse { throw IllegalArgumentException("metadata.platform is invalid") }
            val runtimeVersion = json.optString("runtimeVersion").trim()
            require(runtimeVersion.isNotEmpty()) { "metadata.runtimeVersion is required" }
            val quantization = json.optString("quantization").trim()
            require(quantization.isNotEmpty()) { "metadata.quantization is required" }
            val size = json.optLong("size", -1L)
            require(size > 0L) { "metadata.size must be positive" }
            val sha256 = json.optString("sha256").trim().takeIf { it.isNotEmpty() && !it.equals("null", true) }
            require(sha256 == null || SHA256_PATTERN.matches(sha256)) { "metadata.sha256 is invalid" }
            val modelFormat = json.optString("modelFormat").trim()
            require(modelFormat.isNotEmpty()) { "metadata.modelFormat is required" }
            return LlmModelMetadata(name, platform, runtimeVersion, quantization, size, sha256?.lowercase(), modelFormat)
        }
    }
}

sealed interface LlmModelMetadataState {
    data object Missing : LlmModelMetadataState
    data class Valid(val metadata: LlmModelMetadata) : LlmModelMetadataState
    data class Invalid(val reason: String) : LlmModelMetadataState
}

object LlmModelMetadataStore {
    fun sidecarFor(modelFile: File): File = File(modelFile.parentFile, "${modelFile.name}.json")

    fun read(modelFile: File): LlmModelMetadataState {
        val sidecar = sidecarFor(modelFile)
        if (!sidecar.exists()) return LlmModelMetadataState.Missing
        if (!sidecar.isFile || !sidecar.canRead()) return LlmModelMetadataState.Invalid("metadata sidecar is unreadable")
        return runCatching { LlmModelMetadata.fromJson(JSONObject(sidecar.readText(Charsets.UTF_8))) }.fold(
            onSuccess = LlmModelMetadataState::Valid,
            onFailure = { LlmModelMetadataState.Invalid(it.message ?: "metadata sidecar is invalid") },
        )
    }
}
