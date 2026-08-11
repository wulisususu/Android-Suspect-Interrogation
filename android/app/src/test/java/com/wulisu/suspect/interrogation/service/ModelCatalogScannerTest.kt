package com.wulisu.suspect.interrogation.service

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TemporaryFolder
import java.io.File

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
        val llmRoot = File(root, "llm").apply { mkdirs() }
        File(llmRoot, "first.gguf").writeBytes(ByteArray(1))
        File(llmRoot, "second.gguf").writeBytes(ByteArray(1))
        val selectedId = "LLM:llm/second.gguf"

        val catalog = scanner.scan(root, mapOf(ModelCategory.LLM to selectedId))

        assertEquals("second", catalog.selected(ModelCategory.LLM)?.name)
        assertEquals(1, catalog.models.count { it.selected })
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

