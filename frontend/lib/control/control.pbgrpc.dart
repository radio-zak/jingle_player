// This is a generated file - do not edit.
//
// Generated from control.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'control.pb.dart' as $0;

export 'control.pb.dart';

@$pb.GrpcServiceName('pb.AudioService')
class AudioServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AudioServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$0.AudioStatus> streamPlaybackStatus(
    $0.AudioStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$streamPlaybackStatus, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.PlayerSlot> streamSlotStatus(
    $0.SlotStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$streamSlotStatus, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.PlaybackResponse> playbackCommand(
    $0.PlaybackRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$playbackCommand, request, options: options);
  }

  $grpc.ResponseFuture<$0.PaletteListResponse> listPalettes(
    $0.PaletteListRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listPalettes, request, options: options);
  }

  $grpc.ResponseFuture<$0.PaletteGetResponse> getPalette(
    $0.PaletteID request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPalette, request, options: options);
  }

  $grpc.ResponseFuture<$0.PaletteResponse> updatePalette(
    $0.Palette request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updatePalette, request, options: options);
  }

  $grpc.ResponseFuture<$0.PaletteResponse> createPalette(
    $0.Palette request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createPalette, request, options: options);
  }

  $grpc.ResponseFuture<$0.PaletteDeleteResponse> deletePalette(
    $0.PaletteID request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deletePalette, request, options: options);
  }

  $grpc.ResponseFuture<$0.PaletteActivateResponse> activatePalette(
    $0.PaletteID request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$activatePalette, request, options: options);
  }

  $grpc.ResponseFuture<$0.AudioFileList> listAudioFiles(
    $0.ListAudioFileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listAudioFiles, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAudioFileResponse> getAudioFile(
    $0.AudioFileID request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAudioFile, request, options: options);
  }

  $grpc.ResponseFuture<$0.AudioFileResponse> createAudioFile(
    $async.Stream<$0.AudioFileUpload> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$createAudioFile, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.AudioFileResponse> updateAudioFile(
    $0.AudioFile request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateAudioFile, request, options: options);
  }

  $grpc.ResponseFuture<$0.AudioFileDeleteResponse> deleteAudioFile(
    $0.AudioFileID request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteAudioFile, request, options: options);
  }

  $grpc.ResponseFuture<$0.PlayerSlot> assignAudioFileToSlot(
    $0.AssignAudioFileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$assignAudioFileToSlot, request, options: options);
  }

  $grpc.ResponseFuture<$0.PlayerSlot> unassignAudioFileFromSlot(
    $0.UnassignAudioFileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unassignAudioFileFromSlot, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.PlayerSlot> activateSlot(
    $0.PlayerSlotID request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$activateSlot, request, options: options);
  }

  // method descriptors

  static final _$streamPlaybackStatus =
      $grpc.ClientMethod<$0.AudioStatusRequest, $0.AudioStatus>(
          '/pb.AudioService/StreamPlaybackStatus',
          ($0.AudioStatusRequest value) => value.writeToBuffer(),
          $0.AudioStatus.fromBuffer);
  static final _$streamSlotStatus =
      $grpc.ClientMethod<$0.SlotStatusRequest, $0.PlayerSlot>(
          '/pb.AudioService/StreamSlotStatus',
          ($0.SlotStatusRequest value) => value.writeToBuffer(),
          $0.PlayerSlot.fromBuffer);
  static final _$playbackCommand =
      $grpc.ClientMethod<$0.PlaybackRequest, $0.PlaybackResponse>(
          '/pb.AudioService/PlaybackCommand',
          ($0.PlaybackRequest value) => value.writeToBuffer(),
          $0.PlaybackResponse.fromBuffer);
  static final _$listPalettes =
      $grpc.ClientMethod<$0.PaletteListRequest, $0.PaletteListResponse>(
          '/pb.AudioService/ListPalettes',
          ($0.PaletteListRequest value) => value.writeToBuffer(),
          $0.PaletteListResponse.fromBuffer);
  static final _$getPalette =
      $grpc.ClientMethod<$0.PaletteID, $0.PaletteGetResponse>(
          '/pb.AudioService/GetPalette',
          ($0.PaletteID value) => value.writeToBuffer(),
          $0.PaletteGetResponse.fromBuffer);
  static final _$updatePalette =
      $grpc.ClientMethod<$0.Palette, $0.PaletteResponse>(
          '/pb.AudioService/UpdatePalette',
          ($0.Palette value) => value.writeToBuffer(),
          $0.PaletteResponse.fromBuffer);
  static final _$createPalette =
      $grpc.ClientMethod<$0.Palette, $0.PaletteResponse>(
          '/pb.AudioService/CreatePalette',
          ($0.Palette value) => value.writeToBuffer(),
          $0.PaletteResponse.fromBuffer);
  static final _$deletePalette =
      $grpc.ClientMethod<$0.PaletteID, $0.PaletteDeleteResponse>(
          '/pb.AudioService/DeletePalette',
          ($0.PaletteID value) => value.writeToBuffer(),
          $0.PaletteDeleteResponse.fromBuffer);
  static final _$activatePalette =
      $grpc.ClientMethod<$0.PaletteID, $0.PaletteActivateResponse>(
          '/pb.AudioService/ActivatePalette',
          ($0.PaletteID value) => value.writeToBuffer(),
          $0.PaletteActivateResponse.fromBuffer);
  static final _$listAudioFiles =
      $grpc.ClientMethod<$0.ListAudioFileRequest, $0.AudioFileList>(
          '/pb.AudioService/ListAudioFiles',
          ($0.ListAudioFileRequest value) => value.writeToBuffer(),
          $0.AudioFileList.fromBuffer);
  static final _$getAudioFile =
      $grpc.ClientMethod<$0.AudioFileID, $0.GetAudioFileResponse>(
          '/pb.AudioService/GetAudioFile',
          ($0.AudioFileID value) => value.writeToBuffer(),
          $0.GetAudioFileResponse.fromBuffer);
  static final _$createAudioFile =
      $grpc.ClientMethod<$0.AudioFileUpload, $0.AudioFileResponse>(
          '/pb.AudioService/CreateAudioFile',
          ($0.AudioFileUpload value) => value.writeToBuffer(),
          $0.AudioFileResponse.fromBuffer);
  static final _$updateAudioFile =
      $grpc.ClientMethod<$0.AudioFile, $0.AudioFileResponse>(
          '/pb.AudioService/UpdateAudioFile',
          ($0.AudioFile value) => value.writeToBuffer(),
          $0.AudioFileResponse.fromBuffer);
  static final _$deleteAudioFile =
      $grpc.ClientMethod<$0.AudioFileID, $0.AudioFileDeleteResponse>(
          '/pb.AudioService/DeleteAudioFile',
          ($0.AudioFileID value) => value.writeToBuffer(),
          $0.AudioFileDeleteResponse.fromBuffer);
  static final _$assignAudioFileToSlot =
      $grpc.ClientMethod<$0.AssignAudioFileRequest, $0.PlayerSlot>(
          '/pb.AudioService/AssignAudioFileToSlot',
          ($0.AssignAudioFileRequest value) => value.writeToBuffer(),
          $0.PlayerSlot.fromBuffer);
  static final _$unassignAudioFileFromSlot =
      $grpc.ClientMethod<$0.UnassignAudioFileRequest, $0.PlayerSlot>(
          '/pb.AudioService/UnassignAudioFileFromSlot',
          ($0.UnassignAudioFileRequest value) => value.writeToBuffer(),
          $0.PlayerSlot.fromBuffer);
  static final _$activateSlot =
      $grpc.ClientMethod<$0.PlayerSlotID, $0.PlayerSlot>(
          '/pb.AudioService/ActivateSlot',
          ($0.PlayerSlotID value) => value.writeToBuffer(),
          $0.PlayerSlot.fromBuffer);
}

