import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fcllama_example/db/IsarDao.dart';
import 'package:fcllama_example/utils/MyToast.dart';
import 'package:fcllama_example/utils/StoreKV.dart';
import 'package:fcllama_example/vm/HomeVM.dart';
import 'package:fcllama_example/vm/ModelVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Widget showCustomDialog({
  required BuildContext context,
  required String title,
  String content = "",
  String confirm = "",
  double? contentSize,
  required String cancel,
  VoidCallback? onConfirmClick,
  VoidCallback? onCancelClick,
}) {
  return AlertDialog(
    title: Text(title),
    content: content.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(content, style: TextStyle(fontSize: contentSize)),
              ),
            ),
          )
        : null,
    actions: <Widget>[
      TextButton(
        child: Text(cancel),
        onPressed: () {
          Get.backLegacy(result: false);
          onCancelClick?.call();
        },
      ),
      if (confirm != "") ...[
        FilledButton(
          child: Text(confirm),
          onPressed: () {
            Get.backLegacy(result: true);
            onConfirmClick?.call();
          },
        ),
      ]
    ],
  );
}

Widget addModelDialog({required BuildContext context, required ModelVM mVM}) {
  return AlertDialog(
    title: Text("Add Local Model".tr),
    content: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            children: [
              TextField(
                controller: mVM.textController,
                textInputAction: TextInputAction.done,
                focusNode: mVM.textFocusNode,
                minLines: 1,
                maxLines: 3,
                onSubmitted: (_) {
                  mVM.textFocusNode.unfocus();
                },
                decoration: InputDecoration(
                  labelText: "Model Name".tr,
                  hintText: "Enter Model Name".tr,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(35)],
                keyboardType: TextInputType.text,
                onEditingComplete: () {
                  mVM.textFocusNode.unfocus();
                },
              ),
              Row(
                children: [
                  const Text("Model Path : ", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  IconButton(
                      onPressed: () async {
                        if (mVM.textController.text.isNotEmpty) {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(type: FileType.any);
                          if (result != null) {
                            File file = File(result.files.single.path!);
                            String ext = extension(file.path);
                            if (ext == ".gguf") {
                              final Directory libraryDirectory =
                                  Platform.isAndroid
                                      ? await getApplicationSupportDirectory()
                                      : await getLibraryDirectory();
                              final mFPath =
                                  "${libraryDirectory.path}/model/${mVM.textController.text}.gguf";
                              await file.rename(mFPath);
                              mVM.localModelPath.value = mFPath;
                            } else {
                              MyToast.showWarnNotice(
                                  "Only support GGUF file".tr);
                            }
                          }
                        } else {
                          MyToast.showWarnNotice("Model Name is Empty".tr);
                        }
                      },
                      icon: Icon(
                        Icons.folder_open,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ))
                ],
              ),
              Obx(() => Offstage(
                    offstage: mVM.localModelPath.isEmpty,
                    child: Text(" ${mVM.localModelPath.value} ",
                        style: TextStyle(
                            fontSize: 14,
                            color: mVM.localModelPath.value.endsWith('.gguf')
                                ? Colors.greenAccent
                                : Colors.redAccent)),
                  ))
            ],
          ),
        ),
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: Text("Cancel".tr),
        onPressed: () {
          Get.backLegacy(result: false);
        },
      ),
      FilledButton(
        child: Text("OK".tr),
        onPressed: () {
          if (mVM.localModelPath.value.isNotEmpty &&
              mVM.localModelPath.value.endsWith('.gguf') &&
              mVM.textController.text.isNotEmpty) {
            Get.backLegacy(result: true);
          } else {
            Get.backLegacy(result: false);
          }
        },
      ),
    ],
  );
}

Widget chooseOneModelDialog(
    {required BuildContext context, required HomeVM hVM}) {
  return AlertDialog(
    title: Text("Select One Model".tr),
    content: Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7 >
                  hVM.localModelList.value.length * 63
              ? hVM.localModelList.value.length * 63
              : MediaQuery.of(context).size.height * 0.7,
          child: Obx(() => Scrollbar(
              controller: hVM.scrollController,
              thumbVisibility: true,
              radius: const Radius.circular(6),
              child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ListView.builder(
                      reverse: false,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: hVM.localModelList.value.length,
                      controller: hVM.scrollController,
                      itemBuilder: (context, index) {
                        final bool isEven = index % 2 == 0;
                        final model = hVM.localModelList.value[index];
                        return Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                    color: isEven
                                        ? Colors.grey[200]
                                        : Colors.blueGrey[100],
                                    child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              child: Text(
                                                  "Model: ${model.lmInfo?.mName}",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            const SizedBox(width: 2),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              child: Text(
                                                  model.lmInfo?.quantMethod ??
                                                      "",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors
                                                          .lightBlueAccent)),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () async {
                                                  if (model.id !=
                                                      Id.parse(StoreKV
                                                                  .instance()
                                                              ?.getSelectModelId() ??
                                                          "-1")) {
                                                    await IsarDao.instance()
                                                        ?.selectOneLocalModel(
                                                            Id.parse(StoreKV
                                                                        .instance()
                                                                    ?.getSelectModelId() ??
                                                                "-1"),
                                                            model.id);
                                                    StoreKV.instance()
                                                        ?.setSelectModel(
                                                            name: model.lmInfo
                                                                    ?.mName ??
                                                                "",
                                                            id: model.id
                                                                .toString());
                                                    var mList =
                                                        await IsarDao.instance()
                                                            ?.getLocalModels();
                                                    hVM.localModelList
                                                        .setNewList(mList);
                                                    hVM.chooseModel.value =
                                                        model.lmInfo?.mName ??
                                                            "";
                                                    hVM.initModel(
                                                        model.lmInfo?.mPath ??
                                                            "");
                                                  }
                                                },
                                                icon: Icon(
                                                  model.isSelect
                                                      ? Icons
                                                          .check_circle_outline_outlined
                                                      : Icons
                                                          .radio_button_off_outlined,
                                                  size: 24,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ))
                                          ],
                                        )))));
                      }))))),
    ),
    actions: <Widget>[
      TextButton(
        child: Text("Cancel".tr),
        onPressed: () {
          Get.backLegacy(result: false);
        },
      ),
    ],
  );
}
