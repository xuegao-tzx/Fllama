/*
 * Copyright (c) 田梓萱[小草林] 2021-2024.
 * All Rights Reserved.
 * All codes are protected by China's regulations on the protection of computer software, and infringement must be investigated.
 * 版权所有 (c) 田梓萱[小草林] 2021-2024.
 * 所有代码均受中国《计算机软件保护条例》保护，侵权必究.
 */

import "dart:convert";

import "package:connecteo/connecteo.dart";
import "package:dio/dio.dart";
import "package:dio_smart_retry/dio_smart_retry.dart";
import "package:fllama_example/utils/Tools.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";

Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> decodeJson(String response) {
  return compute(_parseAndDecode, response);
}

String _parseAndEncode(Object request) {
  return jsonEncode(request);
}

Future<String> encodeJson(Object request) {
  return compute(_parseAndEncode, request);
}

class HttpEngine {
  static String baseHost = "ei.xcl.ink";
  static String baseUrl = "https://$baseHost/";
  static const String googleUrl = "https://www.google.com/";
  static const String baiduUrl = "https://www.baidu.com/";
  static const String mySelfUrl = "https://www.xcl.ink/";
  static const List<String> alternateDomains = [
    "https://ei.xcl.ink/",
    "https://ei.xuegao-tzx.top/",
    "https://eo.xcl.ink/",
    "https://oi.xuegao-tzx.top/"
  ];
  static HttpEngine? _instance;
  static Dio? _dio;
  static ConnectionChecker? _connecteo;

  HttpEngine._() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 6),
          sendTimeout: const Duration(seconds: 6),
          receiveTimeout: const Duration(seconds: 16),
          responseType: ResponseType.json,
          baseUrl: baseUrl,
          contentType: "application/json; charset=utf-8"));
      _connecteo = ConnectionChecker(
        checkHostReachability: true,
        checkConnectionEntriesNative: [
          ConnectionEntry.fromIpAddress("114.114.114.114"),
          ConnectionEntry.fromIpAddress("8.8.8.8"),
          ConnectionEntry.fromIpAddress("1.1.1.1"),
          ConnectionEntry.fromIpAddress("8.8.4.4"),
          ConnectionEntry.fromIpAddress("1.0.0.1"),
          ConnectionEntry.fromIpAddress("2606:4700:4700::1111"),
          ConnectionEntry.fromIpAddress("2606:4700:4700::1001"),
          ConnectionEntry.fromUrl("https://dns.alidns.com/dns-query"),
          ConnectionEntry.fromUrl("https://doh.dns.sb/dns-query"),
          ConnectionEntry.fromUrl("https://cloudflare-dns.com/dns-query"),
          ConnectionEntry.fromUrl("https://dns.google/dns-query"),
        ],
        hostReachabilityTimeout: const Duration(seconds: 5),
        baseUrlLookupAddress: kDebugMode ? mySelfUrl : baiduUrl,
        failureAttempts: 5,
        requestInterval: const Duration(seconds: 5),
      );
      _init();
    }
  }

  static HttpEngine? instance() {
    _instance ??= HttpEngine._();
    return _instance;
  }

  String getBaseUrl() {
    return baseUrl;
  }

  Dio gDio() {
    return _dio!;
  }

  modifyHost(String host) {
    baseHost = host;
    baseUrl = "https://$host/";
    gDio().options.baseUrl = baseUrl;
  }

  ConnectionChecker gConnect() {
    return _connecteo!;
  }

  void _init() {
    if (_dio != null) {
      // if (kDebugMode) {
      //   dio.interceptors.add(PrettyDioLogger(
      //       requestHeader: true,
      //       requestBody: true,
      //       responseBody: true,
      //       responseHeader: true,
      //       error: true,
      //       compact: true,
      //       maxWidth: 90));
      // }
      _dio?.transformer = BackgroundTransformer()
        ..jsonEncodeCallback = encodeJson
        ..jsonDecodeCallback = decodeJson;
      _dio?.options.headers = Tools.deviceInfo;
      _dio?.options.followRedirects = false;
      _dio?.interceptors.add(RetryInterceptor(
        dio: _dio!,
        logPrint: Get.log,
        retries: 3,
        alternateDomains:
            kDebugMode ? ["https://dev.xcl.ink/"] : alternateDomains,
        retryEvaluator: (error, _) => error.type != DioExceptionType.cancel,
        //retryableExtraStatuses: {301, 302},
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ));
    }
  }
}
