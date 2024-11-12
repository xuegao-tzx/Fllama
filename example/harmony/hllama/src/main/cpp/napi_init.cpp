#include "napi/native_api.h"
#include <hilog/log.h>
#include <string>
#include <thread>
#include "fllama.hpp"
#include "uv.h"

#define NAPI_CALL_RET(call, return_value)                                                                              \
    do {                                                                                                               \
        napi_status status = (call);                                                                                   \
        if (status != napi_ok) {                                                                                       \
            const napi_extended_error_info *error_info = nullptr;                                                      \
            napi_get_last_error_info(env, &error_info);                                                                \
            OH_LOG_ERROR(LOG_APP, "错误信息:%{public}s", error_info->error_message);                                   \
            bool is_pending;                                                                                           \
            napi_is_exception_pending(env, &is_pending);                                                               \
            if (!is_pending) {                                                                                         \
                auto message = error_info->error_message ? error_info->error_message : "null";                         \
                napi_throw_error(env, nullptr, message);                                                               \
                return return_value;                                                                                   \
            }                                                                                                          \
        }                                                                                                              \
    } while (0)

#define NAPI_CALL(call) NAPI_CALL_RET(call, nullptr)
#define UNUSED(x) (void)(x)
#undef LOG_DOMAIN
#undef LOG_TAG
#define LOG_DOMAIN 0x0006 // 全局domain宏，标识业务领域
#define LOG_TAG "NHLlama"

std::unordered_map<long, fllama::fllama_context *> context_map;

bool IsNValueUndefined(napi_env env, napi_value value) {
    napi_valuetype type;
    if (napi_typeof(env, value, &type) == napi_ok && type == napi_undefined) {
        return true;
    }
    return false;
}

static std::string NValueToString(napi_env env, napi_value value, bool maybeUndefined = false) {
    if (maybeUndefined && IsNValueUndefined(env, value)) {
        return "";
    }

    size_t size;
    NAPI_CALL_RET(napi_get_value_string_utf8(env, value, nullptr, 0, &size), "");
    std::string result(size, '\0');
    NAPI_CALL_RET(napi_get_value_string_utf8(env, value, (char *)result.data(), size + 1, nullptr), "");
    return result;
}

static napi_value StringToNValue(napi_env env, const std::string &value) {
    napi_value result;
    napi_create_string_utf8(env, value.data(), value.size(), &result);
    return result;
}

static napi_value NAPIUndefined(napi_env env) {
    napi_value result = nullptr;
    napi_get_undefined(env, &result);
    return result;
}

napi_status SetObjectProperty(napi_env env, napi_value object, const char *key, const char *value) {
    napi_value key_name;
    napi_value value_data;
    napi_status status = napi_create_string_utf8(env, key, NAPI_AUTO_LENGTH, &key_name);
    if (status != napi_ok)
        return status;
    status = napi_create_string_utf8(env, value, NAPI_AUTO_LENGTH, &value_data);
    if (status != napi_ok)
        return status;
    status = napi_set_property(env, object, key_name, value_data);
    return status;
}

