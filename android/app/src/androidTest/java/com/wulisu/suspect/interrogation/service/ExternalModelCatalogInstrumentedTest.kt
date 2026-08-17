package com.wulisu.suspect.interrogation.service

import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith
import java.io.File

@RunWith(AndroidJUnit4::class)
class ExternalModelCatalogInstrumentedTest {
    @Test
    fun supportedModelsAreRuntimeReadyFromSharedStorage() {
        assumeTrue("External model root is unavailable", File(ModelDirectories.ROOT_PATH).canRead())
        val context = ApplicationProvider.getApplicationContext<android.content.Context>()

        val catalog = ModelManager(context).scan()

        assertEquals(ModelDirectories.ROOT_PATH, catalog.rootPath)
        listOf("ASR:asr/zipformer_rk3576", "ASR:asr/paraformer_int8").forEach { id ->
            assertTrue("ASR model is not runtime ready: $id", catalog.models.any { it.id == id && it.runtimeReady })
        }
        assertTrue(
            "PP-OCRv4 is not runtime ready from /sdcard/models/ocr",
            catalog.models.any { it.category == ModelCategory.OCR && it.modelFormat == "onnx" && it.runtimeReady },
        )
        assertTrue(
            "LegalOne RKLLM is not runtime ready from /sdcard/models",
            catalog.models.any { it.category == ModelCategory.LLM && it.name.contains("LegalOne") && it.runtimeReady },
        )
    }
}
