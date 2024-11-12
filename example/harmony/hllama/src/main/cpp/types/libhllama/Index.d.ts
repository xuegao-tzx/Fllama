export const initLlamaContext: (model: string) => Promise<string>;

export const getModelDetail: (contextId: string) => { desc: string, size: string, nParams: string, isChatTemplateSupported: string };

export const startCompletion: (contextId: string, prompt: string, resultCallback: (result: string) => void,
  realTimeCallback: (result: string) => void) => void;

export const stopCompletion: (contextId: string) => void;

export const freeLlamaContext: (contextId: string) => void;
