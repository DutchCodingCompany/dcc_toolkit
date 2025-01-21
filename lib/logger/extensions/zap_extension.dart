import 'package:dcc_toolkit/logger/bolt_logger.dart';
import 'package:logging/logging.dart';

/// Extension to zap messages.
extension ZapExtension on Object {
  /// {@macro zap}
  void zap(
    Object? message, {
    String? tag,
    Level level = Level.INFO,
  }) {
    // We actually want to know to runtimeType of the object
    // ignore: no_runtimeType_toString
    BoltLogger.zap(message, tag: tag ?? runtimeType.toString(), level: level);
  }

  /// {@macro shock}
  void shock(
    Object? message, {
    String? tag,
    Level level = Level.SEVERE,
  }) {
    // We actually want to know to runtimeType of the object
    //ignore: no_runtimeType_toString
    BoltLogger.shock(message, tag: tag ?? runtimeType.toString(), level: level);
  }
}
