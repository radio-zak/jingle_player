import "dart:io";
import "package:flutter/foundation.dart";
import "package:jingle_player/config.dart";
import "package:jingle_player/file_ops.dart";
import "package:logger/logger.dart";
import "package:path/path.dart" as path;

class LoggingService {
  Logger print;
  LoggingService.internal({required this.print});

  static LoggingService? _instance;

  factory LoggingService() {
    if (_instance == null) {
      throw StateError(
        'LoggingService must be initialized by calling await AppConfig.init() before use.',
      );
    }
    return _instance!;
  }

  static Future<LoggingService> initialize(
    ApplicationConfig config,
    FileOperationService fileOps,
  ) async {
    if (_instance != null) return _instance!;

    await fileOps.createDir(config.logPath!);

    Logger defaultLogSettings = Logger(
      filter: DevelopmentFilter(),
      level: Level.values.byName(config.logLevel!),
      printer: PrettyPrinter(
        methodCount: 0,
        dateTimeFormat: DateTimeFormat.dateAndTime,
        noBoxingByDefault: true,
        printEmojis: false,
      ),
      output: ConsoleOutput(),
    );

    Logger productionLogSettings = Logger(
      filter: ProductionFilter(),
      level: Level.values.byName(config.logLevel!),
      printer: PrettyPrinter(
        methodCount: 0,
        dateTimeFormat: DateTimeFormat.dateAndTime,
        noBoxingByDefault: true,
        printEmojis: false,
      ),
      output: MultiOutput([
        FileOutput(
          file: File(path.join(config.logPath!, 'player.log')),
          overrideExisting: true,
        ),
        ConsoleOutput(),
      ]),
    );

    _instance = LoggingService.internal(
      print: kReleaseMode ? productionLogSettings : defaultLogSettings,
    );
    return _instance!;
  }
}
