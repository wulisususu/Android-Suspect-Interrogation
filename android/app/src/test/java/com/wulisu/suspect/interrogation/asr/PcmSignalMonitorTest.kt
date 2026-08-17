package com.wulisu.suspect.interrogation.asr

import org.junit.Assert.assertEquals
import org.junit.Test

class PcmSignalMonitorTest {
    @Test
    fun `three seconds below threshold becomes silent`() {
        val monitor = PcmSignalMonitor(sampleRate = 10, silenceWindowSeconds = 3, digitalSilencePeak = 64)

        repeat(3) { monitor.accept(ShortArray(10) { 18 }, 10) }

        assertEquals(AudioSignalState.SILENT, monitor.snapshot.state)
        assertEquals(18, monitor.snapshot.peak)
    }

    @Test
    fun `valid signal resets accumulated silence`() {
        val monitor = PcmSignalMonitor(sampleRate = 10, silenceWindowSeconds = 3, digitalSilencePeak = 64)
        repeat(2) { monitor.accept(ShortArray(10) { 18 }, 10) }

        monitor.accept(shortArrayOf(500), 1)

        assertEquals(AudioSignalState.ACTIVE, monitor.snapshot.state)
        assertEquals(500, monitor.snapshot.peak)
    }

    @Test
    fun `minimum short value reports full scale peak`() {
        val monitor = PcmSignalMonitor(sampleRate = 10)

        monitor.accept(shortArrayOf(Short.MIN_VALUE), 1)

        assertEquals(32_768, monitor.snapshot.peak)
    }

    @Test
    fun `short quiet period after valid signal remains active`() {
        val monitor = PcmSignalMonitor(sampleRate = 10, silenceWindowSeconds = 3, digitalSilencePeak = 64)
        monitor.accept(shortArrayOf(500), 1)

        monitor.accept(ShortArray(10) { 18 }, 10)

        assertEquals(AudioSignalState.ACTIVE, monitor.snapshot.state)
    }
}
