package com.wulisu.suspect.interrogation.asr

import kotlin.math.exp

object AsrConfidence {
    fun fromLogProbabilities(values: FloatArray): Double? {
        val finite = values.filter { it.isFinite() }
        if (finite.isEmpty()) return null
        return exp(finite.average()).coerceIn(0.0, 1.0)
    }
}
