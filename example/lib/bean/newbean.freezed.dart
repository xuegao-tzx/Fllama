// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'newbean.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ModelResponse _$ModelResponseFromJson(Map<String, dynamic> json) {
  return _ModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ModelResponse {
  int get code => throw _privateConstructorUsedError;

  set code(int value) => throw _privateConstructorUsedError;

  String get msg => throw _privateConstructorUsedError;

  set msg(String value) => throw _privateConstructorUsedError;

  List<ModelInfoData> get data => throw _privateConstructorUsedError;

  set data(List<ModelInfoData> value) => throw _privateConstructorUsedError;

  /// Serializes this ModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelResponseCopyWith<ModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelResponseCopyWith<$Res> {
  factory $ModelResponseCopyWith(
          ModelResponse value, $Res Function(ModelResponse) then) =
      _$ModelResponseCopyWithImpl<$Res, ModelResponse>;

  @useResult
  $Res call({int code, String msg, List<ModelInfoData> data});
}

/// @nodoc
class _$ModelResponseCopyWithImpl<$Res, $Val extends ModelResponse>
    implements $ModelResponseCopyWith<$Res> {
  _$ModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? msg = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ModelInfoData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelResponseImplCopyWith<$Res>
    implements $ModelResponseCopyWith<$Res> {
  factory _$$ModelResponseImplCopyWith(
          _$ModelResponseImpl value, $Res Function(_$ModelResponseImpl) then) =
      __$$ModelResponseImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({int code, String msg, List<ModelInfoData> data});
}

/// @nodoc
class __$$ModelResponseImplCopyWithImpl<$Res>
    extends _$ModelResponseCopyWithImpl<$Res, _$ModelResponseImpl>
    implements _$$ModelResponseImplCopyWith<$Res> {
  __$$ModelResponseImplCopyWithImpl(
      _$ModelResponseImpl _value, $Res Function(_$ModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? msg = null,
    Object? data = null,
  }) {
    return _then(_$ModelResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ModelInfoData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelResponseImpl implements _ModelResponse {
  _$ModelResponseImpl({this.code = 0, this.msg = "", required this.data});

  factory _$ModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelResponseImplFromJson(json);

  @override
  @JsonKey()
  int code;
  @override
  @JsonKey()
  String msg;
  @override
  List<ModelInfoData> data;

  @override
  String toString() {
    return 'ModelResponse(code: $code, msg: $msg, data: $data)';
  }

  /// Create a copy of ModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelResponseImplCopyWith<_$ModelResponseImpl> get copyWith =>
      __$$ModelResponseImplCopyWithImpl<_$ModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ModelResponse implements ModelResponse {
  factory _ModelResponse(
      {int code,
      String msg,
      required List<ModelInfoData> data}) = _$ModelResponseImpl;

  factory _ModelResponse.fromJson(Map<String, dynamic> json) =
      _$ModelResponseImpl.fromJson;

  @override
  int get code;

  set code(int value);

  @override
  String get msg;

  set msg(String value);

  @override
  List<ModelInfoData> get data;

  set data(List<ModelInfoData> value);

  /// Create a copy of ModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelResponseImplCopyWith<_$ModelResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModelInfoData _$ModelInfoDataFromJson(Map<String, dynamic> json) {
  return _ModelInfoData.fromJson(json);
}

/// @nodoc
mixin _$ModelInfoData {
  String get sUrl => throw _privateConstructorUsedError;

  set sUrl(String value) => throw _privateConstructorUsedError;

  String get name => throw _privateConstructorUsedError;

  set name(String value) => throw _privateConstructorUsedError;

  String get policy => throw _privateConstructorUsedError;

  set policy(String value) => throw _privateConstructorUsedError;

  String get ext => throw _privateConstructorUsedError;

  set ext(String value) => throw _privateConstructorUsedError;

  List<ModelInfoList> get info => throw _privateConstructorUsedError;

  set info(List<ModelInfoList> value) => throw _privateConstructorUsedError;

  /// Serializes this ModelInfoData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModelInfoData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelInfoDataCopyWith<ModelInfoData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelInfoDataCopyWith<$Res> {
  factory $ModelInfoDataCopyWith(
          ModelInfoData value, $Res Function(ModelInfoData) then) =
      _$ModelInfoDataCopyWithImpl<$Res, ModelInfoData>;

  @useResult
  $Res call(
      {String sUrl,
      String name,
      String policy,
      String ext,
      List<ModelInfoList> info});
}

/// @nodoc
class _$ModelInfoDataCopyWithImpl<$Res, $Val extends ModelInfoData>
    implements $ModelInfoDataCopyWith<$Res> {
  _$ModelInfoDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelInfoData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sUrl = null,
    Object? name = null,
    Object? policy = null,
    Object? ext = null,
    Object? info = null,
  }) {
    return _then(_value.copyWith(
      sUrl: null == sUrl
          ? _value.sUrl
          : sUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      policy: null == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as String,
      ext: null == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String,
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as List<ModelInfoList>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelInfoDataImplCopyWith<$Res>
    implements $ModelInfoDataCopyWith<$Res> {
  factory _$$ModelInfoDataImplCopyWith(
          _$ModelInfoDataImpl value, $Res Function(_$ModelInfoDataImpl) then) =
      __$$ModelInfoDataImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call(
      {String sUrl,
      String name,
      String policy,
      String ext,
      List<ModelInfoList> info});
}

/// @nodoc
class __$$ModelInfoDataImplCopyWithImpl<$Res>
    extends _$ModelInfoDataCopyWithImpl<$Res, _$ModelInfoDataImpl>
    implements _$$ModelInfoDataImplCopyWith<$Res> {
  __$$ModelInfoDataImplCopyWithImpl(
      _$ModelInfoDataImpl _value, $Res Function(_$ModelInfoDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModelInfoData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sUrl = null,
    Object? name = null,
    Object? policy = null,
    Object? ext = null,
    Object? info = null,
  }) {
    return _then(_$ModelInfoDataImpl(
      sUrl: null == sUrl
          ? _value.sUrl
          : sUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      policy: null == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as String,
      ext: null == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String,
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as List<ModelInfoList>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelInfoDataImpl implements _ModelInfoData {
  _$ModelInfoDataImpl(
      {required this.sUrl,
      required this.name,
      required this.policy,
      this.ext = ".",
      required this.info});

  factory _$ModelInfoDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelInfoDataImplFromJson(json);

  @override
  String sUrl;
  @override
  String name;
  @override
  String policy;
  @override
  @JsonKey()
  String ext;
  @override
  List<ModelInfoList> info;

  @override
  String toString() {
    return 'ModelInfoData(sUrl: $sUrl, name: $name, policy: $policy, ext: $ext, info: $info)';
  }

  /// Create a copy of ModelInfoData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelInfoDataImplCopyWith<_$ModelInfoDataImpl> get copyWith =>
      __$$ModelInfoDataImplCopyWithImpl<_$ModelInfoDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelInfoDataImplToJson(
      this,
    );
  }
}

abstract class _ModelInfoData implements ModelInfoData {
  factory _ModelInfoData(
      {required String sUrl,
      required String name,
      required String policy,
      String ext,
      required List<ModelInfoList> info}) = _$ModelInfoDataImpl;

  factory _ModelInfoData.fromJson(Map<String, dynamic> json) =
      _$ModelInfoDataImpl.fromJson;

  @override
  String get sUrl;

  set sUrl(String value);

  @override
  String get name;

  set name(String value);

  @override
  String get policy;

  set policy(String value);

  @override
  String get ext;

  set ext(String value);

  @override
  List<ModelInfoList> get info;

  set info(List<ModelInfoList> value);

  /// Create a copy of ModelInfoData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelInfoDataImplCopyWith<_$ModelInfoDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ModelInfoList _$ModelInfoListFromJson(Map<String, dynamic> json) {
  return _ModelInfoList.fromJson(json);
}

/// @nodoc
mixin _$ModelInfoList {
  String get size => throw _privateConstructorUsedError;

  set size(String value) => throw _privateConstructorUsedError;

  String get hash => throw _privateConstructorUsedError;

  set hash(String value) => throw _privateConstructorUsedError;

  String get quantMethod => throw _privateConstructorUsedError;

  set quantMethod(String value) => throw _privateConstructorUsedError;

  /// Serializes this ModelInfoList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModelInfoList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelInfoListCopyWith<ModelInfoList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelInfoListCopyWith<$Res> {
  factory $ModelInfoListCopyWith(
          ModelInfoList value, $Res Function(ModelInfoList) then) =
      _$ModelInfoListCopyWithImpl<$Res, ModelInfoList>;

  @useResult
  $Res call({String size, String hash, String quantMethod});
}

/// @nodoc
class _$ModelInfoListCopyWithImpl<$Res, $Val extends ModelInfoList>
    implements $ModelInfoListCopyWith<$Res> {
  _$ModelInfoListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelInfoList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? hash = null,
    Object? quantMethod = null,
  }) {
    return _then(_value.copyWith(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      quantMethod: null == quantMethod
          ? _value.quantMethod
          : quantMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelInfoListImplCopyWith<$Res>
    implements $ModelInfoListCopyWith<$Res> {
  factory _$$ModelInfoListImplCopyWith(
          _$ModelInfoListImpl value, $Res Function(_$ModelInfoListImpl) then) =
      __$$ModelInfoListImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String size, String hash, String quantMethod});
}

/// @nodoc
class __$$ModelInfoListImplCopyWithImpl<$Res>
    extends _$ModelInfoListCopyWithImpl<$Res, _$ModelInfoListImpl>
    implements _$$ModelInfoListImplCopyWith<$Res> {
  __$$ModelInfoListImplCopyWithImpl(
      _$ModelInfoListImpl _value, $Res Function(_$ModelInfoListImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModelInfoList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? hash = null,
    Object? quantMethod = null,
  }) {
    return _then(_$ModelInfoListImpl(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      quantMethod: null == quantMethod
          ? _value.quantMethod
          : quantMethod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModelInfoListImpl implements _ModelInfoList {
  _$ModelInfoListImpl(
      {required this.size, required this.hash, required this.quantMethod});

  factory _$ModelInfoListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModelInfoListImplFromJson(json);

  @override
  String size;
  @override
  String hash;
  @override
  String quantMethod;

  @override
  String toString() {
    return 'ModelInfoList(size: $size, hash: $hash, quantMethod: $quantMethod)';
  }

  /// Create a copy of ModelInfoList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelInfoListImplCopyWith<_$ModelInfoListImpl> get copyWith =>
      __$$ModelInfoListImplCopyWithImpl<_$ModelInfoListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModelInfoListImplToJson(
      this,
    );
  }
}

abstract class _ModelInfoList implements ModelInfoList {
  factory _ModelInfoList(
      {required String size,
      required String hash,
      required String quantMethod}) = _$ModelInfoListImpl;

  factory _ModelInfoList.fromJson(Map<String, dynamic> json) =
      _$ModelInfoListImpl.fromJson;

  @override
  String get size;

  set size(String value);

  @override
  String get hash;

  set hash(String value);

  @override
  String get quantMethod;

  set quantMethod(String value);

  /// Create a copy of ModelInfoList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelInfoListImplCopyWith<_$ModelInfoListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
