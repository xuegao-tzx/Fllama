import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fcllama_example/bean/newbean.dart';
import 'package:fcllama_example/net/HttpEngine.dart';
import 'package:fcllama_example/utils/MyToast.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ApiService {
  static ApiService? _instance;

  late Dio _dio;
  StreamSubscription<bool>? subscription;

  ApiService._() {
    _dio = HttpEngine.instance()!.gDio();
  }

  void startConnect() {
    subscription = HttpEngine.instance()
        ?.gConnect()
        .connectionStream
        .listen((isConnected) {
      Get.log("[全局网络状态监控]==$isConnected");
    });
  }

  void stopConnect() {
    try {
      HttpEngine.instance()?.gDio().close(force: true);
      subscription?.cancel();
    } catch (_) {}
  }

  static ApiService? instance() {
    _instance ??= ApiService._();
    return _instance;
  }

  Future<List<ModelInfoData>?> getAllModels({String country = "CN"}) async {
    final isConnected = await HttpEngine.instance()?.gConnect().isConnected;
    if (isConnected == true) {
      try {
        Response response;
        response = await _dio.post("/ai/list", data: {"country": country});
        if (response.statusCode == 200) {
          ModelResponse res = ModelResponse.fromJson(response.data);
          return res.data;
        } else {
          Get.log("[ERR]== $response", isError: true);
          return null;
        }
      } on DioException catch (e) {
        if (kDebugMode) {
          Get.log("[ERR]= $e",
              isError: true, error: e.error, stackTrace: e.stackTrace);
        }
        return null;
      }
    } else {
      MyToast.showErrorNotice("network_error_notice".tr, fontSize: 14);
      return null;
    }
  }
}
