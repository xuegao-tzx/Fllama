package ink.xcl.fllama

import android.content.Context
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File
import java.util.Random
import kotlin.math.abs

class FLlama(private val fContext: Context) {

    private val tasks = HashMap<Job, String>()

    private val contexts = HashMap<Int, LlamaContext>()

    fun getFileSHA256(call: MethodCall, res: Result) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            if (map == null) {
                throw Exception("Params can't be Null")
            } else {
                val fPath: String = map["filePath"] as String
                CoroutineScope(Dispatchers.IO).launch {
                    var exception: Exception? = null
                    var result: String? = null
                    try {
                        result = FUtils.calculateFileSHA256(File(fPath))
                    } catch (e: Exception) {
                        exception = e
                    }
                    withContext(Dispatchers.Main) {
                        if (exception != null) {
                            res.error("500", exception.localizedMessage, exception)
                        } else {
                            res.success(result)
                        }
                        tasks.remove(this@launch.coroutineContext)
                    }
                }
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun getCpuInfo(res: Result) {
        try {
            CoroutineScope(Dispatchers.IO).launch {
                var exception: Exception? = null
                val result: Any? = try {
                    val result: HashMap<String, Any> = HashMap()
                    result["cpuFeatures"] = FUtils.cpuInfo.substringAfter(":")
                    result["isMetalSupport"] = false
                    result["gpuName"] = "Android is Not Support !"
                    result["totalMemory"] = FUtils.getTotalMemory(fContext)
                    result["cpuCount"] = FUtils.getCpuCount
                    result["deviceModel"] = Build.MODEL
                    result
                } catch (e: Exception) {
                    exception = e
                    null
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    // === Llama ===

    fun initContext(call: MethodCall, res: Result, eventSend: (HashMap<String, Any>) -> Unit) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            CoroutineScope(Dispatchers.IO).launch {
                var exception: Exception? = null
                val result: Any? = try {
                    if (map == null) {
                        throw Exception("Params can't be Null")
                    } else {
                        val id = abs(Random().nextInt().toDouble()).toInt()
                        val llamaContext =
                            LlamaContext(id, map){
                                CoroutineScope(Dispatchers.Main).launch {
                                    eventSend(it)
                                }
                            }
                        if (llamaContext.context == 0L) {
                            throw Exception("Failed to initialize context")
                        }
                        contexts[id] = llamaContext
                        val result: HashMap<String, Any> = HashMap()
                        result["contextId"] = id
                        result["gpu"] = false
                        result["reasonNoGPU"] = "Currently not supported"
                        result["model"] = llamaContext.getModelDetails()
                        result
                    }
                } catch (e: Exception) {
                    exception = e
                    null
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "initContext"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    @Suppress("UNCHECKED_CAST")
    fun getFormattedChat(
        call: MethodCall, res: Result,
    ) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val messages: Array<HashMap<String, Any>?> =
                map["messages"] as Array<HashMap<String, Any>?>
            val chatTemplate: String? = map["chatTemplate"] as String?
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var result: Any? = null
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    result = context.getFormattedChat(messages, chatTemplate)
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "getFormattedChat-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun loadSession(call: MethodCall, res: Result) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val path: String = map["path"] as String
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var result: Any? = null
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    result = context.loadSession(path)
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "loadSession-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun saveSession(call: MethodCall, res: Result) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val path: String = map["path"] as String
            val size: Double = map["size"] as Double
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var result: Any? = null
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    result = context.saveSession(path, size.toInt())
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "saveSession-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    @Suppress("UNCHECKED_CAST")
    fun completion(call: MethodCall, res: Result, eventSend: (HashMap<String, Any>) -> Unit) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val params: HashMap<String, Any> = map["params"] as HashMap<String, Any>
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var result: Any? = null
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    if (context.isPredicting) {
                        throw Exception("Context is busy")
                    }
                    result = context.completion(params) {
                        CoroutineScope(Dispatchers.Main).launch {
                            eventSend(it)
                        }
                    }
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        FLog.d("result Done")
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "completion-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun stopCompletion(call: MethodCall, res: Result) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    context.stopCompletion()
                    for (task in tasks.keys) {
                        if (tasks[task] == "completion-$contextId") {
                            task.join()
                            break
                        }
                    }
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(null)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "stopCompletion-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun tokenize(call: MethodCall, res: Result) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val text: String = map["text"] as String
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var result: Any? = null
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    result = context.tokenize(text)
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "tokenize-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun detokenize(call: MethodCall, res: Result) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val tokens: IntArray = map["tokens"] as IntArray
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var result: Any? = null
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    result = context.detokenize(tokens)
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "detokenize-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun bench(call: MethodCall, res: Result) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val pp: Double = map["pp"] as Double
            val tg: Double = map["tg"] as Double
            val pl: Double = map["pl"] as Double
            val nr: Double = map["nr"] as Double
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var result: Any? = null
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    result = context.bench(pp.toInt(), tg.toInt(), pl.toInt(), nr.toInt())
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(result)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "bench-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun releaseContext(call: MethodCall, res: Result) {
        try {
            val map = call.arguments<HashMap<String, Any>>()
            val id: Double = map?.get("contextId") as Double
            val contextId = id.toInt()
            CoroutineScope(Dispatchers.IO).launch {
                var exception: Exception? = null
                try {
                    val context = contexts[contextId] ?: throw Exception("Context $id not found")
                    context.stopCompletion()
                    for (task in tasks.keys) {
                        if (tasks[task] == "completion-$contextId") {
                            task.join()
                            break
                        }
                    }
                    context.release()
                    contexts.remove(contextId)
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(null)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "releaseContext-$contextId"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    fun releaseAllContexts(res: Result) {
        try {
            CoroutineScope(Dispatchers.IO).launch {
                var exception: Exception? = null
                try {
                    onDestroy()
                } catch (e: Exception) {
                    exception = e
                }
                withContext(Dispatchers.Main) {
                    if (exception != null) {
                        res.error("500", exception.localizedMessage, exception)
                    } else {
                        res.success(null)
                    }
                    tasks.remove(this@launch.coroutineContext)
                }
            }.let { task ->
                tasks[task] = "releaseAllContexts"
            }
        } catch (e: Exception) {
            res.error("505", e.localizedMessage, e)
        }
    }

    suspend fun onDestroy() {
        try {
            for (context in contexts.values) {
                context.stopCompletion()
            }
            for (task in tasks.keys) {
                try {
                    task.join()
                } catch (e: Exception) {
                    FLog.e("Failed to wait for task", e)
                }
            }
            tasks.clear()
            for (context in contexts.values) {
                context.release()
            }
            contexts.clear()
        } catch (_: Exception) {
        }
    }
}
