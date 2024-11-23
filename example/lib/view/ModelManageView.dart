import 'dart:io';

import 'package:fcllama_example/bean/Enum.dart';
import 'package:fcllama_example/db/IsarDao.dart';
import 'package:fcllama_example/utils/DialogUtils.dart';
import 'package:fcllama_example/utils/HorizontalSwipeBack.dart';
import 'package:fcllama_example/view/module/ModelListItem.dart';
import 'package:fcllama_example/vm/ModelVM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelManageView extends StatelessWidget {
  const ModelManageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ModelVM mVM = Get.find<ModelVM>();

    return HorizontalSwipeBack(
        onBack: () {
          Get.offAllNamed(RouteEntry.home.label);
        },
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        Get.toNamed(RouteEntry.home.label);
                      },
                      iconSize: 24,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Model Manager".tr,
                          style: const TextStyle(fontSize: 22.0),
                        ),
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () async {
                          final ans = await Get.dialog(
                              addModelDialog(context: Get.context!, mVM: mVM));
                          if (ans) {
                            await IsarDao.instance()?.addOneModel(
                                mName: mVM.textController.text,
                                mPath: mVM.localModelPath.value,
                                mSize:
                                    "${(File(mVM.localModelPath.value).lengthSync() / (1024 * 1024 * 1024)).toStringAsFixed(2)} G");
                          } else {
                            mVM.textController.text = "";
                            mVM.textFocusNode.unfocus();
                            mVM.localModelPath.value = "";
                          }
                        },
                        iconSize: 24,
                        icon: const Icon(Icons.add_circle_outline_rounded),
                      )),
                ],
              ),
            ),
            Expanded(
                child: Center(
              child: Obx(() => Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: Stack(
                        children: [
                          Offstage(
                              offstage: mVM.modelList.value.isNotEmpty,
                              child: const CircularProgressIndicator()),
                          Offstage(
                              offstage: mVM.modelList.value.isEmpty,
                              child: ListView.builder(
                                  reverse: false,
                                  addAutomaticKeepAlives: false,
                                  addRepaintBoundaries: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: mVM.modelList.length,
                                  controller: mVM.scrollController,
                                  itemBuilder: (_, index) {
                                    return ModelListItem(
                                      index: index,
                                      mData: mVM.modelList[index],
                                      mVM: mVM,
                                    );
                                  })),
                        ],
                      )))),
            ))
          ],
        )));
  }
}
