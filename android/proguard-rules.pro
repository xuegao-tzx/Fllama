# Proguard rules for the Fllama library
## Keep all classes in the ink.xcl.fllama package
-keep public class * extends android.app.Service
-keep class ink.xcl.fllama.** { *; }
-keep class ink.xcl.fllama.FLlama { *; }
-keep class ink.xcl.fllama.FllamaData { *; }
-keep class ink.xcl.fllama.FllamaPlugin { *; }
-keep class ink.xcl.fllama.FllamaService { *; }
-keep class ink.xcl.fllama.LlamaContext { *; }
-keepclassmembers class ink.xcl.fllama.LlamaContext { *; }
-keepnames class ink.xcl.fllama.LlamaContext { *; }
-keepclassmembernames class ink.xcl.fllama.LlamaContext { *; }
## Keep native methods
-keep class * {
    native <methods>;
}
-keepclassmembers class * {
    @kotlin.jvm.JvmStatic <methods>;
}
-keepclasseswithmembernames class * {
    native <methods>;
}
-dontwarn java.lang.invoke.**
-keep class java.lang.invoke.** { *; }
-dontwarn java.lang.invoke.StringConcatFactory
-keep class java.lang.invoke.StringConcatFactory { *; }
## Keep kotlin classes
-keep class kotlin.** { *; }
-keep class kotlin.coroutines.** { *; }
-keep class kotlinx.coroutines.** { *; }
-keep class kotlinx.coroutines.internal.** { *; }
-keep class kotlinx.coroutines.channels.** { *; }
-keep class kotlinx.coroutines.flow.** { *; }
-keep class kotlinx.coroutines.debug.** { *; }