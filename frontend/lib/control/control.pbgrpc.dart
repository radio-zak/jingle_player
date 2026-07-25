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
    $0.StatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$streamPlaybackStatus, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.ActionResponse> triggerCommand(
    $0.CommandRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$triggerCommand, request, options: options);
  }

  // method descriptors

  static final _$streamPlaybackStatus =
      $grpc.ClientMethod<$0.StatusRequest, $0.AudioStatus>(
          '/pb.AudioService/StreamPlaybackStatus',
          ($0.StatusRequest value) => value.writeToBuffer(),
          $0.AudioStatus.fromBuffer);
  static final _$triggerCommand =
      $grpc.ClientMethod<$0.CommandRequest, $0.ActionResponse>(
          '/pb.AudioService/TriggerCommand',
          ($0.CommandRequest value) => value.writeToBuffer(),
          $0.ActionResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.AudioService')
abstract class AudioServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.AudioService';

  AudioServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StatusRequest, $0.AudioStatus>(
        'StreamPlaybackStatus',
        streamPlaybackStatus_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StatusRequest.fromBuffer(value),
        ($0.AudioStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CommandRequest, $0.ActionResponse>(
        'TriggerCommand',
        triggerCommand_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CommandRequest.fromBuffer(value),
        ($0.ActionResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.AudioStatus> streamPlaybackStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.StatusRequest> $request) async* {
    yield* streamPlaybackStatus($call, await $request);
  }

  $async.Stream<$0.AudioStatus> streamPlaybackStatus(
      $grpc.ServiceCall call, $0.StatusRequest request);

  $async.Future<$0.ActionResponse> triggerCommand_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CommandRequest> $request) async {
    return triggerCommand($call, await $request);
  }

  $async.Future<$0.ActionResponse> triggerCommand(
      $grpc.ServiceCall call, $0.CommandRequest request);
}
