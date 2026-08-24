package com.wulisu.suspect.interrogation.asr

import com.wulisu.suspect.interrogation.domain.BusinessException
import com.wulisu.suspect.interrogation.domain.TranscriptMessage

enum class CaptureSessionState { RECORDING, STOPPED, FAILED }
enum class TemporaryFragmentState { PENDING, CONFIRMED, DISCARDED }
enum class SpeakerSource { UNASSIGNED, MANUAL, DIARIZATION }
enum class ConfidenceSource { SHERPA_TOKEN_LOG_PROBS, UNAVAILABLE }

enum class TemporarySpeaker(val wireValue: String, val formalSpeaker: String?) {
    UNKNOWN("UNKNOWN", null),
    OFFICER("OFFICER", "民警"),
    SUSPECT("SUSPECT", "嫌疑人");

    companion object {
        fun fromWire(value: String?): TemporarySpeaker = entries.firstOrNull {
            it.wireValue == value?.uppercase()
        } ?: throw BusinessException("INVALID_ASR_SPEAKER", "请选择民警或嫌疑人")
    }
}

data class ConfirmableFragment(val text: String, val formalSpeaker: String)

object CaptureFragmentRules {
    const val LOW_CONFIDENCE_THRESHOLD = 0.55

    fun requireConfirmable(editedText: String, speaker: TemporarySpeaker): ConfirmableFragment {
        val text = editedText.trim()
        if (text.isEmpty()) throw BusinessException("ASR_FRAGMENT_TEXT_REQUIRED", "临时片段文本不能为空")
        val formalSpeaker = speaker.formalSpeaker
            ?: throw BusinessException("ASR_FRAGMENT_SPEAKER_REQUIRED", "确认前请选择说话人")
        return ConfirmableFragment(text, formalSpeaker)
    }

    fun isLowConfidence(confidence: Double?): Boolean =
        confidence != null && confidence < LOW_CONFIDENCE_THRESHOLD
}

data class CaptureAudioReference(
    val captureSessionId: String,
    val startOffsetMs: Long,
    val endOffsetMs: Long,
    val available: Boolean,
)

data class TemporaryAsrFragment(
    val id: String,
    val captureSessionId: String,
    val caseId: String,
    val ordinal: Int,
    val startedAtMs: Long,
    val endedAtMs: Long,
    val rawText: String,
    val editedText: String,
    val speaker: TemporarySpeaker,
    val speakerSource: SpeakerSource,
    val confidence: Double?,
    val confidenceSource: ConfidenceSource,
    val state: TemporaryFragmentState,
    val confirmedQaId: String?,
    val audio: CaptureAudioReference,
    val createdAt: Long,
    val updatedAt: Long,
)

data class AsrCaptureStatus(
    val caseId: String,
    val captureSessionId: String?,
    val running: Boolean,
    val startedAt: Long?,
    val endedAt: Long?,
    val modelId: String?,
    val modelName: String?,
    val provider: String?,
    val sampleRate: Int,
    val partialText: String,
    val fragments: List<TemporaryAsrFragment>,
    val error: String?,
)

data class FragmentConfirmation(
    val fragment: TemporaryAsrFragment,
    val record: TranscriptMessage,
)

data class FragmentApplication(
    val fragments: List<TemporaryAsrFragment>,
    val record: TranscriptMessage,
)

data class FragmentConfirmationFailure(
    val fragmentId: String,
    val code: String,
    val message: String,
)

data class BatchFragmentConfirmation(
    val confirmed: List<FragmentConfirmation>,
    val failures: List<FragmentConfirmationFailure>,
)
