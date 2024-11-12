package ink.xcl.fllama

import android.util.Log

object FLog {
    private const val TAG = "[FLlama]"
    fun d(msg: String) {
//        if (BuildConfig.DEBUG) {
        Log.d(TAG, msg)
//        }
    }

    fun e(msg: String, tr: Throwable? = null) {
        Log.e(TAG, msg, tr)
    }

    fun w(msg: String, tr: Throwable? = null) {
        Log.w(TAG, msg, tr)
    }
}