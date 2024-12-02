#include <jni.h>
#include <cstdlib>
#include <sys/sysinfo.h>
#include <string>
#include <thread>
#include <unordered_map>
#include "llama.h"
#include "fllama.hpp"
#include "ggml.h"
#include "utils.h"

#define UNUSED(x) (void)(x)

#ifdef LOGGING_ENABLED
#include <android/log.h>
#define TAG "FLLAMA_ANDROID_JNI"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, TAG, __VA_ARGS__)
#else
#define LOGI(...) // Do nothing
#endif

extern "C" {
std::unordered_map<long, fllama::fllama_context *> context_map;

struct callback_context {
    JNIEnv *env;
    fllama::fllama_context *llama;
    jobject callback;
};

inline jobject tokenProbsToMap(
        JNIEnv *env,
        fllama::fllama_context *llama,
        std::vector<fllama::completion_token_output> probs
) {
    jobjectArray result = futils::createHashMapArray(env, probs.size());
    LOGI("Probs size: %zu", probs.size());
    for (size_t i = 0; i < probs.size(); ++i) {
        jobjectArray probsForToken = futils::createHashMapArray(env, probs.size());
        for (size_t pi = 0; pi < probs[i].probs.size(); ++pi) {
            std::string tokStr = fllama::tokens_to_output_formatted_string(llama->ctx,
                                                                           probs[i].probs[pi].tok);
            auto probResult = futils::createMap(env);
            futils::putString(env, probResult, "tok_str", tokStr.c_str());
            futils::putDouble(env, probResult, "prob", probs[i].probs[pi].prob);
            futils::putHashMapArray(env, probsForToken, probResult, pi);
        }
        std::string tokStr = fllama::tokens_to_output_formatted_string(llama->ctx, probs[i].tok);
        auto tokenResult = futils::createMap(env);
        futils::putString(env, tokenResult, "content", tokStr.c_str());
        futils::putArray(env, tokenResult, "probs", probsForToken);
        futils::putHashMapArray(env, result, tokenResult, i);
    }
    return result;
}

JNIEXPORT jlong JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_initLlamaContext(JNIEnv *env, jobject thiz,
                                                                 jstring model,
                                                                 jboolean lora_init_without_apply,
                                                                 jint n_ctx, jint n_batch,
                                                                 jint n_threads, jint n_gpu_layers,
                                                                 jboolean use_mlock,
                                                                 jboolean use_mmap,
                                                                 jstring lora, jfloat lora_scaled,
                                                                 jfloat rope_freq_base,
                                                                 jfloat rope_freq_scale,
                                                                 jobject load_progress_callback) {
    UNUSED(thiz);

    common_params defaultParams;

    const char *model_path_chars = env->GetStringUTFChars(model, nullptr);
    defaultParams.model = model_path_chars;

    defaultParams.n_ctx = n_ctx;
    defaultParams.n_batch = n_batch;

    int max_threads = std::thread::hardware_concurrency();
    // Use 2 threads by default on 4-core devices, 4 threads on more cores
    int default_n_threads = max_threads == 4 ? 2 : std::min(4, max_threads);
    defaultParams.cpuparams.n_threads = n_threads > 0 ? n_threads : default_n_threads;

    defaultParams.n_gpu_layers = n_gpu_layers;

    defaultParams.use_mlock = use_mlock;
    defaultParams.use_mmap = use_mmap;

    defaultParams.lora_init_without_apply = lora_init_without_apply;
    const char *lora_chars = env->GetStringUTFChars(lora, nullptr);
    if (lora_chars != nullptr && lora_chars[0] != '\0') {
        defaultParams.lora_adapters.push_back({lora_chars, lora_scaled});
        defaultParams.use_mmap = false;
    }

    defaultParams.rope_freq_base = rope_freq_base;
    defaultParams.rope_freq_scale = rope_freq_scale;

    auto llama = new fllama::fllama_context();

    if (load_progress_callback != nullptr) {
        defaultParams.progress_callback = [](float progress, void * user_data) {
            callback_context *cb_ctx = (callback_context *)user_data;
            JNIEnv *env = cb_ctx->env;
            auto llama = cb_ctx->llama;
            jobject callback = cb_ctx->callback;
            int percentage = (int) (100 * progress);
            if (percentage > llama->loading_progress) {
                llama->loading_progress = percentage;
                jclass callback_class = env->GetObjectClass(callback);
                jmethodID onLoadProgress = env->GetMethodID(callback_class, "onLoadProgress", "(I)V");
                env->CallVoidMethod(callback, onLoadProgress, percentage);
            }
            return !llama->is_load_interrupted;
        };
        callback_context *cb_ctx = new callback_context;
        cb_ctx->env = env;
        cb_ctx->llama = llama;
        cb_ctx->callback = env->NewGlobalRef(load_progress_callback);
        defaultParams.progress_callback_user_data = cb_ctx;
    }

    bool is_model_loaded = llama->loadModel(defaultParams);

    LOGI("[FLlama] is_model_loaded %s", (is_model_loaded ? "true" : "false"));
    if (is_model_loaded) {
        context_map[(long) llama->ctx] = llama;
    } else {
        llama_free(llama->ctx);
    }

    env->ReleaseStringUTFChars(model, model_path_chars);
    env->ReleaseStringUTFChars(lora, lora_chars);

    return reinterpret_cast<jlong>(llama->ctx);
}

JNIEXPORT jobject JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_loadModelDetails(JNIEnv *env, jobject thiz,
                                                                 jlong context_ptr) {
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];

    int count = llama_model_meta_count(llama->model);
    auto meta = futils::createMap(env);
    for (int i = 0; i < count; i++) {
        char key[256];
        llama_model_meta_key_by_index(llama->model, i, key, sizeof(key));
        char val[2048];
        llama_model_meta_val_str_by_index(llama->model, i, val, sizeof(val));

        futils::putString(env, meta, key, val);
    }

    auto result = futils::createMap(env);

    char desc[1024];
    llama_model_desc(llama->model, desc, sizeof(desc));
    futils::putString(env, result, "desc", desc);
    futils::putDouble(env, result, "size", llama_model_size(llama->model));
    futils::putDouble(env, result, "nParams", llama_model_n_params(llama->model));
    futils::putBoolean(env, result, "isChatTemplateSupported", llama->validateModelChatTemplate());
    futils::putMap(env, result, "metadata", meta);

    return reinterpret_cast<jobject>(result);
}

