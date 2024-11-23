import 'package:fcllama_example/db/models.dart';
import 'package:fcllama_example/vm/HomeVM.dart';
import 'package:flutter/material.dart';
import 'package:fmarkdown/flutter_markdown.dart';
import 'package:get/get.dart';
import "package:markdown/markdown.dart" as md;
import 'package:url_launcher/url_launcher.dart';

class ChatListItem extends StatelessWidget {
  final int index;
  final ChatInfo itemInfo;
  final HomeVM hVM;
  final ColorScheme colorScheme;
  final Color materialColor;
  final Color myMaterialColor;

  const ChatListItem(
      {super.key,
      required this.index,
      required this.itemInfo,
      required this.hVM,
      required this.colorScheme,
      required this.materialColor,
      required this.myMaterialColor});

  @override
  Widget build(BuildContext context) {
    bool isUser = itemInfo.uName == "my";
    Color materialColor = isUser ? myMaterialColor : this.materialColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 头像
          !isUser
              ? const Icon(Icons.smart_toy_rounded, size: 32)
              : const SizedBox(),
          !isUser ? const SizedBox(width: 8) : const SizedBox(),
          // 消息和状态
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 昵称
                Text(
                  isUser ? "User".tr : "Bot".tr,
                  style: const TextStyle(fontSize: 12),
                ),
                // 消息内容
                Material(
                  color: materialColor.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(8.6),
                  elevation: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: MarkdownBody(
                      data: itemInfo.content ?? "",
                      selectable: false,
                      extensionSet: md.ExtensionSet(
                        md.ExtensionSet.gitHubWeb.blockSyntaxes,
                        [
                          md.EmojiSyntax(),
                          ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
                        ],
                      ),
                      onTapLink: (text, href, title) async {
                        if (href != null && href.isNotEmpty) {
                          await launchUrl(Uri.parse(href));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          isUser ? const SizedBox(width: 8) : const SizedBox(),
          isUser
              ? const Icon(Icons.account_circle_rounded, size: 32)
              : const SizedBox()
        ],
      ),
    );
  }
}
