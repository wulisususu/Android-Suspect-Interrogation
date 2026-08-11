package com.wulisu.suspect.interrogation.ocr

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TemporaryFolder
import java.io.File

class OcrModelProbeTest {
    @get:Rule
    val temporaryFolder = TemporaryFolder()

    @Test
    fun `v4 onnx model is complete only when det and rec files exist`() {
        val root = temporaryFolder.newFolder("ocr")
        File(root, "ppocrv4_det.onnx").writeBytes(ByteArray(3))

        assertFalse(OcrModelProbe.probe(root).any { it.complete })

        File(root, "ppocrv4_rec.onnx").writeBytes(ByteArray(4))
        val candidates = OcrModelProbe.probe(root)

        assertEquals(OcrKnownModels.PPOCR_V4_ONNX.id, candidates.single().spec.id)
        assertTrue(candidates.single().complete)
        assertTrue(candidates.single().runtimeReady)
    }

    @Test
    fun `v6 paddle tar pair is complete but not runtime ready`() {
        val root = temporaryFolder.newFolder("ocr")
        File(root, "PP-OCRv6_small_det_infer.tar").writeBytes(ByteArray(3))
        File(root, "PP-OCRv6_small_rec_infer.tar").writeBytes(ByteArray(4))

        val candidate = OcrModelProbe.probe(root).single()

        assertEquals(OcrKnownModels.PPOCR_V6_SMALL_PADDLE.id, candidate.spec.id)
        assertTrue(candidate.complete)
        assertFalse(candidate.runtimeReady)
        assertEquals("paddle-inference", candidate.spec.provider)
    }
}
