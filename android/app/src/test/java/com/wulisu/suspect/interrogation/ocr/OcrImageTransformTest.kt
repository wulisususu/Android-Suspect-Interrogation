package com.wulisu.suspect.interrogation.ocr

import org.junit.Assert.assertEquals
import org.junit.Test

class OcrImageTransformTest {
    @Test
    fun `letterbox mapping returns model coordinates to original image coordinates`() {
        val transform = OcrImageTransform.letterbox(
            sourceWidth = 1000,
            sourceHeight = 500,
            targetWidth = 480,
            targetHeight = 480,
        )

        assertEquals(0.48f, transform.scale, 0.0001f)
        assertEquals(0f, transform.padX, 0.0001f)
        assertEquals(120f, transform.padY, 0.0001f)

        val point = transform.toOriginal(OcrPoint(240f, 240f))

        assertEquals(500f, point.x, 0.01f)
        assertEquals(250f, point.y, 0.01f)
    }

    @Test
    fun `rotation swaps image dimensions for right angle exif`() {
        assertEquals(OcrImageSize(720, 1280), OcrImageTransform.rotatedSize(1280, 720, 90))
        assertEquals(OcrImageSize(1280, 720), OcrImageTransform.rotatedSize(1280, 720, 180))
    }
}
