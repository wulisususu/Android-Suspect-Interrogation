#include <jni.h>
#include <android/log.h>

#include <atomic>
#include <condition_variable>
#include <cstdint>
#include <cstring>
#include <mutex>
#include <string>

#include "rkllm.h"

namespace {

constexpr const char* kTag = "OfflineRKLLM";

struct NativeEngine {
    JavaVM* vm = nullptr;
    jobject callback = nullptr;
    jmethodID callback_method = nullptr;
    LLMHandle handle = nullptr;
    std::mutex mutex;
    std::condition_variable stopped;
    bool running = false;
    bool destroying = false;
};

class UtfChars {
public:
    UtfChars(JNIEnv* env, jstring value) : env_(env), value_(value), chars_(env->GetStringUTFChars(value, nullptr)) {}
    ~UtfChars() {
        if (chars_ != nullptr) env_->ReleaseStringUTFChars(value_, chars_);
    }
    const char* get() const { return chars_; }

private:
    JNIEnv* env_;
    jstring value_;
    const char* chars_;
};

void throw_illegal_state(JNIEnv* env, const std::string& message) {
    jclass exception_class = env->FindClass("java/lang/IllegalStateException");
    if (exception_class != nullptr) env->ThrowNew(exception_class, message.c_str());
}

int result_callback(RKLLMResult* result, void* userdata, LLMCallState state) {
    auto* engine = static_cast<NativeEngine*>(userdata);
    if (engine == nullptr || engine->vm == nullptr || engine->callback == nullptr) return 0;

    JNIEnv* env = nullptr;
    bool attached = false;
    const jint env_status = engine->vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6);
    if (env_status == JNI_EDETACHED) {
        if (engine->vm->AttachCurrentThread(&env, nullptr) != JNI_OK) return 0;
        attached = true;
    } else if (env_status != JNI_OK) {
        return 0;
    }

    const char* text = result != nullptr && result->text != nullptr ? result->text : "";
    const jint token_id = result != nullptr ? result->token_id : -1;
    jstring java_text = env->NewStringUTF(text);
    if (java_text != nullptr) {
        env->CallVoidMethod(engine->callback, engine->callback_method, java_text, token_id, static_cast<jint>(state));
        env->DeleteLocalRef(java_text);
    }
    if (env->ExceptionCheck()) {
        __android_log_print(ANDROID_LOG_ERROR, kTag, "Kotlin callback raised an exception");
        env->ExceptionClear();
    }
    if (attached) engine->vm->DetachCurrentThread();
    return 0;
}

NativeEngine* from_handle(jlong handle) {
    return reinterpret_cast<NativeEngine*>(static_cast<intptr_t>(handle));
}

}  // namespace

extern "C" JNIEXPORT jlong JNICALL
Java_com_wulisu_suspect_interrogation_llm_RkllmNative_nativeCreate(
    JNIEnv* env,
    jobject,
    jstring model_path,
    jint max_context_len,
    jint max_new_tokens,
    jobject callback) {
    auto* engine = new NativeEngine();
    if (env->GetJavaVM(&engine->vm) != JNI_OK) {
        delete engine;
        throw_illegal_state(env, "GetJavaVM failed");
        return 0;
    }
    engine->callback = env->NewGlobalRef(callback);
    jclass callback_class = env->GetObjectClass(callback);
    engine->callback_method = env->GetMethodID(callback_class, "onNativeFragment", "(Ljava/lang/String;II)V");
    env->DeleteLocalRef(callback_class);
    if (engine->callback == nullptr || engine->callback_method == nullptr) {
        if (engine->callback != nullptr) env->DeleteGlobalRef(engine->callback);
        delete engine;
        throw_illegal_state(env, "RKLLM callback method not found");
        return 0;
    }

    UtfChars path(env, model_path);
    if (path.get() == nullptr) {
        env->DeleteGlobalRef(engine->callback);
        delete engine;
        throw_illegal_state(env, "Model path is unavailable");
        return 0;
    }

    RKLLMParam param = rkllm_createDefaultParam();
    param.model_path = path.get();
    param.max_context_len = max_context_len;
    param.max_new_tokens = max_new_tokens;
    param.top_k = 1;
    param.top_p = 0.95F;
    param.temperature = 0.8F;
    param.repeat_penalty = 1.1F;
    param.frequency_penalty = 0.0F;
    param.presence_penalty = 0.0F;
    param.skip_special_token = true;
    param.ignore_eos_token = false;
    param.is_async = false;
    param.extend_param.base_domain_id = 0;
    param.extend_param.embed_flash = 1;

    RKLLMCallback callbacks{};
    callbacks.result_callback = result_callback;
    callbacks.result_userdata = engine;
    const int result = rkllm_init(&engine->handle, &param, &callbacks);
    if (result != 0 || engine->handle == nullptr) {
        env->DeleteGlobalRef(engine->callback);
        delete engine;
        throw_illegal_state(env, "rkllm_init failed: " + std::to_string(result));
        return 0;
    }
    return static_cast<jlong>(reinterpret_cast<intptr_t>(engine));
}

