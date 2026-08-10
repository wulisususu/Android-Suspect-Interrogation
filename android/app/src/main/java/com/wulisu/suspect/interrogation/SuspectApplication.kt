package com.wulisu.suspect.interrogation

import android.app.Application

class SuspectApplication : Application() {
    val container: AppContainer by lazy { AppContainer(this) }
}
