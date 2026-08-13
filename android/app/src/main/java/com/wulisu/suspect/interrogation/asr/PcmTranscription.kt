package com.wulisu.suspect.interrogation.asr

data class AsrPcmInput(
    val samples: FloatArray,
    val sampleRate: Int,
)

interface PcmTranscribableAsrEngine {
    fun transcribePcm(input: AsrPcmInput): AsrFinalResult
}
