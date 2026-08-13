package com.wulisu.suspect.interrogation.asr

enum class SpeakerAttributionSource {
    AUTO,
    MANUAL,
    UNASSIGNED,
}

data class SpeakerAttributionRequest(
    val captureSessionId: String,
    val startOffsetMs: Long,
    val endOffsetMs: Long,
) {
    init {
        require(captureSessionId.isNotBlank()) { "captureSessionId must not be blank" }
        require(startOffsetMs >= 0L) { "startOffsetMs must be >= 0" }
        require(endOffsetMs >= startOffsetMs) { "endOffsetMs must be >= startOffsetMs" }
    }
}

/**
 * A diarization implementation may return a cluster label such as SPEAKER_00. It does not have to
 * pretend that acoustic clustering already knows the legal role "民警/嫌疑人".
 */
data class SpeakerAttributionResult(
    val label: String,
    val confidence: Double?,
    val source: SpeakerAttributionSource,
) {
    init {
        require(label.isNotBlank()) { "speaker label must not be blank" }
        require(confidence == null || confidence in 0.0..1.0) { "confidence must be within [0, 1]" }
        require(source != SpeakerAttributionSource.UNASSIGNED || label == TemporarySpeaker.UNKNOWN.name) {
            "UNASSIGNED attribution must use UNKNOWN label"
        }
    }

    companion object {
        fun unassigned(): SpeakerAttributionResult = SpeakerAttributionResult(
            label = TemporarySpeaker.UNKNOWN.name,
            confidence = null,
            source = SpeakerAttributionSource.UNASSIGNED,
        )
    }
}

interface SpeakerAttributionEngine {
    suspend fun attribute(request: SpeakerAttributionRequest): SpeakerAttributionResult
}

/** Default extension point: no automatic diarization is claimed. */
object UnassignedSpeakerAttributionEngine : SpeakerAttributionEngine {
    override suspend fun attribute(request: SpeakerAttributionRequest): SpeakerAttributionResult =
        SpeakerAttributionResult.unassigned()
}

/** Normalize the existing persisted source vocabulary for UI/business display without a Room migration. */
fun SpeakerSource.toAttributionSource(): SpeakerAttributionSource = when (this) {
    SpeakerSource.DIARIZATION -> SpeakerAttributionSource.AUTO
    SpeakerSource.MANUAL -> SpeakerAttributionSource.MANUAL
    SpeakerSource.UNASSIGNED -> SpeakerAttributionSource.UNASSIGNED
}

val TemporaryAsrFragment.attributionSource: SpeakerAttributionSource
    get() = speakerSource.toAttributionSource()
