import { hilog } from '@kit.PerformanceAnalysisKit';
import fs from '@ohos.file.fs';
import { common } from '@kit.AbilityKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import { HLlama } from 'hllama';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text("推理")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            hilog.error(0x0006, 'HLlama', '点击推理');
            let context = getContext(this) as common.UIAbilityContext;
            let filesDir = context.filesDir;
            let fileAccess = fs.accessSync(filesDir + '/llama.gguf');
            hilog.error(0x0006, 'HLlama', '文件是否存在：' + fileAccess);
            hilog.error(0x0006, 'HLlama', '文件路径：' + filesDir + '/llama.gguf');
            if (fileAccess) {
              HLlama.initLlamaContext(filesDir + '/llama.gguf').then((initRes) => {
                hilog.error(0x0006, 'HLlama', '初始化结果 == %{public}s', initRes);
                let model = HLlama.getModelDetailSync(initRes);
                hilog.error(0x0006, 'HLlama', '模型信息：' + JSON.stringify(model));
                // HLlama.startCompletionSync(initRes.toString(), "Hi", (output) => {
                //   hilog.error(0x0006, 'HLlama', '推理结果 = ' + output);
                // },(res)=>{
                //   hilog.error(0x0006, 'HLlama', '推理实时结果=' + res);
                // });
              });
            }
          })
        Button("下载")
          .fontSize(35)
          .onClick(() => {
            hilog.error(0x0006, 'HLlama', '点击下载');
            let context = getContext(this) as common.UIAbilityContext;
            let filesDir = context.filesDir;
            let fileAccess = fs.accessSync(filesDir + '/llama.gguf');
            hilog.error(0x0006, 'HLlama', '文件是否存在：' + fileAccess);
            hilog.error(0x0006, 'HLlama', '文件路径：' + filesDir + '/llama.gguf');
            if (fileAccess) {
              HLlama.initLlamaContext(filesDir + '/llama.gguf').then((initRes) => {
                hilog.error(0x0006, 'HLlama', '初始化结果 = %{public}s', initRes);
              }).catch((err: BusinessError) => {
                hilog.error(0x0006, 'HLlama', '初始化异常' + err.code);
                //fs.unlinkSync(filesDir + '/llama.gguf');//删除文件
              });
            } else {
              try {
                hilog.error(0x0006, 'HLlama', '开始下载');
                request.downloadFile(context, {
                  url: "https://hf-mirror.com/TheBloke/Llama-2-7B-32K-Instruct-GGUF/resolve/main/llama-2-7b-32k-instruct.Q2_K.gguf",
                  filePath: filesDir + '/llama.gguf'
                }).then((downloadTask: request.DownloadTask) => {
                  downloadTask.on('complete', () => {
                    hilog.error(0x0006, 'HLlama', 'download complete');
                    hilog.error(0x0006, 'HLlama', ('Path=' + filesDir + '/llama.gguf'));
                    // let file = fs.openSync(filesDir + '/xxxx.txt', fs.OpenMode.READ_WRITE);
                    // let arrayBuffer = new ArrayBuffer(1024);
                    // let readLen = fs.readSync(file.fd, arrayBuffer);
                    // let buf = buffer.from(arrayBuffer, 0, readLen);
                    // hilog.error(0x0006, 'HLlama', `The content of file: ${buf.toString()}`);
                    // fs.closeSync(file);
                  })
                  downloadTask.on('progress', (receivedSize: number, totalSize: number) => {
                    hilog.error(0x0006, 'HLlama', 'download progress');
                    hilog.error(0x0006, 'HLlama', ('progress=' + receivedSize / totalSize));
                    // let file = fs.openSync(filesDir + '/xxxx.txt', fs.OpenMode.READ_WRITE);
                    // let arrayBuffer = new ArrayBuffer(1024);
                    // let readLen = fs.readSync(file.fd, arrayBuffer);
                    // let buf = buffer.from(arrayBuffer, 0, readLen);
                    // hilog.error(0x0006, 'HLlama', `The content of file: ${buf.toString()}`);
                    // fs.closeSync(file);
                  })
                }).catch((err: BusinessError) => {
                  hilog.error(0x0006, 'HLlama',
                    `Invoke downloadTask failed, code is ${err.code}, message is ${err.message}`);
                });
              } catch (error) {
                let err: BusinessError = error as BusinessError;
                hilog.error(0x0006, 'HLlama',
                  `Invoke downloadFile failed, code is ${err.code}, message is ${err.message}`);
              }
            }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
