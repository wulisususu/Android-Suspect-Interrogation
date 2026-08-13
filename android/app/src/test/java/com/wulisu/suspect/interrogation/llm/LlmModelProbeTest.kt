package com.wulisu.suspect.interrogation.llm

import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class LlmModelProbeTest {
    @Test
    fun `device platform detects RK3576 from soc model`() {
        assertEquals(
            LlmTargetPlatform.RK3576,
            LlmDevicePlatform.fromProperties(socModel = "RK3576", device = "rk3576_u", board = "rk30sdk"),
        )
    }

    @Test
    fun `device platform detects RK3588 from device name`() {
        assertEquals(
            LlmTargetPlatform.RK3588,
            LlmDevicePlatform.fromProperties(socModel = "", device = "rk3588_box", board = "rk30sdk"),
        )
    }

    @Test
    fun `valid metadata is primary completeness rule without historical exact size`() {
        val actualSize = 4_700_123_456L
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = actualSize,
            readable = true,
            devicePlatform = LlmTargetPlatform.RK3576,
            metadataState = LlmModelMetadataState.Valid(metadata(size = actualSize)),
        )

        assertEquals(LlmTargetPlatform.RK3576, result.targetPlatform)
        assertEquals(LlmTargetPlatform.RK3576, result.devicePlatform)
        assertEquals("RKLLM / RK3576 NPU", result.provider)
        assertEquals("W8A8", result.quantization)
        assertTrue(result.complete)
        assertTrue(result.runtimeReady)
        assertEquals(LlmCompatibility.READY, result.compatibility)
    }

    @Test
    fun `metadata size mismatch is incomplete`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = 4_600_000_000L,
            readable = true,
            devicePlatform = LlmTargetPlatform.RK3576,
            metadataState = LlmModelMetadataState.Valid(metadata(size = 4_700_000_000L)),
        )

        assertEquals(LlmCompatibility.INCOMPLETE, result.compatibility)
        assertFalse(result.complete)
        assertFalse(result.runtimeReady)
    }

    @Test
    fun `valid metadata can describe a non LegalOne rkllm`() {
        val actualSize = 2_000_000_000L
        val custom = metadata(
            name = "Custom",
            platform = LlmTargetPlatform.RK3588,
            size = actualSize,
        )
        val result = LlmModelProbe.evaluate(
            fileName = "custom-model.rkllm",
            sizeBytes = actualSize,
            readable = true,
            devicePlatform = LlmTargetPlatform.RK3588,
            metadataState = LlmModelMetadataState.Valid(custom),
        )

        assertEquals("Custom", result.displayName)
        assertEquals("RKLLM / RK3588 NPU", result.provider)
        assertEquals(LlmCompatibility.READY, result.compatibility)
        assertTrue(result.runtimeReady)
    }

    @Test
    fun `legacy LegalOne without metadata uses conservative fallback`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = 4_500_000_000L,
            readable = true,
            devicePlatform = LlmTargetPlatform.RK3576,
        )

        assertTrue(result.complete)
        assertTrue(result.runtimeReady)
        assertEquals(LlmCompatibility.READY, result.compatibility)
    }

    @Test
    fun `small legacy LegalOne is incomplete rather than accepted by name`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = 12L,
            readable = true,
            devicePlatform = LlmTargetPlatform.RK3576,
        )

        assertEquals(LlmCompatibility.INCOMPLETE, result.compatibility)
        assertFalse(result.complete)
    }

    @Test
    fun `arbitrary rkllm without metadata remains unsupported`() {
        val result = LlmModelProbe.evaluate(
            fileName = "custom_RK3576.rkllm",
            sizeBytes = 5_000_000_000L,
            readable = true,
            devicePlatform = LlmTargetPlatform.RK3576,
        )

        assertEquals(LlmCompatibility.UNSUPPORTED, result.compatibility)
        assertFalse(result.runtimeReady)
    }

    @Test
    fun `RK3588 metadata reports mismatch on RK3576 dynamically`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3588.rkllm",
            sizeBytes = 4_700_000_000L,
            readable = true,
            devicePlatform = LlmTargetPlatform.RK3576,
            metadataState = LlmModelMetadataState.Valid(
                metadata(platform = LlmTargetPlatform.RK3588, size = 4_700_000_000L),
            ),
        )

        assertEquals(LlmTargetPlatform.RK3588, result.targetPlatform)
        assertEquals("RKLLM / RK3576 NPU", result.provider)
        assertEquals(LlmCompatibility.PLATFORM_MISMATCH, result.compatibility)
        assertFalse(result.runtimeReady)
    }

    @Test
    fun `runtime mismatch is explicit`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = 4_700_000_000L,
            readable = true,
            devicePlatform = LlmTargetPlatform.RK3576,
            metadataState = LlmModelMetadataState.Valid(
                metadata(size = 4_700_000_000L, runtimeVersion = "1.2.0"),
            ),
        )

        assertEquals(LlmCompatibility.RUNTIME_MISMATCH, result.compatibility)
        assertTrue(result.complete)
        assertFalse(result.runtimeReady)
    }

    @Test
    fun `metadata parser validates required manifest fields`() {
        val parsed = LlmModelMetadata.fromJson(
            JSONObject(
                """{
                    "name":"LegalOne-4B",
                    "platform":"RK3588",
                    "runtimeVersion":"1.3.0",
                    "quantization":"W8A8",
                    "size":4700000000,
                    "sha256":"${"a".repeat(64)}",
                    "modelFormat":"RKLLM"
                }""".trimIndent(),
            ),
        )

        assertEquals(LlmTargetPlatform.RK3588, parsed.platform)
        assertEquals(4_700_000_000L, parsed.size)
        assertEquals("a".repeat(64), parsed.sha256)
    }

    @Test
    fun `unreadable model cannot run`() {
        val result = LlmModelProbe.evaluate(
            fileName = "LegalOne-4B_W8A8_RK3576.rkllm",
            sizeBytes = 4_700_000_000L,
            readable = false,
            devicePlatform = LlmTargetPlatform.RK3576,
        )

        assertEquals(LlmCompatibility.UNREADABLE, result.compatibility)
        assertFalse(result.runtimeReady)
    }

    private fun metadata(
        name: String = "LegalOne-4B",
        platform: LlmTargetPlatform = LlmTargetPlatform.RK3576,
        size: Long,
        runtimeVersion: String = RKLLM_RUNTIME_VERSION,
    ) = LlmModelMetadata(
        name = name,
        platform = platform,
        runtimeVersion = runtimeVersion,
        quantization = "W8A8",
        size = size,
        sha256 = "a".repeat(64),
        modelFormat = "RKLLM",
    )
}