extern "C" JNIEXPORT jint JNICALL
Java_com_wulisu_suspect_interrogation_llm_RkllmNative_nativeRun(
    JNIEnv* env,
    jobject,
    jlong native_handle,
    jstring prompt,
    jstring role,
    jint max_new_tokens) {
    NativeEngine* engine = from_handle(native_handle);
    if (engine == nullptr) return -1;
    {
        std::lock_guard<std::mutex> lock(engine->mutex);
        if (engine->destroying || engine->handle == nullptr || engine->running) return -2;
        engine->running = true;
    }

    UtfChars prompt_chars(env, prompt);
    UtfChars role_chars(env, role);
    int result = -3;
    if (prompt_chars.get() != nullptr && role_chars.get() != nullptr) {
        RKLLMInput input{};
        input.input_type = RKLLM_INPUT_PROMPT;
        input.role = role_chars.get();
        input.prompt_input = prompt_chars.get();
        input.enable_thinking = false;

        RKLLMInferParam infer{};
        infer.mode = RKLLM_INFER_GENERATE;
        infer.keep_history = 0;
        infer.max_new_tokens = max_new_tokens;
        result = rkllm_run(engine->handle, &input, &infer, engine);
    }

    {
        std::lock_guard<std::mutex> lock(engine->mutex);
        engine->running = false;
    }
    engine->stopped.notify_all();
    return result;
}

extern "C" JNIEXPORT jint JNICALL
Java_com_wulisu_suspect_interrogation_llm_RkllmNative_nativeAbort(
    JNIEnv*, jobject, jlong native_handle) {
    NativeEngine* engine = from_handle(native_handle);
    if (engine == nullptr) return 0;
    LLMHandle handle = nullptr;
    bool running = false;
    {
        std::lock_guard<std::mutex> lock(engine->mutex);
        handle = engine->handle;
        running = engine->running;
    }
    return handle != nullptr && running ? rkllm_abort(handle) : 0;
}

extern "C" JNIEXPORT jint JNICALL
Java_com_wulisu_suspect_interrogation_llm_RkllmNative_nativeDestroy(
    JNIEnv* env, jobject, jlong native_handle) {
    NativeEngine* engine = from_handle(native_handle);
    if (engine == nullptr) return 0;

    LLMHandle handle = nullptr;
    bool should_abort = false;
    {
        std::lock_guard<std::mutex> lock(engine->mutex);
        if (engine->destroying) return 0;
        engine->destroying = true;
        handle = engine->handle;
        should_abort = engine->running;
    }
    if (should_abort && handle != nullptr) rkllm_abort(handle);
    {
        std::unique_lock<std::mutex> lock(engine->mutex);
        engine->stopped.wait(lock, [engine] { return !engine->running; });
        handle = engine->handle;
        engine->handle = nullptr;
    }
    const int result = handle != nullptr ? rkllm_destroy(handle) : 0;
    if (engine->callback != nullptr) env->DeleteGlobalRef(engine->callback);
    delete engine;
    return result;
}
