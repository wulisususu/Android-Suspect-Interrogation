package com.wulisu.suspect.interrogation.service

import com.wulisu.suspect.interrogation.llm.LlmModelMetadata
import com.wulisu.suspect.interrogation.llm.LlmModelMetadataStore
import com.wulisu.suspect.interrogation.llm.LlmTargetPlatform
import com.wulisu.suspect.interrogation.llm.RKLLM_RUNTIME_VERSION
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
        ModelCategory.entries.forEach { category -> assertTrue(File(root, category.directoryName).isDirectory) }
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
    fun `scan uses sidecar metadata and does not require LegalOne filename`() {
        val privateRoot = temporaryFolder.newFolder("private-metadata")
        val sharedRoot = temporaryFolder.newFolder("shared-metadata")
        val model = File(sharedRoot, "custom.rkllm").apply { writeBytes(ByteArray(32)) }
        val metadata = LlmModelMetadata(
            name = "Custom RKLLM",
            platform = LlmTargetPlatform.RK3588,
            runtimeVersion = RKLLM_RUNTIME_VERSION,
            quantization = "W8A8",
            size = model.length(),
            sha256 = "a".repeat(64),
            modelFormat = "RKLLM",
        )
        LlmModelMetadataStore.sidecarFor(model).writeText(metadata.toJson().toString())
        val descriptor = scanner.scan(root = privateRoot, externalRoots = listOf(sharedRoot), devicePlatform = LlmTargetPlatform.RK3588).models.single { it.category == ModelCategory.LLM }
        assertEquals("Custom RKLLM", descriptor.name)
        assertEquals("W8A8", descriptor.quantization)
        assertEquals("a".repeat(64), descriptor.sha256)
        assertEquals("RKLLM / RK3588 NPU", descriptor.provider)
        assertTrue(descriptor.runtimeReady)
    }

    @Test
    fun `scan supports future nested rkllm directory and ignores part files`() {
        val privateRoot = temporaryFolder.newFolder("private-nested")
        val sharedRoot = temporaryFolder.newFolder("shared-nested")
        val nested = File(sharedRoot, "legalone/rk3588").apply { mkdirs() }
        val model = File(nested, "LegalOne-4B_W8A8_RK3588.rkllm").apply { writeBytes(ByteArray(64)) }
        LlmModelMetadataStore.sidecarFor(model).writeText(
            LlmModelMetadata(
                name = "LegalOne-4B",
                platform = LlmTargetPlatform.RK3588,
                runtimeVersion = RKLLM_RUNTIME_VERSION,
                quantization = "W8A8",
                size = model.length(),
                sha256 = "b".repeat(64),
                modelFormat = "RKLLM",
            ).toJson().toString(),
        )
        File(nested, "broken.rkllm.part").writeBytes(ByteArray(3))
        val models = scanner.scan(root = privateRoot, externalRoots = listOf(sharedRoot), devicePlatform = LlmTargetPlatform.RK3588).models.filter { it.category == ModelCategory.LLM }
        assertEquals(1, models.size)
        assertTrue(models.single().relativePath.contains("legalone/rk3588"))
        assertTrue(models.single().runtimeReady)
    }

    @Test
    fun `private llm directory is not used`() {
        val root = temporaryFolder.newFolder("models")
        File(File(root, "llm").apply { mkdirs() }, "private.rkllm").writeBytes(byteArrayOf(1))
        val models = scanner.scan(root, devicePlatform = LlmTargetPlatform.RK3576).models
        assertTrue(models.none { it.category == ModelCategory.LLM })
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
