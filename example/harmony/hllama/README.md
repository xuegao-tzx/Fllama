[![license](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/xuegao-tzx)
[![Release Version](https://img.shields.io/badge/release-0.0.1-brightgreen.svg)](https://ohpm.openharmony.cn/#/cn/detail/hllama/v/0.0.1)
[![Platform](https://img.shields.io/badge/Platform-%20HarmonyOS%20NEXT-brightgreen.svg)](https://github.com/xuegao-tzx)

# Llama for HarmonyOS NEXT

## Features

1. Support offline local reasoning of gguf format text models.
2. Easy to use

## Getting Started

### Prerequisites

* Apps using HLlama can target: HarmonyOS Next (3.0.0.13) or later (API 12).
* ARM64 & x86_64 architecture.
* DevEco Studio NEXT Developer Beta1 (5.0.3.100) or later.

### Installation via OHPM:

This is the fastest and recommended way to add HLlama to your project.

```bash
ohpm install hllama
```

Or, you can add it to your project manually.
* Add the following lines to `oh-package.json5` on your app module.

  ```json
  "dependencies": {
      "hllama": "^0.0.1",
  }
  ```
  
* Then run

  ```bash
  ohpm install
  ```

### How to Use

1. Initializing Llama asynchronously

```js
import { HLlama } from 'hllama';

HLlama.initLlamaContext(filesDir + '/llama.gguf').then((initId) => {
    // you can get initId，if initId > 0 is success.
});
```

2. Initialize Llama synchronously

```js
import { HLlama } from 'hllama';

HLlama.initLlamaContextSync(filesDir + '/llama.gguf',(initId)=>{
    // you can get initId，if initId > 0 is success.
})
```

3. Get model details synchronously

```js
import { HLlama } from 'hllama';

let model = HLlama.getModelDetailSync(initId);
// interface ModelDetailInterface {
//     desc: string;
//     size: number;
//     nParams: number;
//     isChatTemplateSupported: boolean;
// }
```

4. Start model inference synchronously

```js
import { HLlama } from 'hllama';

HLlama.startCompletionSync(initId.toString(), prompt, (output) => {
    //This callback outputs the final result
},(realTimeOutput)=>{
    //This callback outputs real-time inference results
});
```

5. Synchronously terminate model inference

```js
import { HLlama } from 'hllama';

HLlama.stopCompletionSync(initId.toString());
```

6. Synchronously release the inference process

```js
import { HLlama } from 'hllama';

HLlama.freeLlamaContextSync(initId.toString());
```

## License

HLlama is published under the MIT license. For details check out the [LICENSE](./LICENSE).

## Change Log

Check out the [CHANGELOG.md](./CHANGELOG.md) for details of change history.

## FeedBack

If you have any questions or suggestions, please contact me by email at [zixuanxcl@gmail.com](mailto:zixuanxcl@gmail.com).