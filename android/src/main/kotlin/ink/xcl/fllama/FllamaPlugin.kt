package ink.xcl.fllama

import android.app.Activity
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.os.IBinder
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FllamaPlugin */
class FllamaPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, EventChannel.StreamHandler {
    private lateinit var channel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private var eventSink: EventChannel.EventSink? = null
    private var context: Context? = null
    private var activity: Activity? = null
    private var service: FllamaService? = null
    private var bound = false
    private val methodCallQueue = mutableListOf<Pair<MethodCall, Result>>()
    private val serviceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, binder: IBinder?) {
            FLog.d("FllamaPlugin serviceConnection onServiceConnected")
            val localBinder = binder as? FllamaService.LocalBinder
            service = localBinder?.getService()
            bound = true
            methodCallQueue.forEach { (call, result) ->
                handleMethodCall(call, result)
            }
            methodCallQueue.clear()
        }

        override fun onServiceDisconnected(name: ComponentName?) {
            FLog.d("FllamaPlugin serviceConnection onServiceDisconnected")
            service = null
            bound = false
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        FLog.d("FllamaPlugin onAttachedToEngine")
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fllama")
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "fllama_event_channel")
        context = flutterPluginBinding.applicationContext
        val intent = Intent(context, FllamaService::class.java)
        if (context?.packageManager?.let { intent.resolveActivity(it) } != null) {
            context?.bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE).let {
                if (it == true) {
                    FLog.d("FllamaPlugin bindService success")
                } else {
                    FLog.w("FllamaPlugin bindService failed")
                }
            }
        } else {
            FLog.e("FllamaPlugin service not found")
        }
        channel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(this)
    }

    private fun handleMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            // === Utils ===
            "getFileSHA256" -> service?.getFileSHA256(call, result)
            "getCpuInfo" -> service?.getCpuInfo(call, result)

            // === LLama ===
            "initContext" -> service?.initContext(call, result) { tokenResult ->
                if (eventSink != null) {
                    eventSink?.success(tokenResult)
                }
            }

            "getFormattedChat" -> service?.getFormattedChat(call, result)
            "loadSession" -> service?.loadSession(call, result)
            "saveSession" -> service?.saveSession(call, result)
            "completion" -> service?.completion(call, result) { tokenResult ->
                if (eventSink != null) {
                    eventSink?.success(tokenResult)
                }
            }

            "stopCompletion" -> service?.stopCompletion(call, result)
            "tokenize" -> service?.tokenize(call, result)
            "detokenize" -> service?.detokenize(call, result)
            "bench" -> service?.bench(call, result)
            "releaseContext" -> service?.releaseContext(call, result)
            "releaseAllContexts" -> service?.releaseAllContexts(result)

            else -> result.notImplemented()
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        FLog.d("FllamaPlugin onMethodCall ${call.method}")
        if (bound) {
            handleMethodCall(call, result)
        } else {
            methodCallQueue.add(Pair(call, result))
            if (context != null) {
                val intent = Intent(context, FllamaService::class.java)
                val boundSuccessfully =
                    context?.bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE)
                FLog.d("ManualStartService Status=$boundSuccessfully")
                if (true != boundSuccessfully) {
                    result.error("505", "Service started Error", null)
                }
            } else {
                result.error("504", "Context is Null, Can't call start Service!", null)
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        FLog.d("FllamaPlugin onDetachedFromEngine")
        try {
            context?.unbindService(serviceConnection)
            channel.setMethodCallHandler(null)
            eventChannel.setStreamHandler(null)
        } catch (_: Exception) {

        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        FLog.d("FllamaPlugin onAttachedToActivity")
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        FLog.d("FllamaPlugin onReattachedToActivityForConfigChanges")
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        FLog.d("FllamaPlugin onDetachedFromActivity")
        try {
            context?.unbindService(serviceConnection)
        } catch (_: Exception) {

        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}