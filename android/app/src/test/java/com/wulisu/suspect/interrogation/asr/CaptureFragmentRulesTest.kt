package com.wulisu.suspect.interrogation.asr

import com.wulisu.suspect.interrogation.domain.BusinessException
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class CaptureFragmentRulesTest {
    @Test(expected = BusinessException::class)
    fun `unknown speaker cannot be confirmed`() {
        CaptureFragmentRules.requireConfirmable("有效文本", TemporarySpeaker.UNKNOWN)
    }

    @Test(expected = BusinessException::class)
    fun `blank edited text cannot be confirmed`() {
        CaptureFragmentRules.requireConfirmable("  ", TemporarySpeaker.OFFICER)
    }

    @Test
    fun `confirmation returns trimmed text and formal speaker`() {
        val result = CaptureFragmentRules.requireConfirmable("  请说明情况  ", TemporarySpeaker.SUSPECT)

        assertEquals("请说明情况", result.text)
        assertEquals("嫌疑人", result.formalSpeaker)
    }

    @Test
    fun `only known confidence below threshold is low`() {
        assertFalse(CaptureFragmentRules.isLowConfidence(null))
        assertTrue(CaptureFragmentRules.isLowConfidence(0.54))
        assertFalse(CaptureFragmentRules.isLowConfidence(0.55))
    }
}
