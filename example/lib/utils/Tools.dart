import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Tools {
  static Map<String, dynamic> deviceInfo = {};

  static Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Tools.deviceInfo = {
        "deviceName": "${androidInfo.brand}-${androidInfo.model}",
        "systemVersion": androidInfo.version.sdkInt,
        "deviceType": "Phone",
        "deviceOS": "Android",
        "deviceId": androidInfo.supportedAbis.toList().toString(),
        "isPhysical": androidInfo.isPhysicalDevice,
        "basicInfo": androidInfo.fingerprint,
        "appVersion": packageInfo.version,
        "appBuild": packageInfo.buildNumber,
        //"appLanguage": StoreKV.instance()!.getAppLanguage().short,
      };
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      Tools.deviceInfo = {
        "deviceName": iosInfo.utsname.machine,
        "systemVersion": iosInfo.systemVersion,
        "deviceType":
            iosInfo.model.toLowerCase().contains("ipad") ? "Tablet" : "Phone",
        "deviceOS": "IOS",
        "deviceId": iosInfo.identifierForVendor,
        "isPhysical": iosInfo.isPhysicalDevice,
        "basicInfo": iosInfo.utsname.version,
        "appVersion": packageInfo.version,
        "appBuild": packageInfo.buildNumber,
        //"appLanguage": StoreKV.instance()!.getAppLanguage().short,
      };
    }
  }

  static Widget errorView({String errMsg = ""}) {
    if (errMsg == "" || errMsg.isEmpty) {
      errMsg = "chat_msg_shown_error".tr;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.error,
          color: Colors.redAccent,
          size: 24.0,
        ),
        const SizedBox(width: 3),
        Text(errMsg),
      ],
    );
  }
}
