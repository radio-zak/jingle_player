import "package:shared_preferences/shared_preferences.dart";
import "dart:async";
import "dart:convert";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as path;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'file_ops.dart';

class ApplicationConfig extends ChangeNotifier {
  String configFilePath = "./config.json";
  int palettes;
  String? mediaDir;
  String? logLevel;
  String? logPath;
  int players;
  String appTitle;
  late FileOperationService fileOps;
  late SharedPreferencesWithCache localStorage;
  Map<int, LogicalKeyboardKey> keyMap;
  Map<int, LogicalKeyboardKey> paletteKeyMap;

  ApplicationConfig.internal({
    required this.fileOps,
    required this.palettes,
    required this.players,
    this.mediaDir,
    this.logLevel,
    this.logPath,
    required this.keyMap,
    required this.paletteKeyMap,
    required this.appTitle,
  });

  static ApplicationConfig? _instance;

  @visibleForTesting
  static void reset() => _instance = null;

  factory ApplicationConfig() {
    if (_instance == null) {
      throw StateError(
        'AppConfig must be initialized by calling await AppConfig.init() before use.',
      );
    }
    return _instance!;
  }

  static Future<ApplicationConfig> init(FileOperationService fileOps) async {
    if (_instance != null) return _instance!;
    final appDocsDir = await getApplicationSupportDirectory();

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

    final String defaultAppTitle = "Jingle Player ";
    final int defaultPaletteCount = 8;
    final int defaultPlayerCount = 16;
    final String defaultMediaDir = path.normalize(
      path.join(appDocsDir.path, "./media"),
    );
    final String defaultLogLevel = "info";
    final String defaultLogPath = path.normalize(
      path.join(appDocsDir.path, "./log"),
    );

    var configExists = await fileOps.checkFileExists("./config.json");
    if (!configExists) {
      _instance = ApplicationConfig.internal(
        fileOps: fileOps,
        players: defaultPlayerCount,
        palettes: defaultPaletteCount,
        appTitle: defaultAppTitle,
        mediaDir: defaultMediaDir,
        logPath: defaultLogPath,
        logLevel: defaultLogLevel,
        keyMap: keyMap,
        paletteKeyMap: paletteKeyMap,
      );
      return _instance!;
    }
    var appConfig = await fileOps.readAsString("./config.json");
    Map<String, dynamic> configMap = await jsonDecode(appConfig);
    _instance = ApplicationConfig.internal(
      fileOps: fileOps,
      players: configMap.containsKey('playerCount')
          ? configMap['playerCount']
          : defaultPlayerCount,
      palettes: configMap.containsKey('paletteCount')
          ? configMap['paletteCount']
          : defaultPaletteCount,
      appTitle: configMap.containsKey('appTitle')
          ? configMap['appTitle']
          : defaultAppTitle,
      mediaDir: configMap.containsKey('mediaDir')
          ? configMap['mediaDir']
          : defaultMediaDir,
      logPath: configMap.containsKey('logPath')
          ? configMap['logPath']
          : defaultLogPath,
      logLevel: configMap.containsKey('logLevel')
          ? configMap['logLevel']
          : defaultLogLevel,
      keyMap: keyMap,
      paletteKeyMap: paletteKeyMap,
    );
    return _instance!;
  }

  Future<void> initializeMediaDirectory() async {
    bool mediaDirExists = await fileOps.checkDirExists(mediaDir!);
    if (!mediaDirExists) {
      try {
        await fileOps.createDir(mediaDir!);
      } catch (e) {
        throw Exception(e);
      }
    }
  }
}
