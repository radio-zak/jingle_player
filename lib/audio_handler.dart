import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:isolate';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:wav/wav.dart';
import 'package:jingle_player/logger.dart';

class AudioHandler extends ChangeNotifier {
  DeviceFileSource? sourceFile;
  String? sourceFileParsed;
  Duration? fileDuration = Duration.zero;
  String? fileDurationString = Duration.zero.toString();

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  Duration playerDuration = Duration.zero;
  String playerDurationString = '';
  Duration playerPosition = Duration.zero;
  String playerPositionString = '';

  Duration timeRemaining = Duration.zero;
  String timeRemainingString = '';

  AudioCache audioCache = AudioCache.instance = AudioCache();
  bool editMode = false;
  int palettes = 4;
  int activePalette = 0;
  bool paletteLoading = false;
  String filesPath = "";
  late SharedPreferencesWithCache localStorage;

  bool toolbarActive = false;

  final keyMap = {
    0: LogicalKeyboardKey.digit1,
    1: LogicalKeyboardKey.digit2,
    2: LogicalKeyboardKey.digit3,
    3: LogicalKeyboardKey.digit4,
    4: LogicalKeyboardKey.digit5,
    5: LogicalKeyboardKey.digit6,
    6: LogicalKeyboardKey.digit7,
    7: LogicalKeyboardKey.digit8,
    8: LogicalKeyboardKey.digit9,
    9: LogicalKeyboardKey.digit0,
    10: LogicalKeyboardKey.minus,
    11: LogicalKeyboardKey.equal,
    12: LogicalKeyboardKey.keyQ,
    13: LogicalKeyboardKey.keyW,
    14: LogicalKeyboardKey.keyE,
    15: LogicalKeyboardKey.keyR,
  };
  final paletteKeyMap = {
    0: LogicalKeyboardKey.digit1,
    1: LogicalKeyboardKey.digit2,
    2: LogicalKeyboardKey.digit3,
    3: LogicalKeyboardKey.digit4,
    4: LogicalKeyboardKey.digit5,
    5: LogicalKeyboardKey.digit6,
    6: LogicalKeyboardKey.digit7,
    7: LogicalKeyboardKey.digit8,
  };
  Map<int, DeviceFileSource?> sourceMap = <int, DeviceFileSource?>{};
  Map<int, String> titleMap = {};
  Map<int, String> durationMap = {};
  Map<int, bool> playerLoading = {};

  void toggleToolbar() {
    toolbarActive = !toolbarActive;
    notifyListeners();
  }

  Future<void> initialize(
    int playerCount,
    int paletteCount,
    String mediaDir,
  ) async {
    localStorage = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    List.generate(playerCount, (index) {
      sourceMap.addAll({index: null});
      titleMap.addAll({index: 'No file selected'});
      playerLoading.addAll({index: false});
      return index;
    });
    palettes = paletteCount;
    filesPath = mediaDir;
    logger.i(
      "Initialized audio player with params: playerCount: $playerCount, paletteCount: $paletteCount, mediaDir: $mediaDir",
    );
  }

