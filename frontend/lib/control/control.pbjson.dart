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

@$core.Deprecated('Use audioStatusRequestDescriptor instead')
const AudioStatusRequest$json = {
  '1': 'AudioStatusRequest',
};

/// Descriptor for `AudioStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioStatusRequestDescriptor =
    $convert.base64Decode('ChJBdWRpb1N0YXR1c1JlcXVlc3Q=');

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

@$core.Deprecated('Use playbackRequestDescriptor instead')
const PlaybackRequest$json = {
  '1': 'PlaybackRequest',
  '2': [
    {'1': 'action', '3': 1, '4': 1, '5': 9, '10': 'action'},
  ],
};

/// Descriptor for `PlaybackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playbackRequestDescriptor = $convert
    .base64Decode('Cg9QbGF5YmFja1JlcXVlc3QSFgoGYWN0aW9uGAEgASgJUgZhY3Rpb24=');

@$core.Deprecated('Use playbackResponseDescriptor instead')
const PlaybackResponse$json = {
  '1': 'PlaybackResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `PlaybackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playbackResponseDescriptor = $convert.base64Decode(
    'ChBQbGF5YmFja1Jlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZR'
    'gCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use paletteDescriptor instead')
const Palette$json = {
  '1': 'Palette',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'slots',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.pb.PlayerSlot',
      '10': 'slots'
    },
  ],
};

/// Descriptor for `Palette`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paletteDescriptor = $convert.base64Decode(
    'CgdQYWxldHRlEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiQKBXNsb3RzGA'
    'MgAygLMg4ucGIuUGxheWVyU2xvdFIFc2xvdHM=');

@$core.Deprecated('Use paletteResponseDescriptor instead')
const PaletteResponse$json = {
  '1': 'PaletteResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'id', '3': 3, '4': 1, '5': 5, '10': 'id'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `PaletteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paletteResponseDescriptor = $convert.base64Decode(
    'Cg9QYWxldHRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGA'
    'IgASgJUgdtZXNzYWdlEg4KAmlkGAMgASgFUgJpZBISCgRuYW1lGAQgASgJUgRuYW1l');

@$core.Deprecated('Use paletteIDDescriptor instead')
const PaletteID$json = {
  '1': 'PaletteID',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `PaletteID`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paletteIDDescriptor =
    $convert.base64Decode('CglQYWxldHRlSUQSDgoCaWQYASABKAVSAmlk');

@$core.Deprecated('Use activatePaletteDescriptor instead')
const ActivatePalette$json = {
  '1': 'ActivatePalette',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `ActivatePalette`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activatePaletteDescriptor =
    $convert.base64Decode('Cg9BY3RpdmF0ZVBhbGV0dGUSDgoCaWQYASABKAVSAmlk');

@$core.Deprecated('Use paletteActivateResponseDescriptor instead')
const PaletteActivateResponse$json = {
  '1': 'PaletteActivateResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `PaletteActivateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paletteActivateResponseDescriptor =
    $convert.base64Decode(
        'ChdQYWxldHRlQWN0aXZhdGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use audioFileDescriptor instead')
const AudioFile$json = {
  '1': 'AudioFile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'file_name', '3': 2, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'file_path', '3': 3, '4': 1, '5': 9, '10': 'filePath'},
    {'1': 'duration', '3': 4, '4': 1, '5': 1, '10': 'duration'},
  ],
};

/// Descriptor for `AudioFile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioFileDescriptor = $convert.base64Decode(
    'CglBdWRpb0ZpbGUSDgoCaWQYASABKAVSAmlkEhsKCWZpbGVfbmFtZRgCIAEoCVIIZmlsZU5hbW'
    'USGwoJZmlsZV9wYXRoGAMgASgJUghmaWxlUGF0aBIaCghkdXJhdGlvbhgEIAEoAVIIZHVyYXRp'
    'b24=');

@$core.Deprecated('Use audioFileResponseDescriptor instead')
const AudioFileResponse$json = {
  '1': 'AudioFileResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'file_name', '3': 3, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'file_path', '3': 4, '4': 1, '5': 9, '10': 'filePath'},
    {'1': 'duration', '3': 5, '4': 1, '5': 1, '10': 'duration'},
  ],
};

/// Descriptor for `AudioFileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioFileResponseDescriptor = $convert.base64Decode(
    'ChFBdWRpb0ZpbGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2'
    'UYAiABKAlSB21lc3NhZ2USGwoJZmlsZV9uYW1lGAMgASgJUghmaWxlTmFtZRIbCglmaWxlX3Bh'
    'dGgYBCABKAlSCGZpbGVQYXRoEhoKCGR1cmF0aW9uGAUgASgBUghkdXJhdGlvbg==');

@$core.Deprecated('Use playerSlotDescriptor instead')
const PlayerSlot$json = {
  '1': 'PlayerSlot',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'file', '3': 2, '4': 1, '5': 11, '6': '.pb.AudioFile', '10': 'file'},
  ],
};

/// Descriptor for `PlayerSlot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerSlotDescriptor = $convert.base64Decode(
    'CgpQbGF5ZXJTbG90Eg4KAmlkGAEgASgFUgJpZBIhCgRmaWxlGAIgASgLMg0ucGIuQXVkaW9GaW'
    'xlUgRmaWxl');

