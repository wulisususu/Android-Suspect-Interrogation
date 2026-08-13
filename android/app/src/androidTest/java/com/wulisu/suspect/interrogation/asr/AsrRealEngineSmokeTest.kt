package com.wulisu.suspect.interrogation.asr

import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class AsrRealEngineSmokeTest {
    @Test
    fun fixedFixtureReachesRealEngine() {
        AsrSmokeHarness.run(ApplicationProvider.getApplicationContext())
    }
}
