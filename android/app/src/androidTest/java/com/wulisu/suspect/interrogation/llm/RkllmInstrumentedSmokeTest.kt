package com.wulisu.suspect.interrogation.llm

import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith
import kotlinx.coroutines.runBlocking
import java.io.File

@RunWith(AndroidJUnit4::class)
class RkllmInstrumentedSmokeTest {
    @Test
    fun nativeLibrariesLoad() {
        assertEquals("1.3.0", RkllmNative.runtimeVersion)
        assertNull(RkllmNative.loadError)
    }

    @Test
    fun legalOneModelGeneratesText() = runBlocking {
        val model = File("/sdcard/models/LegalOne-4B_W8A8_RK3576.rkllm")
        assumeTrue("LegalOne RKLLM model is missing from /sdcard/models", model.isFile)
        val config = LlmGenerationConfig(maxNewTokens = 8, maxContextLen = 1024)
        val engine = RkllmEngine(
            modelSpec = LlmModelSpec(
                id = "llm-smoke",
                name = "LegalOne-4B",
                absolutePath = model.absolutePath,
                sizeBytes = model.length(),
                targetPlatform = LlmTargetPlatform.RK3576,
            ),
            config = config,
        )
        try {
            engine.initialize()
            val result = engine.generate(
                LlmInput(
                    generationId = "rkllm-smoke",
                    prompt = "只回答四个字：测试成功",
                    config = config,
                ),
            )
            assertNull(result.error)
            assertFalse("RKLLM output was blank", result.outputText.isBlank())
        } finally {
            engine.release()
        }
    }
}
