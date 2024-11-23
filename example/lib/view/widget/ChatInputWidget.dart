import 'package:fcllama_example/vm/HomeVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatInputWidget extends StatelessWidget {
  final HomeVM hVM;
  final MediaQueryData mediaQuery;
  final ColorScheme colorScheme;

  const ChatInputWidget(
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
          bottom: hVM.keyboardHeight.value,
        ),
        child: NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollMetricsNotification) {
                hVM.setTextFieldHeight();
              }
              return false;
            },
            child: SizeChangedLayoutNotifier(
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(18), // 设置圆角为15
                ),
                constraints: const BoxConstraints(
                  minHeight: 30, // 设置最小高度
                  maxHeight: 250, // 设置最大高度
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: TextField(
                      maxLines: null,
                      key: hVM.textFieldKey,
                      style: TextStyle(
                          fontSize: 14.5,
                          color: colorScheme.onSecondaryContainer),
                      controller: hVM.chatInputController,
                      focusNode: hVM.chatInputFocusNode,
                      decoration: InputDecoration(
                        hintText: "Input your question".tr,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(999)],
                      onChanged: (String value) {
                        hVM.chatInput.value = value;
                      },
                      onTapAlwaysCalled: true,
                      onTapOutside: (PointerDownEvent event) {
                        FocusScope.of(context).unfocus();
                        hVM.setTextFieldHeight();
                      },
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    )),
                    //发送文本消息
                    Offstage(
                        offstage: hVM.isThinking.value,
                        child: IconButton(
                          icon: const Icon(Icons.send_sharp),
                          enableFeedback: hVM.chatInput.value.isEmpty,
                          color: colorScheme.onSurface.withOpacity(
                              hVM.chatInput.value.isEmpty ? 0.3 : 1.0),
                          onPressed: hVM.canThinking.value == true
                              ? () async {
                                  if (hVM.chatInputController.text != "" &&
                                      hVM.chatInput.value != "") {
                                    hVM.sendTextMessage(hVM.chatInput.value);
                                    hVM.chatInputController.text = "";
                                    hVM.chatInput.value = "";
                                    hVM.setTextFieldHeight();
                                    hVM.textFieldHeight.value = 60;
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                              : null,
                        )),
                    Offstage(
                        offstage: !hVM.isThinking.value,
                        child: IconButton(
                          icon: const Icon(Icons.stop_circle_outlined),
                          enableFeedback: true,
                          color: colorScheme.onSurface,
                          onPressed: () async {
                            hVM.stopMessagePutout();
                          },
                        )),
                  ],
                ),
              ), //底部输入那一行
            )))); //底部
  }
}
