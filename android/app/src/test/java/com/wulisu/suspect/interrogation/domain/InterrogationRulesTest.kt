package com.wulisu.suspect.interrogation.domain

import org.junit.Assert.assertEquals
import org.junit.Assert.fail
import org.junit.Test

class InterrogationRulesTest {
    @Test fun pausedSessionCannotRecord() { try { InterrogationRules.requireCanRecord(SessionStatus.PAUSED); fail("expected BusinessException") } catch (error: BusinessException) { assertEquals("SESSION_PAUSED", error.code) } }
    @Test fun blankMessageIsRejected() { try { InterrogationRules.requireNonBlankMessage("   "); fail("expected BusinessException") } catch (error: BusinessException) { assertEquals("EMPTY_MESSAGE", error.code) } }
    @Test fun speakerWireValueIsStable() { assertEquals(Speaker.OFFICER, Speaker.fromWire("民警")); assertEquals(Speaker.SUSPECT, Speaker.fromWire("嫌疑人")) }
}