@$core.Deprecated('Use paletteListRequestDescriptor instead')
const PaletteListRequest$json = {
  '1': 'PaletteListRequest',
};

/// Descriptor for `PaletteListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paletteListRequestDescriptor =
    $convert.base64Decode('ChJQYWxldHRlTGlzdFJlcXVlc3Q=');

@$core.Deprecated('Use paletteListResponseDescriptor instead')
const PaletteListResponse$json = {
  '1': 'PaletteListResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'palettes',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.pb.Palette',
      '10': 'palettes'
    },
  ],
};

/// Descriptor for `PaletteListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paletteListResponseDescriptor = $convert.base64Decode(
    'ChNQYWxldHRlTGlzdFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSJwoIcGFsZX'
    'R0ZXMYAiADKAsyCy5wYi5QYWxldHRlUghwYWxldHRlcw==');

@$core.Deprecated('Use paletteGetResponseDescriptor instead')
const PaletteGetResponse$json = {
  '1': 'PaletteGetResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'palette',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.Palette',
      '10': 'palette'
    },
  ],
};

/// Descriptor for `PaletteGetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paletteGetResponseDescriptor = $convert.base64Decode(
    'ChJQYWxldHRlR2V0UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIlCgdwYWxldH'
    'RlGAIgASgLMgsucGIuUGFsZXR0ZVIHcGFsZXR0ZQ==');

@$core.Deprecated('Use paletteDeleteResponseDescriptor instead')
const PaletteDeleteResponse$json = {
  '1': 'PaletteDeleteResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `PaletteDeleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paletteDeleteResponseDescriptor =
    $convert.base64Decode(
        'ChVQYWxldHRlRGVsZXRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');

@$core.Deprecated('Use audioFileListDescriptor instead')
const AudioFileList$json = {
  '1': 'AudioFileList',
  '2': [
    {
      '1': 'audio_files',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.pb.AudioFile',
      '10': 'audioFiles'
    },
  ],
};

/// Descriptor for `AudioFileList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioFileListDescriptor = $convert.base64Decode(
    'Cg1BdWRpb0ZpbGVMaXN0Ei4KC2F1ZGlvX2ZpbGVzGAEgAygLMg0ucGIuQXVkaW9GaWxlUgphdW'
    'Rpb0ZpbGVz');

@$core.Deprecated('Use listAudioFileRequestDescriptor instead')
const ListAudioFileRequest$json = {
  '1': 'ListAudioFileRequest',
};

/// Descriptor for `ListAudioFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAudioFileRequestDescriptor =
    $convert.base64Decode('ChRMaXN0QXVkaW9GaWxlUmVxdWVzdA==');

@$core.Deprecated('Use audioFileIDDescriptor instead')
const AudioFileID$json = {
  '1': 'AudioFileID',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `AudioFileID`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioFileIDDescriptor =
    $convert.base64Decode('CgtBdWRpb0ZpbGVJRBIOCgJpZBgBIAEoBVICaWQ=');

@$core.Deprecated('Use getAudioFileResponseDescriptor instead')
const GetAudioFileResponse$json = {
  '1': 'GetAudioFileResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {
      '1': 'audio_file',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pb.AudioFile',
      '10': 'audioFile'
    },
  ],
};

/// Descriptor for `GetAudioFileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudioFileResponseDescriptor = $convert.base64Decode(
    'ChRHZXRBdWRpb0ZpbGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiwKCmF1ZG'
    'lvX2ZpbGUYAiABKAsyDS5wYi5BdWRpb0ZpbGVSCWF1ZGlvRmlsZQ==');

@$core.Deprecated('Use audioFileDeleteResponseDescriptor instead')
const AudioFileDeleteResponse$json = {
  '1': 'AudioFileDeleteResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `AudioFileDeleteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioFileDeleteResponseDescriptor =
    $convert.base64Decode(
        'ChdBdWRpb0ZpbGVEZWxldGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use assignAudioFileRequestDescriptor instead')
const AssignAudioFileRequest$json = {
  '1': 'AssignAudioFileRequest',
  '2': [
    {'1': 'slot_id', '3': 1, '4': 1, '5': 5, '10': 'slotId'},
    {'1': 'file_id', '3': 2, '4': 1, '5': 5, '10': 'fileId'},
  ],
};

/// Descriptor for `AssignAudioFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assignAudioFileRequestDescriptor =
    $convert.base64Decode(
        'ChZBc3NpZ25BdWRpb0ZpbGVSZXF1ZXN0EhcKB3Nsb3RfaWQYASABKAVSBnNsb3RJZBIXCgdmaW'
        'xlX2lkGAIgASgFUgZmaWxlSWQ=');

@$core.Deprecated('Use unassignAudioFileRequestDescriptor instead')
const UnassignAudioFileRequest$json = {
  '1': 'UnassignAudioFileRequest',
  '2': [
    {'1': 'slot_id', '3': 1, '4': 1, '5': 5, '10': 'slotId'},
  ],
};

/// Descriptor for `UnassignAudioFileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unassignAudioFileRequestDescriptor =
    $convert.base64Decode(
        'ChhVbmFzc2lnbkF1ZGlvRmlsZVJlcXVlc3QSFwoHc2xvdF9pZBgBIAEoBVIGc2xvdElk');
