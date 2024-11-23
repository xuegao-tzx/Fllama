import 'package:fcllama_example/db/IsarDao.dart';
import 'package:fcllama_example/db/models.dart';
import 'package:fcllama_example/net/ApiService.dart';
import 'package:fcllama_example/net/ModelDownloadController.dart';
import 'package:fcllama_example/view/module/DownloadButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ModelVM extends GetxController {
  var modelList = <ModelData>[].obs;
  var localModelPath = "".obs;
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    int startTimestamp = DateTime.now().millisecondsSinceEpoch;
    IsarDao.instance()?.getModelList().then((mList) {
      _initMList(mList, mList?.isNotEmpty == true, startTimestamp);
      ApiService.instance()?.getAllModels().then((mList1) {
        if (mList1 != null) {
          IsarDao.instance()?.setModelList(mList1).then((_) {
            IsarDao.instance()?.getModelList().then((mList2) {
              _initMList(mList, mList?.isEmpty == true, startTimestamp);
            });
          });
        }
      });
    });
    super.onInit();
  }

  void _initMList(List<ModelData>? mList, bool needRefresh, int startTime) {
    if (mList != null && needRefresh) {
      var tMList = mList;
      for (var i = 0; i < mList.length; i++) {
        final mInfo = mList[i].info;
        final tInfo = mInfo;
        if (tInfo != null && mInfo != null) {
          for (var u = 0; u < tInfo.length; u++) {
            // eg: 【gguf】https://huggingface.co/QuantFactory/Meta-Llama-3-8B-Instruct-GGUF/resolve/main/Meta-Llama-3-8B-Instruct.Q2_K.gguf
            // eg：【whisper bin】https://hf-mirror.com/ggerganov/whisper.cpp/resolve/main/ggml-tiny.bin
            final tDownloadUrl =
                "https://${mList[i].sUrl}/resolve/main/${mList[i].mName}${mList[i].ext}${mInfo[u].quantMethod}.gguf";
            Get.log(
                "downloadUrl (i=$i,u=$u) $tDownloadUrl mName=${mList[i].mName}");
            tInfo[u].dController = ModelDownloadController(
              modelName: mList[i].mName,
              quantMethod: mInfo[u].quantMethod ?? "",
              modelPolicy: mList[i].policy,
              modelSize: mInfo[u].size ?? "",
              downloadUrl: tDownloadUrl,
              downloadStatus: mInfo[u].hasDownloaded == true
                  ? DownloadStatus.downloaded
                  : DownloadStatus.notDownloaded,
              fileHash: mInfo[u].hash ?? "",
            );
          }
        }
        tMList[i].info = tInfo;
      }
      if (needRefresh) {
        int stopTime = DateTime.now().millisecondsSinceEpoch;
        Get.log("[花费时间]=${stopTime - startTime}");
        final custTime = (stopTime - startTime);
        Future.delayed(
            Duration(milliseconds: custTime > 3000 ? 0 : (3000 - custTime)),
            () {
          modelList.setNewList(tMList);
        });
      }
    }
  }
}
