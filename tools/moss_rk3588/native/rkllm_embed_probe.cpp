// ABI: airockchip/rknn-llm release-v1.3.0, commit 878f9361fd3afa7e167b7079918918f78d2c1c2a.
#include <cstddef>
#include "rkllm.h"
#include <cmath>
#include <fstream>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <string>
#include <vector>

struct Result { std::string bytes; bool failed = false; bool finished = false; };

static int callback(RKLLMResult* result, void* data, LLMCallState state) {
    auto& output = *static_cast<Result*>(data);
    if (state == RKLLM_RUN_ERROR) output.failed = true;
    if (state == RKLLM_RUN_FINISH) output.finished = true;
    if ((state == RKLLM_RUN_NORMAL || state == RKLLM_RUN_WAITING) && result && result->text)
        output.bytes.append(result->text);
    return 0;
}

static int positive(const std::string& value) {
    size_t consumed = 0;
    int result = std::stoi(value, &consumed);
    if (consumed != value.size() || result <= 0) throw std::runtime_error("Expected positive integer");
    return result;
}

int main(int argc, char** argv) {
    LLMHandle handle = nullptr;
    try {
        std::string model, raw, output;
        int tokens = 0, max_new_tokens = 2048;
        for (int i = 1; i < argc; i += 2) {
            if (i + 1 == argc) throw std::runtime_error("Missing argument value");
            std::string key = argv[i], value = argv[i + 1];
            if (key == "--model") model = value;
            else if (key == "--raw") raw = value;
            else if (key == "--tokens") tokens = positive(value);
            else if (key == "--max-new-tokens") max_new_tokens = positive(value);
            else if (key == "--output") output = value;
            else throw std::runtime_error("Unknown argument: " + key);
        }
        if (model.empty() || raw.empty() || output.empty() || tokens <= 0)
            throw std::runtime_error("Required: --model --raw --tokens --output");
        if (tokens > std::numeric_limits<int>::max() - max_new_tokens)
            throw std::runtime_error("Context size overflow");
        std::ifstream stream(raw, std::ios::binary | std::ios::ate);
        const auto bytes = static_cast<size_t>(tokens) * 1024 * sizeof(float);
        if (!stream || stream.tellg() != static_cast<std::streamoff>(bytes))
            throw std::runtime_error("raw byte size mismatch: expected tokens * 1024 * sizeof(float)");
        std::vector<float> embeds(static_cast<size_t>(tokens) * 1024);
        stream.seekg(0);
        if (!stream.read(reinterpret_cast<char*>(embeds.data()), bytes))
            throw std::runtime_error("Cannot read embedding bytes");
        for (float value : embeds) if (!std::isfinite(value)) throw std::runtime_error("Nonfinite embedding");
        RKLLMParam param = rkllm_createDefaultParam();
        param.model_path = model.c_str();
        param.max_context_len = tokens + max_new_tokens;
        param.max_new_tokens = max_new_tokens;
        param.top_k = 1;
        param.top_p = 1.0f;
        param.temperature = 1.0f;
        param.repeat_penalty = 1.0f;
        param.frequency_penalty = 0.0f;
        param.presence_penalty = 0.0f;
        param.mirostat = 0;
        param.skip_special_token = true;
        param.ignore_eos_token = false;
        param.is_async = false;
        Result result;
        RKLLMCallback callbacks{};
        callbacks.result_callback = callback;
        callbacks.result_userdata = &result;
        int status = rkllm_init(&handle, &param, &callbacks);
        if (status != 0) throw std::runtime_error("rkllm_init failed: " + std::to_string(status));
        // The captured prefill already includes the MOSS chat template and assistant prefix.
        status = rkllm_set_chat_template(handle, "", "", "");
        if (status != 0) throw std::runtime_error("rkllm_set_chat_template failed: " + std::to_string(status));
        RKLLMInput input{};
        input.input_type = RKLLM_INPUT_EMBED;
        input.role = "user";
        input.enable_thinking = false;
        input.embed_input.embed = embeds.data();
        input.embed_input.n_tokens = tokens;
        RKLLMInferParam infer{};
        infer.mode = RKLLM_INFER_GENERATE;
        infer.keep_history = 0;
        infer.max_new_tokens = max_new_tokens;
        status = rkllm_run(handle, &input, &infer, &result);
        const int destroy_status = rkllm_destroy(handle);
        handle = nullptr;
        std::ofstream destination(output, std::ios::binary | std::ios::trunc);
        destination.write(result.bytes.data(), result.bytes.size());
        if (!destination) throw std::runtime_error("Cannot write result");
        if (status != 0 || destroy_status != 0 || result.failed || !result.finished)
            throw std::runtime_error("Native inference failed: run=" + std::to_string(status)
                                     + " destroy=" + std::to_string(destroy_status));
        return 0;
    } catch (const std::exception& error) {
        if (handle) rkllm_destroy(handle);
        std::cerr << error.what() << '\n';
        return 1;
    }
}
