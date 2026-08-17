package com.wulisu.suspect.interrogation.ocr

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.util.Log
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith
import java.io.File
import java.io.FileOutputStream

@RunWith(AndroidJUnit4::class)
class OcrRecognitionQualityInstrumentedTest {
    @Test
    fun generatedChineseImageProducesMeaningfulText() {
        val context = ApplicationProvider.getApplicationContext<android.content.Context>()
        val modelDir = File("/sdcard/models/ocr")
        assumeTrue(
            "OCR model files are missing from /sdcard/models/ocr",
            File(modelDir, "ppocrv4_det.onnx").isFile &&
                File(modelDir, "ppocrv4_rec.onnx").isFile &&
                File(modelDir, "ppocr_keys_v1.txt").isFile,
        )

        val image = File(context.cacheDir, "ocr-quality-cn.png")
        createChinesePng(image)
        val dictionary = File(modelDir, "ppocr_keys_v1.txt").bufferedReader().use { it.readLines() }
        val engine = OnnxPpocrV4Engine(
            modelRoot = modelDir,
            dictionary = buildList {
                add("")
                addAll(dictionary)
                add(" ")
            },
            modelSpec = OcrKnownModels.PPOCR_V4_ONNX,
        )

        try {
            engine.initialize()
            val result = engine.recognize(OcrInput(image))
            val normalized = result.text.replace(Regex("\\s+"), "")
            val blocks = result.blocks.joinToString(separator = "\n") { it.toString() }
            Log.i(TAG, "OCR text=<<<${result.text}>>>\nOCR blocks=<<<\n$blocks\n>>>")

            assertFalse("OCR text was blank. blocks=<<<$blocks>>>", result.text.isBlank())
            assertTrue("OCR blocks were empty. text=<<<${result.text}>>>", result.blocks.isNotEmpty())
            assertTrue("Expected digits 123. text=<<<${result.text}>>> blocks=<<<$blocks>>>", normalized.contains("123"))
            val keywords = listOf("公安", "讯问", "测试", "完全", "离线", "识别")
            assertTrue(
                "Expected at least one Chinese keyword $keywords. text=<<<${result.text}>>> blocks=<<<$blocks>>>",
                keywords.any(normalized::contains),
            )
        } finally {
            engine.release()
        }
    }

    private fun createChinesePng(file: File) {
        val bitmap = Bitmap.createBitmap(960, 360, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.drawColor(Color.WHITE)
        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = Color.BLACK
            textSize = 76f
            strokeWidth = 2f
        }
        canvas.drawText("公安讯问 OCR 测试 123", 48f, 150f, paint)
        paint.textSize = 58f
        canvas.drawText("完全离线识别", 48f, 250f, paint)
        FileOutputStream(file).use { bitmap.compress(Bitmap.CompressFormat.PNG, 100, it) }
        bitmap.recycle()
    }

    companion object {
        private const val TAG = "OcrRecognitionQuality"
    }
}