JNIEXPORT jstring JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_getFormattedChat(JNIEnv *env, jobject thiz,
                                                                 jlong context_ptr,
                                                                 jobjectArray messages,
                                                                 jstring chat_template) {
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];

    std::vector<common_chat_msg> chat;

    int messages_len = env->GetArrayLength(messages);
    for (int i = 0; i < messages_len; i++) {
        jobject msg = env->GetObjectArrayElement(messages, i);
        jclass hashMapClass = env->FindClass("java/util/HashMap");
        jmethodID getMethod = env->GetMethodID(hashMapClass, "get",
                                               "(Ljava/lang/Object;)Ljava/lang/Object;");

        jstring roleKey = env->NewStringUTF("role");
        jstring contentKey = env->NewStringUTF("content");

        jstring role_str = (jstring) env->CallObjectMethod(msg, getMethod, roleKey);
        jstring content_str = (jstring) env->CallObjectMethod(msg, getMethod, contentKey);

        const char *role = env->GetStringUTFChars(role_str, nullptr);
        const char *content = env->GetStringUTFChars(content_str, nullptr);

        chat.push_back({role, content});

        env->ReleaseStringUTFChars(role_str, role);
        env->ReleaseStringUTFChars(content_str, content);
    }

    const char *tmpl_chars = env->GetStringUTFChars(chat_template, nullptr);
    std::string formatted_chat = common_chat_apply_template(llama->model, tmpl_chars, chat, true);

    return env->NewStringUTF(formatted_chat.c_str());
}

