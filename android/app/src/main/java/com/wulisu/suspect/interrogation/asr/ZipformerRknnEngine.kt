package com.wulisu.suspect.interrogation.asr

import android.content.Context
import com.k2fsa.sherpa.onnx.EndpointConfig
import com.k2fsa.sherpa.onnx.EndpointRule
import com.k2fsa.sherpa.onnx.FeatureConfig
import com.k2fsa.sherpa.onnx.OnlineModelConfig
import com.k2fsa.sherpa.onnx.OnlineRecognizerConfig
import com.k2fsa.sherpa.onnx.OnlineTransducerModelConfig

class ZipformerRknnEngine(context: Context) : SherpaOnlineAsrEngine(
    context = context,
    spec = AsrModelSpecs.ZIPFORMER_RK3576,
) {
    override fun recognizerConfig() = OnlineRecognizerConfig(
        featConfig = FeatureConfig(sampleRate = 16_000, featureDim = 80),
        modelConfig = OnlineModelConfig(
            transducer = OnlineTransducerModelConfig(
                encoder = spec.encoder,
                decoder = spec.decoder,
                joiner = requireNotNull(spec.joiner),
            ),
            tokens = spec.tokens,
            numThreads = spec.numThreads,
            debug = true,
            provider = "rknn",
            modelType = "zipformer",
        ),
        endpointConfig = defaultEndpointConfig(),
        enableEndpoint = true,
        decodingMethod = "greedy_search",
        maxActivePaths = 4,
    )
}

internal fun defaultEndpointConfig() = EndpointConfig(
    rule1 = EndpointRule(false, 2.4f, 0.0f),
    rule2 = EndpointRule(true, 1.2f, 0.0f),
    rule3 = EndpointRule(false, 0.0f, 20.0f),
)

