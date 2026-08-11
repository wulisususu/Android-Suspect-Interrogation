package com.wulisu.suspect.interrogation.asr

import java.io.Closeable
import java.io.File
import java.io.RandomAccessFile
import java.nio.ByteBuffer
import java.nio.ByteOrder

class PcmWavWriter(
    file: File,
    private val sampleRate: Int,
) : Closeable {
    private val output = RandomAccessFile(file.also { it.parentFile?.mkdirs() }, "rw")
    private var dataBytes = 0L
    private var closed = false

    init {
        require(sampleRate > 0)
        output.setLength(0L)
        output.write(ByteArray(HEADER_BYTES))
        writeHeader()
    }

    @Synchronized
    fun append(samples: ShortArray, count: Int) {
        check(!closed) { "WAV writer is closed" }
        require(count in 0..samples.size)
        if (count == 0) return
        val bytes = ByteBuffer.allocate(count * BYTES_PER_SAMPLE).order(ByteOrder.LITTLE_ENDIAN)
        repeat(count) { bytes.putShort(samples[it]) }
        output.seek(HEADER_BYTES + dataBytes)
        output.write(bytes.array())
        dataBytes += bytes.capacity()
    }

    @Synchronized
    fun checkpoint() {
        if (closed) return
        writeHeader()
        output.fd.sync()
    }

    @Synchronized
    override fun close() {
        if (closed) return
        writeHeader()
        output.fd.sync()
        closed = true
        output.close()
    }

    private fun writeHeader() {
        output.seek(0L)
        output.writeBytes("RIFF")
        output.writeIntLe((36L + dataBytes).coerceAtMost(Int.MAX_VALUE.toLong()).toInt())
        output.writeBytes("WAVE")
        output.writeBytes("fmt ")
        output.writeIntLe(16)
        output.writeShortLe(1)
        output.writeShortLe(CHANNELS)
        output.writeIntLe(sampleRate)
        output.writeIntLe(sampleRate * CHANNELS * BYTES_PER_SAMPLE)
        output.writeShortLe(CHANNELS * BYTES_PER_SAMPLE)
        output.writeShortLe(BITS_PER_SAMPLE)
        output.writeBytes("data")
        output.writeIntLe(dataBytes.coerceAtMost(Int.MAX_VALUE.toLong()).toInt())
    }

    private fun RandomAccessFile.writeIntLe(value: Int) {
        writeInt(Integer.reverseBytes(value))
    }

    private fun RandomAccessFile.writeShortLe(value: Int) {
        writeShort(java.lang.Short.reverseBytes(value.toShort()).toInt())
    }

    companion object {
        private const val HEADER_BYTES = 44
        private const val CHANNELS = 1
        private const val BITS_PER_SAMPLE = 16
        private const val BYTES_PER_SAMPLE = 2
    }
}