JNIEXPORT jobject JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_loadSession(JNIEnv *env, jobject thiz,
                                                            jlong context_ptr, jstring path) {
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];
    const char *path_chars = env->GetStringUTFChars(path, nullptr);

    jobject result = futils::createMap(env);

    size_t n_token_count_out = 0;
    llama->embd.resize(llama->params.n_ctx);
    if (!llama_state_load_file(llama->ctx, path_chars, llama->embd.data(), llama->embd.capacity(),
                               &n_token_count_out)) {
        futils::putString(env, result, "error", "Failed to initialize sampling");
        env->ReleaseStringUTFChars(path, path_chars);
        return reinterpret_cast<jobject>(result);
    }
    llama->embd.resize(n_token_count_out);
    env->ReleaseStringUTFChars(path, path_chars);

    const std::string text = fllama::tokens_to_str(llama->ctx, llama->embd.cbegin(),
                                                   llama->embd.cend());

    futils::putInt(env, result, "tokens_loaded", n_token_count_out);
    futils::putString(env, result, "prompt", text.c_str());

    return reinterpret_cast<jobject>(result);
}

JNIEXPORT jint JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_saveSession(JNIEnv *env, jobject thiz,
                                                            jlong context_ptr, jstring path,
                                                            jint size) {
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];

    const char *path_chars = env->GetStringUTFChars(path, nullptr);

    std::vector<llama_token> session_tokens = llama->embd;
    int default_size = session_tokens.size();
    int save_size = size > 0 && size <= default_size ? size : default_size;
    if (!llama_state_save_file(llama->ctx, path_chars, session_tokens.data(), save_size)) {
        env->ReleaseStringUTFChars(path, path_chars);
        return -1;
    }

    env->ReleaseStringUTFChars(path, path_chars);
    return session_tokens.size();
}

