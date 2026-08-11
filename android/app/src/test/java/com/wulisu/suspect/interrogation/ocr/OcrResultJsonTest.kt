package com.wulisu.suspect.interrogation.ocr

import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class OcrResultJsonTest {
    @Test
    fun `result json contains nullable geometry and timing fields`() {
        val result = OcrResult(
            text = "测试",
            blocks = listOf(
                OcrTextBlock(
                    text = "测试",
                    confidence = null,
                    rect = null,
                    points = null,
                ),
            ),
            imageWidth = 640,
            imageHeight = 480,
            modelName = "PP-OCRv4 ONNX",
            provider = "onnxruntime-cpu",
            initializationMs = 12,
            recognitionMs = 34,
            previewUri = null,
        )

        val json = result.toJson()

        assertEquals("测试", json.getString("text"))
        assertEquals(640, json.getInt("imageWidth"))
        assertEquals("onnxruntime-cpu", json.getString("provider"))
        assertEquals(12L, json.getLong("initializationMs"))
        assertTrue(json.getJSONArray("blocks").getJSONObject(0).isNull("confidence"))
        assertTrue(json.getJSONArray("blocks").getJSONObject(0).isNull("points"))
    }
}
