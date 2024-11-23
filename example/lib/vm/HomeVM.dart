import 'package:fcllama/fllama.dart';
import 'package:fcllama_example/db/IsarDao.dart';
import 'package:fcllama_example/db/models.dart';
import 'package:fcllama_example/utils/MyToast.dart';
import 'package:fcllama_example/utils/StoreKV.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeVM extends GetxController with WidgetsBindingObserver {
  final FocusNode addMenuFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  var chooseModel = "Select Model".tr.obs;
  var localModelList = <LocalModelData>[].obs;
  var isLoading = false.obs;

  /// AI-Chat
  var chatItemId = -1;
  var chatId = "".obs;
  var chatInput = "".obs;
  var keyboardHeight = 12.0.obs;
  var textFieldHeight = 0.0.obs;
  var canThinking = false.obs;
  var isThinking = false.obs;
  var chatMesList = <ChatInfo>[].obs;
  var modelContextId = "";
  var modelPutout = "";
  final chatInputFocusNode = FocusNode();
  final textFieldKey = GlobalKey();
  final ScrollController chatListScrollController = ScrollController();
  final TextEditingController chatInputController = TextEditingController();

  void setTextFieldHeight() {
    final RenderBox renderBox =
        textFieldKey.currentContext?.findRenderObject() as RenderBox;
    textFieldHeight.value = renderBox.size.height;
    Get.log("[TextFieldHeight]=${textFieldHeight.value}");
  }

  /// 【发送消息】发送文本消息
  Future<void> sendTextMessage(String msg) async {
    Get.log("[sendMessage]发送消息=$msg");
    isThinking.value = true;
    _setChatItemInList(
        uName: "my", time: DateTime.now().millisecondsSinceEpoch, content: msg);
    modelPutout = "";
    chatItemId = DateTime.now().millisecondsSinceEpoch + 6;
    _setChatItemInList(uName: "gpt", time: chatItemId, content: "...");
    //TODO:调用本地模型进行运算
    final modelId = StoreKV.instance()?.getSelectModelId() ?? "0";
    final lModel = await IsarDao.instance()?.getLocalModel(mId: modelId);
    Get.log("[lModel]=$lModel ${lModel?.lmInfo} ${lModel?.lmInfo?.mPath}");
    Future.delayed(const Duration(seconds: 3), () {
      // _setChatItemInList(uName: "gpt", time: chatItemId, content: "测试AI生成的");
      FCllama.instance()?.completion(
        double.parse(modelContextId),
        prompt:
            'This is a conversation between user and FCllama. Please only output the answer and no examples needed. \n User: $msg \n FCllama:',
        nPredict: 100,
        emitRealtimeCompletion: true,
        stop: ["<eos>", "User"],
      ).then((res) {
        Get.log("[FCllama] Res=$res");
        isThinking.value = false;
      });
      // Future.delayed(const Duration(seconds: 5), () {
      //   isThinking.value = false;
      //   _setChatItemInList(
      //       uName: "gpt",
      //       time: chatItemId,
      //       content: "测试AI生成的消息，20240918消息测试，生成完毕。");
      // });
      // Future.delayed(const Duration(seconds: 1), () {
      //   _setChatItemInList(
      //       uName: "gpt", time: chatItemId, content: "测试AI生成的消息");
      // });
      // Future.delayed(const Duration(seconds: 2), () {
      //   _setChatItemInList(
      //       uName: "gpt", time: chatItemId, content: "测试AI生成的消息，2024");
      // });
      // Future.delayed(const Duration(seconds: 3), () {
      //   _setChatItemInList(
      //       uName: "gpt", time: chatItemId, content: "测试AI生成的消息，20240918");
      // });
      // Future.delayed(const Duration(seconds: 4), () {
      //   _setChatItemInList(
      //       uName: "gpt", time: chatItemId, content: "测试AI生成的消息，20240918消息测试，");
      // });
    });
  }

  Future<void> stopMessagePutout() async {
    FCllama.instance()?.stopCompletion(contextId: double.parse(modelContextId));
  }

  _setChatItemInList(
      {required String uName, required int time, required String content}) {
    List<ChatInfo> tList = chatMesList.value;
    if (tList.isNotEmpty) {
      final tChatInfo = tList.firstWhereOrNull(
          (tMes) => (tMes.time == time && tMes.uName == uName));
      if (tChatInfo != null) {
        tChatInfo.content = content;
        chatMesList.setNewList(tList);
        return;
      }
    }
    final tMyChatInfo = ChatInfo()
      ..uName = uName
      ..time = time
      ..content = content;
    tList.add(tMyChatInfo);
    if (tList.length >= 2) {
      tList.sort((a, b) {
        return (b.time ?? 0).compareTo((a.time ?? 0));
      });
    }
    chatMesList.setNewList(tList);
  }

  void initModel(String mPath) {
    FCllama.instance()
        ?.initContext(mPath, emitLoadProgress: true)
        .then((context) {
      Get.log("[FCllama] initContext Done $context");
      modelContextId = context?["contextId"].toString() ?? "";
      if (modelContextId.isNotEmpty) {
        canThinking.value = true;
        MyToast.showSuccessNotice("Init Success");
      }
    });
  }

  void testBench() {
    FCllama.instance()
        ?.bench(double.parse(modelContextId), pp: 8, tg: 4, pl: 2, nr: 1)
        .then((res) {
      Get.log("[FCllama] Bench Res $res");
    });
  }

  void testTokenize() {
    FCllama.instance()
        ?.tokenize(double.parse(modelContextId), text: "What can you do?")
        .then((res) {
      Get.log("[FCllama] Tokenize Res $res");
      FCllama.instance()
          ?.detokenize(double.parse(modelContextId), tokens: res?['tokens'])
          .then((res) {
        Get.log("[FCllama] Detokenize Res $res");
      });
    });
  }

  @override
  void didChangeMetrics() {
    final double viewInsetsBottom = EdgeInsets.fromViewPadding(
            View.of(Get.context!).viewInsets,
            View.of(Get.context!).devicePixelRatio)
        .bottom;
    keyboardHeight.value = viewInsetsBottom + 12.0;
    super.didChangeMetrics();
  }

  @override
  void onInit() {
    // FCllama.instance()?.getCpuInfo().then((value) {
    //   Get.log("CPU-Info=$value");
    // });
    WidgetsBinding.instance.addObserver(this);
    chooseModel.value =
        StoreKV.instance()?.getSelectModelName() ?? "Select Model".tr;
    isLoading.value = true;
    IsarDao.instance()?.getLocalModels().then((mList) {
      // var testList = <LocalModelData>[];
      // for(var i=0;i<6;i++){
      //   testList.add(LocalModelData()..mName="test$i"..quantMethod="$i");
      // }
      localModelList.setNewList(mList);
      isLoading.value = false;
    });
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    final lModel = await IsarDao.instance()
        ?.getLocalModel(mId: StoreKV.instance()?.getSelectModelId() ?? "");
    FCllama.instance()?.onTokenStream?.listen((data) {
      if (data['function'] == "loadProgress") {
        Get.log("[FCllama] loadProgress=${data['result']}");
      } else if (data['function'] == "completion") {
        Get.log("[FCllama] completion=${data['result']}");
        final tempRes = data["result"]["token"];
        if (tempRes != "User") {
          modelPutout = modelPutout + tempRes;
          _setChatItemInList(
              uName: "gpt", time: chatItemId, content: modelPutout);
        }
      } else {
        Get.log("[FCllama]!!! data=$data");
      }
    });
    if (lModel != null && lModel.lmInfo?.mPath.isNotEmpty == true) {
      Get.log("[Path]= ${lModel.lmInfo?.mPath}");
      initModel(lModel.lmInfo?.mPath ?? "");
    }
  }

  @override
  void onClose() {
    FCllama.instance()?.releaseAllContexts();
    addMenuFocusNode.unfocus();
    textFieldHeight.value = 0;
    keyboardHeight.value = 12.0;
    chatInputFocusNode.unfocus();
    chatInputController.dispose();
    isThinking.value = false;
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
