package com.wulisu.suspect.interrogation.llm

import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class RkllmInstrumentedSmokeTest {
    @Test
    fun nativeLibrariesLoad() {
        assertEquals("1.3.0", RkllmNative.runtimeVersion)
        assertNull(RkllmNative.loadError)
    }
}
