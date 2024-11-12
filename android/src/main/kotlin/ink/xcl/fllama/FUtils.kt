package ink.xcl.fllama

import android.app.ActivityManager
import android.content.Context
import android.os.Build
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.BufferedReader
import java.io.File
import java.io.FileFilter
import java.io.FileInputStream
import java.io.FileReader
import java.io.IOException
import java.security.MessageDigest


object FUtils {
    val cpuInfo: String
        get() {
            val file = File("/proc/cpuinfo")
            val stringBuilder = StringBuilder()
            try {
                val bufferedReader = BufferedReader(FileReader(file))
                var line: String
                while ((bufferedReader.readLine().also { line = it }) != null) {
                    if (line.startsWith("Features")) {
                        stringBuilder.append(line)
                        break
                    }
                }
                bufferedReader.close()
                return stringBuilder.toString()
            } catch (e: IOException) {
                FLog.e("Couldn't read /proc/cpuinfo", e)
                return ""
            }
        }

    val isArm64V8a: Boolean
        get() = Build.SUPPORTED_ABIS[0] == "arm64-v8a"

    val isX86_64: Boolean
        get() = Build.SUPPORTED_ABIS[0] == "x86_64"

    val isArm32V7a: Boolean
        get() = Build.SUPPORTED_ABIS[0] == "armeabi-v7a"

    private val CPU_FILTER: FileFilter = FileFilter { pathname ->
        val path = pathname.name
        if (path.startsWith("cpu")) {
            for (i in 3 until path.length) {
                if (path[i] < '0' || path[i] > '9') {
                    return@FileFilter false
                }
            }
            return@FileFilter true
        }
        false
    }

    val getCpuCount: Int
        get() {
            return try {
                File("/sys/devices/system/cpu/").listFiles(CPU_FILTER)?.size ?: -1
            } catch (e: Exception) {
                -1
            }
        }

    fun getTotalMemory(context: Context): Long {
        val activityManager =
            context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memoryInfo)
        return memoryInfo.totalMem / (1024 * 1024)
    }

    @Throws(Exception::class)
    suspend fun calculateFileSHA256(file: File): String = withContext(Dispatchers.IO) {
        val buffer = ByteArray(8192) // 8KB buffer
        val digest = MessageDigest.getInstance("SHA-256")
        FileInputStream(file).use { fis ->
            var bytesRead: Int
            while (fis.read(buffer).also { bytesRead = it } != -1) {
                digest.update(buffer, 0, bytesRead)
            }
        }
        digest.digest().joinToString("") { "%02x".format(it) }
    }
}