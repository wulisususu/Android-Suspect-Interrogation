package com.wulisu.suspect.interrogation.asr

import org.junit.Assert.assertEquals
import org.junit.Test

class AudioInputSelectionTest {
    @Test
    fun `USB microphone wins over silent built in input`() {
        val usb = AudioInputCandidate(2, AudioInputKind.USB, "HK DXMIC V1")
        val builtIn = AudioInputCandidate(1, AudioInputKind.BUILT_IN, "rockchip-es8388")

        assertEquals(usb, AudioInputSelectionPolicy.select(listOf(usb, builtIn)))
    }

    @Test
    fun `USB microphone is selected when it is the only usable input`() {
        val usb = AudioInputCandidate(2, AudioInputKind.USB, "HK DXMIC V1")

        assertEquals(usb, AudioInputSelectionPolicy.select(listOf(usb)))
    }
}
