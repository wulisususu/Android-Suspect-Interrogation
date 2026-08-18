package com.wulisu.suspect.interrogation

import android.app.Application
import android.content.pm.ApplicationInfo
import android.webkit.WebView

class SuspectApplication : Application() {
    val container: AppContainer by lazy { AppContainer(this) }

    override fun onCreate() {
        super.onCreate()
        if ((applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) != 0) {
            // Diagnostic: allow chrome://inspect / devtools to drive the WebView.
            WebView.setWebContentsDebuggingEnabled(true)
        }
    }
}
