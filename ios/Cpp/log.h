#pragma once

#include "ggml.h" // for lm_ggml_log_level

#ifndef __GNUC__
#    define LOG_ATTRIBUTE_FORMAT(...)
#elif defined(__MINGW32__)
#    define LOG_ATTRIBUTE_FORMAT(...) __attribute__((format(gnu_printf, __VA_ARGS__)))
#else
#    define LOG_ATTRIBUTE_FORMAT(...) __attribute__((format(printf, __VA_ARGS__)))
#endif

#define LOG_DEFAULT_DEBUG 1
#define LOG_DEFAULT_LLAMA 0

// needed by the LOG_TMPL macro to avoid computing log arguments if the verbosity lower
// set via common_log_set_verbosity()
extern int common_log_verbosity_thold;

void common_log_set_verbosity_thold(int verbosity); // not thread-safe

// the common_log uses an internal worker thread to print/write log messages
// when the worker thread is paused, incoming log messages are discarded
struct common_log;

struct common_log * common_log_init();
struct common_log * common_log_main(); // singleton, automatically destroys itself on exit
void                common_log_pause (struct common_log * log); // pause  the worker thread, not thread-safe
void                common_log_resume(struct common_log * log); // resume the worker thread, not thread-safe
void                common_log_free  (struct common_log * log);

LOG_ATTRIBUTE_FORMAT(3, 4)
void common_log_add(struct common_log * log, enum lm_ggml_log_level level, const char * fmt, ...);

// defaults: file = NULL, colors = false, prefix = false, timestamps = false
//
// regular log output:
//
//   lm_ggml_backend_metal_log_allocated_size: allocated buffer, size =  6695.84 MiB, ( 6695.91 / 21845.34)
//   llm_load_tensors: ggml ctx size =    0.27 MiB
//   llm_load_tensors: offloading 32 repeating layers to GPU
//   llm_load_tensors: offloading non-repeating layers to GPU
//
// with prefix = true, timestamps = true, the log output will look like this:
//
//   0.00.035.060 D lm_ggml_backend_metal_log_allocated_size: allocated buffer, size =  6695.84 MiB, ( 6695.91 / 21845.34)
//   0.00.035.064 I llm_load_tensors: ggml ctx size =    0.27 MiB
//   0.00.090.578 I llm_load_tensors: offloading 32 repeating layers to GPU
//   0.00.090.579 I llm_load_tensors: offloading non-repeating layers to GPU
//
// I - info    (stdout, V = 0)
// W - warning (stderr, V = 0)
// E - error   (stderr, V = 0)
// D - debug   (stderr, V = LOG_DEFAULT_DEBUG)
//

void common_log_set_file      (struct common_log * log, const char * file);       // not thread-safe
void common_log_set_colors    (struct common_log * log,       bool   colors);     // not thread-safe
void common_log_set_prefix    (struct common_log * log,       bool   prefix);     // whether to output prefix to each log
void common_log_set_timestamps(struct common_log * log,       bool   timestamps); // whether to output timestamps in the prefix

// helper macros for logging
// use these to avoid computing log arguments if the verbosity of the log is higher than the threshold
//
// for example:
//
//   LOG_DBG("this is a debug message: %d\n", expensive_function());
//
// this will avoid calling expensive_function() if LOG_DEFAULT_DEBUG > common_log_verbosity_thold
//

#define LOG_TMPL(level, verbosity, ...) \
    do { \
        if ((verbosity) <= common_log_verbosity_thold) { \
            common_log_add(common_log_main(), (level), __VA_ARGS__); \
        } \
    } while (0)

#if defined(__ANDROID__)
#if defined(DLOGGING_ENABLED)
#define LLAMA_ANDROID_LOG_TAG "FLLAMA_ANDROID"
#define LOG(...)             __android_log_print(ANDROID_LOG_INFO, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOGV(verbosity, ...) __android_log_print(ANDROID_LOG_INFO, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)

#define LOG_INF(...) __android_log_print(ANDROID_LOG_INFO, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOG_WRN(...) __android_log_print(ANDROID_LOG_WARN, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOG_ERR(...) __android_log_print(ANDROID_LOG_ERROR, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOG_DBG(...) __android_log_print(ANDROID_LOG_DEBUG, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOG_CNT(...) __android_log_print(ANDROID_LOG_DEBUG, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)

#define LOG_INFV(verbosity, ...) __android_log_print(ANDROID_LOG_INFO, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOG_WRNV(verbosity, ...) __android_log_print(ANDROID_LOG_WARN, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOG_ERRV(verbosity, ...) __android_log_print(ANDROID_LOG_ERROR, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOG_DBGV(verbosity, ...) __android_log_print(ANDROID_LOG_DEBUG, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#define LOG_CNTV(verbosity, ...) __android_log_print(ANDROID_LOG_DEBUG, LLAMA_ANDROID_LOG_TAG, __VA_ARGS__)
#else
#define LOG(...)
#define LOGV(verbosity, ...)

