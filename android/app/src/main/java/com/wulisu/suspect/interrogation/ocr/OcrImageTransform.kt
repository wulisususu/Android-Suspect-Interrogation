package com.wulisu.suspect.interrogation.ocr

data class OcrImageTransform(
    val sourceWidth: Int,
    val sourceHeight: Int,
    val targetWidth: Int,
    val targetHeight: Int,
    val scale: Float,
    val padX: Float,
    val padY: Float,
) {
    fun toOriginal(point: OcrPoint): OcrPoint = OcrPoint(
        x = ((point.x - padX) / scale).coerceIn(0f, sourceWidth.toFloat()),
        y = ((point.y - padY) / scale).coerceIn(0f, sourceHeight.toFloat()),
    )

    companion object {
        fun letterbox(
            sourceWidth: Int,
            sourceHeight: Int,
            targetWidth: Int,
            targetHeight: Int,
        ): OcrImageTransform {
            val scale = minOf(targetWidth.toFloat() / sourceWidth, targetHeight.toFloat() / sourceHeight)
            val scaledWidth = sourceWidth * scale
            val scaledHeight = sourceHeight * scale
            return OcrImageTransform(
                sourceWidth = sourceWidth,
                sourceHeight = sourceHeight,
                targetWidth = targetWidth,
                targetHeight = targetHeight,
                scale = scale,
                padX = (targetWidth - scaledWidth) / 2f,
                padY = (targetHeight - scaledHeight) / 2f,
            )
        }

        fun rotatedSize(width: Int, height: Int, degrees: Int): OcrImageSize =
            if (degrees.mod(180) == 0) OcrImageSize(width, height) else OcrImageSize(height, width)
    }
}
