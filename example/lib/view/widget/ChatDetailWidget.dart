import 'package:fcllama_example/view/widget/ChatListItemWidget.dart';
import 'package:fcllama_example/vm/HomeVM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailWidget extends StatelessWidget {
  final HomeVM hVM;
  final MediaQueryData mediaQuery;
  final ColorScheme colorScheme;

  const ChatDetailWidget(
      {super.key,
      required this.hVM,
      required this.mediaQuery,
      required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 64,
          bottom: hVM.keyboardHeight.value + hVM.textFieldHeight.value + 12.0,
        ),
        child: Align(
            alignment: Alignment.center,
            child: ListView.builder(
                reverse: true,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: hVM.chatMesList.value.length,
                controller: hVM.chatListScrollController,
                itemBuilder: (_, index) {
                  final reversedIndex =
                      hVM.chatMesList.value.length - 1 - index;
                  return ChatListItem(
                      index: reversedIndex,
                      itemInfo: hVM.chatMesList.value[index],
                      hVM: hVM,
                      colorScheme: colorScheme,
                      materialColor: colorScheme.tertiaryContainer,
                      myMaterialColor: colorScheme.primaryContainer);
                })))); //具体聊天消息
  }
}