#define LOG_INF(...)
#define LOG_WRN(...)
#define LOG_ERR(...)
#define LOG_DBG(...)
#define LOG_CNT(...)

#define LOG_INFV(verbosity, ...)
#define LOG_WRNV(verbosity, ...)
#define LOG_ERRV(verbosity, ...)
#define LOG_DBGV(verbosity, ...)
#define LOG_CNTV(verbosity, ...)
#endif
#elif defined(OHOS)
#if defined(DLOGGING_ENABLED)
#include <hilog/log.h>
#undef LOG_DOMAIN
#undef LOG_TAG
#define LOG_DOMAIN 0x0006
#define LOG_TAG "FLLAMA_OHOS"
#define LOG(...)             OH_LOG_DEBUG(LOG_APP, __VA_ARGS__)
#define LOGV(verbosity, ...) OH_LOG_INFO(LOG_APP, __VA_ARGS__)

#define LOG_INF(...) OH_LOG_INFO(LOG_APP, __VA_ARGS__)
#define LOG_WRN(...) OH_LOG_WARN(LOG_APP, __VA_ARGS__)
#define LOG_ERR(...) OH_LOG_ERROR(LOG_APP, __VA_ARGS__)
#define LOG_DBG(...) OH_LOG_DEBUG(LOG_APP, __VA_ARGS__)
#define LOG_CNT(...) OH_LOG_DEBUG(LOG_APP, __VA_ARGS__)

#define LOG_INFV(verbosity, ...) OH_LOG_INFO(LOG_APP, __VA_ARGS__)
#define LOG_WRNV(verbosity, ...) OH_LOG_WARN(LOG_APP, __VA_ARGS__)
#define LOG_ERRV(verbosity, ...) OH_LOG_ERROR(LOG_APP, __VA_ARGS__)
#define LOG_DBGV(verbosity, ...) OH_LOG_DEBUG(LOG_APP, __VA_ARGS__)
#define LOG_CNTV(verbosity, ...) OH_LOG_DEBUG(LOG_APP, __VA_ARGS__)
#else
#define LOG(...)
#define LOGV(verbosity, ...)

#define LOG_INF(...)
#define LOG_WRN(...)
#define LOG_ERR(...)
#define LOG_DBG(...)
#define LOG_CNT(...)

#define LOG_INFV(verbosity, ...)
#define LOG_WRNV(verbosity, ...)
#define LOG_ERRV(verbosity, ...)
#define LOG_DBGV(verbosity, ...)
#define LOG_CNTV(verbosity, ...)
#endif
#else
#define LOG(...)             LOG_TMPL(LM_GGML_LOG_LEVEL_NONE, 0,         __VA_ARGS__)
#define LOGV(verbosity, ...) LOG_TMPL(LM_GGML_LOG_LEVEL_NONE, verbosity, __VA_ARGS__)

#define LOG_INF(...) LOG_TMPL(LM_GGML_LOG_LEVEL_INFO,  0,                 __VA_ARGS__)
#define LOG_WRN(...) LOG_TMPL(LM_GGML_LOG_LEVEL_WARN,  0,                 __VA_ARGS__)
#define LOG_ERR(...) LOG_TMPL(LM_GGML_LOG_LEVEL_ERROR, 0,                 __VA_ARGS__)
#define LOG_DBG(...) LOG_TMPL(LM_GGML_LOG_LEVEL_DEBUG, LOG_DEFAULT_DEBUG, __VA_ARGS__)
#define LOG_CNT(...) LOG_TMPL(LM_GGML_LOG_LEVEL_CONT,  0,                 __VA_ARGS__)

#define LOG_INFV(verbosity, ...) LOG_TMPL(LM_GGML_LOG_LEVEL_INFO,  verbosity, __VA_ARGS__)
#define LOG_WRNV(verbosity, ...) LOG_TMPL(LM_GGML_LOG_LEVEL_WARN,  verbosity, __VA_ARGS__)
#define LOG_ERRV(verbosity, ...) LOG_TMPL(LM_GGML_LOG_LEVEL_ERROR, verbosity, __VA_ARGS__)
#define LOG_DBGV(verbosity, ...) LOG_TMPL(LM_GGML_LOG_LEVEL_DEBUG, verbosity, __VA_ARGS__)
#define LOG_CNTV(verbosity, ...) LOG_TMPL(LM_GGML_LOG_LEVEL_CONT,  verbosity, __VA_ARGS__)
#endif