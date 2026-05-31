import "dart:io";
import "package:flutter/foundation.dart";
import "package:jingle_player/config.dart";
import "package:logger/logger.dart";
import "package:path/path.dart" as path;

class LoggingService extends Logger {
  final ApplicationConfig config;
  final String logLevel;
  final String logPath;
  LoggingService.internal({
    required this.config,
    required this.logPath,
    required this.logLevel,
  }) {
    if (kReleaseMode) {
      Logger(
        filter: ProductionFilter(),
        printer: PrettyPrinter(
          methodCount: 0,
          dateTimeFormat: DateTimeFormat.dateAndTime,
          noBoxingByDefault: true,
          printEmojis: false,
        ),
        output: MultiOutput([
          FileOutput(
            file: File(path.join(logPath, 'player.log')),
            overrideExisting: true,
          ),
          ConsoleOutput(),
        ]),
      );
    } else {
      Logger(
        filter: DevelopmentFilter(),
        printer: PrettyPrinter(
          methodCount: 0,
          dateTimeFormat: DateTimeFormat.dateAndTime,
          noBoxingByDefault: true,
          printEmojis: false,
        ),
        output: ConsoleOutput(),
      );
    }
    Logger.level = Level.values.byName(logLevel);
  }

  static LoggingService? _instance;

  factory LoggingService() {
    if (_instance == null) {
      throw StateError(
        'LoggingService must be initialized by calling await AppConfig.init() before use.',
      );
    }
    return _instance!;
  }

  static LoggingService initialize(ApplicationConfig config) {
    if (_instance != null) return _instance!;

    _instance = LoggingService.internal(
      config: config,
      logPath: config.logPath!,
      logLevel: config.logLevel!,
    );
    return _instance!;
  }
}