/// == == [initLlamaContext] == ==
// 初始化Llama本地推理模型需要异步执行，同步会直接crash
struct initLlamaContext_CBData {
    napi_async_work asyncWork = nullptr;
    napi_deferred deferred = nullptr;
    napi_ref callback = nullptr;
    std::string args = "";
    long result = 0;
};
// 3 定义异步任务的第二个回调函数，该函数在主线程执行，将结果传递给原生
static void initLlamaContext_CCB(napi_env env, napi_status status, void *data) {
    UNUSED(status);
    initLlamaContext_CBData *callbackData = reinterpret_cast<initLlamaContext_CBData *>(data);
    if (callbackData->result > 0) {
        napi_resolve_deferred(env, callbackData->deferred, StringToNValue(env, std::to_string(callbackData->result)));
    } else {
        napi_reject_deferred(env, callbackData->deferred, StringToNValue(env, std::to_string(-1)));
    }
    napi_delete_async_work(env, callbackData->asyncWork);
    delete callbackData;
}
// 2 定义异步任务的第一个回调函数，该函数在工作线程中执行，处理具体的业务逻辑
static void initLlamaContext_ECB(napi_env env, void *data) {
    UNUSED(env);
    initLlamaContext_CBData *callbackData = reinterpret_cast<initLlamaContext_CBData *>(data);

    // 逻辑-开始
    common_params defaultParams;
    OH_LOG_ERROR(LOG_APP, "初始化开始:%{public}s", callbackData->args.c_str());
    defaultParams.model = callbackData->args;

    defaultParams.embedding = false;

    defaultParams.n_ctx = 4096;
    defaultParams.n_batch = 512;

    int max_threads = std::thread::hardware_concurrency();
    // Use 2 threads by default on 4-core devices, 4 threads on more cores
    int default_n_threads = max_threads == 4 ? 2 : std::min(4, max_threads);
    defaultParams.cpuparams.n_threads = default_n_threads;

    defaultParams.n_gpu_layers = 0;

    defaultParams.use_mlock = true;
    defaultParams.use_mmap = true;

    defaultParams.lora_init_without_apply = false;

    auto llama = new fllama::fllama_context();
    bool is_model_loaded = llama->loadModel(defaultParams);
    OH_LOG_ERROR(LOG_APP, "模型加载: %{public}s", (is_model_loaded ? "FLlama true" : "FLlama false"));
    if (is_model_loaded) {
        context_map[(long)llama->ctx] = llama;
    } else {
        llama_free(llama->ctx);
    }

    // 逻辑-结束

    callbackData->result = reinterpret_cast<long>(llama->ctx);
}
// 1 创建异步任务，并使用napi_queue_async_work将异步任务加入队列，等待执行
static napi_value initLlamaContext(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value args[1] = {nullptr};
    NAPI_CALL(napi_get_cb_info(env, info, &argc, args, nullptr, nullptr));
    auto callbackData = new initLlamaContext_CBData();
    auto modelPath = NValueToString(env, args[0]);
    callbackData->args = modelPath;

    napi_value promise = nullptr;
    napi_deferred deferred = nullptr;
    napi_create_promise(env, &deferred, &promise);
    callbackData->deferred = deferred;

    napi_value resourceName = nullptr;
    napi_create_string_utf8(env, "initLlamaContextCallback", NAPI_AUTO_LENGTH, &resourceName);
    napi_create_async_work(env, nullptr, resourceName, initLlamaContext_ECB, initLlamaContext_CCB, callbackData,
                           &callbackData->asyncWork);
    napi_queue_async_work(env, callbackData->asyncWork);
    return promise;
}

/// == == [loadModelDetails] == ==
static napi_value getModelDetail(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value args[1] = {nullptr};
    NAPI_CALL(napi_get_cb_info(env, info, &argc, args, nullptr, nullptr));
    auto contextIdStr = NValueToString(env, args[0]);
    auto contextId = std::stol(contextIdStr);
    auto llama = context_map[(long)contextId];
    char desc[1024];
    llama_model_desc(llama->model, desc, sizeof(desc));

    napi_value object = nullptr;
    napi_create_object(env, &object);
    SetObjectProperty(env, object, "desc", desc);
    SetObjectProperty(env, object, "size", std::to_string(llama_model_size(llama->model)).c_str());
    SetObjectProperty(env, object, "nParams", std::to_string(llama_model_n_params(llama->model)).c_str());
    SetObjectProperty(env, object, "isChatTemplateSupported",
                      std::to_string(llama->validateModelChatTemplate()).c_str());
    return object;
}

