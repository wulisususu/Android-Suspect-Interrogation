package com.wulisu.suspect.interrogation.asr

import android.content.Context
import android.util.Base64
import android.util.Log
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.wulisu.suspect.interrogation.asr.fixture.ASR_SMOKE_WAV_B64_PART_0
import com.wulisu.suspect.interrogation.asr.fixture.ASR_SMOKE_WAV_B64_PART_1
import com.wulisu.suspect.interrogation.asr.fixture.ASR_SMOKE_WAV_B64_PART_2
import com.wulisu.suspect.interrogation.asr.fixture.ASR_SMOKE_WAV_B64_PART_3
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test
import org.junit.runner.RunWith
import java.io.ByteArrayInputStream
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.util.zip.GZIPInputStream

@RunWith(AndroidJUnit4::class)
class AsrAcousticInstrumentedSmokeTest {
    @Test
    fun paraformerTranscribesFixedWavThroughRealStreamingEngine() {
        val appContext = ApplicationProvider.getApplicationContext<Context>()
        val engine = ParaformerEngine(appContext)

        assumeTrue(
            "Paraformer model assets are unavailable or still Git LFS pointers; skipping acoustic smoke",
            engine.spec.requiredAssets.all { assetIsMaterialized(appContext, it) },
        )

        val encodedFixture = buildString(14_704) {
            append(ASR_SMOKE_WAV_B64_PART_0)
            append(ASR_SMOKE_WAV_B64_PART_1)
            append(ASR_SMOKE_WAV_B64_PART_2)
            append(ASR_SMOKE_WAV_B64_PART_3)
        }
        val compressed = Base64.decode(encodedFixture, Base64.NO_WRAP)
        val wavBytes = GZIPInputStream(ByteArrayInputStream(compressed)).use { it.readBytes() }
        val wav = parsePcm16MonoWav(wavBytes)

        try {
            val result = engine.transcribePcm16Mono(wav.samples, wav.sampleRate)
            val diagnostic = "model=${engine.spec.id.wireValue} provider=${engine.spec.provider} " +
                "fixture=embedded-gzip-wav samples=${wav.samples.size} sampleRate=${wav.sampleRate} " +
                "latencyMs=${result.latencyMs} confidence=${result.confidence} text=${result.text}"
            Log.i("AsrAcousticSmoke", diagnostic)

            assertTrue("ASR final text must not be blank. $diagnostic", result.text.isNotBlank())
            val normalized = result.text.lowercase().replace(Regex("\\s+"), "")
            assertTrue(
                "ASR must match the keyword spoken by the fixed WAV fixture $EXPECTED_KEYWORDS. $diagnostic",
                EXPECTED_KEYWORDS.any { keyword -> normalized.contains(keyword) },
            )
        } finally {
            engine.release()
        }
    }

    private fun assetIsMaterialized(context: Context, path: String): Boolean = runCatching {
        context.assets.open(path).use { input ->
            val prefix = ByteArray(160)
            val count = input.read(prefix)
            if (count <= 0) return@use false
            val textPrefix = String(prefix, 0, count, Charsets.UTF_8)
            !textPrefix.startsWith("version https://git-lfs.github.com/spec/v1")
        }
    }.getOrDefault(false)

    private fun parsePcm16MonoWav(bytes: ByteArray): WavFixture {
        require(bytes.size >= 44) { "WAV fixture is too short" }
        require(bytes.copyOfRange(0, 4).decodeToString() == "RIFF") { "WAV fixture missing RIFF header" }
        require(bytes.copyOfRange(8, 12).decodeToString() == "WAVE") { "WAV fixture missing WAVE header" }

        var offset = 12
        var sampleRate: Int? = null
        var channels: Int? = null
        var bitsPerSample: Int? = null
        var audioFormat: Int? = null
        var dataOffset = -1
        var dataSize = -1
        while (offset + 8 <= bytes.size) {
            val id = bytes.copyOfRange(offset, offset + 4).decodeToString()
            val size = littleEndianInt(bytes, offset + 4)
            val payload = offset + 8
            require(size >= 0 && payload + size <= bytes.size) { "Invalid WAV chunk $id size=$size" }
            when (id) {
                "fmt " -> {
                    require(size >= 16) { "WAV fmt chunk is too short" }
                    audioFormat = littleEndianShort(bytes, payload)
                    channels = littleEndianShort(bytes, payload + 2)
                    sampleRate = littleEndianInt(bytes, payload + 4)
                    bitsPerSample = littleEndianShort(bytes, payload + 14)
                }
                "data" -> {
                    dataOffset = payload
                    dataSize = size
                }
            }
            offset = payload + size + (size and 1)
        }

        require(audioFormat == 1) { "WAV fixture must be PCM (format=$audioFormat)" }
        require(channels == 1) { "WAV fixture must be mono (channels=$channels)" }
        require(bitsPerSample == 16) { "WAV fixture must be PCM16 (bits=$bitsPerSample)" }
        val resolvedSampleRate = requireNotNull(sampleRate) { "WAV fixture is missing sample rate" }
        require(resolvedSampleRate == 16_000) { "WAV fixture must be 16kHz (sampleRate=$resolvedSampleRate)" }
        require(dataOffset >= 0 && dataSize > 0 && dataSize % 2 == 0) { "WAV fixture has no PCM16 data" }

        val samples = ShortArray(dataSize / 2)
        val buffer = ByteBuffer.wrap(bytes, dataOffset, dataSize).order(ByteOrder.LITTLE_ENDIAN)
        for (index in samples.indices) samples[index] = buffer.short
        return WavFixture(sampleRate = resolvedSampleRate, samples = samples)
    }

    private fun littleEndianShort(bytes: ByteArray, offset: Int): Int =
        ByteBuffer.wrap(bytes, offset, 2).order(ByteOrder.LITTLE_ENDIAN).short.toInt() and 0xffff

    private fun littleEndianInt(bytes: ByteArray, offset: Int): Int =
        ByteBuffer.wrap(bytes, offset, 4).order(ByteOrder.LITTLE_ENDIAN).int

    private data class WavFixture(val sampleRate: Int, val samples: ShortArray)

    companion object {
        private val EXPECTED_KEYWORDS = listOf("公安")
    }
}
