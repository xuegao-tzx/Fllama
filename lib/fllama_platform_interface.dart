import "package:fllama/fllama_type.dart";
import "package:plugin_platform_interface/plugin_platform_interface.dart";

import "fllama_method_channel.dart";

abstract class FllamaPlatform extends PlatformInterface {
  /// Constructs a FllamaPlatform.
  FllamaPlatform() : super(token: _token);

  static final Object _token = Object();

  static FllamaPlatform _instance = MethodChannelFllama();

  /// The default instance of [FllamaPlatform] to use.
  ///
  /// Defaults to [MethodChannelFllama].
  static FllamaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FllamaPlatform] when
  /// they register themselves.
  static set instance(FllamaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<Map<Object?, dynamic>>? get onTokenStream {
    throw UnimplementedError("Stream onTokenStream has not been implemented.");
  }

  Future<Map<Object?, dynamic>?> getCpuInfo() {
    throw UnimplementedError("Method getCpuInfo() has not been implemented.");
  }

  Future<String?> getFileSHA256(String filePath) {
    throw UnimplementedError(
        "Method getFileSHA256(String filePath) has not been implemented.");
  }

  Future<Map<Object?, dynamic>?> initContext(String model,
      {bool embedding = false,
      int nCtx = 768,
      int nBatch = 768,
      int nThreads = 0,
      int nGpuLayers = 0,
      bool useMlock = true,
      bool useMmap = true,
      String lora = "",
      bool loraInitWithoutApply = false,
      double loraScaled = 1.0,
      double ropeFreqBase = 0.0,
      double ropeFreqScale = 0.0,
      bool emitLoadProgress = false}) {
    throw UnimplementedError(
        "Method initContext(String model,{int modelType = 1,bool embedding = false,int nCtx = 768,int nBatch = 768,int nThreads = 0,int nGpuLayers = 0,bool useMlock = true,bool useMmap = true,String lora = "
        ",bool loraInitWithoutApply = false,double loraScaled = 1.0,double ropeFreqBase = 0.0,double ropeFreqScale = 0.0,bool emitLoadProgress = false}) has not been implemented.");
  }

  Future<String?> getFormattedChat(double contextId,
      {required List<RoleContent> messages, String? chatTemplate}) {
    throw UnimplementedError(
        "Method getFormattedChat({required double contextId,required List<Map<String, dynamic>> messages,String? chatTemplate}) has not been implemented.");
  }

  Future<Map<Object?, dynamic>?> loadSession(double contextId,
      {required String path}) {
    throw UnimplementedError(
        "Method loadSession({required double contextId, required String path}) has not been implemented.");
  }

  Future<int?> saveSession(double contextId,
      {required String path, required double size}) {
    throw UnimplementedError(
        "Method saveSession({required double contextId, required String path, required double size}) has not been implemented.");
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
      double xtcThreshold = 0.0,
      double xtcProbability = 0.0,
      int seed = -1,
      List<String>? stop,
      bool ignoreEos = false,
      bool emitRealtimeCompletion = false}) {
    throw UnimplementedError(
        "Method (double contextId,{required String prompt,List<List<double>>? logitBias,String grammar = "
        ",double temperature = 0.7,int nThreads = 0,int nPredict = -1,int nProbs = 0,int penaltyLastN = 64,double penaltyRepeat = 1.0,double penaltyFreq = 0.0,double penaltyPresent = 0.0,double mirostat = 0.0,double mirostatTau = 5.0,double mirostatEta = 0.1,bool penalizeNl = false,int topK = 40,double topP = 0.95,double minP = 0.05,double typicalP = 1.0,double xtcThreshold = 0.0,double xtcProbability = 0.0,int seed = -1,List<String>? stop,bool ignoreEos = false,bool emitPartialCompletion = false,bool emitRealtimeCompletion = false}) has not been implemented.");
  }

  Future<void> stopCompletion(double contextId) {
    throw UnimplementedError(
        "Method stopCompletion({required double contextId}) has not been implemented.");
  }

  Future<Map<Object?, dynamic>?> tokenize(double contextId,
      {required String text}) {
    throw UnimplementedError(
        "Method tokenize({required double contextId, required String text}) has not been implemented.");
  }

  Future<String?> detokenize(double contextId, {required List<int> tokens}) {
    throw UnimplementedError(
        "Method detokenize({required double contextId, required List<int> tokens}) has not been implemented.");
  }

  Future<String?> bench(double contextId,
      {required double pp,
      required double tg,
      required double pl,
      required double nr}) {
    throw UnimplementedError(
        "Method bench({required double contextId,required double pp,required double tg,required double pl,required double nr}) has not been implemented.");
  }

  Future<void> releaseContext(double contextId) {
    throw UnimplementedError(
        "Method releaseContext({required double contextId}) has not been implemented.");
  }

  Future<void> releaseAllContexts() {
    throw UnimplementedError(
        "Method releaseAllContexts() has not been implemented.");
  }
}
