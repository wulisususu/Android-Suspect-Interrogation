package com.wulisu.suspect.interrogation.service

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TemporaryFolder
import java.io.File
import java.io.RandomAccessFile

class ModelCatalogScannerTest {
    @get:Rule
    val temporaryFolder = TemporaryFolder()

    private val scanner = ModelCatalogScanner()

    @Test
    fun `empty scan creates every category and returns no models`() {
        val root = temporaryFolder.newFolder("models")

        val catalog = scanner.scan(root)

        assertTrue(catalog.models.isEmpty())
        ModelCategory.entries.forEach { category ->
            assertTrue(File(root, category.directoryName).isDirectory)
        }
    }

    @Test
    fun `scan describes files and directories without unpacking archives`() {
        val root = temporaryFolder.newFolder("models")
        val asrRoot = File(root, "asr").apply { mkdirs() }
        File(asrRoot, "zipformer-rk3576-2023-02-20.tar.bz2").writeBytes(ByteArray(3))
        val directory = File(asrRoot, "paraformer-int8").apply { mkdirs() }
        File(directory, "encoder.onnx").writeBytes(ByteArray(5))

        val models = scanner.scan(root).models

        assertEquals(2, models.size)
        assertEquals("paraformer-int8", models[0].name)
        assertEquals(ModelSourceKind.DIRECTORY, models[0].sourceKind)
        assertEquals(5L, models[0].sizeBytes)
        assertEquals("zipformer-rk3576-2023-02-20", models[1].name)
        assertEquals(ModelSourceKind.FILE, models[1].sourceKind)
        assertTrue(models[1].archive)
        assertEquals(3L, models[1].sizeBytes)
    }

    @Test
    fun `scan marks only the persisted model selection`() {
        val root = temporaryFolder.newFolder("models")
        val vadRoot = File(root, "vad").apply { mkdirs() }
        File(vadRoot, "first.onnx").writeBytes(ByteArray(1))
        File(vadRoot, "second.onnx").writeBytes(ByteArray(1))
        val selectedId = "VAD:vad/second.onnx"

        val catalog = scanner.scan(root, mapOf(ModelCategory.VAD to selectedId))

        assertEquals("second", catalog.selected(ModelCategory.VAD)?.name)
        assertEquals(1, catalog.models.count { it.selected })
    }

    @Test
    fun `scan marks a complete known ASR directory runtime ready`() {
        val root = temporaryFolder.newFolder("models")
        val modelRoot = File(root, "asr/zipformer_rk3576").apply { mkdirs() }
        listOf("encoder.rknn", "decoder.rknn", "joiner.rknn", "tokens.txt").forEach { name ->
            File(modelRoot, name).writeBytes(byteArrayOf(1))
        }

        val model = scanner.scan(root).models.single { it.category == ModelCategory.ASR }

        assertEquals("ASR:asr/zipformer_rk3576", model.id)
        assertTrue(model.complete)
        assertTrue(model.runtimeReady)
    }

    @Test
    fun `scan keeps an incomplete known ASR directory unavailable`() {
        val root = temporaryFolder.newFolder("models")
        val modelRoot = File(root, "asr/paraformer_int8").apply { mkdirs() }
        File(modelRoot, "encoder.int8.onnx").writeBytes(byteArrayOf(1))

        val model = scanner.scan(root).models.single { it.category == ModelCategory.ASR }

        assertFalse(model.complete)
        assertFalse(model.runtimeReady)
    }

    @Test
    fun `scan reads rkllm files from external root without unrelated files`() {
        val privateRoot = temporaryFolder.newFolder("private")
        val sharedRoot = temporaryFolder.newFolder("shared")
        val model = File(sharedRoot, "LegalOne-4B_W8A8_RK3576.rkllm")
        RandomAccessFile(model, "rw").use { it.setLength(4_862_583_588L) }
        File(sharedRoot, "notes.txt").writeText("ignore")

        val models = scanner.scan(
            root = privateRoot,
            externalRoots = listOf(sharedRoot),
            devicePlatform = "rk3576",
        ).models.filter { it.category == ModelCategory.LLM }

        assertEquals(1, models.size)
        assertEquals("RKLLM", models.single().modelFormat)
        assertEquals("RKLLM / RK3576 NPU", models.single().provider)
        assertEquals("RK3576", models.single().targetPlatform)
        assertEquals("READY", models.single().compatibility)
        assertTrue(models.single().complete)
        assertTrue(models.single().runtimeReady)
    }

    @Test
    fun `standard llm category directory is scanned`() {
        val root = temporaryFolder.newFolder("models")
        val model = File(File(root, "llm").apply { mkdirs() }, "LegalOne-4B_W8A8_RK3576.rkllm")
        RandomAccessFile(model, "rw").use { it.setLength(4_862_583_588L) }

        val models = scanner.scan(root, devicePlatform = "rk3576").models

        val descriptor = models.single { it.category == ModelCategory.LLM }
        assertEquals("LLM:llm/LegalOne-4B_W8A8_RK3576.rkllm", descriptor.id)
        assertEquals(model.absolutePath, descriptor.absolutePath)
    }

    @Test
    fun `scan ignores interrupted and hidden imports`() {
        val root = temporaryFolder.newFolder("models")
        val vadRoot = File(root, "vad").apply { mkdirs() }
        File(vadRoot, ".importing-silero").writeBytes(ByteArray(2))
        File(vadRoot, "silero.part").writeBytes(ByteArray(2))
        File(vadRoot, "silero.onnx").writeBytes(ByteArray(2))

        val models = scanner.scan(root).models

        assertEquals(1, models.size)
        assertEquals("silero", models.single().name)
        assertFalse(models.single().selected)
    }
}
