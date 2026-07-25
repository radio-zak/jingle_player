import 'package:grpc/grpc.dart';
import 'control/control.pbgrpc.dart';

class GrpcClient {
  late ClientChannel channel;
  late AudioServiceClient client;

  final String host = 'localhost';
  final int port = 6969;

  GrpcClient() {
    channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    client = AudioServiceClient(channel);
  }

  Future<ActionResponse> triggerCommand(CommandRequest request) async {
    try {
      return await client.triggerCommand(request);
    } catch (e) {
      print("Error setting PLAY status: $e");
      rethrow;
    }
  }

  ResponseStream<AudioStatus> getAudioStatus() {
    try {
      return client.streamPlaybackStatus(StatusRequest());
    } catch (e) {
      print("Failed to get playback status: $e");
      rethrow;
    }
  }
}
