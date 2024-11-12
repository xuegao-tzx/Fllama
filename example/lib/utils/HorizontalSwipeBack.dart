import "dart:io" show Platform;

import "package:flutter/material.dart";
import "package:get/get.dart";

class HorizontalSwipeBack extends StatelessWidget {
  final Widget child;
  final double startX = 0.0;
  final double horizontalSwipeThreshold;
  final Function() onBack;

  const HorizontalSwipeBack({
    super.key,
    required this.child,
    this.horizontalSwipeThreshold = 100.0, // 默认水平滑动距离阈值
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    double startX = 0.0;

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          } else {
            await onBack.call();
          }
        },
        child: Listener(
          onPointerDown: (details) {
            // 记录初始位置
            startX = details.localPosition.dx;
          },
          onPointerMove: (details) async {
            // 计算滑动的水平距离
            double deltaX = details.localPosition.dx - startX;

            // 只检测水平滑动，且滑动距离大于阈值
            if (details.localPosition.dx > 80 &&
                details.localPosition.dx < 250 &&
                Platform.isIOS &&
                deltaX > horizontalSwipeThreshold &&
                details.delta.dy.abs() < details.delta.dx.abs()) {
              Get.log(
                  "[iOS]侧边滑动返回=dx: ${details.delta.dx}, dy: ${details.delta.dy}");
              await onBack.call();
            }
          },
          child: child,
        ));
  }
}
