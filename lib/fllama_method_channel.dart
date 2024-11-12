import "package:fllama/fllama_type.dart";
import "package:flutter/services.dart";

import "fllama_platform_interface.dart";

/// An implementation of [FllamaPlatform] that uses method channels.
class MethodChannelFllama extends FllamaPlatform {
  /// The method channel used to interact with the native platform.
  final methodChannel = const MethodChannel("fllama");
  final eventChannel = const EventChannel("fllama_event_channel");

  @override
  Stream<Map<Object?, dynamic>> get onTokenStream {
    return eventChannel
        .receiveBroadcastStream()
        .map((event) => Map<Object?, dynamic>.from(event));
  }

  // === Utils ===
  @override
  Future<Map<Object?, dynamic>?> getCpuInfo() async {
    return await methodChannel
        .invokeMethod<Map<Object?, dynamic>>("getCpuInfo");
  }

  @override
  Future<String?> getFileSHA256(String filePath) async {
    return await methodChannel
        .invokeMethod<String>("getFileSHA256", {"filePath": filePath});
  }

  // === LLama ===
  @override
  Future<Map<Object?, dynamic>?> initContext(String model,
      {int modelType = 1,
      bool embedding = false,
      int nCtx = 768,
      int nBatch = 768,
      int nThreads = 2,
      int nGpuLayers = 0,
      bool useMlock = true,
      bool useMmap = true,
      String lora = "",
      bool loraInitWithoutApply = false,
      double loraScaled = 1.0,
      double ropeFreqBase = 0.0,
      double ropeFreqScale = 0.0,
      bool emitLoadProgress = false}) async {
    return await methodChannel
        .invokeMethod<Map<Object?, dynamic>>("initContext", {
      "model": model,
      "modelType": modelType,
      "embedding": embedding,
      "n_ctx": nCtx,
      "n_batch": nBatch,
      "n_threads": nThreads,
      "n_gpu_layers": nGpuLayers,
      "use_mlock": useMlock,
      "use_mmap": useMmap,
      "lora": lora,
      "lora_scaled": loraScaled,
      "lora_init_without_apply": loraInitWithoutApply,
      "rope_freq_base": ropeFreqBase,
      "rope_freq_scale": ropeFreqScale,
      "emit_load_progress": emitLoadProgress
    });
  }

  @override
  Future<String?> getFormattedChat(double contextId,
      {required List<RoleContent> messages, String? chatTemplate}) async {
    return await methodChannel.invokeMethod<String>("getFormattedChat", {
      "contextId": contextId,
      "messages": messages.map((item) => item.toMap()).toList(),
      "chatTemplate": chatTemplate
    });
  }

  @override
  Future<Map<Object?, dynamic>?> loadSession(double contextId,
      {required String path}) async {
    return await methodChannel.invokeMethod<Map<Object?, dynamic>?>(
        "loadSession", {"contextId": contextId, "path": path});
  }

  @override
  Future<int?> saveSession(double contextId,
      {required String path, required double size}) async {
    return await methodChannel.invokeMethod<int>(
        "saveSession", {"contextId": contextId, "path": path, "size": size});
  }

  @override
  Future<Map<Object?, dynamic>?> completion(double contextId,
      {required String prompt,
      List<List<double>>? logitBias,
      String grammar = "",
      double temperature = 0.8,
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
      double xtcThreshold = 0.0,
      double xtcProbability = 0.0,
      int seed = -1,
      List<String>? stop,
      bool ignoreEos = false,
      bool emitRealtimeCompletion = false}) async {
    logitBias = logitBias ?? <List<double>>[];
    stop = stop ?? <String>[];
    return await methodChannel
        .invokeMethod<Map<Object?, dynamic>>("completion", {
      "contextId": contextId,
      "params": {
        "prompt": prompt,
        "logit_bias": logitBias,
        "grammar": grammar,
        "temperature": temperature,
        "n_threads": nThreads,
        "n_predict": nPredict,
        "n_probs": nProbs,
        "penalty_last_n": penaltyLastN,
        "penalty_repeat": penaltyRepeat,
        "penalty_freq": penaltyFreq,
        "penalty_present": penaltyPresent,
        "mirostat": mirostat,
        "mirostat_tau": mirostatTau,
        "mirostat_eta": mirostatEta,
        "penalize_nl": penalizeNl,
        "top_k": topK,
        "top_p": topP,
        "min_p": minP,
        "typical_p": typicalP,
        "xtc_threshold": xtcThreshold,
        "xtc_probability": xtcProbability,
        "seed": seed,
        "stop": stop,
        "ignore_eos": ignoreEos,
        "emit_realtime_completion": emitRealtimeCompletion,
      }
    });
  }

  @override
  Future<void> stopCompletion(double contextId) async {
    await methodChannel
        .invokeMethod("stopCompletion", {"contextId": contextId});
  }

  @override
  Future<Map<Object?, dynamic>?> tokenize(double contextId,
      {required String text}) async {
    return await methodChannel.invokeMethod<Map<Object?, dynamic>>(
        "tokenize", {"contextId": contextId, "text": text});
  }

  @override
  Future<String?> detokenize(double contextId,
      {required List<int> tokens}) async {
    return await methodChannel.invokeMethod<String>(
        "detokenize", {"contextId": contextId, "tokens": tokens});
  }

  @override
  Future<String?> bench(double contextId,
      {required double pp,
      required double tg,
      required double pl,
      required double nr}) async {
    return await methodChannel.invokeMethod<String>("bench",
        {"contextId": contextId, "pp": pp, "tg": tg, "pl": pl, "nr": nr});
  }

  @override
  Future<void> releaseContext(double contextId) async {
    await methodChannel
        .invokeMethod("releaseContext", {"contextId": contextId});
  }

  @override
  Future<void> releaseAllContexts() async {
    await methodChannel.invokeMethod("releaseAllContexts");
  }
}
