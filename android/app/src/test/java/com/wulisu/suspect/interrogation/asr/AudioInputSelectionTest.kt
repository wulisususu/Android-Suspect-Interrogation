package com.wulisu.suspect.interrogation.asr

import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class AudioInputSelectionTest {
    @Test
    fun `built in microphone wins over connected USB input`() {
        val usb = AudioInputCandidate(2, AudioInputKind.USB, "HK DXMIC V1")
        val builtIn = AudioInputCandidate(1, AudioInputKind.BUILT_IN, "rockchip-es8388")

        assertEquals(builtIn, AudioInputSelectionPolicy.select(listOf(usb, builtIn)))
    }

    @Test
    fun `no built in microphone leaves routing to system default`() {
        val usb = AudioInputCandidate(2, AudioInputKind.USB, "HK DXMIC V1")

        assertNull(AudioInputSelectionPolicy.select(listOf(usb)))
    }
}
