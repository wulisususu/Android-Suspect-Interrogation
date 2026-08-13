package com.wulisu.suspect.interrogation.ocr

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.os.Debug
import android.os.SystemClock
import android.util.Log
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith
import java.io.File
import java.io.FileOutputStream

@RunWith(AndroidJUnit4::class)
class OcrInstrumentedSmokeTest {
    @Test
    fun ppocrV4OnnxInitializesAndRecognizesGeneratedChineseImage() {
        val context = ApplicationProvider.getApplicationContext<android.content.Context>()
        val modelDir = File("/sdcard/models/ocr")
        val det = File(modelDir, "ppocrv4_det.onnx")
        val rec = File(modelDir, "ppocrv4_rec.onnx")
        assumeTrue("OCR ONNX files are missing from /sdcard/models/ocr", det.isFile && rec.isFile)

        val image = File(context.cacheDir, "ocr-smoke-cn.png")
        createChinesePng(image)

        val engine = OnnxPpocrV4Engine(
            modelRoot = modelDir,
            dictionary = loadDictionary(context),
            modelSpec = OcrKnownModels.PPOCR_V4_ONNX,
        )
        try {
            val beforeMemory = Debug.MemoryInfo().also { Debug.getMemoryInfo(it) }
            val init = engine.initialize()
            val cpuStarted = Debug.threadCpuTimeNanos()
            val wallStarted = SystemClock.elapsedRealtime()
            val result = engine.recognize(OcrInput(image))
            val wallMs = SystemClock.elapsedRealtime() - wallStarted
            val cpuMs = (Debug.threadCpuTimeNanos() - cpuStarted) / 1_000_000
            val afterMemory = Debug.MemoryInfo().also { Debug.getMemoryInfo(it) }
            val diagnostic = buildString {
                append("model=${result.modelName} provider=${result.provider} initMs=${init.initializationMs} ")
                append("recognitionMs=${result.recognitionMs} wallMs=$wallMs threadCpuMs=$cpuMs ")
                append("pssBeforeKb=${beforeMemory.totalPss} pssAfterKb=${afterMemory.totalPss} ")
                append("nativeHeapKb=${Debug.getNativeHeapAllocatedSize() / 1024} ")
                append("text=${result.text} blocks=${result.blocks}")
            }
            Log.i("OcrInstrumentedSmokeTest", diagnostic)

            assertEquals("onnxruntime-cpu", result.provider)
            assertTrue(init.initializationMs >= 0)
            assertTrue(result.recognitionMs >= 0)
            assertEquals(960, result.imageWidth)
            assertEquals(360, result.imageHeight)
            assertTrue("OCR text must not be blank. $diagnostic", result.text.isNotBlank())
            assertTrue("OCR blocks must not be empty. $diagnostic", result.blocks.isNotEmpty())

            val normalized = result.text.replace(Regex("\\s+"), "")
            assertTrue("OCR must recognize key digits 123. $diagnostic", "123" in normalized)
            val chineseKeywords = listOf("公安", "讯问", "测试", "完全", "离线", "识别")
            assertTrue(
                "OCR must recognize at least one expected Chinese keyword $chineseKeywords. $diagnostic",
                chineseKeywords.any(normalized::contains),
            )
        } finally {
            engine.release()
        }
    }

    @Test
    fun ppocrV6TarIsDetectedButRuntimeUnavailable() {
        val modelDir = File("/sdcard/models/ocr")
        val candidates = OcrModelProbe.probe(modelDir)
        val v6 = candidates.firstOrNull { it.spec.id == "ppocrv6_small_paddle" }
        assumeTrue("OCR v6 tar files are missing from /sdcard/models/ocr", v6 != null)
        assertTrue(v6!!.complete)
        assertEquals(false, v6.runtimeReady)
        assertEquals("paddle-inference", v6.spec.provider)
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

    private fun loadDictionary(context: android.content.Context): List<String> {
        val lines = context.assets.open("models/ocr/ppocr_keys_v1.txt").bufferedReader().use { it.readLines() }
        return buildList {
            add("")
            addAll(lines)
            add(" ")
        }
    }
}
