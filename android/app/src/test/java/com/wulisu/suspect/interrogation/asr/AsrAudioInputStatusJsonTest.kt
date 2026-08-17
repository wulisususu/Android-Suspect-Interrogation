package com.wulisu.suspect.interrogation.asr

import com.wulisu.suspect.interrogation.bridge.toJson
import org.junit.Assert.assertEquals
import org.junit.Test

class AsrAudioInputStatusJsonTest {
    @Test
    fun `runtime status exposes audio input diagnostics`() {
        val status = AsrRuntimeStatus(
            selectedModelId = "asr-test",
            selectedModelName = "ASR test",
            activeModelId = "asr-test",
            provider = "cpu",
            running = true,
            initialized = true,
            initializationMs = 12,
            firstTokenLatencyMs = null,
            utteranceLatencyMs = null,
            partialText = "",
            finalText = "",
            finalResults = emptyList(),
            error = null,
            preferredAudioInput = "rockchip-es8388",
            routedAudioInput = "rockchip-es8388",
            audioPeak = 500,
            audioSignalState = AudioSignalState.ACTIVE,
        )

        val json = status.toJson()

        assertEquals("rockchip-es8388", json.getString("preferredAudioInput"))
        assertEquals("rockchip-es8388", json.getString("routedAudioInput"))
        assertEquals(500, json.getInt("audioPeak"))
        assertEquals("ACTIVE", json.getString("audioSignalState"))
    }
}
