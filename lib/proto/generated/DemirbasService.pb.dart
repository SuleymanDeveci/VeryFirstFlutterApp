// This is a generated file - do not edit.
//
// Generated from DemirbasService.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InsertDemirbasRequest extends $pb.GeneratedMessage {
  factory InsertDemirbasRequest({
    $core.String? demirbasNum,
    $core.String? ipAddress,
    $core.String? os,
    $core.String? hardwareInfo,
  }) {
    final result = create();
    if (demirbasNum != null) result.demirbasNum = demirbasNum;
    if (ipAddress != null) result.ipAddress = ipAddress;
    if (os != null) result.os = os;
    if (hardwareInfo != null) result.hardwareInfo = hardwareInfo;
    return result;
  }

  InsertDemirbasRequest._();

  factory InsertDemirbasRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsertDemirbasRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsertDemirbasRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'demirbasNum')
    ..aOS(2, _omitFieldNames ? '' : 'ipAddress')
    ..aOS(3, _omitFieldNames ? '' : 'os')
    ..aOS(4, _omitFieldNames ? '' : 'hardwareInfo')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsertDemirbasRequest clone() =>
      InsertDemirbasRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsertDemirbasRequest copyWith(
          void Function(InsertDemirbasRequest) updates) =>
      super.copyWith((message) => updates(message as InsertDemirbasRequest))
          as InsertDemirbasRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsertDemirbasRequest create() => InsertDemirbasRequest._();
  @$core.override
  InsertDemirbasRequest createEmptyInstance() => create();
  static $pb.PbList<InsertDemirbasRequest> createRepeated() =>
      $pb.PbList<InsertDemirbasRequest>();
  @$core.pragma('dart2js:noInline')
  static InsertDemirbasRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsertDemirbasRequest>(create);
  static InsertDemirbasRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get demirbasNum => $_getSZ(0);
  @$pb.TagNumber(1)
  set demirbasNum($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDemirbasNum() => $_has(0);
  @$pb.TagNumber(1)
  void clearDemirbasNum() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ipAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ipAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIpAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearIpAddress() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get os => $_getSZ(2);
  @$pb.TagNumber(3)
  set os($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOs() => $_has(2);
  @$pb.TagNumber(3)
  void clearOs() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get hardwareInfo => $_getSZ(3);
  @$pb.TagNumber(4)
  set hardwareInfo($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHardwareInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearHardwareInfo() => $_clearField(4);
}

class InsertDemirbasResponse extends $pb.GeneratedMessage {
  factory InsertDemirbasResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  InsertDemirbasResponse._();

  factory InsertDemirbasResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsertDemirbasResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsertDemirbasResponse',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsertDemirbasResponse clone() =>
      InsertDemirbasResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsertDemirbasResponse copyWith(
          void Function(InsertDemirbasResponse) updates) =>
      super.copyWith((message) => updates(message as InsertDemirbasResponse))
          as InsertDemirbasResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsertDemirbasResponse create() => InsertDemirbasResponse._();
  @$core.override
  InsertDemirbasResponse createEmptyInstance() => create();
  static $pb.PbList<InsertDemirbasResponse> createRepeated() =>
      $pb.PbList<InsertDemirbasResponse>();
  @$core.pragma('dart2js:noInline')
  static InsertDemirbasResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsertDemirbasResponse>(create);
  static InsertDemirbasResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class SearchDemirbasRequest extends $pb.GeneratedMessage {
  factory SearchDemirbasRequest({
    $core.String? ipAddress,
    $core.String? demirbasNum,
  }) {
    final result = create();
    if (ipAddress != null) result.ipAddress = ipAddress;
    if (demirbasNum != null) result.demirbasNum = demirbasNum;
    return result;
  }

  SearchDemirbasRequest._();

  factory SearchDemirbasRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchDemirbasRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchDemirbasRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ipAddress')
    ..aOS(2, _omitFieldNames ? '' : 'demirbasNum')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchDemirbasRequest clone() =>
      SearchDemirbasRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchDemirbasRequest copyWith(
          void Function(SearchDemirbasRequest) updates) =>
      super.copyWith((message) => updates(message as SearchDemirbasRequest))
          as SearchDemirbasRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchDemirbasRequest create() => SearchDemirbasRequest._();
  @$core.override
  SearchDemirbasRequest createEmptyInstance() => create();
  static $pb.PbList<SearchDemirbasRequest> createRepeated() =>
      $pb.PbList<SearchDemirbasRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchDemirbasRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchDemirbasRequest>(create);
  static SearchDemirbasRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ipAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ipAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIpAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearIpAddress() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get demirbasNum => $_getSZ(1);
  @$pb.TagNumber(2)
  set demirbasNum($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDemirbasNum() => $_has(1);
  @$pb.TagNumber(2)
  void clearDemirbasNum() => $_clearField(2);
}

class SearchDemirbasResponse extends $pb.GeneratedMessage {
  factory SearchDemirbasResponse({
    $core.int? id,
    $core.String? demirbasNum,
    $core.String? ipAddress,
    $core.String? os,
    $core.String? hardwareInfo,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (demirbasNum != null) result.demirbasNum = demirbasNum;
    if (ipAddress != null) result.ipAddress = ipAddress;
    if (os != null) result.os = os;
    if (hardwareInfo != null) result.hardwareInfo = hardwareInfo;
    return result;
  }

  SearchDemirbasResponse._();

  factory SearchDemirbasResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchDemirbasResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchDemirbasResponse',
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'demirbasNum')
    ..aOS(3, _omitFieldNames ? '' : 'ipAddress')
    ..aOS(4, _omitFieldNames ? '' : 'os')
    ..aOS(5, _omitFieldNames ? '' : 'hardwareInfo')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchDemirbasResponse clone() =>
      SearchDemirbasResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchDemirbasResponse copyWith(
          void Function(SearchDemirbasResponse) updates) =>
      super.copyWith((message) => updates(message as SearchDemirbasResponse))
          as SearchDemirbasResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchDemirbasResponse create() => SearchDemirbasResponse._();
  @$core.override
  SearchDemirbasResponse createEmptyInstance() => create();
  static $pb.PbList<SearchDemirbasResponse> createRepeated() =>
      $pb.PbList<SearchDemirbasResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchDemirbasResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchDemirbasResponse>(create);
  static SearchDemirbasResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get demirbasNum => $_getSZ(1);
  @$pb.TagNumber(2)
  set demirbasNum($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDemirbasNum() => $_has(1);
  @$pb.TagNumber(2)
  void clearDemirbasNum() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get ipAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set ipAddress($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIpAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearIpAddress() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get os => $_getSZ(3);
  @$pb.TagNumber(4)
  set os($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOs() => $_has(3);
  @$pb.TagNumber(4)
  void clearOs() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get hardwareInfo => $_getSZ(4);
  @$pb.TagNumber(5)
  set hardwareInfo($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHardwareInfo() => $_has(4);
  @$pb.TagNumber(5)
  void clearHardwareInfo() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
