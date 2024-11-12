/*
 * Copyright (c) 田梓萱[小草林] 2021-2024.
 * All Rights Reserved.
 * All codes are protected by China's regulations on the protection of computer software, and infringement must be investigated.
 * 版权所有 (c) 田梓萱[小草林] 2021-2024.
 * 所有代码均受中国《计算机软件保护条例》保护，侵权必究.
 */

import "package:flutter/material.dart";

class SideSheet {
  /// Open Left side sheet
  /// ```dart
  ///onPressed: () => SideSheet.left(body: Text("Body"), context: context)
  /// ```
  static Future<dynamic> left(
      {
      ///Use this to pass any widget you want to display in the side sheet
      required Widget body,
      required BuildContext context,

      /// Use this to set the width of the side sheet
      double? width,
      String barrierLabel = "Side Sheet",

      /// Use barrierDismissible to dismiss the side sheet by tapping outside of it
      bool barrierDismissible = true,

      /// Use barrierColor to set the outside color of the side sheet when opened
      Color barrierColor = Colors.white24,

      /// Use sheetBorderRadius to set the outside border radius of the side sheet when opened
      double sheetBorderRadius = 0,

      /// Use sheetColor to set the color of the side sheet when opened
      /// Default is white
      Color sheetColor = Colors.white,

      /// Use transitionDuration to set the duration of the animation when the side sheet is opened or closed
      Duration transitionDuration = const Duration(milliseconds: 300)}) async {
    dynamic data = await _showSheetSide(
      body: body,
      width: width,
      rightSide: false,
      context: context,
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      sheetBorderRadius: sheetBorderRadius,
      sheetColor: sheetColor,
      transitionDuration: transitionDuration,
    );
    if (data == null) return "";

    return data;
  }

  /// Open Right side sheet
  /// ```dart
  ///onPressed: () => SideSheet.right(body: Text("Body"), context: context)
  /// ```
  static Future<dynamic> right(
      {
      ///Use this to pass any widget you want to display in the side sheet
      required Widget body,
      required BuildContext context,

      /// Use this to set the width of the side sheet
      double? width,
      String barrierLabel = "Side Sheet",

      /// Use barrierDismissible to dismiss the side sheet by tapping outside of it
      bool barrierDismissible = true,

      /// Use barrierColor to set the outside color of the side sheet when opened
      Color barrierColor = Colors.white24,

      /// Use sheetBorderRadius to set the outside border radius of the side sheet when opened
      double sheetBorderRadius = 0,

      /// Use sheetColor to set the color of the side sheet when opened
      /// Default is white
      Color sheetColor = Colors.transparent,

      /// Use transitionDuration to set the duration of the animation when the side sheet is opened or closed
      Duration transitionDuration = const Duration(milliseconds: 345)}) async {
    dynamic data = await _showSheetSide(
      body: body,
      width: width,
      rightSide: true,
      context: context,
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      sheetBorderRadius: sheetBorderRadius,
      sheetColor: sheetColor,
      transitionDuration: transitionDuration,
    );
    if (data == null) return "";

    return data;
  }

  static _showSheetSide({
    required Widget body,
    required bool rightSide,
    double? width,
    required BuildContext context,
    required String barrierLabel,
    required bool barrierDismissible,
    required Color barrierColor,
    required double sheetBorderRadius,
    required Color sheetColor,
    required Duration transitionDuration,
  }) {
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: rightSide ? Radius.circular(sheetBorderRadius) : Radius.zero,
      bottomLeft: rightSide ? Radius.circular(sheetBorderRadius) : Radius.zero,
      topRight: !rightSide ? Radius.circular(sheetBorderRadius) : Radius.zero,
      bottomRight:
          !rightSide ? Radius.circular(sheetBorderRadius) : Radius.zero,
    );

    return showGeneralDialog(
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: (rightSide ? Alignment.centerRight : Alignment.centerLeft),
          child: Material(
            elevation: 15,
            color: Colors.transparent,
            borderRadius: borderRadius,
            child: Container(
                decoration: BoxDecoration(
                    color: sheetColor, borderRadius: borderRadius),
                height: double.infinity,
                width: width ?? MediaQuery.of(context).size.width / 1.35, //.3,
                child: body),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween(
                  begin: Offset((rightSide ? 1 : -1), 0),
                  end: const Offset(0, 0))
              .animate(animation1),
          child: child,
        );
      },
    );
  }
}
