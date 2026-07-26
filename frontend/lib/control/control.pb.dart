// This is a generated file - do not edit.
//
// Generated from control.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class AudioStatusRequest extends $pb.GeneratedMessage {
  factory AudioStatusRequest() => create();

  AudioStatusRequest._();

  factory AudioStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioStatusRequest copyWith(void Function(AudioStatusRequest) updates) =>
      super.copyWith((message) => updates(message as AudioStatusRequest))
          as AudioStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioStatusRequest create() => AudioStatusRequest._();
  @$core.override
  AudioStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioStatusRequest>(create);
  static AudioStatusRequest? _defaultInstance;
}

class AudioStatus extends $pb.GeneratedMessage {
  factory AudioStatus({
    $core.int? activeSlot,
    $core.String? state,
    $core.double? timeRemainingSeconds,
  }) {
    final result = create();
    if (activeSlot != null) result.activeSlot = activeSlot;
    if (state != null) result.state = state;
    if (timeRemainingSeconds != null)
      result.timeRemainingSeconds = timeRemainingSeconds;
    return result;
  }

  AudioStatus._();

  factory AudioStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'activeSlot')
    ..aOS(2, _omitFieldNames ? '' : 'state')
    ..aD(3, _omitFieldNames ? '' : 'timeRemainingSeconds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioStatus copyWith(void Function(AudioStatus) updates) =>
      super.copyWith((message) => updates(message as AudioStatus))
          as AudioStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioStatus create() => AudioStatus._();
  @$core.override
  AudioStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioStatus>(create);
  static AudioStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get activeSlot => $_getIZ(0);
  @$pb.TagNumber(1)
  set activeSlot($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasActiveSlot() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveSlot() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get state => $_getSZ(1);
  @$pb.TagNumber(2)
  set state($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get timeRemainingSeconds => $_getN(2);
  @$pb.TagNumber(3)
  set timeRemainingSeconds($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimeRemainingSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeRemainingSeconds() => $_clearField(3);
}

class PlaybackRequest extends $pb.GeneratedMessage {
  factory PlaybackRequest({
    $core.String? action,
  }) {
    final result = create();
    if (action != null) result.action = action;
    return result;
  }

  PlaybackRequest._();

  factory PlaybackRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlaybackRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlaybackRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'action')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackRequest copyWith(void Function(PlaybackRequest) updates) =>
      super.copyWith((message) => updates(message as PlaybackRequest))
          as PlaybackRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaybackRequest create() => PlaybackRequest._();
  @$core.override
  PlaybackRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlaybackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlaybackRequest>(create);
  static PlaybackRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get action => $_getSZ(0);
  @$pb.TagNumber(1)
  set action($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => $_clearField(1);
}

class PlaybackResponse extends $pb.GeneratedMessage {
  factory PlaybackResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  PlaybackResponse._();

  factory PlaybackResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlaybackResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlaybackResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackResponse copyWith(void Function(PlaybackResponse) updates) =>
      super.copyWith((message) => updates(message as PlaybackResponse))
          as PlaybackResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaybackResponse create() => PlaybackResponse._();
  @$core.override
  PlaybackResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlaybackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlaybackResponse>(create);
  static PlaybackResponse? _defaultInstance;

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

class Palette extends $pb.GeneratedMessage {
  factory Palette({
    $core.int? id,
    $core.String? name,
    $core.Iterable<PlayerSlot>? slots,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (slots != null) result.slots.addAll(slots);
    return result;
  }

  Palette._();

  factory Palette.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Palette.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Palette',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPM<PlayerSlot>(3, _omitFieldNames ? '' : 'slots',
        subBuilder: PlayerSlot.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Palette clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Palette copyWith(void Function(Palette) updates) =>
      super.copyWith((message) => updates(message as Palette)) as Palette;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Palette create() => Palette._();
  @$core.override
  Palette createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Palette getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Palette>(create);
  static Palette? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<PlayerSlot> get slots => $_getList(2);
}

class PaletteResponse extends $pb.GeneratedMessage {
  factory PaletteResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? id,
    $core.String? name,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    return result;
  }

  PaletteResponse._();

  factory PaletteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaletteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaletteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aI(3, _omitFieldNames ? '' : 'id')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteResponse copyWith(void Function(PaletteResponse) updates) =>
      super.copyWith((message) => updates(message as PaletteResponse))
          as PaletteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaletteResponse create() => PaletteResponse._();
  @$core.override
  PaletteResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaletteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaletteResponse>(create);
  static PaletteResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get id => $_getIZ(2);
  @$pb.TagNumber(3)
  set id($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);
}

class PaletteID extends $pb.GeneratedMessage {
  factory PaletteID({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  PaletteID._();

  factory PaletteID.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaletteID.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaletteID',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteID clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteID copyWith(void Function(PaletteID) updates) =>
      super.copyWith((message) => updates(message as PaletteID)) as PaletteID;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaletteID create() => PaletteID._();
  @$core.override
  PaletteID createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaletteID getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaletteID>(create);
  static PaletteID? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class ActivatePalette extends $pb.GeneratedMessage {
  factory ActivatePalette({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  ActivatePalette._();

  factory ActivatePalette.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ActivatePalette.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ActivatePalette',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivatePalette clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ActivatePalette copyWith(void Function(ActivatePalette) updates) =>
      super.copyWith((message) => updates(message as ActivatePalette))
          as ActivatePalette;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ActivatePalette create() => ActivatePalette._();
  @$core.override
  ActivatePalette createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ActivatePalette getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ActivatePalette>(create);
  static ActivatePalette? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class PaletteActivateResponse extends $pb.GeneratedMessage {
  factory PaletteActivateResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  PaletteActivateResponse._();

  factory PaletteActivateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaletteActivateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaletteActivateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteActivateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteActivateResponse copyWith(
          void Function(PaletteActivateResponse) updates) =>
      super.copyWith((message) => updates(message as PaletteActivateResponse))
          as PaletteActivateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaletteActivateResponse create() => PaletteActivateResponse._();
  @$core.override
  PaletteActivateResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaletteActivateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaletteActivateResponse>(create);
  static PaletteActivateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class AudioFile extends $pb.GeneratedMessage {
  factory AudioFile({
    $core.int? id,
    $core.String? fileName,
    $core.String? filePath,
    $core.double? duration,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (fileName != null) result.fileName = fileName;
    if (filePath != null) result.filePath = filePath;
    if (duration != null) result.duration = duration;
    return result;
  }

  AudioFile._();

  factory AudioFile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioFile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioFile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'fileName')
    ..aOS(3, _omitFieldNames ? '' : 'filePath')
    ..aD(4, _omitFieldNames ? '' : 'duration')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFile copyWith(void Function(AudioFile) updates) =>
      super.copyWith((message) => updates(message as AudioFile)) as AudioFile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioFile create() => AudioFile._();
  @$core.override
  AudioFile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioFile getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AudioFile>(create);
  static AudioFile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFileName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get filePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set filePath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFilePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilePath() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get duration => $_getN(3);
  @$pb.TagNumber(4)
  set duration($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearDuration() => $_clearField(4);
}

class AudioFileResponse extends $pb.GeneratedMessage {
  factory AudioFileResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? fileName,
    $core.String? filePath,
    $core.double? duration,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (fileName != null) result.fileName = fileName;
    if (filePath != null) result.filePath = filePath;
    if (duration != null) result.duration = duration;
    return result;
  }

  AudioFileResponse._();

  factory AudioFileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioFileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioFileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'fileName')
    ..aOS(4, _omitFieldNames ? '' : 'filePath')
    ..aD(5, _omitFieldNames ? '' : 'duration')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFileResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFileResponse copyWith(void Function(AudioFileResponse) updates) =>
      super.copyWith((message) => updates(message as AudioFileResponse))
          as AudioFileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioFileResponse create() => AudioFileResponse._();
  @$core.override
  AudioFileResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioFileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioFileResponse>(create);
  static AudioFileResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get fileName => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFileName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get filePath => $_getSZ(3);
  @$pb.TagNumber(4)
  set filePath($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFilePath() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilePath() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get duration => $_getN(4);
  @$pb.TagNumber(5)
  set duration($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearDuration() => $_clearField(5);
}

class PlayerSlot extends $pb.GeneratedMessage {
  factory PlayerSlot({
    $core.int? id,
    AudioFile? file,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (file != null) result.file = file;
    return result;
  }

  PlayerSlot._();

  factory PlayerSlot.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlayerSlot.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayerSlot',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..aOM<AudioFile>(2, _omitFieldNames ? '' : 'file',
        subBuilder: AudioFile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerSlot clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerSlot copyWith(void Function(PlayerSlot) updates) =>
      super.copyWith((message) => updates(message as PlayerSlot)) as PlayerSlot;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerSlot create() => PlayerSlot._();
  @$core.override
  PlayerSlot createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlayerSlot getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayerSlot>(create);
  static PlayerSlot? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  AudioFile get file => $_getN(1);
  @$pb.TagNumber(2)
  set file(AudioFile value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFile() => $_has(1);
  @$pb.TagNumber(2)
  void clearFile() => $_clearField(2);
  @$pb.TagNumber(2)
  AudioFile ensureFile() => $_ensure(1);
}

class PaletteListRequest extends $pb.GeneratedMessage {
  factory PaletteListRequest() => create();

  PaletteListRequest._();

  factory PaletteListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaletteListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaletteListRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteListRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteListRequest copyWith(void Function(PaletteListRequest) updates) =>
      super.copyWith((message) => updates(message as PaletteListRequest))
          as PaletteListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaletteListRequest create() => PaletteListRequest._();
  @$core.override
  PaletteListRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaletteListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaletteListRequest>(create);
  static PaletteListRequest? _defaultInstance;
}

class PaletteListResponse extends $pb.GeneratedMessage {
  factory PaletteListResponse({
    $core.bool? success,
    $core.Iterable<Palette>? palettes,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (palettes != null) result.palettes.addAll(palettes);
    return result;
  }

  PaletteListResponse._();

  factory PaletteListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaletteListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaletteListResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..pPM<Palette>(2, _omitFieldNames ? '' : 'palettes',
        subBuilder: Palette.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteListResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteListResponse copyWith(void Function(PaletteListResponse) updates) =>
      super.copyWith((message) => updates(message as PaletteListResponse))
          as PaletteListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaletteListResponse create() => PaletteListResponse._();
  @$core.override
  PaletteListResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaletteListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaletteListResponse>(create);
  static PaletteListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Palette> get palettes => $_getList(1);
}

class PaletteGetResponse extends $pb.GeneratedMessage {
  factory PaletteGetResponse({
    $core.bool? success,
    Palette? palette,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (palette != null) result.palette = palette;
    return result;
  }

  PaletteGetResponse._();

  factory PaletteGetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaletteGetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaletteGetResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<Palette>(2, _omitFieldNames ? '' : 'palette',
        subBuilder: Palette.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteGetResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteGetResponse copyWith(void Function(PaletteGetResponse) updates) =>
      super.copyWith((message) => updates(message as PaletteGetResponse))
          as PaletteGetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaletteGetResponse create() => PaletteGetResponse._();
  @$core.override
  PaletteGetResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaletteGetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaletteGetResponse>(create);
  static PaletteGetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  Palette get palette => $_getN(1);
  @$pb.TagNumber(2)
  set palette(Palette value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPalette() => $_has(1);
  @$pb.TagNumber(2)
  void clearPalette() => $_clearField(2);
  @$pb.TagNumber(2)
  Palette ensurePalette() => $_ensure(1);
}

class PaletteDeleteResponse extends $pb.GeneratedMessage {
  factory PaletteDeleteResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  PaletteDeleteResponse._();

  factory PaletteDeleteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaletteDeleteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaletteDeleteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteDeleteResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaletteDeleteResponse copyWith(
          void Function(PaletteDeleteResponse) updates) =>
      super.copyWith((message) => updates(message as PaletteDeleteResponse))
          as PaletteDeleteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaletteDeleteResponse create() => PaletteDeleteResponse._();
  @$core.override
  PaletteDeleteResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PaletteDeleteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaletteDeleteResponse>(create);
  static PaletteDeleteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class AudioFileList extends $pb.GeneratedMessage {
  factory AudioFileList({
    $core.Iterable<AudioFile>? audioFiles,
  }) {
    final result = create();
    if (audioFiles != null) result.audioFiles.addAll(audioFiles);
    return result;
  }

  AudioFileList._();

  factory AudioFileList.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioFileList.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioFileList',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pPM<AudioFile>(1, _omitFieldNames ? '' : 'audioFiles',
        subBuilder: AudioFile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFileList clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFileList copyWith(void Function(AudioFileList) updates) =>
      super.copyWith((message) => updates(message as AudioFileList))
          as AudioFileList;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioFileList create() => AudioFileList._();
  @$core.override
  AudioFileList createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioFileList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioFileList>(create);
  static AudioFileList? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AudioFile> get audioFiles => $_getList(0);
}

class ListAudioFileRequest extends $pb.GeneratedMessage {
  factory ListAudioFileRequest() => create();

  ListAudioFileRequest._();

  factory ListAudioFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAudioFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAudioFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAudioFileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAudioFileRequest copyWith(void Function(ListAudioFileRequest) updates) =>
      super.copyWith((message) => updates(message as ListAudioFileRequest))
          as ListAudioFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAudioFileRequest create() => ListAudioFileRequest._();
  @$core.override
  ListAudioFileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAudioFileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAudioFileRequest>(create);
  static ListAudioFileRequest? _defaultInstance;
}

class AudioFileID extends $pb.GeneratedMessage {
  factory AudioFileID({
    $core.int? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  AudioFileID._();

  factory AudioFileID.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioFileID.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioFileID',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFileID clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFileID copyWith(void Function(AudioFileID) updates) =>
      super.copyWith((message) => updates(message as AudioFileID))
          as AudioFileID;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioFileID create() => AudioFileID._();
  @$core.override
  AudioFileID createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioFileID getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioFileID>(create);
  static AudioFileID? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetAudioFileResponse extends $pb.GeneratedMessage {
  factory GetAudioFileResponse({
    $core.bool? success,
    AudioFile? audioFile,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (audioFile != null) result.audioFile = audioFile;
    return result;
  }

  GetAudioFileResponse._();

  factory GetAudioFileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudioFileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudioFileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<AudioFile>(2, _omitFieldNames ? '' : 'audioFile',
        subBuilder: AudioFile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioFileResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioFileResponse copyWith(void Function(GetAudioFileResponse) updates) =>
      super.copyWith((message) => updates(message as GetAudioFileResponse))
          as GetAudioFileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudioFileResponse create() => GetAudioFileResponse._();
  @$core.override
  GetAudioFileResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetAudioFileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudioFileResponse>(create);
  static GetAudioFileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  AudioFile get audioFile => $_getN(1);
  @$pb.TagNumber(2)
  set audioFile(AudioFile value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAudioFile() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudioFile() => $_clearField(2);
  @$pb.TagNumber(2)
  AudioFile ensureAudioFile() => $_ensure(1);
}

class AudioFileDeleteResponse extends $pb.GeneratedMessage {
  factory AudioFileDeleteResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  AudioFileDeleteResponse._();

  factory AudioFileDeleteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioFileDeleteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioFileDeleteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFileDeleteResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioFileDeleteResponse copyWith(
          void Function(AudioFileDeleteResponse) updates) =>
      super.copyWith((message) => updates(message as AudioFileDeleteResponse))
          as AudioFileDeleteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioFileDeleteResponse create() => AudioFileDeleteResponse._();
  @$core.override
  AudioFileDeleteResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioFileDeleteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioFileDeleteResponse>(create);
  static AudioFileDeleteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class AssignAudioFileRequest extends $pb.GeneratedMessage {
  factory AssignAudioFileRequest({
    $core.int? slotId,
    $core.int? fileId,
  }) {
    final result = create();
    if (slotId != null) result.slotId = slotId;
    if (fileId != null) result.fileId = fileId;
    return result;
  }

  AssignAudioFileRequest._();

  factory AssignAudioFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AssignAudioFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssignAudioFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'slotId')
    ..aI(2, _omitFieldNames ? '' : 'fileId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssignAudioFileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssignAudioFileRequest copyWith(
          void Function(AssignAudioFileRequest) updates) =>
      super.copyWith((message) => updates(message as AssignAudioFileRequest))
          as AssignAudioFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssignAudioFileRequest create() => AssignAudioFileRequest._();
  @$core.override
  AssignAudioFileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AssignAudioFileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AssignAudioFileRequest>(create);
  static AssignAudioFileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get slotId => $_getIZ(0);
  @$pb.TagNumber(1)
  set slotId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSlotId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSlotId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get fileId => $_getIZ(1);
  @$pb.TagNumber(2)
  set fileId($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFileId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileId() => $_clearField(2);
}

class UnassignAudioFileRequest extends $pb.GeneratedMessage {
  factory UnassignAudioFileRequest({
    $core.int? slotId,
  }) {
    final result = create();
    if (slotId != null) result.slotId = slotId;
    return result;
  }

  UnassignAudioFileRequest._();

  factory UnassignAudioFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnassignAudioFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnassignAudioFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'slotId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnassignAudioFileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnassignAudioFileRequest copyWith(
          void Function(UnassignAudioFileRequest) updates) =>
      super.copyWith((message) => updates(message as UnassignAudioFileRequest))
          as UnassignAudioFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnassignAudioFileRequest create() => UnassignAudioFileRequest._();
  @$core.override
  UnassignAudioFileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UnassignAudioFileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnassignAudioFileRequest>(create);
  static UnassignAudioFileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get slotId => $_getIZ(0);
  @$pb.TagNumber(1)
  set slotId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSlotId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSlotId() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
