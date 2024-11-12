// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newbean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModelResponseImpl _$$ModelResponseImplFromJson(Map<String, dynamic> json) =>
    _$ModelResponseImpl(
      code: (json['code'] as num?)?.toInt() ?? 0,
      msg: json['msg'] as String? ?? "",
      data: (json['data'] as List<dynamic>)
          .map((e) => ModelInfoData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ModelResponseImplToJson(_$ModelResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

_$ModelInfoDataImpl _$$ModelInfoDataImplFromJson(Map<String, dynamic> json) =>
    _$ModelInfoDataImpl(
      sUrl: json['sUrl'] as String,
      name: json['name'] as String,
      policy: json['policy'] as String,
      ext: json['ext'] as String? ?? ".",
      info: (json['info'] as List<dynamic>)
          .map((e) => ModelInfoList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ModelInfoDataImplToJson(_$ModelInfoDataImpl instance) =>
    <String, dynamic>{
      'sUrl': instance.sUrl,
      'name': instance.name,
      'policy': instance.policy,
      'ext': instance.ext,
      'info': instance.info,
    };

_$ModelInfoListImpl _$$ModelInfoListImplFromJson(Map<String, dynamic> json) =>
    _$ModelInfoListImpl(
      size: json['size'] as String,
      hash: json['hash'] as String,
      quantMethod: json['quantMethod'] as String,
    );

Map<String, dynamic> _$$ModelInfoListImplToJson(_$ModelInfoListImpl instance) =>
    <String, dynamic>{
      'size': instance.size,
      'hash': instance.hash,
      'quantMethod': instance.quantMethod,
    };
