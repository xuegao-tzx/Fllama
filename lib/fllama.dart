import "package:fllama/fllama_type.dart";

import "fllama_platform_interface.dart";

class Fllama {
  static Fllama? _instance;

  Fllama._();

  static Fllama? instance() {
    _instance ??= Fllama._();
    return _instance;
  }

  Stream<Map<Object?, dynamic>>? get onTokenStream {
    return FllamaPlatform.instance.onTokenStream;
  }

  Future<String?> getFileSHA256(String fPath) {
    return FllamaPlatform.instance.getFileSHA256(fPath);
  }

  Future<Map<Object?, dynamic>?> getCpuInfo() {
    return FllamaPlatform.instance.getCpuInfo();
  }

  Future<Map<Object?, dynamic>?> initContext(String model,
      {bool embedding = false,
      int nCtx = 512,
      int nBatch = 512,
      int nThreads = 0,
      int nGpuLayers = 0,
      bool useMlock = true,
      bool useMmap = true,
      String lora = "",
      double loraScaled = 1.0,
      double ropeFreqBase = 0.0,
      double ropeFreqScale = 0.0,
      bool loraInitWithoutApply = false,
      bool emitLoadProgress = false}) {
    return FllamaPlatform.instance.initContext(model,
        embedding: embedding,
        nCtx: nCtx,
        nBatch: nBatch,
        nThreads: nThreads,
        nGpuLayers: nGpuLayers,
        useMlock: useMlock,
        useMmap: useMmap,
        lora: lora,
        loraScaled: loraScaled,
        loraInitWithoutApply: loraInitWithoutApply,
        ropeFreqBase: ropeFreqBase,
        ropeFreqScale: ropeFreqScale,
        emitLoadProgress: emitLoadProgress);
  }

  Future<String?> getFormattedChat(double contextId,
      {required List<RoleContent> messages, String? chatTemplate}) {
    return FllamaPlatform.instance.getFormattedChat(contextId,
        messages: messages, chatTemplate: chatTemplate);
  }

  Future<Map<Object?, dynamic>?> loadSession(double contextId,
      {required String path}) {
    return FllamaPlatform.instance.loadSession(contextId, path: path);
  }

  Future<int?> saveSession(double contextId,
      {required String path, required double size}) {
    return FllamaPlatform.instance
        .saveSession(contextId, path: path, size: size);
  }

  Future<Map<Object?, dynamic>?> completion(double contextId,
      {required String prompt,
      List<List<double>>? logitBias,
      String grammar = "",
      double temperature = 0.7,
      int nThreads = 0,
      int nPredict = -1,
      int nProbs = 0,
      int penaltyLastN = 64,
      double penaltyRepeat = 1.0,
      double penaltyFreq = 0.0,
      double penaltyPresent = 0.0,
      double mirostat = 0.0,
      double mirostatTau = 5.0,
      double mirostatEta = 0.1,
      bool penalizeNl = false,
      int topK = 40,
      double topP = 0.95,
      double minP = 0.05,
      double typicalP = 1.0,
      int seed = -1,
      List<String>? stop,
      bool ignoreEos = false,
      bool emitRealtimeCompletion = false}) {
    return FllamaPlatform.instance.completion(contextId,
        prompt: prompt,
        logitBias: logitBias,
        grammar: grammar,
        temperature: temperature,
        nThreads: nThreads,
        nPredict: nPredict,
        nProbs: nProbs,
        penaltyLastN: penaltyLastN,
        penaltyRepeat: penaltyRepeat,
        penaltyFreq: penaltyFreq,
        penaltyPresent: penaltyPresent,
        mirostat: mirostat,
        mirostatTau: mirostatTau,
        mirostatEta: mirostatEta,
        penalizeNl: penalizeNl,
        topK: topK,
        topP: topP,
        minP: minP,
        typicalP: typicalP,
        seed: seed,
        stop: stop,
        ignoreEos: ignoreEos,
        emitRealtimeCompletion: emitRealtimeCompletion);
  }

  Future<void> stopCompletion({required double contextId}) {
    return FllamaPlatform.instance.stopCompletion(contextId);
  }

  Future<Map<Object?, dynamic>?> tokenize(double contextId,
      {required String text}) {
    return FllamaPlatform.instance.tokenize(contextId, text: text);
  }

  Future<String?> detokenize(double contextId, {required List<int> tokens}) {
    return FllamaPlatform.instance.detokenize(contextId, tokens: tokens);
  }

  Future<String?> bench(double contextId,
      {required double pp,
      required double tg,
      required double pl,
      required double nr}) {
    return FllamaPlatform.instance
        .bench(contextId, pp: pp, tg: tg, pl: pl, nr: nr);
  }

  Future<void> releaseContext(double contextId) {
    return FllamaPlatform.instance.releaseContext(contextId);
  }

  Future<void> releaseAllContexts() {
    return FllamaPlatform.instance.releaseAllContexts();
  }
}
