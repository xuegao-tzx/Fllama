package ink.xcl.fllama

import androidx.annotation.Keep

@Keep
object FllamaData {
    @JvmStatic
    fun createHashMap(): HashMap<String, Any> {
        //FLog.d("[FllamaData] createHashMap")
        val map = HashMap<String, Any>()
        return map
    }

    @JvmStatic
    fun getInt(
        map: HashMap<String, Any>,
        key: String,
        default: Int
    ): Int {
        //FLog.d("[FllamaData] getInt")
        return map[key] as? Int ?: default
    }

    @JvmStatic
    fun putInt(map: HashMap<String, Any>, key: String, value: Int): HashMap<String, Any> {
        //FLog.d("[FllamaData] putInt")
        map[key] = value
        return map
    }

    @JvmStatic
    fun getString(
        map: HashMap<String, Any>,
        key: String,
        default: String
    ): String {
        //FLog.d("[FllamaData] getString")
        return map[key] as? String ?: default
    }

    @JvmStatic
    fun putString(map: HashMap<String, Any>, key: String, value: String): HashMap<String, Any> {
        //FLog.d("[FllamaData] putString")
        map[key] = value
        return map
    }

    @JvmStatic
    fun getDouble(
        map: HashMap<String, Any>,
        key: String,
        default: Double
    ): Double {
        //FLog.d("[FllamaData] getDouble")
        return map[key] as? Double ?: default
    }

    @JvmStatic
    fun putDouble(map: HashMap<String, Any>, key: String, value: Double): HashMap<String, Any> {
        //FLog.d("[FllamaData] putDouble")
        map[key] = value
        return map
    }

    @JvmStatic
    fun getFloat(
        map: HashMap<String, Any>,
        key: String,
        default: Float
    ): Float {
        //FLog.d("[FllamaData] getFloat")
        return map[key] as? Float ?: default
    }

    @JvmStatic
    fun putFloat(map: HashMap<String, Any>, key: String, value: Float): HashMap<String, Any> {
        //FLog.d("[FllamaData] putFloat")
        map[key] = value
        return map
    }

    @JvmStatic
    fun getBoolean(
        map: HashMap<String, Any>,
        key: String,
        default: Boolean
    ): Boolean {
        //FLog.d("[FllamaData] getBoolean")
        return map[key] as? Boolean ?: default
    }

    @JvmStatic
    fun putBoolean(map: HashMap<String, Any>, key: String, value: Boolean): HashMap<String, Any> {
        //FLog.d("[FllamaData] putBoolean")
        map[key] = value
        return map
    }

    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun getMap(
        map: HashMap<String, Any>,
        key: String,
        default: HashMap<String, Any>
    ): HashMap<String, Any> {
        //FLog.d("[FllamaData] getMap")
        return map[key] as? HashMap<String, Any> ?: default
    }

    @JvmStatic
    fun putMap(
        map: HashMap<String, Any>,
        key: String,
        value: HashMap<String, Any>
    ): HashMap<String, Any> {
        //FLog.d("[FllamaData] putMap")
        map[key] = value
        return map
    }

    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun getArray(
        map: HashMap<String, Any>,
        key: String,
        default: Array<Any>
    ): Array<Any> {
        //FLog.d("[FllamaData] getArray")
        return map[key] as? Array<Any> ?: default
    }

    @JvmStatic
    @Suppress("UNCHECKED_CAST")
    fun putArray(map: HashMap<String, Any>, key: String, value: Array<Any>): HashMap<String, Any> {
        //FLog.d("[FllamaData] putArray")
        if (value.isArrayOf<HashMap<String, Any>>()) {
            //FLog.d("[FllamaData] putArrayMap = $value ${value.size}")
            map[key] = value.map { it as HashMap<String, Any> }
        } else {
            map[key] = value
        }
        return map
    }

    @JvmStatic
    fun createHashMapArray(size: Int): Array<HashMap<String, Any>> {
        //FLog.d("[FllamaData] createHashMapArray")
        return Array(size) { HashMap() }
    }

    @JvmStatic
    fun putHashMapArray(
        arrayMap: Array<HashMap<String, Any>>,
        map: HashMap<String, Any>,
        index: Int
    ): Array<HashMap<String, Any>> {
        //FLog.d("[FllamaData] putHashMapArray")
        arrayMap[index] = map
        return arrayMap
    }
}