JNIEXPORT jobject JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_startCompletion(JNIEnv *env, jobject thiz,
                                                             jlong context_ptr, jstring prompt,
                                                             jstring grammar, jfloat temperature,
                                                             jint n_threads, jint n_predict,
                                                             jint n_probs, jint penalty_last_n,
                                                             jfloat penalty_repeat,
                                                             jfloat penalty_freq,
                                                             jfloat penalty_present,
                                                             jfloat mirostat, jfloat mirostat_tau,
                                                             jfloat mirostat_eta,
                                                             jboolean penalize_nl, jint top_k,
                                                             jfloat top_p, jfloat min_p,
                                                             jfloat typical_p,
                                                             jfloat xtc_threshold,
                                                             jfloat xtc_probability,
                                                             jint seed, jobjectArray stop,
                                                             jboolean ignore_eos,
                                                             jobjectArray logit_bias,
                                                             jobject completion_callback) {
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];
    llama->rewind();

    llama_perf_context_reset(llama->ctx);

    llama->params.prompt = env->GetStringUTFChars(prompt, nullptr);
    llama->params.sampling.seed = seed;

    int max_threads = std::thread::hardware_concurrency();
    // Use 3 threads by default on 4-core devices, 4 threads on more cores
    int default_n_threads = max_threads == 4 ? 3 : std::min(4, max_threads);
    llama->params.cpuparams.n_threads = n_threads > 0 ? n_threads : default_n_threads;

    llama->params.n_predict = n_predict;
    llama->params.sampling.ignore_eos = ignore_eos;

    auto &sampling = llama->params.sampling;
    sampling.temp = temperature;
    sampling.penalty_last_n = penalty_last_n;
    sampling.penalty_repeat = penalty_repeat;
    sampling.penalty_freq = penalty_freq;
    sampling.penalty_present = penalty_present;
    sampling.mirostat = mirostat;
    sampling.mirostat_tau = mirostat_tau;
    sampling.mirostat_eta = mirostat_eta;
    sampling.penalize_nl = penalize_nl;
    sampling.top_k = top_k;
    sampling.top_p = top_p;
    sampling.min_p = min_p;
    sampling.typ_p = typical_p;
    sampling.xtc_threshold = xtc_threshold;
    sampling.xtc_probability = xtc_probability;
    sampling.n_probs = n_probs;
    sampling.grammar = env->GetStringUTFChars(grammar, nullptr);
    sampling.logit_bias.clear();
    if (ignore_eos) {
        sampling.logit_bias.push_back({llama_token_eos(llama->model), -INFINITY});
    }

    const int n_vocab = llama_n_vocab(llama_get_model(llama->ctx));
    jsize logit_bias_len = env->GetArrayLength(logit_bias);
    for (jsize i = 0; i < logit_bias_len; i++) {
        jdoubleArray el = (jdoubleArray) env->GetObjectArrayElement(logit_bias, i);
        if (el && env->GetArrayLength(el) == 2) {
            jdouble *doubleArray = env->GetDoubleArrayElements(el, 0);

            llama_token tok = static_cast<llama_token>(doubleArray[0]);
            if (tok >= 0 && tok < n_vocab) {
                if (doubleArray[1] != 0) {  // If the second element is not false (0)
                    sampling.logit_bias.push_back({tok, 1.0f});
                } else {
                    sampling.logit_bias.push_back({tok, -INFINITY});
                }
            }

            env->ReleaseDoubleArrayElements(el, doubleArray, 0);
        }
        env->DeleteLocalRef(el);
    }
    llama->params.antiprompt.clear();
    int stop_len = env->GetArrayLength(stop);
    for (int i = 0; i < stop_len; i++) {
        jstring stop_str = (jstring) env->GetObjectArrayElement(stop, i);
        const char *stop_chars = env->GetStringUTFChars(stop_str, nullptr);
        llama->params.antiprompt.push_back(stop_chars);
        env->ReleaseStringUTFChars(stop_str, stop_chars);
    }
    jobject result = futils::createMap(env);
    if (!llama->initSampling()) {
        futils::putString(env, result, "error", "Failed to initialize sampling");
        return reinterpret_cast<jobject>(result);
    }
    llama->beginCompletion();
    llama->loadPrompt();

    size_t sent_count = 0;
    size_t sent_token_probs_index = 0;
    while (llama->has_next_token && !llama->is_interrupted) {
        const fllama::completion_token_output token_with_probs = llama->doCompletion();
        if (token_with_probs.tok == -1 || llama->incomplete) {
            continue;
        }
        const std::string token_text = common_token_to_piece(llama->ctx, token_with_probs.tok);

        size_t pos = std::min(sent_count, llama->generated_text.size());

        const std::string str_test = llama->generated_text.substr(pos);
        bool is_stop_full = false;
        size_t stop_pos =
                llama->findStoppingStrings(str_test, token_text.size(), fllama::STOP_FULL);
        if (stop_pos != std::string::npos) {
            is_stop_full = true;
            llama->generated_text.erase(
                    llama->generated_text.begin() + pos + stop_pos,
                    llama->generated_text.end());
            pos = std::min(sent_count, llama->generated_text.size());
        } else {
            is_stop_full = false;
            stop_pos = llama->findStoppingStrings(str_test, token_text.size(),
                                                  fllama::STOP_PARTIAL);
        }
        if (
                stop_pos == std::string::npos ||
                // Send rest of the text if we are at the end of the generation
                (!llama->has_next_token && !is_stop_full && stop_pos > 0)
                ) {
            const std::string to_send = llama->generated_text.substr(pos, std::string::npos);

            sent_count += to_send.size();

            std::vector<fllama::completion_token_output> probs_output = {};
            jobject tokenResult = futils::createMap(env);
            futils::putString(env, tokenResult, "token", to_send.c_str());

            if (llama->params.sampling.n_probs > 0) {
                const std::vector<llama_token> to_send_toks = common_tokenize(llama->ctx, to_send,
                                                                             false);
                size_t probs_pos = std::min(sent_token_probs_index,
                                            llama->generated_token_probs.size());
                size_t probs_stop_pos = std::min(sent_token_probs_index + to_send_toks.size(),
                                                 llama->generated_token_probs.size());
                if (probs_pos < probs_stop_pos) {
                    probs_output = std::vector<fllama::completion_token_output>(
                            llama->generated_token_probs.begin() + probs_pos,
                            llama->generated_token_probs.begin() + probs_stop_pos);
                }
                sent_token_probs_index = probs_stop_pos;

                futils::putArray(env, tokenResult, "completion_probabilities",
                                 tokenProbsToMap(env, llama, probs_output));
            }
            if(completion_callback!=nullptr){
                jclass cb_class = env->GetObjectClass(completion_callback);
                jmethodID onPartialCompletion = env->GetMethodID(cb_class, "onPartialCompletion",
                                                                 "(Ljava/util/HashMap;)V");
                env->CallVoidMethod(completion_callback, onPartialCompletion, tokenResult);
            }
        }
    }
    llama_perf_context_print(llama->ctx);
    llama->is_predicting = false;

    futils::putString(env, result, "text", llama->generated_text.c_str());
    futils::putArray(env, result, "completion_probabilities",
                     tokenProbsToMap(env, llama, llama->generated_token_probs));
    futils::putInt(env, result, "tokens_predicted", llama->num_tokens_predicted);
    futils::putInt(env, result, "tokens_evaluated", llama->num_prompt_tokens);
    futils::putInt(env, result, "truncated", llama->truncated);
    futils::putInt(env, result, "stopped_eos", llama->stopped_eos);
    futils::putInt(env, result, "stopped_word", llama->stopped_word);
    futils::putInt(env, result, "stopped_limit", llama->stopped_limit);
    futils::putString(env, result, "stopping_word", llama->stopping_word.c_str());
    futils::putInt(env, result, "tokens_cached", llama->n_past);
    return reinterpret_cast<jobject>(result);
}

