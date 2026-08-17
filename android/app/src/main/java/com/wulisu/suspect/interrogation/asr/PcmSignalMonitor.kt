package com.wulisu.suspect.interrogation.asr

import kotlin.math.abs

enum class AudioSignalState { WAITING, ACTIVE, SILENT }

data class PcmSignalSnapshot(
    val peak: Int,
    val state: AudioSignalState,
)

class PcmSignalMonitor(
    private val sampleRate: Int,
    private val silenceWindowSeconds: Int = 3,
    private val digitalSilencePeak: Int = 64,
) {
    private var consecutiveLowSamples = 0L

    var snapshot = PcmSignalSnapshot(peak = 0, state = AudioSignalState.WAITING)
        private set

    init {
        require(sampleRate > 0) { "sampleRate must be positive" }
        require(silenceWindowSeconds > 0) { "silenceWindowSeconds must be positive" }
        require(digitalSilencePeak >= 0) { "digitalSilencePeak must not be negative" }
    }

    fun accept(samples: ShortArray, count: Int): PcmSignalSnapshot {
        require(count in 0..samples.size) { "count must be within samples" }
        val peak = (0 until count).maxOfOrNull { index -> abs(samples[index].toInt()) } ?: 0
        val state = if (peak > digitalSilencePeak) {
            consecutiveLowSamples = 0L
            AudioSignalState.ACTIVE
        } else {
            consecutiveLowSamples += count
            if (consecutiveLowSamples >= sampleRate.toLong() * silenceWindowSeconds) {
                AudioSignalState.SILENT
            } else if (snapshot.state == AudioSignalState.ACTIVE) {
                AudioSignalState.ACTIVE
            } else {
                AudioSignalState.WAITING
            }
        }
        return PcmSignalSnapshot(peak, state).also { snapshot = it }
    }
}
