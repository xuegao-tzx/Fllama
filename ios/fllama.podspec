#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fllama.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fllama'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://www.xcl.ink'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Small Grass Forest' => 'zixuanxcl@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = "Classes/**/*.{h,m,mm}", "Cpp/**/*.{h,cpp,hpp,c,m,mm}", "Cpp/**/*.{metal}"
  s.resources = "Cpp/**/*.{metallib}"
  s.compiler_flags = "-fno-objc-arc -DLM_GGML_USE_ACCELERATE -DLM_GGML_USE_METAL -DLM_GGML_METAL_NDEBUG -Wno-shorten-64-to-32 -Wno-comma"
  # including C++ library
  s.library = "c++"
  s.pod_target_xcconfig = {
     "MAKEFLAGS" => "-j8",
     "ENABLE_BITCODE" => "NO",
     "DEFINES_MODULE" => "YES",
     "LDPLUSPLUSFLAGS" => "-flto",
     "OTHER_LDFLAGS" => "-flto=thin -framework Accelerate -framework Foundation -framework Metal -framework MetalKit -framework AVFoundation -framework AudioToolbox -lc++",
     "CLANG_CXX_LIBRARY" => "libc++",
     "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
     "OTHER_CFLAGS" => "-O3 -DNDEBUG -funroll-loops -fomit-frame-pointer -fvisibility-inlines-hidden -ffunction-sections -fdata-sections",
     "OTHER_CPLUSPLUSFLAGS" => "-O3 -DNDEBUG -funroll-loops -fomit-frame-pointer -fvisibility-inlines-hidden -ffunction-sections -fdata-sections",
     # Flutter.framework does not contain a i386 slice.
     "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "i386"
  }
  s.swift_version = '5.0'
  s.dependency 'Flutter'
  s.platform = :ios, '14.0'
  # Set as a static lib
  # s.static_framework = true
  # module_map is needed so this module can be used as a framework
  s.module_map = 'fllama.modulemap'
  s.resource_bundles = {'fllama_flutter_libs_apple_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
