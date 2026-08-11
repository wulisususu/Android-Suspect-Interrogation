package com.wulisu.suspect.interrogation.asr

import org.junit.Assert.assertEquals
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TemporaryFolder
import java.nio.ByteBuffer
import java.nio.ByteOrder

class PcmWavWriterTest {
    @get:Rule
    val temporaryFolder = TemporaryFolder()

    @Test
    fun `writes mono pcm16 wav and updates lengths`() {
        val file = temporaryFolder.newFile("capture.wav")
        val writer = PcmWavWriter(file, 16_000)

        writer.append(shortArrayOf(0, 1, -1, Short.MAX_VALUE), 4)
        writer.checkpoint()
        writer.close()

        val bytes = file.readBytes()
        assertEquals("RIFF", bytes.copyOfRange(0, 4).toString(Charsets.US_ASCII))
        assertEquals("WAVE", bytes.copyOfRange(8, 12).toString(Charsets.US_ASCII))
        assertEquals("data", bytes.copyOfRange(36, 40).toString(Charsets.US_ASCII))
        assertEquals(44 + 8, bytes.size)
        assertEquals(44, littleEndianInt(bytes, 4))
        assertEquals(8, littleEndianInt(bytes, 40))
    }

    private fun littleEndianInt(bytes: ByteArray, offset: Int): Int =
        ByteBuffer.wrap(bytes, offset, 4).order(ByteOrder.LITTLE_ENDIAN).int
}
