package ink.xcl.fllama

import android.os.Build
import androidx.annotation.Keep
import java.io.File

@Keep
class LlamaContext(
    private val id: Int,
    params: HashMap<String, Any>,
    eventSend: (HashMap<String, Any>) -> Unit = {}
) {
    /// === Llama ===
    val context: Long
    val isPredicting: Boolean
        get() = isPredicting(this.context)
    private val modelDetails: HashMap<String, Any>
    private var eventSend: (HashMap<String, Any>) -> Unit
    private fun emitStream(functionName: String, result: Any, needId: Boolean = true) {
        val event: HashMap<String, Any> = HashMap()
        event["function"] = functionName
        event["contextId"] = if (needId) {
            this@LlamaContext.id.toString()
        } else {
            ""
        }
        event["result"] = result
        eventSend.invoke(event)
    }

    class LlamaCompletionCallback(var context: LlamaContext, private var emitNeeded: Boolean) {
        @Keep
        fun onPartialCompletion(tokenResult: HashMap<String, Any>) {
            if (!emitNeeded) return
            context.emitStream("completion", tokenResult, needId = true)
        }
    }

    class LlamaLoadProgressCallback(var context: LlamaContext, private var emitNeeded: Boolean) {
        @Keep
        fun onLoadProgress(progress: Int) {
            if (!emitNeeded) return
            context.emitStream("loadProgress", progress, needId = false)
        }
    }

    fun getModelDetails(): HashMap<String, Any> {
        return modelDetails
    }

    fun getFormattedChat(messages: Array<HashMap<String, Any>?>, chatTemplate: String?): String {
        return getFormattedChat(
            this.context, messages,
            chatTemplate ?: ""
        )
    }


    fun loadSession(path: String): HashMap<String, Any> {
        require(path.isNotEmpty()) { "File path is empty" }
        val file = File(path)
        require(file.exists()) { "File does not exist: $path" }
        val result: HashMap<String, Any> = loadSession(this.context, path)
        if (result.containsKey("error")) {
            throw IllegalStateException(result["error"] as String? ?: "")
        }
        return result
    }

    fun saveSession(path: String?, size: Int): Int {
        require(!path.isNullOrEmpty()) { "File path is empty" }
        return saveSession(this.context, path, size)
    }

    @Suppress("UNCHECKED_CAST")
    fun completion(
        params: HashMap<String, Any>,
        eventSent: (HashMap<String, Any>) -> Unit
    ): HashMap<String, Any> {
        var logit_bias = Array<DoubleArray?>(0) {
            DoubleArray(
                0
            )
        }
        if (params.containsKey("logit_bias")) {
            val logit_bias_array: ArrayList<ArrayList<Double>> =
                params["logit_bias"] as ArrayList<ArrayList<Double>>
            logit_bias = arrayOfNulls(logit_bias_array.size)
            for (i in logit_bias_array.indices) {
                val logit_bias_row: DoubleArray = logit_bias_array[i].toDoubleArray()
                logit_bias[i] = DoubleArray(logit_bias_row.size)
                for (j in logit_bias_row.indices) {
                    logit_bias[i]?.set(j, logit_bias_row[j])
                }
            }
        }
        this.eventSend = eventSent
        val result: HashMap<String, Any> = startCompletion(
            this.context,
            params["prompt"] as String,
            params["grammar"] as String? ?: "",
            (params["temperature"] as Double? ?: 0.7f).toFloat(),
            params["n_threads"] as Int? ?: 0,
            params["n_predict"] as Int? ?: -1,
            params["n_probs"] as Int? ?: 0,
            params["penalty_last_n"] as Int? ?: 64,
            (params["penalty_repeat"] as Double? ?: 1.00f).toFloat(),
            (params["penalty_freq"] as Double? ?: 0.00f).toFloat(),
            (params["penalty_present"] as Double? ?: 0.00f).toFloat(),
            (params["mirostat"] as Double? ?: 0.00f).toFloat(),
            (params["mirostat_tau"] as Double? ?: 5.00f).toFloat(),
            (params["mirostat_eta"] as Double? ?: 0.10f).toFloat(),
            params["penalize_nl"] as Boolean? ?: false,
            params["top_k"] as Int? ?: 40,
            (params["top_p"] as Double? ?: 0.95f).toFloat(),
            (params["min_p"] as Double? ?: 0.05f).toFloat(),
            (params["typical_p"] as Double? ?: 1.00f).toFloat(),
            (params["xtc_threshold"] as Double? ?: 0.00f).toFloat(),
            (params["xtc_probability"] as Double? ?: 0.00f).toFloat(),
            params["seed"] as Int? ?: -1,
            (params["stop"] as ArrayList<String?>?)?.toTypedArray() ?: arrayOfNulls<String?>(0),
            params["ignore_eos"] as Boolean? ?: false,
            logit_bias,
            LlamaCompletionCallback(
                this@LlamaContext,
                params["emit_realtime_completion"] as Boolean? ?: false
            )
        )

        if (result.containsKey("error")) {
            throw IllegalStateException(result["error"] as String? ?: "")
        }

        return result
    }

    fun stopCompletion() {
        abortCompletion(this.context)
    }

    fun tokenize(text: String?): HashMap<String, Any> {
        val result: HashMap<String, Any> = HashMap()
        result["tokens"] = tokenize(this.context, text)
        return result
    }

    fun detokenize(tokens: IntArray): String {
        return detokenize(this.context, tokens)
    }

    fun bench(pp: Int, tg: Int, pl: Int, nr: Int): String {
        return bench(this.context, pp, tg, pl, nr)
    }

    fun release() {
        freeLlamaContext(context)
    }

    init {
        this.eventSend = eventSend
        val model = params["model"] as String
        this.context = initLlamaContext(
            model,
            params["lora_init_without_apply"] as Boolean? ?: false,
            params["n_ctx"] as Int? ?: 768,
            params["n_batch"] as Int? ?: 768,
            params["n_threads"] as Int? ?: 0,
            params["n_gpu_layers"] as Int? ?: 0,
            params["use_mlock"] as Boolean? ?: true,
            params["use_mmap"] as Boolean? ?: true,
            params["lora"] as String? ?: "",
            (params["lora_scaled"] as Double? ?: 1.0f).toFloat(),
            (params["rope_freq_base"] as Double? ?: 0.0f).toFloat(),
            (params["rope_freq_scale"] as Double? ?: 0.0f).toFloat(),
            LlamaLoadProgressCallback(
                this@LlamaContext,
                params["emit_load_progress"] as Boolean? ?: false
            )
        )
        this.modelDetails = loadModelDetails(this.context)
    }

    companion object {
        init {
            FLog.d("Primary ABI: ${Build.SUPPORTED_ABIS[0]}")
            if (FUtils.isArm64V8a) {
                FLog.d("CPU features: $FUtils.cpuInfo")
                val hasFp16 = FUtils.cpuInfo.contains("fp16") || FUtils.cpuInfo.contains("fphp")
                val hasDotProd =
                    FUtils.cpuInfo.contains("dotprod") || FUtils.cpuInfo.contains("asimddp")
                val hasI8mm = FUtils.cpuInfo.contains("i8mm")
                val isAtLeastArmV82 =
                    FUtils.cpuInfo.contains("asimd") && FUtils.cpuInfo.contains("crc32") && FUtils.cpuInfo.contains(
                        "aes"
                    )
                val isAtLeastArmV84 =
                    FUtils.cpuInfo.contains("dcpop") && FUtils.cpuInfo.contains("uscat")
                if (isAtLeastArmV84 && hasI8mm && hasFp16 && hasDotProd) {
                    FLog.d("Loading libfllama_v8_4_fp16_dotprod_i8mm.so")
                    System.loadLibrary("fllama_v8_4_fp16_dotprod_i8mm")
                } else if (isAtLeastArmV84 && hasFp16 && hasDotProd) {
                    FLog.d("Loading libfllama_v8_4_fp16_dotprod.so")
                    System.loadLibrary("fllama_v8_4_fp16_dotprod")
                } else if (isAtLeastArmV82 && hasFp16 && hasDotProd) {
                    FLog.d("Loading libfllama_v8_2_fp16_dotprod.so")
                    System.loadLibrary("fllama_v8_2_fp16_dotprod")
                } else if (isAtLeastArmV82 && hasFp16) {
                    FLog.d("Loading libfllama_v8_2_fp16.so")
                    System.loadLibrary("fllama_v8_2_fp16")
                } else {
                    FLog.d("Loading libfllama_v8.so")
                    System.loadLibrary("fllama_v8")
                }
            } else if (FUtils.isX86_64) {
                FLog.d("Loading libfllama_x86_64.so")
                System.loadLibrary("fllama_x86_64")
            } else if (FUtils.isArm32V7a) {
                FLog.d("Loading libfllama_v7.so")
                System.loadLibrary("fllama_v7")
            } else {
                FLog.d("Loading default libfllama.so")
                System.loadLibrary("fllama")
            }
        }

        // Llama
        private external fun initLlamaContext(
            model: String?,
            lora_init_without_apply: Boolean,
            n_ctx: Int,
            n_batch: Int,
            n_threads: Int,
            n_gpu_layers: Int,  //Android Not Support
            use_mlock: Boolean,
            use_mmap: Boolean,
            lora: String?,
            lora_scaled: Float,
            rope_freq_base: Float,
            rope_freq_scale: Float,
            load_progress_callback: LlamaLoadProgressCallback?
        ): Long

        private external fun loadModelDetails(
            contextPtr: Long
        ): HashMap<String, Any>

        private external fun getFormattedChat(
            contextPtr: Long,
            messages: Array<HashMap<String, Any>?>,
            chatTemplate: String?
        ): String

        private external fun loadSession(
            contextPtr: Long,
            path: String?
        ): HashMap<String, Any>

        private external fun saveSession(
            contextPtr: Long,
            path: String?,
            size: Int
        ): Int

        private external fun startCompletion(
            context_ptr: Long,
            prompt: String?,
            grammar: String?,
            temperature: Float,
            n_threads: Int,
            n_predict: Int,
            n_probs: Int,
            penalty_last_n: Int,
            penalty_repeat: Float,
            penalty_freq: Float,
            penalty_present: Float,
            mirostat: Float,
            mirostat_tau: Float,
            mirostat_eta: Float,
            penalize_nl: Boolean,
            top_k: Int,
            top_p: Float,
            min_p: Float,
            typical_p: Float,
            xtc_threshold: Float,
            xtc_probability: Float,
            seed: Int,
            stop: Array<String?>,
            ignore_eos: Boolean,
            logit_bias: Array<DoubleArray?>?,
            completion_callback: LlamaCompletionCallback?
        ): HashMap<String, Any>

        private external fun abortCompletion(contextPtr: Long)
        private external fun isPredicting(contextPtr: Long): Boolean
        private external fun tokenize(contextPtr: Long, text: String?): IntArray
        private external fun detokenize(contextPtr: Long, tokens: IntArray?): String
        private external fun isEmbeddingEnabled(contextPtr: Long): Boolean
        private external fun bench(contextPtr: Long, pp: Int, tg: Int, pl: Int, nr: Int): String
        private external fun freeLlamaContext(contextPtr: Long)
    }
}
