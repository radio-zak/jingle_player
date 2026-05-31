import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:isolate';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:jingle_player/logger.dart';
import 'package:jingle_player/config.dart';
import 'package:jingle_player/file_ops.dart';

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
  int activePalette = 0;
  bool paletteLoading = false;
  SharedPreferencesWithCache localStorage;

  bool toolbarActive = false;

  LoggingService logger;
  ApplicationConfig config;
  FileOperationService fileOps;

  Map<int, DeviceFileSource?> sourceMap = <int, DeviceFileSource?>{};
  Map<int, String> titleMap = {};
  Map<int, String> durationMap = {};
  Map<int, bool> playerLoading = {};

  AudioHandler.internal({
    required this.logger,
    required this.config,
    required this.fileOps,
    required this.localStorage,
    required this.sourceMap,
    required this.titleMap,
    required this.playerLoading,
  }) {
    getPalette(0);
  }

  static AudioHandler? _instance;

  factory AudioHandler() {
    if (_instance == null) {
      throw StateError(
        'AppConfig must be initialized by calling await AppConfig.init() before use.',
      );
    }
    return _instance!;
  }

  static Future<AudioHandler> init(logger, fileOps, config) async {
    if (_instance != null) return _instance!;

    Map<int, DeviceFileSource?> sourceMap = <int, DeviceFileSource?>{};
    Map<int, String> titleMap = {};
    Map<int, bool> playerLoading = {};
    SharedPreferencesWithCache localStorage;
    localStorage = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    List.generate(config.players, (index) {
      sourceMap.addAll({index: null});
      titleMap.addAll({index: 'No file selected'});
      playerLoading.addAll({index: false});
      return index;
    });
    logger.i(
      "Initialized audio player with params: playerCount: ${config.players}, paletteCount: ${config.palettes}, mediaDir: ${config.mediaDir}",
    );
    _instance = AudioHandler.internal(
      logger: logger,
      fileOps: fileOps,
      config: config,
      localStorage: localStorage,
      sourceMap: sourceMap,
      titleMap: titleMap,
      playerLoading: playerLoading,
    );
    return _instance!;
  }

  void toggleToolbar() {
    toolbarActive = !toolbarActive;
    notifyListeners();
  }

  Future<void> setButtonSource(int index) async {
    final result = await fileOps.pickFileFromDisk();
    if (result != null) {
      final fileLocation = path.join(
        path.canonicalize(path.absolute(config.mediaDir!)),
        path.split(result.paths.first!).last,
      );
      final pickedFile = await File(result.paths.first!).resolveSymbolicLinks();
      final existingFile = await fileOps.checkFileExists(fileLocation);
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
          await fileOps.copyFile(pickedFile, fileLocation);
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
      final duration = await fileOps.calculateDurationFromWav(fileLocation);
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
          final duration = await fileOps.calculateDurationFromWav(
            decodedMap[i],
          );
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
