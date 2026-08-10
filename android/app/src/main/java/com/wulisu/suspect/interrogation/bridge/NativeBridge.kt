package com.wulisu.suspect.interrogation.bridge

import android.webkit.JavascriptInterface
import android.webkit.WebView
import kotlinx.coroutines.*
import org.json.JSONObject

class NativeBridge(private val webView: WebView, private val router: RpcRouter) {
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    @JavascriptInterface
    fun call(requestJson: String) {
        scope.launch {
            val response = router.handle(requestJson)
            withContext(Dispatchers.Main) {
                val escaped = JSONObject.quote(response)
                webView.evaluateJavascript("window.__nativeBridgeResolve && window.__nativeBridgeResolve($escaped);", null)
            }
        }
    }

    fun close() { scope.cancel() }
}
