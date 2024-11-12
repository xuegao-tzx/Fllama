import 'package:freezed_annotation/freezed_annotation.dart';

part "newbean.freezed.dart";
part "newbean.g.dart";

@unfreezed
class ModelResponse with _$ModelResponse {
  factory ModelResponse({
    @Default(0) int code,
    @Default("") String msg,
    required List<ModelInfoData> data,
  }) = _ModelResponse;

  factory ModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ModelResponseFromJson(json);
}

@unfreezed
class ModelInfoData with _$ModelInfoData {
  factory ModelInfoData({
    required String sUrl,
    required String name,
    required String policy,
    @Default(".") String ext,
    required List<ModelInfoList> info,
  }) = _ModelInfoData;

  factory ModelInfoData.fromJson(Map<String, dynamic> json) =>
      _$ModelInfoDataFromJson(json);
}

@unfreezed
class ModelInfoList with _$ModelInfoList {
  factory ModelInfoList({
    required String size,
    required String hash,
    required String quantMethod,
  }) = _ModelInfoList;

  factory ModelInfoList.fromJson(Map<String, dynamic> json) =>
      _$ModelInfoListFromJson(json);
}
