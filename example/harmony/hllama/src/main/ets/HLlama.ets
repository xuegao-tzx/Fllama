import native from 'libhllama.so';

interface ModelDetailInterface {
  desc: string;
  size: number;
  nParams: number;
  isChatTemplateSupported: boolean;
}

export class HLlama {
  /**
   * 异步初始化模型
   * @param model 模型路径
   * @returns 初始化Id
   */
  public static initLlamaContext(model:string): Promise<string> {
    return native.initLlamaContext(model);
  }
  /**
   * 同步初始化模型
   * @param model 模型路径
   * @param resultCallback 初始化Id回调
   */
  public static initLlamaContextSync(model:string,resultCallback: (result: string) => void): void {
    native.initLlamaContext(model).then((res)=>{
      resultCallback(res);
    });
  }
  /**
   * 获取模型信息
   * @param contextId
   * @returns ModelDetailInterface 模型信息
   */
  public static getModelDetailSync(contextId: string): ModelDetailInterface {
    let modelDetail = native.getModelDetail(contextId);
    return {
      desc: modelDetail.desc,
      size: Number(modelDetail.size),
      nParams: Number(modelDetail.nParams),
      isChatTemplateSupported: Boolean(modelDetail.isChatTemplateSupported)
    }
  }
  /**
   * 开始模型推理
   * @param contextId 初始化Id
   * @param prompt 输入内容（提示词）
   * @param resultCallback 结果回调
   * @param realTimeCallback 实时结果回调
   */
  public static startCompletionSync(contextId: string, prompt: string, resultCallback: (result: string) => void, realTimeCallback: (result: string) => void): void {
    return native.startCompletion(contextId, prompt, resultCallback, realTimeCallback);
  }
  /**
   * 终止模型推理
   * @param contextId 初始化Id
   */
  public static stopCompletionSync(contextId: string): void {
    native.stopCompletion(contextId);
  }
  /**
   * 释放环境
   * @param contextId 初始化Id
   */
  public static freeLlamaContextSync(contextId: string):void {
    native.freeLlamaContext(contextId);
  }
}