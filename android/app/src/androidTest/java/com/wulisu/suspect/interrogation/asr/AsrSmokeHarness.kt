package com.wulisu.suspect.interrogation.asr

import android.content.Context
import android.util.Base64
import android.util.Log
import androidx.test.platform.app.InstrumentationRegistry
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import java.io.ByteArrayInputStream
import java.io.File
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.util.zip.GZIPInputStream

object AsrSmokeHarness {
    fun run(context: Context, spec: AsrModelSpec) {
        assumeTrue("${spec.displayName} files unavailable", spec.requiredFiles.all { File(it).isFile })

        val wav = loadFixture(spec)
        require(String(wav, 0, 4, Charsets.US_ASCII) == "RIFF")
        require(String(wav, 8, 4, Charsets.US_ASCII) == "WAVE")
        val sampleRate = littleEndianInt(wav, 24)
        val data = dataChunk(wav)
        val pcm = ByteBuffer.wrap(wav, data.first, data.second).order(ByteOrder.LITTLE_ENDIAN)
        val speechSamples = FloatArray(data.second / 2) { pcm.short / 32768.0f }
        val samples = speechSamples.copyOf(speechSamples.size + sampleRate * TRAILING_SILENCE_SECONDS)

        val engine = when (spec.id) {
            AsrModelId.ZIPFORMER_RK3576 -> ZipformerRknnEngine(context)
            AsrModelId.PARAFORMER_INT8 -> ParaformerEngine(context)
        }
        try {
            val result = engine.transcribePcm(AsrPcmInput(samples, sampleRate))
            Log.i(TAG, "finalText=<<<${result.text}>>> latencyMs=${result.latencyMs} confidence=${result.confidence}")
            assertFalse("real ASR final text was blank", result.text.isBlank())
            if (spec.id == AsrModelId.PARAFORMER_INT8) {
                assertTrue(
                    "fixture keyword missing from final text: ${result.text}",
                    listOf("测试", "测", "试").any(result.text::contains),
                )
            }
        } finally {
            engine.release()
        }
    }

    private fun loadFixture(spec: AsrModelSpec): ByteArray {
        if (spec.id == AsrModelId.ZIPFORMER_RK3576) {
            val officialFixture = File("/sdcard/models/zipformer_official_0.wav")
            assumeTrue("Zipformer official WAV fixture unavailable", officialFixture.isFile)
            return officialFixture.readBytes()
        }
        val encoded = InstrumentationRegistry.getInstrumentation().context.assets
            .open("asr/asr_smoke_test.wav.gz.b64")
            .bufferedReader()
            .use { it.readText() }
        val compressed = Base64.decode(encoded, Base64.DEFAULT)
        return GZIPInputStream(ByteArrayInputStream(compressed)).use { it.readBytes() }
    }

    private fun dataChunk(wav: ByteArray): Pair<Int, Int> {
        var offset = 12
        while (offset + 8 <= wav.size) {
            val id = String(wav, offset, 4, Charsets.US_ASCII)
            val size = littleEndianInt(wav, offset + 4)
            if (id == "data") return Pair(offset + 8, size)
            offset += 8 + size + (size and 1)
        }
        error("WAV data chunk missing")
    }

    private fun littleEndianInt(bytes: ByteArray, offset: Int): Int =
        ByteBuffer.wrap(bytes, offset, 4).order(ByteOrder.LITTLE_ENDIAN).int

    private const val TAG = "AsrRealEngineSmoke"
    private const val TRAILING_SILENCE_SECONDS = 2
}
