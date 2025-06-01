import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();
  static final Logger _instance = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
    // filter: ProductionFilter(),
  );

  static Logger get instance => _instance;
}
