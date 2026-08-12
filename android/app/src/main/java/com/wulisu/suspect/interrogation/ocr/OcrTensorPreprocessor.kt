package com.wulisu.suspect.interrogation.ocr

internal object OcrTensorPreprocessor {
    fun rgbChw(
        pixels: IntArray,
        width: Int,
        height: Int,
        mean: FloatArray,
        std: FloatArray,
    ): FloatArray {
        require(pixels.size == width * height)
        require(mean.size == 3 && std.size == 3)
        val plane = width * height
        val output = FloatArray(plane * 3)
        pixels.forEachIndexed { index, color ->
            val red = ((color ushr 16) and 0xff) / 255f
            val green = ((color ushr 8) and 0xff) / 255f
            val blue = (color and 0xff) / 255f
            output[index] = (red - mean[0]) / std[0]
            output[plane + index] = (green - mean[1]) / std[1]
            output[plane * 2 + index] = (blue - mean[2]) / std[2]
        }
        return output
    }
}