  Future<void> setButtonSource(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['wav'],
      type: FileType.custom,
    );
    if (result != null) {
      final fileLocation = path.join(
        path.canonicalize(path.absolute(filesPath)),
        path.split(result.paths.first!).last,
      );
      final pickedFile = await File(result.paths.first!).resolveSymbolicLinks();
      var existingFile = await File(fileLocation).exists();
      if (!existingFile) {
        logger.i("Selected file does not exist in media directory, copying...");
        toastification.show(
          title: Text("Copying file to media directory"),
          alignment: Alignment.topLeft,
          type: ToastificationType.info,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          style: ToastificationStyle.minimal,
          autoCloseDuration: Duration(seconds: 5),
        );
        playerLoading[index] = true;
        notifyListeners();
        try {
          await Isolate.run(() async {
            await File(pickedFile).copy(fileLocation);
          });
        } catch (e) {
          logger.e('$e');
          toastification.show(
            title: Text("An error occured"),
            description: Text("$e"),
            type: ToastificationType.error,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            style: ToastificationStyle.minimal,
            alignment: Alignment.topLeft,
          );
          playerLoading[index] = false;
          notifyListeners();
          return;
        }
        playerLoading[index] = false;
        notifyListeners();
      } else {
        logger.i("Selected existing file from media directory");
        toastification.show(
          title: Text("Selected existing file from media directory"),
          alignment: Alignment.topLeft,
          type: ToastificationType.info,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          style: ToastificationStyle.minimal,
          autoCloseDuration: Duration(seconds: 5),
        );
      }
      sourceMap[index] = DeviceFileSource(fileLocation, mimeType: 'audio/wav');
      titleMap[index] = result.names.first!.split('.').first;
      final duration = await Isolate.run(() async {
        final wav = await Wav.readFile(fileLocation);
        return wav.duration.toInt();
      });
      durationMap[index] = Duration(seconds: duration).toString();
      playerLoading[index] = false;
    }
    notifyListeners();
  }

  void clearButtonSource(int index) {
    sourceMap[index] = null;
    titleMap[index] = 'No file selected';
    durationMap[index] = '';
    notifyListeners();
  }

  final audioPlayer = AudioPlayer(playerId: 'jingle')
    ..setReleaseMode(ReleaseMode.release);

  void switchMode(int id) {
    if (editMode) {
      savePalette(id);
    }
    editMode = !editMode;
    notifyListeners();
  }

  void initStreams() {
    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      logger.d('got duration: $duration');
      playerDuration = duration;
      playerDurationString = parseDuration(duration);
      notifyListeners();
    });

    _positionSubscription = audioPlayer.onPositionChanged.listen(
      (p) => {
        playerPosition = p,
        playerPositionString = parseDuration(playerPosition),
        timeRemaining = playerDuration - p,
        timeRemainingString = parseDuration(timeRemaining),
        notifyListeners(),
      },
    );

    _playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      playerPosition = Duration.zero;
      playerPositionString = parseDuration(playerPosition);
      notifyListeners();
    });

    _playerStateChangeSubscription = audioPlayer.onPlayerStateChanged.listen((
      state,
    ) {
      if (state == PlayerState.stopped) {
        playerPosition = Duration.zero;
        playerPositionString = parseDuration(playerPosition);
        notifyListeners();
      }
      if (state == PlayerState.completed) {
        stop();
        playerPosition = Duration.zero;
        playerPositionString = parseDuration(playerPosition);
      }
    });
  }

  String parseFileName(String fileName) {
    String removePaths = path.split(fileName).last;
    String removeExtension = path.withoutExtension(removePaths);
    return removeExtension;
  }

  String parseDuration(duration) {
    String durationString = duration?.toString().split('.').first ?? '';
    return durationString;
  }

  Future<void> loadToPlayer(DeviceFileSource source) async {
    await audioPlayer.setSource(source);
    sourceFile = source;
    if (sourceFile is DeviceFileSource) {
      sourceFileParsed = parseFileName(source.path);
    }
    playerDuration = await audioPlayer.getDuration() ?? Duration.zero;
    playerDurationString = parseDuration(playerDuration);
    initStreams();
    notifyListeners();
    logger.d('source set!');
  }

  Future<void> play() async {
    logger.d('play invoked');
    if (sourceFile == null) {
      logger.d('empty source!');
    } else {
      await audioPlayer.resume();
    }
  }

  Future<void> pause() async {
    logger.d('pause invoked');
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    logger.d('stop invoked');
    await audioPlayer.release();
    sourceFile = null;
    sourceFileParsed = null;
    fileDuration = null;
    playerDurationString = parseDuration(fileDuration);
    playerPositionString = parseDuration(null);
    notifyListeners();
  }

  Future<void> savePalette(int id) async {
    List<String> sourceList = [];
    List<String> titleList = titleMap.values.toList();

    List<DeviceFileSource?> prepareMap = sourceMap.values.toList();
    for (final s in prepareMap) {
      if (s is DeviceFileSource) {
        sourceList.add(s.path);
      } else if (s == null) {
        sourceList.add("");
      }
    }
    String encodedSourceMap = jsonEncode(sourceList);
    String encodedTitleMap = jsonEncode(titleList);
    await localStorage.setString('palette-$id-sources', encodedSourceMap);
    await localStorage.setString('palette-$id-titles', encodedTitleMap);
    final displayPaletteId = id + 1;
    toastification.show(
      title: Text("Palette $displayPaletteId saved!"),
      autoCloseDuration: Duration(seconds: 5),
      alignment: Alignment.topLeft,
      primaryColor: Colors.teal,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      style: ToastificationStyle.minimal,
    );
  }

  Future<void> loadPaletteFromStorage(int id) async {
    Isolate.run(() async {
      await getPalette(id);
    });
  }

  Future<void> getPalette(int id) async {
    paletteLoading = true;
    notifyListeners();
    await stop();

    activePalette = id;
    final encodedSourceMap = await localStorage.getString(
      'palette-$id-sources',
    );
    final encodedTitleMap = await localStorage.getString('palette-$id-titles');
    if (encodedSourceMap == null) {
      sourceMap.updateAll((key, value) => value = null);
      titleMap.updateAll((key, value) => value = 'No file selected');
      durationMap.updateAll((key, value) => value = '');
      paletteLoading = false;
      notifyListeners();
      return;
    }
    if (encodedTitleMap == null) {
      return;
    }
    final List<dynamic> decodedMap = await Isolate.run<List<dynamic>>(() {
      final map = json.decode(encodedSourceMap);
      return map;
    });
    final List<dynamic> decodedTitles = await Isolate.run<List<dynamic>>(() {
      final map = json.decode(encodedTitleMap);
      return map;
    });
    for (var i = 0; i < decodedMap.length; i++) {
      if (decodedMap[i] == '') {
        sourceMap.addAll({i: null});
        durationMap.addAll({i: ''});
      } else {
        final existFileCheck = await File(decodedMap[i]).exists();
        if (!existFileCheck) {
          toastification.show(
            type: ToastificationType.error,
            title: Text(
              "File in the saved palette does not exist in the media directory",
            ),
            description: Text(decodedMap[i]),
            alignment: Alignment.topLeft,
          );
          sourceMap.addAll({i: null});
          durationMap.addAll({i: ''});
        } else {
          sourceMap.addAll({i: DeviceFileSource(decodedMap[i])});
          final duration = await Isolate.run(() async {
            final wav = await Wav.readFile(decodedMap[i]);
            return wav.duration.toInt();
          });
          durationMap.addAll({i: Duration(seconds: duration).toString()});
        }
      }
    }
    for (var i = 0; i < decodedTitles.length; i++) {
      final existFileCheck = await File(decodedMap[i]).exists();
      if (!existFileCheck) {
        titleMap.addAll({i: 'No file selected'});
      } else {
        titleMap.addAll({i: decodedTitles[i]});
      }
    }
    paletteLoading = false;
    notifyListeners();
  }
}
