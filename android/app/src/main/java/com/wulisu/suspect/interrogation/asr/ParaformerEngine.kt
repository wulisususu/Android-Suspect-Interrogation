package com.wulisu.suspect.interrogation.asr

import android.content.Context
import com.k2fsa.sherpa.onnx.FeatureConfig
import com.k2fsa.sherpa.onnx.OnlineModelConfig
import com.k2fsa.sherpa.onnx.OnlineParaformerModelConfig
import com.k2fsa.sherpa.onnx.OnlineRecognizerConfig

class ParaformerEngine(context: Context) : SherpaOnlineAsrEngine(
    context = context,
    spec = AsrModelSpecs.PARAFORMER_INT8,
) {
    override fun recognizerConfig() = OnlineRecognizerConfig(
        featConfig = FeatureConfig(sampleRate = 16_000, featureDim = 80),
        modelConfig = OnlineModelConfig(
            paraformer = OnlineParaformerModelConfig(
                encoder = spec.encoder,
                decoder = spec.decoder,
            ),
            tokens = spec.tokens,
            numThreads = 4,
            debug = true,
            provider = "cpu",
            modelType = "paraformer",
        ),
        endpointConfig = defaultEndpointConfig(),
        enableEndpoint = true,
        decodingMethod = "greedy_search",
        maxActivePaths = 4,
    )
}

