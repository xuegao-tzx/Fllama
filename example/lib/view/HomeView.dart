import 'package:fcllama_example/bean/Enum.dart';
import 'package:fcllama_example/utils/DialogUtils.dart';
import 'package:fcllama_example/utils/HorizontalSwipeBack.dart';
import 'package:fcllama_example/utils/MyToast.dart';
import 'package:fcllama_example/utils/SideSheet.dart';
import 'package:fcllama_example/view/widget/ChatDetailWidget.dart';
import 'package:fcllama_example/view/widget/ChatInputWidget.dart';
import 'package:fcllama_example/vm/HomeVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeVM hVM = Get.find<HomeVM>();
    final screenSize = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = screenSize.width;
    return HorizontalSwipeBack(
        onBack: () {
          SystemChannels.platform.invokeMethod("SystemNavigator.pop");
        },
        child: SafeArea(
            child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatDetailWidget(
                hVM: hVM, mediaQuery: mediaQuery, colorScheme: colorScheme),
          ), //聊天列表
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatInputWidget(
                hVM: hVM, mediaQuery: mediaQuery, colorScheme: colorScheme),
          ), //底部输入
          Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              SideSheet.left(
                                  sheetColor: colorScheme.surface,
                                  body: const SafeArea(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 8, left: 8),
                                          child: Center(
                                            child: Text("TODO：History 位置"),
                                          ))),
                                  context: Get.context!);
                            },
                            iconSize: 30,
                            icon: const Icon(Symbols.read_more_rounded),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: MenuAnchor(
                            childFocusNode: hVM.addMenuFocusNode,
                            // alignmentOffset: const Offset(-132, 0),
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon:
                                    Icon(MenuEntry.modelManager.icon, size: 22),
                                child: Text(MenuEntry.modelManager.traLabel.tr),
                                onPressed: () {
                                  Get.offAllNamed(
                                      RouteEntry.modelManager.label);
                                },
                              ),
                              const PopupMenuDivider(
                                height: 2,
                              ),
                              MenuItemButton(
                                leadingIcon:
                                    Icon(MenuEntry.about.icon, size: 22),
                                child: Text(MenuEntry.about.traLabel.tr),
                                onPressed: () async {
                                  Get.offAllNamed(RouteEntry.about.label);
                                },
                              ),
                              const PopupMenuDivider(
                                height: 2,
                              ),
                              MenuItemButton(
                                leadingIcon:
                                    Icon(MenuEntry.about.icon, size: 22),
                                child: Text("testBench"),
                                onPressed: () async {
                                  Get.log("[FLlama] testBench");
                                  hVM.testBench();
                                },
                              ),
                              const PopupMenuDivider(
                                height: 2,
                              ),
                              MenuItemButton(
                                leadingIcon:
                                    Icon(MenuEntry.about.icon, size: 22),
                                child: Text("testTokenize"),
                                onPressed: () async {
                                  Get.log("[FLlama] testTokenize");
                                  hVM.testTokenize();
                                },
                              ),
                            ],
                            builder: (BuildContext context,
                                MenuController controller, Widget? child) {
                              return IconButton(
                                  focusNode: hVM.addMenuFocusNode,
                                  icon: const Icon(Symbols.more_horiz_rounded,
                                      size: 30),
                                  onPressed: () {
                                    if (controller.isOpen) {
                                      controller.close();
                                    } else {
                                      controller.open();
                                    }
                                  });
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: () async {
                                if (hVM.isLoading.value == true) {
                                  MyToast.showWarnNotice(
                                      "Loading Model List ...".tr);
                                  return;
                                }
                                if (hVM.localModelList.isEmpty) {
                                  MyToast.showWarnNotice(
                                      "No Local Model Found !".tr);
                                  return;
                                }
                                await Get.dialog(chooseOneModelDialog(
                                    context: Get.context!, hVM: hVM));
                              },
                              child: Obx(() => SizedBox(
                                  width: screenWidth * 0.53,
                                  child: Center(
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(hVM.chooseModel.value,
                                              style: const TextStyle(
                                                  fontSize: 18.6),
                                              maxLines: 1,
                                              overflow:
                                                  TextOverflow.ellipsis)))))),
                        ),
                      ],
                    ),
                  ))), //顶部
        ])));
  }
}
