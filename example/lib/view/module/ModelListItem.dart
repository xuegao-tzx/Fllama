import 'package:fcllama_example/db/models.dart';
import 'package:fcllama_example/net/ModelDownloadController.dart';
import 'package:fcllama_example/view/module/DownloadButton.dart';
import 'package:fcllama_example/vm/ModelVM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelListItem extends StatelessWidget {
  final int index;
  final ModelData mData;
  final ModelVM mVM;

  const ModelListItem(
      {super.key, required this.index, required this.mVM, required this.mData});

  Widget _buildExpansionInfo(String subCity, DownloadController dController) {
    return Padding(
        padding: const EdgeInsets.only(right: 12, left: 12),
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onLongPress: () async {
                  Get.log("[长按删除模型]");
                  switch (dController.downloadStatus) {
                    case DownloadStatus.notDownloaded:
                      break;
                    case DownloadStatus.pauseDownloaded:
                    case DownloadStatus.fetchingDownload:
                      dController.deleteDownload.call();
                      break;
                    case DownloadStatus.downloading:
                      break;
                    case DownloadStatus.downloaded:
                    case DownloadStatus.hasDownloaded:
                      dController.deleteDownload.call();
                      break;
                  }
                },
                child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.only(bottom: 3.6),
                      decoration: BoxDecoration(
                          color: Get.theme.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(subCity)),
                        const Spacer(),
                        Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                                width: 56,
                                height: 40,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: AnimatedBuilder(
                                      animation: dController,
                                      builder: (context, child) {
                                        return DownloadButton(
                                          status: dController.downloadStatus,
                                          downloadProgress:
                                              dController.progress,
                                          onDownload: dController.startDownload,
                                          onCancel: dController.stopDownload,
                                          onDownloaded:
                                              dController.deleteDownload,
                                          onPause: dController.pauseDownload,
                                          onResume: dController.resumeDownload,
                                        );
                                      },
                                    ))))
                      ]),
                    )))));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        mData.mName,
        style: const TextStyle(fontSize: 16),
      ),
      children: List.generate(
        mData.info?.length ?? 0,
        (index) {
          final modelMore = mData.info?[index];
          return _buildExpansionInfo("QuantMethod: ${modelMore?.quantMethod}",
              modelMore?.dController ?? ModelDownloadController());
        },
      ),
    );
  }
}
