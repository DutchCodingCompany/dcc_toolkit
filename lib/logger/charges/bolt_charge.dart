import 'package:dcc_toolkit/logger/bolt_logger.dart';
import 'package:dcc_toolkit/logger/zap_event.dart';

/// Interface for creating [BoltCharge]s to power the [BoltLogger]
abstract interface class BoltCharge {

  /// The name of the charge.
  abstract final String name;
  /// Log the output of the [ZapEvent].
  void logOutput(ZapEvent event);

  /// Discharge the charge.
  void discharge();
}
