import "package:logger/logger.dart";

Logger logger = Logger(printer: PrettyPrinter());

void setLogLevel(String logLevel) {
  Logger.level = Level.values.byName(logLevel);
}
