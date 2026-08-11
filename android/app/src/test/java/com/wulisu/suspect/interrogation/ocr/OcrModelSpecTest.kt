package com.wulisu.suspect.interrogation.ocr

import com.wulisu.suspect.interrogation.service.ModelCategory
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class OcrModelSpecTest {
    @Test
    fun `ocr category uses its own model directory`() {
        assertEquals("ocr", ModelCategory.OCR.directoryName)
        assertEquals("OCR", ModelCategory.OCR.displayName)
    }

    @Test
    fun `ppocr v4 onnx uses onnxruntime cpu and never rknn`() {
        val spec = OcrKnownModels.PPOCR_V4_ONNX

        assertEquals(OcrModelFormat.ONNX, spec.format)
        assertEquals("onnxruntime-cpu", spec.provider)
        assertEquals("ppocrv4_det.onnx", spec.requiredFiles[0])
        assertEquals("ppocrv4_rec.onnx", spec.requiredFiles[1])
        assertFalse(spec.provider.contains("rknn", ignoreCase = true))
    }

    @Test
    fun `ppocr v6 tar is paddle pir and not runnable without paddle runtime`() {
        val spec = OcrKnownModels.PPOCR_V6_SMALL_PADDLE

        assertEquals(OcrModelFormat.PADDLE_PIR, spec.format)
        assertEquals("paddle-inference", spec.provider)
        assertTrue(spec.requiredFiles.contains("PP-OCRv6_small_det_infer.tar"))
        assertTrue(spec.requiredFiles.contains("PP-OCRv6_small_rec_infer.tar"))
        assertFalse(spec.runtimeAvailable)
    }
}
