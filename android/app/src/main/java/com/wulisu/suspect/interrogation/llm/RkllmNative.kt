package com.wulisu.suspect.interrogation.llm

object RkllmNative {
    const val runtimeVersion = RKLLM_RUNTIME_VERSION

    val loadError: Throwable?

    init {
        loadError = runCatching {
            System.loadLibrary("omp")
            System.loadLibrary("rkllmrt")
            System.loadLibrary("rkllm_jni")
        }.exceptionOrNull()
    }

    interface Callback {
        fun onNativeFragment(text: String, tokenId: Int, state: Int)
    }

    fun create(
        modelPath: String,
        maxContextLen: Int,
        maxNewTokens: Int,
        callback: Callback,
    ): Long {
        ensureLoaded()
        return nativeCreate(modelPath, maxContextLen, maxNewTokens, callback)
    }

    fun run(handle: Long, prompt: String, role: String, maxNewTokens: Int): Int {
        ensureLoaded()
        return nativeRun(handle, prompt, role, maxNewTokens)
    }

    fun abort(handle: Long): Int {
        ensureLoaded()
        return nativeAbort(handle)
    }

    fun destroy(handle: Long): Int {
        ensureLoaded()
        return nativeDestroy(handle)
    }

    private fun ensureLoaded() {
        loadError?.let { throw IllegalStateException("RKLLM 1.3.0 native libraries failed to load", it) }
    }

    private external fun nativeCreate(
        modelPath: String,
        maxContextLen: Int,
        maxNewTokens: Int,
        callback: Callback,
    ): Long

    private external fun nativeRun(handle: Long, prompt: String, role: String, maxNewTokens: Int): Int
    private external fun nativeAbort(handle: Long): Int
    private external fun nativeDestroy(handle: Long): Int
}
