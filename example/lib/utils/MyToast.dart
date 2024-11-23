/*
 * Copyright (c) 田梓萱[小草林] 2021-2024.
 * All Rights Reserved.
 * All codes are protected by China's regulations on the protection of computer software, and infringement must be investigated.
 * 版权所有 (c) 田梓萱[小草林] 2021-2024.
 * 所有代码均受中国《计算机软件保护条例》保护，侵权必究.
 */
import "package:fcllama_example/main.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:get/get.dart";

class MyToast {
  /// 错误弹窗
  static void showErrorNotice(String errMes, {double fontSize = 16}) {
    FToast fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    fToast.showToast(
        toastDuration: const Duration(milliseconds: 2345),
        gravity: ToastGravity.BOTTOM,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.redAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline, color: Colors.white),
              const SizedBox(
                width: 8.0,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(Get.context!).size.width - 160,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    errMes,
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  /// 警告弹窗
  static void showWarnNotice(String warnMes, {double fontSize = 16}) {
    FToast fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    fToast.showToast(
        toastDuration: const Duration(milliseconds: 2345),
        gravity: ToastGravity.BOTTOM,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.amberAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline, color: Colors.black),
              const SizedBox(
                width: 8.0,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(Get.context!).size.width - 160,
                ),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(warnMes,
                        style: TextStyle(
                            color: Colors.black, fontSize: fontSize))),
              )
            ],
          ),
        ));
  }

  /// 成功弹窗
  static void showSuccessNotice(String successMes) {
    FToast fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    fToast.showToast(
        toastDuration: const Duration(milliseconds: 2321),
        gravity: ToastGravity.BOTTOM,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.greenAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check, color: Colors.black),
              const SizedBox(
                width: 10.0,
              ),
              Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(Get.context!).size.width - 160,
                  ),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(successMes,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16)))),
            ],
          ),
        ));
  }
}
