package com.wulisu.suspect.interrogation.ocr

import ai.onnxruntime.OnnxTensor
import ai.onnxruntime.OrtEnvironment
import ai.onnxruntime.OrtSession
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Matrix
import android.graphics.Paint
import android.os.SystemClock
import android.util.Log
import androidx.exifinterface.media.ExifInterface
import com.wulisu.suspect.interrogation.domain.BusinessException
import java.io.File
import java.nio.FloatBuffer
import kotlin.math.max
import kotlin.math.min

class OnnxPpocrV4Engine(
    private val modelRoot: File,
    private val dictionary: List<String>,
    override val modelSpec: OcrModelSpec,
) : OcrEngine {
    private val lock = Any()

    @Volatile
    private var environment: OrtEnvironment? = null
    @Volatile
    private var detSession: OrtSession? = null
    @Volatile
    private var recSession: OrtSession? = null
    @Volatile
    private var initializationMs: Long? = null

    override fun initialize(): OcrInitializationMetrics = synchronized(lock) {
        initializationMs?.let { return OcrInitializationMetrics(it) }
        val detModel = File(modelRoot, "ppocrv4_det.onnx")
        val recModel = File(modelRoot, "ppocrv4_rec.onnx")
        if (!detModel.isFile || !recModel.isFile) {
            throw BusinessException("OCR_MODEL_INCOMPLETE", "PP-OCRv4 ONNX 需要 ppocrv4_det.onnx 和 ppocrv4_rec.onnx")
        }
        if (dictionary.size != 6625) {
            throw BusinessException("OCR_DICTIONARY_INVALID", "PP-OCRv4 字典数量不匹配：${dictionary.size}")
        }

        val started = SystemClock.elapsedRealtime()
        val env = OrtEnvironment.getEnvironment()
        val options = OrtSession.SessionOptions().apply {
            setIntraOpNumThreads(4)
            setInterOpNumThreads(1)
            setOptimizationLevel(OrtSession.SessionOptions.OptLevel.ALL_OPT)
        }
        environment = env
        detSession = env.createSession(detModel.absolutePath, options)
        recSession = env.createSession(recModel.absolutePath, options)
        val elapsed = SystemClock.elapsedRealtime() - started
        initializationMs = elapsed
        Log.i(TAG, "OCR initialized model=${modelSpec.displayName} provider=${modelSpec.provider} root=${modelRoot.name} initMs=$elapsed")
        OcrInitializationMetrics(elapsed)
    }

    override fun recognize(input: OcrInput): OcrResult {
        val init = initialize()
        val started = SystemClock.elapsedRealtime()
        val bitmap = decodeRotatedBitmap(input.imageFile)
        try {
            val transform = OcrImageTransform.letterbox(
                bitmap.width,
                bitmap.height,
                modelSpec.detInputWidth,
                modelSpec.detInputHeight,
            )
            val detInput = preprocessDetection(bitmap, transform)
            val boxes = runDetection(detInput, transform)
            val blocks = boxes.mapNotNull { box ->
                val crop = crop(bitmap, box.rect) ?: return@mapNotNull null
                try {
                    val recognition = runRecognition(crop)
                    if (recognition.text.isBlank()) null else OcrTextBlock(
                        text = recognition.text,
                        confidence = recognition.confidence,
                        rect = box.rect,
                        points = box.points,
                    )
                } finally {
                    if (!crop.isRecycled) crop.recycle()
                }
            }
            val elapsed = SystemClock.elapsedRealtime() - started
            val text = blocks.joinToString("\n") { it.text }
            Log.i(TAG, "OCR recognized model=${modelSpec.displayName} provider=${modelSpec.provider} blocks=${blocks.size} recognizeMs=$elapsed")
            return OcrResult(
                text = text,
                blocks = blocks,
                imageWidth = bitmap.width,
                imageHeight = bitmap.height,
                modelName = modelSpec.displayName,
                provider = modelSpec.provider,
                initializationMs = init.initializationMs,
                recognitionMs = elapsed,
                previewUri = null,
            )
        } finally {
            if (!bitmap.isRecycled) bitmap.recycle()
        }
    }

    override fun release() {
        synchronized(lock) {
        runCatching { detSession?.close() }
        runCatching { recSession?.close() }
        detSession = null
        recSession = null
        environment = null
        initializationMs = null
        Log.i(TAG, "OCR released model=${modelSpec.displayName} provider=${modelSpec.provider}")
        }
    }

    private fun runDetection(input: FloatArray, transform: OcrImageTransform): List<DetectedBox> {
        val env = requireNotNull(environment)
        val session = requireNotNull(detSession)
        val tensor = OnnxTensor.createTensor(
            env,
            FloatBuffer.wrap(input),
            longArrayOf(1, 3, modelSpec.detInputHeight.toLong(), modelSpec.detInputWidth.toLong()),
        )
        tensor.use { onnxTensor ->
            session.run(mapOf(session.inputNames.first() to onnxTensor)).use { result ->
                val output = result[0].value as Array<Array<Array<FloatArray>>>
                val map = output[0][0]
                return connectedBoxes(map, transform)
            }
        }
    }

    private fun runRecognition(bitmap: Bitmap): Recognition {
        val env = requireNotNull(environment)
        val session = requireNotNull(recSession)
        val input = preprocessRecognition(bitmap)
        val tensor = OnnxTensor.createTensor(
            env,
            FloatBuffer.wrap(input),
            longArrayOf(1, 3, modelSpec.recInputHeight.toLong(), modelSpec.recInputWidth.toLong()),
        )
        tensor.use { onnxTensor ->
            session.run(mapOf(session.inputNames.first() to onnxTensor)).use { result ->
                val output = result[0].value as Array<Array<FloatArray>>
                return decodeCtc(output[0])
            }
        }
    }

    private fun preprocessDetection(bitmap: Bitmap, transform: OcrImageTransform): FloatArray {
        val target = Bitmap.createBitmap(modelSpec.detInputWidth, modelSpec.detInputHeight, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(target)
        canvas.drawColor(Color.WHITE)
        val matrix = Matrix().apply {
            postScale(transform.scale, transform.scale)
            postTranslate(transform.padX, transform.padY)
        }
        canvas.drawBitmap(bitmap, matrix, Paint(Paint.FILTER_BITMAP_FLAG))
        return target.toBgrChw(mean = DET_MEAN, std = DET_STD).also { target.recycle() }
    }

    private fun preprocessRecognition(bitmap: Bitmap): FloatArray {
        val scale = minOf(modelSpec.recInputWidth.toFloat() / bitmap.width, modelSpec.recInputHeight.toFloat() / bitmap.height)
        val target = Bitmap.createBitmap(modelSpec.recInputWidth, modelSpec.recInputHeight, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(target)
        canvas.drawColor(Color.WHITE)
        val matrix = Matrix().apply { postScale(scale, scale) }
        canvas.drawBitmap(bitmap, matrix, Paint(Paint.FILTER_BITMAP_FLAG))
        return target.toBgrChw(mean = REC_MEAN, std = REC_STD).also { target.recycle() }
    }

    private fun Bitmap.toBgrChw(mean: FloatArray, std: FloatArray): FloatArray {
        val pixels = IntArray(width * height)
        getPixels(pixels, 0, width, 0, 0, width, height)
        val output = FloatArray(3 * width * height)
        val plane = width * height
        pixels.forEachIndexed { index, color ->
            val r = Color.red(color) / 255f
            val g = Color.green(color) / 255f
            val b = Color.blue(color) / 255f
            output[index] = (b - mean[0]) / std[0]
            output[plane + index] = (g - mean[1]) / std[1]
            output[plane * 2 + index] = (r - mean[2]) / std[2]
        }
        return output
    }

    private fun connectedBoxes(probability: Array<FloatArray>, transform: OcrImageTransform): List<DetectedBox> {
        val height = probability.size
        val width = probability.firstOrNull()?.size ?: return emptyList()
        val visited = BooleanArray(width * height)
        val boxes = mutableListOf<DetectedBox>()
        val queueX = IntArray(width * height)
        val queueY = IntArray(width * height)
        for (y in 0 until height) {
            for (x in 0 until width) {
                val offset = y * width + x
                if (visited[offset] || probability[y][x] < DET_THRESHOLD) continue
                var head = 0
                var tail = 0
                var minX = x
                var maxX = x
                var minY = y
                var maxY = y
                var score = 0f
                var area = 0
                queueX[tail] = x
                queueY[tail] = y
                tail += 1
                visited[offset] = true
                while (head < tail) {
                    val cx = queueX[head]
                    val cy = queueY[head]
                    head += 1
                    area += 1
                    score += probability[cy][cx]
                    minX = min(minX, cx)
                    maxX = max(maxX, cx)
                    minY = min(minY, cy)
                    maxY = max(maxY, cy)
                    for (ny in cy - 1..cy + 1) {
                        for (nx in cx - 1..cx + 1) {
                            if (nx !in 0 until width || ny !in 0 until height) continue
                            val nextOffset = ny * width + nx
                            if (visited[nextOffset] || probability[ny][nx] < DET_THRESHOLD) continue
                            visited[nextOffset] = true
                            queueX[tail] = nx
                            queueY[tail] = ny
                            tail += 1
                        }
                    }
                }
                val average = score / area.coerceAtLeast(1)
                if (area < MIN_DET_AREA || average < BOX_THRESHOLD) continue
                boxes += toDetectedBox(minX, minY, maxX, maxY, transform)
            }
        }
        return boxes.sortedWith(compareBy({ it.rect.top }, { it.rect.left })).take(MAX_BOXES)
    }

    private fun toDetectedBox(minX: Int, minY: Int, maxX: Int, maxY: Int, transform: OcrImageTransform): DetectedBox {
        val leftTop = transform.toOriginal(OcrPoint(minX.toFloat(), minY.toFloat()))
        val rightBottom = transform.toOriginal(OcrPoint((maxX + 1).toFloat(), (maxY + 1).toFloat()))
        val rect = OcrRect(
            left = min(leftTop.x, rightBottom.x),
            top = min(leftTop.y, rightBottom.y),
            right = max(leftTop.x, rightBottom.x),
            bottom = max(leftTop.y, rightBottom.y),
        )
        val points = listOf(
            OcrPoint(rect.left, rect.top),
            OcrPoint(rect.right, rect.top),
            OcrPoint(rect.right, rect.bottom),
            OcrPoint(rect.left, rect.bottom),
        )
        return DetectedBox(rect, points)
    }

    private fun decodeCtc(sequence: Array<FloatArray>): Recognition {
        var previous = 0
        var confidenceSum = 0f
        var confidenceCount = 0
        val text = buildString {
            sequence.forEach { timestep ->
                var bestIndex = 0
                var bestScore = Float.NEGATIVE_INFINITY
                timestep.forEachIndexed { index, value ->
                    if (value > bestScore) {
                        bestScore = value
                        bestIndex = index
                    }
                }
                if (bestIndex != 0 && bestIndex != previous && bestIndex < dictionary.size) {
                    append(dictionary[bestIndex])
                    confidenceSum += bestScore
                    confidenceCount += 1
                }
                previous = bestIndex
            }
        }
        return Recognition(
            text = text,
            confidence = if (confidenceCount == 0) null else confidenceSum / confidenceCount,
        )
    }

    private fun crop(bitmap: Bitmap, rect: OcrRect): Bitmap? {
        val left = rect.left.toInt().coerceIn(0, bitmap.width - 1)
        val top = rect.top.toInt().coerceIn(0, bitmap.height - 1)
        val right = rect.right.toInt().coerceIn(left + 1, bitmap.width)
        val bottom = rect.bottom.toInt().coerceIn(top + 1, bitmap.height)
        if (right - left < 2 || bottom - top < 2) return null
        return Bitmap.createBitmap(bitmap, left, top, right - left, bottom - top)
    }

    private fun decodeRotatedBitmap(file: File): Bitmap {
        val bitmap = BitmapFactory.decodeFile(file.absolutePath)
            ?: throw BusinessException("OCR_IMAGE_DECODE_FAILED", "无法解码图片")
        val orientation = runCatching { ExifInterface(file.absolutePath).getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL) }
            .getOrDefault(ExifInterface.ORIENTATION_NORMAL)
        val degrees = when (orientation) {
            ExifInterface.ORIENTATION_ROTATE_90 -> 90f
            ExifInterface.ORIENTATION_ROTATE_180 -> 180f
            ExifInterface.ORIENTATION_ROTATE_270 -> 270f
            else -> 0f
        }
        if (degrees == 0f) return bitmap
        return Bitmap.createBitmap(bitmap, 0, 0, bitmap.width, bitmap.height, Matrix().apply { postRotate(degrees) }, true)
            .also { bitmap.recycle() }
    }

    private data class DetectedBox(val rect: OcrRect, val points: List<OcrPoint>)
    private data class Recognition(val text: String, val confidence: Float?)

    companion object {
        private const val TAG = "OfflineOcr"
        private const val DET_THRESHOLD = 0.30f
        private const val BOX_THRESHOLD = 0.45f
        private const val MIN_DET_AREA = 16
        private const val MAX_BOXES = 80
        private val DET_MEAN = floatArrayOf(0.485f, 0.456f, 0.406f)
        private val DET_STD = floatArrayOf(0.229f, 0.224f, 0.225f)
        private val REC_MEAN = floatArrayOf(0.5f, 0.5f, 0.5f)
        private val REC_STD = floatArrayOf(0.5f, 0.5f, 0.5f)
    }
}
