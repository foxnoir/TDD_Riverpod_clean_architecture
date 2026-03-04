import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// Riverpod provider: singleton AppLogger instance (one per app).
final appLoggerProvider = Provider<AppLogger>((ref) => AppLogger());

class AppLogger {
  AppLogger()
    : _logger = Logger(
        printer: PrettyPrinter(
          lineLength: 80,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
      );
  final Logger _logger;

  /// Debug-level logs
  void debug(String message) {
    _logger.d(message);
  }

  /// Info-level logs
  void info(String message) {
    _logger.i(message);
  }

  /// Warn-level logs
  void warning(String message) {
    _logger.w(message);
  }

  /// Error-level logs
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Fatal-level logs
  void fatal(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
