// This is a generated file - do not edit.
//
// Generated from DemirbasService.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use insertDemirbasRequestDescriptor instead')
const InsertDemirbasRequest$json = {
  '1': 'InsertDemirbasRequest',
  '2': [
    {'1': 'demirbas_num', '3': 1, '4': 1, '5': 9, '10': 'demirbasNum'},
    {'1': 'ip_address', '3': 2, '4': 1, '5': 9, '10': 'ipAddress'},
    {'1': 'os', '3': 3, '4': 1, '5': 9, '10': 'os'},
    {'1': 'hardware_info', '3': 4, '4': 1, '5': 9, '10': 'hardwareInfo'},
  ],
};

/// Descriptor for `InsertDemirbasRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insertDemirbasRequestDescriptor = $convert.base64Decode(
    'ChVJbnNlcnREZW1pcmJhc1JlcXVlc3QSIQoMZGVtaXJiYXNfbnVtGAEgASgJUgtkZW1pcmJhc0'
    '51bRIdCgppcF9hZGRyZXNzGAIgASgJUglpcEFkZHJlc3MSDgoCb3MYAyABKAlSAm9zEiMKDWhh'
    'cmR3YXJlX2luZm8YBCABKAlSDGhhcmR3YXJlSW5mbw==');

@$core.Deprecated('Use insertDemirbasResponseDescriptor instead')
const InsertDemirbasResponse$json = {
  '1': 'InsertDemirbasResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `InsertDemirbasResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List insertDemirbasResponseDescriptor =
    $convert.base64Decode(
        'ChZJbnNlcnREZW1pcmJhc1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
        'Vzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use searchDemirbasRequestDescriptor instead')
const SearchDemirbasRequest$json = {
  '1': 'SearchDemirbasRequest',
  '2': [
    {'1': 'ip_address', '3': 1, '4': 1, '5': 9, '10': 'ipAddress'},
    {'1': 'demirbas_num', '3': 2, '4': 1, '5': 9, '10': 'demirbasNum'},
  ],
};

/// Descriptor for `SearchDemirbasRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchDemirbasRequestDescriptor = $convert.base64Decode(
    'ChVTZWFyY2hEZW1pcmJhc1JlcXVlc3QSHQoKaXBfYWRkcmVzcxgBIAEoCVIJaXBBZGRyZXNzEi'
    'EKDGRlbWlyYmFzX251bRgCIAEoCVILZGVtaXJiYXNOdW0=');

@$core.Deprecated('Use searchDemirbasResponseDescriptor instead')
const SearchDemirbasResponse$json = {
  '1': 'SearchDemirbasResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'demirbas_num', '3': 2, '4': 1, '5': 9, '10': 'demirbasNum'},
    {'1': 'ip_address', '3': 3, '4': 1, '5': 9, '10': 'ipAddress'},
    {'1': 'os', '3': 4, '4': 1, '5': 9, '10': 'os'},
    {'1': 'hardware_info', '3': 5, '4': 1, '5': 9, '10': 'hardwareInfo'},
  ],
};

/// Descriptor for `SearchDemirbasResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchDemirbasResponseDescriptor = $convert.base64Decode(
    'ChZTZWFyY2hEZW1pcmJhc1Jlc3BvbnNlEg4KAmlkGAEgASgFUgJpZBIhCgxkZW1pcmJhc19udW'
    '0YAiABKAlSC2RlbWlyYmFzTnVtEh0KCmlwX2FkZHJlc3MYAyABKAlSCWlwQWRkcmVzcxIOCgJv'
    'cxgEIAEoCVICb3MSIwoNaGFyZHdhcmVfaW5mbxgFIAEoCVIMaGFyZHdhcmVJbmZv');