/// == == [startCompletion] == ==
// 使用Llama执行本地推理模型需要异步执行，同步会直接crash
struct startCompletion_CBData {
    napi_env env = nullptr;
    napi_async_work asyncWork = nullptr;
    napi_ref callbackRef = nullptr;
    napi_ref realTimeCallbackRef = nullptr;
    std::string args[2] = {""};
    std::string result = "";
    bool hasDone = false;
};
// 3 定义异步任务的第二个回调函数，该函数在主线程执行，将结果传递给原生
static void startCompletion_CCB(napi_env env, napi_status status, void *data) {
    UNUSED(status);
    startCompletion_CBData *callbackData = reinterpret_cast<startCompletion_CBData *>(data);
    napi_value callbackArg[1] = {nullptr};
    napi_create_string_utf8(env, callbackData->result.data(), callbackData->result.size(), &callbackArg[0]);
    napi_value callback = nullptr;
    napi_get_reference_value(env, callbackData->callbackRef, &callback);
    napi_value result;
    napi_value undefined;
    napi_get_undefined(env, &undefined);
    napi_call_function(env, undefined, callback, 1, callbackArg, &result);
    napi_delete_reference(env, callbackData->callbackRef);
    napi_delete_reference(env, callbackData->realTimeCallbackRef);
    napi_delete_async_work(env, callbackData->asyncWork);
    delete callbackData;
}
// 2.5 定义一个回调函数，在非ArkTS线程中回调ArkTS接口，将结果传递给原生
void startCompletion_RT(startCompletion_CBData *context) {
    uv_loop_s *loop = nullptr;
    napi_get_uv_event_loop(context->env, &loop);
    uv_work_t *work = new uv_work_t;
    work->data = context;
    uv_queue_work(
        loop, work,
        [](uv_work_t *work) {},
        [](uv_work_t *work, int status) {
            startCompletion_CBData *context = reinterpret_cast<startCompletion_CBData *>(work->data);
            if (context->hasDone == true) {
                OH_LOG_ERROR(LOG_APP, "推理已经结束，请回收");
                if (work != nullptr) {
                    delete work;
                }
            } else {
                napi_handle_scope scope = nullptr;
                napi_open_handle_scope(context->env, &scope);
                if (scope == nullptr) {
                    return;
                }
                napi_value callback = nullptr;
                napi_get_reference_value(context->env, context->realTimeCallbackRef, &callback);
                napi_value retArg;
                napi_create_string_utf8(context->env, context->result.data(), context->result.size(), &retArg);
                napi_value ret;
                napi_call_function(context->env, nullptr, callback, 1, &retArg, &ret);
            }
        });
}
// 2
// 定义异步任务的第一个回调函数，该函数在工作线程中执行，处理具体的业务逻辑，特殊的：这里需要实现打字机效果(实时输出)，所以在循环中每次调用在非ArkTS线程中回调ArkTS接口的回调函数。
static void startCompletion_ECB(napi_env env, void *data) {
    UNUSED(env);
    startCompletion_CBData *callbackData = reinterpret_cast<startCompletion_CBData *>(data);

    // 逻辑-开始
    auto contextId = std::stol(callbackData->args[0]);
    OH_LOG_ERROR(LOG_APP, "调用模型推理");
    auto llama = context_map[(long)contextId];
    llama->rewind();

    llama_perf_context_reset(llama->ctx);

    llama->params.prompt = callbackData->args[1];
    llama->params.sparams.seed = -1;

    int max_threads = std::thread::hardware_concurrency();
    // Use 3 threads by default on 4-core devices, 4 threads on more cores
    int default_n_threads = max_threads == 4 ? 5 : std::min(5, max_threads);
    llama->params.cpuparams.n_threads = default_n_threads;

    llama->params.n_predict = 100;

    if (!llama->initSampling()) {
        std::string result = "Failed to initialize sampling";
        callbackData->result = result;
    }
    OH_LOG_ERROR(LOG_APP, "开始模型推理");
    llama->beginCompletion();
    llama->loadPrompt();

    size_t sent_count = 0;
    while (llama->has_next_token && !llama->is_interrupted) {
        const fllama::completion_token_output token_with_probs = llama->doCompletion();
        if (token_with_probs.tok == -1 || llama->incomplete) {
            continue;
        }
        const std::string token_text = common_token_to_piece(llama->ctx, token_with_probs.tok);

        size_t pos = std::min(sent_count, llama->generated_text.size());

        const std::string str_test = llama->generated_text.substr(pos);
        bool is_stop_full = false;
        size_t stop_pos = llama->findStoppingStrings(str_test, token_text.size(), fllama::STOP_FULL);
        if (stop_pos != std::string::npos) {
            is_stop_full = true;
            llama->generated_text.erase(llama->generated_text.begin() + pos + stop_pos, llama->generated_text.end());
            pos = std::min(sent_count, llama->generated_text.size());
        } else {
            is_stop_full = false;
            stop_pos = llama->findStoppingStrings(str_test, token_text.size(), fllama::STOP_PARTIAL);
        }
        if (stop_pos == std::string::npos ||
            // Send rest of the text if we are at the end of the generation
            (!llama->has_next_token && !is_stop_full && stop_pos > 0)) {
            const std::string to_send = llama->generated_text.substr(pos, std::string::npos);

            sent_count += to_send.size();
            OH_LOG_ERROR(LOG_APP, "推理中: %{public}s", to_send.c_str());
            callbackData->result = to_send.c_str();
            startCompletion_RT(callbackData);
        }
    }
    llama_perf_context_print(llama->ctx);
    llama->is_predicting = false;
    // 逻辑-结束
    OH_LOG_ERROR(LOG_APP, "推理结果: %{public}s", llama->generated_text.c_str());
    callbackData->hasDone = true;
    callbackData->result = llama->generated_text.c_str();
}
// 1 创建异步任务，并使用napi_queue_async_work将异步任务加入队列，等待执行
static napi_value startCompletion(napi_env env, napi_callback_info info) {
    size_t argc = 4;
    napi_value args[4] = {nullptr};
    NAPI_CALL(napi_get_cb_info(env, info, &argc, args, nullptr, nullptr));
    auto asyncContext = new startCompletion_CBData();
    auto contextIdStr = NValueToString(env, args[0]);
    auto prompt = NValueToString(env, args[1]);
    asyncContext->args[0] = contextIdStr;
    asyncContext->args[1] = prompt;
    asyncContext->env = env;
    napi_create_reference(env, args[2], 1, &asyncContext->callbackRef);
    napi_create_reference(env, args[3], 1, &asyncContext->realTimeCallbackRef);
    napi_value resourceName = nullptr;
    napi_create_string_utf8(env, "startCompletionCallback", NAPI_AUTO_LENGTH, &resourceName);
    napi_create_async_work(env, nullptr, resourceName, startCompletion_ECB, startCompletion_CCB, asyncContext,
                           &asyncContext->asyncWork);
    napi_queue_async_work(env, asyncContext->asyncWork);
    return nullptr;
}

