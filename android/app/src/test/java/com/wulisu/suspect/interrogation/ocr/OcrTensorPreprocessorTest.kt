package com.wulisu.suspect.interrogation.ocr

import org.junit.Assert.assertArrayEquals
import org.junit.Test

class OcrTensorPreprocessorTest {
    @Test
    fun `pp ocr input is normalized in RGB channel order`() {
        val tensor = OcrTensorPreprocessor.rgbChw(
            pixels = intArrayOf(0xffff0000.toInt()),
            width = 1,
            height = 1,
            mean = floatArrayOf(0f, 0f, 0f),
            std = floatArrayOf(1f, 1f, 1f),
        )

        assertArrayEquals(floatArrayOf(1f, 0f, 0f), tensor, 0.0001f)
    }
}