JNIEXPORT void JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_abortCompletion(JNIEnv *env, jobject thiz,
                                                               jlong context_ptr) {
    UNUSED(env);
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];
    llama->is_interrupted = true;
}

JNIEXPORT jboolean JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_isPredicting(JNIEnv *env, jobject thiz,
                                                             jlong context_ptr) {
    UNUSED(env);
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];
    return llama->is_predicting;
}

JNIEXPORT jintArray JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_tokenize(JNIEnv *env, jobject thiz,
                                                         jlong context_ptr, jstring text) {
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];

    const char *text_chars = env->GetStringUTFChars(text, nullptr);

    const std::vector<llama_token> toks = common_tokenize(
            llama->ctx,
            text_chars,
            false
    );
    jintArray result = env->NewIntArray(toks.size());
    if (result != nullptr) {
        jint *arrayElements = env->GetIntArrayElements(result, nullptr);
        for (size_t i = 0; i < toks.size(); ++i) {
            arrayElements[i] = toks[i];
        }
        env->ReleaseIntArrayElements(result, arrayElements, 0);  // 释放本地数组
    }
    env->ReleaseStringUTFChars(text, text_chars);
    return result;
}

JNIEXPORT jstring JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_detokenize(JNIEnv *env, jobject thiz,
                                                           jlong context_ptr, jintArray tokens) {
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];

    jsize tokens_len = env->GetArrayLength(tokens);
    jint *tokens_ptr = env->GetIntArrayElements(tokens, 0);
    std::vector<llama_token> toks;
    for (int i = 0; i < tokens_len; i++) {
        toks.push_back(tokens_ptr[i]);
    }

    auto text = fllama::tokens_to_str(llama->ctx, toks.cbegin(), toks.cend());

    env->ReleaseIntArrayElements(tokens, tokens_ptr, 0);

    return env->NewStringUTF(text.c_str());
}

JNIEXPORT jboolean JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_isEmbeddingEnabled(JNIEnv *env, jobject thiz,
                                                                   jlong context_ptr) {
    UNUSED(env);
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];
    return llama->params.embedding;
}

JNIEXPORT jstring JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_bench(JNIEnv *env, jobject thiz, jlong context_ptr,
                                                      jint pp, jint tg, jint pl, jint nr) {
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];
    std::string result = llama->bench(pp, tg, pl, nr);
    return env->NewStringUTF(result.c_str());
}

JNIEXPORT void JNICALL
Java_ink_xcl_fllama_LlamaContext_00024Companion_freeLlamaContext(JNIEnv *env, jobject thiz,
                                                                 jlong context_ptr) {
    UNUSED(env);
    UNUSED(thiz);
    auto llama = context_map[(long) context_ptr];
    if (llama->model) {
        llama_free_model(llama->model);
    }
    if (llama->ctx) {
        llama_free(llama->ctx);
    }
    if (llama->ctx_sampling != nullptr) {
        common_sampler_free(llama->ctx_sampling);
    }
    context_map.erase((long) llama->ctx);
}
}