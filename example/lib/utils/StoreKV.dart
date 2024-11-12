import 'dart:io';

import 'package:mmkv/mmkv.dart';

class StoreKV {
  static StoreKV? _instance;
  static late MMKV _mmkv;

  StoreKV._() {
    _mmkv = MMKV("mmkv-ei-xcl-aichat-2",
        cryptKey:
            "KV_Fllama_StoreKV_2020-2024_F-${Platform.isAndroid ? "Android" : Platform.isIOS ? "iOS" : "unknown"}");
  }

  static StoreKV? instance() {
    _instance ??= StoreKV._();
    return _instance;
  }

  void setSelectModel({required String name, required String id}) {
    _mmkv.encodeString("selectModelName", name);
    _mmkv.encodeString("selectModelId", id);
  }

  String? getSelectModelName() {
    return _mmkv.decodeString("selectModelName");
  }

  String? getSelectModelId() {
    return _mmkv.decodeString("selectModelId");
  }
}
