package com.wulisu.suspect.interrogation.asr

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertSame
import org.junit.Assert.assertTrue
import org.junit.Test

class AsrEngineSwitcherTest {
    @Test
    fun `switching model stops and releases the previous engine`() {
        val created = mutableListOf<FakeEngine>()
        val switcher = AsrEngineSwitcher { spec -> FakeEngine(spec).also(created::add) }

        val first = switcher.switchTo(AsrModelSpecs.ZIPFORMER_RK3576) as FakeEngine
        first.start(NoopAsrListener)
        val second = switcher.switchTo(AsrModelSpecs.PARAFORMER_INT8) as FakeEngine

        assertTrue(first.stopped)
        assertTrue(first.released)
        assertEquals(1, first.stopCalls)
        assertEquals(1, first.releaseCalls)
        assertFalse(second.started)
        assertSame(second, switcher.currentEngine)
        assertEquals(2, created.size)
    }

    @Test
    fun `selecting the same model reuses the inactive engine`() {
        val switcher = AsrEngineSwitcher(::FakeEngine)

        val first = switcher.switchTo(AsrModelSpecs.ZIPFORMER_RK3576)
        val second = switcher.switchTo(AsrModelSpecs.ZIPFORMER_RK3576)

        assertSame(first, second)
    }

    private class FakeEngine(override val spec: AsrModelSpec) : AsrEngine {
        var started = false
        var stopped = false
        var released = false
        var stopCalls = 0
        var releaseCalls = 0

        override fun start(listener: AsrListener): AsrStartMetrics {
            started = true
            return AsrStartMetrics(1)
        }

        override fun stop() {
            stopCalls += 1
            stopped = true
        }

        override fun release() {
            releaseCalls += 1
            stop()
            released = true
        }
    }
}
