// This is a generated file - do not edit.
//
// Generated from control.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use statusRequestDescriptor instead')
const StatusRequest$json = {
  '1': 'StatusRequest',
};

/// Descriptor for `StatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusRequestDescriptor =
    $convert.base64Decode('Cg1TdGF0dXNSZXF1ZXN0');

@$core.Deprecated('Use audioStatusDescriptor instead')
const AudioStatus$json = {
  '1': 'AudioStatus',
  '2': [
    {'1': 'active_slot', '3': 1, '4': 1, '5': 5, '10': 'activeSlot'},
    {'1': 'state', '3': 2, '4': 1, '5': 9, '10': 'state'},
    {
      '1': 'time_remaining_seconds',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'timeRemainingSeconds'
    },
  ],
};

/// Descriptor for `AudioStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioStatusDescriptor = $convert.base64Decode(
    'CgtBdWRpb1N0YXR1cxIfCgthY3RpdmVfc2xvdBgBIAEoBVIKYWN0aXZlU2xvdBIUCgVzdGF0ZR'
    'gCIAEoCVIFc3RhdGUSNAoWdGltZV9yZW1haW5pbmdfc2Vjb25kcxgDIAEoAVIUdGltZVJlbWFp'
    'bmluZ1NlY29uZHM=');

@$core.Deprecated('Use commandRequestDescriptor instead')
const CommandRequest$json = {
  '1': 'CommandRequest',
  '2': [
    {'1': 'slot_id', '3': 1, '4': 1, '5': 5, '10': 'slotId'},
    {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
  ],
};

/// Descriptor for `CommandRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandRequestDescriptor = $convert.base64Decode(
    'Cg5Db21tYW5kUmVxdWVzdBIXCgdzbG90X2lkGAEgASgFUgZzbG90SWQSFgoGYWN0aW9uGAIgAS'
    'gJUgZhY3Rpb24=');

@$core.Deprecated('Use actionResponseDescriptor instead')
const ActionResponse$json = {
  '1': 'ActionResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ActionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionResponseDescriptor = $convert.base64Decode(
    'Cg5BY3Rpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAi'
    'ABKAlSB21lc3NhZ2U=');
