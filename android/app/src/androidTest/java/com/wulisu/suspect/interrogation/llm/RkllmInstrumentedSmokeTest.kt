package com.wulisu.suspect.interrogation.llm

import android.os.Build
import android.os.SystemClock
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.wulisu.suspect.interrogation.service.ModelCatalogScanner
import com.wulisu.suspect.interrogation.service.ModelCategory
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith
import java.io.File
import java.util.Collections
import java.util.concurrent.atomic.AtomicLong

@RunWith(AndroidJUnit4::class)
class RkllmInstrumentedSmokeTest {
    @Test
    fun nativeLibrariesLoad() {
        assertEquals(RKLLM_RUNTIME_VERSION, RkllmNative.runtimeVersion)
        assertNull(RkllmNative.loadError)
    }

    @Test
    fun readyModelPerformsRealInferenceLifecycle() {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        val devicePlatform = LlmDevicePlatform.fromProperties(
            socModel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) Build.SOC_MODEL.orEmpty() else "",
            device = Build.DEVICE.orEmpty(),
            board = Build.BOARD.orEmpty(),
            hardware = Build.HARDWARE.orEmpty(),
        )
        assumeTrue("RKLLM smoke requires RK3576 or RK3588", devicePlatform != LlmTargetPlatform.UNKNOWN)

        val llmRoot = File("/sdcard/models")
        assumeTrue("RKLLM smoke skipped: /sdcard/models is not readable", llmRoot.isDirectory && llmRoot.canRead())

        val catalog = ModelCatalogScanner().scan(
            root = File(context.cacheDir, "rkllm-smoke-catalog"),
            externalRoots = listOf(llmRoot),
            devicePlatform = devicePlatform,
        )
        val readyModel = catalog.models.firstOrNull {
            it.category == ModelCategory.LLM &&
                it.runtimeReady &&
                it.modelFormat.equals("RKLLM", ignoreCase = true) &&
                it.storageName.contains("LegalOne", ignoreCase = true)
        }
        assumeTrue("RKLLM smoke skipped: no matching READY model under /sdcard/models", readyModel != null)
        val model = readyModel!!

        assertNull(RkllmNative.loadError)
        val fragments = Collections.synchronizedList(mutableListOf<String>())
        val firstFragmentAt = AtomicLong(-1L)
        val callback = object : RkllmNative.Callback {
            override fun onNativeFragment(text: String, tokenId: Int, state: Int) {
                if (text.isBlank()) return
                firstFragmentAt.compareAndSet(-1L, SystemClock.elapsedRealtime())
                fragments += text
            }
        }

        var handle = 0L
        var runCode: Int? = null
        var destroyCode: Int? = null
        var startedAt = 0L
        var totalInferenceMs = 0L
        try {
            handle = RkllmNative.create(
                modelPath = model.absolutePath,
                maxContextLen = 512,
                maxNewTokens = 8,
                callback = callback,
            )
            assertTrue("rkllm_init/create returned an invalid handle", handle != 0L)
            startedAt = SystemClock.elapsedRealtime()
            runCode = RkllmNative.run(handle, "Hi", "user", 8)
            totalInferenceMs = SystemClock.elapsedRealtime() - startedAt
        } finally {
            if (handle != 0L) destroyCode = RkllmNative.destroy(handle)
        }

        assertEquals("rkllm_run failed", 0, runCode)
        assertEquals("rkllm_destroy failed", 0, destroyCode)
        assertTrue("RKLLM produced no non-empty fragment", fragments.any { it.isNotBlank() })
        assertTrue("first token latency was not captured", firstFragmentAt.get() >= startedAt)
        val firstTokenLatencyMs = firstFragmentAt.get() - startedAt
        assertTrue("first token latency must be non-negative", firstTokenLatencyMs >= 0L)
        assertTrue("total inference time must be positive", totalInferenceMs > 0L)
    }
}
