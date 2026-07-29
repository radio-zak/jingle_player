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

  Future<PlaybackResponse> playbackCommand(PlaybackRequest request) async {
    try {
      return await client.playbackCommand(request);
    } catch (e) {
      print("Error setting PLAY status: $e");
      rethrow;
    }
  }

  ResponseStream<AudioStatus> getAudioStatus() {
    try {
      return client.streamPlaybackStatus(AudioStatusRequest());
    } catch (e) {
      print("Failed to get playback status: $e");
      rethrow;
    }
  }

  Future<PaletteListResponse> listPalettes() async {
    try {
      return await client.listPalettes(PaletteListRequest());
    } catch (e) {
      print("Failed to get palettes: $e");
      rethrow;
    }
  }

  Future<PaletteGetResponse> getPalette(PaletteID request) async {
    try {
      return await client.getPalette(request);
    } catch (e) {
      print("Failed to retrieve palette: $e");
      rethrow;
    }
  }

  Future<PaletteResponse> createPalette(Palette request) async {
    try {
      return await client.createPalette(request);
    } catch (e) {
      print("Failed to create palette $e");
      rethrow;
    }
  }

  Future<PaletteResponse> updatePalette(Palette request) async {
    try {
      return await client.updatePalette(request);
    } catch (e) {
      print("Failed to update palette $e");
      rethrow;
    }
  }

  Future<PaletteDeleteResponse> deletePalette(PaletteID request) async {
    try {
      return await client.deletePalette(request);
    } catch (e) {
      print("Failed to delete palette $e");
      rethrow;
    }
  }

  Future<PaletteActivateResponse> activatePalette(PaletteID request) async {
    try {
      return await client.activatePalette(request);
    } catch (e) {
      print("Failed to activate palette: $e");
      rethrow;
    }
  }

  Future<AudioFileList> listAudioFiles() async {
    try {
      return await client.listAudioFiles(ListAudioFileRequest());
    } catch (e) {
      print("Failed listing audio files: $e");
      rethrow;
    }
  }

  Future<GetAudioFileResponse> getAudioFile(AudioFileID request) async {
    try {
      return await client.getAudioFile(request);
    } catch (e) {
      print("Failed to get audio file: $e");
      rethrow;
    }
  }

  Future<AudioFileResponse> createAudioFile(AudioFile request) async {
    try {
      return await client.createAudioFile(request);
    } catch (e) {
      print("Failed to create audio file: $e");
      rethrow;
    }
  }

  Future<AudioFileResponse> updateAudioFile(AudioFile request) async {
    try {
      return await client.updateAudioFile(request);
    } catch (e) {
      print("Failed updating audio file");
      rethrow;
    }
  }

  Future<AudioFileDeleteResponse> deleteAudioFile(AudioFileID request) async {
    try {
      return await client.deleteAudioFile(request);
    } catch (e) {
      print("Failed to delete audio file: $e");
      rethrow;
    }
  }

  Future<PlayerSlot> assignAudioFileToSlot(
    AssignAudioFileRequest request,
  ) async {
    try {
      return await client.assignAudioFileToSlot(request);
    } catch (e) {
      print("Failed to assign audio to slot: $e");
      rethrow;
    }
  }

  Future<PlayerSlot> unassignAudioFileFromSlot(
    UnassignAudioFileRequest request,
  ) async {
    try {
      return await client.unassignAudioFileFromSlot(request);
    } catch (e) {
      print("Failed unassigning file from slot: $e");
      rethrow;
  }

  Future<PlayerSlot> activateSlot(PlayerSlotID request) async {
    try {
      return await client.activateSlot(request);
    }
    catch (e) {
      print("Failed activating slot: $e");
      rethrow;
    }
  }
}
