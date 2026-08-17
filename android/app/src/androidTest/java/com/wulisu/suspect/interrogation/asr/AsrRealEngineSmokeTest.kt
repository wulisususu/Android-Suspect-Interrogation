package com.wulisu.suspect.interrogation.asr

import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class AsrRealEngineSmokeTest {
    @Test
    fun fixedFixtureReachesParaformerEngine() {
        AsrSmokeHarness.run(ApplicationProvider.getApplicationContext(), AsrModelSpecs.PARAFORMER_INT8)
    }

    @Test
    fun fixedFixtureReachesZipformerRknnEngine() {
        AsrSmokeHarness.run(ApplicationProvider.getApplicationContext(), AsrModelSpecs.ZIPFORMER_RK3576)
    }
}
