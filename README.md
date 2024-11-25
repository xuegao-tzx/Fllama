# FCllama

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![pub package](https://img.shields.io/pub/v/fcllama.svg?label=fcllama&color=blue)](https://pub.dev/packages/fcllama)

Flutter binding of [llama.cpp](https://github.com/ggerganov/llama.cpp) , which use platform channel .

[llama.cpp](https://github.com/ggerganov/llama.cpp): Inference of [LLaMA](https://arxiv.org/abs/2302.13971) model in pure C/C++

## Installation

### Flutter

```sh
flutter pub add fcllama
```

#### iOS

Please run `pod install` or `pod update` in your iOS project.

#### Android

You need install cmake 3.31.0、android sdk 35 and ndk 28.0.12674087.
No additional operation required .

### OpenHarmonyOS/HarmonyOS

This is the fastest and recommended way to add HLlama to your project.
```bash
ohpm install hllama
```

Or, you can add it to your project manually.
* Add the following lines to `oh-package.json5` on your app module.

```json
"dependencies": {
  "hllama": "^0.0.2",
}
```

* Then run

```bash
  ohpm install
```

## How to use

### Flutter

1. Initializing Llama

```dart
import 'package:fcllama/fllama.dart';

FCllama.instance()?.initContext("model path",emitLoadProgress: true)
        .then((context) {
  modelContextId = context?["contextId"].toString() ?? "";
  if (modelContextId.isNotEmpty) {
    // you can get modelContextId，if modelContextId > 0 is success.
  }
});
```

2. Bench model on device

```dart
import 'package:fcllama/fllama.dart';

FCllama.instance()?.bench(double.parse(modelContextId),pp:8,tg:4,pl:2,nr: 1).then((res){
  Get.log("[FCllama] Bench Res $res");
});
```

3. Tokenize and Detokenize

```dart
import 'package:fcllama/fllama.dart';

FCllama.instance()?.tokenize(double.parse(modelContextId), text: "What can you do?").then((res){
  Get.log("[FCllama] Tokenize Res $res");
  FCllama.instance()?.detokenize(double.parse(modelContextId), tokens: res?['tokens']).then((res){
    Get.log("[FCllama] Detokenize Res $res");
  });
});
```

4. Streaming monitoring

```dart
import 'package:fcllama/fllama.dart';

FCllama.instance()?.onTokenStream?.listen((data) {
  if(data['function']=="loadProgress"){
    Get.log("[FCllama] loadProgress=${data['result']}");
  }else if(data['function']=="completion"){
    Get.log("[FCllama] completion=${data['result']}");
    final tempRes = data["result"]["token"];
    // tempRes is ans
  }
});
```

5. Release this or Stop one

```dart
import 'package:fcllama/fllama.dart';

FCllama.instance()?.stopCompletion(contextId: double.parse(modelContextId)); // stop one completion
FCllama.instance()?.releaseContext(double.parse(modelContextId)); // release one
FCllama.instance()?.releaseAllContexts(); // release all
```

### OpenHarmonyOS/HarmonyOS

You can see [this file](./example/harmony/hllama/README.md)

## Support System

| System | Min SDK | Arch | Other |
|:--:|:--:|:--:|:--:|
| Android | 23 | arm64-v8a、x86_64、armeabi-v7a | Supports additional optimizations for certain CPUs |
| iOS | 14 | arm64 | Support Metal |
| OpenHarmonyOS/HarmonyOS | 12 | arm64-v8a、x86_64 | No additional optimizations for certain CPUs are supported |


## Obtain the model

You can search HuggingFace for available models (Keyword: [`GGUF`](https://huggingface.co/search/full-text?q=GGUF&type=model)).

For get a GGUF model or quantize manually, see [`Prepare and Quantize`](https://github.com/ggerganov/llama.cpp?tab=readme-ov-file#prepare-and-quantize) section in llama.cpp.

## NOTE

iOS:

- The [Extended Virtual Addressing](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_kernel_extended-virtual-addressing) capability is recommended to enable on iOS project.
- Metal:
    - We have tested to know some devices is not able to use Metal ('params.n_gpu_layers > 0') due to llama.cpp used SIMD-scoped operation, you can check if your device is supported in [Metal feature set tables](https://developer.apple.com/metal/Metal-Feature-Set-Tables.pdf), Apple7 GPU will be the minimum requirement.
    - It's also not supported in iOS simulator due to [this limitation](https://developer.apple.com/documentation/metal/developing_metal_apps_that_run_in_simulator#3241609), we used constant buffers more than 14.

Android:

- Currently only supported arm64-v8a / x86_64 / armeabi-v7a platform, this means you can't initialize a context on another platforms. The 64-bit platform are recommended because it can allocate more memory for the model.
- No integrated any GPU backend yet.

## License

MIT