# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html
-ignorewarnings
-optimizationpasses 6
-verbose
-dontusemixedcaseclassnames
-optimizations code/simplification/arithmetic,code/simplification/cast,field/*,class/merging/vertical,code/allocation/variable#高级
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keep class androidx.lifecycle.DefaultLifecycleObserver