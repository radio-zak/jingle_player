import "dart:io";
import "package:flutter/foundation.dart";
import "package:logger/logger.dart";
import "package:path/path.dart" as path;

late Logger logger;

Future<void> initializeLogger(String logDir, String logLevel) async {
  Directory logDirectory = await Directory(logDir).create(recursive: true);
  if (kReleaseMode) {
    logger = Logger(
      filter: ProductionFilter(),
      printer: PrettyPrinter(
        methodCount: 0,
        dateTimeFormat: DateTimeFormat.dateAndTime,
        noBoxingByDefault: true,
        printEmojis: false,
      ),
      output: MultiOutput([
        FileOutput(
          file: File(path.join(logDirectory.path, 'player.log')),
          overrideExisting: true,
        ),
        ConsoleOutput(),
      ]),
    );
  } else {
    logger = Logger(
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
