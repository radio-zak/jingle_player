import "dart:io";
import "dart:async";
import "dart:isolate";
import 'package:wav/wav.dart';
import 'package:file_picker/file_picker.dart';

class FileOperationService {
  Future<bool> checkFileExists(String file) async {
    bool check = await File(file).exists();
    return check;
  }

  Future<String> readAsString(String file) async {
    String result = await File(file).readAsString();
    return result;
  }

  Future<bool> checkDirExists(String dir) async {
    bool check = await Directory(dir).exists();
    return check;
  }

  Future createDir(String dir) async {
    bool exists = await checkDirExists(dir);
    if (!exists) {
      await Directory(dir).create(recursive: true);
    } else {
      return;
    }
  }

  Future<void> copyFile(String source, String dest) async {
    await Isolate.run(() async {
      try {
        await File(source).copy(dest);
      } catch (e) {
        throw Exception(e);
      }
    });
  }

  Future<int> calculateDurationFromWav(String file) async {
    final duration = await Isolate.run(() async {
      final wav = await Wav.readFile(file);
      return wav.duration.toInt();
    });
    return duration;
  }

  Future<FilePickerResult?> pickFileFromDisk() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['wav'],
      type: FileType.custom,
    );
    return result;
  }
}