/// == == [stopCompletion] == ==
static napi_value stopCompletion(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value args[1] = {nullptr};
    NAPI_CALL(napi_get_cb_info(env, info, &argc, args, nullptr, nullptr));
    auto contextIdStr = NValueToString(env, args[0]);
    auto contextId = std::stol(contextIdStr);
    auto llama = context_map[(long)contextId];
    llama->is_interrupted = true;
    OH_LOG_ERROR(LOG_APP, "终止模型推理");
    return NAPIUndefined(env);
}

/// == == [freeLlamaContext] == ==
static napi_value freeLlamaContext(napi_env env, napi_callback_info info) {
    size_t argc = 1;
    napi_value args[1] = {nullptr};
    NAPI_CALL(napi_get_cb_info(env, info, &argc, args, nullptr, nullptr));
    auto contextIdStr = NValueToString(env, args[0]);
    auto contextId = std::stol(contextIdStr);
    auto llama = context_map[(long)contextId];
    if (llama->model) {
        llama_free_model(llama->model);
    }
    if (llama->ctx) {
        llama_free(llama->ctx);
    }
    if (llama->ctx_sampling != nullptr) {
        common_sampler_free(llama->ctx_sampling);
    }
    context_map.erase((long)llama->ctx);
    OH_LOG_ERROR(LOG_APP, "释放上下文环境");
    return NAPIUndefined(env);
}

EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports) {
    napi_property_descriptor desc[] = {
        {"initLlamaContext", nullptr, initLlamaContext, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"getModelDetail", nullptr, getModelDetail, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"startCompletion", nullptr, startCompletion, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"stopCompletion", nullptr, stopCompletion, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"freeLlamaContext", nullptr, freeLlamaContext, nullptr, nullptr, nullptr, napi_default, nullptr}};
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static napi_module hllamaModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "hllama",
    .nm_priv = ((void *)0),
    .reserved = {0},
};

extern "C" __attribute__((constructor)) void RegisterEntryModule(void) { napi_module_register(&hllamaModule); }
