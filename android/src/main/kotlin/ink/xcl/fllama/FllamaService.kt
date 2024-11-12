package ink.xcl.fllama

import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class FllamaService : Service() {
    private val binder = LocalBinder()
    private var fLlama: FLlama? = null

    override fun onCreate() {
        super.onCreate()
        FLog.d("FllamaService onCreate")
        fLlama = FLlama(applicationContext)
    }

    override fun onBind(intent: Intent): IBinder = binder

    inner class LocalBinder : Binder() {
        fun getService(): FllamaService = this@FllamaService
    }

    private fun handleFLlamaMethod(
        call: MethodCall,
        result: Result,
        method: (MethodCall, Result) -> Unit
    ) {
        try {
            FLog.d("Call Method = ${call.method}")
            method(call, result)
        } catch (e: Exception) {
            result.error("ERROR", "An error occurred: ${e.message}", null)
        }
    }

    fun getFileSHA256(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.getFileSHA256(c, r) }
    }

    fun getCpuInfo(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { _, r -> fLlama?.getCpuInfo(r) }
    }

    fun initContext(call: MethodCall, result: Result, eventSend: (HashMap<String, Any>) -> Unit) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.initContext(c, r, eventSend) }
    }

    fun getFormattedChat(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.getFormattedChat(c, r) }
    }

    fun loadSession(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.loadSession(c, r) }
    }

    fun saveSession(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.saveSession(c, r) }
    }

    fun completion(call: MethodCall, result: Result, eventSend: (HashMap<String, Any>) -> Unit) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.completion(c, r, eventSend) }
    }

    fun stopCompletion(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.stopCompletion(c, r) }
    }

    fun tokenize(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.tokenize(c, r) }
    }

    fun detokenize(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.detokenize(c, r) }
    }

    fun bench(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.bench(c, r) }
    }

    fun releaseContext(call: MethodCall, result: Result) {
        handleFLlamaMethod(call, result) { c, r -> fLlama?.releaseContext(c, r) }
    }

    fun releaseAllContexts(result: Result) {
        fLlama?.releaseAllContexts(result)
    }

    override fun onDestroy() {
        try {
            CoroutineScope(Dispatchers.IO).launch {
                fLlama?.onDestroy()
            }
            fLlama = null
        } catch (_: Exception) {

        } finally {
            FLog.d("FllamaService onDestroy")
            super.onDestroy()
        }
    }
}