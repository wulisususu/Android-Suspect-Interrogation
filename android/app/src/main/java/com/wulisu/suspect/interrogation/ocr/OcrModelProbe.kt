package com.wulisu.suspect.interrogation.ocr

import java.io.File

data class OcrModelCandidate(
    val spec: OcrModelSpec,
    val root: File,
    val complete: Boolean,
    val runtimeReady: Boolean,
    val sizeBytes: Long,
    val modifiedAt: Long,
) {
    val catalogId: String = "OCR:${root.name}/${spec.id}"
}

object OcrModelProbe {
    fun probe(directory: File): List<OcrModelCandidate> {
        if (!directory.exists() || !directory.isDirectory) return emptyList()
        return OcrKnownModels.all.mapNotNull { spec ->
            val present = spec.requiredFiles.map { File(directory, it) }
            if (present.none { it.exists() }) return@mapNotNull null
            val complete = present.all { it.isFile && it.length() > 0L }
            OcrModelCandidate(
                spec = spec,
                root = directory,
                complete = complete,
                runtimeReady = complete && spec.runtimeAvailable,
                sizeBytes = present.filter { it.isFile }.sumOf { it.length() },
                modifiedAt = present.filter { it.exists() }.maxOfOrNull { it.lastModified() } ?: directory.lastModified(),
            )
        }
    }
}
