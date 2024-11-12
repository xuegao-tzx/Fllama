#include <jni.h>
extern "C" {
    namespace futils {
        jint getInt(JNIEnv *env, jobject hashMap, const char *key, jint defaultValue) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return defaultValue;
            }
            jmethodID getIntMethod = env->GetStaticMethodID(fllamaDataClass, "getInt",
                                                            "(Ljava/util/HashMap;Ljava/lang/String;I)I");
            if (getIntMethod == nullptr) {
                return defaultValue;
            }
            jstring keyStr = env->NewStringUTF(key);
            jint result = env->CallStaticIntMethod(fllamaDataClass, getIntMethod, hashMap, keyStr, defaultValue);
            env->DeleteLocalRef(keyStr);
            return result;
        }

        void putInt(JNIEnv *env, jobject hashMap, const char *key, jint value) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return;
            }
            jmethodID putIntMethod = env->GetStaticMethodID(fllamaDataClass, "putInt",
                                                            "(Ljava/util/HashMap;Ljava/lang/String;I)Ljava/util/HashMap;");
            if (putIntMethod == nullptr) {
                return;
            }
            jstring keyStr = env->NewStringUTF(key);
            env->CallStaticObjectMethod(fllamaDataClass, putIntMethod, hashMap, keyStr, value);
            env->DeleteLocalRef(keyStr);
        }

        jstring getString(JNIEnv *env, jobject hashMap, const char *key, const char *defaultValue) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return env->NewStringUTF(defaultValue);
            }
            jmethodID getStringMethod = env->GetStaticMethodID(fllamaDataClass, "getString",
                                                               "(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;");
            if (getStringMethod == nullptr) {
                return env->NewStringUTF(defaultValue);
            }
            jstring keyStr = env->NewStringUTF(key);
            jstring defaultStr = env->NewStringUTF(defaultValue);
            jstring result = (jstring)env->CallStaticObjectMethod(fllamaDataClass, getStringMethod, hashMap, keyStr, defaultStr);
            env->DeleteLocalRef(keyStr);
            env->DeleteLocalRef(defaultStr);
            return result;
        }

        void putString(JNIEnv *env, jobject hashMap, const char *key, const char *value) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return;
            }
            jmethodID putStringMethod = env->GetStaticMethodID(fllamaDataClass, "putString",
                                                               "(Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/String;)Ljava/util/HashMap;");
            if (putStringMethod == nullptr) {
                return;
            }
            jstring keyStr = env->NewStringUTF(key);
            jstring valueStr = env->NewStringUTF(value);
            env->CallStaticObjectMethod(fllamaDataClass, putStringMethod, hashMap, keyStr,
                                        valueStr);
            env->DeleteLocalRef(keyStr);
            env->DeleteLocalRef(valueStr);
        }

        jdouble getDouble(JNIEnv *env, jobject hashMap, const char *key, jdouble defaultValue) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return defaultValue;
            }
            jmethodID getDoubleMethod = env->GetStaticMethodID(fllamaDataClass, "getDouble",
                                                               "(Ljava/util/HashMap;Ljava/lang/String;D)D");
            if (getDoubleMethod == nullptr) {
                return defaultValue;
            }
            jstring keyStr = env->NewStringUTF(key);
            jdouble result = env->CallStaticDoubleMethod(fllamaDataClass, getDoubleMethod, hashMap, keyStr, defaultValue);
            env->DeleteLocalRef(keyStr);
            return result;
        }

        void putDouble(JNIEnv *env, jobject hashMap, const char *key, jdouble value) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return;
            }
            jmethodID putDoubleMethod = env->GetStaticMethodID(fllamaDataClass, "putDouble",
                                                               "(Ljava/util/HashMap;Ljava/lang/String;D)Ljava/util/HashMap;");
            if (putDoubleMethod == nullptr) {
                return;
            }
            jstring keyStr = env->NewStringUTF(key);
            env->CallStaticObjectMethod(fllamaDataClass, putDoubleMethod, hashMap, keyStr, value);
            env->DeleteLocalRef(keyStr);
        }

        jboolean getBoolean(JNIEnv *env, jobject hashMap, const char *key, jboolean defaultValue) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return defaultValue;
            }
            jmethodID getBooleanMethod = env->GetStaticMethodID(fllamaDataClass, "getBoolean",
                                                                "(Ljava/util/HashMap;Ljava/lang/String;Z)Z");
            if (getBooleanMethod == nullptr) {
                return defaultValue;
            }
            jstring keyStr = env->NewStringUTF(key);
            jboolean result = env->CallStaticBooleanMethod(fllamaDataClass, getBooleanMethod, hashMap, keyStr, defaultValue);
            env->DeleteLocalRef(keyStr);
            return result;
        }

        void putBoolean(JNIEnv *env, jobject hashMap, const char *key, jboolean value) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return;
            }
            jmethodID putBooleanMethod = env->GetStaticMethodID(fllamaDataClass, "putBoolean",
                                                                "(Ljava/util/HashMap;Ljava/lang/String;Z)Ljava/util/HashMap;");
            if (putBooleanMethod == nullptr) {
                return;
            }
            jstring keyStr = env->NewStringUTF(key);
            env->CallStaticObjectMethod(fllamaDataClass, putBooleanMethod, hashMap, keyStr, value);
            env->DeleteLocalRef(keyStr);
        }

        jfloat getFloat(JNIEnv *env, jobject hashMap, const char *key, jfloat defaultValue) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return defaultValue;
            }
            jmethodID getFloatMethod = env->GetStaticMethodID(fllamaDataClass, "getFloat",
                                                              "(Ljava/util/HashMap;Ljava/lang/String;F)F");
            if (getFloatMethod == nullptr) {
                return defaultValue;
            }
            jstring keyStr = env->NewStringUTF(key);
            jfloat result = env->CallStaticFloatMethod(fllamaDataClass, getFloatMethod, hashMap, keyStr, defaultValue);
            env->DeleteLocalRef(keyStr);
            return result;
        }

        jobject putFloat(JNIEnv *env, jobject hashMap, const char *key, jfloat value) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return hashMap;
            }
            jmethodID putFloatMethod = env->GetStaticMethodID(fllamaDataClass, "putFloat",
                                                              "(Ljava/util/HashMap;Ljava/lang/String;F)Ljava/util/HashMap;");
            if (putFloatMethod == nullptr) {
                return hashMap;
            }
            jstring keyStr = env->NewStringUTF(key);
            jobject resultMap = env->CallStaticObjectMethod(fllamaDataClass, putFloatMethod, hashMap, keyStr, value);
            env->DeleteLocalRef(keyStr);
            return resultMap;
        }

        jobject getMap(JNIEnv *env, jobject hashMap, const char *key, jobject defaultMap) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return defaultMap;
            }
            jmethodID getMapMethod = env->GetStaticMethodID(fllamaDataClass, "getMap",
                                                            "(Ljava/util/HashMap;Ljava/lang/String;Ljava/util/HashMap;)Ljava/util/HashMap;");
            if (getMapMethod == nullptr) {
                return defaultMap;
            }
            jstring keyStr = env->NewStringUTF(key);
            jobject resultMap = env->CallStaticObjectMethod(fllamaDataClass, getMapMethod, hashMap, keyStr, defaultMap);
            env->DeleteLocalRef(keyStr);
            return resultMap;
        }

        void putMap(JNIEnv *env, jobject hashMap, const char *key, jobject valueMap) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return;
            }
            jmethodID putMapMethod = env->GetStaticMethodID(fllamaDataClass, "putMap",
                                                            "(Ljava/util/HashMap;Ljava/lang/String;Ljava/util/HashMap;)Ljava/util/HashMap;");
            if (putMapMethod == nullptr) {
                return;
            }
            jstring keyStr = env->NewStringUTF(key);
            env->CallStaticObjectMethod(fllamaDataClass, putMapMethod, hashMap, keyStr, valueMap);
            env->DeleteLocalRef(keyStr);
        }

        jobjectArray getArray(JNIEnv *env, jobject hashMap, const char *key, jobjectArray defaultArray) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return defaultArray;
            }
            jmethodID getArrayMethod = env->GetStaticMethodID(fllamaDataClass, "getArray",
                                                              "(Ljava/util/HashMap;Ljava/lang/String;[Ljava/lang/Object;)[Ljava/lang/Object;");
            if (getArrayMethod == nullptr) {
                return defaultArray;
            }
            jstring keyStr = env->NewStringUTF(key);
            jobjectArray resultArray = (jobjectArray)env->CallStaticObjectMethod(fllamaDataClass, getArrayMethod, hashMap, keyStr, defaultArray);
            env->DeleteLocalRef(keyStr);
            return resultArray;
        }

        void putArray(JNIEnv *env, jobject hashMap, const char *key, jobject valueArray) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return;
            }
            jmethodID putArrayMethod = env->GetStaticMethodID(fllamaDataClass, "putArray",
                                                              "(Ljava/util/HashMap;Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/HashMap;");
            if (putArrayMethod == nullptr) {
                return;
            }
            jstring keyStr = env->NewStringUTF(key);
            env->CallStaticObjectMethod(fllamaDataClass, putArrayMethod, hashMap, keyStr,
                                        valueArray);
            env->DeleteLocalRef(keyStr);
        }

        jobject createMap(JNIEnv *env) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return nullptr;
            }
            jmethodID createHashMapMethod = env->GetStaticMethodID(fllamaDataClass, "createHashMap",
                                                                   "()Ljava/util/HashMap;");
            if (createHashMapMethod == nullptr) {
                return nullptr;
            }
            jobject hashMap = env->CallStaticObjectMethod(fllamaDataClass, createHashMapMethod);
            if (hashMap == nullptr) {
                return nullptr;
            }
            return hashMap;
        }

        jobjectArray createHashMapArray(JNIEnv *env, jint size) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            if (fllamaDataClass == nullptr) {
                return nullptr;
            }
            jmethodID createHashMapArrayMethod = env->GetStaticMethodID(fllamaDataClass,
                                                                        "createHashMapArray",
                                                                        "(I)[Ljava/util/HashMap;");
            if (createHashMapArrayMethod == nullptr) {
                return nullptr;
            }
            jobjectArray hashMapArray = (jobjectArray) env->CallStaticObjectMethod(fllamaDataClass,
                                                                                   createHashMapArrayMethod,
                                                                                   size);
            if (hashMapArray == nullptr) {
                return nullptr;
            }
            return hashMapArray;
        }

        void putHashMapArray(JNIEnv *env, jobjectArray arrayMap, jobject map, jint index) {
            jclass fllamaDataClass = env->FindClass("ink/xcl/fllama/FllamaData");
            jmethodID putMethodID = env->GetStaticMethodID(
                    fllamaDataClass,
                    "putHashMapArray",
                    "([Ljava/util/HashMap;Ljava/util/HashMap;I)[Ljava/util/HashMap;"
            );
            if (putMethodID == nullptr) {
                return;
            }
            jobjectArray result = (jobjectArray) env->CallStaticObjectMethod(
                    fllamaDataClass,
                    putMethodID,
                    arrayMap,
                    map,
                    index
            );
            if (result == nullptr) {
                return;
            }
            env->SetObjectArrayElement(arrayMap, index, map);
        }

        struct callback_context {
            JNIEnv *env;
            jobject completion_callback;
        };
    }
}