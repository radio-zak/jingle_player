import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wav/wav.dart';

class AudioHandler extends ChangeNotifier {
  Source? sourceFile;
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
  Map<int, Source?> sourceMap = <int, Source?>{};
  Map<int, String> titleMap = {};
  Map<int, String> durationMap = {};

  void initialize(int playerCount, int paletteCount) {
    List.generate(playerCount, (index) {
      sourceMap.addAll({index: null});
      titleMap.addAll({index: 'No file selected'});
      return index;
    });
    palettes = paletteCount;
  }

  Future<void> setButtonSource(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['wav'],
      type: FileType.custom,
    );
    if (result != null) {
      sourceMap[index] = DeviceFileSource(
        result.paths.first!,
        mimeType: 'audio/wav',
      );
      titleMap[index] = result.names.first!.split('.').first;
      final wav = await Wav.readFile(result.paths.first!);
      durationMap[index] = Duration(seconds: wav.duration.toInt()).toString();
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
      debugPrint('got duration: $duration');
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
        notifyListeners();
      }
    });
  }

  String parseFileName(fileName) {
    String removePaths = fileName?.path.split('/').last;
    String removeExtension = removePaths.split('.').first;
    return removeExtension;
  }

  String parseDuration(duration) {
    String durationString = duration?.toString().split('.').first ?? '';
    return durationString;
  }

  Future<void> loadToPlayer(Source source) async {
    await audioPlayer.setSource(source);
    sourceFile = source;
    sourceFileParsed = parseFileName(sourceFile);
    playerDuration = await audioPlayer.getDuration() ?? Duration.zero;
    playerDurationString = parseDuration(playerDuration);
    initStreams();
    notifyListeners();
    debugPrint('source set!');
  }

  Future<void> play() async {
    debugPrint('play invoked');
    if (sourceFile == null) {
      debugPrint('empty source!');
    } else {
      await audioPlayer.resume();
    }
  }

  Future<void> pause() async {
    debugPrint('pause invoked');
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    debugPrint('stop invoked');
    await audioPlayer.release();
    sourceFile = null;
    sourceFileParsed = null;
    fileDuration = null;
    playerDurationString = parseDuration(fileDuration);
    playerPositionString = parseDuration(null);
    notifyListeners();
  }

  Future<void> savePalette(int id) async {
    final SharedPreferences palette = await SharedPreferences.getInstance();

    List<String> sourceList = [];
    List<String> titleList = titleMap.values.toList();

    List<Source?> prepareMap = sourceMap.values.toList();
    for (final s in prepareMap) {
      if (s is DeviceFileSource) {
        sourceList.add(s.path);
      } else if (s == null) {
        sourceList.add("");
      }
    }
    String encodedSourceMap = jsonEncode(sourceList);
    String encodedTitleMap = jsonEncode(titleList);
    await palette.setString('palette-$id-sources', encodedSourceMap);
    await palette.setString('palette-$id-titles', encodedTitleMap);
  }

  Future<void> getPalette(int id) async {
    await stop();
    final SharedPreferences palette = await SharedPreferences.getInstance();

    activePalette = id;
    final encodedSourceMap = await palette.getString('palette-$id-sources');
    final encodedTitleMap = await palette.getString('palette-$id-titles');
    if (encodedSourceMap == null) {
      sourceMap.updateAll((key, value) => value = null);
      titleMap.updateAll((key, value) => value = 'No file selected');
      durationMap.updateAll((key, value) => value = '');
      notifyListeners();
      return;
    }
    if (encodedTitleMap == null) {
      return;
    }
    List<dynamic> decodedMap = json.decode(encodedSourceMap);
    List<dynamic> decodedTitles = json.decode(encodedTitleMap);
    for (var i = 0; i < decodedMap.length; i++) {
      if (decodedMap[i] == '') {
        sourceMap.addAll({i: null});
        durationMap.addAll({i: ''});
      } else {
        sourceMap.addAll({i: DeviceFileSource(decodedMap[i])});
        final wav = await Wav.readFile(decodedMap[i]);
        durationMap.addAll({
          i: Duration(seconds: wav.duration.toInt()).toString(),
        });
      }
    }
    for (var i = 0; i < decodedTitles.length; i++) {
      titleMap.addAll({i: decodedTitles[i]});
    }
    notifyListeners();
  }
}
