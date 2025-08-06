// This is a generated file - do not edit.
//
// Generated from DemirbasService.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'DemirbasService.pb.dart' as $0;

export 'DemirbasService.pb.dart';

@$pb.GrpcServiceName('org.pgmbim.grpc.DemirbasService')
class DemirbasServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  DemirbasServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.InsertDemirbasResponse> insertDemirbas(
    $0.InsertDemirbasRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$insertDemirbas, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchDemirbasResponse> searchDemirbas(
    $0.SearchDemirbasRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchDemirbas, request, options: options);
  }

  // method descriptors

  static final _$insertDemirbas =
      $grpc.ClientMethod<$0.InsertDemirbasRequest, $0.InsertDemirbasResponse>(
          '/org.pgmbim.grpc.DemirbasService/InsertDemirbas',
          ($0.InsertDemirbasRequest value) => value.writeToBuffer(),
          $0.InsertDemirbasResponse.fromBuffer);
  static final _$searchDemirbas =
      $grpc.ClientMethod<$0.SearchDemirbasRequest, $0.SearchDemirbasResponse>(
          '/org.pgmbim.grpc.DemirbasService/SearchDemirbas',
          ($0.SearchDemirbasRequest value) => value.writeToBuffer(),
          $0.SearchDemirbasResponse.fromBuffer);
}

@$pb.GrpcServiceName('org.pgmbim.grpc.DemirbasService')
abstract class DemirbasServiceBase extends $grpc.Service {
  $core.String get $name => 'org.pgmbim.grpc.DemirbasService';

  DemirbasServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.InsertDemirbasRequest,
            $0.InsertDemirbasResponse>(
        'InsertDemirbas',
        insertDemirbas_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InsertDemirbasRequest.fromBuffer(value),
        ($0.InsertDemirbasResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchDemirbasRequest,
            $0.SearchDemirbasResponse>(
        'SearchDemirbas',
        searchDemirbas_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SearchDemirbasRequest.fromBuffer(value),
        ($0.SearchDemirbasResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.InsertDemirbasResponse> insertDemirbas_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InsertDemirbasRequest> $request) async {
    return insertDemirbas($call, await $request);
  }

  $async.Future<$0.InsertDemirbasResponse> insertDemirbas(
      $grpc.ServiceCall call, $0.InsertDemirbasRequest request);

  $async.Future<$0.SearchDemirbasResponse> searchDemirbas_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SearchDemirbasRequest> $request) async {
    return searchDemirbas($call, await $request);
  }

  $async.Future<$0.SearchDemirbasResponse> searchDemirbas(
      $grpc.ServiceCall call, $0.SearchDemirbasRequest request);
}