@$pb.GrpcServiceName('pb.AudioService')
abstract class AudioServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AudioService';

  AudioServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AudioStatusRequest, $0.AudioStatus>(
        'StreamPlaybackStatus',
        streamPlaybackStatus_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.AudioStatusRequest.fromBuffer(value),
        ($0.AudioStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SlotStatusRequest, $0.PlayerSlot>(
        'StreamSlotStatus',
        streamSlotStatus_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SlotStatusRequest.fromBuffer(value),
        ($0.PlayerSlot value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PlaybackRequest, $0.PlaybackResponse>(
        'PlaybackCommand',
        playbackCommand_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlaybackRequest.fromBuffer(value),
        ($0.PlaybackResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.PaletteListRequest, $0.PaletteListResponse>(
            'ListPalettes',
            listPalettes_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.PaletteListRequest.fromBuffer(value),
            ($0.PaletteListResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PaletteID, $0.PaletteGetResponse>(
        'GetPalette',
        getPalette_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PaletteID.fromBuffer(value),
        ($0.PaletteGetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Palette, $0.PaletteResponse>(
        'UpdatePalette',
        updatePalette_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Palette.fromBuffer(value),
        ($0.PaletteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Palette, $0.PaletteResponse>(
        'CreatePalette',
        createPalette_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Palette.fromBuffer(value),
        ($0.PaletteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PaletteID, $0.PaletteDeleteResponse>(
        'DeletePalette',
        deletePalette_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PaletteID.fromBuffer(value),
        ($0.PaletteDeleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PaletteID, $0.PaletteActivateResponse>(
        'ActivatePalette',
        activatePalette_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PaletteID.fromBuffer(value),
        ($0.PaletteActivateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListAudioFileRequest, $0.AudioFileList>(
        'ListAudioFiles',
        listAudioFiles_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListAudioFileRequest.fromBuffer(value),
        ($0.AudioFileList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AudioFileID, $0.GetAudioFileResponse>(
        'GetAudioFile',
        getAudioFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AudioFileID.fromBuffer(value),
        ($0.GetAudioFileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AudioFileUpload, $0.AudioFileResponse>(
        'CreateAudioFile',
        createAudioFile,
        true,
        false,
        ($core.List<$core.int> value) => $0.AudioFileUpload.fromBuffer(value),
        ($0.AudioFileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AudioFile, $0.AudioFileResponse>(
        'UpdateAudioFile',
        updateAudioFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AudioFile.fromBuffer(value),
        ($0.AudioFileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AudioFileID, $0.AudioFileDeleteResponse>(
        'DeleteAudioFile',
        deleteAudioFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AudioFileID.fromBuffer(value),
        ($0.AudioFileDeleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AssignAudioFileRequest, $0.PlayerSlot>(
        'AssignAudioFileToSlot',
        assignAudioFileToSlot_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AssignAudioFileRequest.fromBuffer(value),
        ($0.PlayerSlot value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnassignAudioFileRequest, $0.PlayerSlot>(
        'UnassignAudioFileFromSlot',
        unassignAudioFileFromSlot_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UnassignAudioFileRequest.fromBuffer(value),
        ($0.PlayerSlot value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PlayerSlotID, $0.PlayerSlot>(
        'ActivateSlot',
        activateSlot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlayerSlotID.fromBuffer(value),
        ($0.PlayerSlot value) => value.writeToBuffer()));
  }

  $async.Stream<$0.AudioStatus> streamPlaybackStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AudioStatusRequest> $request) async* {
    yield* streamPlaybackStatus($call, await $request);
  }

  $async.Stream<$0.AudioStatus> streamPlaybackStatus(
      $grpc.ServiceCall call, $0.AudioStatusRequest request);

  $async.Stream<$0.PlayerSlot> streamSlotStatus_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SlotStatusRequest> $request) async* {
    yield* streamSlotStatus($call, await $request);
  }

  $async.Stream<$0.PlayerSlot> streamSlotStatus(
      $grpc.ServiceCall call, $0.SlotStatusRequest request);

  $async.Future<$0.PlaybackResponse> playbackCommand_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PlaybackRequest> $request) async {
    return playbackCommand($call, await $request);
  }

  $async.Future<$0.PlaybackResponse> playbackCommand(
      $grpc.ServiceCall call, $0.PlaybackRequest request);

  $async.Future<$0.PaletteListResponse> listPalettes_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PaletteListRequest> $request) async {
    return listPalettes($call, await $request);
  }

  $async.Future<$0.PaletteListResponse> listPalettes(
      $grpc.ServiceCall call, $0.PaletteListRequest request);

  $async.Future<$0.PaletteGetResponse> getPalette_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.PaletteID> $request) async {
    return getPalette($call, await $request);
  }

  $async.Future<$0.PaletteGetResponse> getPalette(
      $grpc.ServiceCall call, $0.PaletteID request);

  $async.Future<$0.PaletteResponse> updatePalette_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Palette> $request) async {
    return updatePalette($call, await $request);
  }

  $async.Future<$0.PaletteResponse> updatePalette(
      $grpc.ServiceCall call, $0.Palette request);

  $async.Future<$0.PaletteResponse> createPalette_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Palette> $request) async {
    return createPalette($call, await $request);
  }

  $async.Future<$0.PaletteResponse> createPalette(
      $grpc.ServiceCall call, $0.Palette request);

  $async.Future<$0.PaletteDeleteResponse> deletePalette_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.PaletteID> $request) async {
    return deletePalette($call, await $request);
  }

  $async.Future<$0.PaletteDeleteResponse> deletePalette(
      $grpc.ServiceCall call, $0.PaletteID request);

  $async.Future<$0.PaletteActivateResponse> activatePalette_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.PaletteID> $request) async {
    return activatePalette($call, await $request);
  }

  $async.Future<$0.PaletteActivateResponse> activatePalette(
      $grpc.ServiceCall call, $0.PaletteID request);

  $async.Future<$0.AudioFileList> listAudioFiles_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListAudioFileRequest> $request) async {
    return listAudioFiles($call, await $request);
  }

  $async.Future<$0.AudioFileList> listAudioFiles(
      $grpc.ServiceCall call, $0.ListAudioFileRequest request);

  $async.Future<$0.GetAudioFileResponse> getAudioFile_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AudioFileID> $request) async {
    return getAudioFile($call, await $request);
  }

  $async.Future<$0.GetAudioFileResponse> getAudioFile(
      $grpc.ServiceCall call, $0.AudioFileID request);

  $async.Future<$0.AudioFileResponse> createAudioFile(
      $grpc.ServiceCall call, $async.Stream<$0.AudioFileUpload> request);

  $async.Future<$0.AudioFileResponse> updateAudioFile_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AudioFile> $request) async {
    return updateAudioFile($call, await $request);
  }

  $async.Future<$0.AudioFileResponse> updateAudioFile(
      $grpc.ServiceCall call, $0.AudioFile request);

  $async.Future<$0.AudioFileDeleteResponse> deleteAudioFile_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AudioFileID> $request) async {
    return deleteAudioFile($call, await $request);
  }

  $async.Future<$0.AudioFileDeleteResponse> deleteAudioFile(
      $grpc.ServiceCall call, $0.AudioFileID request);

  $async.Future<$0.PlayerSlot> assignAudioFileToSlot_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AssignAudioFileRequest> $request) async {
    return assignAudioFileToSlot($call, await $request);
  }

  $async.Future<$0.PlayerSlot> assignAudioFileToSlot(
      $grpc.ServiceCall call, $0.AssignAudioFileRequest request);

  $async.Future<$0.PlayerSlot> unassignAudioFileFromSlot_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UnassignAudioFileRequest> $request) async {
    return unassignAudioFileFromSlot($call, await $request);
  }

  $async.Future<$0.PlayerSlot> unassignAudioFileFromSlot(
      $grpc.ServiceCall call, $0.UnassignAudioFileRequest request);

  $async.Future<$0.PlayerSlot> activateSlot_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.PlayerSlotID> $request) async {
    return activateSlot($call, await $request);
  }

  $async.Future<$0.PlayerSlot> activateSlot(
      $grpc.ServiceCall call, $0.PlayerSlotID request);
}
