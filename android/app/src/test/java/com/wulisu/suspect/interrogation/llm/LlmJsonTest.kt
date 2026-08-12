package com.wulisu.suspect.interrogation.llm

import com.wulisu.suspect.interrogation.service.LocalModelCatalog
import com.wulisu.suspect.interrogation.service.LocalModelDescriptor
import com.wulisu.suspect.interrogation.service.ModelCategory
import com.wulisu.suspect.interrogation.service.ModelSourceKind
import com.wulisu.suspect.interrogation.service.toWireJson
import org.json.JSONObject
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class LlmJsonTest {
    @Test
    fun `result json includes metrics and nullable tokens`() {
        val result = LlmResult(
            outputText = "回答",
            finished = true,
            fragments = listOf("回", "答"),
            tokenIds = null,
            modelName = "LegalOne",
            provider = RKLLM_PROVIDER,
            maxNewTokens = 64,
            maxContextLen = 1024,
            initializationMs = 123,
            firstTokenLatencyMs = 45,
            totalInferenceMs = 678,
            error = null,
        )

        val json = result.toJson()

        assertEquals("回答", json.getString("outputText"))
        assertTrue(json.getBoolean("finished"))
        assertTrue(json.isNull("tokenIds"))
        assertEquals(64, json.getInt("maxNewTokens"))
        assertEquals(1024, json.getInt("maxContextLen"))
    }

    @Test
    fun `catalog json never exposes absolute paths`() {
        val descriptor = LocalModelDescriptor(
            id = "LLM:external/legal.rkllm",
            category = ModelCategory.LLM,
            name = "legal",
            storageName = "legal.rkllm",
            absolutePath = "/sdcard/models/legal.rkllm",
            relativePath = "external/legal.rkllm",
            sizeBytes = 1,
            modifiedAt = 2,
            sourceKind = ModelSourceKind.FILE,
            archive = false,
            selected = true,
            runtimeReady = true,
            modelFormat = "RKLLM",
            provider = RKLLM_PROVIDER,
            targetPlatform = "RK3576",
            compatibility = "READY",
        )
        val raw = LocalModelCatalog("/private/models", listOf(descriptor)).toWireJson().toString()

        assertFalse(raw.contains("/sdcard"))
        assertFalse(raw.contains("/private"))
        assertFalse(raw.contains("absolutePath"))
        assertEquals("Android 设备模型目录", JSONObject(raw).getString("rootPath"))
    }
}
