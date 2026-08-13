package com.wulisu.suspect.interrogation.asr

data class SpeakerAttributionRequest(
    val captureSessionId: String,
    val startOffsetMs: Long,
    val endOffsetMs: Long,
)

data class SpeakerAttributionResult(
    val speaker: TemporarySpeaker,
    val confidence: Double?,
    val source: SpeakerSource,
)

fun interface SpeakerAttributionEngine {
    fun attribute(request: SpeakerAttributionRequest): SpeakerAttributionResult
}

object UnassignedSpeakerAttributionEngine : SpeakerAttributionEngine {
    override fun attribute(request: SpeakerAttributionRequest) = SpeakerAttributionResult(
        speaker = TemporarySpeaker.UNKNOWN,
        confidence = null,
        source = SpeakerSource.UNASSIGNED,
    )
}
