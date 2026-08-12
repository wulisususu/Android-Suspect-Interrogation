package com.wulisu.suspect.interrogation.llm

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class LlmModelProbeTest {
    @Test
    fun `device platform prefers RK3576 soc model`() {
        assertEquals(
            "rk3576",
            LlmDevicePlatform.fromProperties(socModel = "RK3576", device = "rk3576_u", board = "rk30sdk"),
        )
    }

    @Test
    fun `device platform falls back to device name`() {
        assertEquals(
            "rk3588",
            LlmDevicePlatform.fromProperties(socModel = "", device = "rk3588_box", board = "rk30sdk"),
        )
    }

    @Test
    fun `known RK3576 model is complete and runnable on RK3576`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = 4_862_583_588L,
            readable = true,
            devicePlatform = "rk3576",
        )

        assertEquals(LlmTargetPlatform.RK3576, result.targetPlatform)
        assertEquals("RKLLM / RK3576 NPU", result.provider)
        assertEquals("RKLLM", result.modelFormat)
        assertTrue(result.complete)
        assertTrue(result.runtimeReady)
        assertEquals(LlmCompatibility.READY, result.compatibility)
    }

    @Test
    fun `RK3588 model is visible but not runnable on RK3576`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3588.rkllm",
            sizeBytes = 4_849_163_100L,
            readable = true,
            devicePlatform = "rk3576",
        )

        assertEquals(LlmTargetPlatform.RK3588, result.targetPlatform)
        assertEquals(LlmCompatibility.PLATFORM_MISMATCH, result.compatibility)
        assertTrue(result.complete)
        assertFalse(result.runtimeReady)
    }

    @Test
    fun `partial known model is incomplete`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = 12L,
            readable = true,
            devicePlatform = "rk3576",
        )

        assertEquals(LlmCompatibility.INCOMPLETE, result.compatibility)
        assertFalse(result.complete)
        assertFalse(result.runtimeReady)
    }

    @Test
    fun `unknown rkllm model remains visible but unsupported`() {
        val result = LlmModelProbe.evaluate(
            fileName = "custom.rkllm",
            sizeBytes = 12L,
            readable = true,
            devicePlatform = "rk3576",
        )

        assertEquals(LlmTargetPlatform.UNKNOWN, result.targetPlatform)
        assertEquals(LlmCompatibility.UNSUPPORTED, result.compatibility)
        assertFalse(result.runtimeReady)
    }

    @Test
    fun `unreadable known model cannot run`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = 4_862_583_588L,
            readable = false,
            devicePlatform = "rk3576",
        )

        assertEquals(LlmCompatibility.UNREADABLE, result.compatibility)
        assertFalse(result.runtimeReady)
    }
}
