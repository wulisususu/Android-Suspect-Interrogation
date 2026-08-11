package com.wulisu.suspect.interrogation.asr

import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test
import kotlin.math.exp

class AsrConfidenceTest {
    @Test
    fun `converts mean finite log probability to probability`() {
        val values = floatArrayOf(-0.2f, -0.4f, Float.NaN, Float.NEGATIVE_INFINITY)

        assertEquals(exp(-0.3), AsrConfidence.fromLogProbabilities(values)!!, 0.0001)
    }

    @Test
    fun `clamps malformed positive log probabilities`() {
        assertEquals(1.0, AsrConfidence.fromLogProbabilities(floatArrayOf(0.4f))!!, 0.0)
    }

    @Test
    fun `returns null without usable values`() {
        assertNull(AsrConfidence.fromLogProbabilities(floatArrayOf()))
        assertNull(AsrConfidence.fromLogProbabilities(floatArrayOf(Float.NaN)))
    }
}
